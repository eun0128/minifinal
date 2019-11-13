/* <!-- Kakao Login --> */
//사용할 앱의 JavaScript 키를 설정해 주세요.



function loginWithKakao() {
	Kakao.init('2f90f741a7fa19bb40a6b2cc2d08fd28');
	
	// 로그인 창을 띄웁니다.
	Kakao.Auth.login({
	 
		success: function(authObj) {
	  		//alert(JSON.stringify(authObj));
		  
			console.log( JSON.stringify(authObj) );
			console.log( Kakao.Auth.getAccessToken() );
			
			// 로그인 성공시, API를 호출합니다.
			Kakao.API.request({
				url : '/v1/user/me',
				success : function(res) {
					
					console.log(JSON.stringify(res));//<---- kakao.api.request 에서 불러온 결과값 json형태로 출력
					console.log(JSON.stringify(authObj)); //<----Kakao.Auth.createLㄴoginButton에서 불러온 결과값 json형태로 출력
	
					console.log(JSON.stringify(res.kaccount_email));
					console.log(JSON.stringify(res.id));
					console.log(JSON.stringify(res.properties.profile_image));
					console.log(JSON.stringify(res.properties.nickname));
					console.log( authObj.access_token );
					alert( "카카오에서 넘어온 사용자토큰 authObj.access_token = " + authObj.access_token );
					// 카카오에서 받은 유저정보를 accountform 의 value로 설정
					var email = $('input[name=email]', document.accountform);				
					var nickname = $('input[name=nickname]', document.accountform);							
					var myprofile_img = $('input[name=myprofile_img]', document.accountform);
					var accessToken = $('input[name=accessToken]', document.accountform);
					
					
					email.val( res.kaccount_email );
					nickname.val( res.properties.nickname );
					accessToken.val( authObj.access_token );
					
					alert( " 카카오에서 받은 id = " + res.id );
					alert( " hidden input에 넣은 토큰 = " + accessToken.val() );
					
					// 카카오 프로필파일이 없을경우
					if(res.properties.profile_image == null){
						myprofile_img.val("");
					}
					
					// 카카오 프로필파일 있을경우
					else {
						myprofile_img.val(res.properties.profile_image);
					}
					
					
					// ajax로 넘길 데이터 배열변수 생성
					var mydata = {
						email : email.val(),
						nickname : nickname.val(),
						myprofile_img : myprofile_img.val(),
						accessToken  : accessToken.val()
					}
					
	
					$.ajax({
						url : "snsLoginCheck.do",
						method : "post",
						data : mydata,							
						success : function(num) {
							console.log("snsLoginCheck idChk = " + num);
	
							if (num == 0) {
								console.log("회원가입중...");
								alert("카카오계정으로 등록된 회원 정보가 없습니다. 추가적인 가입 절차를 진행합니다.");
								$("#signup").parent().removeClass("slide-up");
								$("#login").parent().parent().addClass("slide-up");
								email.attr("readonly",true);
								
							}					
							else if (num == 1) { //DB에 아이디가 있는 경우 => 로그인 
								console.log("로그인중...");
								var accountString = $("#account-form").serialize() ;
								
								// 로그인 포인트 지급여부
								$.ajax({
									url : "loginPointCheck.do",
									method : "post",
									data : accountString,
									dataType : 'json',
									success : function( pointcheck ) {
										if(pointcheck == true) {
											alert("main으로 이동합니다.");
										}else if(pointcheck == false) {
											alert("오늘의 출석 포인트 지급 완료! main으로 이동합니다.");
										}
										$("#login-form").attr("method","POST").attr("action","main.do").submit();
									},fail : function(error) {
										alert("loginPointCheck error");
									}
								});
							}
							else if( num == 2 ) {
								console.log("탈퇴한회원");
								alert("해당 계정은 탈퇴한 계정입니다.");
							}
							else if (num == 3) {
								console.log("신고 횟수가 10번 이상 접수되어 자동으로 활동정지된 계정입니다.");
								alert("신고 횟수가 10번 이상 접수되어 자동으로 활동정지된 계정입니다.");
							}
							else if (num == 4) {
								console.log("관리자 권한으로 활동정지된 계정입니다.");
								alert("관리자 권한으로 활동정지된 계정입니다.");
							}
							else if( num == 8 ) {
								console.log("관리자계정");
								location.href="adminMain.do";
							}
						}
					})
				},
				fail : function(error) {
					alert("snsLoginCheck err");
					alert(JSON.stringify(error));
				}					
			});//request 끝
		},
		fail: function(err) {
			alert(JSON.stringify(err));
		}
	});
};


