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
@RequestMapping("/deptor")
public class DeptorController {

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView home(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView();
		try {
			System.out.println("Deptor HomePage");
			String sql = "SELECT * FROM tb_deptor";
			ArrayList<HashMap<String, Object>> list = new Database().queryList(sql);
			request.setAttribute("deptorList", list);
			return model;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}
	
	@RequestMapping(value="/deptor_info",method=RequestMethod.GET)
	public ModelAndView deptor_info(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		ModelAndView model = new ModelAndView();
		try {
			System.out.println("deptor Info page");
			int deptorId = Integer.parseInt(request.getParameter("deptor_id").toString());
			String sql="SELECT * FROM (\n" +
					" SELECT * FROM tb_deptor\n" +
					" ) as a INNER JOIN (\n" +
					"	SELECT * FROM tb_deptor_log\n" +
					"	) as b\n" +
					"	ON a.deptor_id = b.deptor_id\n"
					+"AND a.deptor_id = "+deptorId
					+"\nORDER BY DAY(b.time_reg) DESC,MONTH(b.time_reg) DESC\n"
					+",YEAR(b.time_reg) DESC,TIME(b.time_reg) DESC";
			
			ArrayList<HashMap<String,Object>> list = new Database().queryList(sql);
			request.setAttribute("depInfo",list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return model;
	}
	
	@RequestMapping(value="/add_deptor_form",method=RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel addDeptorForm(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		JsonResponseModel json = new JsonResponseModel();
		try {
			String name = request.getParameter("name");
			String sum = request.getParameter("sum");
			String info = request.getParameter("info");
			
			String sql = "INSERT INTO tb_deptor(deptor_name,deptor_sum) VALUES('"+name+"',"+sum+")";
			int lastDeptorId = new Database().add(sql,new String[] {"deptor_id"});
			
			String sqlInfo ="INSERT INTO tb_deptor_log(deptor_id,deptor_log_info,deptor_log_sum,time_reg)\n"
							+"VALUES("+lastDeptorId+",'"+info+"',"+sum+",CURRENT_TIMESTAMP)";
			int lastDeptorLog = new Database().add(sqlInfo,new String[] {"deptor_log_id"});
			
			json.setResult(lastDeptorLog);
			json.setStatus("1");
			return json;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value="/addDepToDeptor",method=RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel addDepToDeptor(HttpSession session,HttpServletResponse response,HttpServletRequest request) {
		JsonResponseModel json = new JsonResponseModel();
		try {
			String deptorId = request.getParameter("deptorId").toString();
			String sumMoney = request.getParameter("sumMoney").toString();
			String newInfo = request.getParameter("newInfo").toString();
			String sql ="INSERT INTO tb_deptor_log(deptor_id,deptor_log_info,deptor_log_sum,time_reg)\n"
						+"VALUES("+deptorId+",'"+newInfo+"',"+sumMoney+",CURRENT_TIMESTAMP)";
			String sqlUpdate = "UPDATE tb_deptor SET deptor_sum = deptor_sum+"+sumMoney+" WHERE deptor_id = "+deptorId;
			Database db = new Database();
			int status[] = new int[2];
			 status[0] =db.add(sql);
			 status[1] = db.add(sqlUpdate);
			 json.setResult(status);
			 json.setStatus("success_plus");
			return json;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value="/reducesDeptoDeptor",method = RequestMethod.POST)
	@ResponseBody
	public JsonResponseModel reducesDeptoDeptor(HttpSession session,HttpServletResponse response ,HttpServletRequest request) {
		JsonResponseModel json = new JsonResponseModel();
		try {
			String deptorId = request.getParameter("deptorId").toString();
			String sumMoney = request.getParameter("sumMoney").toString();
			String sql ="INSERT INTO tb_deptor_log(deptor_id,deptor_log_info,deptor_log_sum,time_reg)\n"
					+"VALUES("+deptorId+",'จ่ายหนี้',"+sumMoney+",CURRENT_TIMESTAMP)";
			String sqlUpdate = "UPDATE tb_deptor SET deptor_sum = deptor_sum - "+sumMoney+" WHERE deptor_id = "+deptorId;
			Database db = new Database();
			int status[] = new int[2];
			 status[0] =db.add(sql);
			 status[1] = db.add(sqlUpdate);
			 //CHECK 0
			 String sqlCheck ="SELECT deptor_sum FROM tb_deptor WHERE deptor_id="+deptorId;
			HashMap<String,Object> list = db.querySingle(sqlCheck);
			if(Double.parseDouble(list.get("deptor_sum").toString())<=0) {
				String sqlDelete = "DELETE FROM tb_deptor WHERE deptor_id="+deptorId;
				String sqlDeleteDeptor = "DELETE FROM tb_deptor_log WHERE deptor_id ="+deptorId;
				db.delete(sqlDelete);
				db.delete(sqlDeleteDeptor);
				json.setStatus("success_delete_out");
			}else {
				 json.setStatus("success_delete");
			}
			 //----------
			 json.setResult(status);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
}
