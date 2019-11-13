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
	
	<div class="input-area">
		<font id="recipient"><b>받는 사람</b>&nbsp;</font> <font>${sendmsgDetail.nickname }</font>
		<input type="hidden" name="to_email" value="${sendmsgDetail.from_email }">
		<br><br>
		<textarea id="_content" name="content" readonly="readonly">${sendmsgDetail.content }</textarea>
	</div>
	<div class="new-btn-container">
		<button type="button" id="deleteBtn">삭제</button>
		<button type="button" id="cancelBtn">취소</button>
	</div>
</form>
<script type="text/javascript">
$(document).ready(function(){
	var count = 0;
	$(".check-section").hide();

	$("#cancelBtn").on("click",function(){
		self.close();
	});
	
	$("#_important").on("change",function(){
		if($(this).prop("checked")){
			$(this).val(1);
		}
		else{
			$(this).val(0);
		}
		
	});
	
	$("#deleteBtn").on("click",function(){
		
		
	});
});
</script>
</body>
</html>