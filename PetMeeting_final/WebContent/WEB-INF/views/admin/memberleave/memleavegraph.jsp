<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pet Meeting - 관리자</title>
 <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	
	<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
	<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/admin_common.css?after"> --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/memberleave.css?after">

</head>
<body>
<div id="right-panel" class="right-panel">
	<!--::header part start::-->
		<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
	<!-- Header part end-->

	<!-- Content -->
	<div class="content">
	
		<div class="container">
		<div class="mainTitle">회원 탈퇴 목록</div>
		
			<form id="searchFrm">
				<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)? 0:pageNumber }">
				<select name="category" id="_category">
					<option value="전체">전체보기</option>
					<option value="시간">시간부족</option>
					<option value="스팸">스팸 </option>
					<option value="이메일변경">이메일 변경</option>
					<option value="정보부족">정보부족</option>
					<option value="기타">기타</option>
				</select>
				
				
				
				<div class="searchWrap">
				<select name="search_category" id="_search_category">
					<option value="선택">검색 분류</option>
					<option value="이메일">이메일</option>
				</select>
				<input type="search" name="keyword" id="_keyword">
				<button type="button" id="searchBtn" class="search-btn"></button>
				</div>
			</form>

       <table class="boardTable">
    <col width="30%"><col width="40%"><col width="30%">
       	<thead>
	        <tr>
				<th>E-Mail</th><th>사유</th><th>회원정보 보기</th>
         	</tr>
         	
		</thead>
		
		<tbody>
		   <c:if test="${empty list}">
		     <tr>
			    <td colspan="3" align="center">검색결과 없음</td>
		     </tr>
		   </c:if>
		   
		   <c:forEach items="${list }" var="mem" varStatus="i">
		     <tr>
		       <td align="center">${mem.email}</td>
		       <td align="center">
		           <c:if test="${mem.reason=='시간'}"> 사이트 이용 시간 부족</c:if>
		           <c:if test="${mem.reason=='스팸'}"> 스팸 문자나 스팸 게시물 너무 많음   </c:if>
		           <c:if test="${mem.reason=='이메일변경'}">이메일 변경을 위해 </c:if>
		           <c:if test="${mem.reason=='정보부족'}">사이트 정보 부족</c:if>
		           <c:if test="${mem.reason=='기타'}">기타</c:if>
		           <c:if test="${mem.reason=='그냥'}">사유 없음</c:if>
		       </td>
		       <td align="center"><button type="button" class="infoBtn" email="${mem.email }"></button></td>
		     </tr>
		   </c:forEach>
		</tbody>
		
       </table>
				<div class="pagingWrap">
				<jsp:include page="/WEB-INF/views/admin/memberleave/paging.jsp" flush="false">													
							<jsp:param name="pageNumber" value="${pageNumber }" />
							<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
							<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }"/>
							<jsp:param name="recordCountPerPage" value="${recordCountPerPage }"/>		
					</jsp:include>
				</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">

	var selected = "${searchbean.category}";
	if(selected == ""){
		$("#_category").val("전체").attr("selected",true);
	}else{
		$("#_category").val(selected).attr("selected",true);		
	}

$("select[name='category']").on("change", function () {

	$("#searchFrm").attr({"action":"adminMemleavegraph.do", "method":"post"}).submit();
});


$("#searchBtn").on("click", function () {
	   if($.trim($("input[name='keyword']").val()).length == 0){
		alert("검색어를 입력하십시오");
		$("input[name='search_txt']").focus();
		return false;
	}  else{
		$("#_pageNumber").val(0);
		$("#_category").val("${searchbean.category}");
		$("#searchFrm").attr({"action":"adminMemleavegraph.do", "method":"post"}).submit();
	}
	   

});

$(".infoBtn").click(function () {		
	var option = "width = 700, height = 800, top = 100, left = 300, location = no, resizeable = no";
	window.open("adminMemberDetail.do?email="+$(this).attr("email"), "memberDetail", option);
});

// 페이징
function goPage(pageNumber){
	$("#_pageNumber").val(pageNumber);
	$("#_recordCountPerPage").val("${searchbean.recordCountPerPage}");
	$("#_category").val("${searchbean.category}");
	$("#_search_category").val("${searchbean.search_category}");
	$("#_keyword").val("${searchbean.keyword}");
	$("#searchFrm").attr({"action":"adminMemleavegraph.do", "method":"post"}).submit();
}

</script>
</body>
</html>