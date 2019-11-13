<%@page import="com.petmeeting.joy.store.model.CartDto"%>
<%@page import="java.util.List"%>
<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 	<!-- formatNumber(10000 -> 10,000)기능 사용하기 위해 추가 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	<!-- list의 사이즈를 구하기 위해 추가 -->

<%
//주문번호 생성을 위해 주문한 날짜를 가져옴
Calendar cal = Calendar.getInstance();
int year = cal.get(Calendar.YEAR);
String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
String ymd = ym +  new DecimalFormat("00").format(cal.get(Calendar.DATE));
String subNum = "";

// 중복을 막기위해 랜덤숫자를 날짜뒤에 추가해줌
for(int i = 1; i <= 6; i ++) {
 subNum += (int)(Math.random() * 10);
}

String orderNumber = ymd + subNum;
// out.println("orderNumber : "+ orderNumber);
%>
<%
String[] index = request.getParameterValues("index"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting Store</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/owl.carousel.min.css">
    <!-- themify CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/themify-icons.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/flaticon.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/magnific-popup.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/style.css">
    <!-- 우리가 추가한 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/custom.css?after">
<style type="text/css">

.list_table{
 	width: 970px;
	margin: auto;
}
caption {
	caption-side: top;
}
.orderInfo{
/* min-width: 970px; */
min-width: 450px;
}
.orderInfo td{
text-align: left;
}
.agree td{
text-align: right;
}
#s-btn{
width: 100px;
height: 30px;
background: #e0e0e0;
border: none;
font-weight: bold;
border-radius: 7px;
font-size: 12px;
}
.product_name{
text-align: left;
}
b{
color: black;
}

input[type=checkbox] { display:none; }

input[type=checkbox] + label { 
display: inline-block; 
cursor: pointer; 
line-height: 22px; 
padding-left: 22px; 
background: url("./store_resources/images/noncheck-mark.png") no-repeat; 
background-position: left;
}

input[type=checkbox]:checked + label { 
background: url("./store_resources/images/checked.png") no-repeat; 
background-position: left;
} 

.orderpoint{
margin: 0 auto;
width: 1000px;
min-width:970px; 

}

</style>
 
<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script> -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>	<!-- 우편번호API -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script> 	<!-- 결제API -->
</head>
<body >
	<header class="header_area">
	    <div class="main_menu">
	        <div class="container">
	            <div class="row">
	                <div class="col-lg-12">
							<div class="s-navi-top">
								<div class="s-loginInfo">
								<c:if test="${login == null }">
									<a href="login.do">LOGIN</a>&nbsp;&nbsp;&nbsp;<a href="account.do">JOIN</a>							
								</c:if>
								<c:if test="${login != null }">
									안녕하세요. <b>${login.nickname }</b>님!&nbsp;&nbsp;&nbsp;<a href="logout.do">로그아웃</a>
								</c:if>
								</div>
							</div>
							
							<div class="s-navi-bottom">
	                        	<div class="s-logo">
	                        		<img alt="이미지없음" src="${pageContext.request.contextPath}/common/navbar/img/petmeetinglogostore.png" width="auto" height="30px"
	                        			onclick="location.href='productlist.do'">
	                        	</div>
	                        
	                        	<div class="s-mymenu">
									<div class="s-mymenu-petmain">
										<img alt="이미지없음" src="${pageContext.request.contextPath}/store_resources/images/home.png" width="30px" height="30px" onclick="location.href='main.do'">&nbsp;&nbsp;&nbsp;
									</div>
									<div class="s-mymenu-mystore">
										<img alt="이미지없음" src="${pageContext.request.contextPath}/store_resources/images/user.png" width="30px" height="30px" onclick="location.href='mystore.do'">&nbsp;&nbsp;&nbsp;
									</div>
									<div class="s-mymenu-cart">
										<img alt="이미지없음" src="${pageContext.request.contextPath}/store_resources/images/cart.png" width="30px" height="30px" onclick="location.href='cart.do'">
									<%
									HttpSession se = request.getSession();
									MemberDto user = (MemberDto)se.getAttribute("login");
									
									if(user != null) {
										List<CartDto> clist = (List<CartDto>)se.getAttribute(user.getEmail());
										
										if(clist != null && clist.size() > 0) {
										%>
											<span class="s-mymenu-cart-count"><%=clist.size() %></span>
										<%
										}
									}
									%>
									</div>
								</div>
	                        </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</header>

<div class="container s-container">
<div>
<div class="s-title" style="text-align: center">
	<h2>Order</h2>
</div>
<%-- ${fn:length(index) } --%>
<c:if test="${empty olist }">
<form id="_orderform" method="post">
		<input type="hidden" name="productcode" value="${oBean.productcode }"> 
		<input type="hidden" name="psize" value="${oBean.psize }"> 
		<input type="hidden" name="pcolor" value="${oBean.pcolor }"> 
		<input type="hidden" name="quantity" value="${oBean.quantity }"> 
		<input type="hidden" name="totalprice" value="${oBean.totalprice }"> 
<table class="list_table">
<caption>주문 상품 내역</caption>
<colgroup>
<col width="160"><col width="250"><col width="120"><col width="150"><col width="200">
</colgroup>
<thead>
	<tr>
		<th colspan="2">상품정보</th>
		<th>수량</th>
		<th>배송비</th>
		<th>주문금액</th>
	</tr>
</thead>
<tbody>
	<tr align="center">
		<td>
			<div class="product_img_link">
			<a href="${pageContext.request.contextPath}/productdetail.do?pcode=${oBean.productcode }">
				<img class="thumbnailImg" alt="이미지 없음" src="upload/${oBean.filename }" name="filename" >
			</a>
			</div>
		</td>
		<td>
			<div class="product_name">
				<b><a href="${pageContext.request.contextPath}/productdetail.do?pcode=${oBean.productcode }">${oBean.productname }</a></b><br><br>
					[사이즈] ${oBean.psize }<br>
					[색상] ${oBean.pcolor }
			</div>
		</td>
		<td>${oBean.quantity }</td>
		<td>2,500원</td>
		<td> ₩ <fmt:formatNumber value="${oBean.totalprice }" pattern="#,###"/></td>
	</tr>
	<tr>
		<td colspan="5" align="right">
			상품합계  ₩ <fmt:formatNumber value="${oBean.totalprice }" pattern="#,###"/> + 배송비 2,500  | 총 합계  
			<font color="#E5433E" size="6px" style="font-weight: bold">  ₩<fmt:formatNumber value="${oBean.totalprice + 2500 }" pattern="#,###"/> </font>
		</td>
	</tr>
</tbody>
	</table>
	</form>
	</c:if>
	
<c:if test="${not empty olist }">
<form id="multi_orderform">
<table class="list_table" border="1">
<caption>주문 상품 내역</caption>
<colgroup>
<col width="200"><col width="250"><col width="120"><col width="150"><col width="200">
</colgroup>
<thead>
	<tr>
		<th colspan="2">상품정보</th>
		<th>수량</th>
		<th>배송비</th>
		<th>주문금액</th>
	</tr>
</thead>
	<tbody>
	<c:set var="sum" value="0" />
	<c:forEach items="${olist }" var="list" varStatus="vs">
			<input type="hidden"  class='totalP' value="${list.totalprice }"> 
		<tr align="center">
		<td>
			<div class="product_img_link">
			<a href="${pageContext.request.contextPath}/productdetail.do?pcode=${list.productcode }">
				<img class="thumbnailImg" alt="이미지 없음" src="upload/${list.filename }" name="filename" >
			</a>
			</div>
		</td>
		<td>
			<div class="product_name">
				<b><a href="${pageContext.request.contextPath}/productdetail.do?pcode=${list.productcode }">${list.productname }</a></b><br>
					[사이즈] ${list.psize }<br>
					[색상] ${list.pcolor }
			</div>
		</td>
		<td>${list.quantity }
			<input type="hidden" name="quantity" value="${list.quantity }"> 
		</td>
		<c:if test="${vs.count eq 1 }">
			<td rowspan="${fn:length(olist) }" >₩2,500원</td>
		</c:if>
		<td>
			 ₩ <fmt:formatNumber value="${list.totalprice }" pattern="#,###"/>
		</td>
		
	</tr>
	<c:set var="sum" value="${sum + (list.totalprice) }" />
	</c:forEach>
	<tr>
		<td colspan="5" align="right">
				상품합계 ₩ <span id="product_price"></span> + 배송비 2,500   | 총 합계 <font color="#E5433E" size="6px" style="font-weight: bold"> ₩<fmt:formatNumber value="${sum + 2500 }" pattern="#,###"/> </font>
		</td>
	</tr>
</tbody>
</table>
</form>

<c:forEach items="${olist }" var="list" varStatus="vs">
<form id="multiorder-form${vs.index }" method="post">
	<input type="hidden" name="ordernumber" value="<%=orderNumber%>"> 
	<input type="hidden" name="email" value="${login.email }">
	<input type="hidden" name="index" value="${index[vs.index] }">
	<input type="hidden" name="product_option_seq" value="${list.product_option_seq }"> 
	<input type="hidden" name="productcode" value="${list.productcode }"> 
	<input type="hidden" name="productname" id="_productname" value="${list.productname }"> 
	<input type="hidden" name="psize" value="${list.psize }"> 
	<input type="hidden" name="pcolor" value="${list.pcolor }"> 
	<input type="hidden" name="totalprice" value="${list.totalprice}" > 
	<input type="hidden" name="quantity" value="${list.quantity }"> 
	<input type="hidden" name="filename" value="${list.filename }"> 
	<input type="hidden" name="use_point" value="0">
</form>
</c:forEach>

</c:if>
</div>
<br><br><br>

<form id="_orderInfoform" method="post">
<div class="orderpoint">
<div align="center" style="display: inline-block;">
<input type="hidden" name="ordernumber" value="<%=orderNumber%>">
<c:if test="${type != 'one' }">
	<input type="hidden" name="totalprice" value=${sum }>
</c:if>
<% if(index != null) {
	for(int i=0; i<index.length; i++){
	%>
	<input type="hidden" name="index" value="<%=index[i]%>">
	<%
		}
	}
%>
<input type="hidden" name="email" value="${login.email }">
<table class="orderInfo" >
<caption align="top">주문자 정보</caption>
<col width="140"><col width="410">
	<tr>
		<th>배송지 선택</th>
		<td>
			<label id="exiDelivery"><input type="radio" id="exiDelivery" name="delivery" value="주문자 정보와 동일" checked="checked">주문자 정보와 동일</label>
			&emsp; <label id="newDelivery"><input type="radio" id="newDelivery" name="delivery" value="직접 입력">직접 입력</label>
		</td>
	</tr>
	<tr>
		<th>받는 사람 성함</th>
		<td>
			<input type="text" name="rname" id="_rname" value="${login.name }">
		</td>
	</tr> 
	<tr>
		<th>받는 사람 주소</th>
		<td>
			<input type="text" id="sample4_postcode" name="rpostcode" placeholder="우편번호" style="width: 12em; height: 2em;" value="${login.postcode }">
			<input type="button" class="btn_post" id="s-btn"  onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="sample4_roadAddress" name="raddress" placeholder="도로명주소" style="width: 20em; height: 2em;" value="${login.address }"><br>
			<input type="text" id="sample4_detailAddress" name="raddress_detail" placeholder="상세주소" style="width: 12em; height: 2em;" value="${login.address_detail }">
			<input type="text" id="sample4_extraAddress" name="extraAddress" placeholder="참고항목" value="${login.address_refer }"> 
		</td>
	</tr>
	<tr>
		<th>휴대전화</th>
		<td>
		<input type="text" size="20" name="rphone" id="_rphone" value="${login.phone }">
		</td>
	</tr>
	<tr>
		<th>배송메시지</th>
		<td>
			<textarea rows="5" cols="55" name="require" id="_require" style="resize: none" placeholder="부재시 문 앞에 부탁드립니다"></textarea>
		</td>
	</tr>
</table>
</div>

<div style="border: 2px solid #e0e0e0; margin-left: 30px; width: 350px; display: inline-block; text-align: center;">
<br>
<font style="font-weight: bold; font-size: 15px;">적립 예정 포인트</font> &emsp;
	<c:if test="${empty olist }">
		<b><fmt:formatNumber value="${oBean.totalprice * 0.05}" pattern="#,###" />P</b>
	</c:if>
	<c:if test="${not empty olist }">
		<b><span id="_savepoint"></span>P</b>
	</c:if>
	<br>
	<hr width="290px;" color="#000">
	<br>
	<b>사용할 적립금</b> &emsp; <input type="text" name="use_point" id="usepoint"  style="font-weight: bold;" placeholder="0" value="0"> <b>P</b>
	<hr width="290px;" color="#e0e0e0">
	<input type="checkbox" id="allPoint"><label for="allPoint" ><b>전체 사용</b></label> &emsp; 
	총 사용 가능 적립금 <font style="font-weight: bold;" color="#E5433E">${login.s_point }</font> P
	<br>
	<div align="left" style="margin-left: 40px;" >
		<div>· 적립금은 <b>최소 1p</b> 이상부터 사용 가능합니다.</div>
		<div>· 적립금은 최대 사용금액 제한이 없습니다.</div>
	</div>
	<br>
</div>

</div>
</form>

<br><br><br>

<div align="center" >
<table class="agree">
<caption>약관 동의</caption>
<colgroup>
	<col width="800">
</colgroup>
<thead>
	<tr>
		<th align="left">이용약관동의 </th>
	</tr>
</thead>
<tbody>
	<tr>
		<td>
			<textarea rows="5" cols="133" style="resize: none" readonly="readonly" >이 PETMEETING STROE 서비스 이용 약관은 주식회사 마케팅(이하 ‘회사’라 함)이 운영하는 PETMEETING STROE 의 적립금 및 쿠폰 제도 이용에 대한 ‘PETMEETING STROE  서비스’ 약관으로 구성 됩니다.제 1 장(PETMEETING STROE  서비스)제 1 조(목적)이 약관은 ‘회사’가 운영하는 PETMEETING STROE  (이하 ‘판매채널’이라 합니다)를 통하여 제공하는 전자상거래 서비스(이하 ‘서비스’라 함)와 관련하여 ‘회사’와 ‘이용자’(제2조에 정합니다)의 권리와 의무, 책임사항 및 ‘이용자’의 ‘서비스’ 이용절차에 관한 사항을 규정함을 목적으로 합니다. 제 2 조(정의)①이 약관에서 사용하는 용어의 정의는 다음과 같습니다. 1.판매채널: ‘회사’가 상품 또는 용역(이하 ‘상품 등’이라 합니다)을 ‘이용자’에게 판매/제공할 수 있도록 마련한 ‘회사’의 인터넷 사이트와 스마트폰 등 이동통신기기를 통해 제공하는 모바일 어플리케이션 또는 모바일 웹을 말합니다.2.이용자: ‘판매채널’에 접속하여 이 약관에 따라 ‘회사’가 제공하는 ‘서비스’를 받는 회원 및 비회원을 말합니다.3.회원: ‘회사’에게 개인정보를 제공하여 회원 등록을 한 자로서 이 약관에 따라 ‘회사’와 ‘서비스’ 이용계약을 체결한 자를 말합니다. 고 ‘회사’가 제공하는 ‘서비스’를 이용하는 자를 말합니다.5.아이디(ID): ‘회원’의 식별과 ‘서비스’ 이용을 위하여 ‘회원’이 선정하고 ‘회사’가 승인한 영문 대소문자, 숫자의 조합을 말합니다.6.비밀번호(Password): ‘회원’의 동일성 확인과 ‘회원’의 권익 및 비밀보호를 위하여 ‘회원’ 스스로가 설정하여 ‘회사’에 등록한 영문 대소문자, 숫자, 특수문자의 조합을 말합니다.7.게시물: ‘‘회원’이 ‘서비스’를 이용함에 있어 ‘판매채널’ 상에 게시한 부호, 문자, 음성 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다.②이 약관에서 정의되지 않은 용어는 상관례 내지 관련법령이 정하는 바에 따릅니다.제 3 조(약관 등의 명시와 설명 및 개정)①‘회사’는 이 약관의 내용, 상호, 대표자의 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 사업자등록번호, 통신판매업 신고번호, 고객센터 번호, 전자우편주소 등을 ‘회원’이 쉽게 알 수 있도록 ‘판매채널’의 초기 ‘서비스’ 화면에 게시합니다. 다만, 이 약관의 구체적 내용은 ‘회원’이 연결화면을 통하여 볼 수 있습니다.②‘회사’는 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회・배송책임・환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.③‘회사’는 약관의 규제에 관한 법률, 전자문서 및 전자거래기본법, 전자금융거래법, 전자서명법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전자상거래 등에서의 소비자보호에 관한 법률, 소비자기본법, 위치정보의 보호 및 이용 등에 관한 법률 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.④‘회사’가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행 약관과 함께 ‘판매채널’의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 단, ‘회원’에게 불리하게 약관 내용을 변경하는 경우에는 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 ‘회사’는 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.⑤‘회사’가 전항에 따라 개정약관을 공지 또는 통지하면서 ‘회원’에게 약관 변경 적용일까지 거부의사를 표시하지 아니할 경우 약관의 변경에 동의한 것으로 간주 한다는 뜻을 명확하게 공지 또는 통지하였음에도 ‘회원’이 명시적으로 거부의 의사표시를 하지 아니한 경우, ‘회원’이 개정약관에 동의한 것으로 봅니다. ‘회원’이 개정약관의 적용에 동의하지 않는 경우 ‘회사’는 해당 ‘회원’에 대해 개정 약관의 내용을 적용할 수 없으며, 이 경우 ‘회원’은 이용계약을 해지할 수 있습니다.⑥‘회사’가 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제4항에 의한 개정약관의 공지기간 내에 ‘회사’에 송신하여 ‘회사’의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.⑦이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.제 4 조(개별 서비스에 대한 약관 및 이용조건)‘회사’는 제공하는 ‘서비스’의 구체적 내용에 따라 개별 ‘서비스’에 대한 약관 및 이용조건을 각 개별 ‘서비스’마다 별도로 정하여 ‘회원’의 동의를 얻을 수 있습니다. 이 경우 개별 ‘서비스’에 대한 이용약관 등이 본 약관에 우선합니다.제 5 조(이용계약의 성립)①이용계약은 ‘회원’의 약관 동의, 이용신청에 대한 ‘회사’의 승낙에 의하여 성립합니다.②이용계약의 성립시기는 ‘회사’가 가입완료 표시를 신청절차 상에서 표시한 시점으로 합니다.③이용계약은 관련법령에 의거 만14세 미만의 회원 가입이 제한될 수 있습니다.제 6 조(이용신청 및 승낙)①‘회원’은 ‘회사’가 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로써 회원 가입을 신청합니다.②‘회사’는 전 항에 따른 이용신청 시 ‘회원’에게 전문기관을 통한 본인인증 절차를 요청할 수 있습니다.③‘회사’는 다음 각 호에 해당하는 이용신청에 대하여는 이를 승낙하지 아니하거나 사후에 이용계약을 해지할 수 있습니다. 1.‘회사’가 실명확인절차를 실시할 경우에 ‘회원’의 실명이 아님이 확인된 경우2.이미 가입된 ‘회원’의 전자우편주소 등의 정보가 동일한 경우3.타인의 명의를 도용하거나, 기입내용에 허위, 기재누락, 오기가 있는 경우4.이 약관에 의하여 이전에 회원 자격을 상실한 적이 있는 경우. 다만, 회원자격 상실 후 3년이 경과한 자로서 ‘회사’의 회원 재가입 승낙을 얻은 경우에는 예외로 합니다.5.‘회원’이 탈퇴를 한 날로부터 60일이 경과하지 않은 경우6.‘회원’의 의도적인 탈퇴와 재가입이 확인되는 경우7.부정한 용도 또는 영리를 추구할 목적으로 ‘서비스’를 이용하고자 하는 경우(단, ‘회사’가 승인한 범위 내에서의 서비스 이용은 예외로 함)8.이전에 동일∙유사한 아이디 또는 다른 아이디를 통하여 부정한 사용을 한 이력이 있거나 의심되는 경우9.관련법령에 위배되거나 사회의 안녕질서 혹은 미풍양속을 저해할 수 있는 목적으로 신청한 경우10.‘서비스’ 운영에 따른 설비에 여유가 없거나 기술상 지장이 있는 경우. 다만, 이 경우 그 사유가 해소될 때까지 이용 승낙을 유보할 수 있습니다.11.만14세 미만의 아동이 법정대리인(부모 등)의 동의를 얻지 아니한 이용신청을 하는 경우12.기타 이 약관에 위배되거나 위법 또는 부당한 이용신청임이 확인된 경우 및 ‘회사’가 합리적인 판단에 의하여 필요하다고 인정하는 경우제 7 조(회원의 아이디 및 비밀번호에 대한 의무)①‘아이디’와 ‘비밀번호’에 관한 관리책임은 ‘회원’에게 있으며, 이를 소홀히 하여 발생한 모든 민형사상의 책임은 ‘회원’ 자신에게 있습니다.②‘회원’ 자신의 ‘아이디’ 및 ‘비밀번호’를 제3자가 이용하게 해서는 안됩니다.③‘회원’이 자신의 ‘아이디’ 및 ‘비밀번호’를 도난 당하거나 제3자가 사용하고 있음을 인지한 경우에는 즉시 ‘회사’에 통보하고 ‘회사’의 조치가 있는 경우에는 그에 따라야 합니다.④‘회원’이 전 항에 따른 통지를 하지 않거나 ‘회사’의 조치에 응하지 아니하여 발생하는 모든 불이익에 대한 책임은 ‘회원’에게 있습니다.제 8 조(이용자의 의무)①‘이용자’는 관계법령, 이 약관의 규정, 이용안내 등 ‘회사’가 통지하는 사항을 준수하여야 하며, 기타 ‘회사’ 업무에 방해되는 행위를 하여서는 안됩니다.②‘이용자’는 ‘서비스’ 이용과 관련하여 다음 각 호의 행위를 하여서는 안됩니다. 1.‘서비스’ 신청 또는 변경 시 허위내용의 등록2.‘회사’가 게시한 정보의 허가 받지 않은 변경3.‘회사’가 정한 정보 이외의 정보(컴퓨터 프로그램 등)의 송신 또는 게시4.‘회사’ 및 기타 제3자의 저작권 등 지식재산권에 대한 침해5.‘회사’ 및 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위6.외설 또는 폭력적인 메시지, 동영상, 음성 기타 공공질서, 미풍양속에 반하는 정보를 ‘판매채널’에 공개 또는 게시하는 행위7.‘회원’의 의무 불이행 (‘회원’에 한함)8.기타 관련법령이나 ‘회사’에서 정한 규정에 위배되는 행위제 9 조(‘회사’의 의무)①‘회사’는 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화・용역을 제공하는데 최선을 다하여야 합니다.②‘회사’는 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함) 보호를 위한 보안 시스템을 갖추어야 합니다.③‘회사’가 상품이나 용역에 대하여 표시・광고의 공정화에 관한 법률 제3조 소정의 부당한 표시・광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.④‘회사’는 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.부 칙 이 약관은 2019년 4월 5일부터 시행합니다.</textarea>		
		</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="_agree"><label for="_agree"><b>이용약관에 동의합니다</b></label></td>
	</tr>
</tbody>
</table>
<br>

<div align="center">
<button type="button" class="l-btn" name="pay" id="_pay" onclick="pay()">결제하기</button>
</div>
</div>
</div>

	<!-- Footer part start -->
	<footer class="footer_area">
		<div class="container">
			<div class="footer-title">
				PETMEETING STORE
			</div>
			<div class="footer-content">
				<div class="footer-content-element">
					<span class="element-title">회사명</span> (주)펫미팅스토어
				</div>
				<div class="footer-content-element">
					<span class="element-title">대표자명</span> 박유림
				</div>
				<div class="footer-content-element">
					<span class="element-title">주소</span> 서울특별시 서초구 강남대로 459 백암빌딩 5층
				</div>
				<div class="footer-content-element">
					<span class="element-title">대표번호</span> 010 1234 5678
				</div>
				<div class="footer-content-element">
					<span class="element-title">개인정보 보호 책임자</span> 김연하 younger9403@gmail.com
				</div>
				<div class="footer-text">
					PETMEETING STORE의 모든 콘텐츠는 저작권의 보호를 받고 있습니다.
				</div>
			</div>
			<div class="footer-bottom">
				
			</div>
		</div>
	</footer>
	<!-- Footer part end -->

	<!-- jquery plugins here-->
    <!-- jquery -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/jquery-1.12.1.min.js"></script>
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
// 금액 포맷(#,###) 함수
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 총 금액 뿌려주기
var tot = $(".totalP");
// ==> <input type="hidden" class='totalP' value="${list.totalprice }">
var total_p = 0;

for (var i = 0; i < tot.length; i++) {
	var _totalprice = tot.eq(i);
	total_p += parseInt(_totalprice.val());
	
	$("#product_price").text(numberWithCommas(total_p));
	$("#_savepoint").text(numberWithCommas(total_p * 0.05));
// 	$("#total_price").text(numberWithCommas(total_p + 2500));
}
var _product_name = $("#_productname").val();
// alert(_product_name);

// 로그인 한 유저의 정보
var email = "<c:out value="${login.email }"/>";
var name = "<c:out value="${login.name }"/>";
var post_code = "<c:out value="${login.postcode }"/>";
var address = "<c:out value="${login.address }"/>";
var address_detail = "<c:out value="${login.address_detail }"/>";
var address_refer = "<c:out value="${login.address_refer }"/>";
var phone = "<c:out value="${login.phone }"/>";
var point = "<c:out value="${login.s_point }"/>";

// 선택한 상품 정보
var product_code = "<c:out value="${oBean.productcode}"/>";
var product_name = "<c:out value="${oBean.productname}"/>";
var quantity= "<c:out value="${oBean.quantity}"/>";
var price_t = "<c:out value="${oBean.totalprice }"/>";
var price_total = parseInt(price_t);
var index ="<c:out value = "${index[vs.count -1] }"/>"


// 전체 사용을 눌렀을 때 적립금 처리
$('#allPoint').on("click", function () {
	if($("input:checkbox[id='allPoint']").is(":checked") == true){	// 전체 사용이 체크되면
		
		if(price_total + 2500 < point && total_p == 0){		// 바로주문하기일 떄
			$("#usepoint").val(price_total + 2500);
		}else if(total_p + 2500 < point && total_p != 0){	// 카트 주문일 때
			$("#usepoint").val(total_p + 2500);	// 상품가격보다 포인트가 더 많으면 상품가격만큼만 사용함
		}else{
			$("#usepoint").val(point);		
		}
	}else{
		$("#usepoint").val('0');
	}
});

// 텍스트필드 실시간 감지를 이용한 적립금 초과사용 방지
$("#usepoint").on("propertychange change keyup paste input", function() {
    var use_point = $(this).val();

    if(parseInt(use_point) > parseInt(point)){
    	alert("적립금은 사용 가능 적립금을 초과해서 사용할 수 없습니다.");
    	$("#usepoint").val('0');
    }
	if($("#usepoint").val() != point){
		$("input:checkbox[id='allPoint']").prop("checked", false);
	}

});


	
// 적립금 숫자 외 문자 불허용
$("input:text[id='usepoint']").on("keyup", function() {
    $(this).val($(this).val().replace(/[^0-9]/g,""));
});

//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
  	   
        	// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
			if(roadAddr !== ''){
               document.getElementById("sample4_extraAddress").value = extraRoadAddr;
           } else {
               document.getElementById("sample4_extraAddress").value = '';
           }
        }
    }).open();
}

function pay() {
	var use_P = $("#usepoint").val();	// 사용하는 적립금
	var useP = parseInt(use_P);
	
	$("input:hidden[name='use_point']").val(useP);
	
	
	if($("input:checkbox[id='_agree']").is(":checked") == false){	// 이용약관에 체크가 안되어있으면 
		alert('이용약관에 동의해주세요');
		event.preventDefault();					// 결제(이벤트) 진행X
	}else if($("#_rname").val() == "" ||
		$("#sample4_postcode").val() == "" ||
		$("#sample4_roadAddress").val() == "" ||
		$("#sample4_detailAddress").val() == "" ||
		$("#_rphone").val() == ""){				// 주문자 정보가 공백이면
		alert('주문자 정보를 모두 입력해주세요.');
		event.preventDefault();				
	}else {		// 체크가 되어있으면 결제 진행
		var IMP = window.IMP; // 생략가능
		
		var formData = $("#_orderform").serialize() + "&" + $("#_orderInfoform").serialize();
		
		IMP.init('imp27799924'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		
		var type = '<%=request.getAttribute("type")%>'
		var orderNo = '<%=orderNumber%>';
		var delivery = 2500;
		if (type == 'one') {
		//	alert("if type = one")
			IMP.request_pay({
				pg : 'KG inicis',
				pay_method : 'card',
				merchant_uid : <%=orderNumber%>,
				name : '주문명:' + product_name,
				amount : price_total + delivery - useP,
			//	amount : 10,
				buyer_email : email,
				buyer_name : name,
				buyer_tel : phone,
				buyer_addr : address,
				buyer_postcode : post_code
			}, function(rsp) {
				if (rsp.success) {
					//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
					jQuery.ajax({
						url : "productorderAf.do", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
						type : 'POST',
						data : formData,
						async : false,
					}).done(function(data) {
						//	alert(rsp.status);
						//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
						if (rsp.status == 'paid') {
							var msg = '결제가 완료되었습니다.';
					        msg += '결제 금액 : ' + rsp.paid_amount;
					        msg += '주문번호 : ' + rsp.merchant_uid;
					        msg += '카드 승인번호 : ' + rsp.apply_num;
						
					        $("#_orderInfoform").attr("action", "ordercomplete.do").submit();
					        alert(msg);
						} else {
							//[3] 아직 제대로 결제가 되지 않았습니다.
							//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
						}
					});
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;

					alert(msg);
				}
			});
		
			 
// 				 $("#_orderInfoform").attr("action", "ordercomplete.do").submit();
				 
			}else if(type == "null"){

				IMP.request_pay({
					pg : 'KG inicis',
					pay_method : 'card',
					merchant_uid : <%=orderNumber%>,
					name : '주문명:' + _product_name + '외 ' + tot.length + '개' ,
 					amount : total_p + delivery - useP,
//					amount : 10,
					buyer_email : email,
					buyer_name : name,
					buyer_tel : phone,
					buyer_addr : address,
					buyer_postcode : post_code
				}, function(rsp) {
					if (rsp.success) {
						var orderdetail = $("#_orderInfoform").serialize();
						//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
						jQuery.ajax({
							url : "cartorderdelete.do", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
							type : 'POST',
							data : orderdetail,
							async : false
						}).done(function(data) {
							//	alert(rsp.status);
							//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
							if (rsp.status == 'paid') {
								for (var i = 0; i < tot.length; i++) {
				// 					alert(tot.length);
									var formD = $("#multiorder-form"+i).serialize();
								
				//					alert(formD);
									
									$.ajax({
										url : "cartorderAf.do", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
										type : 'POST',
										data : formD,
										async : false,
										success: function () {
										//	alert("suc");
										},
										error: function () {
											alert("err")
										}
									});
								}
			
								var msg = '결제가 완료되었습니다.';
						        msg += '결제 금액 : ' + rsp.paid_amount;
						        msg += '주문번호 : ' + rsp.merchant_uid;
						        msg += '카드 승인번호 : ' + rsp.apply_num;
							
								alert(msg);
								
								location.href= "ordercomplete.do?ordernumber="+ orderNo +"&use_point=" + useP;
							} else {
								//[3] 아직 제대로 결제가 되지 않았습니다.
								//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
							}
						});
					
					} else {
						var msg = '결제에 실패하였습니다.';
						msg += '에러내용 : ' + rsp.error_msg;

						alert(msg);
					}
				});
				
			}
		}
	}
	
$("input[name='delivery']").click(function() {
	// 	alert($(this).val())
	if ($(this).val() == '직접 입력') { // 배송지 선택시 직접입력을 클릭하면 텍스트필드 초기화
		$("#_rname").val('');
		$("#sample4_postcode").val('');
		$("#sample4_roadAddress").val('');
		$("#sample4_detailAddress").val('');
		$("#_rphone").val('');
		$("#sample4_extraAddress").val('');
	} else if ($(this).val() == '주문자 정보와 동일') { // 주문자 정보와 동일을 선택하면 텍스트필드에 주문자 정보 뿌려줌
		$("#_rname").val(name);
		$("#sample4_postcode").val(post_code);
		$("#sample4_roadAddress").val(address);
		$("#sample4_detailAddress").val(address_detail);
		$("#_rphone").val(phone);
		$("#sample4_extraAddress").val(address_refer);
	}
});


</script>
</body>
</html>