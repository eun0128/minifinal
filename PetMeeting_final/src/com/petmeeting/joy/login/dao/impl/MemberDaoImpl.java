package com.petmeeting.joy.login.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petmeeting.joy.login.dao.MemberDao;
import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.mypage.model.MyPetProfileDto;
import com.petmeeting.joy.mypage.model.MyProfileDto;
import com.petmeeting.joy.login.model.KakaoParam;
import com.petmeeting.joy.login.model.LoginParam;

@Repository
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	SqlSession sqlSession;
	
	String ns = "Member.";

	
	@Override
	public void addMember(MemberDto mem) {
		sqlSession.insert(ns + "addMember", mem);
	}
	
	@Override
	public void addSetMyProfile(String email) {
		sqlSession.insert(ns + "addSetMyProfile", email);
	}

	@Override
	public boolean kakaoProfileImgUpdate(KakaoParam param) {
		int n = sqlSession.update(ns + "kakaoProfileImgUpdate", param);
		return n>0?true:false;
	}
	
	@Override
	public MemberDto loginCheck(MemberDto mem) {
		return sqlSession.selectOne(ns + "loginCheck", mem);
	}
	
	@Override
	public boolean leaveMemCheck(String email) {
		int n = sqlSession.selectOne(ns + "leaveMemCheck", email);
		return n>0?true:false;
	}
	
	@Override
	public MemberDto kakaologinCheck(KakaoParam param) {
		return sqlSession.selectOne(ns + "kakaoLoginCheck", param);
	}
	
	// 로그인시 포인트 지급 관련 -------------
	@Override
	public boolean loginPointCheck(LoginParam param) {
		int count = sqlSession.selectOne(ns + "loginPointCheck", param);
		
		return count>0?true:false;
	}
	
	@Override
	public boolean setTodayLogin(LoginParam param) {
		System.out.println("setTodayLogin param : " + param.toString());
		
		int n = sqlSession.insert(ns + "setTodayLogin", param);
		System.out.println("setTodayLogin return count n : " + n);
		
		return n>0?true:false;
	}
	
	@Override
	public void upPoint(LoginParam param) {
		sqlSession.update(ns + "upPoint", param);
		
	}
	
	@Override
	public void upTotalPoint(LoginParam param) {
		sqlSession.update(ns + "upTotalPoint", param);
	}
	
	@Override
	public boolean addPointHistory(LoginParam param) {
		int n = sqlSession.insert(ns + "addPointHistory", param);
		return n>0?true:false;
	}
	
	// ------------------------------------

	@Override
	public MemberDto getUser(String email) {
		MemberDto user = sqlSession.selectOne(ns + "getUser", email);	
		return user;
	}


	// 로그인유저 profile 정보가져오기
	@Override
	public MyProfileDto getLoginUserProfile(String email) {
		MyProfileDto dto = sqlSession.selectOne(ns + "getLoginUserProfile", email);
		
		return dto;
		
	}
	
	// 로그인유저 펫프로필 가져오기
	@Override
	public MyPetProfileDto getLoginUserPetProfile(String email) {
		MyPetProfileDto dto = sqlSession.selectOne(ns + "getLoginUserPetProfile", email);
		return dto;
	}
	
	// 이메일중복체크
	@Override
	public MemberDto checkEmail(String email) {
		return sqlSession.selectOne(ns + "checkEmail", email);
	}
	// 닉네임 중복체크
	@Override
	public MemberDto checkNickname(String nickname) {
		return sqlSession.selectOne(ns + "checkNickname", nickname);
	}
	
	// 비밀번호 변경
	@Override
	public boolean passwordUpdate(MemberDto dto) {
		int n = sqlSession.update(ns + "passwordUpdate", dto);
		return n>0?true:false;
	}
	
	
	
	
	
	
	
	
	
}
