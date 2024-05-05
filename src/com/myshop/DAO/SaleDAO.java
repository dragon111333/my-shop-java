package com.myshop.DAO;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;

import com.database.Database;

public class SaleDAO {

	Database db = new Database();

	public ArrayList<ArrayList<HashMap<String, Object>>> saleGraphHaveZeroMonth(int dateType) {
		// date type [0] = รายเดือน , date type [1] = รายวัน
		ArrayList<ArrayList<HashMap<String, Object>>> graphList = new ArrayList<>();
		try {
			LocalDate today = LocalDate.now();
			if (dateType == 0) {
				LocalDate reverst12Month = today.plusMonths(-12);
				String[] dateArr = String.valueOf(reverst12Month).split("-");
				int month = Integer.parseInt(dateArr[1])+1;
				int year = Integer.parseInt(dateArr[0]);
				long diff = reverst12Month.until(today, ChronoUnit.MONTHS);

				for (int i = 0; i < diff; i++) {
					if(month==13) {
						month = 1;
						year++;
					}
					String sql = "SELECT *,SUM(sale_count) as 'count',SUM(sale_sum) as 'sum',SUM(sale_profit) \n"
							+ "as 'profit',CONCAT_WS('-',MONTH(sale_date),YEAR(sale_date)) as 'sale_month'\n"
							+ "FROM tb_sale\n" + "WHERE  MONTH(sale_date) ='" + month + "' AND  YEAR(sale_date) = '"
							+ year + "'\n" + "GROUP BY MONTH(sale_date) AND  YEAR(sale_date)\n"
							+ "ORDER BY sale_date ASC";
					ArrayList<HashMap<String, Object>> list = db.queryList(sql);
					if (list.size()<=0) {
						graphList.add(null);
					} else {
						graphList.add(list);
					}
					month++;
				}
			} else if(dateType==1){
				LocalDate in7DayAgo = today.plusDays(-7);
				long diff = in7DayAgo.until(today,ChronoUnit.DAYS);

				for(int i = 0;i<diff;i++) {
		
					String sql = "SELECT *,CONCAT_WS('-',MONTH(sale_date),YEAR(sale_date)) as 'sale_month'\n"
							+ "FROM tb_sale\n" + "WHERE DATE(sale_date) = '"+in7DayAgo.plusDays(i+1)+"'\n"
							+ "ORDER BY sale_date ASC";
					ArrayList<HashMap<String,Object>> list = db.queryList(sql);
					if(list.size()<=0) {
						graphList.add(null);
					}else {
						graphList.add(list);
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return graphList;
	}

}
