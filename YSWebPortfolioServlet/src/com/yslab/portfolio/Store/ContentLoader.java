package com.yslab.portfolio.Store;

import java.sql.Connection;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.yslab.portfolio.Utilities.Retriever;

public class ContentLoader {
	
	public JSONArray loadTopicContent(Connection con, JSONObject target) {
		Retriever rt = new Retriever();
		System.out.println("at loadTopic :");
		
		return rt.getAllByConditionFrom(con, "tab_topic_contents", target);
	}
	
	public JSONArray loadSubTopicContent(Connection con, JSONObject target) {
		Retriever rt = new Retriever();
		System.out.println("at loadTopic :");
		
		return rt.getAllByConditionFrom(con, "tab_topic_sub_contents", target);
	}
	
	public JSONArray loadSubTopicContentTop5(Connection con, JSONObject target) {
		Retriever rt = new Retriever();
		System.out.println("at loadTopic :");
		
		return rt.getAllByConditionFrom(con, "tab_topic_sub_contents", target);
	}
	
	public JSONArray loadSubTopicContentAll(Connection con) {
		Retriever rt = new Retriever();
		System.out.println("at loadSubTopicContentAll :");
		
		return rt.getAllFrom(con, "tab_topic_sub_contents");
	}
}
