
// submit 함수 -> 스크립트로 동적 제어
function myprosubmitChk() {	
	
	// profile
	if( $('input[name=myage]').val().length < 1) {
		   alert("나이를 입력해주세요");
		   $('input[name=myage]').focus();
		   return false;
	}
	if( $('textarea[name=myintro]').val().length < 1 ){
		 alert("소개글을 입력해주세요");
		 $('textarea[name=myintro]').focus();
		 return false;
	}

	var inrtoval = $('textarea[name=myintro]').val();
	inrtoval = inrtoval.replace(/(?:\r\n|\r|\n)/g, ' ');
	$('textarea[name=myintro]').val(inrtoval);
}

function petprosubmitChk() {	

	//petprofile
	if( $('input[name=petname]').val().length < 1) {
		   alert("펫 이름을 입력해주세요");
		   $('input[name=petname]').focus();
		   return false;
	}
	if( $('input[name=petage]').val().length < 1) {
		   alert("펫 나이를 입력해주세요");
		   $('input[name=petage]').focus();
		   return false;
	}
	if( $('textarea[name=petintro]').val().length < 1 ){
		 alert("펫 소개글을 입력해주세요");
		 $('textarea[name=petintro]').focus();
		 return false;
	}
	if( $("input[name=petname]").val().length < 1 ) {
		alert("펫 이름을 입력하세요.");
		$("input[name=petname]").focus();
		return false;
	}
	
	var inrtoval = $('textarea[name=petintro]').val();
	inrtoval = inrtoval.replace(/(?:\r\n|\r|\n)/g, ' ');
	$('textarea[name=petintro]').val(inrtoval);
	
	
	
}
