package com.yslab.portfolio.Viewer;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;

import com.yslab.portfolio.Store.TabListLoader;
import com.yslab.portfolio.Utilities.DBConnector;

/**
 * Servlet implementation class Index
 */
@WebServlet("/Index")
public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static Connection con;
	public TabListLoader tabListLoader = new TabListLoader();
	
	public static String tabMenuList = null;
	public static String tabTopicList = null;
	public static String tabSubTopicList = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Index() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init() throws ServletException {
    	DBConnector DB = new DBConnector();
    	con = DB.getConnection();
    	this.tabMenuList = this.tabListLoader.getTabMenuList(con).toJSONString();
    	this.tabTopicList = this.tabListLoader.getTabTopicList(con).toJSONString();
    	this.tabSubTopicList = this.tabListLoader.getTabTopicSubList(con).toJSONString();
    }
    
    public String getTabMenuList() {
    	return tabMenuList;
    }
    
    public String getTabTopicList() {
    	return tabTopicList;
    }
    
    public String getTabSubTopicList() {
    	return tabSubTopicList;
    }

    public void setTabMenuList() {
    	tabMenuList = tabListLoader.getTabMenuList(con).toJSONString();
    }
    
    public void setTabTopicList() {
    	tabTopicList = tabListLoader.getTabTopicList(con).toJSONString();
    }
    
    public void setTabSubTopicList() {
    	tabSubTopicList = tabListLoader.getTabTopicList(con).toJSONString();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd = null;
		
		request.setCharacterEncoding("utf-8");
		request.setAttribute("tabMenuList", tabMenuList);
		request.setAttribute("tabTopicList", tabTopicList);
		rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
		
		System.out.println("Index doGet :");
		
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
