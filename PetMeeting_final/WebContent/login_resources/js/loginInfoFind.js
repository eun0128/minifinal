$(document).ready(function(){
	console.log("document ready----");
//	$("#frm2").hide();
//	$(".label_email").css("background-color","#eee");
	$("#frm1").hide();
	$(".nextBtn").hide();
	$(".label_pwd").css("background-color","#eee");
	
	// 비밀번호찾기 클릭시
	$(".label_pwd").on("click",function(){
		$("#frm1").hide();		
		$("#frm2").show();
		$(".label_email").css("background-color","#f9f9f9");
		$(".label_pwd").css("background-color","#eee");
	});
	
	
	// 이메일찾기 클릭시
	$(".label_email").on("click",function(){	
		$("#frm2").hide();
		$("#frm1").show();
		$(".label_email").css("background-color","#eee");
		$(".label_pwd").css("background-color","#f9f9f9");		
	});
	
	
});


$("#emailAuthSend_btn").on("click",function(){
	
	var frm2_email = $("#frm2_email");
	
	if( frm2_email.val() == ''){
		alert('이메일을 입력하세요.');
		$("#frm2_email").focus()
	}
	else{
		console.log(frm2_email.val());
		var email = frm2_email.val().replace(/ /gi, '');	//띄어쓰기 없애고 공백 처리
		
		$.ajax({
			url : "checkEmail.do",
			type : "post",
			data :"email=" + email,
			dataType : "text",
			async: false,
			success : function( data ) {
				if(data == "ok"){
					alert("일치하는 유저 정보가 없습니다.");					
					$("#frm2_email").focus();
				}
				if(data == "notok"){					
					console.log("가입된 이메일로 확인 email = " + email);
					
					// 이메일 인증코드 발송
					$.ajax({
						url : "emailAuth.do",
						method : "post",
						data : "inputEmail="+email,
						dataType: "text",
						success : function( msg ) {
							alert("입력한 이메일주소로 발송된 인증번호를 입력하세요.");				
							$("#emailAutNum").prop("disabled",false);
							$("#emailAutNum").focus();
							
						},fail : function(error) {
							alert("emailAuth error");
						}
					});
				}
			},
			error: function (error) {
	            alert(JSON.stringify(error));
	            alert("이메일 체크 실패...");
			}
		});	
	}
	
});

// 인증확인 버튼
$("#emailAuthCheck_btn").on("click",function(){
	// 입력한 인증코드 번호와 발송한 인증번호세션 비교값 가져오는 ajax실행
	$.ajax({
		url : "emailAuthCodeCheck.do",
		data : "authCodeUSer="+$("#emailAutNum").val(),
		dataType: "json",
		success : function( chk ) {
			if(chk == false){
				alert("인증번호가 일치하지 않습니다. 다시 확인하여 주십시오");
				$("#emailAutNum").focus();
				return false;
			}
			if(chk == true){
				alert("이메일 인증 완료!");				
				$("#emailAutNum").prop("disabled",true);
				$("#emailAuthCheck_btn").prop("disabled",true);
				$("#frm2_pwd").prop("disabled",false);
				$("#frm2_pwdCheck").prop("disabled",false);
				$("#frm2_pwd").focus();
				
			}					
		},
		fail : function(error) {
			alert("emailAuth error");
		}
	});
	
});


/* 비밀번호 입력 event */
$("#frm2_pwd").on({
	keydown: function(event){
		if ( $(this).val().length > 16 ) {
	        alert("비밀번호는 8 ~ 16 자리로 입력해주세요.");
	        $(this).val( $(this).val().substring(0, 16) );
	        $(this).val();			
		}
		if(event.keyCode == 32){	
			alert("특수문자는 !@#$%^*+=- 만 입력가능합니다");
			$("#frm2_pwd").val( $(this).replace(/ /gi, '') );
			$("#frm2_pwd").focus();
			return false;
		}
		if (event.keyCode == 9){	//탭키이동
			pwdCheck( $(this).val() );
		}
		return true;
	}
});	

/* 비밀번호 재입력 event */
$("#frm2_pwdCheck").on({
	focusout: function (event) {
		var pwd = $("#frm2_pwd").val();
		var pwdCheck = $("#frm2_pwdCheck").val();
		
		if(pwd == ''){
			$(".pwdCheckMsg").val("");
			pwd.focus();
			$(".nextBtn").hide();
			return false;
		}
		if( pwd != '' && pwdCheck == ''){
			$(".pwdCheckMsg").val("");
			$("#frm2_pwdCheck").focus();
			$(".nextBtn").hide();
			return false;
		}
		if( pwd != '' && pwd != pwdCheck ){
			$(".pwdCheckMsg").val("불일치");
			$(".pwdCheckMsg").css({"color":"red"});
			$(".nextBtn").hide();
		}
		
		else{
			$(".pwdCheckMsg").val("일치");
			$(".pwdCheckMsg").css({"color":"#85da46"});
			$(".nextBtn").show();
		}
		return false;	
	},
	click: function (event) {
		pwdCheck( pwd.val() );
	}
});

function pwdCheck(pw) {	
	 var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
	 //var pwd = $("#frm2_pwd");	
	 // pw:파라미터로 넘어온 새로운비번
	 // pwd:새로운 비번 입력input
	 
	 if(pw == ''){	 	
		 $("#frm2_pwd").attr("placeholder","비밀번호는 필수 입력사항입니다");
		$("#frm2_pwd").focus();
		$(".nextBtn").hide();
		return false;
	 }
	 if (!check.test(pw)){
		 if (pw.length < 8 || pw.length > 16 ) {
	        alert("비밀번호는 8 ~ 16 자리로 입력해주세요.");
	        $("#frm2_pwd").val( pw.substring(0, 16) );
	        $("#frm2_pwd").focus();
	        $(".nextBtn").hide();
	        return false;
		 }
		 else{
			 alert("비밀번호는 영문, 숫자, 특수문자(!@#$%^*+=-)의 조합으로 입력해주세요.");
			 $("#frm2_pwd").focus();
			 $(".nextBtn").hide();
		     return false;
		 }
	 }
	 return true;
}

/* 비밀번호 변경하기 클릭 */
$(".nextBtn").on({
	click: function (event) {		
		$.ajax({
			url : "passwordUpdate.do",
			data : "email="+$("#frm2_email").val()+"&password="+$("#frm2_pwd").val(),
			dataType: "text",
			success : function( data ) {
				alert("성공적으로 비밀번호가 변경되었습니다.");
				self.close();
			},
			fail : function(error) {
				alert("emailAuth error");
			}
		});
	}
});








