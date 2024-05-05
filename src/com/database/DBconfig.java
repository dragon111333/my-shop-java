package com.database;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconfig {
	
   public static Connection getConnection() {
	   try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost/myshop?user=root&password");
		return con;
	} catch (Exception e) {
		e.printStackTrace();
	}
	   return null;
   }
}
