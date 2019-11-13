<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="com.petmeeting.joy.freeboard.model.CommentDto"%>
<%@page import="com.petmeeting.joy.freeboard.model.FreeboardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting-자유게시판</title>
<link rel="stylesheet" href="/css/bootstrap.css">

    <style>

	#_btnlist{
	border-radius: 8px;
	width:80px;
	height:30px;
	color:white;
	font-family:NanumSquareRound;
	font-size: 15px;
	
	}

	#boardtitle{
	border-radius: 8px;
	width:300px;
	height:50px;
	color:white;
	font-family:NanumSquareRound;
	font-size: 30px;
	
	}
	</style>
    
</head>
<body>

<%
	MemberDto user = (MemberDto)request.getSession().getAttribute("login");
%>
<%
	FreeboardDto dto = (FreeboardDto)request.getAttribute("dto");
%>
<%
	CommentDto cmdto = (CommentDto)request.getAttribute("commentdto");
%>
<div class="container">

<%	String from2 = dto.getRegdate();
  	SimpleDateFormat transFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   	Date to2 = transFormat2.parse(from2); 	%>
<br><br>
 <span><strong>${dto.category}</strong></span> <span id="cCnt"></span><br>
 	<h1>${dto.title}</h1>
 		
		<span style="font-size:25px"><c:if test= "${dto.myprofile_img eq null}">
			<img src="./profileimg/picture2.jpg" style="width:30px; height:30px;" >
			</c:if>
			<c:if test= "${not empty dto.myprofile_img}">
			<img src="./profileimg/${dto.myprofile_img}" style="width:30px; height:30px;" >
			</c:if>
			<img src="./gradeimg/${dto.filename}" style="width:30px; height:30px;" >&nbsp;&nbsp;${dto.nickname}
			</span>
				<span style="float:right; margin-right: 3px">조회수: ${dto.readcount}&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<span style="float:right;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<span style="float:right">좋아요: <div class="likeke" id="ttest">${dto.likecount}</div></span>
				<span style="float:right">작성일: <%=transFormat2.format(to2)%>&nbsp;&nbsp;&nbsp;&nbsp;</span><br><br>
					<span>${dto.content}</span>
				

</div>
<br>

<div class="container">
	<input type="button" id="_btnlist" value="글목록" style="background-color:#585e7d;float: center; margin-left:2%; border: 1px solid #585e7d;" onclick="location.href='freeboard_admin.do'">
	<input type="button" id="_btnlist" value="신고 확인" style="background-color:#585e7d;float: center; margin-left:2%; border: 1px solid #585e7d;" onclick="reportcheck()">
			
	
	</div>
</div>




<div>
<%--  <form name="testForm" id="testForm">
<input type="hidden" name="board_seq" value="${dto.seq}"/>
<input type="hidden" name="board_code" value="DOG"/>
<input type="hidden" name="email" value="${login.email}"/>
</form> --%>

 <form name="testForm" id="testForm">
<input type="hidden" name="board_seq" value="1"/>
<input type="hidden" name="board_code" value="DOG"/>
<input type="hidden" name="email" value="1"/>
</form>


 <form name="test2Form" id="testForm">
<input type="hidden" name="board_seq" value="${dto.seq}"/>
<input type="hidden" name="board_code" value="${dto.board_code}"/>
<input type="hidden" name="email" value="${login.email}"/>
</form>
</div>
<br>


<%
	List<CommentDto> cmlist = (List<CommentDto>)request.getAttribute("cmlist");
%>


<style>
.profilephoto{
	width: 100px; height: 100px;
   	object-fit: cover;
    border-radius: 50%;}


.th1{	width:150px;}
.th2{	width:800px;}    /* style="word-break:break-all" */
.th3{	width:400px;}
.th4{	width:120px;}
.th5{	width:90px;}
.th6{	width:90px;}
.th7{	width:90px;}
.th8{	width:90px;}
.th9{	width:90px;}
.tt1{ width: 100px;}
.tt2{ width: 100px;}
.tt3{ width: 300px;}
.tt4{ width: 100px;}
.qqq{fontsize:x-large;}
.cmlike{display:inline}
.likeke{display:inline}
</style>

<div class="container">
    <form id="commentListForm" name="commentListForm" method="post">
        <div id="commentList">
        	<br><br>
        	<div>
            	<div>
                <span><strong>댓글</strong></span> <span id="cCnt"></span> <span id="cCnt"></span> <span id="cCnt"></span> <span id="cCnt"></span>
            	</div>
            		<div>
            		 <table class="table" style="word-wrap:break-word;word-break:break-all;">
        				<thead>
                            <tr>
                                <th class="th1"></th>
                                <th class="th2" style="word-break:break-all"></th>
                                <th class="th3"></th>
                                <th class="th4"></th>
                                <th class="th5"></th>
                                <th class="th6"></th>
                                <th class="th7"></th>
                                <th class="th8"></th>
                            </tr>
                        </thead>
                        <tbody>
                         <%
                         	for(int i = 0; i < cmlist.size(); i++) { 
                                                 	CommentDto cm = cmlist.get(i);
                                                 	String from = cm.getRegdate();
                                                 	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                                 	Date to = transFormat.parse(from);  
                                                 	
                                                 	String email = cm.getEmail();
                         %>
                         <%if(cmlist.size() == '0'){%>
                        	 <tr><td>작성된 댓글이 없습니다.</td></tr>
                         <%}%>
                        	<%if(cm.getDel() == 0){ %>
                            <tr>
                            	<td rowspan="2">
                            	<%
                           if(cm.getDepth() !=0){
							%>		<img src='./images/reply.png' width="20px" height="20px" />
							<%}%>	
							
                                <%if(cm.getMyprofile_img() == null) {%>
                                <img src="./profileimg/picture2.jpg" width="70px" class="profilephoto" height="70px" style="position:; margin-right: 50px; float:center;">
                                <%}else{ %>
                                <img src="./profileimg/<%=cm.getMyprofile_img() %>" class="profilephoto" width="70px" height="70px" style="position:; margin-right: 50px; float:center;">
                                <%} %>
                                </td>
                               	<td style="word-break:break-all"><img src="./gradeimg/<%=cm.getFilename() %>" style="width:30px; height:30px;" >&nbsp;&nbsp;&nbsp;<%=cm.getNickname() %></td>
                                <td style="word-break:break-all"><%=transFormat.format(to) %></td>
                                <td style="word-break:break-all"></td>
                                <td style="word-break:break-all"><img src=./images/delete.png width="20px" height="20px" onclick="cmdeletebtn('<%=cm.getEmail() %>',<%=cm.getSeq()%>,${dto.seq},<%=cm.getRef() %>,<%=cm.getStep() %>)" style="cursor: pointer;"></td>
                            	<td style="word-break:break-all" ></td>
                            	<td style="word-break:break-all"></td>
                            	<td style="word-break:break-all"></td>
                           </tr>
                           <tr>
                           <td colspan="8" style="text-align:left; word-break:break-all; font-size:20px"  id="reply<%=cm.getSeq()%>"><%=cm.getContent() %></tr>                     	
                        	<%
                        }
                        }
                        %> 
                        </tbody>
           	</table>
	       	</div>
	        </div>
        <input type="hidden" id="b_code" name="b_code" value="" /> 
       
        </div>
    </form>
</div>




<!--::footer part start::-->    
<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
<!-- footer part end-->






<input type="hidden" class="hdboardcode" value="${dto.board_code}">
<input type="hidden" class="hdboardseq" value="${dto.seq}">
<input type="hidden" class="hdemail" value="${login.email}">
<input type="hidden" class="hdref" value="${cmdto.ref}">
<input type="hidden" class="hdstep" value="${cmdto.step}">
<input type="hidden" class="hddepth" value="${cmdto.depth}">


<script>
var btn;
var btnlocation;
var mydiv;
var next;
var th;
var textbackup;
var count = 0;

function delfbadmin(seq){
	var email = $(".hdemail").val();
	if(email == ""){
		alert("로그인이 필요한 페이지 입니다.");
		return false;
	} 
	
	var chk = confirm("정말 삭제하시겠습니까?");
	if(chk){
		location.href="freeboard_admin_delete.do?seq=${dto.seq}";
	}
	
}

function fbreportchk(){
	var email = $(".hdemail").val();
	if(email == ""){
		alert("로그인이 필요한 페이지 입니다.");
		return false;
	} 
	var chk = confirm("정말 신고하시겠습니까?");
	if(chk){
		fbreport();
	}
	
}

function fbreport(seq){
	window.open("./WEB-INF/view/freeboard/popup.html", "a", "width=400, height=300, left=100, top=50");
	
}


function cmdelete(data){

	var seq = data;
	var seqq = $(".hdboardseq").val();
	var cmdeldata = {
			"seq" : seq,
			"seqq" : seqq
	}; 
	
	 $.ajax({
		url:"freeboard_admincommentdelete.do",
		type:"get",
		data: cmdeldata,
		success:function(data){
			
			if(data == "likeit"){
			$(".heartImg").attr('src', './images/like.png');
			
			location.href="fbdetail.do?seq="+seq;
			}
			else if(data == "dislikeit")
			$(".heartImg").attr('src', './images/dislike.png');
			},
			
			
		error:function(){
			$("#reply"+seq).html(content);
		}		
	});  	
}

function updateOpenReply(th,seq,cmemail){
var email = $(".hdemail").val();
if(email == ""){
	alert("로그인이 필요한 페이지 입니다.");
	return false;
}
if(cmemail != email){
	alert("작성자 본인만 수정/삭제할 수 있습니다.");
	return false;
}
if(count > 0){
	alert("글 수정과 답글은 동시에 실행할 수 없습니다");
	return false;
}
count++;

btn = $(th).parent().html()
btnlocation =  $(th).parent().parent();
my = th;
next = $(my).parent().parent().parent().next().after();
mydiv = $(my).parent();   
next2 = $(my).parent().parent().parent().next().after();
textbackup = next.text();
var content = $("#reply"+seq).html();
var backup = content
next.after("<tr id='updatereplyDiv"+seq+"'><td colspan='8'><form name='updatecommentform'><textarea name='_updatecomment' style='width: 1000px' class='replyContent"+seq+"' value='"+content+"'>"+content+"</textarea><br><button type='button' id='_btnlist' class='updateReply' style='background-color:#585e7d; float: right; margin-left:2%; border: 1px solid #585e7d;'  value='"+seq+"'>수정등록</button>&nbsp;&nbsp;<button type='button' id='_btnlist' class='updateCancel' style='background-color:#585e7d; float: right; margin-left:2%; border: 1px solid #585e7d;' value='"+seq+"'>수정취소</button></form></td></tr>");
}



$(document).on('click', '.updateReply', function(){
		var seq = $(this).val();
		var form = document.updatecommentform;
		 if(!form._updatecomment.value){
			alert("내용을 입력해주세요");
			return false;
		} 
		var content = $(".replyContent"+seq).val();
			
		var updatereply = {
				"seq" : seq,
				"content" : content
		};
		
		$.ajax({
			url:"freeboard_commentupdate.do",
			type:"get",
			data: updatereply,
			success:function(data){
				alert("성공");
				if(data == "likeit"){
				$(".heartImg").attr('src', './images/like.png');
			
				
				}
				else if(data == "dislikeit")
				$(".heartImg").attr('src', './images/dislike.png');
				},
			error:function(){
				$("#reply"+seq).html(content);
			}		
		});
		count--;
		$("#updatereplyDiv"+seq).remove();
});

$(document).on('click', '.updateCancel', function(){
	count--;
	$(this).parent().remove();
	
});

$(document).on('click', '.recommentCancel', function(){
	count--;
	var seq = $(this).val();
	$("#recommentDiv"+seq).remove();
});



 
function recommentOpenReply(th,seq){
	btn = $(th).parent().html()
	btnlocation =  $(th).parent().parent();

	 my = th;
	 next = $(my).parent().parent().parent().next().after();
	 mydiv = $(my).parent().next().next();   
	
		
	
	
	//alert(seq);
	var email = $(".hdemail").val();
	//alert(email);
	if(email == ""){
		alert("로그인이 필요한 페이지 입니다.");
		return false;
	} 
	
	if(count > 0){
		alert("글 수정과 답글은 동시에 실행할 수 없습니다");
		return false;
	}
	count++;
	var content = $("#reply"+seq).html();

	next.after("<tr id='recommentDiv"+seq+"'><td colspan='8'><form name='recommentform'><textarea style='width: 1000px' name='_recommentcontent' class='recommentreplyContent"+seq+"' rows='3' cols='30' id='comment' name='content' placeholder='댓글을 입력하세요'></textarea><br><button type='button' class='writerecommentReply' id='_btnlist' style='background-color:#585e7d; float: right; font-size:15px; margin-left:2%; border: 1px solid #585e7d;'  value='"+seq+"'>답글등록</button>&nbsp;&nbsp;<button type='button' class='recommentCancel' id='_btnlist' style='background-color:#585e7d; float: right; font-size:15px; margin-left:2%; border: 1px solid #585e7d; ' value='"+seq+"'>답글취소</button></form></td></tr>")
	 
}

$(document).on('click', '.writerecommentReply', function(){
	var form = document.recommentform;
	 if(!form._recommentcontent.value){
		alert("내용을 입력해주세요");
		return false;
	} 
	
	
	var seq = $(this).val();
	var content = $(".recommentreplyContent"+seq).val();
	var board_code = $(".hdboardcode").val();
	var board_seq = $(".hdboardseq").val();
	var email = $(".hdemail").val();
	
	
	var updatereply = {
			"seq" : seq,
			"content" : content,
			"board_code" : board_code,
			"board_seq" : board_seq,
			"email" : email,
	};
	
		 $.ajax({
		url:"freeboard_recomment.do",
		type:"get",
		data: updatereply,
		success:function(data){
			alert("성공");
			if(data == "abc"){
			alert("성공");
			}
			else if(data == "dislikeit")
			$(".heartImg").attr('src', './images/dislike.png');
			alert("실패");
			},
		error:function(){
			
			location.href='freeboard_boarddetail.do?seq=${dto.seq}'
			$("#reply"+seq).html(content);
		}		
	}); 
		 count--;
});







function liketest(){

	var aaa = $("form[name=testForm]").serialize();
	$.ajax({
		url:"freeboard_boardlikecheck.do",
		type:"get",
		data: aaa,
		success:function(data){
			if(data == "likeit"){
				$(".heartImg").attr('src', './images/like.png');
				}
				else if(data == "dislikeit"){
				$(".heartImg").attr('src', './images/dislike.png');
				}
				getlikecount();
				},
			error:function(data){
				alert("라이크테스트에러");
			}		
		});
}

function getlikecount(){
	 $.ajax({
	      url:"freeboard_boardlikecount.do",
	      type:"get",
	      data: {
	         seq : "${dto.seq}"
	      },
	      success:function(data){
	    	   $("#ttest").html(data);
		      
	      },
	      error:function(data){
	    	  alert("error");
	      }
	   })
	
}



function commentlikecheck(th, Seq){
	
	var email = $(".hdemail").val();
	if(email == ""){
		alert("로그인이 필요한 페이지 입니다.");
		return false;
	}
	
	
	btn = $(th).parent().html()
	btnlocation =  $(th).parent().parent();
	
	
	 my = th;
	 next = $(my).parent().parent().parent().next().after();
	 mydiv = $(my).parent();
	 mymydiv = $(my).prev();
	 
			
	 
	var seq = {"Seq": Seq};

	$.ajax({
		url:"freeboard_commentlikecheck.do",
		type:"get",
		data: {"seq":Seq},
		success:function(data){
			if(data == "likeit"){
				getcmlikecount(Seq);
				}
				else if(data == "dislikeit")
				getcmlikecount(Seq);		
				},
		error:function(data){
			alert("에러");
		}		
	});
}

function getcmlikecount(Seq){
	
	 $.ajax({
	      url:"freeboard_commentlikecount.do",
	      type:"get",
	      data: {
	         "seq" : Seq
	      },
	      success:function(data){
	   	mymydiv.html(data);
		      
	      },
	      error:function(data){
	    	  alert("error");
	      }
	   })
	
}




function report(data){
	var email = $(".hdemail").val();
	if(email == ""){
		alert("로그인이 필요한 페이지 입니다.");
		return false;
	} 
}

function nullcheckcm(){
	 var email = $(".hdemail").val();
		if(email == ""){
			alert("로그인이 필요한 페이지 입니다.");
			return false;
		}
	var form = document.commentform;
	var content = $(".reply_content").val();
	var seq = $(".hdboardseq").val();
	if(!form.content.value){
		alert("내용을 입력해주세요");
		return false;
	}
	var board_code = $(".hdboardcode").val();
	var board_seq = $(".hdboardseq").val();
	var email = $(".hdemail").val();
	var cmdto ={
			"board_seq" : board_seq,
			"content" : content,
			"board_code" : board_code,
			"email" : email,
	}
	
	location.href="freeboard_commentwritedown.do?board_seq="+board_seq + "&content=" + content+ "&board_code=" + board_code + "&email=" + email;
 }
	
function cmdeletebtn(cmemail,cmseq, fbseq, cmref, cmstep){
var board_seq = $(".hdboardseq").val();
var email = $(".hdemail").val();

var chk = confirm("정말 삭제하시겠습니까?");
if(chk){
 	location.href="freeboard_admincommentdelete.do?ref="+cmref+"&seq="+cmseq+"&board_seq="+board_seq+"&step="+cmstep;

}
	
}


function logincheck(cmemail){
	alert(cmemail);
	var email = $(".hdemail").val();
	alert(email);
	if(cmemail != email){
		alert("작성자 본인만 수정/삭제할 수 있습니다.");
		return false;
	}
	else{
		alert("하하");
	}
}


function reportBtn(){
	
	var email = $(".hdemail").val();
	if(email == ""){
		alert("로그인이 필요한 페이지 입니다.");
		return false;
	}
	
	var reportform = {
			"board_seq" : ${dto.seq },
			"board_code" : '${dto.board_code }',
			"email" : email,
			 	};
	
	
	 
	if("${dto.email }" == "${login.email }"){
		alert("본인이 작성한글은 신고 불가능합니다");
	}
	
	else{
		
		$.ajax({
			url: 'freeboard_boardreportCheck.do',
			type: 'post',
			data: reportform,
			success: function ( data ) {
				
				 if(data == "OK"){
					var option = "width = 500, height = 500, top = 100, left = 200, location = no, resizeable = no";
					window.open("freeboard_boardReport.do?seq="+${dto.seq}, "report", option);
					alert("신고완료");
				 }
					else if(data == "NO"){
					alert("신고는 한번만가능합니다");  
				} 
			},
			error: function () {
				alert("error");
			}
			
		});
		
	} 

}



function cmreportBtn(seq,cmemail){
	
	var email = $(".hdemail").val();
	//alert(email);
	if(email == ""){
	alert("로그인이 필요한 페이지 입니다.");
	return false;
	}
		
	var cmreportform = {
			"comment_seq": seq,
			"board_seq" : ${dto.seq },
			"board_code" : '${dto.board_code }',
			"email" : email,
				 	};
	
	if("${login.email }" == cmemail){
		alert("본인이 작성한글은 신고 불가능합니다");
	}
	
	 
	else{
		
		$.ajax({
			url: 'freeboard_commentreportCheck.do',
			type: 'post',
			data: cmreportform,
			success: function ( data ) {
				
				 if(data == "OK"){
					 var option = "width = 550, height = 500, top = 100, left = 300, location = no, resizeable = no";
					window.open("freeboard_commentreport.do?seq="+seq, "freeboard_commentreport", option); 
				 }
					else if(data == "NO"){
					alert("신고 한번만가능합니다");  
				} 
			},
			error: function () {
				alert("error");
			}
			
		});
		
	} 
 
}


function reportcheck() {
	
	var seq = "${dto.seq}";
	alert(seq);
	
 	$.ajax({
			url:"beforereportchk.do",
			type:"get",
			data: "seq=" + seq,
			success:function (data){
				alert(data);
				if(data != 0){
					var option = "width = 500, height = 500, top = 100, left = 200, location = no, resizeable = no";
					window.open("freeboard_adminreportcheck.do?seq="+${dto.seq}, "report", option);
					
				}else if(data === 0){
					alert("신고 내역이 없습니다.");
				}
				
			},
			error:function(){
				alert("err");
			}			
		});
	
	
};
 
</script>
</body>
</html>