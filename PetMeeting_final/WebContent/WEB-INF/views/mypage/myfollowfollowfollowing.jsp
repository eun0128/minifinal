<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/mypage_resources/mypage_h/msgbox/msgbox_style.css">
</head>
<body>
<form class="frm">
		<div class="flw-header">
			<div id="following" flw="${flw }">
				<font><b>${myfollowings } &nbsp;&nbsp; 팔로잉</b></font>
			</div>
			<div id="follower">
				<font><b>${myfollowers } &nbsp;&nbsp; 팔로워</b></font>
				
			</div>
		</div>
		<div class="flw-body" >
			<div id="flw-search">
				<select name="selection" id="_selection" class="select-flw">
					<option>선택</option>
					<option>닉네임</option>
					<option>이메일</option>
				</select>
				 <input type="text" class="input-flw" value="" name="keyword" id="_keyword" autocomplete="off">
				 <img alt="d" src="./mypage_resources/mypage_s/images/searchIcon1.png" class="flwimgBtn" id="searchBtn">
	
			</div>
			<div class="flwing-list" >
				<table class="flw-table" id="followingTable">
				 <input type="hidden" name="myemail" class="email" id="email" value="${email}">
					<col width="70px"><col width="260px"><col width="70px">
						<c:if test="${empty myfollowinglist }">
									<tr>
										<td colspan="3" align="center"><p>팔로잉 리스트가 없습니다.</p></td>
									</tr>
						</c:if>
					<c:forEach items="${myfollowinglist }" var="following" varStatus="i">
						<tr>
						    
							<c:if test="${following.myprofile_img == null}">						
								<td><img src="./mypage_resources/mypage_s/images/unknown.png" class="flw-img"></td>
							</c:if>
							<c:if test="${following.myprofile_img != null}">		
								<td><img src="${following.myprofile_img }" class="flw-img"></td>
							</c:if>
							<td align="left" style="padding:15px">
								<b>${following.nickname}</b>
								<br> 
								<font style="font-size:9pt" color="darkgray">${following.folloing_email }</font>
							</td>
							<td></td>
						</tr>
					</c:forEach>
				</table>
			</div>

			<div class="flwer-list" >
				<table class="flw-table" id="followerTable">
				<col width="70px"><col width="260px"><col width="70px">
						<c:if test="${empty myfollowerlist }">
									<tr>
										<td colspan="3" align="center"><p>팔로워 리스트가 없습니다.</p></td>
									</tr>
						</c:if>
					<c:forEach items="${myfollowerlist }" var="follower" varStatus="i">
						<tr>
							<c:if test="${follower.myprofile_img == null}">						
								<td><img src="./mypage_resources/mypage_s/images/unknown.png" class="flw-img"></td>
							</c:if>
							<c:if test="${follower.myprofile_img != null}">		
								<td><img src="${follower.myprofile_img }" class="flw-img"></td>
							</c:if>
							<td align="left" style="padding:15px">
								<b>${follower.nickname}</b>
								<br> 
								<font style="font-size:9pt" color="darkgray">${follower.myemail }</font>
							</td>
							<td></td>
						
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		</form>
		  <div id="pop-up-window-contact">

	    </div>
		
		
<script type="text/javascript">
$(document).ready(function(){
	
	//로드했을 때 팔로잉인지 팔로워인지 체크 - 검색 후 바로 그 화면이 뜨기 위해서 하는 것 
	var flw = $("#following").attr("flw");
	
	
	//메뉴가 팔로잉인지 팔로워인지에 따라서 배경색 변경 & 리스트 감추기 
	if(flw == 'ing'){
		$(".flwer-list").hide();	
		$("#following").css("background-color","rgb(241,238,235,0.6)");
		$("#follower").css("background-color","white");
	
	}
	else if(flw == 'wer'){
		$(".flwing-list").hide();
		$("#follower").css("background-color","rgb(241,238,235,0.6)");
		$("#following").css("background-color","white");
	}
	
	//팔로워 메뉴를 눌렀을 때 팔로워 메뉴가 보이게끔 하는 것 
	$("#follower").on("click",function(){
	
		$(this).css("background-color","rgb(241,238,235,0.6)");
		$("#following").css("background-color","white");
		$(".flwer-list").show();
		$(".flwing-list").hide();
		$("#following").attr("flw","wer");

	});
	
	//팔로잉 메뉴를 눌렀을 때 팔로잉 메뉴가 모이게끔 하는 것 
	$("#following").on("click",function(){
		
		
		$(this).css("background-color","rgb(241,238,235,0.6)");
		$("#follower").css("background-color","white");
		$(".flwing-list").show();
		$(".flwer-list").hide();
		$(this).attr("flw","ing");
	});
	
	//팔로워 || 팔로잉 검색하는 검색 버튼 
	$("#searchBtn").on("click", function(){
		var contactSearch = $(".frm").serialize();
	    var myemail=$(".email").val();
	    alert("22"+myemail);
	    
	    var option = "scrollbars=no, left=400,top=200, width=492, height=595";
		window.open("mypagefollowfollower.do?myemail="+myemail+"&selection="+$(".select-flw").val()+"&keyword="+$(".input-flw").val()+"&flw="+ $("#following").attr("flw"),name,option);
	    
	    
/* 
		   $.ajax({
				type : "post",
				url : "mypagefollowfollower.do",
				data : contactSearch,
				dataType : "text",
				success : function(obj) {
					alert("성공");
			
					//어느 메뉴에서 검색했는지 체크하고 선택지, 검색어를 함께 보내는 중 
					var flw = $("#following").attr("flw");
					var selection = $("#_selection").val();
					var keyword = $("#_keyword").val();
				
					location.href=""
					
					$("#pop-up-window-contact").load("getcontact.do?selection="+selection+"&keyword="+keyword+"&flw="+flw);
				},
				error : function() {
					alert("실패의 참맛");
				}
			}); 
			 */
	  	
	   });

});

	
</script>
</body>
</html>