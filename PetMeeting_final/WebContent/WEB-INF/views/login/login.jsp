<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- 유정추가 로그인모달창 CSS Files -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/login_resources/css/loginmodal.css">

</head>
<body>
	<div class="form-structor">
	
		<!-- 회원가입 -->
		<div class="signup slide-up">		
			<h2 class="form-title" id="signup">회원가입</h2>
			<div class="form-holder">
				<form id="account-form" name="accountform" autocomplete="off">
					<input type="hidden" name="myprofile_img" value="">
					<input type="hidden" name="accessToken" value="">
					
					<!-- 이메일 -->
					<input type="text" class="email_input" name="email" placeholder="* 이메일(userid@sitename.com)">					
					<button type="button" id="emailCheck-Btn" class="checked_input" disabled="disabled">이메일인증</button>
				
					<!-- 이메일 인증코드 확인 -->
					<input type="text" class="authCode_input displayis" placeholder="인증코드를 입력하세요">				
					<button type="button" class="checked_input displayis" id="authCodeCheck-Btn">인증확인</button>
					
					<!-- 비밀번호 -->
					<input type="password" class="input" name="pwd" placeholder="* 비밀번호(영,숫자,특수문자포함 8~16자리)">
					<input type="password" class="pwd_input" placeholder="비밀번호확인">
					<input type="text" value="" class="pwdCheckMsg" disabled="disabled">
					
					<!-- 닉네임 -->
					<input type="text" class="nickname_input" name="nickname" placeholder="* 닉네임 " >
					<button type="button" id="nicknameCheck-Btn" class="checked_input">사용하기</button>
					
					<input type="text" class="input" name="name" placeholder="* 이름">
					
					<input type="text" class="postcode_input" id="sample6_postcode" name="postcode" placeholder="우편번호" readonly="readonly">
					<input type="button" class="checked_input" id="postcodeSearch" onclick="sample6_execDaumPostcode()" value="우편번호검색">
					
					<input type="text" class="input" id="sample6_address" name="address" placeholder="주소" readonly="readonly">
					<input type="text" class="input" id="sample6_detailAddress" name="address_detail" placeholder="상세주소">
					<input type="text" class="input" id="sample6_extraAddress" name="address_refer" placeholder="참고항목" readonly="readonly">
					<input type="text" class="input" name="phone" onKeyup="inputPhoneNumber(this);" maxlength="13" placeholder="* 연락처(13자리이내)" pattern="(010)-\d{3,4}-\d{4}">
				</form>
			</div>
			<button type="button" class="submit-btn" id="account-btn" disabled="disabled">회원가입</button>
		</div>

		<div class="modal-body">
		
		
		<!-- 로그인 -->
			<div class="login">
				<div class="center">
					<h2 class="form-title" id="login">로그인</h2>
					
					<div class="form-holder">
						<form id="login-form" name="loginform">
							<input type="text" class="input" placeholder="Email" name="email" autocomplete="new-password"/>
							<input type="password" class="input" placeholder="Password" name="pwd" />
						</form>
					</div>
					
					
					
					
					
					
					<!-- 아이디,패스워드 찾기 -->
					<div class="lg_links" align="center">
						<!-- id저장 -->
						<div class="lg_link_idsave">
						<input type="checkbox" id="idSaveCheck"><span class="idsave_text">ID저장</span>
						</div>
						
						<div class="lg_link_find">
						<a href="javascript:emailfind()" class="lg_find_text">계정</a>·
						<a href="javascript:emailfind()" class="lg_find_text">비밀번호 찾기</a>
						</div>
					</div>
					
					
					<button type="button" class="submit-btn" id="login-btn">로그인</button>
					
					<div align="center">
						<a id="custom-login-btn" href="javascript:loginWithKakao()">
						<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" id="kakaologbtn"/>
						</a>
						<a href="http://developers.kakao.com/logout">카카오 로그아웃(임시)</a>
					</div>
					

					
					
				</div>
			</div>
		</div>
	</div>

<script	src="${pageContext.request.contextPath}/login_resources/js/login_open_change.js"></script> <!-- 로그인/회원가입 뷰변경 -->
<script	src="${pageContext.request.contextPath}/login_resources/js/js-kakaologin.js"></script> <!-- 카카오로그인  -->
<script src="${pageContext.request.contextPath}/login_resources/js/js-cookie.js"></script> <!-- id쿠키저장 -->
<script	src="${pageContext.request.contextPath}/login_resources/js/input_check.js"></script> <!-- 로그인/회원가입 submit -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 우편api -->

<script type="text/javascript">
// 우편 api
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
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
};





// 휴대폰번호 하이픈 자동추가, 제어
function inputPhoneNumber(obj) {
	var regexp = /[^0-9\-]/gi;
	var num = obj.value;
	
	if( regexp.test( num ) ){
		alert("숫자만 입력 가능합니다");
		obj.value = obj.value.replace(regexp, '');
		return false;
	}
	
    var number = obj.value.replace(/[^0-9]/g, "");
    var phone = "";
    
    if(number.length < 4) {
        return number;
    } else if(number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    } else if(number.length < 11) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 3);
        phone += "-";
        phone += number.substr(6);
    } else {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 4);
        phone += "-";
        phone += number.substr(7);
    }
    obj.value = phone;
}


// 이메일찾기
function emailfind() {
	
	alert("emailfind클릭");
	
	var url = "emailfind.do";
	var option = "scrollbars=no, left=200,top=200, width=650, height=530";
	var name = "내 계정 찾기";
	window.open(url, name, option);
	
}


</script>
</body>
</html>