<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700" rel="stylesheet">

<title>마이페이지 - 받은쪽지함</title>
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
							<h2>받은 쪽지함</h2>
						<!-- 새로고침 버튼은 나중에 해보도록 할게요
						<img src="./mypage_resources/mypage_s/images/refresh.png" class="imgBtn"> -->
						</div>
						<hr>
						<div class="msg-container">
							<form id="frm">
						
						<div class="left-container">
							<select id="_recordCountPerPage" name="recordCountPerPage">			
								<option>10</option>
								<option>20</option>
								<option>30</option>
							</select>&nbsp;&nbsp;&nbsp;전체&nbsp;&nbsp;<font><b>${(empty pureTotal)? 0:pureTotal }</b></font>
							<div id="msgtotalcount"></div>
						</div>
						<div class="right-container">
							<div class="checkgroup">
								<img src="./mypage_resources/mypage_s/images/urgent.png"
									class="container-icon">중요&nbsp;&nbsp;&nbsp;
									<input type="checkbox" id="_important" name="important" value="${sparam.important}" >
						
							</div>
							<div class="checkgroup">
								<img src="./mypage_resources/mypage_s/images/unread.png"
									class="container-icon">읽지 않음&nbsp;&nbsp;&nbsp;
									<input type="checkbox" id="_readcheck" name="readcheck" value="${sparam.readcheck}">
						
							</div>
							&nbsp;&nbsp;&nbsp;
							<div class="searchbar">
								<input type="hidden" name="pageNumber" id="_pageNumber" value="${pageNumber }">
								<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)? 0:recordCountPerPage }">
										
										<select name="selection" id="_selection">
											<option>선택</option>
											<option>보낸 사람</option>
											<option>내용</option>
											<option>일시</option>
										</select> <input type="text" class="input-text" value="" name="keyword" id="_keyword" autocomplete="off">
										 <img alt="d" src="./mypage_resources/mypage_s/images/searchIcon1.png" class="imgBtn" id="searchBtn">
									</div>
								</div>
							</form>
						</div>
						<br> <br>
						<table id="revmsgbox" border="1" width="100%">
							<colgroup>
								<col width="50px">
								<col width="70px">
								<col width="70px">
								<col width="1000px">
								<col width="200px">
								<col width="150px">
							</colgroup>
							<thead>
								<tr align="center">
									<th><input type="checkbox"  id="alldel"></th>
									<th><img
										src="./mypage_resources/mypage_s/images/urgent.png"></th>
									<th><img
										src="./mypage_resources/mypage_s/images/unread.png"></th>
									<th>내용</th>
									<th>보낸 사람</th>
									<th>일시</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${empty myrevmsglist }">
								<tr>
									<td colspan="6" align="center"><p>쪽지가 없습니다.</p></td>
								</tr>
							</c:if>
							 <jsp:useBean id="dateUtil" class="com.petmeeting.joy.mypage.util.MypageDateUtil"/>
							<c:forEach items="${myrevmsglist }" var="rev" varStatus="i">
							<jsp:setProperty property="strDate" name="dateUtil" value="${rev.senddate }"/>
								<tr>
									<td><input type="checkbox" id="_del" class="delck" seq="${rev.seq }"></td>
									<c:if test="${rev.important eq 0 }">
										<td></td>
									</c:if>
									<c:if test="${rev.important eq 1 }">
										<td><img
											src="./mypage_resources/mypage_s/images/urgent.png"></td>
									</c:if>
									<c:if test="${rev.readcheck eq 0 }">
										<td><img
											src="./mypage_resources/mypage_s/images/unread.png" class="readimg" seq="${rev.seq }" readcheck="${rev.readcheck }" id="img${rev.seq }"></td>
									</c:if>
									<c:if test="${rev.readcheck eq 1 }">
										<td><img
											src="./mypage_resources/mypage_s/images/read.png" class="readimg"  seq="${rev.seq }" readcheck="${rev.readcheck }" id="img${rev.seq }"></td>
									</c:if>
					
									<td class="goDetail" seq="${rev.seq }">${rev.content }</td>
									<td>${rev.nickname }</td>
									<td><jsp:getProperty property="strDateFormat" name="dateUtil"/></td>
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
									<button type="button" id="writeBtn">쪽지 쓰기</button>
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
$(document).ready(function(){
	
	//중요&읽지않음으로 sorting한 상태에서 paging할 때 그 값이 어떻게 되고 그에 따라 체크박스 상태 유지하기 위한 부분 
	var important = $("#_important").val();
	var readcheck = $("#_readcheck").val();
	
	var count = 0;
	if(important=='중요'){
		$("#_important").prop("checked",true);
		count = 1;
	}else{
		$("#_important").prop("checked",false);
		count = 0;
	}
	
	if(readcheck == '읽지않음'){
		$("#_readcheck").prop("checked",true);
		count = 1;
	}else{
		$("#_readcheck").prop("checked",false);
		count = 0;
		
	}
	

	//새쪽지 쓰는 버튼
	$('#writeBtn').on("click",function() {
		var url = "writemsg.do";
		var option = "scrollbars=no, left=400,top=200, width=459, height=530";
		var name = "새 쪽지";
		window.open(url, name, option);
	});

	//쪽지 자세히 보기 쪽지를 보는 순간 읽은 표시로 바꾸는 ajax 포함
	$(".goDetail").on("click",function() {
		var seq = $(this).attr("seq");
		var url =  "msgdetail.do?seq="+ seq +"&box=rev";
		var option = "scrollbars=no, left=400,top=200, width=457, height=440";
		var name = "새 쪽지";
		window.open(url, name, option);
		$.ajax({
			type : "post",
			url : "changeReadcheck.do",
			data : {"seq" : seq,"click" : "no"},
			dataType : "json",
			success : function(obj) {
				if(obj == 1){
						$("#img"+seq).attr("src", "./mypage_resources/mypage_s/images/read.png");							
				}
				$.ajax({
					type : "post",
					url : "countunreadmsg.do",
					success : function(data) {
						$(".unreadMsg").text(data);
					},
					error:function(request,status,error){
				        alert("code:"+request.status + "message:"+request.responseText+"error:"+error);
				     
					}

				});
			},
			error : function() {
				alert("실패의 참맛");
			}
		});
	});
	
	//읽음표시 아이콘을 누르면 상태 바꾸는 부분 
	$(".readimg").on("click", function(){
		var seq = $(this).attr("seq");
		var readcheck = $(this).attr("readcheck");
		var result = "";

		if(readcheck == 0){
			result = confirm("읽음 표시로 바꾸시겠습니까?");
		}
		else{
			result = confirm("읽지 않음 표시로 바꾸시겠습니까?");
		}
		
		if(result){
			$.ajax({
				type : "post",
				url : "changeReadcheck.do",
				data : {"seq" : seq, "readcheck" : readcheck,"click" : "click"},
				dataType : "json",
				success : function(obj) {
					
					if(obj == 1){
						$("#img"+seq).attr("src", "./mypage_resources/mypage_s/images/read.png");
						$(".readimg").attr("readcheck", obj);
						$.ajax({
							type : "post",
							url : "countunreadmsg.do",
							success : function(data) {
								$(".unreadMsg").text(data);
							},
							error:function(request,status,error){
						        alert("code:"+request.status + "message:"+request.responseText+"error:"+error);
						     
							}

						});
						
					}
					if(obj == 0){
						$("#img"+seq).attr("src", "./mypage_resources/mypage_s/images/unread.png");							
						$(".readimg").attr("readcheck", obj);
						$.ajax({
							type : "post",
							url : "countunreadmsg.do",
							success : function(data) {
								$(".unreadMsg").text(data);
							},
							error:function(request,status,error){
						        alert("code:"+request.status + "message:"+request.responseText+"error:"+error);
						     
							}

						});
						
					}
					
				},
				error : function() {
					alert("실패의 참맛");
				}
			});
		}

	});
	
	/*  frm 으로 보내는 집단들   */
	$("#searchBtn").on("click", function(){
		$("#_pageNumber").val(0);
		$("#frm").attr("action","myrevmsg.do").submit();
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
		
		$("#_important").val("${sparam.important}");
		$("#_readcheck").val("${sparam.readcheck}");
		$("#_selection").val("${sparam.selection}");
		$("#_keyword").val("${sparam.keyword}");
		$("#frm").attr("action","myrevmsg.do").submit();
	});

	$("#_recordCountPerPage").val("${sparam.recordCountPerPage}").attr("selected", "selected");

	
	$("#_important").on("click",function(){
		if(count == 0){
			$(this).val('중요');
			alert($(this).val());
			$("#_pageNumber").val(0);
			$("#_recordCountPerPage").val("${sparam.recordCountPerPage}");
			$("#_selection").val("${sparam.selection}");
			$("#_keyword").val("${sparam.keyword}");
			$("#frm").attr("action","myrevmsg.do").submit();			
		}
		else if(count == 1){
			$(this).val('안중요');
			alert($(this).val());
			$("#_pageNumber").val(0);
			$("#_recordCountPerPage").val("${sparam.recordCountPerPage}");
			$("#_selection").val("${sparam.selection}");
			$("#_keyword").val("${sparam.keyword}");
			$("#frm").attr("action","myrevmsg.do").submit();	
		}
	});
	

	$("#_readcheck").on("change",function(){
		if(count == 0){
			$(this).val('읽지않음');
			alert($(this).val());
			$("#_pageNumber").val(0);
			$("#_recordCountPerPage").val("${sparam.recordCountPerPage}");
			$("#_selection").val("${sparam.selection}");
			$("#_keyword").val("${sparam.keyword}");
			$("#frm").attr("action","myrevmsg.do").submit();
			
		}
		else if(count == 1){
			$(this).val('모두');
			alert($(this).val());
			$("#_pageNumber").val(0);
			$("#_important").val("${sparam.important}");
			$("#_readcheck").val("${sparam.readcheck}");
			$("#_recordCountPerPage").val("${sparam.recordCountPerPage}");
			$("#_selection").val("${sparam.selection}");
			$("#_keyword").val("${sparam.keyword}");
			$("#frm").attr("action","myrevmsg.do").submit();
			
		}

	});
});

// 페이징
function goPage(pageNumber){
	$("#_pageNumber").val(pageNumber);
	$("#_recordCountPerPage").val("${sparam.recordCountPerPage}");
	$("#_selection").val("${sparam.selection}");
	$("#_keyword").val("${sparam.keyword}");
	$("#frm").attr("action","myrevmsg.do").submit();
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
				data : {"seqArr" : checkArr, "select":"rev"},
				dataType : "text",
				success : function(obj) {
					location.href="myrevmsg.do?recordCountPerPage=${sparam.recordCountPerPage}";
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
