package com.yslab.portfolio.Utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class Creator extends SQLUtilities {
	
	private final static String seperatorSYNTAX = "<SEP>";
	private final static String TEMPORARY_TABLE_NAME = "temporary_table";
	
	public int createTemporaryTable(Connection con, JSONArray jsonArray) {
		
		System.out.println("at createTemporaryTable :");
		
		setCreateTemporaryCondition(jsonArray);
		String keyNtypes = getKeyNTypes();
		
		String sql = "create temporary table " + DB_NAME + TEMPORARY_TABLE_NAME + " " + keyNtypes;
		System.out.println(sql);
		
		int rs = 0;

        try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return rs;
	}
	
	public int insertAll(Connection con, String TableName, JSONArray jsonArray) {
		
		System.out.println("at insertAll :");
		
		setCreatorCondition(jsonArray);
		String keys = getKeys();
		String values = getValues();
		
		String sql = "insert into " + DB_NAME + TableName + " " + keys + " values " + values;
		System.out.println(sql);
		
		int rs = 0;

        try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return rs;
	}
	
	public int insertAllOnDuplicate(Connection con, String TableName, JSONArray jsonArray, JSONObject jsonObject) {
		
		System.out.println("at insertAllOnDuplicate :");
		
		setCreatorCondition(jsonArray);
		setTarget(jsonObject);
		String keys = getKeys();
		String values = getValues();
		String target = getTarget();
		
		String sql = "insert into " + DB_NAME + TableName + " " + keys + " values " + values + " ON DUPLICATE KEY UPDATE " + target;
		System.out.println(sql);
		
		int rs = 0;

        try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return rs;
	}
	
	public int updateAll(Connection con, String TableName, JSONArray jsonArray, String sortedBy) {
		
		System.out.println("at updateAll :");
		
		setUpdaterCondition(jsonArray, sortedBy);
		
		String wheres = getWheres();
		String keyNvalues = getKeyNValues();
		
		String[] splitedWhere = wheres.split(seperatorSYNTAX);
		String[] splitedValue = keyNvalues.split(seperatorSYNTAX);
		
		int rs = 0;
		
        try {
        	for(int i=0; i<splitedWhere.length; i++) {
        		String sql = "update " + DB_NAME + TableName + " set " + splitedValue[i] + " where " + sortedBy + "=" + splitedWhere[i];
        		System.out.println(sql);
    			PreparedStatement pstmt = con.prepareStatement(sql);
    			rs = pstmt.executeUpdate(sql);
        	}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        return rs;
	}
	
	public int updateWithTemporaryAll(Connection con, String TableName, JSONArray jsonArray, String sortedBy) {
		
		System.out.println("at updateAll :");
		
		createTemporaryTable(con, jsonArray);
		insertAll(con, Type.TEMPORARY_TABLE_NAME, jsonArray);
		setUpdaterInnerJoinCondition(jsonArray, sortedBy);
		
		String target = getTarget();
		String keyNvalues = getKeyNValues();
		
		int rs = 0;
		
		String sql = "update " + DB_NAME + TableName + " " + target + " set " + keyNvalues + ";";
		String sqlForDrop = "drop table " + DB_NAME + Type.TEMPORARY_TABLE_NAME;
		
		System.out.println(sql);

        try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			rs = pstmt.executeUpdate(sql);
			
			pstmt = con.prepareStatement(sqlForDrop);
			rs += pstmt.executeUpdate(sqlForDrop);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        return rs;
	}
	
}
