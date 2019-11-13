<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 	<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	 <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	 
    <link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/navbar/css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/navbar/css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/navbar/css/owl.carousel.min.css">
    <!-- themify CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/navbar/css/themify-icons.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/navbar/css/flaticon.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/navbar/css/magnific-popup.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/navbar/css/style.css">
    <!-- 우리가 추가한 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/navbar/css/custom.css?after">
   
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
   
</head>
<body>

 <!--::header part start::-->
    <header class="header_area">
        <div class="sub_header">
            <div class="container">
               
                
                <div class="row align-items-center">
                  <div class="col-4 col-md-4 col-xl-6">
                       <div id="logo">
                          <a href="main.do"><img src="${pageContext.request.contextPath}/common/navbar/img/petmeetinglogo.png" alt="" title="" width="300px" /></a>
                      </div>
                  </div>
                  <div class="col-8 col-md-8 col-xl-6 ">

                    <div class="sub_header_social_icon float-right">
                        <!-- 로그인/회원가입/마이페이지 등 로그인 정보 나타내는 div -->
				        <div id="loginInfo">				        
				            <input type="hidden" class='nowmymsg' value="-1">
				        	<c:if test="${not empty login }">			        		
				        		<img src="${pageContext.request.contextPath}/common/img/usericon.png" width="20px" />&nbsp;
				        		${login.nickname }		        		
				        		 <div class="myDropDown">
									<ul>
										<li><a href="mypagehome.do">마이페이지</a></li>	
										<li><a href="myrevmsg.do?recordCountPerPage=10">나의 쪽지함</a></li>			
										<c:if test="${login.auth eq 8 }"><li><a href="adminMain.do">관리자 모드</a></li></c:if>						
										<li><a href="logout.do">로그아웃&nbsp;<img src="${pageContext.request.contextPath}/common/img/logout.png" width="15px" /></a></li>										
									</ul>
								</div>			        		
				        	</c:if>
				        	
				        	<c:if test="${empty login }">
				        		<a href="login.do" target="_self">로그인</a>
				        	</c:if>
				           
				        </div>
                   		</div>
                    </div>
                </div>
            </div>
        </div>
        
        
        <!-- 
       		<a href="javascript:kakaologout(this);">로그아웃</a>
       		
       		<script type="text/javascript">
       		
       		function kakaologout() {
       			Kakao.init('2f90f741a7fa19bb40a6b2cc2d08fd28');
           		Kakao.Auth.logout(function(obj) {
           			if(obj==true){
           				//로그아웃 완료
           				alert("로그아웃완료");
           				location.href="logout.do";
           			}else{
           				//로그아웃안됬을때
           				alert("로그아웃실패");
           			}
           		});
			};        		
       		</script>
       		 -->
              

        <div class="main_menu">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <nav class="navbar navbar-expand-lg navbar-light">
                            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <i class="ti-menu"></i>
                            </button>

                            <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
                                <ul class="navbar-nav">
                                    <li class="nav-item active">
                                        <a class="nav-link active" href="main.do">Home</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="noticeboard.do" class="nav-link">공지</a>
                                    </li>
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                         	자유게시판
                                        </a>
                                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                             <a class="dropdown-item" href="freeboard_listview.do?board_code=DOG">강아지</a>
                                            <a class="dropdown-item" href="freeboard_listview.do?board_code=CAT">고양이</a>
                                             <a class="dropdown-item" href="freeboard_listview.do?board_code=ETC">기타 소동물</a>
                                        </div>
                                    </li>
                                    <li class="nav-item">
                                        <a href="playboard.do" class="nav-link">소모임</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="funding.do" class="nav-link">후원</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="productlist.do" class="nav-link">스토어</a>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- Header part end-->
    
   
    
    <!-- jquery plugins here-->
    <!-- jquery -->

   	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <!-- popper js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/bootstrap.min.js"></script>
    <!-- counterup js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/jquery.counterup.min.js"></script>
    <!-- waypoints js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/waypoints.min.js"></script>
    <!-- easing js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/jquery.magnific-popup.js"></script>
    <!-- particles js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/owl.carousel.min.js"></script>
    <!-- custom js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/custom.js"></script>

    
    
    
    
<script type="text/javascript">
   $(function () {
	$("#loginInfo").click(function () {
		if($(".myDropDown").css("display") == "block" ){
			$(".myDropDown").css("display", "none");
		}else if($(".myDropDown").css("display") == "none" ){
			$(".myDropDown").css("display", "block");
		}
	});
	$(window).scroll(function(event){ 
		$(".myDropDown").css("display", "none");
	});	
});
</script>
    

<script type="text/javascript">

$(document).ready(function () {

	Notification.requestPermission(function (status) {
		    // This allows to use Notification.permission with Chrome/Safari

		    // alert(Notification.permission);

		  //  alert("status"+status);
		    if (Notification.permission != status) {
		      Notification.permission = status;
		    }
		  });
	 
	$.ajax({
		 type:"POST",
		 url:"mypagemsgpush.do",
		 async: false,
		 success:function(data){
			 var split_res=data.split('/');
			 var count=split_res[1];
 			if(count!='-1'){
				$(".nowmymsg").val(count);				
			}			
		  },error:function(){
			  alert("실패!");
		  }
	   });
       
		// var notification = new Notification("새 쪽지가 등록 되었습니다");
    function noti() {	   	
		$.ajax({
			 type:"POST",
			 url:"mypagemsgpush.do",
			 async: false,
			 success:function(data){
						 
				 var split_res=data.split('/');
				 var email=split_res[0];
				 var count=split_res[1];
				 
				//alert("이메일"+email);
				 //alert("카운트"+count);
				 				 
				 if(count!='-1'){
					 					 
					 if($(".nowmymsg").val()<count){
							
					    var options={
					        icon:"https://img.icons8.com/cotton/2x/topic-push-notification.png",
					    	body:"새 쪽지가 도착 하였습니다. ",
					    	onclick:"alert('d');"
					    }				    		
					Notification.requestPermission().then(function(result) {
										
				      if(result=='denied'){
				    	 
				      alert(email+"님으로 부터 쪽지가 왔습니다");	
				  }else{
						var notification = new Notification(email+"님으로 부터 쪽지가 왔습니다",options);
					    notification.onclick =function (){
					       location.href="myrevmsg.do?recordCountPerPage=10";
					    }										  
				  }								 
			});						 
						$(".nowmymsg").val(count);
					}else{
						//alert(data);
					}					
				}				 
				 
			  },error:function(){
				  alert("실패!");
			  }
		   });
	}	
	 setInterval(noti,2000);	 	
});
	
</script>
</body>
</html>