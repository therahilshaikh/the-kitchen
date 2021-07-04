package com.rahil.dao;

import java.util.ArrayList;

import com.rahil.model.BillDetails;
import com.rahil.model.Category;
import com.rahil.model.Item;
import com.rahil.model.Login;
import com.rahil.model.OrderMaster;

public class UserService {		
	DBConnect dbconnect = new DBConnect();
	
	public ArrayList<Category> getAllCategorys() {
		return dbconnect.getAllCategory();
	}
	public boolean checkLogin(Login login) {
		return  dbconnect.checkLogin(login);		
	}
	
	public ArrayList<Item> getAllItems(int catId) {
		return dbconnect.getAllItemsByCategory(catId);
	}
	
	public ArrayList<OrderMaster> getAllOrders(int tableNo) {
		return dbconnect.getAllOrders(tableNo);
	}
	
	public ArrayList<BillDetails> getBill(int tableNo) {
		return dbconnect.getBill(tableNo);
	}
}