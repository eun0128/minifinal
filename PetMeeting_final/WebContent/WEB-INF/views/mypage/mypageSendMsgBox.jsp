<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 보낸쪽지함</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/mypage_resources/mypage_s/msgbox/msgbox_style.css">
<link href="./mypage_resources/mypage_s/datepicker/datepicker.css" rel="stylesheet">

</head>
<body class="is-preload">
  <header class="header_area">
    	<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>
    </header>
<!-- Wrapper -->
<div id="wrapper">

  <!-- Main -->
	<div id="main">
		<div class="inner">
		<section class="main-container">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12">
						<div class="title-container">
					<h2>보낸 쪽지함</h2>
					<!-- 새로고침 버튼은 나중에 해보도록 할게요
				 	<img src="./mypage_resources/mypage_s/images/refresh.png" class="imgBtn"> -->
				</div>
				<hr>
					<div class="msg-container">
						<form id="frm">
							<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)? 0:pageNumber }">
						<div class="left-container">
							<select id="_recordCountPerPage" name="recordCountPerPage">
								<option>10</option>
								<option>20</option>
								<option>30</option>
							</select>&nbsp;&nbsp;&nbsp;전체&nbsp;&nbsp;<font><b>${(empty pureTotal)? 0:pureTotal }</b></font>
							<div id="msgtotalcount"></div>
						</div>
						<div class="right-container">
							<div class="searchbar">
								<select name="selection" id="_selection">
									<option>선택</option>
									<option>받는 사람</option>
									<option>내용</option>
									<option>일시</option>
								</select> <input type="text" class="input-text" value="" name="keyword" id="_keyword" autocomplete="off">
						 <img alt="d" src="./mypage_resources/mypage_s/images/searchIcon1.png" class="imgBtn" id="searchBtn">
							</div>
						</div>
					</form>
				</div>
					<br> <br>
					<table id="sendmsgbox" border="1" width="100%">
						<colgroup>
							<col width="50px">
							<col width="1000px">
							<col width="200px">
							<col width="150px">
							<col width="150px">
							<col width="100px">
						</colgroup>
						<thead>
							<tr align="center">
								<th><input type="checkbox" id="alldel"></th>
								<th>내용</th>
								<th>받는 사람</th>
								<th>보낸 날짜</th>
								<th>받은 날짜</th>
								<th>발송 취소</th>

							</tr>
						</thead>
						<tbody>
							<c:if test="${empty mysendmsglist }">
								<tr>
									<td colspan="6" align="center"><p>쪽지가 없습니다.</p></td>
								</tr>
							</c:if>
							 <jsp:useBean id="dateUtil" class="com.petmeeting.joy.mypage.util.MypageDateUtil"/>
							<c:forEach items="${mysendmsglist }" var="send" varStatus="i">
								<tr>
									<td><input type="checkbox" id="_del" class="delck" seq="${send.seq }"></td>									
									<td class="goDetail" seq="${send.seq }">${send.content }</td>
									<td>${send.nickname }</td>
										<jsp:setProperty property="strDate" name="dateUtil" value="${send.senddate }"/>
									<td><jsp:getProperty property="strDateFormat" name="dateUtil"/></td>
									<c:if test="${send.readcheck eq 0 }">
										<td><font>읽지않음</font></td>
									</c:if>
									<c:if test="${send.readcheck eq 1 }">
									<jsp:setProperty property="strDate" name="dateUtil" value="${send.readdate }"/>
										<td><jsp:getProperty property="strDateFormat" name="dateUtil"/></td>
									</c:if>
									<c:if test="${send.readcheck eq 0 }">
										<td><font class="cancel" seq="${send.seq }"><b>발송취소</b></font></td>
									</c:if>
									<c:if test="${send.readcheck eq 1 }">
										<td> </td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>

					</table>
					
				<div class="paging-container">
					<jsp:include page="/WEB-INF/views/mypage/paging.jsp" flush="false">
						<jsp:param name="pageNumber" value="${pageNumber }"/>
						<jsp:param name="totalRecordCount" value="${totalRecordCount }"/>
						<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }"/>
						<jsp:param name="recordCountPerPage" value="${recordCountPerPage }"/>		
					</jsp:include>
				 </div>
					<div class="btn-container">
						<button type="button" id="deleteBtn">삭제</button>
					</div>
							</div>
						</div>
					</div>
			</section>
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

<script src="./mypage_resources/mypage_s/datepicker/datepicker.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	//수신 확인 안한 쪽지 발송취소하는 부분
	$(".cancel").on("click", function(){
		var confirm_val = confirm("정말 취소하시겠습니까?");
		var seq = $(this).attr("seq");
		if(confirm_val){
			var checkArr = new Array();
			checkArr.push(seq);
			}
	
		$.ajax({
			type : "post",
			url : "deletemsg.do",
			data : {"seqArr": checkArr ,"select":"all"},
			dataType : "text",
			success : function(data) {
				alert("성공적으로 발송취소 되었습니다");
				location.href="mysendmsg.do";
			},
			error:function(request,status,error){
		        alert("code:"+request.status + "message:"+request.responseText+"error:"+error);
		     
			}

		});
	});
	
	//보낸 쪽지 디테일
	$(".goDetail").on("click",function() {
		var seq = $(this).attr("seq");
		var url = "msgdetail.do?seq="+ seq +"&box=send";
		var option = "scrollbars=no, left=400,top=200, width=457, height=444";
		var name = "새 쪽지";
		window.open(url, name, option);
		
	});
		
	/*  frm 으로 보내는 집단들   */
	$("#searchBtn").on("click", function(){
		$("#_pageNumber").val(0);
		$("#frm").attr("action","mysendmsg.do").submit();
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
	
	$("#_recordCountPerPage").on("change", function(){
		$("#_selection").val("${sparam.selection}");
		$("#_keyword").val("${sparam.keyword}");
		$("#frm").attr("action","mysendmsg.do").submit();
	});

	$("#_recordCountPerPage").val("${sparam.recordCountPerPage}").attr("selected", "selected");
	
});
		

function goPage(pageNumber){
	$("#_pageNumber").val(pageNumber);
	$("#_recordCountPerPage").val("${sparam.recordCountPerPage}");
	$("#_selection").val("${sparam.selection}");
	$("#_keyword").val("${sparam.keyword}");
	$("#frm").attr("action","mysendmsg.do").submit();
}

		/* 삭제 파트 */
	$("#alldel").on("click",function(){
		var chk = $(this).prop("checked");
		
		if(chk){
			$(".delck").prop("checked",true);
		}
		else{
			$(".delck").prop("checked",false);
		}
	});
	
	$(".delck").on("click",function(){
		$("#alldel").prop("checked",false);
	});

	$("#deleteBtn").on("click",function(){
		var confirm_val = confirm("정말 삭제하시겠습니까?");
		
		if(confirm_val){
			var checkArr = new Array();
			
			$("input[class='delck']:checked").each(function(){
				checkArr.push($(this).attr("seq"));
			});
			
			$.ajax({
				type : "post",
				url : "deletemsg.do",
				data : {"seqArr" : checkArr, "select":"send"},
				dataType : "text",
				success : function(obj) {
					location.href="mysendmsg.do?recordCountPerPage=${sparam.recordCountPerPage}";
				},
				error : function() {
					alert("실패의 참맛");
				}
			});
		}
	});
</script>


</body>
</html>