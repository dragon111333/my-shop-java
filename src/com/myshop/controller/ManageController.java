package com.myshop.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStreamReader;
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
import com.google.gson.Gson;
import com.myshop.DAO.SaleDAO;
import com.myshop.Model.JsonResponseModel;

@Controller
@RequestMapping("/manage")
public class ManageController {

	@RequestMapping(value = "/sales_log",method = RequestMethod.GET)
	public ModelAndView sales_log(HttpSession sessioin, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView();
		try {
			System.out.println("Manager Page");
			String sql = "";
			if (String.valueOf(request.getParameter("logSaleDate")).equals("0")||request.getParameter("logSaleDate")==null) {
				sql = "SELECT A.*,B.bill_det_id,B.item_id,item.item_name\n" + ",CONCAT_WS('-',DAY(A.time_reg)\n"
						+ ",MONTH(A.time_reg),YEAR(A.time_reg)) as date,TIME(A.time_reg) as time FROM(\n"
						+ "	SELECT * FROM tb_bill\n" + "	) as A\n" + "INNER JOIN \n" + "	(\n"
						+ "	SELECT * FROM tb_bill_det\n" + "	) as B\n" + "ON A.bill_id = B.bill_id\n"
						+ "INNER JOIN \n" + "	(\n" + "	SELECT * FROM tb_item\n" + ") as item \n"
						+ "ON B.item_id = item.item_id\n" + "ORDER BY b.bill_id DESC LIMIT 100";
			
		
			} else {
				String logSaleDate = request.getParameter("logSaleDate");
				sql = "SELECT A.*,B.bill_det_id,B.item_id,item.item_name\n" + ",CONCAT_WS('-',DAY(A.time_reg)\n"
						+ ",MONTH(A.time_reg),YEAR(A.time_reg)) as date,TIME(A.time_reg) as time FROM(\n"
						+ "	SELECT * FROM tb_bill\n" + "	) as A\n" + "INNER JOIN \n" + "	(\n"
						+ "	SELECT * FROM tb_bill_det\n" + "	) as B\n"
						+ "ON A.bill_id = B.bill_id AND DATE(A.time_reg)='" + logSaleDate + "'\n" + "INNER JOIN \n"
						+ "	(\n" + "	SELECT * FROM tb_item\n" + ") as item \n" + "ON B.item_id = item.item_id\n"
						+ "ORDER BY b.bill_id DESC";
				
			}
			
			String saleTableSql = "SELECT *,CONCAT_WS('-',DAY(sale_date),MONTH(sale_date),YEAR(sale_date)) as 'sale_date' \n" +
								  "FROM tb_sale\n" +
								   "ORDER BY  DATE(sale_date) DESC,YEAR(sale_date) DESC LIMIT 100";
			Database db = new Database();
			ArrayList<HashMap<String,Object>> salesList = db.queryList(saleTableSql);
			ArrayList<HashMap<String, Object>> billList = db.queryList(sql);
			//------------------------กราฟรวมสินค้า--------------
			String sqlCountItem = "SELECT a.*,item.item_name,b.time_reg,COUNT(a.item_id) as sum FROM \n" +
					"( \n" +
					"	SELECT * FROM tb_bill_det\n" +
					") as a\n" +
					"INNER JOIN (\n" +
					"	SELECT * FROM tb_bill\n" +
					")as b\n" +
					"ON a.bill_id = b.bill_id AND b.time_reg BETWEEN \n" +
					"DATE_ADD(CURRENT_DATE,INTERVAL -3 MONTH) AND CURRENT_DATE \n" +
					"INNER JOIN \n" +
					"(\n" +
					"	SELECT * FROM tb_item\n" +
					")as item \n" +
					"ON a.item_id = item.item_id\n" +
					"GROUP BY a.item_id LIMIT 100";
			ArrayList<HashMap<String,Object>> sumItem = db.queryList(sqlCountItem);
			//  [0] = ชื่อสินค้า , [1] = ขายได้กี่ชิ้น 	
			ArrayList<ArrayList<String>> itemChartData = new ArrayList<>();
			ArrayList<String> sumItemLabels = new ArrayList<>();
			ArrayList<String> sumItemData = new ArrayList<>();
			
			for(int i=0;i<sumItem.size();i++) {
			 sumItemLabels.add("'"+sumItem.get(i).get("item_name").toString()+"'");	
			 sumItemData.add(sumItem.get(i).get("sum").toString());	
			}
			itemChartData.add(sumItemLabels);
			itemChartData.add(sumItemData);
			//-----------------------------------------------------

			request.setAttribute("billList", billList);
			request.setAttribute("salesList",salesList);
			request.setAttribute("sumItem",itemChartData);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "searchByDate", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel searchByDate(HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		JsonResponseModel json = new JsonResponseModel();
		try {
			String date = request.getParameter("date");
			String sql = "SELECT COUNT(*) as sum \n" 
						+ "FROM tb_sale\n" 
						+ "WHERE DATE(sale_date) ='" + date + "'";
			HashMap<String, Object> list = new Database().querySingle(sql);
			int sum = Integer.parseInt(list.get("sum").toString());
			json.setResult(sum);
			json.setStatus("success");
			return json;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value="/findSaleByMonth",method=RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String findSaleByMonth(HttpSession sessoin,HttpServletRequest request,HttpServletResponse response) {
		String json ="";
		try {
			String date[] = String.valueOf(request.getParameter("month")).split("-");
			String sql =  "SELECT *,CONCAT_WS('-',DAY(sale_date),MONTH(sale_date),YEAR(sale_date)) as 'sale_date' \n" +
						  "FROM tb_sale\n" +
						  "WHERE YEAR(sale_date) = '"+date[0]+"' AND MONTH(sale_date) = '"+date[1]+"' \n" +
						  "ORDER BY sale_date ASC LIMIT 100";
			ArrayList<HashMap<String,Object>> list = new Database().queryList(sql);
			 json = new Gson().toJson(list);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value = "insertSales", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel insertSales(HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		JsonResponseModel json = new JsonResponseModel();
		try {
			double sumPrice = Double.parseDouble(request.getParameter("sumPrice"));
			double sumProfit = Double.parseDouble(request.getParameter("sumProfit"));
			int saleCount = Integer.parseInt(request.getParameter("saleCount"));
			String date = request.getParameter("date");
			String sql = "INSERT INTO tb_sale(sale_sum,sale_profit,sale_count,sale_date,time_reg) \n"
					+ "VALUES("+sumPrice+","+sumProfit+","+saleCount+",'"+date+"',CURRENT_TIMESTAMP)";
			int status = new Database().add(sql,new String[] {"sale_id"});
			json.setResult(status);
			json.setStatus("success");
			return json;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value = "delSales", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel delSales(HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		JsonResponseModel json = new JsonResponseModel();
		try {
			int saleId = Integer.parseInt(request.getParameter("saleId"));
			String sql = "DELETE FROM tb_sale WHERE sale_id="+saleId;
			int status = new Database().delete(sql);
			json.setResult(status);
			json.setStatus("success");
			return json;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	
	//------------------------ เขียนไฟล์  -----------------------
	@RequestMapping(value="/exportSaleToExcel",method=RequestMethod.POST,produces="application/json; charset=UTF-8")
	@ResponseBody
	public String exportSaleToExcel(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		
		HashMap<String,String> json = new HashMap<String,String>();
		String date = request.getParameter("date");
		String dateArr[] = date.split("-");
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		
		if(dateArr[1].length()<2) {
			dateArr[1] = "0"+dateArr[1];
		}else if(dateArr[0].length()<2) {
			dateArr[0]="0"+dateArr[0];
		}
		String sumDate = dateArr[2]+"-"+dateArr[1]+"-"+dateArr[0];
		
		try {
			String sql = "SELECT A.*,B.bill_det_id,B.item_id,item.item_name\n" + ",CONCAT_WS('-',DAY(A.time_reg)\n"
					+ ",MONTH(A.time_reg),YEAR(A.time_reg)) as date,TIME(A.time_reg) as time FROM(\n"
					+ "	SELECT * FROM tb_bill\n" + "	) as A\n" + "INNER JOIN \n" + "	(\n"
					+ "	SELECT * FROM tb_bill_det\n" + "	) as B\n"
					+ "ON A.bill_id = B.bill_id AND DATE(A.time_reg)='"+sumDate+"'\n"
					+ "INNER JOIN \n"
					+ "	(\n" + "	SELECT * FROM tb_item\n" + ") as item \n" + "ON B.item_id = item.item_id\n"
					+ "ORDER BY b.bill_id DESC";

			Database db = new Database();
			
			list = db.queryList(sql);
			
			String filePath = "C://log_sale/วันที่_"+date+".csv";
			BufferedWriter bw = new BufferedWriter(new FileWriter(filePath,false));			
			int thisId = Integer.parseInt(list.get(0).get("bill_id").toString());
			
			bw.write(",เวลา,รับเงินรวม(บาท),กำไร(บาท),สินค้า\n");
		
			float sum = (float) 0.0;
			float sumProfit = (float) 0.0;
			int numberOfBill = 1;
			
			for(int i=0;i<list.size();i++) {
				
				if(i==0) {
					bw.write(numberOfBill+","+list.get(i).get("time")+","+list.get(i).get("bill_sum")+","+list.get(i).get("bill_profit")
							+","+list.get(i).get("item_name")+"\n");
					
					sum += Float.parseFloat(list.get(i).get("bill_sum").toString());;
					sumProfit += Float.parseFloat(list.get(i).get("bill_profit").toString());
					numberOfBill++;
				}else if(thisId == Integer.parseInt(list.get(i).get("bill_id").toString())){
					bw.write(",,,,"+list.get(i).get("item_name")+"\n");
					
				}else {
					bw.write(numberOfBill+","+list.get(i).get("time")+","+list.get(i).get("bill_sum")+","+list.get(i).get("bill_profit")
							+","+list.get(i).get("item_name")+"\n");
					
					sum += Float.parseFloat(list.get(i).get("bill_sum").toString());;
					sumProfit += Float.parseFloat(list.get(i).get("bill_profit").toString());
					thisId = Integer.parseInt(list.get(i).get("bill_id").toString());
					numberOfBill++;
				}
				
			}
			bw.write("\nยอดขายรวม >,"+sum+" บาท,,,");
			bw.write("\nกำไรรวม >,"+sumProfit+" บาท,,,");
			bw.flush();
			json.put("status","success");
			json.put("file_path",filePath);
			return new Gson().toJson(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new Gson().toJson(json);
	}
	//------------------------ เขียนไฟล์  -----------------------
	
	@RequestMapping(value="/updateChart",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String updateChart(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		String date = request.getParameter("date");
		String json = "";
		try {
			String 	sql = "SELECT a.*,item.item_name,b.time_reg, COUNT(a.item_id) as sum FROM \n" +
					"( \n" +
					"	SELECT * FROM tb_bill_det\n" +
					") as a\n" +
					"INNER JOIN (\n" +
					"	SELECT * FROM tb_bill\n" +
					")as b\n" +
					"ON a.bill_id = b.bill_id AND DATE(b.time_reg) = '"+date+"'\n" +
					"INNER JOIN \n" +
					"( \n" +
					"	SELECT * FROM tb_item\n" +
					")as item \n" +
					"ON a.item_id = item.item_id\n" +
					"GROUP BY a.item_id";
			ArrayList<HashMap<String,Object>> itemUpdateChart = new Database().queryList(sql);
			json = new Gson().toJson(itemUpdateChart);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value="/updateChartSale",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String updateChartSale(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		int type = Integer.parseInt(request.getParameter("type"));
		String json  ="";
		try {
			//------------------------[ กราฟยอดขายสินค้า ]----------------
			ArrayList<ArrayList<HashMap<String, Object>>> saleMonthList = new SaleDAO().saleGraphHaveZeroMonth(type);
			json = new Gson().toJson(saleMonthList);
			//-------------------------------------------------------
			return json;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
}
