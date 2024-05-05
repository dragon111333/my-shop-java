<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ระบบจัดการร้าน</title>
</head>
<body >
<jsp:include page="/include/header.jsp"/>
  <div class="content-wrapper">
			  <div class="container-full">
			  		<section class="content">
			  			<div class="row">
			  				<div class="col">
			  						<h1 class='text-success'>ขายสินค้า</h1>
									<p class="text-dark">หน้าขายสินค้าให้ลูกค้า</p>
			  				</div>
			  			</div>
						
						<div class="row">
								<div class="col">
										<div class='card' id="views1">
											<div class="card-body" style="text-align:left;">
												<label for="item_barcode" style="font-size:30px">บาร์โค้ด <i class="fas fa-barcode"></i> : </label>
												<input id="item_barcode" type="text" class="form-control" placeholder="บาร์โค้ดสินค้า">
												<br>
											</div>
										</div>
								</div>
						</div>
						
						<br>
						
						<div class="row">
								<div class="col">
										<div class='card' id="views2">
												<div class="card-body">
													<h1 class='border-bottom border- pb-2  text-primary' >รายการสินค้า<i class="fas fa-shopping-cart"></i></h1>
													<p class="text-info">สรุปการขาย</p>
													<table class="table table-striped">
														<thead>
																<tr>
																	<th>บาร์โค้ด</th>
																	<th>ชื่อ</th>
																	<th>ราคา</th>
																	<th style="width:5px"></th>
																</tr>
														</thead>
														<tbody id="allItem">
														</tbody>
														<tr style="font-size:18px"><td colspan=4 style="text-align:right;" class="bg-success">
															<span class="text-white">รวม : </span>
															<span id="sum" class="badge badge-pill badge-warning text-dark" style="color:#FFC93A;font-size:24px">0.0</span>
															<span class="text-white">บาท</span></td>
														</tr>
													</table>
												</div>
										</div>
								</div>
						</div>
			  		<%//-----------------------------SUCCESS--------------------------------- %>
					<div class="row">
							<div class="col" style="text-align:center;">
													<center>
										  			<div  id="successCard" style="width:80%;display:none;" class="card">
										  					<div class="card-body">
										  							<button class="btn  btn-success btn-md btn-block" >ขายสำเร็จ!</button>
																	<div  class='my-3 p-3 bg-white rounded box-shadow' >
															        <h2  class='border-bottom border- pb-2 mb-0'>คิดเงินทอน</h2>
															        <br>
															       <span  class='badge badge-pill badge-dark'><span class="badge badge-warning text-dark" style="width:20px">⏎</span> คิดเงินทอน</span>
															        <span class='badge badge-pill badge-dark'><span class="badge badge-warning text-dark" style="width:20px">␣</span> เสร็จสิ้น</span>
															        <br><br>
															        <table class="table">
																        <tr>
																		        <td class="bg-secondary">
																		        	<h5>จำนวนเงินลูกค้า&nbsp;&nbsp;</h5>
																		        </td>
																		        <td>
																		        		<input type="number" id="emp" class="form-control" placeholder="จ่าย(บาท)" style="width:100%">
																		      	 </td>
																      	 </tr>
																      	 <tr>
																	      	 		<td class="bg-success text-white">
																	      	 				<span>รวม</span>
																	      	 		</td>
																	      	 		<td class="bg-secondary">
																	      	 			    <h1 id="sumAll"  style="font-size:25px" class="text-dark">฿</h1>
																	      	 		</td>
																      	 </tr>
																      	 <tr>
																      	 		<td class="bg-warning text-dark">
																      	 				<span>เงินทอน</span>
																      	 		</td>
																      	 		<td class="bg-secondary">
																      	 				<h1 id="changeMoney" style="font-size:25px" class="text-danger">฿</h1>
																      	 		</td>
																      	 </tr>
															        </table>
															
														    </div>
										  					</div>
										  			</div>
							</div>
					</div>
				<%//---------------------------------------------------------------------------- %>
				</section>
</div>
</div>
<script type="text/javascript">
 var path = $('#path').val();
 var itemRank = 0;
 var thisSumPrice = 0.0;
	$(document).ready(function(){
		document.getElementById('item_barcode').select();
	});
	
	//เพิ่มสินค้า---------------
	$('#item_barcode').keypress(function(){
				var barcode = $('#item_barcode').val();
				var k = event.keyCode;
				if(k==13){
					$.ajax({
						type:"POST",
						enctype:"multipart/form_data",
						url:path+"/findItemByBarcode",
						data:"barcode="+barcode,
						timeout:60000,
						success:function(rs){
							if(rs.result.length>0){
								itemRank++;
								 $('#allItem').append('<tr style="font-size:20px" id="row'+itemRank+'" >'
									 +'<td><span class="badge badge-dark" style="width:100%">'+barcode+'</span></td>'
									 +'<td>'+rs.result[1]+'<input type="hidden" name="itemId_inTable" value="'+rs.result[0]+'"></td>'
									 +'<td><span class="badge badge-pill badge-success" name="price">'+rs.result[3]+'</span></td>'
									 +'<td><button class="btn btn-danger" onclick="cancle('+itemRank+')"><i class="fas fa-trash-alt"></i></button></td>'
								 +'</tr>');
								 $('#item_barcode').val('');
								 	calItemPrice();
							}else{
								swOption.callError("ไม่พบสินค้า","กรุณาลองใหม่อีกครั้ง");
							 $('#item_barcode').val('');
							}
						}
		
					});
		}else if(k==32){
			if(calItemPrice()<=0){
				swOption.callError("ไม่ได้เลือกสินค้า","กรุณาเลือกสินค้า");
			}else{
					createBill();
					$('#sumAll').html('รวม : '+parseFloat(thisSumPrice)+' ฿');
					document.getElementById('views1').style.display ="none";
					document.getElementById('views2').style.display ="none";
					document.getElementById('successCard').style.display = "block";
					document.getElementById('changeMoney').scrollIntoView();
					document.getElementById('emp').select();	
			}
	
		}
	});
	//---------------------------------------------
	
	function cancle(idRank){
		$('#row'+idRank).remove();
		calItemPrice();
	}
	
	//คิดเงินทอน
	$('#emp').keypress(function(){
		var key = event.keyCode;
		if(key==13){
			var empM =  $('#emp').val();
			var change = empM-parseFloat(thisSumPrice);
			$('#changeMoney').html(change+' ฿');
		}else if(key==32){
			location.reload();
		}
	});
	//รวมเงิน
	function calItemPrice(){
		 var numItem = document.getElementsByName('price').length;
		 var sumPrice = 0.0;
		if(numItem>0){
			 for(i=0;i<numItem;i++){
					var oneItemPrice = document.getElementsByName('price')[i].innerHTML;
					sumPrice = sumPrice + parseFloat(oneItemPrice);
				 }
			 thisSumPrice = sumPrice;
		}else{
			
		}
		$('#sum').html(sumPrice);
		document.getElementById('sum').scrollIntoView();
		return numItem;
	}
	//---------- ทำBill -----------
	function createBill(){
		$.ajax({
					type:"POST",
					enctype:"multipart/form_data",
					url:path+"/addBill",
					data:"billSum="+thisSumPrice+"&addType=0",
					timeout:600000,
					success:function(rs){
						if(rs.result>-1){
									var itemLength = document.getElementsByName('itemId_inTable').length;
									for(i=0;i<itemLength;i++){
												 var itemId = document.getElementsByName('itemId_inTable')[i].value;
												$.ajax({
															type:"POST",
															enctype:"multipart/form_data",
															url:path+"/addBill",
															data:"billSum="+thisSumPrice+"&addType=1"+"&billId="+rs.result+"&itemId="+itemId,
															timeout:600000,
															success:function(rs2){
																//-----------SUCCESS------------
															}
												});
									}
		
						}else{
									console.log('เพิ่มบิลล้มเหลว');
						}
					}
		});
	}
</script>			
</body>
</html>