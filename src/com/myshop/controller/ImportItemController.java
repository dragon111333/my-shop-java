package com.myshop.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import com.myshop.Model.JsonResponseModel;

@Controller
@RequestMapping("/import_item")
public class ImportItemController {
	
	@RequestMapping(value="/import_item",method=RequestMethod.GET)
	public ModelAndView import_item(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		ModelAndView model = new ModelAndView();
		System.out.println("Import Item Page");
		try {
		DBconfig.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value="/findItemByBarcode",method=RequestMethod.POST,produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String findItemByBarcode(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		String json = "";
		HashMap<String,Object> item = new HashMap<String,Object>();
		try {
			String barcode = request.getParameter("barcode");
			String sql = "SELECT * FROM tb_item WHERE item_barcode='"+barcode+"' LIMIT 1";
			item = new Database().querySingle(sql);
			item.put("status", "success");
			json = new Gson().toJson(item);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			item.put("status","error");
			json = new Gson().toJson(item);
			return json;
		}
		
	}
	
	@RequestMapping(value="/import_item_log",method=RequestMethod.GET)
	public ModelAndView import_item_log(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		ModelAndView model = new ModelAndView();
		try {
			System.out.println("import item log");
			String sql = "SELECT log.*,item.item_name,item.item_barcode,\n" +
					"CONCAT_WS(\"-\",DAY(log.time_reg),MONTH(log.time_reg),YEAR(log.time_reg)) as date\n" +
					"FROM(\n" +
					"SELECT * FROM tb_import_item\n" +
					")as log\n" +
					"INNER JOIN (\n" +
					"SELECT * FROM tb_item\n" +
					") as item\n" +
					"ON log.item_id = item.item_id\n" +
					"ORDER BY MONTH(log.time_reg) DESC , YEAR(log.time_reg) DESC";
			ArrayList<HashMap<String,Object>> list = new Database().queryList(sql);
			request.setAttribute("importLog",list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return  model;
	}
	
	@RequestMapping(value="/successImport",method=RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel successImport(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		JsonResponseModel json = new JsonResponseModel();
		try {
			String itemId = request.getParameter("itemId");
			int stockAdd = Integer.parseInt(request.getParameter("stock").toString());
			//add import log-----------
			String sqlLog = "INSERT INTO tb_import_item(item_id,import_sum,time_reg) VALUES("+itemId+","+stockAdd+",CURRENT_TIMESTAMP)";
			new Database().add(sqlLog);
			//--------------------------
			
			//update Stock-----
			String sql = "UPDATE tb_item SET item_stock="+stockAdd+"+item_stock \n"
					+"WHERE item_id="+itemId;
			int status = new Database().update(sql);
			//------------------
			json.setResult(status);
			json.setStatus("success");
			return json;
		} catch (Exception e) {
			json.setStatus("error");
			e.printStackTrace();
			return json;
		}
		
	}
	
	@RequestMapping(value="/findImportLogByDate",method = RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel findImportLogByDate(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		JsonResponseModel json = new  JsonResponseModel();
		try {
			String time = request.getParameter("time");
			String sql = "SELECT log.*,item.item_name,item.item_barcode,\n" +
					"CONCAT_WS(\"-\",DAY(log.time_reg),MONTH(log.time_reg),YEAR(log.time_reg)) as date\n" +
					"FROM(\n" +
					"SELECT * FROM tb_import_item\n" +
					")as log\n" +
					"INNER JOIN (\n" +
					"SELECT * FROM tb_item\n" +
					") as item\n" +
					"ON log.item_id = item.item_id AND DATE(log.time_reg) = '"+time+"'\n" +
					"ORDER BY date DESC";
			ArrayList<HashMap<String,Object>> list = new Database().queryList(sql);
			ArrayList<ArrayList<String>> result = new ArrayList<>();
			
			for(int i=0;i<list.size();i++) {
				ArrayList<String> in = new ArrayList<>();
				in.add(list.get(i).get("import_id").toString());
				in.add(list.get(i).get("item_barcode").toString());
				in.add(list.get(i).get("item_name").toString());
				in.add(list.get(i).get("import_sum").toString());
				in.add(list.get(i).get("date").toString());
				result.add(in);
			}
			json.setResult(result);
			json.setStatus("success");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}

}
