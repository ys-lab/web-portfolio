package com.yslab.portfolio.Manager;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Types;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.yslab.portfolio.Store.ContentLoader;
import com.yslab.portfolio.Store.ContentsApplier;
import com.yslab.portfolio.Viewer.Index;

/**
 * Servlet implementation class PageManager
 */
@WebServlet("/PageManager")
public class PageManager extends Index {
	private static final long serialVersionUID = 1L;
	
	private static final String TARGET_TABLE = "table";
	private static final String NUM = "num";
	private static final String TOPIC_NUM = "topic_num";
	
	private JSONObject update_target = new JSONObject();
	private JSONArray forUpdate = new JSONArray();
	
	private String targetTable = "";
	
	private ContentsApplier ContentsApplier = new ContentsApplier();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PageManager() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("at PageManager :");
		
		request.setCharacterEncoding("utf-8");
		
		String target_table = request.getParameter("table");
		String topic_num = request.getParameter(TOPIC_NUM);
		
		System.out.println(target_table + topic_num);
		
		JSONObject topicNum = new JSONObject();
		topicNum.put(TOPIC_NUM, topic_num);
		String content = "";
		
		try {
			switch(target_table) {
			case "tab_topic_contents":
				ContentLoader contentLoader = new ContentLoader();
				content = contentLoader.loadTopicContent(con, topicNum).toJSONString();
				System.out.println("content : " + content);
				break;
			}
		} catch(Exception e) {
			
		}
		
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(content);
		
			
		System.out.println("PageContent doGet :");
		
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("utf-8");
		
		System.out.println("at PageManager post :");
		
		StringBuffer jsonData = new StringBuffer();
		String line = null;
		try {
		    BufferedReader reader = request.getReader();
		    while ((line = reader.readLine()) != null) {
		    	jsonData.append(line);
		    }
		    System.out.println(jsonData);
		} catch (Exception e) { 
			
		}
		
		requestAnalyst(jsonData);
		applyContent(forUpdate);
		
	}
    
    private void requestAnalyst(StringBuffer jsonData) {
		JSONParser jsonParser = new JSONParser();
		
		try {
			if(jsonData != null) {
				JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonData.toString());
				JSONObject contentData = new JSONObject();
				
				Iterator<String> keys = jsonObject.keySet().iterator();
				while(keys.hasNext()) {
					
					String key = (String) keys.next();
					
					switch(key) {
					
					case TARGET_TABLE:
						String tableName = jsonObject.get(TARGET_TABLE).toString();
						setTargetTable(tableName);
						break;
					default:
						String context = jsonObject.get(key).toString();
						contentData.put(key, context);
						break;
					}
				}
				forUpdate.add(contentData);
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
	
	private void applyContent(JSONArray forUpdate) {
		if(forUpdate.size() > 0) {
			ContentsApplier.updateAll(con, forUpdate, targetTable, TOPIC_NUM);
		}
	}

}
