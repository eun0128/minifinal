
<%@page import="com.petmeeting.joy.mypage.model.MypageFollowDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/css/mypageFollow.css?after">
	<link rel="stylesheet"
	href="${pageContext.request.contextPath}/mypage_resources/mypage_h/msgbox/msgbox_style.css">
	
<%
	List<MypageFollowDto> list = (List) request.getAttribute("mypagelist");
	System.out.println("listsize" + list.size());
%>


</head>
<body>
<header class="header_area">
    	<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>
</header>
<div id="wrapper">

  <!-- Main -->
	<div id="main">
		<div class="inner">
		<section class="main-container">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12">
				<div class="mypageMain">
				 <h2>나의 구독</h2>
		 <hr>
				
			
			
		
				<div class="searchdiv">
					 <select class="s_category">
							<option vlaue="email">EMAIL</option>

					</select>
					<input type="text" class="searchtext">
					 <img alt="d" src="./mypage_resources/mypage_s/images/searchIcon1.png" class="searchbtn" id="searchBtn">
					
					<!-- <button type="button" class="searchbtn">
				  검색
					</button> -->

				</div>
         
				<div class="quotes">
					<%
						if (list.size() == 0) {
					%>
					구독하고 있는 사람이 존재 하지 않습니다.
					<%
						} else {
							for (int i = 0; i < list.size(); i++) {
								MypageFollowDto dto = list.get(i);
								System.out.println("jsp파일 안에 픽쳐 확인 : "+i+" 번째"+dto.getPicture());
					%>



					<div class="box box1" id="followbox<%=i + 1%>">
					

                       
						<div class="mypagecancel">
							<img  alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/more.png" 
							  onclick="getmodal(<%=i+1%>)">
                             		  
							  
					<%-- 		<img alt=""
								src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/Cancel.png"
								onclick="followDel('<%=dto.getEmail()%>')"> --%>
						</div>
						<div class="followingfollow">
							<span>
							<b class="followercountb"> [팔로워]</b>
							<a><%=dto.getFollower()%></a>
							<br><b> [팔로잉]</b> 
							<%=dto.getFolloing()%>
							</span>
						</div>

						<div class="followpprofile">
							<%
								if (dto.getPicture() == null || dto.getPicture() == "") {
							%>
					
							<img alt=""
								src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/pet1.jpg"
								class="myprofileimg">
							<%
								} else {
							%>
				
							<img alt="" src="upload/<%=dto.getPicture()%>" class="myprofileimg">
							<%
								}
							%>


							<div class="followemail">
						      <b><%=dto.getEmail()%></b>							
							</div>
							  <div class="follownickname">
								<%
									if (dto.getNickname().equals("")) {
								%>
								닉네임이 존재하지 않습니다
								<%
									} else {
								%>
								<b><%=dto.getNickname()%></b>
								<%
									}
								%>
							</div>





						</div>
						<div class="followEmailicon">
							<%-- <img alt=""
								src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/mail1.png"
								onclick="followemail()">  --%>
							<!-- <div class="icon-bar">
								<a class="active" href="#"><i class="fa fa-home"></i></a> <a
									href="#"><i class="fa fa-search"></i></a> <a href="#"><i
									class="fa fa-envelope"></i></a> <a href="#"><i
									class="fa fa-globe"></i></a> <a href="#"><i class="fa fa-trash"></i></a>
							</div> -->
						</div>


					</div>
				
					
					<div id="myModal<%=i+1 %>" class="modal" >
 
      <div class="modal-content"  >
                   <div class="mo">
                     <div class="modalout">
                     	<img  alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/multiply.png" onclick="close_pop(<%=i+1%>)">  
                      </div>
                      
                      <ul class="modalinul">
                        <li class="nonfollow"  onclick="followDel('<%=dto.getEmail()%>')"><a>  <img alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/bell.png" > 구독 취소 </a></li>
                        <li class="viewprofile" onclick="viewprofile('<%=dto.getEmail()%>')"><a><img alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/user.png" onclick=""> 프로필 </a></li>
                        <li class="sendmessage" onclick="myfollowsendmsg('<%=dto.getNickname()%>','<%=dto.getEmail()%>')"><a><img alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/noteemail.png" > 쪽지 보내기</a></li>
                        <li class="viewlist" onclick="viewlist('<%=dto.getEmail()%>' )"> <a><img alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/evaluate.png" onclick="">참여중인 모임</a></li>
                        <li class="viewFollow" onclick="viewFollow('<%=dto.getEmail()%>')"><a><img alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/conversation.png" onclick="">팔로우/팔로잉 보기</a></li>
                        
                      </ul>
                      <input type="hidden" class="pmodal" value="0">
                   
                   </div>
              
      </div>
 
    </div>
					
		
					


					<%
						}

						}
					%>
					<%
						int listtotal = (int) request.getAttribute("listtotalsize");
						System.out.println("listtotal" + listtotal);
					%>
					
				
					<input type="hidden" value="<%=list.size()%>" class="totalhidden">
					<input type="hidden" value="1" class="nowpage">
					<div class="morelist">
						<!-- 
						<a href="#" class="moreatag">더보기(More)</a> !-->
						<input type="hidden" value="1" class="nowpage">
<!-- 
						<button
							class="button button--nina button--text-thick button--text-upper button--size-s"
							data-text="MORE" id="moreatag">
							<span>M</span><span>O</span><span>R</span><span>E</span>
						</button>
						 -->
					
					  <div class="primary-button" id="moreatag">
                        <a href="#">More</a>
                      </div>
						
			</div>
	
	 				
   <div id="mypfModal" class="modal" >
    
      <div class="modalpf-content" >
                  <div class="modalout2">
                     	<img  alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/multiply.png" onclick="close_modal()">  
                   </div>
                   <div class="modalpfcontent">
                     <div class="modalheader">
                        <img alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/evaluate.png" onclick="">참여중인 모임
                      </div>
                    
            <div class="modalcontent_a">
        <%-- 
        
                       <div class="modaltitle">
                       	<img  alt='' src='./mypage_resources/mypage_h/mypageFollow/images/title.png' >  
                                                         나랑 같이 알탕 먹으러 가실분
                       </div>
                       <div class="modaltime"> 
                        <img  alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/time.png" >  
                      2019-10-23 00:00:00:0 
                       </div>
                       
                       
                       <div class="modaltitle">
                                    	<img  alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/title.png" >
                            내 모임에 좀 참가 해주라!!
                       </div>
                       <div class="modaltime"> 
                       <img  alt="" src="${pageContext.request.contextPath}/mypage_resources/mypage_h/mypageFollow/images/time.png" >  
                        2019-10-23 00:00:00:0 
                          </div>
                           --%>
                          
             </div>   
         
                   </div>
       
       
       <!-- 쪽지 보낼 pop -->

       
       
       
                 </div>






					<!--follow코드 오는 부분! 끝  -->
				</div>
			</div>
</div>

<!-- 메인 끝!!! -->
				
				
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

	
	          
		<script type="text/javascript">
		
		
		/* 
		Notification.requestPermission().then(function(result) {
			 alert(result);
			 
			 if (Notification.permission === "granted") {
				 alert("알림 어케 하는건데!!"); 
				 
				 // If it's okay let's create a notification
				    var notification = new Notification("새 쪽지가 등록 되었습니다");
				  }
			});
		
		 */
		
		
		//알림 !
		
		$(document).ready(function () {
			$("#frm").hide();
		});
		
		
		//팔로우 팔로잉 보기를 눌렀을 때
		function viewFollow(e) {	
			var name = "FOLLOW";
		    var option = "scrollbars=no, left=400,top=200, width=492, height=595";
			window.open("mypagefollowfollower.do?myemail="+e,name,option);
	       /* 
			
			$.ajax({
				
				 type:"POST",
				 url:"mypagefollowfollower.do",
				 async: false,
				 data:{"myemail":e},
				 success:function(data){
			       	alert("성공");
			       	alert(data);
				 
				 },error:function(){
				alert("실패")
				 
				 }
			});
			 */
			
		}
		
		function myfollowsendmsg(n,e) {
		//	alert("nickname"+n);
		//	alert("mail"+e);
		
			   var nowmodal=$(".pmodal").val();
		    $('#myModal'+nowmodal).hide();
	
		    var url =  "mypageFollowreplymsg.do?to_email="+e+"&nickname="+n;
			var option = "scrollbars=no, left=400,top=200, width=472, height=595";
			var name = "새 쪽지";
			window.open(url, name, option);
	 
		}
		
		
		
		function close_modal() {
			alert("dd");
			$("#mypfModal").hide();
			
			
			
		};
		
		
		function viewlist(e) {
		
			$("#mypfModal").show();
		    var nowmodal=$(".pmodal").val();
		    $('#myModal'+nowmodal).hide();
		    
			//$(".modal").show();
		
		 
			
			$.ajax({
				 type:"POST",
				 url:"mypagefollowmyattendplay.do",
				 async: false,
				 data:{"email":e},
				  success:function(data){
					  alert("성공");
					//  alert(data);
					  
				 $(".modalcontent_a").html(data);
				  },error:function(){
					  alert("실패");
				  }
			})
			  
		}
		
		
		//프로필 보기를 눌렀을 때
		function viewprofile(e) {
			alert(e);			
			    var url =  "mypagefollowprofile.do?email="+e;
				var option = "scrollbars=no, left=400,top=200, width=420, height=420 ";
				var name = "프로필";
				
				window.open(url, name, option);
			
		};
		
		
		
		//프로필 옆 더보기 아이콘 눌렀을 때
	
		function getmodal(e) {
			 $('#myModal'+e).show();
			 $(".pmodal").val(e);
			// alert( $(".pmodal").val());
		}
	
	
		function moremodal(e) {
	  //      $('#myModal').show();		
	     }
		 function close_pop(e){	
		    $('#myModal'+e).hide();	   
		    $(".modal").hide();
		    self.close();
		 };

		 
		 
		 
		
			//검색
			$(".searchbtn").click(function() {
								var email = $(".searchtext").val();
								if (email == "") {
									alert("email을 입력 해 주세요");
									$(".searchtext").focus();
									return false;
								}

								location.href = "mypagefollow.do?s_category=email&s_keyword="
										+ email;

							});

			$(document).ready(function() {
				//

				//
				var totallist = $(".totalhidden").val();

				if (totallist <= 6) {
					$(".morelist").hide();
				}

				//	alert(totallist);
				for (var i = 7; i <= totallist; i++) {
					$("#followbox" + i).hide();
				}

				$("#moreatag").focus();
			});

			$("#moreatag").click(function() {
				var nowpage = $(".nowpage").val();
				var spage = nowpage * 6 + 1; //7
				var epage = spage + 6; //13
				$(".nowpage").val(Number(nowpage) + 1);
                 
				
				  
			

				for (var i = spage; i < epage; i++) {
					$("#followbox" + i).fadeIn(1000);
				}

				var totallist = $(".totalhidden").val();
				//  alert("totallist"+totallist);
				if (epage >= totallist) {
					$(".morelist").hide();
				}

				$('html, body').animate({
					scrollTop : $('#followbox'+spage).offset().top
				}, 'slow');

			
			});

			//구독 취소 버튼
			function followDel(e) {
				alert(e + "삭제");

				if (confirm("팔로우를 취소하시겠습니까?")) {
					location.href = "mypagefolloingdel.do?folloingid=" + e;
				} else {
				}

				//		location.href = "mypagefolloingdel.do?folloingid=" + e;
			}

			//쪽지 보내기 버튼
			function followemail() {
			//	alert("쪽지 보내기");
			}
		</script>
</body>

</html>