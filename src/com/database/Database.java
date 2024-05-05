package com.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class Database {
	Connection con = null;

	public int add(String sql) {
		int status = -1;
		try {
			con = DBconfig.getConnection();
			Statement statement = con.createStatement();
			status = statement.executeUpdate(sql);
			if (con != null) {
				statement.close();
				con.close();
			}
			return status;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public int add(String sql,String[] param) {
		int status = -1;
		try {
			con = DBconfig.getConnection();
			Statement statement = con.createStatement();
			 statement.executeUpdate(sql,param);
			ResultSet re = statement.getGeneratedKeys();
			if(re.next()) {
				status = re.getInt(1);
			}
			if (con != null) {
				statement.close();
				con.close();
			}
			return status;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public int update(String sql) {
		int status = -1;
		try {
			con = DBconfig.getConnection();
			Statement st = con.createStatement();
			status = st.executeUpdate(sql);
			if (con != null) {
				st.close();
				con.close();
			}
			return status;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public int delete(String sql) {
		int status = -1 ;
		try {
			con = DBconfig.getConnection();
			Statement st = con.createStatement();
			status = st.executeUpdate(sql);
			if(con!=null) {
				con.close();
				st.close();
			}
			return status;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public int delete(String sql,String[] param) {
		int status = -1;
		try {
			con = DBconfig.getConnection();
			Statement st = con.createStatement();
			st.executeUpdate(sql,param);
			ResultSet re = st.getGeneratedKeys();
			if(re.next()) {
				status = re.getInt(1);
			}
			if(con!=null) {
				con.close();
				st.close();
			}
			return status;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public ArrayList<HashMap<String, Object>> queryList(String sql) {
		try {
			con = DBconfig.getConnection();
			Statement st = con.createStatement();
			ResultSet re = st.executeQuery(sql);
			ResultSetMetaData reMeta = re.getMetaData();
			ArrayList<HashMap<String, Object>> list = new ArrayList<>();
			while (re != null && re.next()) {
				HashMap<String, Object> map = new HashMap<>();
				for (int i = 0; i < reMeta.getColumnCount(); i++) {
					map.put(reMeta.getColumnName(i + 1), re.getString(i + 1));
				}
				list.add(map);
			}
			if (con != null) {
				con.close();
				st.close();
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public HashMap<String,Object> querySingle(String sql){
		HashMap<String,Object> query = new HashMap<>();
		try {
			con = DBconfig.getConnection();
			Statement st = con.createStatement();
			ResultSet re = st.executeQuery(sql);
			ResultSetMetaData reMeta = re.getMetaData();
			if(re!=null) {
				re.next();
				for(int i = 0;i<reMeta.getColumnCount();i++) {
					query.put(reMeta.getColumnName(i+1),re.getString(i+1));
				}
			}
	
			if(con!=null) {
				con.close();
				st.close();
			}
			return query;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return query;
	}
	
}
