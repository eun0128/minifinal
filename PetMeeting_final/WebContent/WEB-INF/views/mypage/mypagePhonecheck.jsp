
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.4.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypagephonecheck_resources/css/templatemo-style.css">
<%-- <link rel="stylesheet"
	href="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/css/mypage_layout.css"> --%>
</head>

<body>

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
 <h2>번호 인증</h2>
		 <hr>
				
<!--  -->

	<form id="msform">
	<fieldset class="step1" >
	<div class="input-container" id="input-container1" >
		
    <h2 class="fs-title">휴대폰 인증 STEP1</h2>
    <h3 class="fs-subtitle">현재 휴대폰 번호를 입력 하세요</h3>
    <input type="text" name="pass"class="phonenumber" id="_phonenumber" placeholder="phone-number" />
  <!--   <input type="button" name="next" class="next action-button" id="checkpwd" value="Next" />
  -->
   <div class="primary-button"  id="phonecheckbtn" >
                        <a class ="infoupdatea"  href="#">입력</a>
    </div>
  
  </div>
   <div class="input-container" id="input-container2" >
   
          <input type="text" class="checkphonenumber" id="_checkphonenumber"> 
          <div class="bar"> 
           <span class="mytime">30초</span>
          <button type="button" id="checkphonecheckbtn">인증번호확인</button></div>   
          <input type="hidden" id="randnum" value="0">
       </div>
  

  </fieldset>
		</form>
		
					
	<!--  -->			
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

$(document).ready(function () {
	$("#input-container2").hide();
});


/* 
$(".phonecheckbtn1").click(function () {
	//alert("크릭");
	var modal=document.getElementById("modal");
	
	  modal.style.display = "block";
	  
	  alert(modal);
	  
	  
});
 */
$("#phonecheckbtn").click(function () {
      alert("폰인증!!");
	
	
	var phone=$(".phonenumber").val();
	//alert("폰"+phone);
	
	if(phone.length==0){
		alert("전화번호를 기입 해 주세요");
		
		$(".phonenumber").focus();
		return false;
	}
	
	if(isNaN(phone)==false){
		//alert("숫자입니다");
	//	console.log("숫자입니다");
	    
		$("#input-container1").hide();
		$("#input-container2").show();
	
	//	alert("폰"+phone);
		
		
		$.ajax({
		type:"POST",
		url:"mypagePhonerandnumcheck.do?phone"+phone,
		data:{"phone":phone},
		error:function(error){
		//	alert("에러");
		},
		success:function(data){
			
		
		
		//인증번호를 위 히든값에 넣어 줌 
		$("#randnum").val(data);
		
		
		//alert("인증번호"+	$("#randnum").val());
		
		timer();
	    
		
		
		  }	
		});
		
		
		
		<%-- <%
		
		
		 SendSMS sms = new SendSMS(22) ;
		%> --%>
		
	}else{		
		alert("바른형식의 전화 번호가 아닙니다 숫자만 입력 해 주세요");
		$(".phonenumber").focus();
		return false;
	}
});


function timer() {
    alert("타이머 시작");
	var count=30;
	var countdown=setInterval(function () {
		
		
		if(count==0){
			clearInterval(countdown);
			//alert("타이머 종료");
			return false;
		}
		
		count--;
		$(".mytime").text(count+"초");
	},1000);
}

$("#checkphonecheckbtn").click(function () {
 
	if($(".mytime").text()=='0초'){
	  alert("시간이 초과 되었습니다");
	  $("#input-container1").show();
	  $(".phonenumber").val("");
	  
	  
	  $("#input-container2").hide();
	  $(".checkphonenumber").val("");
       return false;
  }

	var randnum=$(".checkphonenumber").val();
	
	
	if(randnum.length==0){
		alert("인증번호를 기입 해 주세요");
		
		$(".checkphonenumber").focus();
		return false;
	}
	
	if(isNaN(randnum)!=false||randnum.length<6){
	   alert("바른 형식의 인증번호가 아닙니다");
	   $(".checkphonenumber").val(""); 
	   return false;
	}
	//인증번호 비교 하는 부분!!!
	else{
		
	//문자로 날린 인증번호를 가져옴!
	var realnum=$("#randnum").val();
	var usernum=$(".checkphonenumber").val();
    //alert("유저가 쓴 인증번호"+ $(".checkphonenumber").val());
       
       if(realnum==usernum){
    	    	 
    location.href="mypagehome.do";
    	 
       }else{
    	  alert("인증번호 불일치");
    	  $(".checkphonenumber").val(""); 
     }
    
	}
  
  
});



<%--  
$("#check").click(function () {
    alert("클릭11");
    <%
    SendSMS sms = new SendSMS("hwwk78") ;
    %>
	
}); --%>

</script>


</body>
</html>