<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	 <meta name="viewport" content="width=device-width, initial-scale=0.5">
	 
	 <link rel="stylesheet" href="${pageContext.request.contextPath}/content/css/font.css"> 
	 <link rel="stylesheet" href="${pageContext.request.contextPath}/content/css/bootstrap.min.css"> 
	 <link rel="stylesheet" href="${pageContext.request.contextPath}/content/css/jquery.dataTables.min.css"> 
	 <link rel="stylesheet" href="${pageContext.request.contextPath}/content/css/Chart.min.css"> 
	
	 <script src="${pageContext.request.contextPath}/content/js/Chart.min.js" ></script>
	 <script src="${pageContext.request.contextPath}/content/js/jquery-3.5.1.min.js"></script>
	 <script src="${pageContext.request.contextPath}/content/js/popper.min.js"></script>	
	 <script  src="${pageContext.request.contextPath}/content/js/bootstrap.min.js"></script>	
	 <script src="${pageContext.request.contextPath}/content/js/apexcharts.js" ></script>
	 <script  src="${pageContext.request.contextPath}/content/js/jquery.dataTables.min.js"></script>	
	 <script  src="${pageContext.request.contextPath}/content/js/fontawsome.js"></script>
	  <script  src="${pageContext.request.contextPath}/content/js/sweetalert.js"></script>
	 <script  src="${pageContext.request.contextPath}/content/js/sweetAlertOptions.js"></script>
	 <%//Template %>
	 <link rel="stylesheet" href="${pageContext.request.contextPath}/content/css/bootstrap-extend.css"> 
	<link rel="stylesheet" href="${pageContext.request.contextPath}/content/css/master_style.css"> 
	<link rel="stylesheet" href="${pageContext.request.contextPath}/content/css/skin-color.css"> 
	
	<%//Menu %>
	<input id="path" type="hidden" value="${pageContext.request.contextPath}">
  
 <aside class="main-sidebar" style="position:fixed;">
    <!-- sidebar-->
    <section class="sidebar" style="font-size:18px">
		<div class="user-profile">
			<div class="ulogo">
				 <a href="${pageCotext.request.contextPath }"  name="menu_bar">
				  <!-- logo for regular state and mobile devices -->
				  <h2>ระบบจัดการร้านค้า</h2>
				</a>
			</div>
        </div>
      
      <!-- sidebar menu-->
      <ul class="sidebar-menu" data-widget="tree">
      	<li class="header">
 				<span class="text-primary" style="font-size:20px">เมนู </span>  	
      	</li> 
		<li  id="li_index_page" >
				<a href="${pageContext.request.contextPath}/" id="index_page" name="menu_bar">
						<i class="fas fa-money-bill-wave text-white"></i>  
						ขายสินค้า
				</a>
        </li> 		
		<li  id="li_import_item">
			<a href="${pageContext.request.contextPath}/import_item/import_item" id="import_item"  name="menu_bar">
				<i class="fas fa-cart-arrow-down text-white"></i> 
				ซื้อสินค้าเพิ่ม
			</a>
		</li>
		<li id="li_import_item_log">
			<a href="${pageContext.request.contextPath}/import_item/import_item_log" id="import_item_log"  name="menu_bar">
				<i class="fas fa-history text-white"></i> 
				ประวัติการนำเข้า
			</a>
		</li>
		<li id="li_manage_item">
			<a href="${pageContext.request.contextPath}/item/manage_item" id="manage_item" name="menu_bar">
				<i class="fas fa-box text-white"></i>
				<span>จัดการสินค้า</span>&nbsp;
				<span class="badge badge-danger" id="item_out_stock"></span>
			</a>
		</li>
		<li id="li_manage">
				<a href="${pageContext.request.contextPath}/manage/sales_log?logSaleDate=0" id="manage" name="menu_bar">
					<i class="fas fa-chart-line text-white"></i> 
					ยอดขายสินค้า
				</a>
		</li>
		<li id="li_deptor">
				<a href="${pageContext.request.contextPath}/deptor/home" name="menu_bar" id="deptor" >
					<i class="fas fa-user-friends text-white"></i> 
					ผู้ติดหนี้
				</a>
		</li>
		<li id="li_import_out_item">
				<a href="${pageContext.request.contextPath}/item/add_item" name="menu_bar" id="import_out_item">
					<i class="fas fa-file-import text-white"></i> 
					นำสินค้าเข้าระบบ
				</a>
		</li>	
      </ul>
    </section>
  </aside>
	<script type="text/javascript">
		function setMenuPage(){
			var link = (""+location.href).split("/");
			$('a[name="menu_bar"]').attr('class','text-white');
			let menuName = '';
			switch(link[4]){
					case '':
							menuName = 'index_page';
							break;
					case 'import_item':
							menuName = (link[5]=='import_item')?'import_item':'import_item_log';
							break;
					case 'item':
						menuName = (link[5]=='manage_item')?'manage_item':'import_out_item';
						break;
					case 'manage':
						menuName = 'manage';
						break;
					case 'deptor':
						menuName = 'deptor';
						break;
					default :
						console.log('ไม่พบเมนู');
						break;
			}
			$("#"+menuName).attr('class','btn btn-success text-white');
			$("#li_"+menuName).attr('class','active');
		}
		
		let swOption = new SweetAlertOption();
		$('a').click(()=>{
			swOption.callLoading();
		})
		
		function getItemOutStock(){
			$.ajax({
				"type":"POST",
				"url":$('#path').val()+"/item/getCountOutStockItem",
				"data":""
			}).done((response)=>{
					$("#item_out_stock").html(response.COUNT);
			})
		}
		getItemOutStock();
		setMenuPage();
	</script>
 <style>
	   .table td,.table th{
	 		padding: 12px 15px;
	 		border-right:0.5px solid #DCDCDC;
	  }
	   .table td{
	 		padding: 12px 15px;
	  }
	  body{
	 		font-family: 'Prompt', sans-serif;
	 		background-color:#f4f5f9;
	 		font-size:15px;
	 		color:black;
	  }
	  .form-control
      {
          background-color:#E0E0E0;
          border:none;
          padding: 10px;
          box-shadow: 5px 5px 10px #C6C6C6;
      }
      .form-control:hover , .form-control:visited{
      		 background-color:#FFCE92;
      }
      .table thead th{
      		background-color:white;
      		color:black;
      		margin: 25px 0;
      		border-right:1px solid #E0E0E0;
      		border-top:1px solid #E0E0E0;
      }
      .content .card{
      		box-shadow: 5px 5px 10px #C6C6C6;
      		border:1px solid #e2e5ed;
      }
      .btn{
      		border-radius:60px;
      }
      aside{
      		background-color:#292b2c;
      }
      h1{
      		font-size:20px
      }
</style>