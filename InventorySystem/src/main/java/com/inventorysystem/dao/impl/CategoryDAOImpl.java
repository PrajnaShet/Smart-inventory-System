package com.inventorysystem.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.inventorysystem.dao.CategoryDAO;
import com.inventorysystem.model.Category;
import com.inventorysystem.utility.DBConnection;

public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public boolean addCategory(Category category) {

        boolean status = false;

        String query =
                "INSERT INTO categories(category_name, description) VALUES(?, ?)";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setString(1, category.getCategoryName());
            preparedStatement.setString(2, category.getDescription());

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                status = true;
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return status;
    }

    @Override
    public boolean updateCategory(Category category) {

        boolean status = false;

        String query =
                "UPDATE categories SET category_name = ?, description = ? WHERE category_id = ?";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setString(1, category.getCategoryName());
            preparedStatement.setString(2, category.getDescription());
            preparedStatement.setInt(3, category.getCategoryId());

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                status = true;
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return status;
    }

    @Override
    public boolean deleteCategory(int categoryId) {

        boolean status = false;

        String query =
                "DELETE FROM categories WHERE category_id = ?";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setInt(1, categoryId);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                status = true;
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return status;
    }

    @Override
    public Category getCategoryById(int categoryId) {

        Category category = null;

        String query =
                "SELECT * FROM categories WHERE category_id = ?";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setInt(1, categoryId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {

                category = new Category();

                category.setCategoryId(resultSet.getInt("category_id"));
                category.setCategoryName(resultSet.getString("category_name"));
                category.setDescription(resultSet.getString("description"));
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return category;
    }

    @Override
    public List<Category> getAllCategories() {

        List<Category> categoryList = new ArrayList<>();

        String query =
                "SELECT * FROM categories";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {

                Category category = new Category();

                category.setCategoryId(resultSet.getInt("category_id"));
                category.setCategoryName(resultSet.getString("category_name"));
                category.setDescription(resultSet.getString("description"));

                categoryList.add(category);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return categoryList;
    }
}