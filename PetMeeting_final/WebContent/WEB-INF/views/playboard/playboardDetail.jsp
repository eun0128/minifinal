<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting-소모임</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<!-- 지도 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=689cdd3b092f29b4c71fe175d367652c&libraries=services"></script>
  
	<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/playboard_resources/css/playboardDetail.css?after">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/playboard_resources/css/bootstrap.min.css?after">   
 	<link rel="stylesheet" href="${pageContext.request.contextPath}/common/navbar/css/memberDropdown.css">
</head>
<body>

<!--::header part start::--> 
   	<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/> 
<!-- Header part end-->

<c:if test="${login eq null}">
	<script type="text/javascript">
		alert("세션이 종료되었습니다. 다시 로그인 하세요");
		location.href="login.do";
	</script>
</c:if>

<div class="container">
	<div class="makerBtns">
		<c:if test="${login.email eq detail.email }">
			<button class="btn1" id="updateBtn">수정</button>
			<button class="btn1" id="deleteBtn">삭제</button>
		</c:if>
	</div>
	<div class="playInfo">
		<div class="playInfoLeft">
			<div class="thumbnail">
				<img class="thumbnail-img"src="${pageContext.request.contextPath}/playboardUpload/${detail.filename }">
			</div>
			 <div class="playTitle">
			 	<div style="width: 93%; float: left;">[${detail.category }] ${detail.title } </div>
			 	<div style="width: 7%; float: right;"><button type="button" id="sirenBtn"></button></div>
			 </div>	 
			 <div class="playReadCount">
			 	조회수: ${detail.readcount }
			 </div>
	   		 <div class="playLikes">	   		 
	   		 	<c:if test="${checks.likeCheck eq false }">
	   				 <button type="button" id="likeBtn" style="display: inline;"></button><button type="button" id="unlikeBtn" style="display: none;"></button>
	   			</c:if>
	   			<c:if test="${checks.likeCheck eq true }">
	   				 <button type="button" id="likeBtn" style="display: none;"></button><button type="button" id="unlikeBtn" style="display: inline;"></button>
	   			</c:if>	
	   			 &nbsp;&nbsp;<span id="likeCount">${detail.likecount }</span>
	   		 </div>
	   		 <div class="playPeople"><img src="${pageContext.request.contextPath}/playboard_resources/img/people.png" width="30px" height="30px;">&nbsp;&nbsp;${detail.personcount }명 참여중&nbsp;&nbsp;모집인원 ${detail.people }명</div>
			 <div class="hashtags">
				<c:if test="${not empty hashs.hash1 }"><a href="hashSearch.do?searchText=${hashs.hash1 }">#${hashs.hash1 }</a></c:if>	
				<c:if test="${not empty hashs.hash2 }"><a href="hashSearch.do?searchText=${hashs.hash2 }">#${hashs.hash2 }</a></c:if>	
				<c:if test="${not empty hashs.hash3 }"><a href="hashSearch.do?searchText=${hashs.hash3 }">#${hashs.hash3 }</a></c:if>	
				<c:if test="${not empty hashs.hash4 }"><a href="hashSearch.do?searchText=${hashs.hash4 }">#${hashs.hash4 }</a></c:if>	
				<c:if test="${not empty hashs.hash5 }"><a href="hashSearch.do?searchText=${hashs.hash5 }">#${hashs.hash5 }</a></c:if>	
			</div>
			
		</div>
		
		<div class="playInfoRight">
		<jsp:useBean id="pUtil" class="com.petmeeting.joy.playboard.Util.PlayboardUtil"/>
			<div class="playMaker">
				<div class="infoTitle">
					<span class="smallTxt">모임 주최자</span>
				</div>			
					<!-- 프로필 사진이 없는 경우 -->
					<c:if test="${empty profile.myprofile_img }">
						<img src="${pageContext.request.contextPath}/playboard_resources/img/user.png" width="50px" height="50px">&nbsp;&nbsp;
					</c:if>
					
					<!-- 프로필 사진이 있는 경우 -->
					<c:if test="${not empty profile.myprofile_img }">
						<img id="profilePic" src="${pageContext.request.contextPath}/upload/${profile.myprofile_img }">&nbsp;&nbsp;
					</c:if>
					<a class="dropdown" email="${detail.email }" nickname="${detail.nickname }">
						${detail.nickname }
					</a>
				
			</div>	
			<div class="playDate">
				<div class="infoTitle">
					<span class="smallTxt">모임 예정일</span>
				</div>				
				<jsp:setProperty property="myDate" name="pUtil" value="${detail.pdate }"/>
				<img src="${pageContext.request.contextPath}/playboard_resources/img/calicon.png" width="30px" height="30px;">&nbsp;&nbsp;<jsp:getProperty property="dateString" name="pUtil"/>
			</div>
			
			<div class="playDate">
				<div class="infoTitle">
					<span class="smallTxt">모집 마감일</span>
				</div>				
				<jsp:setProperty property="myDate" name="pUtil" value="${detail.edate }"/>
				<img src="${pageContext.request.contextPath}/playboard_resources/img/calicon.png" width="30px" height="30px;">&nbsp;&nbsp;<jsp:getProperty property="dateString" name="pUtil"/>
			</div>
			
	   		<div class="playLocation">
	   			<div class="infoTitle">
					<span class="smallTxt">모임 장소</span>
				</div>
	   			<img src="${pageContext.request.contextPath}/playboard_resources/img/pin.png" width="30px" height="30px;">&nbsp;&nbsp;${detail.location }
	   		</div>
	   		
	   		<c:if test="${login.email eq detail.email }">
   				
	   			<div class="playPartMems">
		   			<div class="infoTitle">
							<span class="smallTxt">참여자 목록</span>
					</div>
	   				<div class="memberProfile">
	   					<c:if test="${empty partList }">
		   					<div style="text-align: center;">현재 참여자가 없습니다.</div>
		   				</c:if>	
		   				
		   				<c:forEach items="${partList }" var="partMem">		   
		   						<div class="memberProfileCell">		
			   									   						     					
				   						<c:if test="${empty partMem.memProfile.myprofile_img }">	   									   							
				   							<img src="${pageContext.request.contextPath}/playboard_resources/img/user.png" width="40px" height="40px">&nbsp;&nbsp;
				   								   									   									   							
				   						</c:if>			
				   						
				   						<c:if test="${not empty partMem.memProfile.myprofile_img }">		   								   							   							
				   							<img class="partMemProfilePic" src="${pageContext.request.contextPath}/upload/${partMem.memProfile.myprofile_img }">&nbsp;&nbsp;		   											   								   									   								   							
				   						</c:if>	
				   					<a class="dropdown" email="${partMem.email }" nickname="${partMem.nickname }">		    
			   							${partMem.nickname }	
			   						</a>
		   						</div>						   				
		   				</c:forEach>
	   				</div>
	   			</div>
	   		</c:if>
	   	
	   		<c:if test="${login.email ne detail.email }">
		   		<div class="playParticipate">
		   			<c:if test="${login.email ne detail.email && checks.partCheck eq false }">
		   				<button type="button" class="btn2" id="partBtn">참여하기</button>
		   			</c:if>
		   			<c:if test="${checks.partCheck eq true }">
		   				<button type="button" class="btn3" id="cancelBtn">참여 취소</button>
		   			</c:if>	
		   		</div>
	   		</c:if>
		</div>
	</div>
	
	
	
	<div class="playContent">
		<div class="infoTitle"><span class="bigTxt">모임 예상비용</span></div>
		<div class="price-area">
			<fmt:formatNumber type="number" maxFractionDigits="3" value="${detail.price }"/>원		
			<div class="priceInfo">
				<img src="${pageContext.request.contextPath}/playboard_resources/img/exclamation-mark.png" width="20px" style="vertical-align: sub;">&nbsp;모임 예상비용은 주최자가 정한 금액으로, 모임시 증가 혹은 감소될 수 있습니다. 
			</div>
		</div>
		
		<div class="infoTitle"><span class="bigTxt">모임 소개</span></div>
		<div class="detail-area">
			${detail.content }
		</div>
		
		<div class="infoTitle"><span class="bigTxt">모임 장소</span></div>
		<div class="map-area">		
			<img src="${pageContext.request.contextPath}/playboard_resources/img/pin.png" width="35px" height="35px;" style="margin-bottom: 10px;">&nbsp;${detail.location } ${detail.location_detail }
			<div id="map" style="width:100%;height:400px;"></div>			
		</div>
	</div>
	
	<div class="playQnA">
		<div class="infoTitle"><span class="bigTxt">Q&A</span></div>
		<div class="QnA-area">
			
			<!-- 주최자가 아닐 경우에만 문의하기 버튼이 보이도록 제어 -->
			<c:if test="${login.email ne detail.email }">
			<button type="button" id="writeQnABtn">문의하기</button>
			</c:if>
			
			<!-- 문의글 남기는 폼 -->
			<div class="writeQnA">
				<form id="QnAFrm">
					<input type="hidden" name="email" value="${login.email }">
					<input type="hidden" name="board_seq" value="${detail.seq }">
					<textarea name="content" placeholder="내용"></textarea>
					<div class="writeQnA-btns">
						<label><input type="checkbox" name="secret" value="1"> 비밀글 (모임 주최자에게만 글이 보여집니다.)</label>
						<button type="button" id="submitQnA">등록</button>	
					</div>				
				</form>		
			</div>
			
			<c:if test="${empty qnaList }">
				<div align="center" style="margin-top: 100px;">
				작성된 문의글이 존재하지 않습니다.
				</div>
			</c:if>
			
			
			<div class="QnA-row">
			
				<c:forEach items="${qnaList }" var="qna">
					
					<div class="question">
						<!-- 질문 -->
						<c:if test="${qna.parent eq 0 }">
								
								<div class="questionProfile">
									<!-- 비밀글인 경우 -->
									<c:if test="${qna.secret eq 1 }">										
										<c:if test="${login.email eq detail.email || qna.email eq login.email }">
											<c:if test="${empty qna.memProfile.myprofile_img }">
											<img src="${pageContext.request.contextPath}/playboard_resources/img/user.png" width="40px" height="40px">
											</c:if>
											<c:if test="${not empty qna.memProfile.myprofile_img }">
												<img class="QnAProfilePic" src="${pageContext.request.contextPath}/upload/${qna.memProfile.myprofile_img }">
											</c:if>							
											&nbsp;<a class="dropdown" email="${qna.email }" nickname="${qna.nickname }">${qna.nickname }</a> | 작성일&nbsp;<fmt:formatDate value="${qna.regdate }"  pattern="yyyy.MM.dd HH:mm" />
										</c:if>					
										
										<c:if test="${login.email ne detail.email && qna.email ne login.email }">
										<img src="${pageContext.request.contextPath}/playboard_resources/img/lockicon.png" width="40px" height="40px">								
											비밀글 | 작성일&nbsp;<fmt:formatDate value="${qna.regdate }"  pattern="yyyy.MM.dd HH:mm" />
										</c:if>			
									</c:if>
									
									<!-- 비밀글이 아닌 경우 -->
									<c:if test="${qna.secret eq 0 }">
										<c:if test="${empty qna.memProfile.myprofile_img }">
											<img src="${pageContext.request.contextPath}/playboard_resources/img/user.png" width="40px" height="40px">
										</c:if>
										<c:if test="${not empty qna.memProfile.myprofile_img }">
											<img class="QnAProfilePic" src="${pageContext.request.contextPath}/upload/${qna.memProfile.myprofile_img }">
										</c:if>								
										 &nbsp;<a class="dropdown" email="${qna.email }" nickname="${qna.nickname }">${qna.nickname }</a> | 작성일&nbsp;<fmt:formatDate value="${qna.regdate }"  pattern="yyyy.MM.dd HH:mm" />
									</c:if>													
								</div>
								
								<div class="questionContent">
									<!-- 비밀글인 경우 -->
									<c:if test="${qna.secret eq 1 }">										
										<c:if test="${login.email eq detail.email || qna.email eq login.email }">
											Q. ${qna.content }
										</c:if>					
										
										<c:if test="${login.email ne detail.email && qna.email ne login.email }">						
											비밀글 입니다.
										</c:if>			
									</c:if>
									
									<!-- 비밀글이 아닌 경우 -->
									<c:if test="${qna.secret eq 0 }">
										Q. ${qna.content }
									</c:if>		
									
									<c:if test="${detail.email eq login.email  && qna.replyCheck eq false }">
										<a class="replyQnABtn" seq="${qna.seq }">답변하기</a>
									</c:if>																									
								</div>
								
						</c:if>
						
						<!-- 답변 -->
						<c:if test="${qna.parent ne 0 }">
						
							<div class="reply">		
								<div class="questionProfile">
									<!-- 비밀글인 경우 -->
									<c:if test="${qna.secret eq 1 }">										
									<c:if test="${login.email eq detail.email || qna.email eq login.email }">
										<c:if test="${empty qna.memProfile.myprofile_img }">
										<img src="${pageContext.request.contextPath}/playboard_resources/img/user.png" width="40px" height="40px">
										</c:if>
										<c:if test="${not empty qna.memProfile.myprofile_img }">
											<img class="QnAProfilePic" src="${pageContext.request.contextPath}/upload/${qna.memProfile.myprofile_img }">
										</c:if>							
										 &nbsp;<a class="dropdown" email="${qna.email }" nickname="${qna.nickname }">${qna.nickname }</a> | 작성일&nbsp;<fmt:formatDate value="${qna.regdate }"  pattern="yyyy.MM.dd HH:mm" />
									</c:if>					
										
										<c:if test="${login.email ne detail.email && qna.email ne login.email }">
										<img src="${pageContext.request.contextPath}/playboard_resources/img/lockicon.png" width="40px" height="40px">								
											비밀글 | 작성일&nbsp;<fmt:formatDate value="${qna.regdate }"  pattern="yyyy.MM.dd HH:mm" />
										</c:if>			
									</c:if>
									
									<!-- 비밀글이 아닌 경우 -->
									<c:if test="${qna.secret eq 0 }">
										<c:if test="${empty qna.memProfile.myprofile_img }">
											<img src="${pageContext.request.contextPath}/playboard_resources/img/user.png" width="40px" height="40px">
										</c:if>
										<c:if test="${not empty qna.memProfile.myprofile_img }">
											<img class="QnAProfilePic" src="${pageContext.request.contextPath}/upload/${qna.memProfile.myprofile_img }">
										</c:if>								
										 &nbsp;<a class="dropdown" email="${qna.email }" nickname="${qna.nickname }">${qna.nickname }</a> | 작성일&nbsp;<fmt:formatDate value="${qna.regdate }"  pattern="yyyy.MM.dd HH:mm" />
									</c:if>			
								</div>
								<img alt="" src="${pageContext.request.contextPath}/playboard_resources/img/arrow.png" width="18px" style="vertical-align: top; margin-top: 12px;">
								
								<div class="replyContent">
									<!-- 비밀글인 경우 -->
									<c:if test="${qna.secret eq 1 }">										
										<c:if test="${login.email eq detail.email || qna.email eq login.email }">
											A. ${qna.content }
										</c:if>					
										
										<c:if test="${login.email ne detail.email && qna.email ne login.email }">						
											비밀글 입니다.
										</c:if>			
									</c:if>
									
									<!-- 비밀글이 아닌 경우 -->
									<c:if test="${qna.secret eq 0 }">
										A. ${qna.content }
									</c:if>		
								</div>
														
							</div>
							
						</c:if>	
								
					</div>
					
				</c:forEach>								
			</div><!-- QnA-row 끝 -->
			
			<div class="QnApaging">
				<form id="pagingFrm">
					<input type="hidden" name="seq" value="${detail.seq }">
					<input type="hidden" name="board_seq" value="${detail.seq }">
					<input type="hidden" name="currPage" value="${currPage }">
				</form>
				
				<c:if test="${currPage ne 1 }">
					<a id="prevPage"><img src="${pageContext.request.contextPath}/playboard_resources/img/back.png" width="13px" height="13px" style="vertical-align: middle;">&emsp;이전 페이지</a>				
				</c:if>
				
				<c:if test="${!((currPage*6) >= totalCount) }">
				<a id="nextPage">다음 페이지&emsp;<img src="${pageContext.request.contextPath}/playboard_resources/img/next.png" width="13px" height="13px"style="vertical-align: middle;"></a>
				</c:if>
			</div>
					
		</div>
	</div><!-- QnA부분 끝 -->
	
</div>

<div class="memberDropDown">
	<ul>
		<li><a id="viewMemberProfile">프로필 보기</a></li>
		<li><a id="follow">팔로우 하기</a></li>
		<li><a id="writeMsg">쪽지 보내기</a></li>
		<li><a id="reportMember">신고하기</a></li>
	</ul>
	<form id="memberProfileFrm">
		<input type="hidden" name="email">
		<input type="hidden" name="bad_email">
		<input type="hidden" name="nickname" id="_nickname">
	</form>
</div>

<!--::footer part start::--> 
<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
<!-- footer part end-->

<script src="${pageContext.request.contextPath}/common/navbar/js/memberDropdown.js"></script>
<script type="text/javascript">
$(function () {	
	
	if(${detail.fullCheck } == true || ${detail.deadlineCheck } == true){
		$("#partBtn").css("background-color", "#d2d2d2");
	}
	/* 글 수정 */
	$("#updateBtn").click(function () {
		location.href = "updatePlay.do?seq="+${detail.seq };
	});
	
	/* 글 삭제 */
	$("#deleteBtn").click(function () {
		location.href= "deletePlay.do?seq="+${detail.seq };	
	});
	
	/* 모임 참가 */	
	$("#partBtn").click(function () {		
		if(${detail.fullCheck } == true){
			alert("모집 인원을 초과하였습니다.");
		}else if(${detail.deadlineCheck } == true){
			alert("모집 기한이 종료되었습니다.");
		}else{
			var check = confirm("모임에 참여하시겠습니까?");
			if(check == true){
				location.href="participatePlay.do?seq="+${detail.seq };
			}
		}				
	});
	
	/* 모임 참가 취소 */
	$("#cancelBtn").click(function () {
		var check = confirm("모임 참여를 취소하시겠습니까?");
		if(check == true){
			location.href="cancelPartPlay.do?seq="+${detail.seq };
		}
	});
	
	/* 좋아요 */
	$("#likeBtn").click(function () {		
		//location.href="likePlay.do?seq="+${detail.seq };		
		$.ajax({
			url: 'likePlay.do',
			type: 'post',
			data: {"seq": ${detail.seq }},
			datatype: 'json',
			async: false,
			success: function (data) {
				//alert("success");				
				$("#likeBtn").css("display", "none");
				$("#unlikeBtn").css("display", "inline");	
				$("#likeCount").text(data.trim());
			},
			error: function () {
				alert("error");
			}
		});
	});
	/* 좋아요 취소 */
	$("#unlikeBtn").click(function () {
		//location.href="unLikePlay.do?seq="+${detail.seq };	
		$.ajax({
			url: 'unLikePlay.do',
			type: 'post',
			data: {"seq": ${detail.seq }},
			datatype: 'json',
			async: false,
			success: function (data) {
				//alert("success");
				$("#unlikeBtn").css("display", "none");
				$("#likeBtn").css("display", "inline");
				$("#likeCount").text(data.trim());
			},
			error: function () {
				alert("error");
			}
		});
	});
	
	/* 신고 */
	$("#sirenBtn").click(function () {
		if("${detail.email }" == "${login.email }"){
			alert("본인 작성글은 신고가 불가합니다");
		}else{
			
			$.ajax({
				url: 'reportCheck.do',
				type: 'post',
				data: {'seq': ${detail.seq }},
				success: function ( data ) {
				//	alert("성공");
					if(data.trim() == "okay"){
						var option = "width = 550, height = 500, top = 100, left = 300, location = no, resizeable = no";
						window.open("boardReport.do?seq=${detail.seq }", "report", option);
					}else if(data.trim() == "no"){
						alert("신고는 한 번만 가능합니다!");
					}
				},
				error: function () {
					alert("에러");
				}
				
			});
			
		}	
	});
	
	/* Q&A 질문 작성	*/
	$("#writeQnABtn").click(function () {		
		if($(".writeQnA").css("display") == "none"){
			$(".writeQnA").css("display", "inline-block");
		}else if($(".writeQnA").css("display") == "inline-block"){
			$(".writeQnA textarea").val("");
			$(".writeQnA").css("display", "none");
		}		
	});
	
	$("#submitQnA").click(function () {
	
		if($.trim($(".writeQnA textarea").val()) == ""){
			alert("질문 내용을 입력해 주십시오.");
			return false;
		}else{
			$("#QnAFrm").attr({"action":"insertQnA.do", "method":"post"}).submit();
		}
	});
	
	/* Q&A 답변 작성 */
	$(document).on('click','.replyQnABtn',function () {
		
	//	alert($(".replyQnA").find('textarea').attr("name"));
	//	alert($(".replyQnA").length);
		var html = "<div class='replyQnA'>";
		html += "<form id='QnAReplyFrm'>";
		html += "<input type='hidden' name='email' value='"+"${login.email }"+"'>";
		html += "<input type='hidden' name='board_seq' value='"+${detail.seq }+"'>"	;
		html += "<input type='hidden' name='parent' value='"+$(this).attr("seq")+"'>";
		html += "<img alt='' src='${pageContext.request.contextPath}/playboard_resources/img/arrow.png' width='18px' style='vertical-align: top; margin-top: 12px;'>&nbsp;";
		html += "<textarea name='content' placeholder='답변'></textarea>";
		html += "<div class='replyQnA-btns'>";
		html += "<button type='button' id='submitReply'>등록</button>	";
		html += "</div>";
		html += "</form>";
		html += "</div>";
		
		if($(".replyQnA").length < 1){			
			$(this).parent().after(html);
		}else{
			$(".replyQnA").remove();
			$(this).parent().after(html);
		}		
	});
	
	$(document).on('click', '#submitReply', function () {		
		$("#QnAReplyFrm").attr({"action":"insertQnAReply.do", "method":"post"}).submit();
	});
	
	/* Q&A 페이징 */
	$("#prevPage").click(function () {
		var cp = ${currPage }-1;
		$("input[name='currPage']").val(parseInt($("input[name='currPage']").val())-1);
		$("#pagingFrm").attr("action", "detailPlay.do").submit();
	});
	$("#nextPage").click(function () {
		var cp = ${currPage }+1;
		$("input[name='currPage']").val(parseInt($("input[name='currPage']").val())+1);
		$("#pagingFrm").attr("action", "detailPlay.do").submit();
	});
	
	/* 닉네임 클릭시 드롭다운 div 보이게 하기  */
	$(".dropdown").click(function () {			
		$("#memberProfileFrm input[name='nickname']").val($(this).attr("nickname"));
		$("#memberProfileFrm input[name='bad_email']").val($(this).attr("email"));
		$("#memberProfileFrm input[name='email']").val("${login.email }");
		
		var left = $(this).offset().left;
		var top = $(this).offset().top + $(this).height();

		if($(".memberDropDown").length > 1){
			$(".memberDropDown").css("display", "none");
			$(".memberDropDown").css({
				"display": "block",
				"left": left,
				"top": top
			});
		}else{
			$(".memberDropDown").css({
				"display": "block",
				"left": left,
				"top": top
			});
		}		 			
	});

	/* 드롭다운 멤버 신고 */
	$("#reportMember").click(function () {
		//alert($("#memberProfileFrm input[name='nickname']").val());
		if($("#memberProfileFrm input[name='bad_email']").val() == $("#memberProfileFrm input[name='email']").val()){
			alert("자기 자신은 신고할 수 없습니다!");
			return false;
		}else{
		//	var formdata = $("#memberProfileFrm").serialize();
		//	$("#memberProfileFrm").attr({"action":"memberReport.do", "method":"post"}).submit();
		/*	
			$.ajax({
				url: "memberReportIfo.do",
				type: "post",
				data: formdata,
				success: function () {
					//alert("성공");
					var option = "width = 550, height = 500, top = 100, left = 300, location = no, resizeable = no";
					var reportPopUp = window.open("memberReport.do", "report", option);
					$(reportPopUp).find("input[name='bad_email']").val($("#memberProfileFrm input[name='bad_email']").val());
				},
				error: function () {
					alert("에러");
				}
			});
		*/
			var option = "width = 550, height = 500, top = 100, left = 300, location = no, resizeable = no";
			var reportPopUp = window.open("memberReport.do", "report", option);
		//	$(reportPopUp).find("input[name='bad_email']").val($("#memberProfileFrm input[name='bad_email']").val());
				
		}		
	});


	/* 드롭다운 쪽지보내기 */
	$('#writeMsg').on("click",function() {
		if($("#memberProfileFrm input[name='bad_email']").val() == $("#memberProfileFrm input[name='email']").val()){
			alert("자기 자신에게 쪽지보내기는 불가합니다.");
		}else{
			var url =  "mypageFollowreplymsg.do?to_email="+$("#memberProfileFrm input[name='bad_email']").val()+"&nickname="+$("#memberProfileFrm input[name='nickname']").val();
			var option = "scrollbars=no, left=400,top=200, width=472, height=595";
			var name = "새 쪽지";
			window.open(url, name, option);
		} 
	});

	/* 드롭다운 프로필보기 */
	$("#viewMemberProfile").click(function () {
		var url =  "mypagefollowprofile.do?email="+$("#memberProfileFrm input[name='bad_email']").val();
		var option = "scrollbars=no, left=400,top=200, width=420, height=420 ";
		var name = "프로필";
		
		window.open(url, name, option);
	});

	/* 드롭다운 팔로우하기 */
	$("#follow").click(function () {
		if($("#memberProfileFrm input[name='bad_email']").val() == $("#memberProfileFrm input[name='email']").val()){
			alert("자기 자신은 팔로우 할 수 없습니다.");
		}else{
			var follow = $("#memberProfileFrm input[name='bad_email']").val();
			$.ajax({
				url: 'follow.do',
				type: 'post',
				data: {"folloing_email": follow },
				success: function ( data ) {
					//alert("성공");
					if(data.trim() == "no"){
						alert("이미 팔로잉 중입니다.");
					}else{
						alert("팔로우 되었습니다.");					
					}				
				},
				error: function () {
					alert("에러");
				}
			});
		}
		
	});
	 
	/* 스크롤 움직일 경우 드롭다운 div 제거 */
	$(window).scroll(function(event){ 
		$(".memberDropDown").css("display", "none");
	});	
	$(".memberProfile").scroll(function(event) {
		$(".memberDropDown").css("display", "none");
	});
	/* 다른 곳 클릭 시 드롭다운 div 제거 */
	$(window).click(function(event){
		//alert($(event.target).attr('class'));		
		if($(event.target).attr('class') != "dropdown"){
			$(".memberDropDown").css("display", "none");
		} 
	});
	

	
/* 지도 출력 */
var geocoder = new kakao.maps.services.Geocoder();

var callback = function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        console.log(result);
        	        
        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
        
        var mapContainer = document.getElementById('map');
		var mapOption = {
			center: new daum.maps.LatLng(result[0].y, result[0].x),
			level: 3
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); 

		var imageSrc = 'playboard_resources/img/mapPin.png', // 마커이미지의 주소입니다    
		imageSize = new kakao.maps.Size(50, 53), // 마커이미지의 크기입니다
		imageOption = {offset: new kakao.maps.Point(20, 60)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		    markerPosition = coords // 마커가 표시될 위치입니다

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition, 
		    image: markerImage, // 마커이미지 설정 
		    clickable: true 
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);   

		map.relayout();
		map.setCenter(coords);
		
		// 마우스 오버 시 띄울 div
		var overContent = '<div align="center" style="padding:10px;">클릭해보세요!</div>';
		var infowindow = new kakao.maps.InfoWindow({
		    content : overContent
		});
		
		kakao.maps.event.addListener(marker, 'click', function() {
		  	var y = marker.getPosition().getLat();
		   	var x = marker.getPosition().getLng();

		    var URL = "https://map.kakao.com/link/map/" + y + "," + x;
		    //alert(URL);

		 // window.open('https://map.kakao.com/link/map/'+ y+','+x);
		    window.open('https://map.kakao.com/link/search/${detail.location }');
		});
		
		kakao.maps.event.addListener(marker, 'mouseover', function() {
			infowindow.open(map, marker);
		});
		kakao.maps.event.addListener(marker, 'mouseout', function() {
			infowindow.close();
		});

    }
};
		
geocoder.addressSearch("${detail.location }", callback);

});



</script>

</body>
</html>