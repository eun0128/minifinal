package com.petmeeting.joy.login.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.petmeeting.joy.login.model.KakaoParam;
import com.petmeeting.joy.login.model.LoginParam;
import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.login.service.MemberService;
import com.petmeeting.joy.mypage.model.MyPetProfileDto;
import com.petmeeting.joy.mypage.model.MyProfileDto;
import com.petmeeting.joy.mypage.model.MyProfileParam;
import com.petmeeting.joy.mypage.model.MypageMsgDto;
import com.petmeeting.joy.mypage.model.MypageMsgParam;
import com.petmeeting.joy.mypage.service.mypageService;

@Controller
public class loginController {

	@Autowired
	MemberService memService;


	@RequestMapping (value="goMain.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String goMain() {
		return "redirect:/main.do";
	}
	
	@RequestMapping (value="login.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String login() {
		
		return "login/login";
	}
	
	@RequestMapping (value="logout.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String logout(HttpServletRequest req) {
		
		req.getSession().removeAttribute("login");
		req.getSession().removeAttribute("userProfile");
		req.getSession().removeAttribute("mypet");
		System.out.println("login, userProfile 세션 제거 --> 로그아웃완료");
		

		memService.kakaoLogout( (String)req.getSession().getAttribute("access_Token") );
		
		/*
		req.getSession().removeAttribute("access_Token");
		req.getSession().removeAttribute("Kakaouserid");
		System.out.println("access_Token, userId 세션 제거 --> 카카오 로그아웃완료");
	    */
		return "main";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "checkEmail.do", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/text; charset=utf8")
	public String checkEmail( String email ){
		System.out.println("checkEmail.do --------------------------------");
		System.out.println("입력한 email = " + email);
		
		MemberDto memdto = memService.checkEmail(email);
		
		if(memdto == null) {
			System.out.println("저장되지않은 email, 사용가능");			
			return "ok";
		}else {
			System.out.println("계정존재. 입력한 email 사용불가");
			return "notok";
		}
		
	}
	
	// 닉네임체크
	@ResponseBody
	@RequestMapping(value = "checkNickname.do", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/text; charset=utf8")
	public String checkNickname( String nickname ) {
		System.out.println("checkNickname.do --------------------------------");
		System.out.println("입력한 nickname = " + nickname);
		
		MemberDto memdto = memService.checkNickname(nickname);
		
		if(memdto == null) {
			System.out.println("저장되지않은 nickname, 사용가능");			
			return "ok";
		}else {
			System.out.println("계정존재. 입력한 nickname 사용불가");
			return "notok";
		}
	}
	
	
	@RequestMapping (value="account.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String account(KakaoParam param, Model model) {
		
		model.addAttribute("kakaoparam", param);
		
		return "login/account";
	}	
	
	@ResponseBody
	@RequestMapping (value="accountAf.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String accountAf(MemberDto mem, String myprofile_img, HttpServletRequest req, Model model) {
		String str = "";
		System.out.println("accountAf.do 유저입력한 회원가입정보>>> " + mem.toString());		
		System.out.println("accountAf.do myprofile_img>>> " + myprofile_img);
		
		// 회원가입실행(member추가, myProfile기본정보추가)
		memService.addMember(mem);
		
		// 일반회원가입 경우 프로필 사진 없으면 'Account' 리턴
		if(myprofile_img == "" || myprofile_img == null) {
			System.out.println("accountAf.do ---- 일반회원 가입완료");			
			str = "Account";
		}
		// 카카오 회원가입 프로필 사진이 있을 경우 'kakaoAccount' 리턴
		else {
			KakaoParam param = new KakaoParam( mem.getEmail(), myprofile_img);
			
			// 초기 프로필 얻어와 프로필 이미지 저장한다
			boolean isS = memService.kakaoProfileImgUpdate(param);			
			
			if(!isS) {
				System.out.println("accountAf.do ---- 카카오 회원가입 프로필이미지 등록실패");	
			}
			else {
			System.out.println("accountAf.do ---- 카카오 프로필 이미지 등록완료 ");
			System.out.println("accountAf.do ---- 카카오회원 가입완료");
			
			str = "kakaoAccount";
			}
		}
		return str;
	}
	
	@ResponseBody
	@RequestMapping(value = "snsLoginCheck.do", method= {RequestMethod.GET, RequestMethod.POST})
	public int snsLoginCheck( KakaoParam param, Model model, HttpServletRequest req) {
		System.out.println("snsLoginCheck.do ------------------- 넘어온 param : " + param.toString() );
		
		MemberDto user = memService.kakaologinCheck(param);
		
		int num;
		boolean leaveCheck = memService.leaveMemCheck(param.getEmail());		
		
		if(user == null) {
			num = 0; // "가입되지 않은 계정";
		}
		else {
			num = 1; // "가입되어 있는 계정";
			req.getSession().setAttribute("access_Token",param.getAccessToken());
		}
		
		if(leaveCheck) {
			num = 2; // ""탈퇴한 계정";
		}
		if( user != null && user.getReportcount() >= 10 ) {
			num = 3; // "신고로 자동 활동정지된 계정";
		}
		if( user != null && user.getAuth() == 4 ) {
			num = 4; // "관리자에 의한 활동이 정지된 계정";
		}
		if( user != null && user.getAuth() == 8 ) {
			num = 8; // "관리자 계정";
		}
		
		return num;	
	}

	@ResponseBody
	@RequestMapping (value="loginAf.do", method= {RequestMethod.GET, RequestMethod.POST})
	public int loginAf(MemberDto mem, HttpServletRequest req, Model model) {
		int num;
		MemberDto user = memService.loginCheck(mem);
		boolean leaveCheck = memService.leaveMemCheck(mem.getEmail());		
		
		
		if(user == null) {
			num = 0; // "가입되지 않은 계정";
		}
		else{
			num = 1; // "가입되어 있는 계정";
		}
		
		if(leaveCheck) {
			num = 2; // ""탈퇴한 계정";
		}
		if( user != null && user.getReportcount() >= 10 ) {
			num = 3; // "신고로 자동 활동정지된 계정";
		}
		if( user != null && user.getAuth() == 4 ) {
			num = 4; // "관리자에 의한 활동이 정지된 계정";
		}
		if( user != null && user.getAuth() == 8 ) {
			num = 8; // "관리자 계정";
			// 로그인시 유저정보 가져오기
						MemberDto loginuser = memService.getUser(user.getEmail());
						// 세션생성		
						req.getSession().setAttribute("login", loginuser);		
						System.out.println("loginAf.do>>> 관리자ver 로그인 세션생성");
		}		
		
		return num;
	}	
	
	@ResponseBody
	@RequestMapping (value="loginPointCheck.do", method= {RequestMethod.GET, RequestMethod.POST})
	public boolean loginPointCheck(MemberDto user, HttpServletRequest req, Model model) {
		
		// 로그인 당일 날짜 얻어오기(첫로그인 확인용)
		SimpleDateFormat dateformat = new SimpleDateFormat ( "yyyy-MM-dd");
		Date time = new Date();
		String todate = dateformat.format(time);
		System.out.println("loginPointCheck todate : " + todate);		
		
		// 당일 첫로그인 포인트지급 여부 확인
		LoginParam param = new LoginParam( user.getEmail(), todate);
		boolean pointcheck = memService.loginPointCheck( param );
		
		// 당일 첫로그인 이력 존재 -> 로그인 포인트 지급 X
		if( pointcheck ) {	
			System.out.println("오늘의 첫 로그인이 아닙니다");
		}
		// 당일 첫로그인 이력 없음 -> 로그인 포인트 지급실행
		else if( !pointcheck ) {		
			System.out.println("오늘 첫로그인 입니다");
			
			// 매일 첫로그인 여부 DB저장, 포인트지급 (일 2번째 로그인부터는 포인트 지급X, 300p 지급)
			param = new LoginParam(user.getEmail(), "", 300);
			boolean b = memService.addLoginPoint(param);
			
			if( b ) System.out.println("출석 포인트 지급완료");
			else System.out.println("출석 포인트 지급 실패..");	
		}
		
		// 로그인시 유저정보 가져오기
		MemberDto loginuser = memService.getUser(user.getEmail());
		
		// 로그인 유저의 프로필 가져오기
		MyProfileDto profiledto = memService.getLoginUserProfile( user.getEmail() );
		
		// 로그인 유저의 펫프로필 가져오기
		MyPetProfileDto mypet = memService.getLoginUserPetProfile(user.getEmail());
		
		// 확인용 
		if(profiledto != null) {
			System.out.println("mypagehome.do>>> 로그인유저의 프로필정보 찾음 : " + profiledto.toString() );
		}
		else System.out.println("mypagehome.do>>> 로그인유저의 프로필정보 없음");	
		
		if(mypet != null) {
			System.out.println("mypagehome.do>>> 로그인유저의 펫프로필 찾음 : " + mypet.toString() );
		}
		else System.out.println("mypagehome.do>>> 로그인유저의 펫프로필 없음");	
		
		// 세션생성		
		req.getSession().setAttribute("login", loginuser);		
		System.out.println("mypagehome.do>>> 로그인 세션생성");
		
		req.getSession().setAttribute("userProfile", profiledto);
		System.out.println("mypagehome.do>>> userProfile 세션생성");
		
		req.getSession().setAttribute("mypet", mypet);		
		System.out.println("mypagehome.do>>> mypet 세션생성");
		return pointcheck;
		
	}
	
	// 회원가입 이메일 인증
    @ResponseBody
    @RequestMapping (value="emailAuth.do", method= {RequestMethod.GET, RequestMethod.POST})
	public boolean emailAuth(String inputEmail, HttpServletRequest req) {
    	System.out.println("emailAuth.do ---------------------");
    	
    	boolean isS;
    	
    	if(inputEmail == null) {
    		System.out.println("유저가 입력한 이메일 null");
    		isS = false;
    		return isS;
    	}
    	else {
    		System.out.println("유저가 입력한 이메일 = " + inputEmail);
    	
    	
	    	int rannum = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
	        String authCode = String.valueOf(rannum);
	        System.out.println("발급된 인증키 = " + authCode);
	       
	        req.getSession().setAttribute("authCode", authCode);
	        
	        String subject = "[Petmeeting] 인증 코드 발급 안내 입니다.";	// 메일 제목   
	        String text = "인증 번호 : " + authCode;	// 메일 내용   
	       	
	        boolean sendCheck = com.petmeeting.joy.util.SendEmail.sendMail(subject, text.toString(), inputEmail);
	        
	        if(sendCheck) {
	        	System.out.println("메일발신 성공");
	        	isS = true;
	        }else {
	        	System.out.println("메일발신 실패");
	        	isS = false;
	    	}
	        return isS;
    	}
    	
    }
    
    //이메일인증코드 비교
    @ResponseBody
    @RequestMapping (value="emailAuthCodeCheck.do", method= {RequestMethod.GET, RequestMethod.POST})
    public boolean emailAuthCodeCheck(String authCodeUSer, HttpServletRequest req) {
    	System.out.println("emailAuth.do ---------------------");
    	System.out.println("authCodeUSer = " + authCodeUSer);
    	
        String authCode = (String)req.getSession().getAttribute("authCode");
        System.out.println("authCode = " + authCode);
        
        
        if(!authCode.equals(authCodeUSer)) {
            System.out.println("인증번호 일치하지 않습니다.");
            
            req.setAttribute("msg", "인증번호가 일치하지 않습니다");
            return false;
        }else {
        	 System.out.println("인증번호 일치");
        	return true;
        }       
    }
    
    //이메일인증코드 비교
    @ResponseBody
    @RequestMapping (value="passwordUpdate.do", method= {RequestMethod.GET, RequestMethod.POST})
    public String passwordUpdate(String email, String password, HttpServletRequest req) {
    	System.out.println("passwordUpdate.do ---------------------");
    	System.out.println("email = " + email + ", password = "+ password);

    	MemberDto memdto = memService.getUser(email);
    	System.out.println("memdto = "+memdto);
    	
    	MemberDto dto = new MemberDto(memdto.getEmail(), password);
    	System.out.println("유저, 바꿀 비번 = "+dto.getEmail()+", " + dto.getPwd());
    	
    	boolean is = memService.passwordUpdate(dto);
    	
    	if(!is){
    		System.out.println("비밀번호 변경실패");
    	}else {
    		System.out.println("비밀번호 변경완료");    		
    	} 
    	return "";
        
    }
 
    
	//TODO
	@RequestMapping (value="emailfind.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String emailfind() {
		System.out.println("emailfind.do ----------------------");
		
		return "login/loginInfoFind";
	}
	
}
		