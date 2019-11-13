<%@page import="org.omg.PortableInterceptor.SYSTEM_EXCEPTION"%>
<%@page import="java.util.List"%>
<%@page import="com.petmeeting.joy.playboard.model.PlayboardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypagemylike/css/mypagemyplaylistlike.css?after">
<link href="./mypage_resources/mypage_s/datepicker/datepicker.css" rel="stylesheet">
</head>
<body>
<%
/* List<PlayboardDto>list=(List)request.getAttribute("list"); */
//System.out.println("체크중임"+list.get(0));
%>
<header class="header_area">
    	<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>
</header>
<div id="wrapper">

  <!-- Main -->
	<div id="main">
		<div class="inner">
	
 <h2>나의 소모임</h2>
		 <hr>
<div id="attend-tap">
		<font>소모임</font>
</div>
		 


<div class="searchbar">
<form id="frm">
						<select name="category" id="_category">
							<option>모임 유형</option>
							<option>산책</option>
							<option>봉사</option>
							<option>원데이 클래스</option>
							<option>동호회</option>
							<option>기타</option>
						</select>
						<select name="selection" id="_selection">
							<option>선택</option>
							<option>제목</option>
							<option>장소</option>
							<option>일시</option>
						</select>
						<input type="text" class="input-text" value="" name="keyword" id="_keyword" autocomplete="off">
						 <img alt="d" src="./mypage_resources/mypage_s/images/searchIcon1.png" class="imgBtn" id="searchBtn">
				</form>
</div>


<div class="attend" id="_attend">
 <c:if test="${empty myattendList  }">
		     <section class="left-image">
              <div class="container-fluid">
                	<div class="row">
                		<div class="empty-playlist">
					  	<font>참여한 활동이 없습니다.</font>
                		</div>
                	</div>
               </div>
             </section>
		  </c:if>
		
		  <jsp:useBean id="dateUtil" class="com.petmeeting.joy.mypage.util.MypageDateUtil"/>
		  <c:forEach items="${myattendList }" var="attend" varStatus="i">
				<jsp:setProperty property="date2" name="dateUtil" value="${attend.pdate }"/>
				<jsp:setProperty property="date3" name="dateUtil" value="${attend.edate }"/>
				<jsp:setProperty property="location" name="dateUtil" value="${attend.location }"/>
            <div id="section${i.index}">
            <section class="left-image">
              <div class="container-fluid">
                <div class="row">
                  <div class="col-md-4">
                       <img src="/PetMeeting/playboardUpload/${attend.filename }" alt="" class="mysize">
              <!--     <img src="${attend.filename }" alt=""> -->  
                  </div>
                  <div class="col-md-4">
                    <div class="right-content">
                      <h3>[${attend.category}] ${attend.title }</h3>
                      <div>
                      <img src="./mypage_resources/mypage_s/images/calendar.png" class="playicon">&nbsp;&nbsp;<jsp:getProperty property="dateString2" name="dateUtil"/><span id="expired-attend${i.index }" class="expired"></span>
                      </div>
                      <div>
                	    <img src="./mypage_resources/mypage_s/images/location.png" class="playicon">&nbsp;&nbsp;<font><jsp:getProperty property="simpleLoc" name="dateUtil"/></font>
                      </div>
                      <div>
                      <img src="./mypage_resources/mypage_s/images/like.png" class="playicon">&nbsp;&nbsp;<font>${attend.likecount }</font>                      
                      </div>
                      <div id="checkExpired-attend${i.index }" personcount="${attend.personcount}" people="${attend.people }" isEnd="<jsp:getProperty property='isEnd3' name='dateUtil'/>">
    	            <img src="./mypage_resources/mypage_s/images/people.png" class="playicon">&nbsp;&nbsp;<font>${attend.personcount}명 참여중  모집인원 ${attend.people }명</font>
                     </div>
                      <div class="primary-button" onclick="playboarddetail(${attend.seq})" seq="${attend.seq }" isEnd="<jsp:getProperty property='isEnd2' name='dateUtil'/>">
                        <a>Read More</a>
                      </div>
                    </div>
                  </div>
                 
                </div>
              </div>
            </section>
            
            

			<hr>
          </div>
             </c:forEach>
         
        

 <input type="hidden" class="nowpage" value="5" >
 <input type="hidden" class="totallist" value="${myattendList.size()}">
 <div id="js-btn-wrap" class="btn-wrap"><a href="javascript:;" class="moreBtn" style="color:#23527c">LOAD MORE</a> </div>

</div>
<!--::footer part start::-->
				<br>
			<footer>
			<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
			</footer> 
			<!-- footer part end-->

				</div>
			</div>


<!-- 메인 끝!!! -->
		
					
			
		
	<jsp:include page="/WEB-INF/views/mypage/mypageSidemenu.jsp"/>
</div>	
<script src="./mypage_resources/mypage_s/datepicker/datepicker.js"></script>
<script type="text/javascript">
function playboarddetail(e) {
	location.href="detailPlay.do?seq="+e;
	
	
};
 $("#js-btn-wrap").click(function () {
	 
	 var nowpage1=$(".nowpage").val();
	 $(".nowpage").val( Number(nowpage1)+5);     
	 var nowpage2=$(".nowpage").val();
	 
	 for(var i=0 ; i<nowpage2; i++){
		 $("#section"+i).fadeIn(2000);
	 }
	 var offset = $("#section" + nowpage1).offset();
     $('html, body').animate({scrollTop : offset.top}, 400);

	
	 
	 if(nowpage2>$(".totallist").val()){
		 $("#js-btn-wrap").hide();
	 }

});
	
	$(document).ready(function(){
		
		var nowpage=$(".nowpage").val();
		var totalsize=$(".totallist").val();
		
		 if(totalsize<=5){
		
	    	 $("#js-btn-wrap").hide();
	    }
		
		for(var i = Number(nowpage) ; i<totalsize ; i++){
			
			$("#section"+i).hide();
		}
		 
		
		
		
		
		
		<%
		List<PlayboardDto> attendlist = (List<PlayboardDto>)request.getAttribute("myattendList"); 
		
		
		for(int i=0;i<attendlist.size();i++){
			%>
			
			var people = $("#checkExpired-attend<%=i%>").attr("people");
			var personcount =  $("#checkExpired-attend<%=i%>").attr("personcount");
			var edate =  $("#checkExpired-attend<%=i%>").attr("isEnd");
			
			
			if(edate == 0 || people == personcount){
				$("#expired-attend<%=i%>").text("  마감 ");	
			}
		<%	
		}
		%>
		
	
		$("#searchBtn").on("click", function(){
	     	$("#frm").attr("action","mypageplayboardlike.do").submit();
	   
		});
		
		$("#_selection").on("change", function(){
			if($(this).val() == "일시"){
				$("#_keyword").attr("data-toggle","datepicker");
				$('[data-toggle="datepicker"]').datepicker();
			}
			else{
				$('[data-toggle="datepicker"]').datepicker("destroy");
				$("#_keyword").removeAttr("data-toggle","datepicker");
				
			}
		});
		
		
	});

	

	</script>

</body>
</html>