package com.inventorysystem.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.inventorysystem.dao.ProductDAO;
import com.inventorysystem.model.Product;
import com.inventorysystem.utility.DBConnection;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public boolean addProduct(Product product) {

        boolean status = false;

        String query = "INSERT INTO products(product_name, category_id, price, quantity, min_stock, description) VALUES(?, ?, ?, ?, ?, ?)";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setString(1, product.getProductName());
            preparedStatement.setInt(2, product.getCategoryId());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setInt(4, product.getQuantity());
            preparedStatement.setInt(5, product.getMinStock());
            preparedStatement.setString(6, product.getDescription());

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
    public boolean updateProduct(Product product) {

        boolean status = false;

        String query = "UPDATE products SET product_name = ?, category_id = ?, price = ?, quantity = ?, min_stock = ?, description = ? WHERE product_id = ?";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setString(1, product.getProductName());
            preparedStatement.setInt(2, product.getCategoryId());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setInt(4, product.getQuantity());
            preparedStatement.setInt(5, product.getMinStock());
            preparedStatement.setString(6, product.getDescription());
            preparedStatement.setInt(7, product.getProductId());

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
    public boolean deleteProduct(int productId) {

        boolean status = false;

        String query = "DELETE FROM products WHERE product_id = ?";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setInt(1, productId);

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
    public Product getProductById(int productId) {

        Product product = null;

        String query = "SELECT * FROM products WHERE product_id = ?";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setInt(1, productId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {

                product = mapResultSetToProduct(resultSet);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return product;
    }

    @Override
    public List<Product> getAllProducts() {

        List<Product> productList = new ArrayList<>();

        String query = "SELECT * FROM products";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {

                Product product = mapResultSetToProduct(resultSet);

                productList.add(product);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return productList;
    }

    @Override
    public List<Product> searchProducts(String keyword) {

        List<Product> productList = new ArrayList<>();

        String query = "SELECT * FROM products WHERE product_name LIKE ?";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setString(1, "%" + keyword + "%");

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {

                Product product = mapResultSetToProduct(resultSet);

                productList.add(product);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return productList;
    }

    @Override
    public List<Product> getLowStockProducts() {

        List<Product> productList = new ArrayList<>();

        String query = "SELECT * FROM products WHERE quantity <= min_stock";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {

                Product product = mapResultSetToProduct(resultSet);

                productList.add(product);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return productList;
    }

    @Override
    public boolean updateStock(int productId, int quantity) {

        boolean status = false;

        String query = "UPDATE products SET quantity = quantity + ? WHERE product_id = ?";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setInt(1, quantity);
            preparedStatement.setInt(2, productId);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                status = true;
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return status;
    }

    private Product mapResultSetToProduct(ResultSet resultSet) throws SQLException {

        Product product = new Product();

        product.setProductId(resultSet.getInt("product_id"));
        product.setProductName(resultSet.getString("product_name"));
        product.setCategoryId(resultSet.getInt("category_id"));
        product.setPrice(resultSet.getDouble("price"));
        product.setQuantity(resultSet.getInt("quantity"));
        product.setMinStock(resultSet.getInt("min_stock"));
        product.setDescription(resultSet.getString("description"));

        Timestamp createdAt = resultSet.getTimestamp("created_at");

        product.setCreatedAt(createdAt);

        return product;
    }
}