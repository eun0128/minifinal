<%@page import="java.lang.reflect.Member"%>
<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageInfo/css/mypageInfo.css">


     <%
		    MemberDto mem=(MemberDto)request.getAttribute("member");		    
     %> 
		    
		    
</head>
<body>

	<!-- <div id="mypageInfoupdate"> -->
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
		
 <h2>나의 회원정보 수정</h2>
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
    <h2 class="fs-title">회원정보 수정 STEP1</h2>
    <h3 class="fs-subtitle">비밀번호를 입력 하세요</h3>
    <input type="password" name="pass" class="pwd" placeholder="Password" />
    
    <div class="primary-button"  id="checkpwd">
                        <a href="#">NEXT</a>
    </div>
    
    
<!--     <input type="button" name="next" class="next action-button" id="checkpwd" value="Next" /> -->
  </fieldset>

  
  <fieldset class="step2">
    <h2 class="fs-title">회원정보 수정 STEP2</h2>
    <h3 class="fs-subtitle">나의 회원 정보 </h3>
 <span>EMAIL</span>
 <input type="text" readonly="readonly" id="email"  value="<%=mem.getEmail()%>">
 <span>NICKNAME</span>  
 <input type="text" readonly="readonly" id="nickname" class="nickname" value="<%=mem.getNickname()%>">
 <span>NAME</span>
 <input type="text" readonly="readonly" id="name" value="<%=mem.getName()%>">
 <span>PHONE</span>
 <input type="text" readonly="readonly" id="phone" value="<%=mem.getPhone()%> ">
 <span>POSTCODE</span>
 <input type="text" readonly="readonly" id="sample6_postcode" class="postcode" value="<%=mem.getPostcode()%>"> 
 <button type="button"  class="next action-button2"  onclick="sample6_execDaumPostcode()" id="searchpostcode">우편번호 찾기</button>
<!--   <input type="button"  class="next action-button2"  onclick="sample6_execDaumPostcode()" id="searchpostcode" value="우편번호 찾기"> -->
  <span>ADDRESS</span><input type="text" id="sample6_address" readonly="readonly" class="address" value="<%=mem.getAddress()%>">
<span>ADDRESSDETAIL</span>
<input type="text" id="sample6_extraAddress" readonly="readonly" class="addressdetail" value="<%=mem.getAddress_refer()%>">
<input type="text" id="sample6_detailAddress" class="address_detail" name="address_detail"  value="<%=mem.getAddress_detail()%>">
   
   <!-- 
    <input type="button" name="next" class="next action-button2" id="infoupdate" value="수정" /> -->
    
    <div class="primary-button"  id="infoupdate">
                        <a class ="infoupdatea"  href="#">수정</a>
    </div>
    
   
   
  </fieldset>
 
 
 
 <fieldset class="step3" >
    <h2 class="fs-title">회원정보 수정이 완료 되었습니다</h2>
 
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
		

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

$(document).ready(function () {
    $("#searchpostcode").hide();
	$(".step2").hide();
	$(".step3").hide();
	
	/* 
	if($("#infoupdate").val()=="수정완료"){}
	alert("클릭"); */
});


function update() {

	var addressdetail= $(".address_detail").val();
	var next_fs = $(this).parent().next();
	if(addressdetail=="" ){
       alert("상세 주소를 기입 해 주세요");
       $(".address_detail").focus();
       return false;
    }
	   else{
		   
		   $.ajax({
				 type:"POST",
				 url:"mypageInfoupdateaf.do",
				 async: false,
				 data:{"email":$("#email").val(),
					   "nickname":$("#nickname").val(),
					   "name":$("#name").val(),
					   "postcode":$(".postcode").val(),
					   "address":$(".address").val(),
					   "address_detail":$(".address_detail").val(),
					   "address_refer":$(".addressdetail").val(),
					   "phone":$("#phone").val()},
				 success:function(data){
				//  alert("성공!!!");
					 if(data=="true"){
					     	 
					    $(".step2").hide();
						$(".step3").show();
						$("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
					 }
				  
					 
				 },error:function(){
					 alert("실패!");
				 }
			}); 
			
	   }
}

//수정하기 버튼을 눌렀을 때
$("#infoupdate").click(function () {
	//alert("클릭");

	$("#nickname").attr("readonly", false); 
	$("#name").attr("readonly", false); 
	$("#phone").attr("readonly", false); 
	
	  $("#searchpostcode").show();

	  
		 
	 $(".infoupdatea").html("수정완료");
	 
	 $("#infoupdate").on('click',update);
	 
	  
/* 	  
	 //수정완료 버튼을 눌렀을 때 
	if($("#infoupdate").val()=="수정완료"){
		var addressdetail= $(".address_detail").val();
		var next_fs = $(this).parent().next();
		if(addressdetail=="" ){
           alert("상세 주소를 기입 해 주세요");
           $(".address_detail").focus();
           return false;
        }
		   else{
			   
			   $.ajax({
					 type:"POST",
					 url:"mypageInfoupdateaf.do",
					 async: false,
					 data:{"email":$("#email").val(),
						   "nickname":$("#nickname").val(),
						   "name":$("#name").val(),
						   "postcode":$(".postcode").val(),
						   "address":$(".address").val(),
						   "address_detail":$(".address_detail").val(),
						   "address_refer":$(".addressdetail").val(),
						   "phone":$("#phone").val()},
					 success:function(data){
					//  alert("성공!!!");
						 if(data=="true"){
						     	 
						    $(".step2").hide();
							$(".step3").show();
							$("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
						 }
					  
						 
					 },error:function(){
						 alert("실패!");
					 }
				}); 
				
	
        	       	
        }
	}   */
});




function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                $(".address").attr("readonly", false); 
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            $(".postcode").attr("readonly", false); 
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
    
    
 
}


 
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