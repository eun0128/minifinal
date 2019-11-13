<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>PetMeeting</title>
	<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">	
</head>
<body>


<!--::header part start::-->
<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>    
<!-- Header part end-->
    

   <!-- banner part start -->
   <section class="banner_part">
   
   	<!-- Slideshow container -->
	<div class="slideshow-container">
	
	  <!-- Full-width images with number and caption text -->
	  <div class="mySlides fade">
	    <div class="numbertext">1 / 3</div>
	    <a href="productdetail.do?pcode=ETC0006">
	    <img src="${pageContext.request.contextPath}/common/img/slide(1).png" width="100%">
	    </a>
	  </div>
	
	  <div class="mySlides fade">
	    <div class="numbertext">2 / 3</div>
	    <a href="fundingDetail.do?board_seq=1&seq=1&email=${login.email}&board_code=FUND">
	    <img src="${pageContext.request.contextPath}/common/img/slide(2).png">
	    </a>	   
	  </div>
	
	  <div class="mySlides fade">
	    <div class="numbertext">3 / 3</div>
	     <a href="eventDetail.do?seq=5"><img src="${pageContext.request.contextPath}/common/img/slide(3).png"></a>
	   
	  </div>
	
	  <!-- Next and previous buttons -->
	  <a onclick="plusSlides(-1)"><img src="${pageContext.request.contextPath}/common/img/slide-left.png" class="prev" width="40px"></a>
	  <a  onclick="plusSlides(1)"><img src="${pageContext.request.contextPath}/common/img/slide-right.png" class="next" width="40px"></a>
	</div>		
	
   </section>
   
   <div class="container">
	   	<div class="eventBoard">
		   <div class="col-md-12">
			<div class="boardTitle">다가오는 반려동물 행사</div>
			<c:forEach items="${eventList }" var="eList">
				<div class="eventRow">		
					
					<div class="eventDate">			
					<fmt:formatDate value="${eList.event_sdate }"  pattern="MM월 dd일"/>
					</div>
					<a class="eventAnchor" seq="${eList.seq }">${eList.title }</a>	
					
				</div>
			</c:forEach>
			</div>
			<div align="center">
	    	<button type="button" class="goBoard" id="goEventboard" onclick="location.href='eventBoard.do'">VIEW MORE</button>
	  		</div>
		</div>
		 
   </div>
   
   
   
   <div class="container">
   	<div class="todayNewest">
   
   	 <div class="col-md-6">
   	 	<div class="newBoard">
   	 		<div class="boardTitle">소모임 최신글</div>
   	 		
		    <c:if test="${empty todayPlayboard }">오늘 올라온 소모임 없음</c:if>
		    <c:if test="${not empty todayPlayboard }">
		    	<c:forEach items="${todayPlayboard }" var="pList">		    		
		    		<a class="playboardAnchor" seq="${pList.seq }">
		    			<font class="newicon">NEW</font>&nbsp;${pList.title }
		    		</a>
		    	</c:forEach>
		    
		    </c:if>		
		    <div align="center">
	    	<button type="button" class="goBoard" id="goPlayboard" onclick="location.href='playboard.do'">VIEW MORE</button>
	    	</div>    
	    </div>
	    
	  </div>
    

   	 <div class="col-md-6">
   	 	<div class="newBoard">
   	 		<div class="boardTitle">자유게시판 최신글</div>
   	 	
		    <c:if test="${empty todayFreeboard }">오늘 올라온 자유게시판 글 없음</c:if>
		    <c:if test="${not empty todayFreeboard }">
		    	<c:forEach items="${todayFreeboard }" var="fList">
		    		<a class="freeboardAnchor" seq="${fList.seq }">
		    			<font class="newicon">NEW</font>&nbsp;${fList.title }
		    		</a>
		    	</c:forEach>
		    
		    </c:if>
		     <div align="center">
	    	<button type="button" class="goBoard" id="goFreeboard">VIEW MORE</button>
	     	</div>
	    </div>
	    
	  </div>
  
    </div>   
   </div>
   
   

<!--::footer part start::-->    
<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
<!-- footer part end-->
    
<!-- 슬라이드 쇼 스크립트 -->
<script src="${pageContext.request.contextPath}/common/navbar/js/slideshow.js"></script>    

<script type="text/javascript">
/* 최신 소모임 제목 클릭 스크립트 */
$(document).on('click', '.playboardAnchor', function(){
	if("${login.email }" == ""){
		alert("로그인을 하셔야 글을 보실 수 있습니다.");
		location.href="login.do";
	}else{
		location.href="detailPlay.do?seq="+$(this).attr("seq");
	}
});

$(document).on('click', '.freeboardAnchor', function(){
	if("${login.email }" == ""){
		alert("로그인을 하셔야 글을 보실 수 있습니다.");
		location.href="login.do";
	}else{
		location.href="freeboard_boarddetail.do?seq="+$(this).attr("seq");
	}
});

$(".eventAnchor").click(function () {
	location.href="eventDetail.do?seq="+$(this).attr("seq");
});


$(document).ready(function () {
	 Notification.requestPermission(function (status) {
	   // This allows to use Notification.permission with Chrome/Safari
	  // alert("status"+status);
	   if (Notification.permission !== status) {
	     Notification.permission = status;
	   }
	 });
	
	$.ajax({
		 type:"POST",
		 url:"mypagemsgpush.do",
		 async: false,
		 success:function(data){
			 var split_res=data.split('/');
			 var count=split_res[1];
 			if(count!='-1'){
				$(".nowmymsg").val(count);				
			}			
		  },error:function(){
			  alert("실패!");
		  }
	   });
       
		// var notification = new Notification("새 쪽지가 등록 되었습니다");
    function noti() {	   	
		$.ajax({
			 type:"POST",
			 url:"mypagemsgpush.do",
			 async: false,
			 success:function(data){
						 
				 var split_res=data.split('/');
				 var email=split_res[0];
				 var count=split_res[1];
				 
				//alert("이메일"+email);
				 //alert("카운트"+count);
				 				 
				 if(count!='-1'){
					 					 
					 if($(".nowmymsg").val()<count){
							
					    var options={
					        icon:"https://img.icons8.com/cotton/2x/topic-push-notification.png",
					    	body:"새 쪽지가 도착 하였습니다. ",
					    	onclick:"alert('d');"
					    }				    		
					Notification.requestPermission().then(function(result) {
										
				      if(result=='denied'){
				      alert(email+"님으로 부터 쪽지가 왔습니다");	
				  }else{
						var notification = new Notification(email+"님으로 부터 쪽지가 왔습니다",options);
					    notification.onclick =function (){
					       location.href="myrevmsg.do?recordCountPerPage=10";
					    }										  
				  }								 
			});						 
						$(".nowmymsg").val(count);
					}else{
						//alert(data);
					}					
				}				 
				 
			  },error:function(){
				  alert("실패!");
			  }
		   });
	}	
	 setInterval(noti,2000);	 	
});
	
</script>


</body>
</html>