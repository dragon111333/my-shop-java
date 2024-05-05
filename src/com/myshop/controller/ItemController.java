package com.myshop.controller;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.database.DBconfig;
import com.database.Database;
import com.google.gson.Gson;
import com.myshop.DAO.TbItemDAO;
import com.myshop.Model.JsonResponseModel;
import com.myshop.Model.TbItemModel;

@Controller
@RequestMapping("/item")
public class ItemController {
	
	@RequestMapping(value="/add_item",method=RequestMethod.GET)
	public ModelAndView add_item(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		ModelAndView model = new ModelAndView();
		System.out.println("ADD Item Page");
		try {
		DBconfig.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value="/add_item_this",method=RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel add_item_this(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		JsonResponseModel json = new JsonResponseModel();
try {
		String barcode = request.getParameter("barcode");
		String itemName = request.getParameter("itemName");
		double cost = Double.parseDouble(request.getParameter("cost").toString());
		double price = Double.parseDouble(request.getParameter("price").toString());
		TbItemModel item = new TbItemModel();
		item.setItemBarcode(barcode);
		item.setItemName(itemName);
		item.setItemCost(cost);
		item.setItemPrice(price);
		item.setItemStock(0);
		int status = new TbItemDAO().Add(item);
		json.setResult(status);
		json.setStatus("success");
	} catch (Exception e) {
		e.printStackTrace();
	}
		return json;
	}
	
	
	
	@RequestMapping(value="/manage_item",method=RequestMethod.GET)
	public ModelAndView manage_item(HttpSession session,HttpServletRequest request,HttpServletResponse respose) {
		ModelAndView model = new ModelAndView();
		try {
			System.out.println("Manage Item Page");
			Database db = new Database();
			ArrayList<HashMap<String,Object>> itemList = db.queryList("SELECT * FROM tb_item \n ORDER BY item_name ASC");
			request.setAttribute("itemList",itemList);
			return model;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	@RequestMapping(value="/editItemHere",method=RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel editItemHere(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		JsonResponseModel json = new JsonResponseModel();
		try {
			int id = Integer.parseInt(request.getParameter("itemId").toString());
			String barcode = request.getParameter("barcode");
			String name = request.getParameter("name");
			double cost = Double.parseDouble(request.getParameter("cost"));
			double price = Double.parseDouble(request.getParameter("price"));
			int stock = Integer.parseInt(request.getParameter("stock").toString());
			String sql = "UPDATE tb_item SET item_barcode='"+barcode+"',item_name='"+name+"'\n "
					+ ",item_cost="+cost+",item_price="+price+",item_stock="+stock+" \n"
					+" WHERE item_id = "+id;
			System.out.println(sql);
			Database db = new Database();
			int upStat = db.update(sql);
			json.setResult(upStat);
			json.setStatus("success");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="/deleteItem",method=RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel deleteItem(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		JsonResponseModel json = new JsonResponseModel();
		try {
			int itemId = Integer.parseInt(request.getParameter("itemId").toString());
			String sql = "DELETE FROM tb_item WHERE item_id = "+itemId;
			int status  = new Database().delete(sql);
			json.setResult(status);
			json.setStatus("success");
			return json;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value="/checkDublicItem",method=RequestMethod.POST)
	@ResponseBody
	public int checkDublicItem(HttpSession session,HttpServletResponse response,HttpServletRequest request) {
		int status = 0;
		try {
			String barcode = request.getParameter("barcode");
			String name = request.getParameter("name");
			String sql = "SELECT COUNT(*) count FROM tb_item WHERE item_barcode='"+barcode
						 +"' OR item_name='"+name+"' LIMIT 1";
			HashMap<String,Object> map = new Database().querySingle(sql);
			return status = (map.get("count").toString().equals("0"))?1:0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	
	@RequestMapping(value="/getCountOutStockItem",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public String getCountOutStockItem(HttpSession session,HttpServletRequest request,HttpServletResponse response){
				String json = "";
				try {
					String sql = "SELECT COUNT(*) as COUNT FROM TB_ITEM WHERE item_stock<=0;";
					HashMap<String,Object> list = new Database().querySingle(sql);
					return new Gson().toJson(list);
				} catch (Exception e) {
					e.printStackTrace();
				}
				return json;
			}

}
