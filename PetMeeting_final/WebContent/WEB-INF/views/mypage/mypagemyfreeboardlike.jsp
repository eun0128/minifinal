<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypagemylike/css/mypagemyfreeboardlike.css">
</head>
<body>
 <header class="header_area">
    	<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>
    </header>

<div id="wrapper">

  <!-- Main -->
   <div id="main">
      <div class="inner">
        <h2>게시글 좋아요</h2>
       <hr>
       <div id="attend-tap">
		<font>게시글</font>
</div>
		 
       
           <div class="fund-searchbar">
            <form id="frm">
            <select name="board_code" id="_category">
							<option>게시판 유형</option>
							<option>강아지</option>
							<option>고양이</option>
							<option>기타 소동물</option>
						</select>
            
               <select name="category" id="_category">
							<option>분류 유형</option>
							<option>잡담</option>
							<option>찾아요</option>
							<option>정보</option>
							<option>질문</option>
							<option>자랑</option>
						</select>
						<select name="selection" id="_selection">
							<option>선택</option>
							<option>제목</option>
							<option>이메일</option>
						</select>
						<input type="text" class="input-text" value="" name="keyword" id="_keyword" autocomplete="off">
						 <img alt="d" src="./mypage_resources/mypage_s/images/searchIcon1.png" class="imgBtn" id="searchBtn">
            </form>
           </div>
          
       
      <div class="attend" id="_attend">
       <c:if test="${ empty freelist  }">
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
		  
	 <c:if test="${ !empty freelist  }">
		  <div class="freetablediv">
		  <table class="freetable" >
		  <col width="9%"><col width="41%"><col width="12.5%"><col width="12.5%"><col width="12.5%"><col width="12.5%">
		   <tr>
		      <th>번호</th>
		      <th>제목</th>
		      <th>유형</th>
		      <th>분류</th>
		      <th>작성자</th>
		      <th>좋아요</th>
		   </tr>
		   <c:forEach items="${freelist}" var="attend" varStatus="i">
		   <tbody id="section${i.index}">
          		<tr>
          		  <td><span class="freeindex">${i.index+1}</span></td>
          		  <td>${attend.title}</td>
          		  <td><c:if test="${'DOG' eq attend.board_code}">강아지</c:if>
          		      <c:if test="${'CAT' eq attend.board_code}">고양이</c:if>
          		      <c:if test="${'ETC' eq attend.board_code}">기타</c:if>
          		  </td>
          		  <td>${attend.category}</td>
          		  <td>${attend.email}</td>
          		  <td>${attend.likecount}</td>
          		</tr>

		   </tbody>
             </c:forEach>
          </table>
          </div>
       </c:if>
   
             <input type="hidden" class="nowpage" value="5" >
             <input type="hidden" class="totallist" value="${freelist.size() }"> 
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


   <jsp:include page="/WEB-INF/views/mypage/mypageSidemenu.jsp"/>
</div>   

<script type="text/javascript">

$("#js-btn-wrap").click(function () {
	 
	 var nowpage1=$(".nowpage").val();
	 $(".nowpage").val( Number(nowpage1)+5);     
	 var nowpage2=$(".nowpage").val();
	 
	 for(var i=0 ; i<nowpage2; i++){
		 $("#section"+i).fadeIn(2000);
	 }
	 var offset = $("#section" + nowpage1).offset();
    $('html, body').animate({scrollTop : offset.top}, 400);

	
	/*  alert("현재 페이지"+nowpage2);
	 alert("토탈페이지"+$(".totallist").val()); */
	 if(Number(nowpage2)>$(".totallist").val()){
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
	});

$("#searchBtn").on("click", function(){
 	$("#frm").attr("action","mypageboardlike.do").submit();

});

</script>
</body>
</html>





