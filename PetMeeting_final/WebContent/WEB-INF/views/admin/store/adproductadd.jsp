<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting - 관리자</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- include libraries(jQuery, bootstrap) -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
	<!-- include summernote css/js -->
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
<style type="text/css">
button {
	border: 0;
	border-radius: 5px;
	padding: px 20px;
	background: #008c9e;
	color: #fff;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
}
th {
	text-align: center;
}
div.alert-wrap{
	display: inline-block;
	font-size: 15px;
}
div.alert-wrap img{
	transform: translate(0, -2px);
	width: 15px;
	height: 15px;
}
button[disabled=disabled] {
	background: #e0e0e0;
	color: #333;
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
				<h4 style="font-size: 1.5em;">상품 등록</h4>			
			</div>
			<form id="product-form" method="post" enctype="multipart/form-data">
				<table class="detailTable">
					<tr>
						<th style="text-align: center;">상품코드</th>
						<td>
							<input type="text" name="productcode" placeholder="상품코드를 입력해주세요" maxlength="10">
							<div class="alert-wrap">
								<img alt="" src="">
								<span class="alert-text"></span>
							</div>
						</td>
					</tr>
					<tr>
						<th style="text-align: center;">상품명</th>
						<td><input type="text" name="productname" placeholder="상품명을 입력해주세요" maxlength="15"></td>
					</tr>
					<tr>
						<th style="text-align: center;">카테고리</th>
						<td>
							<select name="category" style="margin: 0;">
								<option value="">선택</option>
								<option value="의류">의류</option>
								<option value="악세사리">악세사리</option>
								<option value="반려용품">반려용품</option>
								<option value="기타">기타</option>
							</select>
						</td>
					</tr>
					<tr>
						<th style="text-align: center;">상품가격</th>
						<td><input type="text" name="price" placeholder="상품가격을 입력해주세요" onKeyup="NumCheck(this)"></td>
					</tr>
					<tr>
						<th style="text-align: center;">대표이미지</th>
						<td><input type="file" name="fileload"></td>
					</tr>
					<tr>
						<th style="text-align: center;">상품설명</th>
						<td>
							<textarea id="summernote" name="content"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: right;">
							<button type="button" id="add-btn" style="width: 150px; height: 50px; font-size: 18px;" disabled="disabled">상품등록</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function () {
	$('#summernote').summernote({
		height: 500,
		lang: 'ko-KR', // 언어 세팅
		callbacks: {
			onImageUpload: function(files, editor) {
				sendFile(files[0], editor);
			}
		}
	});
	
	function sendFile(file, editor) {
		data = new FormData();
		data.append("file", file);
	//	alert(data);
		$.ajax({
		    data: data,
		    type: "POST",
		    url: "editorimgupload.do",
		    cache: false,
		    contentType: false,
		    processData: false,
		    success: function(filename) {
		    	alert("upload/" + filename);
		        $("#summernote").summernote('editor.insertImage', "upload/" + filename);
		    },
		    error: function () {
				alert("error");
			}
		});
	}
	
	$("input[name=productcode]").blur(function () {
		var productcode = $(this).val();
		
		if(productcode == "") {
			$(".alert-wrap img").attr("src", "${pageContext.request.contextPath}/store_resources/images/alert.png");
			$(".alert-wrap").css("color", "#e46156");
			$(".alert-text").text("상품코드를 입력해주세요");
			$("#add-btn").attr("disabled", "disabled");
		}else {
			$.ajax({
				url: "duplicationCheck.do",
				type: "post",
				data: "productcode=" + productcode,
				dataType: "text",
				success: function (data) {
				//	alert(data.trim());
					var isDuplicated = data.trim();
					if(isDuplicated == "true") {
						$(".alert-wrap img").attr("src", "${pageContext.request.contextPath}/store_resources/images/alert.png");
						$(".alert-wrap").css("color", "#e46156");
						$(".alert-text").text("이미 존재하는 상품코드입니다");
						$("#add-btn").attr("disabled", "disabled");
					}else {
						$(".alert-wrap img").attr("src", "${pageContext.request.contextPath}/store_resources/images/check.png");
						$(".alert-wrap").css("color", "#51baa8");
						$(".alert-text").text("사용 가능한 상품코드입니다");
						$("#add-btn").removeAttr("disabled");
					}
				},
				error: function () {
					alert("error");
				}
			});
		}
	});
	
	$("#add-btn").click(function () {
		var productcode = $("input[name=productcode]").val();
		var productname = $("input[name=productname]").val();
		var category = $("select[name=category]").val();
		var price = $("input[name=price]").val();
		var file = $("input[name=file]").val();
		var content = $("select[name=content]").val();
		
		if(productcode == "") {
			alert("상품코드를 입력해주세요.");
		}else if(productname == "") {
			alert("상품이름을 입력해주세요.");
		}else if(category == "") {
			alert("카테고리를 선택해주세요.");
		}else if(price == "") {
			alert("상품가격을 입력해주세요.");
		}else if(file == "") {
			alert("대표이미지를 등록해주세요.");
		}else if(content == "") {
			alert("상세내용을 입력해주세요.");
		}else {
			$("#product-form").attr("action", "adproductaddAf.do").submit();
		}
	});
});

function NumCheck( textField ) {
	textField.value=textField.value.replace(/[^0-9]/g,'');
}
</script>
</body>
</html>