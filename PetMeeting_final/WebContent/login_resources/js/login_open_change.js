$("document").ready(function () {
    
	var taget_email = $("input[name=email]", document.loginform);
	taget_email.focus();

	$("#login").click(function(e){
		//alert("loginBtn click");
		
		var parent = $(this).parent().parent();
		
		if(parent.hasClass("slide-up") === false) {
			//alert("slide-up 클래스 미적용");
			parent.addClass("slide-up");
		}else{
			//alert("slide-up 클래스적용중");
			$("#signup").parent().addClass("slide-up");			
			parent.removeClass("slide-up");
			
		}
	});
	
	$("#signup").click(function(e){
		//alert("signup click");
		
		var parent = $(this).parent();
		 
		if(parent.hasClass("slide-up") === false) {
			//alert("회원가입 폼 닫힘");
			parent.addClass("slide-up");
		}
		else{
			//alert("회원가입 폼 열림");
			$("#login").parent().parent().addClass("slide-up");
			parent.removeClass("slide-up");
		}
	});
	
});


