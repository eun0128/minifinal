<%@page import="com.petmeeting.joy.freeboard.model.CmreportDto"%>
<%@page import="com.petmeeting.joy.freeboard.model.FreeboardDto"%>
<%@page import="com.petmeeting.joy.freeboard.model.ReportDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting</title>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/playboard_resources/css/report.css">
	
</head>
<body>


<%
	CmreportDto cmreportdto = (CmreportDto)request.getAttribute("cmreportform");
%>

<div class="container">
<form id="cmreportForm">

	<input type="hidden" name="seq" value="0">
	<input type="hidden" name="board_code" value="${cmreportform.board_code}">
	<input type="hidden" name="board_seq" value="${cmreportform.board_seq}">
	<input type="hidden" name="email" value="${cmreportform.email }">
	<input type="hidden" name="comment_seq" value="${cmreportform.comment_seq }">
	
	<div class="row">
		<img src="freeboard_resources/images/report.png" width="30px" height="30px" style="transform: translate(5px, 10px);">&nbsp;&nbsp;<h3>신고하기</h3>
	</div>
	<div class="line"></div>	
	
	<c:if test="${not empty detail }">
		<div class="row">	
			<div class="title">
				작성자
			</div>
			<div class="content">
				${reportdto.nickname }
			</div>
		</div>
		
		<div class="row">
			<div class="title">
				제목
			</div>
			<div class="content">
				[${dto.category }] ${dto.title }
			</div>
		</div>	
		
	</c:if>
	
	<c:if test="${empty dto }">
	<div id="memberReport">
		<div class="row">
			<div class="title">
				신고 대상
			</div>
			<div class="content" id="nickname">
				
			</div>
		</div>
	</div>
	</c:if>
	<div class="line"></div>
	
	<div class="row">
		<div class="title">
			신고 사유
		</div>
		<div class="content-reason">
			<label><input type="radio" name="reason" value="홍보">홍보성 게시글<br></label>
			<label><input type="radio" name="reason" value="음란">음란성 또는 청소년에게 부적합한 게시글<br></label>
			<label><input type="radio" name="reason" value="비방">비방 또는 심한 욕설사용<br></label>
			<label><input type="radio" name="reason" value="기타">기타 사유</label>
			<textarea rows="3" id="_reasonTxt" name="reasonTxt"></textarea>
		</div>
	</div>
	
	<div class="row">
		<button id="reportBtn">신고하기</button>
	</div>
</form>
</div>

<script type="text/javascript">

$(function () {
	$("input[name='bad_email']").val($(window.opener.document).find("#memberProfileFrm input[name='bad_email']").val());
	$("#nickname").text($(window.opener.document).find("#memberProfileFrm input[name='nickname']").val());		

	$("input[name='reason']").on("change", function () {
		if($("input[name='reason']:checked").val() == "기타"){
			$("#_reasonTxt").css("display","block");
		}else{
			$("#_reasonTxt").css("display","none");
		}
	});
	
	$("#reportBtn").click(function () {
		
		var checked = $("input[name='reason']:checked").length;
		if(checked == 0){
			alert("신고 사유를 선택해주세요.");
			return false;
		}
		
		if($("input[name='reason']:checked").val() == "기타" && $.trim($("#_reasonTxt").val()) == ""){
			alert("신고 사유를 작성해주세요.");
			return false;
		}
		
		var check = confirm("신고는 한번만 가능합니다");
		if(check){
			
			if($("input[name='board_seq']").val() == null || $("input[name='board_seq']").val() == ""){
				$("input[name='board_seq']").val("0");
			}
			
			$("#cmreportForm").attr("action", "freeboard_commentreportAf.do");
			$("#cmreportForm").submit();
			
			self.close();				
		
		}else{
			self.close();	
		}
	});
});

</script>

</body>
</html>