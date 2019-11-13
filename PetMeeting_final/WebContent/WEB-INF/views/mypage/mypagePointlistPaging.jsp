<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%System.out.println("paging.jsp---------------");
/*
	[1][2][3][4][5][6][7][8][9][10] >>
	<< ...[4][5][6] 7 [8][9][10]... >>
*/
	int totalRecordCount;	// 전체 글수    23 -> 3페이지
	int pageNumber;			// 현재 페이지 0 ~ 9	[1]~[10]
	int pageCountPerScreen;	// 스크린당 페이지 수 = 10
	int recordCountPerPage;	// 페이지당 글수 = 10
	
	String st1 = request.getAttribute("totalRecordCount").toString();
	if(st1 == null)	totalRecordCount = 0;
	else			totalRecordCount = Integer.parseInt(st1);	
	
	String st2 = request.getAttribute("pageNumber").toString();
	if(st2 == null)	pageNumber = 0;
	else			pageNumber = Integer.parseInt(st2);	
	
	String st3 = request.getAttribute("pageCountPerScreen").toString();
	if(st3 == null)	pageCountPerScreen = 0;
	else			pageCountPerScreen = Integer.parseInt(st3);	
	
	String st4 = request.getAttribute("recordCountPerPage").toString();
	if(st4 == null)	recordCountPerPage = 0;
	else			recordCountPerPage = Integer.parseInt(st4);
	
	System.out.println("현재 페이지 pageNumber = "+ pageNumber);
	System.out.println("스크린당 페이지 수 pageCountPerScreen = "+ pageCountPerScreen);
	System.out.println("전체 글수 totalRecordCount = "+ totalRecordCount);
	System.out.println("페이지당글수 recordCountPerPage = "+ recordCountPerPage);
	
	// 총페이지 수
	int totalPageCount = totalRecordCount / recordCountPerPage;
	System.out.println("totalPageCount = "+ totalPageCount);
	//	2					23					10
	if((totalRecordCount % recordCountPerPage)!= 0){
		totalPageCount++;		// -> 3
		System.out.println("if > totalPageCount = "+ totalPageCount);
	}
	
	
	
	
	//			0    10    20
	// 시작페이지 [1]  [11]  [21]	<<[1][2][3]...[10]>>
	int screenStartPageIndex = ( (pageNumber + 1) / pageCountPerScreen ) * pageCountPerScreen;
	//			0					10					10
	
	// 끝페이지  [10] [20] [30]	
	int screenEndPageIndex = (((pageNumber + 1) / pageCountPerScreen) * pageCountPerScreen) + pageCountPerScreen;
	
	// 끝페이지는 다시 계산
	if(screenEndPageIndex > totalPageCount){
		screenEndPageIndex = totalPageCount;
	}
	
	if((pageNumber + 1) % pageCountPerScreen == 0){
		screenStartPageIndex = (( (pageNumber + 1) / pageCountPerScreen) * pageCountPerScreen) - pageCountPerScreen;
		screenEndPageIndex = pageNumber + 1;	// 0 -> 1  9 -> 10
	}
%>
<form id="frm">
	<input type="hidden" name="email" value="${login.email }">
	<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)? 0:pageNumber }">
	<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)? 0:recordCountPerPage }">
</form>
<table class="pointlist_table">
	<colgroup> <col width="10%"><col width="30%"><col width="10%"><col width="10%"><col width="20%"><col width="20%"> </colgroup>
	
	<tbody>
	
	<tr class="pointlist_table_th">
		<th>NO</th><th>적립/사용내역</th><th>적립</th><th>사용</th><th>잔여포인트</th><th>날짜</th>
	</tr>
		
	<c:if test="${empty pointlist }">
		<tr>
			<td colspan="6">포인트 사용 내역이 없습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${!empty pointlist }">
	<c:forEach items="${pointlist }" var="pointlist" varStatus="i">
		<tr>
		<td>${i.count}</td>															
		<td align="left">&nbsp;&nbsp;${pointlist.usedinfo}</td>
		
		<c:if test="${pointlist.usedtype eq 0}">
			<td class="savepoint">${pointlist.usepoint }p</td>
			<td></td>
		</c:if>	
		
		<c:if test="${pointlist.usedtype eq 1}">
			<td></td>
			<td class="usepoint">${pointlist.usepoint }p</td>
		</c:if>	
		
		<td>${pointlist.resultpoint }p</td>
		<td>${fn:substring(pointlist.regdate,0,10) }</td>
		
		</tr>
	</c:forEach>
	</c:if>
	</tbody>									
</table> 

<div class="paging-container">
	<div style="float: left; width: 96%; text-align: center;">
		<!-- << -->
		<a href="#none" title="처음페이지" onclick="goPage('0')">
			<img alt="" src="./mypage_resources/mypage_s/images/arrow_first.gif" style="width: 9px; height: 9px">
		</a>
		
		<!-- < -->
		<%
		if(screenStartPageIndex > 1){
			%>
			<a href="#none" title="이전페이지" onclick="goPage('<%=screenStartPageIndex-1 %>')">
				<img alt="" src="./mypage_resources/mypage_s/images/arrow_back.gif" style="width: 9px; height: 9px">
			</a>
			<%
		}
		%>
		
		<!-- [1] 2 [3] -->
		<%
		for(int i = screenStartPageIndex; i < screenEndPageIndex; i++){
			if(i == pageNumber){	// 현재 페이지
				%>
				<span style="font-size: 9pt; color: #000000; font-weight: bold;">
					<%=i+1 %>
				</span>
				<%
			}else{		// 그외의 페이지들
				%>
				<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"	 style="font-size: 7.5pt; color: #000000; font-weight: normal;">
					[<%=i+1 %>]
				</a>	
				<%	
			}
		}
		%>
	
		<!-- > -->
		<%
		if(screenEndPageIndex < totalPageCount){	//  [11][12][13] >
			%>
			<a href="#none" title="다음페이지" onclick="goPage(<%=screenEndPageIndex %>)">
				<img alt="" src="./mypage_resources/mypage_s/images/arrow_next.gif" style="width: 9px; height: 9px">
			</a>
			<%	
		}	
		int end_page = 0;
		if(totalPageCount > 0){
			end_page = totalPageCount - 1;	
		}
		
		//		[1][2][3]
		//		[11][12][13]
		//		총페이지 -> 120		
		
		%>
		<!-- >> -->
		<a href="#none" title="마지막페이지" onclick="goPage(<%=end_page %>)">
			<img alt="" src="./mypage_resources/mypage_s/images/arrow_end.gif" style="width: 9px; height: 9px">
		</a>	
		
	
	</div>
</div>

</body>
</html>