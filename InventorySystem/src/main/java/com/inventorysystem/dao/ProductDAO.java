package com.inventorysystem.dao;

import java.util.List;

import com.inventorysystem.model.Product;

public interface ProductDAO {

    boolean addProduct(Product product);

    boolean updateProduct(Product product);

    boolean deleteProduct(int productId);

    Product getProductById(int productId);

    List<Product> getAllProducts();

    List<Product> searchProducts(String keyword);

    List<Product> getLowStockProducts();

    boolean updateStock(int productId, int quantity);

}