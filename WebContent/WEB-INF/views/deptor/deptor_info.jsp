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
	<center>
	  <div class="content-wrapper">
			  <div class="container-full">
			  		<section class="content">
							<%ArrayList<HashMap<String,Object>> depInfo = (ArrayList<HashMap<String,Object>>) request.getAttribute("depInfo"); %>
								<div class="row">
										<div class="col">
												<div class="font-size-30">
														<span><i class="fas fa-user"></i> ผู้ติดหนี้ : </span>
														<span class="badge badge-dark"><%=depInfo.get(0).get("deptor_name")%></span>
												</div>
												<br>
												<div class="card">
															<div class="card-header" style="text-align:center;">
																	  <input type="hidden" id="deptor_id" value="<%=depInfo.get(0).get("deptor_id")%>">
															</div>
															<div class="card-body">
																	  <p class="text-primary">ประวัติหนี้</p>
																		  <input type="checkbox" name="the_check" id= "check0" onClick="editCheckBox(this.id)">
																		   <label for="check0">เพิ่มหนี้</label>
																		   &nbsp;&nbsp;&nbsp;&nbsp;
																		  <input type="checkbox" name="the_check" id="check1" onClick="editCheckBox(this.id)">
																		  <label for="check1">จ่ายหนี้</label>
																		  
																		  <div id="edit_deptor_form" style="display:none;">
																		  	<input type="number" id="sum_money" placeholder="จ่ายหนี้ ฿" class="form-control" style="width:200px">&nbsp;
																		  	<input type="text" id="new_info" placeholder="หมายเหตุ" class="form-control" style="width:200px;display:none;">
																		  	<br>
																		  	<button type="button" id="ok_button" class="btn btn-md btn-success">ยืนยัน</button>
																		  </div>
																	  <br>
																		<span class="text-dark" style="font-size:25px">ยอดรวม : </span>
																		<span class="badge badge-warning text-dark" style="font-size:25px"><%=depInfo.get(0).get("deptor_sum")%> ฿</span>
																		<table class="table table-striped"  id="dep_info">
																			<thead>
																				<tr>
																					<th>วันที่</th>
																					<th>ข้อมูล</th>
																					<th>รวม</th>
																				</tr>
																			</thead>
																			<tbody>
																				<%for(int i=0;i<depInfo.size();i++){%>
																				<tr>
																					<td ><span class="badge badge-dark"><%=depInfo.get(i).get("time_reg")%></span></td>
																					<%if(depInfo.get(i).get("deptor_log_info").equals("จ่ายหนี้")){%>
																						<td>
																								<span class="badge badge-pill badge-success">จ่ายหนี้</span>
																						</td>
																						<td>
																								<span class="badge badge-success w-100">
																									<i class="fas fa-minus"></i>
																									<%=depInfo.get(i).get("deptor_log_sum")%>
																								</span>
																						</td>
																					<%}else{%>
																						<td>
																								<span class="badge badge-pill badge-danger">
																									<%=depInfo.get(i).get("deptor_log_info")%>
																								</span>
																						</td>
																						<td>
																								<span class="badge badge-danger w-100">
																										<i class="fas fa-plus"></i>
																										<%=depInfo.get(i).get("deptor_log_sum")%>
																								</span>
																					</td>
																					<%}%>
																				</tr>
																				<%}%>
																			</tbody>
																		</table>
															</div>
												</div>
										</div>
								</div>
					</section>
				</div>
		</div>
	<script type="text/javascript">
	var path = $('#path').val();
	
	function editCheckBox(option){
		var length = document.getElementsByName('the_check').length;
		for(i=0;i<length;i++){
			document.getElementsByName('the_check')[i].checked = false;
		}
		document.getElementById(option).checked = true;	
		
		// 0 = เพิ่มหนี้ , 1 = จ่ายหนี้
		document.getElementById('edit_deptor_form').style.display = 'block';
		if(option=='check0'){
			console.log('เพิ่มหนี้');
			document.getElementById('sum_money').placeholder = 'เพิ่มหนี้ ฿';
			document.getElementById('ok_button').value = 0;
			document.getElementById('ok_button').className = 'btn btn-md btn-danger';
			document.getElementById('new_info').style.display = 'block';
		}else if(option=='check1'){
			console.log('จ่ายหนี้');
			document.getElementById('sum_money').placeholder = 'จ่ายหนี้ ฿';
			document.getElementById('ok_button').value = 1;
			document.getElementById('ok_button').className = 'btn btn-md btn-success';
			document.getElementById('new_info').style.display = 'none';

		}
	}
	//=============================================[ กำลังทำยังไม่เสร็จครับบบบบบบบบบบบบบบบบบบบบ ]=======================================================
		//1.เช็คช่องว่างก่อน
	$('#ok_button').click(function(){
		let event = '';
		let sumMoney = $('#sum_money').val();
		let newInfo = $('#new_info').val();
		if(document.getElementById('check0').checked==true){
			event = '+';
			if(sumMoney===''||newInfo===''){
				swOption.callError("ข้อมูลว่าง","กรุณากรอกข้อมูลให้ครบ");
			}else{
				addDepToDeptor('deptorId='+$('#deptor_id').val()
				+'&sumMoney='+sumMoney+'&newInfo='+newInfo,'addDepToDeptor');
			}
		}else if(document.getElementById('check1').checked==true){
			event = '-';
			addDepToDeptor('deptorId='+$('#deptor_id').val()
			+'&sumMoney='+sumMoney,'reducesDeptoDeptor');
		}
		console.log('click > '+event);


	});
	
	
	function addDepToDeptor(data,method){
		console.log(data);
		$.ajax({
			type:"POST",
			enctype:"multipart/form_data",
			url:path+"/deptor/"+method,
			data:data,
			timeout:600000,
			success:function(rs){
					let status = rs.status.split('_');
					if(status[0]=='success'){
							switch(status[1]){
									case 'plus':
												swOption.callSuccess("เพิ่มหนี้สำเร็จ","");
												setTimeout(()=>{location.reload();},1500);
												break;
									case 'delete': 
												if(status.length>=3){
													swOption.callSuccess("หนี้หมดแล้ว!","หนี้ทั้งหมดถูกชำระแล้ว");
													setTimeout(()=>{location.href = path+'/deptor/home';},1500);
												}else{
													swOption.callSuccess("จ่ายหนี้สำเร็จแล้ว","");
													setTimeout(()=>{location.reload();},1500);
												}
											   break;
									default :
												swOption.callError("เกิดข้อผิดพลาด","กรุณาลองอีกครั้ง");
												break;
							}
					}else{
						swOption.callError("เกิดข้อผิดพลาด","กรุณาลองอีกครั้ง");
					}
			}
			
		}); 
	}
	
	$("#dep_info").DataTable({
		  "scrollY":"500px",
	        "scrollCollapse": true,
	        "paging":false,
	        "searching": true,
	        "ordering": true,
	        "info":false,
	       language: { search: 'ค้นหารายการ', searchPlaceholder: "ค้นหารายการ..." },
  });
	</script>
</body>
</html>