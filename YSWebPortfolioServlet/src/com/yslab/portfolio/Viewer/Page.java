package com.yslab.portfolio.Viewer;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.yslab.portfolio.Store.ContentLoader;
import com.yslab.portfolio.Store.TabListLoader;
import com.yslab.portfolio.Utilities.DBConnector;

/**
 * Servlet implementation class Page
 */
@WebServlet("/Page")
public class Page extends Index {
	private static final long serialVersionUID = 1L;
	private String contents = null;
	private String TARGET_HEAD = "Page?target=";
	private static String TARGET_TOPIC_LINK = "topic_link";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Page() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String target = request.getParameter("target");
		
		JSONObject topicLink = new JSONObject();
		String content = "";
		topicLink.put(TARGET_TOPIC_LINK, TARGET_HEAD + target);
		
		ContentLoader contentLoader = new ContentLoader();
		content = contentLoader.loadTopicContent(con, topicLink).toJSONString();
		System.out.println("content : " + content);
		
		RequestDispatcher rd = null;
		
		request.setCharacterEncoding("utf-8");
		request.setAttribute("tabMenuList", tabMenuList);
		request.setAttribute("tabTopicList", tabTopicList);
		request.setAttribute("tabSubTopicList", tabSubTopicList);
		request.setAttribute("target", target);
		request.setAttribute("content", content);
		
		rd = request.getRequestDispatcher("page.jsp");
		rd.forward(request, response);
		
		System.out.println("Page doGet :");
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
