package com.yslab.portfolio.Utilities;

import java.sql.*;

public class DBConnector {
	static Connection con=null;
	
	static String db = "ys_portfolio";
	static String usr = "root";
	static String pwd = "132435a";
	
    public static Connection getConnection()
    {
        if (con != null) return con;
        // get db, user, pass from settings file
        return getConnection(db, usr, pwd);
    }

    private static Connection getConnection(String db_name,  String user_name,String password)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_name+"?user="+user_name+"&password="+password);
        }
        catch ( ClassNotFoundException e ){
        	e.printStackTrace();
        	System.out.println("There had no driver");
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        System.out.println("getConnection :");

        return con;        
    }
    
    private static boolean closeConnection() {
    	if(con != null) {
    		try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
    	}
    	return true;
    }
}
