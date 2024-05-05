<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ระบบจัดการร้าน</title>
</head>
<body>
	<jsp:include page="/include/header.jsp"/>

	  <div class="content-wrapper">
			  <div class="container-full">
			  		<section class="content">
			  				<h1 class='text-dark'>เพิ่มสินค้าเข้าสู่ระบบ <i class="fas fa-file-import"></i></h1>
							<p class="text-info">เพิ่มข้อมูลสินค้าใหม่เข้าระบบจัดการ</p>
							<div class="row" >
									<div class="col col-12">
												<div class="card">
															<center>
															<div class="card-body" style="width:30%;text-align:left;" >
																	<label for="item_barcode">บาร์โค้ดสินค้า : </label>
																		<input id="item_barcode" type="text" class="form-control"  placeholder="บาร์โค้ดสินค้า">
																	<label for="item_name">ชื่อสินค้า : </label>
																		<input id="item_name" type="text" class="form-control" placeholder="ชื่อสินค้า">
																	<label for="item_cost">ราคาส่ง : </label>
																		<input id="item_cost" type="number" class="form-control text-primary" placeholder="ราคาส่ง(฿)">
																	<label for="item_price">ราคาขาย : </label>
																		<input id="item_price" type="number" class="form-control text-success"  placeholder="ราคาขาย(฿)">	
																	<br>
															</div>
															<div class="card-footer" style="width:30%">
																<button id="okButton" type="button" class="btn btn-primary btn-md btn-block">เพิ่ม</button>
															</div>
												</div>
									</div>
							</div>
						</section>
					</div>
				</div>
						
	<script type="text/javascript">
	var path = $('#path').val();
		$(document).ready(function(){
			document.getElementById('item_barcode').select();
		});
		
		$('#okButton').click(function(e){
			e.preventDefault();
			var barcode = $('#item_barcode').val();
			var name = $('#item_name').val();
			var cost = $('#item_cost').val();
			var price = $('#item_price').val();
			if(barcode==''||name==''||cost==''||price==''){
				swOption.callError("โปรดกรอกข้อมูลให้ครบ","");
			}else{
				checkDublicItem(barcode,name,cost,price);
			}
			
		});
		
		function checkDublicItem(barcode,name,cost,price){
			$.ajax({
				type:"POST",
				enctype:"multipart/formdata",
				url:path+"/item/checkDublicItem",
				data:"barcode="+barcode+"&name="+name,
				timeout:600000,
				success:function(rs){
			 		if(parseInt(rs)==1){
						addItemIntoSystem(barcode,name,cost,price);
					}else{
						swOption.callError("ชื่อสินค้าหรือบาร์โค้ดซ้ำ","");
					} 
				}
			});
		}
		
		function addItemIntoSystem(barcode,name,cost,price){
			 $.ajax({
				 type:"POST",
				 enctype:"multipart/form_data",
				 url:path+"/item/add_item_this",
				 data:"barcode="+barcode+"&itemName="+name+"&cost="+cost+"&price="+price,
				 timeout:60000,
				 success:function(rs){
					 if(rs.status=="success"){
							swOption.callSuccess("เพิ่มสินค้าใหม่สำเร็จ","");
							setTimeout(()=>{location.reload();},1500);
					 }
				 }
			 });
		}

	</script>
</body>
</html>