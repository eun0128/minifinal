<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내프로필 보기</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 유정추가 myprofile CSS Files -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/mypage_resources/mypage_j/css/myprofilemodal.css">

</head>
<body>

	<div align="center">myProfileView.jsp</div>
	
	<div class="modal-header"> <!-- Modal 제목  -->
		<h4 class="modal-title" id="myModalLabel">MyProfile</h4>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	
	<div class="modal-body">	<!-- Modal 내용  -->
		<form id="profilemodalfrm">
		<table>
			<colgroup>
				<col width="30%"><col width="70%">
			</colgroup>
			
			<tbody>
				<tr>
					<td><div class="tbcaptiontitle">이메일</div></td>
					<td><div><input type="text" value="${login.email }"></div></td>
				</tr>
			</tbody>
		</table>
		</form>
		
		
<%-- 		
		<div>
			이메일
			<span></span>
		</div>
		
		<div>닉네임
		<input type="text" size="50" value="${login.nickname }">
		</div>
		<div>나이
		<input type="text" size="50" value="${login.nickname }">
		</div>
		<div>성별
		<input type="text" size="50">
		</div>
		<div>소개
		<input type="text" size="50">
		</div>
	 --%>
	
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	</div>
	
</body>
</html>