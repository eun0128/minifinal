<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pet Meeting - 관리자</title>
 <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style type="text/css">
div.section {
    display: block;
	width: 45%;
/*     height: 350px; */
    height: 320px;
    float: left;
    margin: 20px 20px;
    padding: 10px;
    text-align: center;
}

div.circle{
	display: inline-block;
	width: 120px;
	height: 120px;
	border-radius: 50%;
	background-color: #F7B32A;
	font-size: 15px;
	text-align: center;
	line-height: 50px;
	margin-top: 40px;
	margin-left: 15px;
}

div.delivery-wait{
	background-color: #4c8bff;
}

div.delivery-ing{
	background-color: #bd85d0;
}

div.playboard{
	background-color: #b6a8d4;
}

div.freeboard{
	background-color: #e2adad;
}

div.fundingboard{
	background-color: #7dc59c;
}

.sub-title{
    padding: 5px;
    border-bottom: 2px solid #777777;
	font-weight: bold;
}

ul li {
 list-style:none;
 padding: 2px;
}
</style>
</head>
<body>
    <div id="right-panel" class="right-panel">
		 <!--::header part start::-->
		 	<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
		 <!-- Header part end-->

        <!-- Content -->
        <div class="content">
        	<div class="container">
        		<div class="section left-top" >
        			<div class="sub-title" style="text-align: left;">
        				게시글 현황
        			</div>
        			<div>
        				<div class="circle playboard">
        					<img alt="" src="${pageContext.request.contextPath }/admin_resources/images/group.png" style="padding-top: 20px">
        					<p style="color: white">추가된 소모임<br><a href="adminPlayboardList.do" style="color: white;">${todayPlayCount } 건</a></p>
        				</div>
        				<div class="circle freeboard">
        					<img alt="" src="${pageContext.request.contextPath }/admin_resources/images/notepad.png" style="padding-top: 20px">
        					<p style="color: white">추가된 게시글<br><a href="" style="color: white;"> ${todayFreeCount } 건</a></p>
        				</div>
        				<div class="circle fundingboard">
        					<img alt="" src="${pageContext.request.contextPath }/admin_resources/images/sponsored.png" style="padding-top: 20px">
        					<p style="color: white">오늘 마감된 후원<br><a href="adminFundingList.do" style="color: white;">${todayEndFundCount } 건</a></p>
        				</div>
       				</div>
        		</div>
        		
        		
        		<div class="section right-top">
       				<div class="sub-title" style="text-align: left;">
        				회원 신고 내역
        				<a href="adminMemberList.do" style="float: right;"><img alt="" src="${pageContext.request.contextPath }/admin_resources/images/more.png">&nbsp;더보기</a>
        			</div>
        			<div class="member-report-list">
        				<ul class="report-list">
							<c:if test="${reportlist == null  || reportlist.size() == 0 }">
								<li class="empty-qnalist" style="padding-top: 100px;">신고된 회원이 없습니다.</li>									
							</c:if>
							<c:if test="${reportlist != null }">
        					<c:forEach items="${reportlist }" var="reportlist">
        						<li class="memberEmail" style="text-align: left;"><font style="color: #E5433E; font-weight: bold;">${reportlist.email }</font>
	        					<div class="memberName" style="display: inline-block;">
        							${reportlist.name } <p style="display: inline-block;">(활동네임 : ${reportlist.nickname })</p>					
    	    					</div>
    	    					<div class="reportCount" style="display: inline-block;">
    	    						${reportlist.reportcount }건
    	    					</div>
        						</li> 
        					</c:forEach>
        					</c:if>
        				</ul>
       				</div>
        			
        		</div>
        		<div class="section left-bottom">
        			<div class="sub-title" style="text-align: left;">
        				판매 진행 현황
        			</div>
        			<div>
        				<div class="circle">
        				
        					<img alt="" src="${pageContext.request.contextPath }/admin_resources/images/credit-card.png" style="padding-top: 20px">
        					<p style="color: white">오늘의 주문<br><a href="adorderlist.do" style="color: white;">${todayOrderCount } 건</a></p>
        				</div>
        				<div class="circle delivery-wait">
        					<img alt="" src="${pageContext.request.contextPath }/admin_resources/images/delivery-wait.png" style="padding-top: 20px">
        					<p style="color: white">배송 대기<br><a href="adorderlist.do" style="color: white;">${deliveryWaitCount } 건</a></p>
        				</div>
        				<div class="circle delivery-ing">
        					<img alt="" src="${pageContext.request.contextPath }/admin_resources/images/delivery-truck.png" style="padding-top: 20px">
        					<p style="color: white">배송중<br><a href="adorderlist.do" style="color: white;">${deliveryIngCount } 건</a></p>
        				</div>
       				</div>
        		</div>
        		
        		<div class="section right-bottom">
        			<div class="sub-title" style="text-align: left;">
        				최근 문의 내역
        				<a href="adquestionlist.do" style="float: right;"><img alt="" src="${pageContext.request.contextPath }/admin_resources/images/more.png">&nbsp;더보기</a>
        			</div>
       				<div class="qustion-list">
        				<ul class="qna-list">
							<c:if test="${qlist == null  || qlist.size() == 0 }">
								<li class="empty-qnalist" style="padding-top: 100px;">최근에 작성된 문의내역이 없습니다.</li>									
							</c:if>
							<c:if test="${qlist != null }">
        					<c:forEach items="${qlist }" var="list">
        						<li class="product-name" style="text-align: left;"><b>${list.productcode }</b>
        						<c:choose>
        							<c:when test="${fn:length(list.q_content) gt 25 }">
        								<c:out value="${fn:substring(list.q_content, 0, 24) }"/>...
        							</c:when>
        							<c:otherwise>
        								<c:out value="${list.q_content }"/>
        							</c:otherwise>
       							</c:choose>
	        					<div class="qna-writer" style="display: inline-block;">
        							<p style="text-align: right;">${list.nickname }</p>						
    	    					</div>
        						</li> 
        					</c:forEach>
        					</c:if>
        				</ul>
       				</div>
        		</div>

			</div>
			
		</div>
    </div>  

</body>
</html>