package com.inventorysystem.model;

import java.sql.Timestamp;

public class StockHistory {
    private int historyId;
    private int productId;
    private String changeType;
    private int quantityChanged;
    private Timestamp updatedAt;

    public StockHistory() {
    }

    public StockHistory(int historyId, int productId, String changeType, int quantityChanged, Timestamp updatedAt) {
        this.historyId = historyId;
        this.productId = productId;
        this.changeType = changeType;
        this.quantityChanged = quantityChanged;
        this.updatedAt = updatedAt;
    }

    public StockHistory(int productId, String changeType, int quantityChanged) {
        this.productId = productId;
        this.changeType = changeType;
        this.quantityChanged = quantityChanged;
    }

    public int getHistoryId() {
        return historyId;
    }

    public void setHistoryId(int historyId) {
        this.historyId = historyId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getChangeType() {
        return changeType;
    }

    public void setChangeType(String changeType) {
        this.changeType = changeType;
    }

    public int getQuantityChanged() {
        return quantityChanged;
    }

    public void setQuantityChanged(int quantityChanged) {
        this.quantityChanged = quantityChanged;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}