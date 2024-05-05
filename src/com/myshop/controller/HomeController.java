package com.myshop.controller;

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

import com.database.Database;
import com.myshop.Model.JsonResponseModel;

@Controller
public class HomeController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("home");
		try {
			System.out.println("homePage");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/findItemByBarcode", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel findItemByBarcode(HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		JsonResponseModel json = new JsonResponseModel();
		try {
			String barcode = request.getParameter("barcode");
			String sql = "SELECT * FROM tb_item WHERE item_barcode='" + barcode + "'";
			HashMap<String, Object> item = new Database().querySingle(sql);
			ArrayList<String> result = new ArrayList<>();
			for (int i = 0; i < item.size(); i++) {
				result.add(item.get("item_id").toString());
				result.add(item.get("item_name").toString());
				result.add(item.get("item_cost").toString());
				result.add(item.get("item_price").toString());
			}
			json.setResult(result);
			json.setStatus("success");
			return json;
		} catch (Exception e) {
			json.setStatus("error");
			e.printStackTrace();
			return json;
		}

	}

	@RequestMapping(value = "/addBill", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel addBill(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		JsonResponseModel json = new JsonResponseModel();
		try {
			int addType = Integer.parseInt(request.getParameter("addType"));
			double billSum = Double.parseDouble(request.getParameter("billSum"));
			int add = -1;
			if (addType == 0) {
					String sql = "INSERT INTO tb_bill(bill_sum,bill_profit,time_reg) \n"
							+ "VALUES("+billSum+",0.0,CURRENT_TIMESTAMP)";
					 add = new Database().add(sql,new String[] {"bill_id"});
					 json.setResult(add);
			} else {
				int itemId = Integer.parseInt(request.getParameter("itemId"));
				int billId = Integer.parseInt(request.getParameter("billId"));
				Database db = new Database();
				//bill det add
				String billDateAddSql = "INSERT INTO tb_bill_det(bill_id,item_id) VALUES("+billId+","+itemId+")";
				add = db.add(billDateAddSql,new String[] {"bill_id"});
				
				//find Profit
				String profitSql = "SELECT item_price-item_cost as profit FROM tb_item where item_id ="+itemId;
				HashMap<String,Object> profit = db.querySingle(profitSql);
				//update Profit
				String sql ="UPDATE tb_bill SET bill_profit = bill_profit+"+profit.get("profit").toString()+" WHERE bill_id = "+billId;
				db.update(sql);
				//update stock
				String stockSql = "UPDATE tb_item SET item_stock=item_stock-1 WHERE item_id = "+itemId;
				db.update(stockSql);
				
				json.setResult(add);
			}
			json.setStatus("success");
			return json;
		} catch (Exception e) {
			json.setStatus("error");
			e.printStackTrace();
			return json;
		}

	}
}
