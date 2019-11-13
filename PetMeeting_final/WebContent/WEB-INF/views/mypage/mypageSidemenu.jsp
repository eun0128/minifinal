<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String fupload = "/mypage_resources/myprofile/userProfileIMG/"; //프로젝트 내부 경로
   String fupload2 = request.getServletContext().getRealPath("/upload/");  //톰캣경로
%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link
	href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700"
	rel="stylesheet">
<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Additional CSS Files -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/css/fontawesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/css/templatemo-style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/css/owl.css">

</head>

<body>
<c:if test="${login eq null}">
	<script type="text/javascript">
		alert("세션이 종료되었습니다. 다시 로그인 하세요");
		location.href="login.do";
	</script>
</c:if>

	<!-- Sidebar -->
 <div id="sidebar">
	 	   <a href="#sidebar" class="toggle">Toggle</a>
	      <div class="inner">
				<aside class="Myprofile">
	<div class="imgs">
		<!-- <div class="myprofileimg_box"></div> -->
		
		<img alt=""
			src="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/images/profile.png"
			class="mysidebar_myprofileimg">
		
		<img alt=""
			src="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/images/petprofile.jpg"
			class="mypetprofileimg">
	
		<!-- 들어온 프로필, 펫프로필 이미지 EL변수-->											
		<c:set var="myimg" value="${userProfile.myprofile_img}"/>
		<c:set var="petprofile_img" value="${mypet.petprofile_img}"/>
		
		<!-- 프로필세션의 프로필이미지 있는경우 -->
		<c:if test="${userProfile.myprofile_img ne null}">
			<script>
				var myprofileimg = '<c:out value="${myimg }"/>';							
				$(".mysidebar_myprofileimg").attr("src", "upload/" + myprofileimg);
			</script>
		</c:if>
			
		<!-- sns가입하여 이미지주소 형태로 프로필사진이 저장되어 있는 경우 주소url 그대로 반영 -->
		<c:if test="${fn:contains(myimg,'http')}">
			<script>
				var myprofileimg = '<c:out value="${myimg}"/>';
				$(".mysidebar_myprofileimg").attr("src", myprofileimg);
			</script>
		</c:if>
				
		<!-- 펫프로필세션의 펫프로필이미지 있는경우 -->
		<c:if test="${mypet.petprofile_img ne null}">
			<script>
				var petprofile_img = '<c:out value="${petprofile_img }"/>';							
				$(".mypetprofileimg").attr("src", "upload/" + petprofile_img);
			</script>
		</c:if>
		
		
	</div>

	<div class="followbox">
		<div class="follower">
			<a class="followcount" id="followercount"></a> <span class="followkor">팔로워</span>
		</div>
	
		<div class="following">
			<a class="followcount" id="followingcount"></a> <span class="followkor">팔로잉</span>
		</div>
	
	</div>
	
	<div class="MyprofileDetail">				
		<h3 class="usernickname" style="color:white">${login.nickname }</h3><!-- 유정수정 PetMaster -->
		<h6 class="useremail" style="color:white">${login.email }</h6><!-- 유정수정 petmeetingjoy@gmail.com -->
		<p class="userintro">Hi, we are pet-friendly community platform. please feel free
			to enjoy our service and contact us:)</p>
			
		<c:if test="${userProfile.myintro ne null }">
			<c:set var="myintro" value="${userProfile.myintro }"/>
			<script>
				
				var myintro = '<c:out value="${myintro}"/>';
				myintro = myintro.split('&lt;br/&gt;').join("<br>");
				$(".userintro").html( myintro );
				
			</script>
		</c:if>
		</div>
					
	</aside>
	         <!-- Menu -->
	        <nav id="menu">
	          <ul>
	           <!-- 유정 part 1  -->
	
		<li><span class="opener">프로필 정보</span>
			<ul>
				<li><a href="myprofile.do">나의 프로필</a></li>
				<li><a href="mypetprofile.do">펫의 프로필</a></li>
			</ul></li>
	
		<!-- 혜연 part 1  -->
		<li><span class="opener">나의 활동</span>
			<ul>
				<li><a href="mycalendar.do">나의 일정</a></li>
				<li><a href="mypageplaylist.do">나의 소모임</a></li>
				<li><a href="mypagefundinglist.do">나의 후원 내역</a></li>
			</ul></li>
		
		<!-- 혜연 part 2 -->
	<li><span class="opener">나의 쪽지함<font class="unreadMsg" color="white"></font></span>
		<ul>
			<li><a href="myrevmsg.do?recordCountPerPage=10" style="display:inline;">받은 쪽지함</a><font class="unreadMsg" style="background:none;"></font></li>
			<li><a href="mysendmsg.do?recordCountPerPage=10">보낸 쪽지함</a></li>
		</ul></li>
		
		
		<!-- 현아 part 1  -->
		<li><span class="opener">나의 좋아요</span>
			<ul>
				<li><a href="mypagefundinglike.do">나의 후원</a></li>
				<li><a href="mypageplayboardlike.do">나의 소모임</a></li>
				<li><a href="mypageboardlike.do">나의 게시글</a></li>
			</ul></li>
		
		
		<li><a href="mypagefollow.do">나의 구독</a></li>
	
		<!-- 현아 part 2 -->	
		<li><span class="opener">나의 회원 정보</span>
			<ul>
				<li><a href="mypageInfoupdate.do">회원정보 수정</a></li>
				<li><a href="mypagepasswordUpdate.do">비밀번호 변경</a></li>
				<li><a href="mypageMemberleave.do">회원 탈퇴</a></li>
				<li><a href="mypagePhoneCheck.do">휴대폰 인증</a></li>
			</ul></li>
	          </ul>
	        </nav>
	      </div>
</div>

<script src="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/js/browser.min.js"></script>
<script src="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/js/breakpoints.min.js"></script>
<script src="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/js/owl-carousel.js"></script>
<script src="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/js/custom.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	/* 읽지 않은 받은 쪽지 수  */
	$.ajax({
		type : "post",
		url : "countunreadmsg.do",
		success : function(data) {
			$(".unreadMsg").text(data);
		},
		error:function(request,status,error){
	        alert("code:"+request.status + "message:"+request.responseText+"error:"+error);
		}
	});
	
	/* 팔로워/팔로잉의 수  */
	$.ajax({
		type : "post",
		url : "gettotalflwcount.do",
		dataType : "json",
		success : function(data) {
			var followingcount = data.followingcount;
			var followercount = data.followercount;
			
			$("#followercount").html(followercount);
			$("#followingcount").html(followingcount);
			
		},
		error:function(request,status,error){
	        alert("code:"+request.status + "message:"+request.responseText+"error:"+error);
	     
		}

	});
});

</script>

</body>


</html>
