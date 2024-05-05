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
							<h1 class="text-dark">ประวัติการนำเข้าสินค้า <i class="fas fa-history"></i></h1>
							<p class="text-primary">ประวัติการซื้อสินค้าเข้าร้าน</p>
							<center>
							<div class="card">
									<div class="card-body">
											 <table>
													 <tr>
													 	<td>
													 	 <label >ดูตามวัน&nbsp;</label>
													 	</td>
													   <td>
													    <input type="date" class="form-control" id="date" placeholder="วัน/เดือน/ปี">
													   </td>
													   <td>
													   <button type="submit" class="btn btn-primary" id="searchDate">ค้นหา</button>
													   </td>
													  </tr>
													</table>
													<br>
													<table class="table table-striped" id="theTable">
													<thead><tr>
														<th>บาร์โค้ดสินค้า</th><th>ชื่อสินค้า</th><th>นำเข้า(ชิ้น)</th><th>เวลา</th>
														</tr></thead>
													<tbody id = "dataIn">
													<%ArrayList<HashMap<String,Object>> list = (ArrayList<HashMap<String,Object>>) request.getAttribute("importLog"); 
													 for(int i = 0;i<list.size();i++){%>
														 <tr>
														 		<td>
														 				<span class="badge badge-dark" style="width:100%"><%=list.get(i).get("item_barcode") %></span>
														 		</td>
														 		<td><%=list.get(i).get("item_name")%></td>
														 		<td>
														 				<span class="badge badge-pill badge-success">+<%=list.get(i).get("import_sum")%></span>
														 		</td>
														 		<td class="text-primary">
														 				<span class="badge badge-warning text-dark"><%=list.get(i).get("date")%></span>
														 		</td>
														 </tr>
													 <%}%>
											</tbody>
											</table>
									</div>
							</div>
						</section>
					</div>
				</div>
	<script type="text/javascript">
	var path = $('#path').val();
	
	$(document).ready(function(){
		$('#theTable').DataTable({	
			"scrollY":        "500px",
	        "scrollCollapse": true,
	        "paging":         false,
	        "info":     false,
	        language: { search: 'ค้นหารายการ', searchPlaceholder: "ค้นหารายการ..." },
	        }
			);
	});
		$('#searchDate').click(function(){
			var time = $('#date').val();
			console.log(time);
			if(time==""){
				swOption.callError("โปรดระบุวันที่","");
			}else{
				$.ajax({
					type:"POST",
					enctype:"multipart/form_data",
					url:path+"/import_item/findImportLogByDate",
					data:"time="+time,
					timeout:600000,
					success:function(rs){
						if(rs.status=='success'){
							$('#dataIn').empty();
							rs.result.forEach((item)=>{
									$('#dataIn').append(	'<tr>'
																	 +'		<td>'
																	 +'				<span class="badge badge-dark" style="width:100%">'+item[1]+'</span>'
																	 +'		</td>'
																	 +'		<td>'+item[2]+'</td>'
																	 +'		<td>'
																	 +'				<span class="badge badge-pill badge-success">+'+item[3]+'</span>'
																	 +'		</td>'
																	 +'		<td class="text-primary">'
																	 +'				<span class="badge badge-warning text-dark">'+item[4]+'</span>'
																	 +'		</td>'
																 +'</tr>');
							});
						}
					}
				});
			}
		});
	</script>
</body>
</html>