<%@page import="com.petmeeting.joy.freeboard.model.FreeboardDto"%>
<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>PetMeeting-자유게시판</title>
<link rel="stylesheet" href="freeboard_resources/css/bootstrap.css">
<link rel="stylesheet" href="freeboard_resources/css/freeboard_style.css">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>  
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">

</head>
<body>
<!--::header part start::-->
<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>    
<!-- Header part end-->


<input type="hidden" class="hdemail" value="${login.email}">
<%	MemberDto user = (MemberDto)request.getSession().getAttribute("login");%>
<%FreeboardDto fb = (FreeboardDto)request.getAttribute("dto"); %>
<div class="container">
  	<div class="fbtitle" align="left" style="margin-top: 2%; margin-left: 2%;">
  		
  	<c:if test="${board_code eq 'DOG'}">
  		<input type="button" value="강아지 게시판" id="boardtitle" style="background-color:#585e7d; border: 1px solid #585e7d; float: left; margin-top: 2%; margin-left: 2%;">
   	</c:if>
   	
   	<c:if test="${board_code eq 'CAT'}">
  		<input type="button" value="고양이 게시판" id="boardtitle" style="background-color:#585e7d; border: 1px solid #585e7d; float: left; margin-top: 2%; margin-left: 2%;">
   	</c:if>
	
   	<c:if test="${board_code eq 'ETC'}">
  		<input type="button" value="기타 동물 게시판" id="boardtitle" style="background-color:#585e7d; border: 1px solid #585e7d; float: left; margin-top: 2%; margin-left: 2%;">
   	</c:if>
   	</div>
	    	
</div>

<form method="post" name="fbwriteinfo" id="_fbwriteFrm" action="freeboard_boardwritedown.do">
	<input type="hidden" name="email" value="<%=user.getEmail() %>">
	<input type="hidden" name="board_code" value="${board_code}">
<div class="container">
  
        <div id="commentList">
        	<br><br>
        	<div>
            	<div>
                <span><strong>${dto.category}</strong></span> <span id="cCnt"></span>
            	</div>
            		<div>
            			<table>
            			<tr>
		            		<td>	<label for ="category"></label>
							        <select id="category" class="category" name="category" size="1">
						            
						            <option name="1" value="잡담">잡담</option>
						            <option name="2" value="찾아요">찾아요</option>
						            <option name="3" value="정보">정보</option>
						            <option name="4" value="질문">질문</option>
						            <option name="5" value="자랑">자랑</option>
						    	    </select>
						   	</td>
	            			<td>
	            				<input type="text" name="title" maxLength="40" class="title" placeholder="제목" style= width:1000px;>
	            			</td>
            			</tr>
            			<tr>
            				<td colspan="2"><br>
            					<textarea type="text" name="content" class="content" placeholder="내용" id="summernote"  rows="10" cols="50" ></textarea>		
            					
            				</td>
            			</tr>
            			<tr>
            				
            			
            			</tr>
            	</table>
	       	</div>
	        </div>
        <input type="hidden" id="b_code" name="b_code" value="" />  
        </div>
    
</div>  


<div class="container" >
<input type="button" id="_btnlist" style="float: right; margin-right: 5%; background-color:#585e7d; border: 1px solid #585e7d;" value="취소" onclick="location.href='fblistview.do'">
<input type="button" id="_btnlist" style="float: right; margin-right: 5%; background-color:#585e7d; border: 1px solid #585e7d;;" value="글쓰기완료" onclick="writefb()">

<!-- email -->
<input type="hidden" class="hdemail" value="${login.email}">

</div>
</form>

<!--::footer part start::-->    
<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
<!-- footer part end--> 
   
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>

 
 
<script type="text/javascript">
$('#summernote').summernote({
       placeholder: '내용을 입력해주세요',
       tabsize: 2,
       height: 400,
       minHeight: null,             // set minimum height of editor
          maxHeight: null,             // set maximum height of editor
          focus: true                  // set focus to editable area after initializing summernote
  
     });
</script>

<script>
function notnull(){
	alert("여기옴");
	
}



function writefb(){
	var form = document.fbwriteinfo;
	
 	if(!form.title.value || !form.content.value){
		alert("모든 항목을 입력해주세요");
		return false;
	} 
	
	$("#_fbwriteFrm").submit();
	
	
}


</script>
   
</body>
</html>