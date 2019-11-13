<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String type = request.getParameter("type");
/*
	<< [1][2][3][4][5][6][7][8][9][10]	>>
	<< ...[4][5][6] 7 [8][9][10]...	>>
*/
	int totalRecordCount;		// 전체 글 수
	int pageNumber;				// 현재 페이지	0 ~ 9	[1] ~ [10]
	int pageCountPerScreen;		// 스크린당 페이지 수 	 = 10
	int recordCountPerPage;		// 페이지당 글 수 = 10
	
	String st1 = request.getParameter("totalRecordCount");
	if(st1 == null) totalRecordCount = 0;
	else 			totalRecordCount = Integer.parseInt(st1);
	
	String st2 = request.getParameter("pageNumber");
	if(st2 == null) pageNumber = 0;
	else 			pageNumber = Integer.parseInt(st2);
	
	String st3 = request.getParameter("pageCountPerScreen");
	if(st3 == null) pageCountPerScreen = 0;
	else 			pageCountPerScreen = Integer.parseInt(st3);
	
	String st4 = request.getParameter("recordCountPerPage");
	if(st4 == null) recordCountPerPage = 0;
	else 			recordCountPerPage = Integer.parseInt(st4);
	
	
	
	// 총 페이지 수 	(!= 전체 글 수  )
	int totalPageCount = totalRecordCount / recordCountPerPage;		// 전체 글 수 / 페이지당 글 수 
	//ex) 	2		   =			23				10			
			
	if(totalRecordCount % recordCountPerPage  != 0) {		// 전체 글 수를 페이지당 글 수로 나눴을 때 나머지가 0이 아니면 총 페이지 수는 +1이 된다
		totalPageCount++;		// 3페이지
	}
	
	//		   0	10	20
	// 시작페이지 [1] [11] [21] 	<<[1][2][3]..[10]>>
	int screenStartPageIndex = ((pageNumber + 1) / pageCountPerScreen) * pageCountPerScreen;
	
	// 끝페이지    [10]	[20]  [30]
	int screenEndPageIndex = (((pageNumber + 1) / pageCountPerScreen) * pageCountPerScreen) + pageCountPerScreen;
	
	// 끝페이지는 다시 계산
	if(screenEndPageIndex > totalPageCount){
		screenEndPageIndex = totalPageCount;
	}
	
	if((pageNumber + 1) % pageCountPerScreen == 0 ){
		screenStartPageIndex = (((pageNumber + 1 ) / pageCountPerScreen) * pageCountPerScreen) - pageCountPerScreen;
		
		screenEndPageIndex = pageNumber + 1;		// 0 -> 1 , 9 -> 10
	}
	
%>
<%
if(totalRecordCount != 0) {
%>
<div style="float: left; width: 96%; text-align: center;">
	<!-- << -->
	<a href="#none" title="첫페이지" onclick="goPage('<%=type %>', '0')">
		<img alt="" src="${pageContext.request.contextPath}/store_resources/images/backarrow.png" style="width: 12px;height: 12px;transform: translate(0,-3px);">
	</a>
	
	<!-- < -->
	<%
	if(screenStartPageIndex > 1){
	%>
		<a href="#none" title="이전페이지" onclick="goPage('<%=type %>','<%=screenStartPageIndex-1%>')">
		<img alt="" src="${pageContext.request.contextPath}/store_resources/images/back.png" style="width: 12px;height: 12px;transform: translate(0,-3px);">
		</a>
	<%
	}
	%>
	
	<!-- [1] 2 [3] -->
	<%
	for(int i = screenStartPageIndex; i < screenEndPageIndex; i++){
		if(i == pageNumber){		// 현재 페이지
			%>
			<span style="font-size: 15px;color: #333;font-weight: bold;width: 20px;display: inline-block; 
						height: 20px; background-color: #e0e0e0; border-radius: 10px;">
				<%=i + 1 %>		
			</span>
			<%
		}else{		// 그 외 페이지
			%>
			<span style="font-size: 15px;color: #999; width: 20px; display: inline-block; height: 20px; border-radius: 10px;"
				onmouseover="this.style.background='#e0e0e0'" onmouseout="this.style.background='#fff'">
			<a href="#none" title="<%=i+1%>페이지" onclick="goPage('<%=type %>', <%=i%>)">
				<%=i+1 %>
			</a>
			</span>
			<%
		}
	}
	%>

	
	<!-- > -->
	<%
	if(screenEndPageIndex < totalPageCount){	// [11][12][13]	>
		%>
		<a href="#none" title="다음페이지" onclick="goPage('<%=type %>', <%=screenEndPageIndex%>)">
			<img alt="" src="${pageContext.request.contextPath}/store_resources/images/next.png" style="width: 12px;height: 12px;transform: translate(0,-3px);">
		</a>
		<%
	}
	
	int end_page = 0;
	if(totalPageCount > 0){
		end_page = totalPageCount - 1;
	}
	
	//	[1][2][3]
	// [11][12][13]
	// 총페이지 - > 120
	
	%>
	<!-- >> -->
	<a href="#none" title="마지막페이지" onclick="goPage('<%=type %>', <%=end_page %>)">
			<img alt="" src="${pageContext.request.contextPath}/store_resources/images/nextarrow.png" style="width: 12px;height: 12px;transform: translate(0,-3px);">
	</a>
	
</div>
<%
}
%>