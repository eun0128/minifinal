<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting - 관리자</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
input[type=checkbox] { display:none; }

input[type=checkbox] + label { 
	display: inline-block; 
	cursor: pointer;
	height: 22px;
	line-height: 22px;
	padding-left: 22px; 
	background: url("./store_resources/images/noncheck-mark.png") no-repeat; 
	background-position: left;
}

input[type=checkbox]:checked + label { 
	background: url("./store_resources/images/checked.png") no-repeat; 
	background-position: left;
}

input[type=checkbox].recommend-check + label { 
	display: inline-block; 
	cursor: pointer;
	height: 24px;
	line-height: 24px;
	padding-left: 24px; 
	background: url("./admin_resources/images/unrecommend.png") no-repeat; 
	background-position: left;
}

input[type=checkbox].recommend-check:checked + label { 
	background: url("./admin_resources/images/recommend.png") no-repeat; 
	background-position: left;
}
</style>
</head>
<body>

<div id="right-panel" class="right-panel">
	<!--::header part start::-->
		<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
	<!-- Header part end-->

	<!-- Content -->
	<div class="content">
		<div class="container">
			<div style="margin: 40px 0;">
				<font style="font-size: 1.5rem;">상품 관리</font>
			</div>
			<div class="search-wrap">
				<form id="search-form" method="post">
					<input type="hidden" name="p_pageNumber" value=0>
					<div style="float: left; display: inline-block; ">
						<select style="width: 130px;" class="search-select" name="p_sorting_category">
							<option value="">전체</option>
							<option value="의류">의류</option>
							<option value="악세사리">악세사리</option>
							<option value="반려용품">반려용품</option>
							<option value="기타">기타</option>
						</select>
						<input type="checkbox" name="p_sorting_soldout" id="soldout-check" value="soldout"><label for="soldout-check">품절상품만 보기</label>
					</div>
					<input type="text" name="p_keyword" placeholder="상품명을 검색해보세요" maxlength="15"><input type="button" class="search-btn">
					<input type="text" style="display: none">
				</form>
			</div>
			<div>
			<table class="boardTable">
				<colgroup>
					<col width="50"><col width="100"><col width="120"><col width="200">
					<col width="100"><col width="100"><col width="100"><col width="130">
				</colgroup>
				<thead>
					<tr>
						<th>추천</th>
						<th>상품코드</th>
						<th colspan="2">상품명</th>
						<th>카테고리</th>
						<th>가격</th>
						<th>재고수량</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${plist.size() == 0 }">
					<tr>
						<td colspan="8" style="text-align: center">등록된 상품이 없습니다.</td>
					</tr>
					</c:if>
					<c:forEach items="${plist }" var="pro" varStatus="vs">
					<tr class="product-tr">
						<td style="text-align: center;">
							<input type="checkbox" id="check${vs.count }" class="recommend-check" value="${pro.productcode }"
								recomm=${pro.recommend }><label class="recommend-check" for="check${vs.count }"></label>
						</td>
						<td style="text-align: center;" class="productcode-td">${pro.productcode }</td>
						<td><img alt="이미지없음" src="upload/${pro.filename }" width="100px" height="100px"></td>
						<td>${pro.productname }</td>
						<td style="text-align: center;">${pro.category }</td>
						<td style="text-align: center;"><fmt:formatNumber value="${pro.price }" pattern="#,###"/>원</td>
						<td style="text-align: center;">
							<c:if test="${pro.quantity == 0 }">
								<span style="color: #b70000"><b>품절</b></span>
							</c:if>
							<c:if test="${pro.quantity != 0 }">
								${pro.quantity }개
							</c:if>
						</td>			
						<td style="text-align: center;">
							<fmt:formatDate value="${pro.regdate }" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<form id="productupdate" method="post">
			<input type="hidden" name="productcode" value="">
			<input type="hidden" name="psize" value="">
			<input type="hidden" name="pcolor" value="">
			<input type="hidden" name="pquantity" value="">
			</form>
			</div>
			
			<div class="pagingWrap">
				<jsp:include page="/WEB-INF/views/store/mystore/paging.jsp" flush="false">
					<jsp:param name="" value="type" />
					<jsp:param name="pageNumber" value="${pageNumber }"/>		
					<jsp:param name="totalRecordCount" value="${totalRecordCount }"/>	
					<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }"/>	
					<jsp:param name="recordCountPerPage" value="${recordCountPerPage }"/>	
				</jsp:include>
			</div>
		</div>
	</div>
</div>



<script type="text/javascript">
$(document).ready(function () {
	// 검색 시 파라미터 유지
	var p_sorting_category = "${param.p_sorting_category }";
	var p_sorting_soldout = "${param.p_sorting_soldout}";
	var p_keyword = "${param.p_keyword }";
	
	$("select[name=p_sorting_category]").val(p_sorting_category);
	$("input[name=p_keyword]").val(p_keyword);
	if(p_sorting_soldout == "soldout") {
		$("input[name=p_sorting_soldout]").prop("checked", true);
	}
	
	// 검색 버튼 클릭 시 검색
	$(".search-btn").click(function () {
		$("input[name=p_pageNumber]").val(0);
		
		$("#search-form").attr("action", "adproductlist.do").submit();				
	});
	
	// 정렬 셀렉트박스 변경 시 폼 제출
	$("select[name=p_sorting_category]").change(function () {
		$("input[name=p_pageNumber]").val(0);
		$("#search-form").attr("action", "adproductlist.do").submit();
	});
	
	// 체크박스 선택 시 폼 제출
	$("input[name=p_sorting_soldout]").change(function () {
		$("input[name=p_pageNumber]").val(0);
		$("#search-form").attr("action", "adproductlist.do").submit();
	});
	
	// 제품을 클릭하면 상세 옵션별 재고수량 수정폼이 나온다.
	$(".product-tr").click(function (e) {
	//	alert($(e.target).hasClass("recommend-check"));
		if(!$(e.target).hasClass("recommend-check")) {
			var product_tr = $(this); 
			var productcode = $(this).children(".productcode-td").text();
		//	alert(productcode);
	
			$.ajax({
				url : "adproductoptionlist.do",
				type: "post",
				data : "productcode=" + productcode,
				dataType: "json",
				success: function (data) {
				//	alert(data.count);
					showProductOption(data.polist, product_tr, productcode);			
				},
				error: function () {
					alert("error");
				}
			});
		}
	});
	
	function showProductOption( list, tr, pcode ) {
		$(".poption-tr").remove();
		
		var length = list.length;
		var html = "<tr class='poption-tr'><td colspan='8' style='text-align: center;'>";
		html += "<table id='poption-table'>";
		html += "<col width='120px'><col width='120px'><col width='80px'>"
		html += "<tr><th>사이즈</th><th>색상</th><th>재고수량</th></tr>";
		for (var i = 0; i < length; i++) {
			var poption = list[i]
			html += "<tr>";
			html += "<td>" + poption.psize + "</td>";
			html += "<td>" + poption.pcolor + "</td>";
			html += "<td><form id='update-form" + i + "' method='post'>";
			html += "<input type='text' name='pquantity' value=" + poption.pquantity + " onkeyup='NumCheck(this)'>";
			html += "<input type='hidden' name='seq' value=" + poption.seq + ">";
			html += "</form></td>";
			html += "</tr>";
		}
		html += "</table>";
		html += "<button type='button' id='detail-btn' pcode='" + pcode + "' onclick='goDetail(this)'>상품정보</button> <button type='button' id='update-btn'>재고수정</button>";
		html += "</td></tr>";
		
		tr.after(html);
	}
	
	//재고수정 버튼 클릭 시
	$(document).on("click", "#update-btn", function () {
	//	alert("수정버튼 클릭");
		var poptions = $("#poption-table");
		var count = poptions.children().children().length - 1;
		
	//	alert(count);
	
		for (var i = 0; i < count; i++) {
			var form = $("#update-form" + i);
			var formData = form.serialize();
			
			$.ajax({
				url : "quantityupdate.do",
				data: formData,
				type: "post",
				success: function () {
				//	alert("successs");
				},
				error: function () {
					alert("error");
				}
			});
		}
		
		alert("재고량 수정이 완료되었습니다");
		$("#search-form").attr("action", "adproductlist.do").submit();
	});

	// 추천 체크박스 클릭 시 ajax
	$("input.recommend-check").click(function () {
	//	alert($(this).val());
		var checkbox = $(this);
		var productcode = $(this).val();
		var isRecommended = $(this).prop("checked");
		var recommend = 0;
		
		if(isRecommended) {
			recommend = 1;
		}
		
	//	alert(recommend);
		
		$.ajax({
			url: "productrecommend.do",
			type: "post",
			data: "productcode=" + productcode + "&recommend=" + recommend,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			success: function (data) {
				alert(data.msg);
				if(data.update == false) {
					checkbox.prop("checked", false);
				}
			},
			error: function () {
				alert("error");
			}
		});
	});
	
	// 추천된 상품은 체크되있도록
	$("input:checkbox[class='recommend-check']").each(function () {
		var recomm = $(this).attr("recomm");

		if(recomm == 1) {
			$(this).prop("checked", true);
		}
	});
	
	
});

function goPage(type, pageNumber) {
	$("input[name=p_pageNumber]").val(pageNumber);
	$("#search-form").attr("action", "adproductlist.do").submit();	
}

function goDetail(btn) {
//	alert(btn.getAttribute("pcode"));
	var pcode = btn.getAttribute("pcode");
	
	location.href = "adproductdetail.do?pcode=" + pcode;
}

function NumCheck( textField ) {
	textField.value=textField.value.replace(/[^0-9]/g,'');
}
</script>
</body>
</html>