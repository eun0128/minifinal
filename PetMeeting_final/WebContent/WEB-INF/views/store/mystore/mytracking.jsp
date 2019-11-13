<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting Store - 배송조회</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/tracking.css">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>

	<div class="tracking-container">
	<div class="sub-title">
		<h3>배송 조회</h3>
	</div>
		<div class="container">
			<div class="control" data-v-72b15ce9="">
				<span class="select"> 
				<select id="company">
						<!---->
						<option value="" selected="" disabled="" style="color: #ccc" data-v-72b15ce9="">택배사</option>
						<option data-v-72b15ce9="" value="kr.cjlogistics">CJ대한통운</option>
						<option data-v-72b15ce9="" value="kr.cupost">CU 편의점택배</option>
						<option data-v-72b15ce9="" value="kr.cvsnet">GS Postbox택배</option>
						<option data-v-72b15ce9="" value="kr.epost">우체국 택배</option>
						<option data-v-72b15ce9="" value="kr.hanjin">한진택배</option>
						<option data-v-72b15ce9="" value="kr.kdexp">경동택배</option>
						<option data-v-72b15ce9="" value="kr.logen">로젠택배</option>
						<option data-v-72b15ce9="" value="kr.lotte">롯데택배</option>
				</select>
				</span>
			</div>
			<br><br>
			<div class="control is-clearfix" data-v-72b15ce9="">
				<input type="text" autocomplete="on" placeholder="운송장번호" value="" class="input">
			</div>
			<div class="control is-click">
			<a href="" class="tracking-btn">조회</a>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
$("select[id='company'").change(function() {
	var select = $("#company option:selected").val();

	$(".tracking-btn").attr("href", "https://tracker.delivery/#/"+ select);
});

$("input:text[class='input']").change(function () {
	var trackNo = $(".input").val();
	var href = $(".tracking-btn").attr("href");

	$(".tracking-btn").attr("href", href + "/" + trackNo);
});

 $(".tracking-btn").click(function() {
	
	var href = $(".tracking-btn").attr("href");

	if($("select[id='company'").html == '택배사'){
		alert("택배사를 선택해주세요.");
	}else if($(".input").val() == ''){
		alert("운송장번호를 입력해주세요");
		$(".tracking-btn").attr("href", "");
	}else if($("select[id='company'").html != '택배사' && $(".input").val() != ''){
		window.open(href, "_blank", "width=820, height=600, left=100, top=50"); 
		window.close();
	}
	
}); 

	


</script>
</body>
</html>