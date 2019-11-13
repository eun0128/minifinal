$(function() {
	
	
	// 회원가입 input 제어 -----------------------------------------------------------------
	var account_email = $("input[name=email]", document.accountform);
	var account_pwd = $("input[name=pwd]", document.accountform);
	var account_nickname = $("input[name=nickname]", document.accountform);
	var account_name = $("input[name='name']", document.accountform);
	var address = $("input[name=address]", document.accountform);
	var address_detail = $("input[name=address_detail]", document.accountform);
	var phone = $("input[name=phone]", document.accountform);
	var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	
	
	
	$(document).on('change', function() {
		if( $(".pwd_input").val() != account_pwd.val() 
				|| $(".pwd_input").val().length != account_pwd.val().length ){
			$(".pwdCheckMsg").val("불일치");
			$(".pwdCheckMsg").css({"color":"red"});
			
			$("#account-btn").css("background-color","#5a5a5a");
			$("#account-btn").prop("disabled",true);
		}

		if( $(".pwdCheckMsg").val() != "일치"
			||$("#emailCheck-Btn").text() != "인증완료" 
			||$("#nicknameCheck-Btn").text() != "사용가능" 
			|| account_pwd.val().length < 1 
			|| account_name.val().length < 1
			|| address.val().length < 1
			|| phone.val().length  < 12 ) {
				$("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
		}

		else{
			$("#account-btn").css("background-color","#585e7d");
			$("#account-btn").prop("disabled", false);
		}
		
	});
	/**/
	// ---------------------- tab키 제어 (id저장 체크박스로 포커스 이동방지)
	phone.on({
		keydown: function (e) {
					
			if (e.keyCode == 9){
				if( $("#account-btn").prop("disabled") == true || phone.val() == '' ){
					return false;
				}
				else{	
					return true;
				}
			}
			else{
				if($(this).val().length < 12){
					$("#account-btn").css("background-color","#5a5a5a");
					$("#account-btn").prop("disabled",true);
				}
				if($(this).val().length >= 12){
					if($(".pwdCheckMsg").val() == "일치"
						&&$("#emailCheck-Btn").text() == "인증완료" 
							&&$("#nicknameCheck-Btn").text() == "사용가능" 
							&& account_pwd.val() !='' 
							&& account_name.val() !=''
							&& address.val() !=''){
						$("#account-btn").css("background-color","#585e7d");
						$("#account-btn").prop("disabled", false);
					}
				}
			}
		}
	});
	
	$("#account-btn").on({
		keydown: function (e) { if (e.keyCode == 9)	return false; }
	});
	// ---------------------- tab키 제어 end

	/* 이메일 event */
	account_email.on({
		keyup: function (event) {
			if( !getMail.test( account_email.val() ) ){ 	// 정규식 위배
				if( account_email.val() == ""){ 
					return false;
				}
				account_email.css({"font-weight":"initial","color":"initial"});
				$("#emailCheck-Btn").text("이메일인증");
				$("#emailCheck-Btn").css({"color":"#ccc6c6"});
				$("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
				
				if($("#emailCheck-Btn").prop("disabled",false)){
					$("#emailCheck-Btn").prop("disabled",true);
				}		
				
			}
			else{	// 정규식 통
				$("#emailCheck-Btn").css({"color":"#585e7d"});
				if($("#emailCheck-Btn").prop("disabled",true)){
					$("#emailCheck-Btn").prop("disabled",false);
				}
				
			}	
		},
		keydown: function(event){
			if( account_email.val() == "") {
				account_email.addClass("inputcheck");
				account_email.attr("placeholder","email은 필수 입력 사항입니다");
				account_email.focus();
			}
			if (event.keyCode == 9){	//탭키이동
				if( !getMail.test( account_email.val() ) ) {
					if( account_email.val() == ""){
						return false;
					}
					alert('이메일 주소를 형식에 맞게 기입하세요. 예)userid@sitename.com');
					account_email.focus();
					return false;
				}
			}
		},
		click: function(event) {
			if( account_email.prop("readonly") == true ) {
				var result = confirm("인증할 메일을 변경하시겠습니까?");
				if(result){
					account_email.prop("readonly",false);
					$("#emailCheck-Btn").text("이메일인증");
					$("#emailCheck-Btn").prop("disabled",false);
					$("#emailCheck-Btn").css({"color":"#ccc6c6"});
					account_email.focus();
					
					$("#account-btn").css("background-color","#5a5a5a");
					$("#account-btn").prop("disabled",true);
					
					return false;
				}	
			}
		}
	});


	/* 이메일인증 버튼 event */
	$("#emailCheck-Btn").on({
		focus: function (event) {
			$("#emailCheck-Btn").css({"background-color":"#e8e8e8","color":"#000"});
			return false;
		},
		focusout: function (event) {
			$("#emailCheck-Btn").css({"background-color":"#fff","color":"#ccc6c6"});
			return false;	
		},
		keydown:function(e) {
		    if (e.keyCode == 13) {
		    	$("#emailCheck-Btn").css({"background-color":"#1d1616bf","color":"#fff"});
		    }
		},
		keyup:function(e) {
		    if (e.keyCode == 13) {
		    	$("#emailCheck-Btn").css({"background-color":"#fff","color":"#ccc6c6"});
		    }
		},
		click: function(e) {
			checkEmail();
		}	
	});
	
	function checkEmail(){	// 중복체크 후 이메일인증발송
		var email = account_email.val().replace(/ /gi, '');	//띄어쓰기 없애고 공백 처리
		
		$.ajax({
			url : "checkEmail.do",
			type : "post",
			data :"email=" + email,
			dataType : "text",
			async: false,
			success : function( data ) {
				if(data == "ok"){
					console.log("이메일인증email = " + email);
					
					// 이메일 인증코드 발송
					$.ajax({
						url : "emailAuth.do",
						method : "post",
						data : "inputEmail="+email,
						dataType: "text",
						success : function( msg ) {
							alert("입력한 이메일로 인증번호가 발송되었습니다.");
							//1.이메일 인증번호 입력란 display show
							$(".authCode_input").removeClass("displayis");
							$(".checked_input").removeClass("displayis");
							$(".authCode_input").focus();
							
						},fail : function(error) {
							alert("emailAuth error");
						}
					});
				}
				if(data == "notok"){
					alert("이미 가입된 계정입니다.");
				}
			},
			error: function (error) {
	            alert(JSON.stringify(error));
	            alert("이메일 체크 실패...");
			}
		});	
	}
	
	// 인증번호 확인 버튼
	$("#authCodeCheck-Btn").on({
		click: function(){	
			// 입력한 인증코드 번호와 발송한 인증번호세션 비교값 가져오는 ajax실행
			$.ajax({
				url : "emailAuthCodeCheck.do",
				data : "authCodeUSer="+$(".authCode_input").val(),
				dataType: "json",
				success : function( chk ) {
					if(chk == false){
						alert("인증번호 일치하지 않습니다. 다시 확인하여 주십시오");
						return false;
					}
					if(chk == true){
						alert("이메일 인증 완료!");
						//이메일 인증번호 입력란 display none
						$(".authCode_input").val('');
						$(".authCode_input").addClass("displayis");
						$("#authCodeCheck-Btn").addClass("displayis");
						$("#emailCheck-Btn").text("인증완료");
						$("#emailCheck-Btn").css({"color":"#85da46"});
						$("#emailCheck-Btn").prop("disabled",true);
						account_email.css({"color":"initial"});
						account_email.prop("readonly",true);
						account_pwd.focus();
						
						if($(".pwdCheckMsg").val() == "일치"
								&&$("#nicknameCheck-Btn").text() == "사용가능" 
								&& account_pwd.val().length !='' 
								&& account_name.val().length !=''
								&& address.val().length !=''){
							$("#account-btn").css("background-color","#585e7d");
							$("#account-btn").prop("disabled", false);
						}
					}					
				},
				fail : function(error) {
					alert("emailAuth error");
				}
			});
		}
	});
	
	
	function pwdCheck(pw) {
		 var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
		 
		 if(pw == ''){
		 	account_pwd.addClass("inputcheck");
			account_pwd.attr("placeholder","비밀번호는 필수 입력사항입니다");
			account_pwd.focus();
			
			$("#account-btn").css("background-color","#5a5a5a");
			$("#account-btn").prop("disabled",true);
			
			return false;
		 }
		 if (!check.test(pw)){
			 if (pw.length < 8 || pw.length > 16 ) {
		        alert("비밀번호는 8 ~ 16 자리로 입력해주세요.");
		        account_pwd.val( pw.substring(0, 16) );
		        account_pwd.focus();
		        
		        $("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
				
		        return false;
			 }
			 else{
				 alert("비밀번호는 영문, 숫자, 특수문자(!@#$%^*+=-)의 조합으로 입력해주세요.");
				 account_pwd.focus();
				 
				 $("#account-btn").css("background-color","#5a5a5a");
				 $("#account-btn").prop("disabled",true);
					
			     return false;
			 }
		 }
		 return true;
	}

	/* 비밀번호 입력 event */
	account_pwd.on({
		keydown: function(event){
			if ( $(this).val().length > 16 ) {
		        alert("비밀번호는 8 ~ 16 자리로 입력해주세요.");
		        $(this).val( $(this).val().substring(0, 16) );
		        
		        $("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
				
			}
			if(event.keyCode == 32){	
				alert("특수문자는 !@#$%^*+=- 만 입력가능합니다");
				var v = account_pwd.val().replace(/ /gi, '');
				account_pwd.val(v);
				account_pwd.focus();
				return false;
			}
			if (event.keyCode == 9){	//탭키이동
				pwdCheck( $(this).val() );
			}
			return true;
		}
	});	
	
	/* 비밀번호 재입력 event */
	$(".pwd_input").on({
		focusout: function (event) {
			var pwd = account_pwd.val();
			var pwd2 = $(".pwd_input").val();
			if(pwd == ''){
				$(".pwdCheckMsg").val("");
				account_pwd.focus();
				$("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
				
				return false;
			}
			if( pwd != '' &&pwd2 == ''){
				$(".pwdCheckMsg").val("");
				account_pwd.focus();
				return false;
			}
			if( pwd != '' && pwd != pwd2 ){
				$(".pwdCheckMsg").val("불일치");
				$(".pwdCheckMsg").css({"color":"red"});
				
				$("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
			}
			
			else{
				$(".pwdCheckMsg").val("일치");
				$(".pwdCheckMsg").css({"color":"#85da46"});
				
				if( $("#emailCheck-Btn").text() == "인증완료" 
						&& $("#nicknameCheck-Btn").text() == "사용가능" 
						&& account_pwd.val().length !='' 
						&& account_name.val().length !=''
						&& address.val().length !=''){
					$("#account-btn").css("background-color","#585e7d");
					$("#account-btn").prop("disabled", false);
				}
			}
			return false;	
		},
		click: function (event) {
			pwdCheck( account_pwd.val() );
		}
	});
	
	/* 닉네임 입력 event */
	account_nickname.on({
		keydown: function(event){
			if(event.keyCode == 32){
				alert("닉네임은 한,영,숫자, 특수문자 -,_만 입력가능 합니다.");
				var v = $(this).val().replace(/ /gi, '');
				$(this).val(v);
				$(this).focus();
				
				$("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
				
				return false;
			}
			if (event.keyCode == 9){	//탭키이동
				var check = /[^가-힣a-zA-Z0-9\-_]/gi;
				
				if( $(this).val() == ''){
					//alert("닉네임은 필수 입력사항입니다");
					$(this).addClass("inputcheck");
					$(this).attr("placeholder","nickname은 필수 입력 사항입니다");
					$(this).focus();
					
					$("#account-btn").css("background-color","#5a5a5a");
					$("#account-btn").prop("disabled",true);
					
					return false;
				}
				if ( check.test( $(this).val()) ){
					if( $(this).val().length > 8 ) {
						alert("닉네임은 8자 이내로 사용가능합니다.");
						$(this).val($(this).val().substring(0, 8));
						$(this).focus();
						
						$("#account-btn").css("background-color","#5a5a5a");
						$("#account-btn").prop("disabled",true);
						
					    return false;
					 }
					 else{
						 alert("닉네임은 한,영,숫자, 특수문자 -,_만 입력가능 합니다.");
						 $(this).val( $(this).val().replace(/[^가-힣a-zA-Z0-9\-_]/gi,'') );
						 $(this).focus();
						 
						 $("#account-btn").css("background-color","#5a5a5a");
						 $("#account-btn").prop("disabled",true);
							
					     return false;
					 }
				 }
				if ( !check.test( $(this).val()) ){
					if( $(this).val().length > 8 ) {
						alert("닉네임은 8자 이내로 사용가능합니다.");
						$(this).val($(this).val().substring(0, 8));
						$(this).focus();
						
						$("#account-btn").css("background-color","#5a5a5a");
						$("#account-btn").prop("disabled",true);
						
					    return false;
					}
				}
				return true; 
			}
			return true;
		},
		click: function(event) {
			if( account_nickname.prop("readonly") == true ) {
				var result = confirm("닉네임을 변경하시겠습니까?");
				if(result){
					account_nickname.prop("readonly",false);
					$("#nicknameCheck-Btn").text("사용하기");
					$("#nicknameCheck-Btn").prop("disabled",false);
					$("#nicknameCheck-Btn").css({"color":"#ccc6c6"});
					account_nickname.focus();
					
					$("#account-btn").css("background-color","#5a5a5a");
					$("#account-btn").prop("disabled",true);
					
					return false;
				}	
			}
		}
	});
	
	
	/* 닉네임 확인 event */
	$("#nicknameCheck-Btn").on({
		focus: function (event) {
			$(this).css({"background-color":"#e8e8e8","color":"#000"});
			return false;
		},
		focusout: function (event) {
			$(this).css({"background-color":"#fff","color":"#ccc6c6"});
			return false;	
		},
		keyup:function(e) {
		    if (e.keyCode == 13) {
		    	$(this).css({"background-color":"#fff","color":"#ccc6c6"});
		    }
		},
		click:function(){
			
			var nickname = account_nickname.val().replace(/ /gi, '');	//띄어쓰기 없애고 공백 처리
			if(nickname == ''){
				account_nickname.addClass("inputcheck");
				account_nickname.attr("placeholder","nickname은 필수 입력 사항입니다");
				account_nickname.focus();
				
				$("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
				
				return false;
			}
			
			$.ajax({
				url : "checkNickname.do",
				type : "post",
				data :"nickname=" + nickname,
				dataType : "text",
				async: false,
				success : function( data ) {
					if(data == "ok"){
						console.log("nickname = " + nickname);
						alert("사용가능한 닉네임입니다.");
						
						$("#nicknameCheck-Btn").text("사용가능");
						$("#nicknameCheck-Btn").prop("disabled",true);
						$("#nicknameCheck-Btn").css({"color":"#85da46"});
						account_nickname.css({"color":"initial"});
						account_nickname.prop("readonly",true);
						account_name.focus();
						
						
						if($(".pwdCheckMsg").val() == "일치"
							&&$("#emailCheck-Btn").text() == "인증완료"
								&& account_pwd.val().length !='' 
								&& account_name.val().length !=''
								&& address.val().length !=''){
							$("#account-btn").css("background-color","#585e7d");
							$("#account-btn").prop("disabled", false);
						}
					}
					if(data == "notok"){
						alert("이미 사용중인 닉네임입니다.");
					}
				},
				error: function (error) {
		            alert(JSON.stringify(error));
		            alert("닉네임 체크 실패...");
				}
			});	
			
		}
	});
	
	
	/* 이름 입력 event */
	account_name.on({
		blur:function(event){
			var check = /[^가-힣a-zA-Z]/gi;
			
			if( $(this).val() == ''){
				$(this).addClass("inputcheck");
				$(this).attr("placeholder","이름은 필수 입력 사항입니다");
				
				$("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
				
				return false;
			}
			if ( check.test( $(this).val()) ){
				 alert("이름은 한글, 영어만 입력가능 합니다.");
				 $(this).val( $(this).val().replace(/[^가-힣a-zA-Z]/gi,'') );
				 $(this).focus();
				 
				 $("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
					
			     return false;
			}
			return true; 
		},
		keydown: function(event){
			
			
			if( $(this).val().length >  20) {	// 글자수 제한			
				alert("이름은 20자 이내로 사용가능합니다.");
				$(this).val($(this).val().substring(0, 20));
				$(this).focus();
				
				$("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
				
			    return false;					    
			}
			if(event.keyCode == 32){	// 스페이스바 이벤트_ 띄어쓰기 공백처리
				alert("이름은 한글, 영어만 입력가능 합니다.");
				$(this).val( $(this).val().replace(/ /gi, '') );
				$(this).focus();
				
				$("#account-btn").css("background-color","#5a5a5a");
				$("#account-btn").prop("disabled",true);
				
				return false;
			}
			if (event.keyCode == 9){	// 탭키 이벤트
				var check = /[^가-힣a-zA-Z]/gi;
								
				if( $(this).val() == ''){
					$(this).addClass("inputcheck");
					$(this).attr("placeholder","이름은 필수 입력 사항입니다");
					$(this).focus();
					
					$("#account-btn").css("background-color","#5a5a5a");
					$("#account-btn").prop("disabled",true);
					
					return false;
				}
				if ( check.test( $(this).val()) ){
					 alert("이름은 한글, 영어만 입력가능 합니다.");
					 $(this).val( $(this).val().replace(/[^가-힣a-zA-Z]/gi,'') );
					 $(this).focus();
					 
					 $("#account-btn").css("background-color","#5a5a5a");
					 $("#account-btn").prop("disabled",true);
					 
				     return false;
				 }
				return true;
					 
			}
			return true;
		}
	});
	
	$("#postcodeSearch").on({
		focusin: function (event) {
			$(this).css({"background-color":"#e8e8e8","color":"#000"});
			return false;
		},
		focusout: function (event) {
			$(this).css({"background-color":"#fff","color":"#ccc6c6"});
			return false;	
		},
		keyup:function(e) {
		    if (e.keyCode == 13) {
		    	$(this).css({"background-color":"#fff","color":"#ccc6c6"});
		    }
		}
	});
	
	// 로그인 submit
	$("#login-btn").on("click", function() {
		var id = $("input[name=email]", document.loginform);
		var pwd = $("input[name=pwd]", document.loginform);
		
		if ( id.val() == "") {
			alert("이메일을 입력하세요");
			id.focus();
		}
		else if (pwd.val() == "") {
			alert("비밀번호를 입력하세요");
			pwd.focus();
		}
		else {
			var login_data = $("#login-form").serialize() ;
			
			$.ajax({
				url : "loginAf.do",
				method : "post",
				data : login_data,
				dataType : 'json',
				success : function(num) {
					console.log("userChk = " + num);

					if (num == 0) { //DB에 아이디가 없을 경우 
						console.log("일치하는 회원 찾지 못함");
						alert("id와 비밀번호를 확인해주세요.");
					}
					if (num == 1) { //DB에 아이디가 있는 경우 => 로그인 
						console.log("로그인중...");
						
						//포인트지급관련
						$.ajax({
							url : "loginPointCheck.do",
							method : "post",
							data : login_data,
							dataType : 'json',
							success : function( pointcheck ) {
								if(pointcheck == true) {
									alert("main으로 이동합니다.");
								}else if(pointcheck == false) {
									alert("오늘의 출석 포인트 지급 완료! main으로 이동합니다.");
								}
								$("#login-form").attr("method","POST").attr("action","main.do").submit();
							},fail : function(error) {
								alert("loginPointCheck error");
							}
						});
						
					}
					if( num == 2 ) {
						console.log("탈퇴한회원");
						alert("해당 계정은 탈퇴한 계정입니다.");
					}
					if (num == 3) {
						console.log("신고 횟수가 10번 이상 접수되어 자동으로 활동정지된 계정입니다.");
						alert("신고 횟수가 10번 이상 접수되어 자동으로 활동정지된 계정입니다.");
					}
					if (num == 4) {
						console.log("관리자 권한으로 활동정지된 계정입니다.");
						alert("관리자 권한으로 활동정지된 계정입니다.");
					}
					if( num == 8 ) {
						console.log("관리자계정");
						location.href="adminMain.do";
					}
				},fail : function(error) {
					alert(JSON.stringify(error));
				}
			});	
			
		}
	});	
	

	// 회원가입 submit
	$("#account-btn").on("click", function () {	
		
		var account_email = $("input[name=email]", document.accountform);
		var account_pwd = $("input[name=pwd]", document.accountform);
		var account_nickname = $("input[name=nickname]", document.accountform);
		var name = $("input[name=name]", document.accountform);
		var address = $("input[name=address]", document.accountform);
		var address_detail = $("input[name=address_detail]", document.accountform);
		var phone = $("input[name=phone]", document.accountform);

		if(account_email.val() == ""){
			alert("이메일은 필수 입력사항 입니다.");
			account_email.focus();
		}
		else if(account_pwd.val() == "") {
			alert("비밀번호는 필수 입력사항 입니다.");
			account_pwd.focus();
		}
		else if ($(".pwdCheckMsg").val() == ""){
			alert("비밀번호 확인을 진행해 주세요.");
			$(".pwd_input").focus();
		}
		else if( $("#emailCheck-Btn").text() != "인증완료"  ){
			alert("이메일 인증이 되지 않았습니다. 다시 확인해 주세요.");
			account_email.focus();
		}
		else if( $("#nicknameCheck-Btn").text() != "사용가능"  ){
			alert("닉네임 사용여부를 체크해주세요.");
			account_nickname.focus();
		}
		else if ($(".pwdCheckMsg").val() == "불일치"){
			alert("비밀번호가 일치하지 않습니다. 다시 확인해 주세요.");
			$(".pwd_input").focus();
		}
		else if(account_nickname.val() == "") {
			alert("닉네임은 필수 입력사항 입니다.");
			account_nickname.focus();
		}else if(name.val() == "") {
			alert("이름은 필수 입력사항 입니다.");
			name.focus();
		}else if(address.val() == "") {
			alert("주소를 입력해주세요");
			address.focus();
		}else if(phone.val() == "") {
			alert("핸드폰번호를 입력해주세요");
			phone.focus();
		}else {
			alert("회원가입클릭");
			var accountString = $("#account-form").serialize() ;
			
			$.ajax({
				url : "accountAf.do",
				method : "post",
				data : accountString,
				dataType : 'text',
				success : function(str) {					
					console.log("str = " + str);			
					if (str == "kakaoAccount") { //카카오유저회원가입
						console.log("카카오회원 가입완료");
					}
					if (str == "Account") { //일반유저회원가입 
						console.log("일반유저회원가입완료");
					}				
					alert("회원가입완료! 홈페이지 메인으로 이동합니다.");
					
					//포인트지급관련
					$.ajax({
						url : "loginPointCheck.do",
						method : "post",
						data : accountString,
						dataType : 'json',
						success : function( msg ) {
							alert("포인트지급 여부 msg = " + msg);
							alert(JSON.stringify(msg));					
							alert("로그인중...");					
							location.href = "main.do";
						},fail : function(error) {
							alert("loginPointCheck error");
						}
					});	
					
					
				},fail : function(error) {
					alert(JSON.stringify(error));
				}
			});
			
		}
	});
	
});

