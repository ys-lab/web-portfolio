package com.yslab.portfolio.Utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.json.simple.JSONArray;

public class Deleter extends SQLUtilities {
	
	public int dropTemporaryTable(Connection con) {
		
		System.out.println("at dropTemporaryTable :");
		
		String sql = "drop table " + DB_NAME + Type.TEMPORARY_TABLE_NAME;
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
	
	public int deleteAll(Connection con, String TableName, JSONArray jsonArray) {
		
		System.out.println("at deleteAll :");
		
		setDeleterCondition(jsonArray);
		String keys = getKeys();
		String values = getValues();
		
		String sql = "delete from " + DB_NAME + TableName + " where " + keys + " in " + values;
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
}
