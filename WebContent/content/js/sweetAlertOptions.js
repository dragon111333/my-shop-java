class SweetAlertOption{
		callLoading(){
					let timerInterval
					Swal.fire({
					  title: 'กำลังโหลด',
					  html: 'กำลังดึงข้อมูล.',
					  timer: 10000,
					  didOpen: () => {
					    Swal.showLoading()
					  },
					  willClose: () => {
					    clearInterval(timerInterval)
					  }
					})
		}
		callError(title,desc){
				Swal.fire({
					  icon: 'error',
					  title: title,
					  text:desc,
				})
		}
		callSuccess(title,desc){
				Swal.fire({
					  icon:"success",
					  title:title,
					  text:desc,
					  showConfirmButton: true,
					  timer: 1500
				})
		}
		
		callConfirm(title,desc,doItFunction){
				Swal.fire({
					  title: title,
					  text: desc,
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#3085d6',
					  cancelButtonColor: '#d33',
					  confirmButtonText: "ใช่",
					  cancelButtonText:"ยกเลิก"
			}).then((result) => {
					  if (result.isConfirmed) {
					   		 doItFunction();
					  }
			})
		}
}