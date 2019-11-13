<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 계정 찾기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/login_resources/css/loginInfoFind.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>

<div class="emailfind">
	<div class="emailfind_title">
		<h1>로그인 정보 찾기</h1>
		<hr>
	</div>

	<div class="emailfind_main" id="_emailfind_main">
		<div class="label_pwd">
			<font class="label_text">비밀번호찾기</font>
		</div>
		
		<!-- //해당 부분 계정이메일 찾기부분인데, 찾을방법을 찾을 수 없습니다..
		<div class="label_email">
			<font class="label_text">이메일찾기</font>
		</div>
		
		<div class="emailfind_box1" id="frm1">
			<form id="idfindfrm">
			<h3>본인확인 이메일로 인증</h3>
			<p>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
			<table class="emailfind_tb">
				<colgroup>
					<col width="20%"><col width="50%"><col width="30%">
				</colgroup>
				
				<tr>
					<th>이름</th>	
					<td><input type="text" name="name" id="frm1_name"></td>
				</tr>
				
				<tr>
					<th>이메일 주소</th>
					<td><input type="text" name="email" id="frm1_email"></td>
					<td>
					<button class="emailfind_emailAuth_Btn" id="emailAuthSend_btn">인증번호 받기</button>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><input type="text" placeholder="인증번호 입력" disabled="disabled" id="emailAutNum"></td>
				</tr>
			</table>
			</form>
		</div>
		
		 -->
		
		<div class="emailfind_box1" id="frm2">
			<form id="pwdfindfrm">
			<h3>비밀번호 찾기</h3>
			<p>가입한 계정 이메일주소와 입력한 이메일 주소가 같아야 계정 확인 인증번호를 받을 수 있습니다. 비밀번호는 8~16자 이내 영문, 숫자, 특수문자(!@#$%^*+=-)의 조합으로 입력해주세요. </p>
			<table class="emailfind_tb">
				<colgroup>
					<col width="20%"><col width="50%"><col width="30%">
				</colgroup>
				
				<tr>
					<th>이메일 주소</th>
					<td><input type="text" id="frm2_email" name="email"></td>
					<td>
					<button type="button" class="emailfind_emailAuth_Btn" id="emailAuthSend_btn">인증번호 받기</button>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><input type="text" placeholder="인증번호 입력" disabled="disabled" id="emailAutNum"></td>
					<td>
					<button type="button" class="emailfind_emailAuth_Btn" id="emailAuthCheck_btn">인증확인</button>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><input type="password" placeholder="새 비밀번호 입력" disabled="disabled" id="frm2_pwd"></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="password" placeholder="새 비밀번호 재확인" disabled="disabled" name="password" id="frm2_pwdCheck"></td>
					<td><input type="text" value="" class="pwdCheckMsg" disabled="disabled"></td>
				</tr>
			</table>
			</form>
		</div>
		
		<font class="nextBtn">비밀번호변경하기</font>
	</div>
</div>

<script	src="${pageContext.request.contextPath}/login_resources/js/loginInfoFind.js"></script>
</body>
</html>