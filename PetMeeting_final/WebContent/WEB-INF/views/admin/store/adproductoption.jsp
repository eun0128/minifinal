<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting - 관리자</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
.productInfo-tr {
	display:none;
}

label {
	width: 10px;
	height: 25px;
}

input[type=checkbox] { display:none; }

input[type=checkbox] + label{ 
display: inline-block;
line-height: 25px;
cursor: pointer; 
background-position: left;
}
input[type=checkbox].option-50 + label { 
	padding-left: 31px; 
}
input[type=checkbox].option-120 + label {  
	padding-left: 75px; 
}
input[type=checkbox].option-150 + label { 
	padding-left: 94px; 
}

input[type=checkbox]#option-S + label { 
	background: url("./admin_resources/images/btnS.png") no-repeat; 
}

input[type=checkbox]#option-S:checked + label { 
	background: url("./admin_resources/images/btnS-active.png") no-repeat; 
}

input[type=checkbox]#option-M + label { 
	background: url("./admin_resources/images/btnM.png") no-repeat; 
}

input[type=checkbox]#option-M:checked + label { 
	background: url("./admin_resources/images/btnM-active.png") no-repeat; 
}

input[type=checkbox]#option-L + label { 
	background: url("./admin_resources/images/btnL.png") no-repeat; 
}

input[type=checkbox]#option-L:checked + label { 
	background: url("./admin_resources/images/btnL-active.png") no-repeat; 
}
input[type=checkbox]#option-XL + label { 
	background: url("./admin_resources/images/btnXL.png") no-repeat; 
}

input[type=checkbox]#option-XL:checked + label { 
	background: url("./admin_resources/images/btnXL-active.png") no-repeat; 
}
input[type=checkbox]#option-ONE-SIZE + label { 
	background: url("./admin_resources/images/btnOneSize.png") no-repeat; 
}

input[type=checkbox]#option-ONE-SIZE:checked + label { 
	background: url("./admin_resources/images/btnOneSize-active.png") no-repeat; 
}
input[type=checkbox]#option-WHITE + label { 
	background: url("./admin_resources/images/btnWhite.png") no-repeat; 
}

input[type=checkbox]#option-WHITE:checked + label { 
	background: url("./admin_resources/images/btnWhite-active.png") no-repeat; 
}
input[type=checkbox]#option-BLACK + label { 
	background: url("./admin_resources/images/btnBlack.png") no-repeat; 
}

input[type=checkbox]#option-BLACK:checked + label { 
	background: url("./admin_resources/images/btnBlack-active.png") no-repeat; 
}
input[type=checkbox]#option-RED + label { 
	background: url("./admin_resources/images/btnRed.png") no-repeat; 
}

input[type=checkbox]#option-RED:checked + label { 
	background: url("./admin_resources/images/btnRed-active.png") no-repeat; 
}
input[type=checkbox]#option-ORANGE + label { 
	background: url("./admin_resources/images/btnOrange.png") no-repeat; 
}

input[type=checkbox]#option-ORANGE:checked + label { 
	background: url("./admin_resources/images/btnOrange-active.png") no-repeat; 
}
input[type=checkbox]#option-YELLOW + label { 
	background: url("./admin_resources/images/btnYellow.png") no-repeat; 
}

input[type=checkbox]#option-YELLOW:checked + label { 
	background: url("./admin_resources/images/btnYellow-active.png") no-repeat; 
}
input[type=checkbox]#option-GREEN + label { 
	background: url("./admin_resources/images/btnGreen.png") no-repeat; 
}

input[type=checkbox]#option-GREEN:checked + label { 
	background: url("./admin_resources/images/btnGreen-active.png") no-repeat; 
}
input[type=checkbox]#option-BLUE + label { 
	background: url("./admin_resources/images/btnBlue.png") no-repeat; 
}

input[type=checkbox]#option-BLUE:checked + label { 
	background: url("./admin_resources/images/btnBlue-active.png") no-repeat; 
}
input[type=checkbox]#option-PURPLE + label { 
	background: url("./admin_resources/images/btnPurple.png") no-repeat; 
}

input[type=checkbox]#option-PURPLE:checked + label { 
	background: url("./admin_resources/images/btnPurple-active.png") no-repeat; 
}
input[type=checkbox]#option-ONE-COLOR + label { 
	background: url("./admin_resources/images/btnOneColor.png") no-repeat; 
}

input[type=checkbox]#option-ONE-COLOR:checked + label { 
	background: url("./admin_resources/images/btnOneColor-active.png") no-repeat; 
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
				<h4 style="font-size: 1.5em">상품 옵션 등록</h4>			
			</div>
			<form id="option-form" method="post">
				<table class="detailTable">
					<tr>
						<th style="text-align: center;">상품코드</th>
						<td>
							<select name="productcode">
								<option value="">선택</option>
								<c:forEach items="${plist }" var="pro" varStatus="vs">
									<option value="${pro.productcode }">${pro.productcode }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr class="productInfo-tr">
						<th style="text-align: center;">상품정보</th>
						<td></td>
					</tr>
					<tr>
						<th style="text-align: center;">상품사이즈</th>
						<td>
							<input type="checkbox" name="psize" class="option-50" id="option-S" value='S'><label for='option-S'></label>
							<input type="checkbox" name="psize" class="option-50" id="option-M" value='M'><label for='option-M'></label>
							<input type="checkbox" name="psize" class="option-50" id="option-L" value='L'><label for='option-L'></label>
							<input type="checkbox" name="psize" class="option-50" id="option-XL" value='XL'><label for='option-XL'></label>
							<input type="checkbox" name="psize" class="option-150" id="option-ONE-SIZE" value='ONE-SIZE'><label for='option-ONE-SIZE'></label>
						</td>
					</tr>
					<tr>
						<th style="text-align: center;">상품 색상</th>
						<td>
							<input type="checkbox" name="pcolor" class="option-120" id="option-WHITE" value='WHITE'><label for='option-WHITE'></label>
							<input type="checkbox" name="pcolor" class="option-120" id="option-BLACK" value='BLACK'><label for='option-BLACK'></label>
							<input type="checkbox" name="pcolor" class="option-120" id="option-RED" value='RED'><label for='option-RED'></label>
							<input type="checkbox" name="pcolor" class="option-120" id="option-GREEN" value='GREEN'><label for='option-GREEN'></label>
							<input type="checkbox" name="pcolor" class="option-120" id="option-BLUE" value='BLUE'><label for='option-BLUE'></label>
							<input type="checkbox" name="pcolor" class="option-120" id="option-YELLOW" value='YELLOW'><label for='option-YELLOW'></label>
							<input type="checkbox" name="pcolor" class="option-120" id="option-ORANGE" value='ORANGE'><label for='option-ORANGE'></label>
							<input type="checkbox" name="pcolor" class="option-120" id="option-PURPLE" value='PURPLE'><label for='option-PURPLE'></label>
							<input type="checkbox" name="pcolor" class="option-150" id="option-ONE-COLOR" value='ONE-COLOR'><label for='option-ONE-COLOR'></label>
						</td>
					</tr>
					<tr>
						<th style="text-align: center;">상품 수량</th>
						<td><input type="text" name="quantity" placeholder="수량을 입력해주세요" onkeyup="NumCheck(this)"></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: right;">
							<button type="button" id="add-btn">상품옵션 등록</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function () {
	// 상품코드 선택 시 상품정보 보여주기
	$("select[name=productcode]").change(function () {
	//	alert($(this).val());
		var productcode = $(this).val();
		var html = "";
		
		if(productcode != ""){
		
			$.ajax({
				url: "adproductinfo_ajax.do",
				data: "pcode=" + productcode,
				type: "post",
				dataType: "json",
				success: function (data) {
				//	alert(data.psize);
					$(".productInfo-tr td").html("");
					
					html += "<div class='texts'><b>상품명</b> " + data.productname + "</div>";
					html += "<div class='texts'><b>상품옵션 - 사이즈</b> ";
					if(data.psize == "") {
						html += "<font style='color: #b70000'>미등록</font>";
					}else {
						html += data.psize;
					}
					html += "</div>";
					html += "<div class='texts'><b>상품옵션 - 색상</b> ";
					if(data.pcolor == ""){
						html += "<font style='color: #b70000'>미등록</font>";
					}else {
						html += data.pcolor;
					}
					html += "</div>";
					
					$(".productInfo-tr td").html(html);
				},
				error: function () {
					alert("error");
				}
			});
			
			$(".productInfo-tr").css("display", "table-row");
			
		}
	});
	
	
	// 옵션추가
	$("#add-btn").click(function () {
		var productcode = $("select[name=productcode]").val();
		var psize = $("input[name=psize]");
		var pcolor = $("input[name=pcolor]");
		var quantity = $("input[name=quantity]").val();
		
		if(productcode == "") {
			alert("상품코드를 선택하세요.");
		}else if(psize.is(":checked") == false) {
			alert("상품사이즈를 선택하세요.");
		}else if(pcolor.is(":checked") == false) {
			alert("상품색상을 선택하세요.");
		}else if(quantity == "") {
			alert("상품수량을 입력하세요.");
		}else {
			$("#option-form").attr("action", "adproductoptionAf.do").submit();
		}
	});
});

function NumCheck( textField ) {
	textField.value=textField.value.replace(/[^0-9]/g,'');
}
</script>

</body>
</html>