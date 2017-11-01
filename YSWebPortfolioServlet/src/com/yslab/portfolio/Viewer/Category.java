package com.yslab.portfolio.Viewer;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.yslab.portfolio.Store.ContentLoader;

/**
 * Servlet implementation class Category
 */
@WebServlet("/Category")
public class Category extends Index {
	private static final long serialVersionUID = 1L;
	
	private String contents = null;
	private String TARGET_HEAD = "Category?target=";
	private static String TARGET_TOPIC_LINK = "topic_link";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Category() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String target = request.getParameter("target");
		
		RequestDispatcher rd = null;
		
		request.setCharacterEncoding("utf-8");
		request.setAttribute("tabMenuList", tabMenuList);
		request.setAttribute("tabTopicList", tabTopicList);
		request.setAttribute("tabSubTopicList", tabSubTopicList);
		request.setAttribute("target", target);
		
		rd = request.getRequestDispatcher("category.jsp");
		rd.forward(request, response);
		
		System.out.println("Category doGet :");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
