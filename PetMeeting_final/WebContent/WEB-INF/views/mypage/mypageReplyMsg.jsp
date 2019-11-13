<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>PetMeeting : 쪽지 쓰기</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/mypage_resources/mypage_s/msgbox/msgbox_style.css">

</head>
<body>
<form id="frm">
<input type="hidden" name="from_email" value="${login.email }">
	<div class="check-section">
		<img src="./mypage_resources/mypage_s/images/urgent.png"
			class="container-icon"><font><b>중요</b></font>&nbsp;<input
			type="checkbox" name="important" id="_important" value="0">
	</div>



	<div class="input-area">
		<font id="recipient" IsAdmin="${revmsgDetail.nickname eq '관리자'? 0:1  }"><b>보낸사람</b>&nbsp;</font> <font>${revmsgDetail.nickname }</font>
		<input type="hidden" name="nickname" value="${revmsgDetail.nickname }">
	
		<br><br>
		<textarea id="_content" name="content" readonly="readonly">${revmsgDetail.content }</textarea>
	</div>
	<div class="new-btn-container">
		<button type="button" id="sendBtn">답장</button>
		<button type="button" id="cancelBtn">취소</button>
	</div>
</form>
<script type="text/javascript">
$(document).ready(function(){
	var admin = $("#recipient").attr("IsAdmin");
	if(admin == 0){
		$("#sendBtn").hide();
	}
	//답장보내기 모드로 바꾸기 위한 장치
	var count = 0;
	
	//답장 보내기부분에서 중요체크박스를 주기 위해 숨겨놓음
	$(".check-section").hide();

	//취소
	$("#cancelBtn").on("click",function(){
		self.close();
	});
	
	//중요 체크박스
	$("#_important").on("change",function(){
		if($(this).prop("checked")){
			$(this).val(1);
		}
		else{
			$(this).val(0);
		}
		
	});
	
	//답장 버튼 0 보내기 버튼 1
	$("#sendBtn").on("click",function(){
	if(count == 0){
		$(".check-section").show();
		window.resizeTo("475","590");
		$("#sendBtn").html("보내기");
		$("#recipient").html("받는사람");
		$("#_content").removeAttr("readonly");
		$("#_content").val("");
		count = 1;
		
	}
	else if(count == 1){
		
		var content = $("textarea[name='content']").val();
	
		if(content == null || content == ""){
			$("textarea[name='content']").attr("placeholder","쪽지 내용을 입력해주세요");
			$("textarea[name='content']").addClass("content-result")
			$("textarea[name='content']").focus();
		}
		else{
			 $("#frm").attr("action", "writemsgAf.do").submit();
			alert("쪽지를 성공적으로 보냈습니다");
			self.close(); 
		}
	}
		
	});
});
</script>
</body>
</html>