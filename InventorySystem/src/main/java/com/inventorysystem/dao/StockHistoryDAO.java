package com.inventorysystem.dao;

import java.util.List;

import com.inventorysystem.model.StockHistory;

public interface StockHistoryDAO {

    boolean addStockHistory(StockHistory stockHistory);

    List<StockHistory> getStockHistoryByProductId(int productId);

    List<StockHistory> getAllStockHistory();

}