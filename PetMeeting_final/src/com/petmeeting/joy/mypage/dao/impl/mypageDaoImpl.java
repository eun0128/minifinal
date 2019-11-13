package com.petmeeting.joy.mypage.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.funding.model.FundingDto;
import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.mypage.dao.mypageDao;
import com.petmeeting.joy.mypage.model.MyGradeDto;
import com.petmeeting.joy.mypage.model.MyPetProfileDto;
import com.petmeeting.joy.mypage.model.MyProfileDto;
import com.petmeeting.joy.mypage.model.MyProfileParam;
import com.petmeeting.joy.mypage.model.MypageFollowDto;
import com.petmeeting.joy.mypage.model.MypageFollowListParam;
import com.petmeeting.joy.mypage.model.MypageFollowparam;
import com.petmeeting.joy.mypage.model.MypageListParam;
import com.petmeeting.joy.mypage.model.MypageMemberleave;
import com.petmeeting.joy.mypage.model.MypageMsgDto;
import com.petmeeting.joy.mypage.model.MypageMsgParam;
import com.petmeeting.joy.mypage.model.MypagePointListParam;
import com.petmeeting.joy.mypage.model.Mypagememandpet;
import com.petmeeting.joy.mypage.model.PointHistoryDto;
import com.petmeeting.joy.mypage.model.MypagemylikeDto;
import com.petmeeting.joy.mypage.model.MypagemylikefreeboardDto;
import com.petmeeting.joy.playboard.model.PlayboardDto;

@Repository
public class mypageDaoImpl implements mypageDao {

	@Autowired
	SqlSession sqlSession;

	String ns = "Mypage.";

	@Override
	public List<MypageFollowDto> myFollolistemail(MemberDto member) {
		
		return sqlSession.selectList(ns+"myFollolistemail", member);
	}

	@Override
	public void mypagecertification(MemberDto member) {
      
		sqlSession.update(ns+"mypagecertification",member);
	}

	@Override
	public MypageFollowDto myFollolistnickname(MypageFollowDto emaildto) {
		return sqlSession.selectOne(ns+"myFollolistnickname", emaildto);
	}

	@Override
	public MypageFollowDto mypageFolloingcount(String email) {
		
		return sqlSession.selectOne(ns+"myFolloingcount", email);
	}

	@Override
	public MypageFollowDto mypageFollowercount(String email) {
		
		return sqlSession.selectOne(ns+"myFollowercount", email);
	}

	@Override
	public MypageFollowDto mypageprofileimg(String email) {	
		return sqlSession.selectOne(ns+"mypageprofileImg", email);
	}

	@Override
	public MypageFollowDto mypageprofileintro(String email) {
		return sqlSession.selectOne(ns+"mypageprofileintro", email);
	}

	@Override
	public void mypagefollowdel(MypageFollowDto emaildto) {
		sqlSession.delete(ns+"mypagefollowdel", emaildto);
	}

	@Override
	public List<MypageFollowDto> mypagefollowmorelist(MypageFollowparam param) {
		return sqlSession.selectList(ns+"mypagefollowmorelist", param);
	}

	@Override
	public void mypageInfoUpdateaf(MemberDto member) {
		sqlSession.update(ns+"mypageInfoUpdateaf", member);
		
	}

	@Override
	public void mypagepasswordUpdateaf(MemberDto member) {
	   sqlSession.update(ns+"mypagepasswordUpdateaf", member);		
	}

	@Override
	public void mypageMemberleave(MypageMemberleave mem) {
		sqlSession.insert(ns+"mypageMemberleave", mem);
		
	}

	@Override
	public List<PlayboardDto> mypageattendplay(MemberDto member) {
		
		return sqlSession.selectList(ns+"mypageattendplay",member);
	}
	
	//나의 구독하는 사람의 팔로우 팔로잉을 볼 때
	public List<MypageFollowDto> mypagefollowfollwinglist(MypageFollowDto follow){
		return sqlSession.selectList(ns+"mypagefollowfollwinglist", follow);
	}
	
	//나의 구독하는 사람과 멤버와 펫의 프로필 보여주기 위함
	@Override
	public Mypagememandpet mypageprofilememandpet(String email) {
	
		return sqlSession.selectOne(ns+"mypageprofilememandpet", email);
	}
	
	
	  @Override
	  public int mypagemsgpush(String email) {
			return sqlSession.selectOne(ns+"mypagemsgpush",email );
		}
		
    
	  

	@Override
	public String mypagemsgpushnewperson(String email) {
		return sqlSession.selectOne(ns+"mypagemsgpushnewperson", email);
	}
	
	
	@Override
	public List<FundingDto> mypagefundinglike(MypagemylikeDto param) {
		return sqlSession.selectList(ns+"mypagefundinglike",param);
	}
	
	@Override
	public List<PlayboardDto> mypageplayboardlike(MypagemylikeDto param) {
		return sqlSession.selectList(ns+"mypageplayboardlike", param);
	}
	
	
	
	@Override
	public List<FreeboardDto> mypagefreeboardlike(MypagemylikefreeboardDto param) {	
		return sqlSession.selectList(ns+"mypagefreeboardlike", param);
	}


	///////////////////////////////////////////유정

    

	


	
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
	
	// 로그인유저 등급 가져오기
	@Override
	public MyGradeDto getUserGrade(MemberDto user) {
		MyGradeDto dto = sqlSession.selectOne(ns + "getUserGrade", user);
		return dto;
	}
	
	//PM_CHECK_MYPROFILE테이블에 email 존재여부 확인 
	@Override
	public boolean check_myprofile(MemberDto user) {
		int n = sqlSession.selectOne(ns + "check_myprofile", user);
		return n>0?true:false;
	}
	
	// PM_CHECK_MYPROFILE에 유저등록 
	@Override
	public boolean addMyProfileCheck(String email) {
		int n = sqlSession.insert(ns + "addMyProfileCheck", email);
		return n>0?true:false;
	}
	// 프로필 수정
	@Override
	public boolean updateProfile(MyProfileParam dto) {
		int n = sqlSession.update(ns + "updateProfile", dto);
		return n>0?true:false;
	}
	// 닉네임 수정
	@Override
	public boolean updateNickname(MyProfileParam dto) {
		int n = sqlSession.update(ns + "updateNickname", dto);
		return n>0?true:false;
	}
	// 프로필 등록 포인트지급
	@Override
	public boolean addProfilePoint(String email) {
		int n = sqlSession.insert(ns + "addProfilePoint", email);
		return n>0?true:false;
	}
	
	@Override
	public boolean addprofilePointHistory(String email) {
		int n = sqlSession.insert(ns + "addprofilePointHistory", email);
		return n>0?true:false;
	}
	
	// 펫프로필 등록 여부확인
	@Override
	public boolean check_petprofile(String email) {
		int n = sqlSession.selectOne(ns + "check_petprofile", email);
		return n>0?true:false;
	}
	
	// 펫프로필 등록
	@Override
	public boolean insertPetProfile(MyPetProfileDto petdto) {
		int n = sqlSession.insert(ns + "insertPetProfile", petdto);
		return n>0?true:false;
	}
	
	// 펫프로필체크 테이블에 유저등록
	@Override
	public boolean addPetProfileCheck(String email) {
		int n = sqlSession.insert(ns + "addPetProfileCheck", email);
		return n>0?true:false;
	}
	
	// 펫프로필 등록 포인트 지급
	@Override
	public boolean addPetProfilePoint(String email) {
		int n = sqlSession.insert(ns + "addPetProfilePoint", email);
		return n>0?true:false;
	}
	
	@Override
	public boolean addpetPointHistory(String email) {
		int n = sqlSession.insert(ns + "addpetPointHistory", email);
		return n>0?true:false;
	}
	// 펫프로필 수정
	@Override
	public boolean updatePetProfile(MyPetProfileDto petdto) {
		int n = sqlSession.update(ns + "updatePetProfile", petdto);
		return n>0?true:false;
	}
	
	// 로그인유저 펫프로필 가져오기
	@Override
	public MyPetProfileDto getLoginUserPetProfile(String email) {
		MyPetProfileDto dto = sqlSession.selectOne(ns + "getLoginUserPetProfile", email);
		return dto;
	}
	
	@Override
	public int getAllPointList(MypagePointListParam pageingparam) {
		return sqlSession.selectOne(ns+"getAllPointList", pageingparam);
	}
	@Override
	public List<PointHistoryDto> getPointHIstoryList(MypagePointListParam pageingparam) {
		//List<PointHistoryDto> list = 
		return sqlSession.selectList(ns+"getPointHIstoryList", pageingparam);
	}
	
	
	
	//혜연과 유정사이
	
	
	@Override
	public int getMyPlayCount(String email) {
		
		return sqlSession.selectOne(ns+"getMyPlayCount", email);
	}

	@Override
	public int getMyFreeCount(String email) {
		
		return sqlSession.selectOne(ns+"getMyFreeCount", email);
	}

	@Override
	public int getMyCommentCount(String email) {
		
		return sqlSession.selectOne(ns+"getMyCommentCount", email);
	}
	
	@Override
	public List<MypageFollowListParam> getRecentFollowersPlayJoin(String email) {
		
		return sqlSession.selectList(ns+"getRecentFollowersPlayJoin", email);
	}

	@Override
	public List<MypageFollowListParam> getRecentFollowersPlayMake(String email) {
		
		return sqlSession.selectList(ns+"getRecentFollowersPlayMake", email);
	}
	
	@Override
	public List<MypageFollowListParam> getRecentFollowersFree(String email) {
		
		return sqlSession.selectList(ns+"getRecentFollowersFree", email);
	}
	
	
	
	
	
	
	
	
	/*혜연*/


	@Override
	public List<PlayboardDto> getJoinPlayList(MypageListParam listparam) {
	
		return sqlSession.selectList(ns+"getJoinPlayList", listparam);
	}


	@Override
	public List<PlayboardDto> getMakePlayList(MypageListParam listparam) {
		return sqlSession.selectList(ns+"getMakePlayList", listparam);
	}

	public List<FundingDto> getMyFundingList(MypageListParam listparam){
		return sqlSession.selectList(ns+"getMyFundingList", listparam);
	}

	
	@Override
	public List<MypageMsgDto> getRevMsgList(MypageMsgParam sparam) {
		
		return sqlSession.selectList(ns+"getRevMsgList", sparam);
	}

	@Override
	public List<MypageMsgDto> getSendMsgList(MypageMsgParam sparam) {
		
		return sqlSession.selectList(ns+"getSendMsgList", sparam);
	}


	@Override
	public MypageMsgDto getRevMsgDetail(MypageMsgDto msgdto) {
	
		return sqlSession.selectOne(ns+"getRevMsgDetail", msgdto);
	}

	@Override
	public void writeNewMsg(MypageMsgDto msgdto) {
		sqlSession.insert(ns+"writeNewMsg", msgdto);
		
	}


	@Override
	public void changeReadcheck1(MypageMsgDto msgdto) {
		sqlSession.update(ns+"changeReadcheck1", msgdto);
		
	}

	@Override
	public void changeReadcheck2(MypageMsgDto msgdto) {
		sqlSession.update(ns+"changeReadcheck2", msgdto);
		
	}

	@Override
	public void deleteRevMsg(MypageMsgDto msgdto) {
		sqlSession.delete(ns+"deleteRevMsg",msgdto);
	}

	@Override
	public void deleteSendMsg(MypageMsgDto msgdto) {
		sqlSession.delete(ns+"deleteSendMsg",msgdto);
		
	}

	@Override
	public int getAllRevMsg(MypageMsgParam sparam) {
		return sqlSession.selectOne(ns+"getAllRevMsg", sparam);
	}

	@Override
	public int getAllSendMsg(MypageMsgParam sparam) {
		
		return sqlSession.selectOne(ns+"getAllSendMsg", sparam);
	}

	@Override
	public int getAllUnreadMsg(MemberDto mdto) {
		
		return sqlSession.selectOne(ns+"getAllUnreadMsg", mdto);
	}

	@Override
	public int myFollowerCount(MypageFollowListParam flwparam) {
		return sqlSession.selectOne(ns+"myFollowerCount", flwparam);
	}

	@Override
	public int myFollowingCount(MypageFollowListParam flwparam) {
		return sqlSession.selectOne(ns+"myFollowingCount", flwparam);
	}

	@Override
	public List<MypageFollowListParam> myFollowerInfoList(MypageFollowListParam flwparam) {
		
		return sqlSession.selectList(ns+"myFollowerInfoList", flwparam);
	}

	@Override
	public List<MypageFollowListParam> myFollowingInfoList(MypageFollowListParam flwparam) {
		return sqlSession.selectList(ns+"myFollowingInfoList", flwparam);
	}


	@Override
	public void writeNewMultiMsgs1(List<MypageMsgDto> msgdtolist) {
		sqlSession.insert(ns+"writeNewMultiMsgs1", msgdtolist);
		
	}

	@Override
	public void writeNewMultiMsgs2(List<MypageMsgDto> msgdtolist) {
		sqlSession.insert(ns+"writeNewMultiMsgs2", msgdtolist);
		
	}

	@Override
	public MypageFollowListParam getFlwingEmail(int seq) {
		return sqlSession.selectOne(ns+"getFlwingEmail", seq);
	}

	@Override
	public MypageFollowListParam getFlwerEmail(int seq) {
		return sqlSession.selectOne(ns+"getFlwerEmail", seq);
	}

	@Override
	public MypageMsgDto getSendMsgDetail(MypageMsgDto msgdto) {
		
		return sqlSession.selectOne(ns+"getSendMsgDetail", msgdto);
	}

	@Override
	public MemberDto checkNicknameExist(String nickname) {
		return sqlSession.selectOne(ns+"checkNicknameExist", nickname);
	}

	

	

}

