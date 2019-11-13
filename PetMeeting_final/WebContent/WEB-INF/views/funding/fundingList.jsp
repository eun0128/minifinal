<%@page import="com.petmeeting.joy.funding.util.DateUtil"%>
<%@page import="com.petmeeting.joy.funding.model.FundingDto"%>
<%@page import="java.util.List"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.Reader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting-funding</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/fundingboard_resources/css/fundingboard.css">
<!-- 슬라이드 화살표 -->
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
</head>
<body>

 <!--::header part start::-->
 <header class="header_area">
 	<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>
 </header>
 <!-- Header part end-->
 
	<!-- 게시판 소개 부분 -->
  	<div class="container">
   		<div class="mainTitle">                                     
        <span id="mainTitle-petmeeting">PetMeeting</span>
        <span id="mainTitle-boardname"><img src="./fundingboard_resources/img/donation.png" width="60px">&nbsp;후원</span>
        <span id="mainTitle-info">여러분들의 참여를 기다리는 아이들에게 사랑을 나눠주세요</span>                                                 
       </div>
	 </div>

 
<div class="container">
	<!-- <div id="wrapper">
		<div id="slider-wrap">
			<ul id="slider">     
	         <li>          
				<img src="./fundingboard_resources/img/dogcat.jpg">
	     	 </li>
	         <li>          
				<img src="./fundingboard_resources/img/pets.jpg">
	     	 </li>
     	     <li>          
				<img src="./fundingboard_resources/img/twodog.jpg">
     	  	 </li>
     	     <li>          
				<img src="./fundingboard_resources/img/ham.jpg">
     	  	 </li>
      	     <li>          
				<img src="./fundingboard_resources/img/stwodog.jpg">
     	  	 </li>  
			</ul>
	          
			controls
			<div class="btns" id="next"><i class="fa fa-arrow-right"></i></div>
			<div class="btns" id="previous"><i class="fa fa-arrow-left"></i></div>
			<div id="pagination-wrap">
				<ul>
				</ul>
			</div>
			controls  
		</div>
	</div> -->
	
<jsp:useBean id="dates" class="com.petmeeting.joy.funding.util.DateUtil"/>
<jsp:useBean id="today" class="java.util.Date"/>

<div class="pack">
	<div class="select">
		<select id="_select" onchange="select()">
			<option value="">정렬 선택</option>
			<option <c:if test="${categorys == '_like' }">selected</c:if> value="_like">좋아요 순</option>
			<option <c:if test="${categorys == '_join' }">selected</c:if> value="_join">참여자 순</option>
		</select>
	</div>

	<div class="search_1">
		<input id="search_title" type="text" placeholder="후원명을 입력해주세요" <c:if test="${keyword != null}"> value='${keyword}'</c:if>> 
		<input id="searchBtn" type="button" value="검색">
	</div>
</div>

<div class="radioDiv">
	<input type="radio" name="List" id="List1" value="_update" <c:if test="${ing_end == '_update' }">checked</c:if>><label for="List1">전체 후원</label>
	<input type="radio" name="List" id="List2" value="_ing" <c:if test="${ing_end == '_ing' }">checked</c:if>><label for="List2">진행중인 후원</label>
	<input type="radio" name="List" id="List3" value="_end" <c:if test="${ing_end == '_end' }">checked</c:if>><label for="List3">마감된 후원</label>
</div>
※모든 후원은 자정에 마감됩니다.

<c:if test="${empty list }">
	<div>
		<script type="text/javascript">
		alert("해당 후원이 없습니다.");
		location.href="funding.do?ing_end="+$("input[name=List]:checked").val()+"&categorys="+$("#_select").val()+"&keyword=";
		</script>
	</div>	
</c:if>

<c:forEach var="list" items="${list }" varStatus="vs">
	<input type="hidden" value="${list.seq }" id="board_seq">

	<div class="fundingContainer" style="display: none;">
		<div>
			<a href="fundingDetail.do?board_seq=${list.seq }&seq=${list.seq }&email=${login.email}&board_code=FUND" ><img class="listimg" src="fundingFileupload/${list.thumbnail }"></a>
		</div>

		<div class="listText">
			<div>
				<c:if test="${dates.isEnd(list.edate) eq 'true' || list.current_price eq list.max_price}">
					<span class="fundEnd">[후원 마감]</span><br>
				</c:if>
					
				[ <fmt:formatDate pattern="yyyy-MM-dd" value="${list.sdate }"/> ]  ~ [ <fmt:formatDate pattern="yyyy-MM-dd" value="${list.edate }"/> ]		
				<c:if test="${list.isfunding eq 'true' }">
					&nbsp;<img class="listicon_list" alt="" src="./fundingboard_resources/img/success.png"> 참여중
				</c:if>
			</div>
				
			<div class="listTitle">${list.title } </div>
			
			<c:if test="${dates.isEnd(list.edate) eq 'false'}"> 
				 <div class="dday">
				 	<fmt:formatDate value="${today }" var="now" pattern="yyyyMMdd"/>
					<fmt:formatDate var="edate" value="${list.edate }" pattern="yyyyMMdd"/>
					D - ${edate-now }
				 </div>
			</c:if>
			<div class="list1">
				[${list.readcount }]명이 조회했습니다
			</div>	
			<div class="list1">
				<img class="listicon_list" src="./fundingboard_resources/img/hearts.png">  ${list.likecount }
			</div>
			<div class="list1">	
				<img class="listicon_list" src="./fundingboard_resources/img/group.png">  ${list.personcount } 명의 후원
			</div>
			<div class="list1">
				<img class="listicon_list" src="./fundingboard_resources/img/trophy.png"> <fmt:formatNumber value="${list.current_price }" pattern="#,###"/>  / <fmt:formatNumber value="${list.max_price }" pattern="#,###"/> (원)
			</div>
			<div class="list1">	
				<div class="graph">
					<span style="width:${dates.PercentP(list.current_price,list.max_price)}%">${dates.PercentP(list.current_price,list.max_price)}%</span>
				</div>
			</div>	
			<div class="fundingintro">${list.intro }</div>
			<div class="fundMore"><a class="more" href="fundingDetail.do?board_seq=${list.seq }&seq=${list.seq }&email=${login.email}&board_code=FUND">후원내용 보기</a></div>
		</div>
	</div>
</c:forEach>		 

	<div class="moreList">
		<button type="button" id="loadmore">LOAD MORE</button>
	</div>

</div>

<!--::footer part start::-->    
	<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
<!-- footer part end-->

<script>
$(document).ready(function() {	 
	$(".fundingContainer").slice(0,5).show();

	if($(".fundingContainer:hidden").length == 0 ){
			$("#loadmore").css("display","none");
		}else{
			$("#loadmore").click(function(e) {
				e.preventDefault();
				$(".fundingContainer:hidden").slice(0,5).show();
					if($(".fundingContainer:hidden").length == 0 ){
						$("#loadmore").css("display","none");
					}
				});		
		}
	
	var ingEnd = "${ing_end}";
	if(ingEnd == ""){
		$("#List2").attr("checked","checked");
		}
});
 
$("input[name=List]").click(function() {
	location.href="funding.do?ing_end="+$(this).val();
}); 

function select() {
	location.href="funding.do?ing_end="+$("input[name=List]:checked").val()+"&categorys="+$("#_select").val()+"&keyword="+$("#search_title").val();
}

$("#searchBtn").click(function() {
	location.href="funding.do?ing_end="+$("input[name=List]:checked").val()+"&categorys="+$("#_select").val()+"&keyword="+$("#search_title").val();
});

//current position
var pos = 0;
//number of slides
var totalSlides = $('#slider-wrap ul li').length;
//get the slide width
var sliderWidth = $('#slider-wrap').width();


$(document).ready(function(){
  /* BUILD THE SLIDER*/
    //set width to be 'x' times the number of slides
    $('#slider-wrap ul#slider').width(sliderWidth*totalSlides);
	//next slide    
    $('#next').click(function(){
        slideRight();
    });
    //previous slide
    $('#previous').click(function(){
        slideLeft();
    });
    /* OPTIONAL SETTINGS*/
    //automatic slider
    var autoSlider = setInterval(slideRight, 3000);
    
    //for each slide 
    $.each($('#slider-wrap ul li'), function() { 

       //create a pagination
       var li = document.createElement('li');
       $('#pagination-wrap ul').append(li);    
    });
    
    //counter
    countSlides();
    //pagination
    pagination();
   	//hide/show controls/btns when hover
    //pause automatic slide when hover
    $('#slider-wrap').hover(
      function(){ $(this).addClass('active'); clearInterval(autoSlider); }, 
      function(){ $(this).removeClass('active'); autoSlider = setInterval(slideRight, 3000); }
    );
});//DOCUMENT READY
    
/* SLIDE LEFT*/
function slideLeft(){
    pos--;
    if(pos==-1){ pos = totalSlides-1; }
    $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos));    
    //*> optional
    countSlides();
    pagination();
}
/* SLIDE RIGHT*/
function slideRight(){
    pos++;
    if(pos==totalSlides){ pos = 0; }
    $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos)); 
    
    //*> optional 
    countSlides();
    pagination();
}
/*> OPTIONAL SETTINGS*/
function countSlides(){
    $('#counter').html(pos+1 + ' / ' + totalSlides);
}

function pagination(){
    $('#pagination-wrap ul li').removeClass('active');
    $('#pagination-wrap ul li:eq('+pos+')').addClass('active');
} 
        
</script>    
</body>
</html>