<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ระบบจัดการร้าน</title>
</head>
<body>
	<jsp:include page="/include/header.jsp"/>
	  <div class="content-wrapper">
			  <div class="container-full">
			  		<section class="content">
								<%//---------------------------ROW 1------------------------------------- 
									ArrayList<ArrayList<String>> itemChartData = (ArrayList<ArrayList<String>>) request.getAttribute("sumItem");
								%>
								<h1 class="text-dark">ยอดขายสินค้า <i class="fas fa-stopwatch"></i></h1>
								<p class="text-primary">ยอดขายสินค้าทั้งหมด</p>
								<div class="row">
							  		<div class="col-xl-3 col-md-6 col-12">
													<div class="box">
														<ul class="box-controls pull-right text-white">
																	#														
															</ul>
														<div class="box-body pt-0">
															<div class="d-flex align-items-center justify-content-between">
																<div class="icon bg-primary-light rounded-circle">
																	<i class="fas fa-money-bill-wave font-size-50 text-primary"></i>
																</div>
																<div>
																	<h3 class="text-dark mb-0 font-weight-500"  id="sumPriceShow">0</h3>
																	<p class="text-mute mb-0">ยอดขายรวม</p>
																</div>
															</div>
														</div>
													</div>
							  		</div>
							  		<div class="col-xl-3 col-md-6 col-12">
													<div class="box">
														<ul class="box-controls pull-right text-white">
																	#														
															</ul>
														<div class="box-body pt-0">
															<div class="d-flex align-items-center justify-content-between">
																<div class="icon bg-primary-light rounded-circle">
																		<i class="fas fa-wallet text-success font-size-50"></i>
																</div>
																<div>
																	<h3 class="text-dark mb-0 font-weight-500"  id="sumProfitShow">0</h3>
																	<p class="text-mute mb-0">กำไร</p>
																</div>
															</div>
														</div>
													</div>
							  		</div>
							  		<div class="col-xl-3 col-md-6 col-12">
													<div class="box">
															<ul class="box-controls pull-right text-white">
																	#														
															</ul>
															<div class="box-body pt-0">
																<div class="d-flex align-items-center justify-content-between">
																	<div class="icon bg-primary-light rounded-circle">
																		<i class="fas fa-box font-size-50"></i>
																	</div>
																	<div>
																		<h3 class="text-dark mb-0 font-weight-500" id="sumCountSaleShow">0</h3>
																		<p class="text-mute mb-0">การขายทั้งหมก</p>
																	</div>
																</div>
															</div>
													</div>
							  		</div>
							  			<div class="col-xl-3 col-md-6 col-12">
													<div class="box">
															<ul class="box-controls pull-left"></ul>
															<div class="box-body">
																	<form>
																			<div class="row">
																					<div class="col">
																							<label>ดูตามวันที่</label>
																					</div>
																			</div>
																			<div class="row">
																					<div class="col col-8">
																							<input type="date" class="form-control form-control-sm float-right" id="findDate" value="">
																					</div>
																					<div class="col col-4">
																							<button type="button" class="btn btn-sm btn-primary float-left" style="width:100%;" onClick="searchDate()">
																									<i class="fas fa-search" ></i>
																							</button>
																					</div>
																			</div>
																	</form>
															</div>
													</div>
							  		</div>
							  	</div>
								 <div class="row">
								  	<div class="col">
										<center>
										<div class='card'>
													<div class="card-body">
															<h1 class="text-dark">ยอดขายสินค้าล่าสุด</h1>
															 <table>
																  <tr>
																  	<td colspan="3">
																  	<div style="font-size:14px;text-align:center;">
																	  			<button type="button" class="btn btn-success" id="saveThisBill" style="display:none;">บันทึกลงบิลรายวัน</button>
																	  			<button type="button" class="btn btn-outline-secondary" id="saveOk" style="display:none;">ยอดขายถูกบันทึกแล้ว</button>
																	</div>
																  	</td>
																  </tr>
															</table>
															<br>
															<div id="showTableLogSale">
															<table class="table table-striped" id="sales_table">
																<thead>
																	<tr>
																	<th>ลำดับ</th>
																	<th>รับเงินรวม</th>
																	<th>กำไร</th>
																	<th>สินค้า</th>
																	<th>วันที่/เวลา</th>
																	</tr>
																</thead>
																<tbody>
																	<% ArrayList<HashMap<String,Object>> billList = (ArrayList<HashMap<String,Object>>)request.getAttribute("billList"); 
																	int rowNum = 1;
																	 for(int i=0;i<billList.size();i++){
																		 try{
																	 %>
																		 <tr>
																			 <td><%=rowNum%></td>
																			 <td>
																			 		<span name="bill_sum" class="badge badge-warning"><%=billList.get(i).get("bill_sum")%></span>
																			 </td>
																			 <td>
																			 		<span name="bill_profit" class="badge badge-success"><%=billList.get(i).get("bill_profit")%></span>
																			 </td>
																			 <td>
																				 <%String thisBillId = billList.get(i).get("bill_id").toString();
																				 do{%>
																						 <%=billList.get(i).get("item_name")%><br>
																						 <%i++;
																				 }while(thisBillId.equals(billList.get(i).get("bill_id")));
																				 i--; %>
																			 </td>
																			 <td >
																			 		<span class="badge badge-dark"><%=billList.get(i).get("date") %>&nbsp;|&nbsp;<%=billList.get(i).get("time") %></span>
																			 </td>
																		 </tr>
																	 <%
																	 rowNum++;
																	 
																	}catch(Exception e){
																		i--;%> 
																			<td >
																			 		<span class="badge badge-dark"><%=billList.get(i).get("date") %>&nbsp;|&nbsp;<%=billList.get(i).get("time") %></span>
																			 </td>													<% 
																			 break;
																		 }		
																	 }%>
																	</tbody>
																</table>
																</div>
																<tr><td> <input type="hidden" value="<%=rowNum%>" id="rowNum"></td></tr>
													</div>
										</div>
								 </div>	
								</div>
								 <div class="row">
													 <div class="col col-8">
															 	<div class='card'>
															 			<div class="card-header">
															 					<h3 class='text-dark'>ยอดขาย <i class="fas fa-chart-bar"></i></h3>
																				<p class="text-info">กราฟแสดงยอดขาย </p>
															 			</div>
																		<div class="card-body">
																				<select id="saleGraphType" class="form-control" style="width:30%;height:40px">
																					<option value='1'>รายวัน</option>
																					<option value='0'>รายเดือน</option>
																				</select>
																				<div id="saleChartArea"></div>
																		</div>
																</div>
													</div>
													  <div class="col col-4" >
																<div class='card' >
																		<div class="card-header">
																				<h3 class='text-dark'>สินค้าขายดี <i class="fas fa-chart-pie"></i></h3>
																				<p class="text-info">กราฟแสดงสินค้าขายดี</p>
																		</div>
																		<div class="card-body">
																				<div id="itemChart"></div>
																		</div>
																 </div>
													 </div>	
							</div>	
															<div class="row">
										<div class="col">
												<div class='card'>	
														<div class="card-body">
																<center>
																<h1 class='text-primary border-bottom  pb-2 mb-0'>บิลรายวัน <i class="fas fa-calendar-alt"></i></h1>
																<p class="text-info">ยอดขายรวมของแต่ละวันที่มีการบันทึกจากยอดขายรวม</p>
																 <table>
																		 <tr>
																			  <td>
																			 	 <label >ดูตามเดือน&nbsp;</label>
																			  </td>
																			   <td>
																			    	<input type="month" class="form-control" id="findMonth" placeholder="วัน/เดือน/ปี">
																			   </td>
																			   <td>
																			   	<button type="button" class="btn btn-primary" id="searchMonth" onclick="searchMonth()">ค้นหา</button>
																			   </td>
																		  </tr>
																		  <tr>
																			  	<td colspan="3">
																			  	<div style="font-size:14px;text-align:center;">
																				  	<span>ยอดขายรวม </span><span class="text-primary"style="font-size:28px" id="sumPriceDayShow">0</span><span> ฿</span>
																				  	<span>,กำไร </span><span class="text-success"style="font-size:28px" id="sumProfitDayShow">0</span><span> ฿</span>
																				</div>
																			  	</td>
																		  </tr>
																</table>
																<br>
																 <div id="saleByDay_div">
																	<table id="saleByDay_table" class="table table-striped">
																		<thead>
																			<tr>
																				<th>วันที่</th>
																				<th>ยอดขายทั้งหมด</th>
																				 <th>กำไรรวม</th>
																				<th>จำนวนการขาย(ครั้ง)</th>
																				<th></th>
																			</tr>
																		</thead>
																		<tbody id="saleByDay_tbody">
																			 <%ArrayList<HashMap<String,Object>> salesList = (ArrayList<HashMap<String,Object>>) request.getAttribute("salesList");
																			 int rowNum2 = 1;
																			 for(int i=0;i<salesList.size();i++){%>
																				 <tr>
																					 <td >
																					 	<span class="badge badge-dark"><%=salesList.get(i).get("sale_date") %></span>
																					 </td>
																					 <td>
																					 		<span class="badge badge-pill badge-warning"  name="saleSumDay"><%=salesList.get(i).get("sale_sum") %></span>
																					 </td>
																					 <td>
																					 		<span class="badge badge-pill badge-success"  name="saleProfitDay"><%=salesList.get(i).get("sale_profit") %></span>
																					 </td>
																					 <td><span class="badge badge-dark" style="width:100%"><%=salesList.get(i).get("sale_count") %></span></td>
																					 <td>
																						<form class="float-right">
																							 <div class="form-row">
																							 		<div class="col">
																							 		 	<button type="button" class="btn btn-outline-primary float-right" onclick="saleInfo('<%=salesList.get(i).get("sale_date")%>')"><i class="fas fa-search"></i></button>&nbsp;
																									</div>
																									<div class="col">
																									 	<button type="button" class="btn btn-outline-success float-right" onclick="exportSale('<%=salesList.get(i).get("sale_date")%>')">ดาวโหลดบิล <i class="fas fa-file-excel"></i></button>&nbsp;
																									 </div>
																									 <div class="col">
																									 	<button type="button" class="btn btn-outline-danger float-left" onclick="delTheSalesOfDay(<%=salesList.get(i).get("sale_id")%>)"><i class="fas fa-trash-alt"></i></button>
																							 		</div>
																							 </div>
																						</form>
																					</td>
																				 </tr>
																			<%  }%> 
																		</tbody>
																	</table>
																  </div>
														</div>
												</div>
										</div>
								</div>
				</section>
			</div>
	</div>
	
<script src="${pageContext.request.contextPath}/content/js/zynColors.js"></script>
<script type="text/javascript">
	var path = $('#path').val();
	
	$(document).ready(function(){
		dataTable($('#sales_table'));
		dataTable($('#saleByDay_table'));
		sumData(document.getElementsByName("bill_sum").length);
		sumDataSaleOfDay(document.getElementsByName("saleSumDay").length);
		updateChartSale(1,'');
		renderChart(<%=itemChartData.get(1)%>,<%=itemChartData.get(0)%>);
	});
	
	function searchDate() {
		 let date = $('#findDate').val();
		 if(date==""){
		 	 swOption.callError("โปรดระบุวันที่","โปรดระบุวันที่เพื่อค้นหาข้อมูล")
		 }else{
			 //--โหลดตารางยอดขายล่าสุด----
			 loadSalesTable(path+"/manage/sales_log?logSaleDate="+$('#findDate').val()+" #sales_table");
			 //-------------------------------------
			 
			 //-------------โหลดตรางรายเดือน------------
			 loadMonthTable();
			//------------------------------------------------
					 
			//----อัพเดท กราฟไอเทม---
		    updateChart($('#findDate').val());
			//------------------------------
			$.ajax({
				 type:"POST",
				 url:path+"/manage/searchByDate",
				 data:"date="+date,
				 timeout:600000,
				 success: function(rs){
								new Promise((resolve,reject)=>{
									//-------------------------------check type salse-------------------------------
										 if(parseInt(rs.result)<=0){
											 document.getElementById("saveThisBill").style.display = "block";
											 document.getElementById("saveOk").style.display = "none";
										 }else{
											 document.getElementById("saveThisBill").style.display = "none";
											 document.getElementById("saveOk").style.display = "block";
										 }
										 resolve(true);
									//-----------------------------------------------------------------------------------
								}).then((status)=>{
										//--------------------------check Empty row ----------------------------
										setTimeout(function(){
											let lengthData =  document.getElementsByName('bill_sum').length;
											sumData(lengthData);
											if(lengthData<=0){
												document.getElementById("saveThisBill").style.display = "none";
												 document.getElementById("saveOk").style.display = "none";
											}
										},500);
									//-----------------------------------------------------------------------------						
								})
				 }
			 });
			
		 }
	 }
	
	function searchMonth(){
		var month = $('#findMonth').val();
		if(month==""){
		 	 swOption.callError("โปรดระบุวันที่","โปรดระบุวันที่เพื่อค้นหาข้อมูล")
		}else{
			$.ajax({
				type:"POST",
				enctype:"multipart/form_data",
				url:path+"/manage/findSaleByMonth",
				data:"month="+month,
				timeout:600000,
				success:function(rs){
					$('#saleByDay_tbody').empty();
					if(rs.length>0){
					  for(i=0;i<rs.length;i++){
						    $('#saleByDay_tbody').append('<tr>'
																			    +' <td >'
																			    +' 	<span class="badge badge-dark">'+rs[i].sale_date+'</span>'
																			    +'</td>'
																			    +'<td>'
																			    +'		<span class="badge badge-pill badge-warning"  name="saleSumDay">'+rs[i].sale_sum+'</span>'
																			    +'</td>'
																			    +'<td>'
																			    +'		<span class="badge badge-pill badge-success"  name="saleProfitDay">'+rs[i].sale_profit+'</span>'
																			    +'</td>'
																			    +'<td><span class="badge badge-dark" style="width:100%">'+rs[i].sale_count+'</span></td>'
																			    +'<td>'
																			    +'	<form class="float-right">'
																			    +'		 <div class="form-row">'
																			    +'		 		<div class="col">'
																			    +'		 		 	<button  type="button" class="btn btn-outline-primary float-right" onclick="saleInfo(\''+rs[i].sale_date+'\')"><i class="fas fa-search"></i></button>&nbsp;'
																			    +'				</div>'
																			    +'				<div class="col">'
																			    +'				 	<button  type="button"  class="btn btn-outline-success float-right" onclick="exportSale(\''+rs[i].sale_date+'\')">ส่งออกเป็น <i class="fas fa-file-excel"></i></button>&nbsp;'
																			    +'				 </div>'
																			    +'				 <div class="col">'
																			    +'				 	<button  type="button"  class="btn btn-outline-danger float-left" onclick="delTheSalesOfDay('+rs[i].sale_id+')"><i class="fas fa-trash-alt"></i></button>'
																			    +'		 		</div>'
																			    +'		 </div>'
																			    +'	</form>'
																			    +'</td>'
																	    +'</tr>');  
					  }
					}else{
						$('#saleByDay_tbody').append("<tr><td colspan='5' style='width:100%;'><h1>ไม่มีบันทึก</h1></td></tr>");
					}
					setTimeout(function(){
						sumDataSaleOfDay(document.getElementsByName("saleSumDay").length);
					},200);
				}
			});
		}
	
	}
	
	function saleInfo(date){
		let dateArr  = date.split("-");
		loadSalesTable(path+"/manage/sales_log?logSaleDate="+dateArr[2]+"-"+dateArr[1]+"-"+dateArr[0]+" #sales_table");
		loadMonthTable();
		
		if(dateArr[1].length<=1){
			dateArr[1] = "0"+dateArr[1];
		}else if(dateArr[0].length<=1){
			dateArr[0] = "0"+dateArr[0];
		}
		
		document.getElementById('findDate').value = dateArr[2]+"-"+dateArr[1]+"-"+dateArr[0];
		updateChart(dateArr[2]+"-"+dateArr[1]+"-"+dateArr[0]);
		setTimeout(function(){
				new Promise((resolve,reject)=>{
					sumData(document.getElementsByName("bill_sum").length);
					sumDataSaleOfDay(document.getElementsByName("saleSumDay").length);
					resolve(true);
				}).then((status)=>{
						document.getElementById("sumPriceShow").scrollIntoView();
				})
		}
		,500);
	}
	
	function exportSale(date){
		$.ajax({
			type:"POST",
			url:path+"/manage/exportSaleToExcel",
			data:"date="+date,
			timeout:600000,
			success:function(rs){
				if(rs.status=='success'){
					location.href = rs.file_path;
					swOption.callSuccess('ส่งออกสำเร็จสำเร็จ','');
				}else{
					swOption.callError('เกิดข้อผิดพลาด','');
				}
			}
		});
	}
//---------------------------------------------------------- SUM DATA ----------------------------------------------
	 function sumData(lengthOfData){
			var sumPrice = 0.0;
			var sumProfit = 0.0;
			 for (i=0;i<lengthOfData;i++){
				 sumPrice += parseFloat(document.getElementsByName('bill_sum')[i].innerHTML);
				 sumProfit += parseFloat(document.getElementsByName('bill_profit')[i].innerHTML);
			 }
			 $('#sumCountSaleShow').html(lengthOfData);
			 $('#sumPriceShow').html(sumPrice.toFixed(2));
			 $('#sumProfitShow').html(sumProfit.toFixed(2));
	 }
	 
	 function sumDataSaleOfDay(lengthOfSaleData){
			var sumPrice = 0.0;
			var sumProfit = 0.0;
			for(i=0;i<lengthOfSaleData;i++){
				sumPrice += parseFloat(document.getElementsByName('saleSumDay')[i].innerHTML);
				sumProfit += parseFloat(document.getElementsByName('saleProfitDay')[i].innerHTML) ;
			}
			$('#sumPriceDayShow').html(sumPrice.toFixed(2));
			$('#sumProfitDayShow').html(sumProfit.toFixed(2));
	 };
//------------------------------------------------------------------------------------------------------------------------

	 $('#saveThisBill').click(function(){
				 var sumPrice = $('#sumPriceShow').html();
				 var sumProfit = $('#sumProfitShow').html();
				 var saleCount = $('#sumCountSaleShow').html();
				 var date = $('#findDate').val();
		
				 var data = "sumPrice="+sumPrice+"&sumProfit="+sumProfit+"&saleCount="+saleCount
				 				+"&date="+date;
				 $.ajax({
					 type:"POST",
					 enctype:"multipart/form_data",
					 url:path+"/manage/insertSales",
					 data:data,
					 timeout:600000,
					 success: function(rs){
						 if(rs.result<=0){
						 	 swOption.callError("เกิดข้อผิดพลาด","โปรดลองอีกครั้ง")
						 }else{
							 document.getElementById("saveThisBill").style.display = "none";
							 document.getElementById("saveOk").style.display = "block";
							 swOption.callSuccess("บันทึกแล้ว","");
							 loadMonthTable();
						 }
					 }
				 });
	 });
	 
	 function delTheSalesOfDay(thisSaleId){
		swOption.callConfirm("ต้องการลบ","ต้องการลบบันทึกนี้หรือไม่?"  ,()=>{
					 $.ajax({
						 type:"POST",
						 enctype:"multipart/form_data",
						 url:path+"/manage/delSales",
						 data:"saleId="+thisSaleId,
						 timeout:600000,
						 success:function(rs){
							 if(rs.result<-1){
									swOption.callError('เกิดข้อผิดพลาด','');
							 }else{
								 loadMonthTable();
								 swOption.callSuccess("ลบสำเร็จ","");
							 }
						 }
					 });
		});
	 }
	 
	 $('#saleGraphType').change(function(){
		var type = $('#saleGraphType').val();
		updateChartSale(type,'');
	 });
	 
	 //--------------------------โหลดตาราง-----------------------------------------
	 function loadSalesTable(link){
		 $("#showTableLogSale").load(link);
		 setTimeout(function(){
				dataTable($('#sales_table'));
			},500);
	 }
	 
	 function loadMonthTable(){
		 $('#saleByDay_div').load(path+'/manage/sales_log?logSaleDate=0 #saleByDay_table');
		 setTimeout(()=>{dataTable($('#saleByDay_table'))},500);
	 }
	 
	 function dataTable(tableOption){
		 tableOption.DataTable({
		        "scrollY":"300px",
		        "scrollCollapse": true,
		        "paging":false,
		        "searching": false,
		        "info":false
		    });
	 }
	 //--------------------------------------------------------------------------------------
	 
	 //-------------------------------โหลดกราฟ------------------------------------------
	 function updateChart(date){
				 $.ajax({
					 type:"POST",
					 enctype:"multipart/form_data",
					 url:path+"/manage/updateChart",
					 data:"date="+date,
					 timeout:600000,
				 }).done((rs)=>{
							 if(rs.length<=0){
								 		renderChart([100],['ไม่มีข้อมูล']);
							 }else{
										  new Promise((resolve,reject)=>{
												 let labels = [];
												 let data = [];
												 rs.forEach((item)=>{
														 labels.push(item.item_name);
														 data.push(parseInt(item.sum));
												});
												 resolve({"data":data,"labels":labels});
										  }).then((loopData)=>{
												renderChart(loopData.data,loopData.labels);
										  });
							 }
			 })
	 }
	 
	 function renderChart(data,labels){
		 $('#itemChart').empty();	
		 $('#itemChart').attr('style','display:none;');
			 new Promise((resolve,reject)=>{
							 let itemChartOptions = {
						                series: data,
						                chart: {
						                type: 'donut',
						              },
						              labels:labels,
						              responsive: [{
								                breakpoint: 480,
								                options: {
								                  chart: {
								                    width: 300
								                  },
								                  legend: {
								                    position: 'bottom',
								                    inverseOrder: true
								                  }
								                }
						              }]
						              ,legend: {
						                  position: 'top',
						              }
						           	 ,tooltip: {
								            shared: true,
								            y: {
									              formatter: (val)=> {
									                return val +" ชิ้น";
									              }
								            }
								         }
						 	};	
							resolve(itemChartOptions);
			 }).then((options)=>{
						 var itemChart = new ApexCharts(document.querySelector("#itemChart"), options);
						  itemChart.render();		
						  return(true);
			 }).then((status_chart)=>{
				  $('#itemChart').attr('style',"display:block;");
			 })	

	 }
	 
	 function updateChartSale(type,date){
		 $.ajax({
			 type:"POST",
			 enctype:"multipart/form_data",
			 url:path+"/manage/updateChartSale",
			 data:"type="+type+"&date="+date,
			 success:function(rs){
							 let labels = [];
							 let dataSum = [];
							 let dataProfit= [];
							 let dataCount = [];
							if(type==0){
										 let Months12Ago = new Date(new Date().setMonth(new Date().getMonth()-12));
										 let month = Months12Ago.getMonth()+2;
										 let year = Months12Ago.getFullYear();
										 for(i=0;i<rs.length;i++){
														 if(month==13){
															 month=1;
															 year++;
														 }
														 labels.push(parseMonthToThai(month)+"-"+year);
														 if(rs[i]==null){
															 dataSum.push(0);
															 dataProfit.push(0);
															 dataCount.push(0);
														 }else{
															 dataSum.push(rs[i][0].sum);
															 dataProfit.push(rs[i][0].profit);
															 dataCount.push(rs[i][0].count);
														 }
														 month++;
										 }
			
							}else if(type==1){
										let today = new Date();
										let in7DayAgo = new Date(today.setDate(today.getDate()-7));
											for(i=0;i<rs.length;i++){
											 	let thisDay = new Date(in7DayAgo.setDate(in7DayAgo.getDate()+1));
												labels.push(thisDay.getDate()+"-"+parseMonthToThai(thisDay.getMonth()+1));
												if(rs[i]==null){
													  dataSum.push(0);
													  dataProfit.push(0);
													  dataCount.push(0);
												}else{
													 dataSum.push(rs[i][0].sale_sum);
													  dataProfit.push(rs[i][0].sale_profit);
													  dataCount.push(rs[i][0].sale_count);
												}
											}
							}							 
						//----apex sale chart------
						let chartSaleOption = {
															"dataSum":dataSum
															,"dataProfit":dataProfit
															,"dataCount":dataCount
															,"labels":labels
															,"chartId":"saleChartArea"
															,"chartType":"area"
													}
						renderChartSale(chartSaleOption);
			 }
		 });
	 }
	 
	 function renderChartSale(option){
				 let chartSaleOption = {
				          series: [{
				        	  		  name:"ยอดขาย(บาท)"
							          ,data: option.dataSum }
							         ,{ 
							        	 name:"กำไร(บาท)"
							        	 ,data:option.dataProfit}
							         ,{
							        	 name:"การขายทั้งหมด(ครั้ง)"
							        	 ,data:option.dataCount
							         }
				          ],
				          chart: {
					          type: option.chartType,
					          height: 350
				        },
				        plotOptions: {
					          bar: {
					            horizontal: false,
					          }
				        },
				        dataLabels: {
				          	enabled: true
				        },
				        xaxis: {
				         	 categories:option.labels,
				        }  
				        ,tooltip: {
				            shared: true,
				            y: {
					              formatter: (val)=> {
					                return val ;
					              }
				            }
				         }
		       };
		
				 $("#"+option.chartId).empty();
				 let chartSale = new ApexCharts(document.querySelector("#"+option.chartId), chartSaleOption);
				 chartSale.render();
	 }
//----------------------------------------------------------------------------------------------------------------------- 
		function parseMonthToThai(monthNum){
			var monthName = '';
			 if(monthNum==1){
					monthName ='มกราคม';
				 }else if(monthNum==2){
					monthName ='กุมภาพันธ์';
				 }else if(monthNum==3){
					 monthName ='มีนาคม';
				 }else if(monthNum==4){
					 monthName ='เมษายน';
				 }else if(monthNum==5){
					 monthName ='พฤษภาคม';
				 }else if(monthNum==6){
					 monthName ='มิถุนายน';
				 }else if(monthNum==7){
					 monthName ='กรกฎาคม';
				 }else if(monthNum==8){
					 monthName ='สิงหาคม';
				 }else if(monthNum==9){
					 monthName ='กันยายน';
				 }else if(monthNum==10){
					 monthName ='ตุลาคม';
				 }else if(monthNum==11){
					 monthName ='พฤศจิกายน';
				 }else{
					 monthName ='ธันวาคม';
				 }
			 return monthName;
		}
	</script>
</body>
</html>