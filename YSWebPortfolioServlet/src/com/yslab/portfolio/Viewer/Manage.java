package com.yslab.portfolio.Viewer;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yslab.portfolio.Store.ContentsApplier;

/**
 * Servlet implementation class Manage
 */
@WebServlet("/Manage")
public class Manage extends Index {
	private static final long serialVersionUID = 1L;
	private static final String TARGET = "target";
	private static final String PAGE = "Page";
	   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Manage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd = null;
		
		String forwardToPage = "";
		forwardToPage = request.getParameter(TARGET);
		
		request.setCharacterEncoding("utf-8");
		request.setAttribute("tabMenuList", tabMenuList);
		request.setAttribute("tabTopicList", tabTopicList);
		request.setAttribute("tabSubTopicList", tabSubTopicList);
		
		switch(forwardToPage) {
		case PAGE:
			rd = request.getRequestDispatcher("manage_page.jsp");
			break;
		default:
			rd = request.getRequestDispatcher("manage_menu.jsp");
			break;
		}
		
		rd.forward(request, response);
		
		System.out.println("Manage doGet :");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		doGet(request, response);
	}
	
}
