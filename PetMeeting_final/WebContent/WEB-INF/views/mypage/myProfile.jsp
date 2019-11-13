<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 프로필</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/jquery.form.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/mypage_resources/mypage_j/css/myprofile.css">

</head>
<body class="is-preload">
  <header class="header_area">
    	<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>
    </header>
<!-- Wrapper -->
<div id="wrapper">

  <!-- Main -->
	<div id="main">
		<div class="inner">
			<h2>나의 프로필</h2>
			<hr>							
			<section class="main-container">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12 myprofile-all-container">
						
							<form name="profileForm" id="_profileForm">	
							<div class="col-md-6 right-content myprofile-container">
									<input name="email" type="hidden" value="${login.email }">
									<input name="myprofile_img" type="hidden" value="${userProfile.myprofile_img }">
									<input name="mysex" id="gender" type="hidden" value="${userProfile.mysex }">
									
									<div class="mypageHomebox_1">
										<div class="input_row">
											<p class="input_title">닉네임</p>							
											<span>
											<input name="nickname" type="text" size="20px" value="${login.nickname }" readonly="readonly">
											<input type="button" id="nickChange_btn" class="nickchange" value="닉네임변경">
											<input type="button" id="nickChk_btn" class="nickchange displayis" value="사용하기">
											</span>
											<p><font class="nickChgMsg"></font></p>
										</div>
									</div>
								
									<div class="mypageHomebox_1">
										<div class="input_row">
											<p class="input_title">&nbsp;&nbsp;나이</p>
											<span>&nbsp;<input name="myage" type="text" size="6px" value="${userProfile.myage==0? 0:userProfile.myage }" >&nbsp;&nbsp;세</span>
										</div>						
									</div>
									
									<div class="mypageHomebox_1">
										<div class="input_row">
											<p class="input_title">&nbsp;&nbsp;성별</p>
											<input name="mysex" type="checkbox" id="female" onclick="checkChg()">&nbsp;&nbsp;여
												&nbsp;&nbsp;&nbsp;&nbsp;
											<input name="mysex" type="checkbox" id="male"  onclick="checkChg()">&nbsp;&nbsp;남
										</div>					
									</div>
									
									<div class="mypageHomebox_1">
										<div class="input_row">
											<p class="input_title">&nbsp;&nbsp;소개&nbsp;<font size="2em">(100자 이내로 작성해주세요)</font></p>
											
											<textarea name="myintro" placeholder="당신에 대해 소개해 주세요">${userProfile.myintro }</textarea>	
										</div>											
									</div>
							
							
							
							
							</div>
							<div class="col-md-6 left-content myprofile-container">
							
									<div class="mypageHomebox_1">
										<div class="input_row">
											<p class="input_title">프로필이미지</p>	
											<div class="input_content">								
												<img id="img_preView" class="img_preView" alt="이미지없음" src="./mypage_resources/mypage_j/images/profile_icon.png" align="center"/>
																																
												<!-- 프로필세션의 프로필이미지 있는경우 -->
												<!-- 들어온 프로필 변수-->											
												<c:set var="myimg" value="${userProfile.myprofile_img}"/>
												
												<!-- 프로필 이미지파일 있는경우 -->
												<c:if test="${userProfile.myprofile_img ne null}">
													<script>
														var myprofileimg = '<c:out value="${myimg }"/>';							
														$(".img_preView").attr("src", "upload/" + myprofileimg);
													</script>
												</c:if>
												
												<!-- 주소형식 이미지의 경우(카카오프로필의 경우) -->											
												<c:if test="${fn:contains(myimg,'http')}">
													<script>
														var myprofileimg = '<c:out value="${myimg}"/>';
														$(".img_preView").attr("src", myprofileimg);
													</script>
												</c:if>
												
												<br><br>
												<input type="file" name="fileload">
												<p>250px * 250px 이상의 이미지사용을 권장합니다.<br>(권장사이즈 이상 시 사진이 잘릴 수 있습니다)</p>
											</div>
											
											
										</div>						
									</div>
									
							</div>
								</form>		
						</div>
					</div>
				</div>
				<div class="mypageHomebox_1">
									<div class="input_row">
										<button class="profile_Btn displayis" id="myProfile_insertBtn">프로필 등록하기</button>
										<button class="profile_Btn displayis" id="myProfile_updateSubBtn" >프로필 수정완료</button>						
									</div>
								</div>
			</section>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/mypage/mypageSidemenu.jsp"/>
</div>

<script	src="${pageContext.request.contextPath}/mypage_resources/mypage_j/js/submit_checking.js"></script> <!-- 등록,수정 submit시 공백 체크함수 -->
<script type="text/javascript">
$(document).ready(function(){

	if( $("input[name=myage]").val() == 0){
		$("input[name=myage]").val('');
	}
	
	var comintro = $('textarea').val();
	comintro = comintro.split('<br/>').join("\r\n");
	$('textarea').val(comintro);
	
	$(".input_title").prepend("<img src='./mypage_resources/mypage_s/images/point.png' class='input-icon'>");
	$('input[type="checkbox"]').bind('click',function() { $('input[type="checkbox"]').not(this).prop("checked", false); });
	

	
	var gender = $("#gender").val();	
	if(gender == 0){
		$("#female").prop("checked",true);
	}
	else{
		$("#male").prop("checked",true);
	}
	
	// checkbox제어
	$("#female").change(function(){
	    if($("#female").is(":checked") == false ){
	    	$("#male").prop("checked",true);
	    	$("#gender").val('1');
	    }else{
	    	$("#male").prop("checked",false);
	    	$("#gender").val('0');
	    }
	});
	$("#male").change(function(){
	    if($("#male").is(":checked") == false ){
	    	$("#female").prop("checked",true);
	    	$("#gender").val('0');
	    }else{
	    	$("#female").prop("checked",false);
	    	$("#gender").val('1');
	    }
	});
	

	$("#_petsex1").change(function(){
	    if( $("#_petsex1").is(":checked") ){
	    	$("#_petsex0").prop("checked",false);
	    }else{
	    	$("#_petsex0").prop("checked",true);
	    }
	});
	
	$.ajax({
		url : "checkprofile.do",
		success : function(checkIS) {
			if(checkIS){
				console.log("PM_CHECK_MYPROFILE에 유저정보 있음");
				$("#myProfile_updateSubBtn").removeClass("displayis");
			}
			if(!checkIS){
				console.log("PM_CHECK_MYPROFILE에 유저정보 없음");				
				alert("프로필을 등록하고 1000point 받으세요!");
				$("#myProfile_insertBtn").removeClass("displayis");
			}			
		},
		fail : function(error) {
			alert(JSON.stringify(error));			
		}	
	});
});

// 파일업로드시 미리보기
$("input[name=fileload]").change(function() {
    readURL(this);
});

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#img_preView').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

// 프로필 등록 submit
$('#myProfile_insertBtn').on("click",function(){
	
	if ( myprosubmitChk() == false ) return false;
	
	var profileForm = $("#_profileForm")[0];
	var data = new FormData(profileForm);

	$.ajax({
		url : "updateProfile.do",
		method : "post",
		data : data,
		enctype: 'multipart/form-data',
		processData: false,
        contentType: false,
        cache: false,
		async: false,
		success : function(str) {			
			alert("프로필 등록 완료!");
			location.href ="myprofile.do";
			
		},
		error: function (error) {
            alert(JSON.stringify(error));          
            $("#myProfile_insertBtn").prop("disabled", false);
            alert("프로필 등록 실패...");
		}	
	});
	
});

// 프로필 수정 submit
$('#myProfile_updateSubBtn').on("click",function(){
	
	if ( myprosubmitChk() == false) return false;
	
	var profileForm = $("#_profileForm")[0];
	var data = new FormData(profileForm);
	
	$.ajax({
		url : "updateProfile.do",
		method : "post",
		data : data,
		enctype: 'multipart/form-data',
		processData: false,
        contentType: false,
        cache: false,
		async: false,
		success : function(str) {			
			alert("프로필 수정 완료!");
			location.href="myprofile.do";
		},
		error: function (error) {
            alert(JSON.stringify(error));
            alert("프로필 수정 실패...");
		}
	});
});


// 닉네임변경 버튼 클릭이벤트
$("#nickChange_btn").on("click",function(){
	$("input[name=nickname]").prop("readonly",false);	
	$("input[name=nickname]").focus();	
	$("#nickChange_btn").addClass("displayis");
	$("#nickChk_btn").removeClass("displayis");
	$("#nickChk_btn").css("background-color", "#2b2b2b");
	$("#myProfile_updateSubBtn").css("background-color", "#2b2b2b");
	$("#myProfile_updateSubBtn").prop("disabled",true);	// 수정완료 버튼 비활성화	
});

// 수정완료 버튼 활성화 함수
function updateSubBtnUse() {	
	$("input[name=nickname]").prop("readonly",true);	
	$("#nickChange_btn").removeClass("displayis");
	$("#nickChk_btn").addClass("displayis");
	
	$("#myProfile_updateSubBtn").css("background-color", "#585e7d");
	$("#myProfile_updateSubBtn").prop("disabled",false);// 수정완료 버튼 활성화	
};

// 닉네임 사용하기 버튼 클릭이벤트
$("#nickChk_btn").on("click",function(){
	if( $("input[name=nickname]").val() == '') {
		$(".nickChgMsg").text("닉네임을 입력하세요.");
		$(".nickChgMsg").attr("color","red");
		$("input[name=nickname]").focus();
		return false;
	}
		
	var nickname = $("input[name=nickname]").val().replace(/ /gi, '');
	
	$.ajax({
		url : "nicknameCheck.do",
		type : "post",
		data :"nickname=" + nickname,
		dataType : "text",
		async: false,
		success : function( data ) {
			if(data == "사용 가능한 닉네임 입니다."){
				var result = confirm("사용 가능한 닉네임 입니다. 사용하시겠습니까?");
				if(result){
					$(".nickChgMsg").text("");
					updateSubBtnUse();
				}
			}
			else if(data == "현재 사용중인 닉네임 입니다."){	
				updateSubBtnUse();
			}
			else if(data == "이미 존재하는 닉네임 입니다."){
				$(".nickChgMsg").text("이미 존재하는 닉네임 입니다.");
				$(".nickChgMsg").attr("color","red");
				$("input[name=nickname]").focus();
			}
			else{
				$(".nickChgMsg").text("");
			}
		},
		error: function (error) {
            alert(JSON.stringify(error));
            alert("닉네임 체크 실패...");
		}
	});
});


//keyup 이벤트
$('input[name=nickname]').on('keyup', function(event) {
	// 표현식 제한
	var regexp = /[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣a-zA-Z0-9\-_]/gi;
	var nameval = $(this).val();
	if( regexp.test( nameval ) ){
		alert("한,영,숫자, 특수문자 -,_만 입력가능 합니다");
		
		$(this).val(nameval.replace(regexp, ''));
	}
	
	// 글자수제한 	
	if($(this).val().length > 8) {
		$(".nickChgMsg").text("닉네임은 8자 이내만 사용가능합니다.");
		$(".nickChgMsg").attr("color","red");
		$("#nickChk_btn").prop("disabled",true);
		$("#nickChk_btn").css("background-color", "#a2a2a2");
		//
	}
	if($(this).val().length <= 8) {
		$(".nickChgMsg").text("");
		$("#nickChk_btn").prop("disabled",false);
		$("#nickChk_btn").css("background-color", "#2b2b2b");
	}
});

$('input[name=myage]').on('keyup', function(event) {    
		var regexp = /[^0-9]/gi;
		var ageval = $(this).val();
		
	   if( $(this).val().length > 2) {
		   $(this).val($(this).val().substring(0, 2));
	   }
	   if( regexp.test( ageval ) ){
		   alert("숫자만 입력가능 합니다");
		   $(this).val(ageval.replace(regexp, ''));
	   }
});

$('textarea[name=myintro]').on('keyup', function(event) {    
	   if( $(this).val().length > 100) {
		   alert("소개글은 100자 이내로 작성해주세요.");
		   $(this).val($(this).val().substring(0, 100));
	   }
});



</script>
</body>
</html>