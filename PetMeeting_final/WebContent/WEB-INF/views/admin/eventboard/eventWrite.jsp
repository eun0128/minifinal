<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pet Meeting - 관리자</title>
 <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>	
	<!-- datepicker -->
	<script src="${pageContext.request.contextPath}/playboard_resources/datepicker/datepicker.js"></script>
	<link  href="${pageContext.request.contextPath}/playboard_resources/datepicker/datepicker.css?after" rel="stylesheet">	
	<!-- 도로명 주소 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	
	<!-- CKEditor -->
	<script src="${pageContext.request.contextPath}/playboard_resources/ckeditor/ckeditor.js"></script>	
	
	<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/eventboard.css">
</head>
<body>

<div id="right-panel" class="right-panel">
<!--::header part start::-->
	<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
<!-- Header part end-->

<!-- Content -->
<div class="content">
	<div class="container">
		<div class="mainTitle">반려동물 행사 등록</div>
		
		<form id="writeFrm" method="post" enctype="multipart/form-data">
		<table class="WriteTable">

			<tr>
				<th>행사 제목</th>
				<td><input type="text" name="title"  style="width: 80%;"></td>
			</tr>
			
			<tr>
				<th>행사 썸네일</th>
				<td><input type="file" name="fileload" accept="image/gif, image/jpeg, image/jpg, image/png" style="width: 50%;"></td>
			</tr>
			
			<tr>
				<th>행사 기간</th>
				<td>
					<label>
	    			<input type="text" autocomplete="off" id="_startDate" readonly="readonly" placeholder="행사 시작일" >
	    			<input type="hidden" name="pyear">
	    			<input type="hidden" name="pmonth">
	    			<input type="hidden" name="pday">
	    			<img src="${pageContext.request.contextPath}/playboard_resources/img/schedule.png" width="20px" height="20px;" style="opacity: 0.4">
	    			</label>	
	    			&emsp;~&emsp; 	
	    			<label>
	    			<input type="text" autocomplete="off" id="_endDate" readonly="readonly" placeholder="행사 종료일" >	   
	    			<input type="hidden" name="eyear">
	    			<input type="hidden" name="emonth">
	    			<input type="hidden" name="eday"> 			
	    			<img src="${pageContext.request.contextPath}/playboard_resources/img/schedule.png" width="20px" height="20px;" style="opacity: 0.4">
	    			</label>
				
				</td>
			</tr>
			
			<tr>
				<th>행사 장소</th>
				<td>
					<input type="text" name="location" id="sample6_address" placeholder="주소" style="width: 60%;"> <button type="button" id="findAddr" onclick="sample6_execDaumPostcode()">우편번호 찾기</button><br>
					<input type="text" name="location_detail" id="sample6_detailAddress" placeholder="상세주소">
				</td>
			</tr>
			
			<tr>
				<th colspan="2">행사 상세정보</th>
			</tr>
			
			<tr>
				<td colspan="2">
				<textarea name="content" id="editor" rows="10" cols="100" style="width:95%; height:600px; display:none;"></textarea>
				</td>
			</tr>

		</table>
		</form>
		
		<div class="buttons">
			<button type="button" id="submitBtn">행사 등록</button>
		</div>
	</div>
</div>

</div>


<script type="text/javascript">
$(function () {
	var today = new Date();
	var tomorrow = new Date();
	tomorrow.setDate(tomorrow.getDate()+1);
	var mindate;
	var week =["일", "월", "화", "수", "목", "금", "토"];
	var month = ["1월","2월","3월","4월","5월","6월", "7월","8월","9월","10월","11월","12월"];

	/* 모임 예정일 */
	$("#_startDate").datepicker({	
		format: 'yyyy-mm-dd',
		/* startDate: tomorrow, */
		language: "ko",
		todayHighlight: true,
		daysMin: week,
		months: month,
		autoHide: true,
		yearFirst: true,
		yearSuffix: '년',
		zIndex: 5000
	});
	$('#_startDate').on('pick.datepicker', function (e) {
		/* alert($('#_playDate').datepicker('getDate')); */
		var pdate = $('#_startDate').datepicker('getDate');
		//alert("pdate : " + pdate);
		var startDate = new Date(pdate);
		startDate.setDate(pdate.getDate());
		//alert("endDate : " + endDate);
		$("#_endDate").datepicker('setStartDate', startDate);
		
		$("input[name='pyear']").val(pdate.getFullYear());
		$("input[name='pmonth']").val(pdate.getMonth()+1);
		$("input[name='pday']").val(pdate.getDate());	
		
	});

	/* 모집 마감일 */
	$("#_endDate").datepicker({
		format: 'yyyy-mm-dd',
		language: "ko",
		todayHighlight: true,
		daysMin: week,
		months: month,
		autoHide: true,
		yearFirst: true,
		yearSuffix: '년'
	});
	$('#_endDate').on('pick.datepicker', function (e) {
		var edate = $('#_endDate').datepicker('getDate');
		
		$("input[name='eyear']").val(edate.getFullYear());
		$("input[name='emonth']").val(edate.getMonth()+1);
		$("input[name='eday']").val(edate.getDate());
	});
	
	
	$("#submitBtn").click(function () {
		if($.trim($("input[name='title']").val()) == ""){
			alert("제목을 입력해주세요!");
			$("input[name='title']").focus();
			return false;
		}
		if($.trim($("#_startDate").val()) == ""){
			alert("행사 시작일을 선택해주세요!");
			return false;
		}
		if($.trim($("#_endDate").val()) == ""){
			alert("행사 종료일을 선택해주세요!");
			return false;
		}
		if($.trim($("input[name='location']").val()) == ""){
			alert("모임 장소를 입력해주세요!");
			return false;
		}
		var data = CKEDITOR.instances.editor.getData();
		if($.trim(data) == ""){
			alert("행사에 대한 설명을 입력해주세요!");
			return false;
		}
		
		
		$("#writeFrm").attr("action", "adminEventWriteAf.do").submit();
	});
});


/* CKEDITOR */
CKEDITOR.editorConfig = function( config ) {
	config.removePlugins = 'easyimage, cloudservices';
	config.fillEmptyBlocks = false;
	config.fullPage = false;
	config.enterMode = CKEDITOR.ENTER_BR;
	config.filebrowserUploadMethod = 'form';
	config.language = 'ko';
};

CKEDITOR.replace('editor', {
	  	 filebrowserUploadUrl: '${path }adminEventfileupload.do',
	  	 width: '100%',
	     height: 500
});


/* 도로명주소 API */
function sample6_execDaumPostcode() {
  new daum.Postcode({
      oncomplete: function(data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

          // 각 주소의 노출 규칙에 따라 주소를 조합한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var addr = ''; // 주소 변수
          var extraAddr = ''; // 참고항목 변수

          //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
              addr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
              addr = data.jibunAddress;
          }

          document.getElementById("sample6_address").value = addr;
          // 커서를 상세주소 필드로 이동한다.
          document.getElementById("sample6_detailAddress").focus();
      }
  }).open();
}
</script>
</body>
</html>