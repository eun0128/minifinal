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
				<h4>상품 상세정보</h4>			
			</div>
			<form id="product-form" method="post" enctype="multipart/form-data">
				<input type="hidden" name="productcode" value="${pro.productcode }">
				<table class="detailTable">
					<tbody>
						<tr>
							<th>상품코드</th>
							<td>${pro.productcode }</td>
						</tr>
						<tr>
							<th>상품명</th>
							<td><input type="text" name="productname" value="${pro.productname }" maxlength="15"></td>
						</tr>
						<tr>
							<th>카테고리</th>
							<td>
								<select name="category">
									<option value="의류">의류</option>
									<option value="악세사리">악세사리</option>
									<option value="반려용품">반려용품</option>
									<option value="기타">기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>상품가격</th>
							<td><input type="text" name="price" value=${pro.price } onkeyup="NumCheck(this)"></td>
						</tr>
						<tr>
							<th>대표이미지</th>
							<td><input type="file" name="fileload"></td>
						</tr>
						<tr>
							<th>상품설명</th>
							<td>
								<textarea id="summernote" name="content">${pro.content }</textarea>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: right;">
								<button type="button" id="add-btn" style="width: 150px; height: 50px; font-size: 18px;">상품수정</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function () {
	// 카테고리 세팅
	$("select[name=category]").val("${pro.category }");
	
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
		    //	alert("upload/" + filename);
		        $("#summernote").summernote('editor.insertImage', "upload/" + filename);
		    },
		    error: function () {
				alert("error");
			}
		});
	}
	
	$("#add-btn").click(function () {
		var productname = $("input[name=productname]").val();
		var price = $("input[name=price]").val();
		var content = $("select[name=content]").val();

		if(productname == "") {
			alert("상품명을 입력해주세요.");
		}else if(price == "") {
			alert("상품가격을 입력해주세요.");
		}else if(content == "") {
			alert("내용을 입력해주세요.");
		}else {
			$("#product-form").attr("action", "adproductupdateAf.do").submit();
		}
	});
});

function NumCheck( textField ) {
	textField.value=textField.value.replace(/[^0-9]/g,'');
}
</script>
</body>
</html>