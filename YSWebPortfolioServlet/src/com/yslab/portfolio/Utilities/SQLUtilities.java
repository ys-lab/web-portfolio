package com.yslab.portfolio.Utilities;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Iterator;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class SQLUtilities {
	
	final public static String DB_NAME = "ys_portfolio.";
	final private static String NUM = "num";
	final private static String seperatorSYNTAX = "<SEP>";
	final private static String seperator = ", ";
	final private static String seperatorAND = " AND ";
	
	private String keys = "";
	private String values = "";
	private String target = "";
	private String wheres = "";
	private String keyNvalues = "";
	private String keyNtypes = "";
	
	public String getKeys() {
		return this.keys;
	}
	
	public String getKeyNValues() {
		return this.keyNvalues;
	}
	
	public String getKeyNTypes() {
		return this.keyNtypes;
	}
	
	public String getValues() {
		return this.values;
	}
	
	public String getTarget() {
		return this.target;
	}
	
	public String getWheres() {
		return this.wheres;
	}
	
	private String getType(String key) {
		switch(key) {
			case Type.TAB_MENU_NAME:
			case Type.TAB_MENU_TITLE:
			case Type.TAB_MENU_LINK:
				return Type.NVARCHAR_45;
			case Type.NUM:
			case Type.TAB_MENU_NUM:
				return Type.TINYINT_5;
			case Type.TAB_MENU_TYPE:
				return Type.TINYINT_2;
		}
		return "";
	}
	
	public void setTarget(JSONObject CONDITION) {
		Iterator<String> keys = CONDITION.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			this.target = key + "'" + CONDITION.get(key).toString() + "'";
		}
	}
	
	public void setCreateTemporaryCondition(JSONArray CON) {
		System.out.println("at setCondition : ");
		JSONObject CONDITION = (JSONObject) CON.get(0);
		Iterator<String> keys = CONDITION.keySet().iterator();
		this.keyNtypes = "(";
		
		while(keys.hasNext()) {
			String key = keys.next();
			String type = getType(key);
			
			this.keyNtypes += key + " " + type;
			
			if(keys.hasNext()) {
				this.keyNtypes += seperator;
			} else {
				this.keyNtypes += ")";
			}
		}
		System.out.println(this.keys + " " + this.keyNvalues);
	}
	
	public void setCondition(JSONObject CONDITION) {
		
		System.out.println("at setCondition : ");
		
		Iterator<String> keys = CONDITION.keySet().iterator();
		this.keys = "";
		this.keyNvalues = "";
		
		while(keys.hasNext()) {
			String key = keys.next();
			String value = CONDITION.get(key).toString();
			if(value != "") {
				this.keys += key;
				this.keyNvalues += key + "='" + value + "'";
			}
			if(keys.hasNext()) {
				this.keys += seperator;
				this.keyNvalues += seperator;
			}
		}
		System.out.println(this.keys + " " + this.keyNvalues);
	}
	
	public void setCreatorCondition(JSONArray CON) {
		
		System.out.println("at setCreatorCondition : ");
		
		this.keys = "(";
		this.values = "";
		
		for(int i=0; i<CON.size(); i++) {
			JSONObject CONDITION = (JSONObject) CON.get(i);
			Iterator<String> keys = CONDITION.keySet().iterator();
			
			this.values += "(";
			
			while(keys.hasNext()) {
				String key = keys.next();
				String value = CONDITION.get(key).toString();
				
				switch(i) {
					case 0:
						if(!value.isEmpty()) {
							this.keys += key;
							this.values += "'" + value + "'";
							
							if(keys.hasNext()) {
								this.keys += seperator;
								this.values += seperator;
							} else {
								this.keys += ")";
								this.values += ")";
							}
						}
						break;
					default:
						if(!value.isEmpty()) {
							this.values += "'" + value + "'";
							
							if(keys.hasNext()) {
								this.values += seperator;
							} else {
								this.values += ")";
							}
						}
						break;
				}
			}
			if(i < CON.size()-1) {
				this.values += seperator;
			}
			System.out.println(this.keys + " " + this.keyNvalues);
		}
	}
	
	public void setUpdaterCondition(JSONArray CON, String sortedBy) {
		
		System.out.println("at setUpdaterCondition : ");
		
		this.keyNvalues = "";
		this.wheres = "";
		
		for(int i=0; i<CON.size(); i++) {
			JSONObject CONDITION = (JSONObject) CON.get(i);
			Iterator<String> keys = CONDITION.keySet().iterator();
			
			while(keys.hasNext()) {
				String key = keys.next();
				String value = CONDITION.get(key).toString();
				
				this.keyNvalues += key + "='" + value + "'";
				
				if(key.equals(sortedBy)) {
					this.wheres += "'" + value + "'";
				}
				
				if(keys.hasNext()) {
					this.keyNvalues += seperator;
				}
			}
			if(i < CON.size()-1) {
				this.keyNvalues += seperatorSYNTAX;
				this.wheres += seperatorSYNTAX;
			}
			System.out.println(this.keys + " " + this.keyNvalues);
		}
	}
	
	public void setUpdaterInnerJoinCondition(JSONArray CON, String sortedBy) {
		
		System.out.println("at setUpdaterInnerJoinCondition : ");
		
		this.target = "";
		this.keyNvalues = "";
		
		JSONObject CONDITION = (JSONObject) CON.get(0);
		Iterator<String> keys = CONDITION.keySet().iterator();
		
		while(keys.hasNext()) {
			String key = keys.next();
			String value = CONDITION.get(key).toString();
			
			if(!value.isEmpty()) {
				
				if(key.equals(sortedBy)) {
					this.target += "forUpdate inner join " + Type.TEMPORARY_TABLE_NAME + " temporary on ";
					this.target += "forUpdate." + sortedBy + "=temporary." + sortedBy;
				} else {
					this.keyNvalues += "temporary." + key + "=forUpdate." + key;
				}
				
				if(keys.hasNext()) {
					this.keyNvalues += seperator;
				}
			}
		}
		System.out.println(this.keys + " " + this.keyNvalues);
	}
	
	public void setDeleterCondition(JSONArray CON) {
		
		System.out.println("at setDeleterCondition : ");
		
		this.keys = "";
		this.values = "(";
		
		for(int i=0; i<CON.size(); i++) {
			JSONObject CONDITION = (JSONObject) CON.get(i);
			Iterator<String> keys = CONDITION.keySet().iterator();
			
			while(keys.hasNext()) {
				String key = keys.next();
				String value = CONDITION.get(key).toString();
				
				switch(i) {
					case 0:
						if(!value.isEmpty()) {
							this.keys += key;
							this.values += "'" + value + "'";
						}
						break;
					default:
						if(!value.isEmpty()) {
							this.values += "'" + value + "'";
						}
						break;
				}
			}
			if(i < CON.size()-1) {
				this.values += seperator;
			}
			System.out.println(this.keys + " " + this.keyNvalues);
		}
		this.values += ")";
	}
	
	public JSONArray sqlResult(ResultSet rs) throws SQLException {
		
		int count = 0;
		
		System.out.println("at sqlResult :");
		
		JSONArray jsonArray = new JSONArray();
		
		while(rs.next()) {
			
			ResultSetMetaData rsmd = rs.getMetaData();
			JSONObject jsonObject = new JSONObject();
			
			int num = rsmd.getColumnCount();
			
			System.out.println("column : " + num);
			
			for(int i=0; i<num; i++) {
				int type = rsmd.getColumnType(i+1);
				switch(type) {
					case Types.CHAR:
					case Types.NCHAR:
					case Types.VARCHAR:
					case Types.NVARCHAR:
					case Types.LONGVARCHAR:
					case Types.LONGNVARCHAR:
						jsonObject.put(rsmd.getColumnName(i+1), rs.getString(i+1));
						System.out.println(rsmd.getColumnName(i+1) + " " + rs.getString(i+1));
						break;
					case Types.BIGINT:
					case Types.SMALLINT:
					case Types.TINYINT:
					case Types.INTEGER:
						jsonObject.put(rsmd.getColumnName(i+1), rs.getInt(i+1));
						System.out.println(rsmd.getColumnName(i+1) + " " + rs.getString(i+1));
						break;
					case Types.FLOAT:
						jsonObject.put(rsmd.getColumnName(i+1), rs.getFloat(i+1));
						System.out.println(rsmd.getColumnName(i+1) + " " + rs.getString(i+1));
						break;
				}
			}
			
			jsonArray.add(jsonObject);
		}
		
		return jsonArray;
	}
}
