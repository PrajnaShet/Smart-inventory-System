package com.inventorysystem.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	

	    // Database URL
	    private static final String URL =
	            "jdbc:mysql://localhost:3306/inventory_system";

	    // Database Username
	    private static final String USERNAME = "root";

	    // Database Password
	    private static final String PASSWORD = "Praxy@1244";

	    // Method to get database connection
	    public static Connection getConnection() {

	        Connection connection = null;

	        try {

	            // Load MySQL Driver
	            Class.forName("com.mysql.cj.jdbc.Driver");

	            // Create Connection
	            connection = DriverManager.getConnection(
	                    URL,
	                    USERNAME,
	                    PASSWORD
	            );

	            System.out.println("Database Connected Successfully!");

	        } catch (ClassNotFoundException e) {

	            System.out.println("MySQL Driver Not Found!");
	            e.printStackTrace();

	        } catch (SQLException e) {

	            System.out.println("Database Connection Failed!");
	            e.printStackTrace();
	        }

	        return connection;
	    }
	}

