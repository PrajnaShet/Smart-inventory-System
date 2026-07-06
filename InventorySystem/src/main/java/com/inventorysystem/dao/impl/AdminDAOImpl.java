package com.inventorysystem.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.inventorysystem.dao.AdminDAO;
import com.inventorysystem.model.Admin;
import com.inventorysystem.utility.DBConnection;

public class AdminDAOImpl implements AdminDAO {

    @Override
    public Admin login(String username, String password) {

        Admin admin = null;

        String query = "SELECT * FROM admins WHERE username = ? AND password = ?";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {

                admin = new Admin();

                admin.setAdminId(resultSet.getInt("admin_id"));
                admin.setUsername(resultSet.getString("username"));
                admin.setEmail(resultSet.getString("email"));
                admin.setPassword(resultSet.getString("password"));
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return admin;
    }
}