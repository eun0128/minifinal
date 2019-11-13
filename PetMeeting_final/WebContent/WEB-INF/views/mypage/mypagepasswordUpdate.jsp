<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageupdatepass/css/mypageupdatepass.css?after">

    <%
		    MemberDto mem=(MemberDto)request.getAttribute("member");		    
     %> 
</head>
<body>


<!-- 	<div id="mypageInfoupdate"> -->
 <header class="header_area">
    	<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>
    </header>
<div id="wrapper">

  <!-- Main -->
	<div id="main">
		<div class="inner">
		<section class="main-container">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12">
			<div class="mypageMain">


		
			<!--코드 오는 부분! -->
		<h2>나의 비밀번호 변경</h2>
		 <hr>	
		    
		<form id="msform">
  <!-- progressbar -->
  <ul id="progressbar">
    <li class="active">Account Setup</li>
    <li>Social Profiles</li>
    <li>Personal Details</li>
  </ul>
  <!-- fieldsets -->
  
 
 <fieldset class="step1" >
    <h2 class="fs-title">비밀번호 변경 STEP1</h2>
    <h3 class="fs-subtitle">현재 비밀번호를 입력 하세요</h3>
    <input type="password" name="pass" class="pwd" placeholder="Password" />
  <!--   <input type="button" name="next" class="next action-button" id="checkpwd" value="Next" />
  -->
 <div class="primary-button"  id="checkpwd" >
                        <a class ="infoupdatea"  href="#">수정</a>
    </div>
  </fieldset>

  
  <fieldset class="step2">
    <h2 class="fs-title">비밀번호 변경 STEP2</h2>
    <h3 class="fs-subtitle">나의 비밀번호 </h3>
    
    <span>비밀번호</span>
    <input type="password" id="pass1" >
    
    <span id="passspan">비밀번호 확인</span> 
     <input type="password" id="pass2" >
   <!--  <input type="button" name="next" class="next action-button2" id="passupdate" value="수정" /> -->
   <div class="primary-button" id="passupdate" >
                        <a class ="infoupdatea"  href="#">수정</a>
    </div>
   
   
  </fieldset>
 
 
 
 <fieldset class="step3" >`
    <h2 class="fs-title">비밀번호 변경이 완료 되었습니다</h2>
  </fieldset>
 
 
</form>		
			<!--코드 오는 부분! 끝  -->
					
				
							</div>
						</div>
					</div>
			</section>
			
				<!--::footer part start::-->
				<br>
			<footer>
			<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
			</footer> 
			<!-- footer part end-->
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/mypage/mypageSidemenu.jsp"/>
</div>	


<script type="text/javascript">
$("#pass2").keyup(function () {
	if($("#pass1").val()!=$("#pass2").val()){
		$('#passspan').css('color', 'red'); 
		$("#passspan").html("비밀번호 불일치");	
	}
	if($("#pass1").val().trim() == $("#pass2").val().trim()){
		$('#passspan').css('color', 'white'); 
		$("#passspan").html("비밀번호 일치");	
	}
});


//비밀번호 변경 버튼을 눌렀을 때
$("#passupdate").click(function () {
	if($("#pass1").val()==""){
		alert("변경 할 비밀번호를 입력 해 주세요");
		$("#pass1").focus();
		return false;
	}
	if($("#pass2").val()==""){
		alert("변경 할 비밀번호를 입력 해 주세요");
		$("#pass2").focus();
		return false;
	}
   if($("#passspan").html()=="비밀번호 일치"){
		var next_fs = $(this).parent().next();
		
	   $.ajax({
		   type:"POST",
		   url:"mypagepasswordUpdateaf.do",
		   async: false,
		   data:{"pwd":$("#pass2").val()},
		   success:function(data){
			   alert("성공~");
			   if(data=='ok'){
				   $(".step2").hide();
				   $(".step3").show();
				   $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active"); 
			   }
		   },error:function(){
			   alert("실패!!");
		   }
	   });
	   
	   
	   
	   
	   
   }else{
	   alert("비밀번호가 옳바르지 않습니다");
	   $("#pass1").focus();
	   $("#pass2").val("");
	   return false;
   }
});


$(document).ready(function () {
	$(".step2").hide();
	$(".step3").hide();
	$(".step1").show();
	
	/* 
	//두번째 비밀번호에 포커스가 될때 발생하는 이벤트
	var pass2=$("#pass2");
	pass2.focus(function () {
		// $('#passspan').css('color', 'white');  
	}); */
});

//비밀번호 확인 버튼을 눌렀을 때
$("#checkpwd").click(function(){
	var pwd=$(".pwd").val();
	if(pwd==""){
	   alert("비밀번호를 입력하지 않으셨습니다");
	   $(".pwd").focus();
	    return false;
	}
	var next_fs = $(this).parent().next();
      $.ajax({
		 type:"POST",
		 url:"mypageInfocheckpwd.do",
		 async: false,
		 data:{"pwd":pwd},
		 success:function(data){
			// alert("성공~~");
			 //alert(data);
			 if(data=="true"){
				$(".step1").hide();
				$(".step2").show();
				$("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
	
			 }else{
				 alert("비밀번호가 일치 하지 않습니다 다시 입력 해 주세요");
				 $(".pwd").val("");
				 $(".pwd").focus();
				 return false;
			 }
			 
		 },error:function(){
			 alert("실패!");
		 }
	}); 
	
});


</script>

</body>
</html>