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
			  				<h1 class='text-dark'>รายชื่อผู้ติดหนี้ <i class="fas fa-user-friends"></i></h1>
							<p class="text-primary">รายชื่อผู้ที่ค้างชำระหนี้ทั้งหมด</p>
			  				<div class="row">
			  						<div class="col">
			  								<div class="card">
														<div class="card-body">
																<center>
																<input type="checkbox" id="add_deptor_check" onclick ="addDeptorMenu()">&nbsp;&nbsp;<label for="add_deptor_check">เพิ่มผู้ติดหนี้</label>
																<div id="edit_deptor_form" style="display:none;">
																			<input type="text" id="deptor_name" placeholder="ชื่อผู้ติดหนี้" class="form-control" style="width:200px"><br>
																			<input type="number" id="sum_money" placeholder="ราคา ฿" class="form-control" style="width:200px">&nbsp;
																		  	<input type="text" id="new_info" placeholder="หมายเหตุ" class="form-control" style="width:200px;display:block;"><br>
																		  	<button type="button" id="ok_button" onClick="addDeptor()" class="btn btn-md btn-success">เพิ่ม</button><br>
																</div>
																<div id="divDataDeptor">
																<table class="table table-striped"  id="deptorTable">
																	<thead>
																		<tr>
																			<th>ลำดับ</th>
																			<th>ชื่อ</th>
																			<th>รวม</th>
																			<th>*</th>
																		</tr>
																	</thead>
																	<tbody id="deptor_data">
																	<%ArrayList<HashMap<String,Object>> depList = (ArrayList<HashMap<String,Object>>) request.getAttribute("deptorList"); 
																	int i = 0;
																	ArrayList<String> deptorName = new ArrayList<String>();
																	ArrayList<Integer> deptorId = new ArrayList<Integer>();
																	ArrayList<Double> deptorDep = new ArrayList<Double>();
																	for(i=0;i<depList.size();i++){
																	%>
																		<tr>
																			<td id="row<%=i+1%>"><%=i+1%></td>
																			<td class="text-primary">
																					<span class="badge badge-dark" style="width:100%;"><%=depList.get(i).get("deptor_name")%></span>
																			</td>
																			<td class="text-danger">
																					<span class="badge badge-pill badge-danger float-right">
																						<%=depList.get(i).get("deptor_sum")%>
																					</span>
																			</td>
																			<td style="text-align:right;">
																				<a href="${pageContext.request.contextPath}/deptor/deptor_info?deptor_id=<%=depList.get(i).get("deptor_id")%>">
																						<button class="btn btn-primary"><i class="fas fa-search-plus"></i></button>
																				</a>
																			</td>
																		</tr>
																		
																	<%
																		deptorId.add(Integer.parseInt(depList.get(i).get("deptor_id").toString()));
																		deptorName.add("\'"+depList.get(i).get("deptor_name").toString()+"\'");
																		deptorDep.add(Double.parseDouble(depList.get(i).get("deptor_sum").toString()));
																	}%>
																	</tbody>
																</table>
																</div>
														</div>
												</div>
			  						</div>
			  				</div>

							<div class="row">
									<div class="col">
											<%----------------- --%>
											<div class="card">
													<div class="card-header">
															<h1 class="text-primary">รายชื่อผู้ติดหนี้เฉลี่ย</h1>
															<p class="text-dark">รายชื่อผู้ที่ค้างชำระหนี้ทั้งหมด</p>
													</div>
													<div class="card-body">
															<canvas id="deptor_chart"></canvas>
													</div>
											</div>
											<%-------------------- --%>
									</div>
							</div>
					
						</section>
					</div>
				</div>
	<script src="${pageContext.request.contextPath}/content/js/zynColors.js"></script>
	
	<script type="text/javascript">
	var path = $('#path').val();
		$(document).ready(function(){
			getDataTable('#deptorTable');
		});
		
		function addDeptorMenu(){		
			if(document.getElementById('add_deptor_check').checked == true){
				display = "block";
			}else{
				display = "none";
			}
			document.getElementById('edit_deptor_form').style.display = display;
		}
		
		function addDeptor(){
			var newDeptorName = $('#deptor_name').val();
			var newSumDeptor = $('#sum_money').val();
			var newInfo = $('#new_info').val();
			if(newDeptorName==''||newSumDeptor==''||newInfo==''){
				swOption.callError("ข้อมูลว่าง","กรุณากรอกข้อมูลให้ครบ");
			}else{
				$.ajax({
					type:"POST",
					enctype:"multipart/form_data",
					url:path+"/deptor/add_deptor_form",
					data:"name="+newDeptorName+"&sum="+newSumDeptor+"&info="+newInfo,
					timeout:600000,
					success:function(rs){
						if(parseInt(rs.status)==1){
							swOption.callSuccess("เพิ่มแล้ว","เพิ่มผู้ติดหนี้แล้ว");
							$('#divDataDeptor').load(path+'/deptor/home #deptorTable');
							setTimeout(()=>{$('input[type="text"]').val("")},500);
							
						}else{
							swOption.callError("เกิดข้อผิดพลาด","กรุณาลองอีกครั้ง");
						}
					}
				});
					
			}
		}
		
	 var deptorChart = new Chart($('#deptor_chart'),{
		 type : 'doughnut',
		 data :{
			 labels:<%=deptorName%>,
			 datasets:[{
				 label:'หนี้ทั้งหมด',
				 data:<%=deptorDep%>,
			 	backgroundColor: zynColors.getArray(<%=deptorName.size()%>)
			 },{
				 label:'ID',
				 data:<%=deptorId%>,
			 	 hidden:true
			 }]
		 },
		 options:{
			 onClick:function(event,item){
					 let clickEvent = this.getElementAtEvent(event)[0];
					 console.log('\n')
					 let idDeptorOnChartClick = item[0]._chart.data.datasets[1].data[clickEvent._index];
					 location.href = path+"/deptor/deptor_info?deptor_id="+idDeptorOnChartClick;
			 }
		 }
	 });
		
		function getDataTable(tableId){
			$(tableId).DataTable({
				 "scrollY":"500px",
			        "scrollCollapse": true,
			        "paging":false,
			        "searching": true,
			        "info":false,
			        language: { search: 'ค้นหารายการ', searchPlaceholder: "ค้นหารายการ..." }
			});
		}
	</script>
</body>
</html>