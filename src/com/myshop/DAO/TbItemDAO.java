package com.myshop.DAO;

import java.util.ArrayList;
import java.util.HashMap;

import com.database.Database;
import com.myshop.Model.TbItemModel;

import imp.DAO.DAO;

public class TbItemDAO implements DAO<TbItemModel> {
	
	private Database db;
	public TbItemDAO() {
		db = new Database();
	}

	@Override
	public int Add(TbItemModel bean) {
		String sql = "INSERT INTO tb_item(item_barcode,item_name,item_cost,item_price,item_stock,time_reg)\n"
				+ "VALUES('"+bean.getItemBarcode()+"','"+bean.getItemName()+"',"+bean.getItemCost()+","+bean.getItemPrice()+",0,CURRENT_TIMESTAMP)";
		System.out.println(sql);
		return db.add(sql);
	}

	@Override
	public int Delete(TbItemModel bean) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int Update(TbItemModel bean) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<TbItemModel> FindAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TbItemModel FindByID(TbItemModel bean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TbItemModel FindByID(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TbItemModel MappingBeans(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

}
