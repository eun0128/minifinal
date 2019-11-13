<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting : 쪽지 쓰기</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/mypage_resources/mypage_s/msgbox/msgbox_style.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<div id="pop-up-window">
<form id="msgfrm">
	<div id="pop-up-window-msg">
	<input type="hidden" name="from_email" value="${login.email }">
		<div class="check-section">
			<img src="./mypage_resources/mypage_s/images/urgent.png" class="container-icon">
				<font><b>중요</b></font>&nbsp;
			<input type="checkbox" name="important" id="_important" value="0">
		</div>
		<div class="input-area">
			<font><b>받는사람</b></font> <input type="text" id="input-rev" placeholder="여러 명은 쉼표(,)구분 (최대10명)" name="nickname">
			 <img src="./mypage_resources/mypage_s/images/contact.png" class="contact-icon" id="contactBtn"> <br>
			<br>
			<textarea placeholder="내용" name="content"></textarea>
		</div>
		<div class="new-btn-container">
			<button type="button" id="sendBtn">보내기</button>
			<button type="button" id="cancelBtn">취소</button>
		</div>
	</div>
</form>
<form id="contactfrm">
	<div id="pop-up-window-contact">

	</div>
</form>
</div>
<script type="text/javascript">
$(document).ready(function(){
	
	//주소록 읽어오는 부분
	$("#pop-up-window-contact").load("getcontact.do?flw=${flw}");
	
	//검색한 부분이 팔로워인지 팔로잉인지 확인하는 부분 
	if("${flw} == 'ing'"){
		$(".flwer-list").hide();		
	}
	else if("${flw} == 'wer'"){
		$(".flwing-list").hide();
	}

	//취소 버튼
	$("#cancelBtn").on("click",function(){
		self.close();
	});
	
	//중요한지 안중요한지 체크박스
	$("#_important").on("change",function(){
		if($(this).prop("checked")){
			$(this).val(1);
		}
		else{
			$(this).val(0);
		}
		
	});
	
	//보내기 버튼 - 여기가 제어 천국이다 
	$("#sendBtn").on("click", function(){
		
		var toEmail = $("#input-rev").val();
		var content = $("textarea[name='content']").val();
		if(toEmail == null || toEmail == ""){
			console.log("입력체크체크체크체크");
			$("#input-rev").attr("placeholder","받는 사람을 입력해주세요");
			$("#input-rev").addClass('input-rev-result');
			$("#input-rev").focus();
		
		}
		
		else if(content == null || content == ""){
			$("textarea[name='content']").attr("placeholder","쪽지 내용을 입력해주세요");
			$("textarea[name='content']").addClass("content-result")
			$("textarea[name='content']").focus();
			
		}
		else{
		
			var nickname = $("input[name='nickname']").val();
			$.ajax({
				type : "post",
				url : "checknicknameExist.do",
				data : {"nickname":nickname},
				dataType : "text",
				success : function(obj) {
					if(obj == 'ready'){
						$("#msgfrm").attr("action", "writemsgAf.do").submit();
						alert("쪽지를 성공적으로 보냈습니다");
						self.close();
					}else{
						alert(obj);						
					}

				},
				error : function() {
					alert("실패의 참맛");
				}
			}); 
			
			
		
		}
	
	});
	
	
	//주소록 버튼 누르면 열리고 닫히고 하는거죠 
	var count = 0;
	$("#contactBtn").on("click", function(){
		if(count == 0){
			window.resizeTo("975","595");
			$("#pop-up-window-contact").css("display","inline");
			count =1;
		}
		else if(count == 1){
			window.resizeTo("472","595");
			$("#pop-up-window-contact").css("display","none");
			count =0;
		}
	});
	
	//받는 사람에 대한 제어 파트
	$("#input-rev").on("change",function(){
	
	});
	
	
});
</script>
</body>
</html>