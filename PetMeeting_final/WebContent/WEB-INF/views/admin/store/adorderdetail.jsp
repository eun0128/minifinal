<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting - 관리자</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/custom.css">
<style type="text/css">

.caption {
	caption-side: top;
	text-align: left;
	font-weight: bold;
	font-size: 16px;
}
.boardTable td{
text-align: center;
}

.orderhead{
/* 	background-color: #008c9e; */
 	background-color: white;
	color: black;
	font-size: 17px;
    text-align: center;
}


</style>
</head>
<body>
	<div id="right-panel" class="right-panel">
		<!--::header part start::-->
		<jsp:include
			page="/admin_resources/admincss/templates/adminheader.jsp" flush="false" />
		<!-- Header part end-->
		<div class="content">
			<div class="container">
				<div style="margin: 40px 0;">
					<h4>상세 주문 내역</h4>
				</div>
					<table class="boardTable">
						<colgroup>
							<col width="200">
							<col width="250">
							<col width="120">
							<col width="150">
							<col width="200">
							<col width="200">
						</colgroup>
						<thead>
							<tr>
								<th colspan="2">상품정보</th>
								<th>수량</th>
								<th>배송비</th>
								<th>주문금액</th>
								<th>주문상태</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${mylist }" var="list" varStatus="vs">
								<tr>
									<td>
										<div class="product_img_link">
											<a
												href="${pageContext.request.contextPath}/productdetail.do?pcode=${list.productcode }">
												<img class="thumbnailImg" alt="이미지 없음"
												src="upload/${list.filename }" name="filename" width="100px">
											</a>
										</div>
									</td>
									<td>
										<div class="product_name" align="left">
											<b><a
												href="${pageContext.request.contextPath}/productdetail.do?pcode=${list.productcode }">${list.productname }</a></b><br>
											[사이즈] ${list.psize }<br> [색상] ${list.pcolor }
										</div>
									</td>
									<td>${list.quantity }</td>
									<c:if test="${vs.count eq 1 }">
										<td rowspan="${fn:length(mylist) }">2,500원</td>
									</c:if>
									<td>${list.price * list.quantity }</td>
									<td>
										<c:if test="${list.status eq 0}">
											배송준비중
										</c:if>
										<c:if test="${list.status eq 1}">
											배송중
										</c:if>
										<c:if test="${list.status eq 2}">
											배송완료
										</c:if>
										<c:if test="${list.status eq 3}">
											주문 취소
										</c:if>
										<c:if test="${list.status eq 4}">
											반품 대기
										</c:if>
										<c:if test="${list.status eq 5}">
											반품 완료
										</c:if>
										<c:if test="${list.status eq 6}">
											교환 대기
										</c:if>
										<c:if test="${list.status eq 7}">
											교환 완료
										</c:if>
									</td>
								</tr>
							<c:set var="sum" value="${sum + (list.price * list.quantity) }" />
							</c:forEach>
							<tr>
								<td colspan="6" align="right">
									총 결제금액 ₩ <fmt:formatNumber value="${sum }" pattern="#,###"/>  + 배송비 2,500 &ensp; <c:if test="${not empty usepoint or usepoint ne 0 }"> <b>(사용포인트 ${usepoint }P)</b></c:if> &ensp; | 총 합계 <font color="#E5433E" size="6px" style="font-weight: bold"> ₩<fmt:formatNumber value="${sum + 2500 - usepoint }" pattern="#,###"/> </font>
<%-- 									총 결제금액 ₩ <fmt:formatNumber value="${sum }" pattern="#,###"/> + 배송비 2,500  &ensp;&ensp; | 총 합계 <font color="#E5433E" size="6px" style="font-weight: bold"> ₩<fmt:formatNumber value="${sum + 2500}" pattern="#,###"/> </font> --%>
								</td>
							</tr>
						
						</tbody>
					</table>
					<br><br><br>
				
					<c:forEach items="${mylist }" var="list" varStatus="vs" begin="0" end="0">
					<table class="boardTable">
					<caption class="caption">배송지정보</caption>
					<colgroup>
						<col width="200"><col width="770">
					</colgroup>
					<tbody>
						<tr>
							<td class="orderhead"><span>수령인명</span></td>
							<td style="text-align: left;">${list.rname }</td>
						</tr>
						<tr>
							<td class="orderhead"><span>수령인연락처</span></td>
							<td style="text-align: left;"><fmt:formatNumber var="phone" value="${list.rphone }" pattern="###,####,####" />
								0<c:out value="${fn:replace(phone, ',', '-')}" />
							</td>
						</tr>
						<tr>
							<td class="orderhead"><span>배송정보</span></td>
							<td style="text-align: left;">${list.raddress } ${list.raddress_detail } </td>
						</tr>
						<tr>
							<td class="orderhead"><span>추가 배송 메시지</span></td>
							<td style="text-align: left;">
								${list.require }
							</td>
						</tr>
					</tbody>
					</table>
					</c:forEach>
					<br><br><br><br>
					
				</div>
			</div>
		</div>

</body>
</html>