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
			  				<h1 class="text-dark">จัดการสินค้า <i class="fas fa-box"></i></h1>
							<p class="text-primary">สินค้าทั้งหมดในร้าน</p>
							<div class='card'>
									<div class="card-body">
											<table id ="item" class='table table-striped'>
													<thead>
														<tr>
															<th>บาร์โค้ด</th>
															<th>ชื่อสินค้า</th>
															<th>ราคาซื้อ</th>
															<th>ราคาขาย</th>
															<th>คงเหลือ</th>
															<th></th>
														</tr>
													</thead>
												<tbody>
														<%
														ArrayList<HashMap<String,Object>> itemList = (ArrayList<HashMap<String,Object>>) request.getAttribute("itemList");
														for(int i=0;i<itemList.size();i++){%>
																<tr>
																		<td><span class="badge badge-dark" style="width:100%"><%=itemList.get(i).get("item_barcode")%></span></td>
																		<td><%=itemList.get(i).get("item_name")%></td>
																		<td ><span class="badge badge-pill badge-primary"><%=itemList.get(i).get("item_cost")%></span></td>
																		<td class="text-success"><span class="badge badge-pill badge-success"><%=itemList.get(i).get("item_price")%></span></td>
																		<%if(Integer.parseInt(itemList.get(i).get("item_stock").toString())<=0){%>
																				<td><p class="badge badge-danger" style="width:100%">สินค้าหมด!</p></td>
																		<% }else{%>
																				<td><span  class="badge badge-warning text-dark" style="width:100%"><%=itemList.get(i).get("item_stock")%></span></td>
																		<%}%>
																		<td class="float-right">
																			<button type="button" class="btn btn-outline-dark" data-toggle="modal" data-target="#editItem" style="border-radius:0px"
																					onclick="editItem(<%=itemList.get(i).get("item_id")%>,'<%=itemList.get(i).get("item_barcode")%>'
																					,'<%=itemList.get(i).get("item_name")%>',<%=itemList.get(i).get("item_cost")%>
																					,<%=itemList.get(i).get("item_price")%>,<%=itemList.get(i).get("item_stock")%>)" >
																			<i class="fas fa-search-plus"></i>
																			</button>
																			&nbsp;
																			<buton type="button" onclick="deleteItem(<%=itemList.get(i).get("item_id")%>)" class="btn btn-outline-danger" style="border-radius:0px">
																			  <i class="fas fa-trash-alt"></i>
																			 </buton>
																		</td>
																</tr>
														<%} %>
												</tbody>
												</table>
									</div>
							</div>
						</section>
					</div>
				</div>
								<%-- POPUP --%>
								 <div class="modal fade" id="editItem">
								   <div class="modal-dialog">
						      		<div class="modal-content">
						      		   <div class="modal-header bg-warning">
						      		   		 	<h4>แก้ไขสินค้า</h4>
						      		   		 	 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
										          	<span aria-hidden="true">&times;</span>
										        </button>
						      		   </div>
							      		 <div class="modal-body">
									      		 <input type="hidden" id="itemEditId" value ="">
											 	<label for="item_barcode">บาร์โค้ดสินค้า : </label>
												<input id="item_barcode" type="text" class="form-control">
												<label for="item_name">ชื่อสินค้า : </label>
												<input id="item_name" type="text" class="form-control">
												<label for="item_cost">ราคาส่ง : </label>
												<input id="item_cost" type="number" class="form-control text-primary">
												<label for="item_price">ราคาขาย : </label>
												<input id="item_price" type="number" class="form-control text-success">	
												<label for="item_stock">คงเหลือ : </label>
												<input id="item_stock" type="number" class="form-control text-danger">	
												<br>
										</div>
										<div class="modal-footer">
												<button id="editHere" type="submit" class="btn btn-warning" style="text-radius:0px">
											      		   				แก้ไข
											    </button>
												 <button type="button" class="btn btn-secondary" data-dismiss="modal">ยกเลิก</button>  		
									    </div>
								 	</div>
								 	</div>
								 </div>
							<%-- POPUP --%>
		
	<script type="text/javascript">
	var path = $('#path').val();
	 $(document).ready(function(){
		 $('#item').DataTable({
		        "scrollY":        "700px",
		        "scrollCollapse": true,
		        "paging":         false,
		        "info":false,
		        language: { search: 'ค้นหารายการ', searchPlaceholder: "ค้นหารายการ..." },
		    });
	 });
		
	 function editItem(itemId,barCode,name,cost,price,stock){
		 document.getElementById('itemEditId').value = itemId;
		document.getElementById('item_barcode').value = barCode;
		document.getElementById('item_name').value = name;
		document.getElementById('item_cost').value = cost;
		document.getElementById('item_price').value = price;
		document.getElementById('item_stock').value = stock;
	
	 }
	 
	 $('#editHere').click(function(){
		var id = document.getElementById('itemEditId').value;
		var barcode =	document.getElementById('item_barcode').value ;
		var name =	document.getElementById('item_name').value ;
		var cost =	document.getElementById('item_cost').value ;
		var price =	document.getElementById('item_price').value ;
		var stock =  document.getElementById('item_stock').value ; 
		if(id==''||barcode==''||name==''||cost==''||price==''||stock==''){
			swOption.callError("ข้อมูลว่าง","โปรดกรอกข้อมูลให้ครบ");
		}else{
			$.ajax({
				 type:"POST",
				 enctype:"multipart/form_data",
				 url:path+"/item/editItemHere",
				 data:"itemId="+id+"&barcode="+barcode+"&name="+name+"&cost="+cost+"&price="+price+"&stock="+stock,
				 timeout:60000,
				 success:function(rs){
					 if(rs.status=="success"&&rs.result>-1){
							swOption.callSuccess("แก้ไขสำเร็จ","");
						 	setTimeout(()=>{location.reload();},1500);
					 }else{
						 	swOption.callError("เกิดข้อผิดพลาด","โปรดลองใหม่อีกครั้ง");
					 }
				 }
			 }); 
		}		  
	 });
	 
	 function deleteItem(itemId){
	 	swOption.callConfirm("ต้องการลบสินค้า?","",()=>{
	 		$.ajax({
		 			type:"POST",
		 			enctype:"multipart/form_data",
		 			url:path+"/item/deleteItem",
		 			data:"itemId="+itemId,
		 			timeout:60000,
		 			success:function(rs){
		 				if(rs.status=='success'){
							swOption.callSuccess("ลบสำเร็จ","");
						 	setTimeout(()=>{location.reload();},1500);
		 				}else{
						 	swOption.callError("เกิดข้อผิดพลาด","โปรดลองใหม่อีกครั้ง");
		 				}
		 			}
	 		});
	 	});
ฃฃ
	 }
	</script>
</body>
</html>