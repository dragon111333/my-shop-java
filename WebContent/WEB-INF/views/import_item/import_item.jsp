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
			  				<h1 class="text-dark">นำเข้าสินค้า <i class="fas fa-cart-arrow-down"></i></h1>
							<p class="text-primary">ซื้อสินค้าเข้าร้าน</p>
							<center>
							<div class="row">
									<div class="col col-12">
												<div class="card">
														<div class="card-body">
																	<div style="text-align:left;width:50%;">
																		<input type="hidden" id="item_id" value="" >
																		<div> <% // ------row------- %>
																			<div class="row">
																					<div class="col">
																							<label>บาร์โค้ดสินค้า : </label>
																					</div>
																			</div>
																			<div class="row">
																					<div class="col col-10">
																							<input id="item_barcode" type="text" onKeyup="check()" class="form-control" placeholder="ใส่บาร์โค้ดสินค้า(ค้นหาอัตโนมัติ)">
																					</div>
																					<div class="col col-2">
																							<button type="button" class="btn btn-dark" style="border-radius:30px;" onClick="setItemData()">
																									<i class="fas fa-search"></i>
																							</button>
																					</div>
																			</div>
																		</div>
																		<br>
																		<table class="table">
																				<thead>
																						<tr>
																								<th class="bg-secondary" style="width:30%">ชื่อสินค้า </th>
																								<th><span id="item_name">#</span></th>
																						</tr>
																						<tr>
																								<th class="bg-secondary" style="width:30%">ราคาส่ง</th>
																								<th><span id="item_cost" class="badge badge-pill badge-primary">#</span></th>
																						</tr>
																						<tr>
																								<th class="bg-secondary" style="width:30%">ราคาขาย </th>
																								<th><span id="item_price"  class="badge badge-pill badge-success">#</span></th>
																						</tr>
																						<tr>
																								<th class="bg-secondary" style="width:30%">คงเหลือ </th>
																								<th><span id="item_in_stock"  class="badge badge-dark">#</span></th>
																						</tr>
																				</thead>
																		</table>
																				<label for="item_price">ทั้งหมด(ชิ้น) : </label>
																		<input id="item_addStock" type="number"  class="form-control text-danger" placeholder="จำนวน">
																	</div>
														</div>
														<div class="card-footer">
																	<button id ="okButton" type="button" class="btn btn-primary btn-md" style="width:50%">ยืนยัน</button>
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
		

		function check(){
			var k = event.keyCode;
			if(k==13){
				setItemData();
			}
		}
		
		function setItemData(){
				var barcode = $('#item_barcode').val();
				$.ajax({
					type:"POST",
					url:path+"/import_item/findItemByBarcode",
					data:"barcode="+barcode,
					timeout:60000,
					success:function(result){
							if(result.item_id!=null){
								$('#item_id').val(result.item_id);
								 $('#item_name').html(result.item_name);
								 $('#item_cost').html(result.item_cost);
								 $('#item_price').html(result.item_price);
								 $("#item_in_stock").html(result.item_stock)
								 document.getElementById('item_addStock').select();
							}else{
								swOption.callError("ไม่พบสินค้า","");						
							}
					}
	
				});
		}
		
		$('#okButton').click(function(){
			 var itemId = $('#item_id').val();
			 var stock = $('#item_addStock').val();
			 if(stock==''){
				swOption.callError("กรุณากรอกจำนวน","กรุณากรอกจำนวนสินค้า");
			 }else{
				 $.ajax({
						type:"POST",
						enctype:"multipart/form_data",
						url:path+"/import_item/successImport",
						data:"itemId="+itemId+"&stock="+stock,
						timeout:60000,
						success:function(rs){
							if(rs.status=="success"){
								swOption.callSuccess("นำเข้าแล้ว","");
								setTimeout(()=>{location.reload();},1500);
							}else{
								swOption.callError("เกิดข้อผิดพลาด","กรุณาลองอีกครั้ง");							
							}
						}

					});
			 }
		});
		
	</script>
</body>
</html>