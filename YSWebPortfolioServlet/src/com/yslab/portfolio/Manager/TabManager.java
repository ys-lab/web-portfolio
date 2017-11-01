package com.yslab.portfolio.Manager;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.yslab.portfolio.Store.ContentsApplier;
import com.yslab.portfolio.Viewer.Index;

/**
 * Servlet implementation class TabManager
 */
@WebServlet("/TabManager")
public class TabManager extends Index {
	private static final long serialVersionUID = 1L;
	
	private static final String TARGET_TABLE = "table";
	private static final String ADDED_LISTS = "added";
	private static final String MODIFIED_LISTS = "modified";
	private static final String DELETED_LISTS = "deleted";
	private static final String NUM = "num";
	
	private String targetTable = "";
	
	private JSONArray menuAddList = new JSONArray();
	private JSONArray menuUpdateList = new JSONArray();
	private JSONArray menuDeleteList = new JSONArray();
	
	private ContentsApplier ContentsApplier = new ContentsApplier();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TabManager() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("utf-8");
		
		System.out.println("at TabManager post :");
		System.out.println(request.getParameter("edited") + request.getParameter("deleted"));
		
		StringBuffer jsonData = new StringBuffer();
		String line = null;
		try {
		    BufferedReader reader = request.getReader();
		    while ((line = reader.readLine()) != null) {
		    	jsonData.append(line);
		    }
		    System.out.println(jsonData);
		} catch (Exception e) { 
			/*report an error*/ 
		}
		
		requestAnalyst(jsonData);
		applyMenu();
		setTabMenuList();
		setTabTopicList();
		setTabSubTopicList();
		
		doGet(request, response);
	}
	
	private void requestAnalyst(StringBuffer jsonData) {
		JSONParser jsonParser = new JSONParser();
		
		try {
			if(jsonData != null) {
				JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonData.toString());
				
				Iterator<String> keys = jsonObject.keySet().iterator();
				while(keys.hasNext()) {
					JSONObject menuList = new JSONObject();
					String key = (String) keys.next();
					
					switch(key) {
					
					case TARGET_TABLE:
						String tableName = jsonObject.get(TARGET_TABLE).toString();
						setTargetTable(tableName);
						break;
					default:
						menuList = (JSONObject) jsonObject.get(key);
						System.out.println("menuList :" + menuList);
						
						Iterator<String> numKeys = menuList.keySet().iterator();
						while(numKeys.hasNext()) {
							JSONObject menu = new JSONObject();
							String numKey = (String) numKeys.next();
							menu = (JSONObject) menuList.get(numKey);
							
							System.out.println("menu :" + menu);
							
							switch(key) {
							
							case ADDED_LISTS:
								menuAddList.add(menu);
								break;
							case MODIFIED_LISTS:
								menuUpdateList.add(menu);
								break;
							case DELETED_LISTS:
								menuDeleteList.add(menu);
								break;
							}
						}
						break;
					}
					
				}
				
				System.out.println(menuAddList.toString() + menuUpdateList.toString() + menuDeleteList.toString());

			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void setTargetTable(String targetTable) {
		this.targetTable = targetTable;
		System.out.println(targetTable);
	}
	
	private void applyMenu() {
		if(menuAddList.size() > 0) {
			ContentsApplier.addAll(con, menuAddList, targetTable);
			menuAddList.clear();
		}
		if(menuUpdateList.size() > 0) {
			ContentsApplier.updateAll(con, menuUpdateList, targetTable, NUM);
			menuUpdateList.clear();
		}
		if(menuDeleteList.size() > 0) {
			ContentsApplier.deleteAll(con, menuDeleteList, targetTable);
			menuDeleteList.clear();
		}
	}
}