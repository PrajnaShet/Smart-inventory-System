package com.inventorysystem.utility;

import java.util.List;

import com.inventorysystem.dao.CategoryDAO;
import com.inventorysystem.dao.impl.CategoryDAOImpl;
import com.inventorysystem.model.Category;

public class CategoryDAOTest {

    public static void main(String[] args) {

        CategoryDAO categoryDAO = new CategoryDAOImpl();

        List<Category> categoryList =
                categoryDAO.getAllCategories();

        for (Category category : categoryList) {

            System.out.println("Category ID : "
                    + category.getCategoryId());

            System.out.println("Category Name : "
                    + category.getCategoryName());

            System.out.println("Description : "
                    + category.getDescription());

            System.out.println("----------------------------");
        }
    }
}