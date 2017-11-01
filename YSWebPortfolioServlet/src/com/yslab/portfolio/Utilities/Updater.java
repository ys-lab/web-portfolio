package com.yslab.portfolio.Utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class Updater extends SQLUtilities {

	public JSONArray updateAll(Connection con, String TableName) {
		
		System.out.println("at getAllFrom :");
		
		JSONArray jsonArray = new JSONArray();
		String sql = "select * from " + DB_NAME + TableName;

        try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery(sql);
			jsonArray = sqlResult(rs);
			rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return jsonArray;
	}
	
	public JSONArray getAllByConditionFrom(Connection con, String TableName, JSONObject CONDITION) {

		System.out.println("at getAllByConditionFrom :");
		
		setCondition(CONDITION);
		String keyNvalues = getKeyNValues();
		
		JSONArray jsonArray = new JSONArray();
		String sql = "select * from " + DB_NAME + TableName + " where " + keyNvalues;
		System.out.println(sql);

        try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery(sql);
			jsonArray = sqlResult(rs);
			rs.close();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        return jsonArray;
	}
}
