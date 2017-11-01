package com.yslab.portfolio.Store;

import java.sql.Connection;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.yslab.portfolio.Utilities.Creator;
import com.yslab.portfolio.Utilities.Deleter;

public class ContentsApplier {
	
	Creator creator = new Creator();
	Deleter deleter = new Deleter();
	
	public int addAll(Connection con, JSONArray jsonArray, String tableName) {
		return creator.insertAll(con, tableName, jsonArray);
	}
	
	public int updateAll(Connection con, JSONArray jsonArray, String tableName, String sortedBy) {
		return creator.updateAll(con, tableName, jsonArray, sortedBy);
	}
	
	public int deleteAll(Connection con, JSONArray jsonArray, String tableName) {
		return deleter.deleteAll(con, tableName, jsonArray);
	}
	
	public int insertAllOnDuplicate(Connection con, JSONArray jsonArray, String tableName, JSONObject jsonObject) {
		return creator.insertAllOnDuplicate(con, tableName, jsonArray, jsonObject);
	}
}
