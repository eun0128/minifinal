package com.petmeeting.joy.login.dao;

import com.petmeeting.joy.login.model.KakaoParam;
import com.petmeeting.joy.login.model.LoginParam;
import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.mypage.model.MyPetProfileDto;
import com.petmeeting.joy.mypage.model.MyProfileDto;

public interface MemberDao {
	
	public void addMember(MemberDto mem);	
	
	public void addSetMyProfile(String email);
	
	public boolean kakaoProfileImgUpdate(KakaoParam param);
	
	public MemberDto loginCheck(MemberDto mem);
	
	// 탈퇴유저인지 체크
	public boolean leaveMemCheck(String email);
	
	public MemberDto kakaologinCheck(KakaoParam param);	//카카오로그인 정보확인
	
	public boolean loginPointCheck( LoginParam loginPointCheck );
	
	public boolean setTodayLogin(LoginParam param);
	
	public void upPoint(LoginParam param);
	
	public void upTotalPoint(LoginParam param);
	
	public boolean addPointHistory(LoginParam param);
	
	public MemberDto getUser(String email);
	
	// 로그인유저 profile 정보가져오기
	public MyProfileDto getLoginUserProfile(String email);
	
	// 로그인유저 펫프로필 가져오기
	public MyPetProfileDto getLoginUserPetProfile(String email);
	
	// 이메일 중복체크
	public MemberDto checkEmail(String email);
	// 닉네임 중복체크	
	public MemberDto checkNickname(String nickname);
	//public boolean snsAddMember(KakaoParam param); // sns 가입
	
	// 비밀번호 변경
	public boolean passwordUpdate(MemberDto dto);
	
	
}
