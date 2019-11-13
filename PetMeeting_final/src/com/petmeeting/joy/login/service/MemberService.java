package com.petmeeting.joy.login.service;

import com.petmeeting.joy.login.model.KakaoParam;
import com.petmeeting.joy.login.model.LoginParam;
import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.mypage.model.MyGradeDto;
import com.petmeeting.joy.mypage.model.MyPetProfileDto;
import com.petmeeting.joy.mypage.model.MyProfileDto;

public interface MemberService {
	
	// 회원가입
	public void addMember(MemberDto mem);
	
	// 카카오 회원 가입시 최초카톡프사를 프로필 이미지로 등록
	public boolean kakaoProfileImgUpdate(KakaoParam param); 	
	
	// 가입유저인지 체크
	public MemberDto loginCheck(MemberDto mem);
	
	// 탈퇴유저인지 체크
	public boolean leaveMemCheck(String email);
	
	// 가입된 유저 데려오기
	public MemberDto getUser(String email);
	
	// 카카오로그인인지 체크
	public MemberDto kakaologinCheck(KakaoParam param);
	
	// 매일 첫 로그인 기록 확인
	public boolean loginPointCheck( LoginParam logparam );
	
	// 매일 첫 로그인기록, 포인트지급, 총포인트합산
	public boolean addLoginPoint(LoginParam param);
	
	// 로그인유저 profile 정보가져오기
	public MyProfileDto getLoginUserProfile(String email);
	
	// 로그인유저 펫프로필 가져오기
	public MyPetProfileDto getLoginUserPetProfile(String email);
	
	// 이메일중복체크
	public MemberDto checkEmail(String email);
	
	// 닉네임 중복체크
	public MemberDto checkNickname(String nickname);
	
	//public boolean snsAddMember(KakaoParam param); // sns 가입
	
	public void kakaoLogout(String access_Token);
	
	// 비밀번호 변경
	public boolean passwordUpdate(MemberDto dto);
	
	
}
