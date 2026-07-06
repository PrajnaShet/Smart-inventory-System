package com.inventorysystem.dao;

import java.util.List;

import com.inventorysystem.model.Category;

public interface CategoryDAO {

    boolean addCategory(Category category);

    boolean updateCategory(Category category);

    boolean deleteCategory(int categoryId);

    Category getCategoryById(int categoryId);

    List<Category> getAllCategories();

}