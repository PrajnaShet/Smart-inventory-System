package com.inventorysystem.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.inventorysystem.dao.StockHistoryDAO;
import com.inventorysystem.model.StockHistory;
import com.inventorysystem.utility.DBConnection;

public class StockHistoryDAOImpl implements StockHistoryDAO {

    @Override
    public boolean addStockHistory(StockHistory stockHistory) {

        boolean status = false;

        String query = "INSERT INTO stock_history(product_id, change_type, quantity_changed) VALUES(?, ?, ?)";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setInt(1, stockHistory.getProductId());
            preparedStatement.setString(2, stockHistory.getChangeType());
            preparedStatement.setInt(3, stockHistory.getQuantityChanged());

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
    public List<StockHistory> getStockHistoryByProductId(int productId) {

        List<StockHistory> historyList = new ArrayList<>();

        String query = "SELECT * FROM stock_history WHERE product_id = ?";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setInt(1, productId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {

                StockHistory history = mapResultSetToStockHistory(resultSet);

                historyList.add(history);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return historyList;
    }

    @Override
    public List<StockHistory> getAllStockHistory() {

        List<StockHistory> historyList = new ArrayList<>();

        String query = "SELECT * FROM stock_history";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {

                StockHistory history = mapResultSetToStockHistory(resultSet);

                historyList.add(history);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return historyList;
    }

    private StockHistory mapResultSetToStockHistory(ResultSet resultSet)
            throws SQLException {

        StockHistory history = new StockHistory();

        history.setHistoryId(resultSet.getInt("history_id"));
        history.setProductId(resultSet.getInt("product_id"));
        history.setChangeType(resultSet.getString("change_type"));
        history.setQuantityChanged(resultSet.getInt("quantity_changed"));

        Timestamp updatedAt =
                resultSet.getTimestamp("updated_at");

        history.setUpdatedAt(updatedAt);

        return history;
    }
}