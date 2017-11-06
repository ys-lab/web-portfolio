package com.yslab.portfolio.Store;

import java.sql.Connection;
import org.json.simple.JSONArray;

import com.yslab.portfolio.Utilities.Retriever;

public class TabListLoader {
	
	Retriever rt = new Retriever();
	
	public JSONArray getTabMenuList(Connection con){
		System.out.println("at getList :");
		return rt.getAllFrom(con, "tab_menu_lists");
	}
	
	public JSONArray getTabTopicList(Connection con){
		System.out.println("at getList :");
		return rt.getAllFrom(con, "tab_topic_lists");
	}
	
	public JSONArray getTabTopicSubList(Connection con){
		System.out.println("at getList :");
		return rt.getAllFrom(con, "tab_topic_sub_lists");
	}
	
	public JSONArray getTabTopicContent(Connection con){
		System.out.println("at getList :");
		return rt.getAllFrom(con, "tab_topic_lists");
	}
	
	public JSONArray getTabTopicSubContent(Connection con){
		System.out.println("at getList :");
		return rt.getAllFrom(con, "tab_topic_lists");
	}
}
