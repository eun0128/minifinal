package com.petmeeting.joy.login.service.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petmeeting.joy.login.dao.MemberDao;
import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.login.model.KakaoParam;
import com.petmeeting.joy.login.model.LoginParam;
import com.petmeeting.joy.login.service.MemberService;
import com.petmeeting.joy.mypage.model.MyPetProfileDto;
import com.petmeeting.joy.mypage.model.MyProfileDto;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao memDao;

	@Override
	public void addMember(MemberDto mem) {
		System.out.println("MemberServiceImpl 파라미터 memdto>> " + mem.toString());		
		memDao.addMember(mem);
		memDao.addSetMyProfile(mem.getEmail());
	}
	
	// 유저 memdto 가져오기
	@Override
	public MemberDto getUser(String email) {
		return memDao.getUser(email);
	}
	
	// 카카오프로필 이미지 있는경우 프로필이미지 주소로 업데이트시킨다
	@Override
	public boolean kakaoProfileImgUpdate(KakaoParam param) {
		return memDao.kakaoProfileImgUpdate(param);
	}

	@Override
	public MemberDto loginCheck(MemberDto mem) {
		return memDao.loginCheck(mem);
	}
	
	@Override
	public boolean leaveMemCheck(String email) {
		return memDao.leaveMemCheck(email);
	}
	@Override
	public MemberDto kakaologinCheck(KakaoParam param) {
		return memDao.kakaologinCheck(param);
	}
	
	@Override
	public boolean loginPointCheck(LoginParam logparam) {		
		return memDao.loginPointCheck(logparam);
		
	}
	
	@Override
	public boolean addLoginPoint(LoginParam param) {
		System.out.println("MemberServiceImpl addLoginPoint--- param" + param.toString());
		
		boolean isS = memDao.setTodayLogin(param);	//PM_CHECK_LOGIN에 기록
		
		if(isS) {
			memDao.upPoint(param);	//로그인 포인트지급
			memDao.upTotalPoint(param);	//total포인트 합산
			
			boolean b = memDao.addPointHistory(param); //포인트히스토리 추가
			if(b) System.out.println("로그인 포인트 지급내역 포인트히스토리 추가 결과 == " + b);
			
			
			System.out.println("MemberServiceImpl addLoginPoint--- 출석 포인트지급 성공");
		}
		else {
			System.out.println("MemberServiceImpl addLoginPoint 출석 포인트 지급 실패");
		}
		
		return isS;
		
	}
	
	// 로그인유저 profile 정보가져오기
	@Override
	public MyProfileDto getLoginUserProfile(String email) {
		System.out.println("MypageServiceImpl getLoginUserProfile 파라미터 : "+email);
		
		MyProfileDto dto = memDao.getLoginUserProfile(email);
		if(dto != null) {
			System.out.println("MypageServiceImpl getLoginUserProfile 리턴할dto : " + dto.toString());
			
		}
		
		return dto;
	}
	
	// 로그인유저 펫프로필 가져오기
	@Override
	public MyPetProfileDto getLoginUserPetProfile(String email) {
		MyPetProfileDto dto = memDao.getLoginUserPetProfile(email);
		
		if(dto != null) {
			System.out.println("MypageServiceImpl getLoginUserPetProfile 리턴할dto : " + dto.toString());
		}
		return dto;
	}
	

	@Override
	public void kakaoLogout(String access_Token) {
	    String reqURL = "https://kapi.kakao.com/v1/user/logout";
	    reqURL = "http://developers.kakao.com/logout";
	    System.out.println("MypageServiceImpl kakaoLogout 카카오로그아웃 access_Token = " + access_Token);
	    
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	       
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String result = "";
	        String line = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        System.out.println(result);
	        
	    } catch (IOException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }
	}
	
	// 이메일중복체크
	@Override
	public MemberDto checkEmail(String email) {
		return memDao.checkEmail(email);
	}
	
	// 닉네임 중복체크
	@Override
	public MemberDto checkNickname(String nickname) {
		return memDao.checkNickname(nickname);
	}
	
	// 비밀번호변경
	@Override
	public boolean passwordUpdate(MemberDto dto) {	
		return memDao.passwordUpdate(dto);
	}
	
}
