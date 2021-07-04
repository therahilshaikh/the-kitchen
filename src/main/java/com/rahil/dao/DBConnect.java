package com.rahil.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.rahil.model.BillDetails;
import com.rahil.model.Category;
import com.rahil.model.Item;
import com.rahil.model.Login;
import com.rahil.model.OrderDetails;
import com.rahil.model.OrderMaster;
import com.rahil.model.OrderMaster.OrderStatus;

public class DBConnect {
	private static Connection connection = null;
	private static String DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
	private static String DATABASE_NAME = "hotel_orders";
	private static String DB_URL = "jdbc:mysql://localhost:3306/"
			+ DBConnect.DATABASE_NAME;
	private static String USER_NAME = "root";
	private static String PASSWORD = "root";

	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName(DRIVER_NAME);
			con = (Connection) DriverManager.getConnection(DB_URL, USER_NAME,
					PASSWORD);
			return con;
		} catch (ClassNotFoundException cne) {
			System.out.println(cne);
		} catch (SQLException sqle) {
			System.out.println(sqle.toString());
		}
		return con;
	}

	public void closeConnection() {
		try {

			if (connection != null)
				connection.close();
		} catch (SQLException sqle) {
			System.out.println(sqle.toString());
		}
	}

	public boolean checkLogin(Login login) {
		String SQL = "select user_name,pass from login where user_name='"
				+ login.getUserName() + "' and pass='" + login.getPassword()
				+ "'";
		connection = getConnection();
		boolean result = Boolean.FALSE;
		try {
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				ResultSet rs = st.executeQuery(SQL);
				if (rs.next())
					result = Boolean.TRUE;
				else
					result = Boolean.FALSE;
				closeConnection();
			} else {
				System.out.println("Connection is null in checkLogin");
			}
		} catch (SQLException sqle) {
			System.out.println("sqle in checkLogin - " + sqle);
		}
		return result;
	}

	public boolean isAlreadyExists(String name) {
		String SQL = "select name from category where name='" + name + "'";
		connection = getConnection();
		boolean result = Boolean.FALSE;
		try {
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				ResultSet rs = st.executeQuery(SQL);
				if (rs.next())
					result = Boolean.TRUE;

				closeConnection();
			} else {
				System.out.println("Connection is null in isAlreadyExists");
			}
		} catch (SQLException sqle) {
			System.out.println("sqle in isAlreadyExists - " + sqle);
		}
		return result;
	}

	public boolean addCategory(String name) {
		String SQL = "insert into category(name) values('" + name + "')";
		connection = getConnection();
		boolean result = Boolean.FALSE;
		try {
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				int update = st.executeUpdate(SQL);
				if (update > 0)
					result = Boolean.TRUE;

				closeConnection();
			} else {
				System.out.println("Connection is null in addCategory");
			}
		} catch (SQLException sqle) {
			System.out.println("sqle in addCategory - " + sqle);
		}
		return result;

	}

	public boolean isItemAlreadyExists(String itemName) {
		String SQL = "select name from item where name='" + itemName + "'";
		connection = getConnection();
		boolean result = Boolean.FALSE;
		try {
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				ResultSet rs = st.executeQuery(SQL);
				if (rs.next())
					result = Boolean.TRUE;

				closeConnection();
			} else {
				System.out.println("Connection is null in isItemAlreadyExists");
			}
		} catch (SQLException sqle) {
			System.out.println("sqle in isItemAlreadyExists - " + sqle);
		}
		return result;
	}

	public boolean addItem(Item item) {
		String SQL = "insert into item(name, category_id, qnt, cost) values('"
				+ item.getItemName() + "', " + item.getCategoryId() + ", "
				+ item.getQnt() + ", '" + item.getCost() + "')";
		connection = getConnection();
		boolean result = Boolean.FALSE;
		try {
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				int update = st.executeUpdate(SQL);
				if (update > 0)
					result = Boolean.TRUE;

				closeConnection();
			} else {
				System.out.println("Connection is null in addCategory");
			}
		} catch (SQLException sqle) {
			System.out.println("sqle in addCategory - " + sqle);
		}
		return result;

	}

	public ArrayList<Category> getAllCategory() {
		String SQL = "SELECT * FROM category";
		ArrayList<Category> cats = new ArrayList<Category>();
		Category c = null;
		try {
			connection = getConnection();
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				ResultSet rs = st.executeQuery(SQL);
				while (rs.next()) {
					c = new Category();
					c.setId(rs.getInt("id"));
					c.setCategoryName(rs.getString("name"));
					cats.add(c);
				}
				closeConnection();
			} else {
				System.out.println("connection is null getAllCategory");
			}
		} catch (Exception e) {
			System.out.println("sqle in addCategory - " + e);
		}
		return cats;
	}

	public ArrayList<OrderMaster> getAllOrders() {
		String SQL = "SELECT * FROM order_master where status !='"
				+ OrderStatus.DELIVERED.name() + "' and order_date = curdate()";
		ArrayList<OrderMaster> os = new ArrayList<OrderMaster>();
		OrderMaster om = null;
		try {
			connection = getConnection();
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				ResultSet rs = st.executeQuery(SQL);
				while (rs.next()) {
					om = new OrderMaster();
					om.setId(rs.getInt("id"));
					om.setTableNo(rs.getInt("table_no"));
					om.setOrderName(rs.getString("name"));
					om.setDate(rs.getDate("order_date").toString());
					om.setDate(rs.getString("order_time"));
					om.setOrderStat(OrderMaster.getOrderStat(rs
							.getString("status")));

					os.add(om);
				}
				closeConnection();
			} else {
				System.out.println("connection is null in getAllOrders");
			}
		} catch (Exception e) {
			System.out.println("sqle in getAllOrders - " + e);
		}
		return os;
	}

	public boolean updateOrderStatus(int orderId, String status) {
		String SQL = "UPDATE order_master SET status='" + status
				+ "' where id=" + orderId;
		connection = getConnection();
		boolean result = Boolean.FALSE;
		try {
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				int update = st.executeUpdate(SQL);
				if (update > 0)
					result = Boolean.TRUE;

				closeConnection();
			} else {
				System.out.println("Connection is null in updateOrderStatus");
			}
		} catch (SQLException sqle) {
			System.out.println("sqle in updateOrderStatus - " + sqle);
		}
		return result;
	}

	public ArrayList<OrderDetails> getAllItems(int orderId) {
		String SQL = "SELECT order_master.id, table_no, item.id, item.name, item.qnt, item.cost, order_details.status"
				+ " FROM order_master,order_details, item"
				+ " WHERE order_master.id = order_details.order_id and order_details.item_id = item.id and order_master.id="
				+ orderId;
		ArrayList<OrderDetails> ods = new ArrayList<OrderDetails>();
		OrderDetails od = null;
		try {
			connection = getConnection();
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				ResultSet rs = st.executeQuery(SQL);
				while (rs.next()) {
					od = new OrderDetails();
					od.setId(rs.getInt("order_master.id"));
					od.setTableNo(rs.getInt("table_no"));
					od.setItemId(rs.getInt("item.id"));
					od.setItemName(rs.getString("item.name"));
					od.setQnt(rs.getInt("item.qnt"));
					od.setItemCost(rs.getString("item.cost"));
					od.setOrderStat(OrderDetails.getOrderStat(rs
							.getString("order_details.status")));
					ods.add(od);
				}
				closeConnection();
			} else {
				System.out.println("connection is null in getAllItems(oID)");
			}
		} catch (Exception e) {
			System.out.println("sqle in getAllItems(oId) - " + e);
		}
		return ods;
	}

	public boolean updateItemStatus(int orderId, int itemId, String status) {
		String SQL = "UPDATE order_details SET status='" + status
				+ "' where order_id=" + orderId + " and item_id=" + itemId;
		connection = getConnection();
		boolean result = Boolean.FALSE;
		try {
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				int update = st.executeUpdate(SQL);
				if (update > 0)
					result = Boolean.TRUE;

				closeConnection();
			} else {
				System.out.println("Connection is null in updateItemStatus");
			}
		} catch (SQLException sqle) {
			System.out.println("sqle in updateItemStatus - " + sqle);
		}
		return result;
	}

	public ArrayList<Item> getAllItemsByCategory(int catId) {
		String SQL = "SELECT * FROM item where category_id=" + catId;
		ArrayList<Item> items = new ArrayList<Item>();
		Item i = null;
		try {
			connection = getConnection();
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				ResultSet rs = st.executeQuery(SQL);
				while (rs.next()) {
					i = new Item();
					i.setId(rs.getInt("id"));
					i.setCategoryId(rs.getInt("category_id"));
					i.setItemName(rs.getString("name"));
					i.setQnt(rs.getInt("qnt"));
					i.setCost(rs.getString("cost"));
					items.add(i);
				}
				closeConnection();
			} else {
				System.out
						.println("connection is null in getAllItemsByCategory(itemId)");
			}
		} catch (Exception e) {
			System.out.println("sqle in getAllItemsByCategory(itemId) - " + e);
		}
		return items;
	}

	public ArrayList<OrderMaster> getAllOrders(int tableNo) {
		String SQL = "SELECT * FROM order_master where order_date = curdate() and table_no="
				+ tableNo;
		ArrayList<OrderMaster> os = new ArrayList<OrderMaster>();
		OrderMaster om = null;
		try {
			connection = getConnection();
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				ResultSet rs = st.executeQuery(SQL);
				while (rs.next()) {
					om = new OrderMaster();
					om.setId(rs.getInt("id"));
					om.setTableNo(rs.getInt("table_no"));
					om.setOrderName(rs.getString("name"));
					om.setDate(rs.getDate("order_date").toString());
					om.setDate(rs.getString("order_time"));
					om.setOrderStat(OrderMaster.getOrderStat(rs
							.getString("status")));

					os.add(om);
				}
				closeConnection();
			} else {
				System.out
						.println("connection is null in getAllOrders(tableNo)");
			}
		} catch (Exception e) {
			System.out.println("sqle in getAllOrders(tableNo) - " + e);
		}
		return os;
	}

	public boolean addOrder(OrderMaster orderMaster) {
		String SQL = "INSERT INTO order_master(table_no, name, order_date, order_time, status) "
				+ "VALUES("
				+ orderMaster.getTableNo()
				+ ", '"
				+ orderMaster.getOrderName()
				+ "', CURDATE(), CURTIME(), '"
				+ orderMaster.getOrderStat().name() + "' )";
		connection = getConnection();
		boolean result = Boolean.FALSE;
		try {
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				int update = st.executeUpdate(SQL);
				if (update > 0)
					result = Boolean.TRUE;

				closeConnection();
			} else {
				System.out.println("Connection is null in addOrder");
			}
		} catch (SQLException sqle) {
			System.out.println("sqle in addOrder - " + sqle);
		}
		return result;
	}

	public int getLastOrderId() {
		String SQL = "select * from order_master";
		connection = getConnection();
		int orderId = 0;
		try {
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				ResultSet rs = st.executeQuery(SQL);
				while (rs.next())
					orderId = rs.getInt("id");
			} else {
				System.out.println("Connection is null in getLastOrderId");
			}
		} catch (Exception e) {
			System.out.println("Error in getLastOrderId " + e);
		}
		return orderId;
	}

	public boolean addOrderedItems(ArrayList<OrderDetails> orderDetails) {
		for (OrderDetails ods : orderDetails) {
			if (!addOrderItem(ods))
				return false;
		}
		return true;
	}

	public boolean addOrderItem(OrderDetails ods) {
		String SQL = "INSERT INTO order_details(order_id, item_id, qnt, status) "
				+ "VALUES("
				+ ods.getOrderId()
				+ ", "
				+ ods.getItemId()
				+ ", "
				+ ods.getQnt() + ", '" + ods.getOrderStat().name() + "')";

		boolean result = Boolean.FALSE;
		try {
			connection = getConnection();
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				int update = st.executeUpdate(SQL);
				if (update > 0)
					result = Boolean.TRUE;
			} else {
				System.out
						.println("connection is null in addOrderItem(OrderDetails)");
			}
		} catch (Exception e) {
			System.out.println("Error in addOrderItem(OrderDetails) - " + e);
		}
		return result;
	}

	public ArrayList<BillDetails> getBill(int tableNo) {
		String SQL = "SELECT order_details.order_id, order_master.name, item.name, item.qnt, order_details.qnt, item.cost"+
					" FROM order_details, order_master,item"+
					" where order_details.order_id = order_master.id and"+
					" item.id = order_details.item_id"+
					" and order_date = curdate() and order_master.table_no="+tableNo;	
		ArrayList<BillDetails> bdetails = new ArrayList<BillDetails>();		
		try {
			connection = getConnection();
			if (connection != null) {
				Statement st = (Statement) connection.createStatement();
				ResultSet rs = st.executeQuery(SQL);
				while(rs.next())
				{
					BillDetails bd = new BillDetails();
					bd.setId(rs.getInt("order_details.order_id"));
					bd.setOrderId(rs.getInt("order_details.order_id"));
					bd.setOrderName(rs.getString("order_master.name"));
					bd.setItemName(rs.getString("item.name"));
					bd.setItemQnt(rs.getInt("item.qnt"));
					bd.setOrderQnt(rs.getInt("order_details.qnt"));
					bd.setItemCost(rs.getString("item.cost"));
					bdetails.add(bd);
					
				}
			} else {
				System.out
						.println("connection is null in getBill(tableNo)");
			}
		} catch (Exception e) {
			System.out.println("Error in getBill(tableNo) - " + e);
		}
		return bdetails;
	}

}
