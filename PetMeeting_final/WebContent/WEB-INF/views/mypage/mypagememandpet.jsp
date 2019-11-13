<%@page import="com.petmeeting.joy.mypage.model.Mypagememandpet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/css/profile.css?after">

</head>
<body style="overflow-x:hidden; overflow-y:auto;" >

<%
Mypagememandpet profile=(Mypagememandpet)request.getAttribute("proflie");
%>
<div class="profile">
<div class="mempic">
      <%
      if(profile.getMyprofile_img()==null|| profile.getMyprofile_img()==""){
         %>
        <img alt="" src="${pageContext.request.contextPath}/mypage_resources/common/sidemenu/images/user.png" class="myprofileimg">    	 
         <%
      }else{
    	  %>
            <img alt="" src="<%=profile.getMyprofile_img()%>">	  
    	  <%
      }
      %>
</div>

<div class="petpic">
<%
 if(profile.getPetprofile_img()==null|| profile.getPetprofile_img()==""){
	 %>
	   <img alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/dog.png">    	 
	 <%
 }else{
	 %>
	  <img alt="" src="upload/<%=profile.getPetprofile_img()%>">	  
	 <%
 }
%>
</div>

<div class="followbox">

<div class="follower">
			<a class="followcount" id="followercount"><%=profile.getFollower() %></a> 
			<span class="followkor">팔로워</span>
		</div>
	
		<div class="following">
			<a class="followcount" id="followingcount"><%=profile.getFollowing() %></a>
			<span class="followkor">팔로잉</span>
		</div>
		
		
	   <div class="followmsg">
	         <img  onclick="myfollowsendmsg('<%=profile.getNickname() %>','<%=profile.getEmail() %>')" alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/mail.png" >    	 
	   </div>
</div>


<div class="MyprofileDetail">
<h3 class="usernickname" style="color:white"><%=profile.getNickname() %></h3>
<h3 class="useremail" style="color:white"><%=profile.getEmail() %></h3>
<%
if(profile.getMyintro()==null || profile.getMyintro()==""){
	%>
	<h3 class="userintro" style="color:black">등록된 자기소개가 없습니다</h3>
	<%
}else{
	%>
	<h3 class="userintro" style="color:black"><%=profile.getMyintro() %></h3>
	<%
}
%>

</div>

</div>

</body>

<script type="text/javascript">
function myfollowsendmsg(n,e) {



 var url =  "mypageFollowreplymsg.do?to_email="+e+"&nickname="+n;
	var option = "scrollbars=no, left=400,top=200, width=472, height=595";
	var name = "새 쪽지";
	window.open(url, name, option);
	
}


</script>
</html>