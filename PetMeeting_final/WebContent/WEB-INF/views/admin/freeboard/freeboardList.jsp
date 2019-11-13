<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.petmeeting.joy.freeboard.model.FreeboardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	int totalRecordCount = (int)request.getAttribute("totalRecordCount");
	int pageNumber =  (int)request.getAttribute("pageNumber");
%>
<%
	String s_category = (String)request.getAttribute("s_category");
if(s_category == null) s_category = "";
	
String keyword = (String)request.getAttribute("s_keyword");
if(keyword == null) keyword = "";

%>
<%
	List<FreeboardDto> list = (List<FreeboardDto>)request.getAttribute("list");
%>

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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/playboard.css">
</head>
<body>

<div id="right-panel" class="right-panel">
	<!--::header part start::-->
		<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
	<!-- Header part end-->

	<!-- Content -->
	<div class="content">
	
		<div class="container">
		
		<div class="mainTitle"><a href="adminFreeboardList.do">자유게시판 글목록</a></div>
<form id="_frmFormSearch" name="frmForm1" class="_frmFormSearch" method="get" action="adminFreeboardList.do">		
			<!-- <form id="searchFrm"> -->
			
				<%-- 	<select name="choicesorting" id="sorting_" onchange="_sorting(this.value)">
						<option  value=""<c:if test="${empty sorting }">selected='selected'</c:if>>정렬</option>
						<option  value="old"<c:if test="${sorting eq 'old' }">selected='selected'</c:if> >오래된 작성순</option>
						<option  value="like"<c:if test="${sorting eq 'like' }">selected='selected'</c:if>>좋아요순</option>
						<option  value="read"<c:if test="${sorting eq 'read' }">selected='selected'</c:if>>조회수 많은 순</option>
					</select> --%>
					<select id="" name="category" id="category_" onchange="_category(this.value)">
						<option value="" <c:if test="${empty category }">selected='selected'</c:if>>분류</option>
						<option value="free"<c:if test="${category=='free' }">selected='selected'</c:if>>잡담</option>
						<option value="search" <c:if test="${category=='search'}">selected='selected'</c:if>>찾아요</option>
						<option value="infor"<c:if test="${category=='infor'}">selected='selected'</c:if>>정보</option>
						<option value="qna"<c:if test="${category=='qna'}">selected='selected'</c:if>>질문</option>
						<option value="boast"<c:if test="${category=='boast'}">selected='selected'</c:if>>자랑</option>
					</select>
						<input type="hidden" id="category_"
							<c:if test="${category=='free' }">value="free"</c:if>
							<c:if test="${category=='search' }">value="search"</c:if>
							<c:if test="${category=='infor' }">value="infor"</c:if>
							<c:if test="${category=='qna' }">value="qna"</c:if>
							<c:if test="${category=='boast' }">value="boast"</c:if>
																			>
						<input type="hidden" id="sorting_"
							<c:if test="${sorting=='old' }">value="old"</c:if>
							<c:if test="${sorting=='like' }">value="like"</c:if>
							<c:if test="${sorting=='read' }">value="read"</c:if>
																			>
				
				<div class="searchWrap">
				<select name="s_category" id="_s_category">
					<option value="">선택</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="nickname">닉네임</option>
				</select>
				<input type="search" class="s_keyword" name="s_keyword">
				<button type="button" id="searchBtn" class="search-btn"></button>
				</div>
<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber }">
<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
			<!-- </form> -->
</form>
			
			<form id="deleteboardform" action="adminFreeboardDelete.do" method="post">
				<table class="boardTable">
					<col width="5%"><col width="5%"><col width="10%"><col width="37%"><col width="15%"><col width="5%"><col width="15%"><col width="15%">
					<thead>
						<tr>
							<th><input type="checkbox" name="alldel"></th><th>No.</th><th>게시판</th><th>제목</th><th>닉네임</th><th>신고 수</th><th>작성일</th><th>상태</th>
						</tr>
					</thead>
					
					<tbody>
					
					 <%
                         	for(int i = 0; i < list.size(); i++) { 
                                                 	FreeboardDto fb = list.get(i);
                                                 	
                                                 	String from = fb.getRegdate();
                                                 	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                 	Date to = transFormat.parse(from);                                                 	
                                                 	
                         %>
					
					
						<%-- <c:forEach items="${playboardList }" var="pList" varStatus="i"> --%>
							<tr>
								<td align="center"><input type="checkbox" name="deleteboard" value="<%=fb.getSeq() %>"></td>
								<td align="center"><%=i %></td>
								<td align="center">
								<%if(fb.getBoard_code().equals("DOG")){ %>
	                                 	강아지
	                                <%}else if(fb.getBoard_code().equals("CAT")	){ %>
	                                	고양이
	                               <%} else{%>
	                               		기타 동물
	                               	<%} %>
								</td>
								<td style="padding-left: 20px;">
								<a href="adminFreeboardDetail.do?seq=<%=fb.getSeq()%>" style="color:black; "><%=fb.getTitle() %>&nbsp;&nbsp;&nbsp;(<%=fb.getCountreply() %>)</a>
								</td>
								<td align="center"><%=fb.getNickname()%></td>
								<td align="center"><%=fb.getReportcount()%></td>
								<td align="center"><%=transFormat.format(to) %></td>
								<td align="center">
								<%if(fb.getDel() == 0){ %>
	                                	게시중
	                                <%}else{ %>
	                                	삭제됨
	                               <%} %>
								</td>
								
							</tr>
						<%-- </c:forEach> --%>
						
						<% }%>
					</tbody>
				</table>
			</form>
			
			<input id="deleteBtn" type="button" value="삭제" onclick="delCheck()">
			
			<div id="paging_wrap">
			<jsp:include page="/WEB-INF/views/freeboard/paging.jsp" flush="false">
			<jsp:param name="pageNumber" value="${pageNumber }" />
			<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
			<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }" />
			<jsp:param name="recordCountPerPage" value="${recordCountPerPage }" />	
			</jsp:include>
</div>

</div>
			
		</div>
	</div>

<script type="text/javascript">


$(function () {
	
	
	/* 전체선택 및 전체선택 해제 */
	$("input:checkbox[name='alldel']").change(function() {
		if($("input:checkbox[name='alldel']").is(":checked")){
			//alert("체크");
			$("input:checkbox[name='deleteboard']").each(function () {
				$(this).prop("checked", true);
			});
		}else{
			//alert("체크 해제");
			$("input:checkbox[name='deleteboard']").each(function () {
				$(this).prop("checked", false);
			});
		}
	});
	
	
	$("#deleteBtn").click(function () {
		var checklen = $("input:checkbox[name='deleteboard']:checked").length;
		if(checklen == 0){
			alert("삭제할 글을 선택하세요!");
		}else{
			var check = confirm("선택하신 글들을 삭제하시겠습니까?");
			if(check){
				$("#deleteboardform").submit();
			}else{
				return false;
			}
		}
		
		
	});
	

});

function goPage( pageNumber ) {
	var sort = $("select[name=choicesorting]").val();
	var category = $("select[name=category]").val();
	
	
	
	$("#frm_sorting").val(sort);
	$("#frm_category").val(category);
	
	$("#_pageNumber").val(pageNumber);
	//alert($("#_pageNumber").val());
	
	$("#_frmFormSearch").attr("action", "adminFreeboardList.do").submit();	
	
}


function _sorting(sorting){
	var category = $("#category_").val();
	var sorting = $("#sorting_").val();
	$("#frm_sorting").val(sorting);
	$("#frm_category").val(category);
	$("#keyword").val(keyword);
	$("#_pageNumber").val(0);
	$("#_frmFormSearch").submit();
	}
 	
function _category(category){
	var sorting = $("#sorting_").val();
	
 	$("#frm_sorting").val(sorting);
	$("#frm_category").val(category);
	$("#keyword").val(keyword);
	//alert($("#frm_category").val());
	$("#_pageNumber").val(0);
	$("#_frmFormSearch").submit();
 	}
 	

$("#searchBtn").click(function () {
	
	var form = document.frmForm1;
	var content = $(".s_keyword").val();
	//alert(content);
	
	if(!form._s_category.value){
		alert("카테고리를 선택해주세요");
		return false;
	}
	if(!form.s_keyword.value){
		alert("내용을 입력해주세요");
		return false;
	}
	
	var check = $("#_s_keyword").val;
	//alert(check);
	
	$("#_pageNumber").val(0);
	
	var sort = $("select[name=choicesorting]").val();
	var category = $("#_s_category").val();
	//alert(category);
	
	$("#frm_sorting").val(sort);
	$("#frm_category").val(category);
	$("#_frmFormSearch").attr("action", "adminFreeboardList.do").submit();	
});


//검색을 유지하기 위한 처리
var s_category = "<%=s_category %>";
var keyword = "<%=keyword %>";
$(document).ready(function () {
	document.frmForm1.s_keyword.value = keyword;
	
	if(keyword == "" || keyword == null){
		s_category = "";
	}
	
	$("#_s_category").val( s_category );
	
});

</script>
</body>
</html>