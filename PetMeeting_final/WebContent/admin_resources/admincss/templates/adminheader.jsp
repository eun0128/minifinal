<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Admin-Mode</title>
    <meta name="description" content="Ela Admin - HTML5 Admin Template">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	
	<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/normalize.css@8.0.0/normalize.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.1/css/all.min.css" />
    <!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css"> -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pixeden-stroke-7-icon@1.2.3/pe-icon-7-stroke/dist/pe-icon-7-stroke.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.2.0/css/flag-icon.min.css">
    <link rel="stylesheet" href="admin_resources/admincss/css/cs-skin-elastic.css">
    <link rel="stylesheet" href="admin_resources/admincss/css/style.css">
    <!-- animate CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/animate.css?after">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/admin_common.css">
	<!-- custom CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/custom.css">

</head>

<body>
    <!-- Left Panel -->
    <aside id="left-panel" class="left-panel">
        <nav class="navbar navbar-expand-sm navbar-default">
            <div id="main-menu" class="main-menu collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="adminMain.do"><i class="menu-icon fa fa-laptop"></i>관리자 홈</a>
                    </li>
                    <li class="menu-title">게시판</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fas fa-paw"></i>소모임 게시판</a>
                        <ul class="sub-menu children dropdown-menu">                            
                        	<li><i class="fas fa-edit"></i><a href="adminPlayboardList.do">소모임 관리</a></li>
                        </ul>
                    </li>
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fas fa-donate"></i>후원 게시판</a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="fas fa-edit"></i><a href="adminFundingList.do">후원 관리</a></li>
                        </ul>
                    </li>
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fas fa-table"></i>자유 게시판</a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="fas fa-edit"></i><a href="forms-basic.html">자유게시판 관리</a></li>
                        </ul>
                    </li>
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fas fa-volume-up"></i>공지 게시판</a>
                        <ul class="sub-menu children dropdown-menu">
                           <li><i class="fas fa-edit"></i><a href="noticeList.do">공지게시판 관리</a></li>
                        </ul>
                    </li>
                     <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon far fa-calendar-alt"></i>행사안내 게시판</a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="menu-icon fas fa-edit"></i><a href="adminEventBoard.do">행사안내게시판 관리</a></li>
                        </ul>
                    </li>
                    
                    <li class="menu-title">굿즈샵</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fas fa-store"></i>상품</a>
                        <ul class="sub-menu children dropdown-menu">
                        	<li><i class="fas fa-cart-plus"></i><a href="adproductadd.do">상품 등록</a></li>
                        	<li><i class="fas fa-plus-square"></i><a href="adproductoption.do">상품 옵션 등록</a></li>
                        	<li><i class="fas fa-tags"></i><a href="adproductlist.do">상품 관리</a></li>
                        </ul>
                    </li>
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fas fa-boxes"></i>주문</a>
                        <ul class="sub-menu children dropdown-menu">
                        	<li><i class="fas fa-chart-line"></i><a href="adstore.do">매출 관리</a></li>
                        	<li><i class="fas fa-receipt"></i><a href="adorderlist.do">주문 관리</a></li>
                        	<li><i class="fas fa-retweet"></i><a href="adrefundlist.do">반품/교환 관리</a></li>
                        </ul>
                    </li>
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fas fa-table"></i>게시글</a>
                        <ul class="sub-menu children dropdown-menu">
                        	<li><i class="fa fa-question"></i><a href="adquestionlist.do">문의글 관리</a></li>
                        	<li><i class="fa fa-star"></i><a href="adreviewlist.do">리뷰글 관리</a></li>
                        </ul>
                    </li>

					<li class="menu-title">관리자</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
                        <i class="menu-icon fas fa-user-cog"></i>회원 관리</a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="menu-icon fas fa-users"></i><a href="adminMemberList.do">회원 목록</a></li>
                            <li><i class="menu-icon fas fa-chart-pie"></i><a href="adminMemleavegraph.do">회원탈퇴 통계</a></li>
                        </ul>
					</li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </nav>
    </aside>
    <!-- /#left-panel -->
    <!-- Right Panel -->
<!--     <div id="right-panel" class="right-panel"> -->
        <!-- Header-->
        <header id="header" class="header">
            <div class="top-left">
                <div class="navbar-header">
                    <a class="navbar-brand" href="./"><img src="${pageContext.request.contextPath}/common/navbar/img/petmeetinglogo.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="./"><img src="${pageContext.request.contextPath}/common/navbar/img/petmeetinglogo.png" alt="Logo"></a>
                    <a id="menuToggle" class="menutoggle"><i class="fa fa-bars"></i></a>
                </div>
            </div>
            <div class="top-right">
                <div class="header-menu">
                    <div class="user-area dropdown float-right">
                       
                     </div>
	                     <c:if test="${not empty login }">
	                     <div class="logindiv">
	                     	로그인 정보: 관리자&emsp;
	              			<a href="logout.do">로그아웃</a>
	              		 </div>
						 </c:if>
	                     <c:if test="${empty login }">
	                     <div class="logindiv">
	                     	로그인 정보: 관리자&emsp;
							<a href="login.do">로그인</a>                       		
	                      </div>
	                      </c:if>  
                    </div>

                </div>
        </header>
        <!-- /#header -->

        
        
        
        
        
        <!-- Footer 
        <footer class="site-footer">
            <div class="footer-inner bg-white">
                <div class="row">
                    <div class="col-sm-6">
                        
                    </div>
                    <div class="col-sm-6 text-right">
                       
                    </div>
                </div>
            </div>
        </footer>
        /.site-footer -->
 <!--    </div> -->
    <!-- /#right-panel -->

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-match-height@0.7.2/dist/jquery.matchHeight.min.js"></script>
    <script src="admin_resources/admincss/js/main.js"></script>
</body>
</html>