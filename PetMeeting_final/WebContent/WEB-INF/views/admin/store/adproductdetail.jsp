<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting - 관리자</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<div id="right-panel" class="right-panel">
	<!--::header part start::-->
		<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
	<!-- Header part end-->

	<!-- Content -->
	<div class="content">
		<div class="container">
			<div style="margin: 40px 0;">
				<h4>상품 상세정보</h4>			
			</div>
			<table style="margin: auto">
				<colgroup>
					<col width="300"><col width="100"><col width="300">
				</colgroup>
				<tr>
					<td rowspan="6">
						<img alt="이미지없음" src="${pageContext.request.contextPath}/upload/${pbean.filename }" style="width: auto; height: 300px;">
					</td>
					<td><span class="category2">카테고리</span></td>
					<td>${pbean.category }</td>
				</tr>
				<tr>
					<td><span class="category2">상품코드</span></td>
					<td>${pbean.productcode }</td>
				</tr>
				<tr>
					<td><span class="category2">상품명</span></td>
					<td>${pbean.productname }</td>
				</tr>
				<tr>
					<td><span class="category2">상품 가격</span></td>
					<td>${pbean.price }</td>
				</tr>
				<tr>
					<td><span class="category2">상품 사이즈</span></td>
					<td>
						<c:forEach begin="0" end="${fn:length(pbean.psize) - 1 }" varStatus="i">
							${pbean.psize[i.index] }
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td><span class="category2">상품 색상</span></td>
					<td>
						<c:forEach begin="0" end="${fn:length(pbean.pcolor) - 1 }" varStatus="i">
							${pbean.pcolor[i.index] }
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<span class='category2' style="width: 100%">상세설명</span>		
						<div>
							${pbean.content }
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: center;">
						<button type="button" id="update-btn">수정하기</button>
						<button type="button" id="delete-btn">삭제하기</button>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function () {
	var productcode = "${pbean.productcode}";
	// 수정하기 클릭
	$("#update-btn").click(function () {
		location.href="adproductupdate.do?pcode=" + productcode;
	});
});
</script>
</body>
</html>