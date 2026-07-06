package com.inventorysystem.dao;

import com.inventorysystem.model.Admin;

public interface AdminDAO {

    Admin login(String username, String password);

}