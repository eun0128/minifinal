package com.petmeeting.joy.mypage.service;

import java.util.List;

import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.funding.model.FundingDto;
import com.petmeeting.joy.login.model.MemberDto;
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
import com.petmeeting.joy.mypage.model.MypagemylikeDto;
import com.petmeeting.joy.mypage.model.MypagemylikefreeboardDto;
import com.petmeeting.joy.mypage.model.Mypagewebpush;
import com.petmeeting.joy.mypage.model.PointHistoryDto;
import com.petmeeting.joy.playboard.model.PlayboardDto;


public interface mypageService {

	
	public void mypagecertification(MemberDto member);
	public List<MypageFollowDto> myFollolistemail(MemberDto member);
	
	
	//구독을 취소하는 부분
	public void mypagefollowdel(MypageFollowDto emaildto);

	//더보기 된 followlist부분
	public List<MypageFollowDto> mypagefollowmorelist(MypageFollowparam param);

    //회원정보를 수정 하였을 때
	public void mypageInfoUpdateaf(MemberDto member);
    
	public void mypagepasswordUpdateaf(MemberDto member);

	//회원탈퇴 하였을 때
	public void mypageMemberleave(MypageMemberleave mem);
	
	//해당 사람의 참여중인 소모임을 보고싶을때
	public List<PlayboardDto> mypageattendplay(MemberDto member);
	
	public List<MypageFollowDto> mypagefollowfollwinglist(MypageFollowDto follow);
	
	
	public Mypagememandpet mypageprofilememandpet(String email);
	
	
	public Mypagewebpush mypagemsgpush(String email);
	
	public List<FundingDto> mypagefundinglike(MypagemylikeDto param);
	
	public List<PlayboardDto> mypageplayboardlike(MypagemylikeDto param);
	
	
	public List<FreeboardDto> mypagefreeboardlike(MypagemylikefreeboardDto param);
	
	//유정////////
	
	

	// 로그인 유저 정보 가져오기
	public MemberDto getUser(String email);
	
	// 로그인 유저 profile 정보가져오기
	public MyProfileDto getLoginUserProfile(String email);
	
	// 로그인유저 등급 가져오기
	public MyGradeDto getUserGrade(MemberDto user);
	
	// PM_CHECK_MYPROFILE테이블에 email 존재여부 확인 
	public boolean check_myprofile(MemberDto user);
	
	// 프로필업데이트
	public boolean updateProfile(MyProfileParam dto);
	
	// PM_CHECK_MYPROFILE 프로필체크유저등록 (point추가진행)
	public boolean addMyProfileCheck(String email);		
	
	// 펫프로필 등록 여부확인
	public boolean check_petprofile(String email);
	
	// 펫프로필 등록
	public boolean insertPetProfile(MyPetProfileDto petdto);
	
	// 프로필 수정
	public boolean updatePetProfile(MyPetProfileDto petdto);
	
	// 로그인유저 펫프로필 가져오기
	public MyPetProfileDto getLoginUserPetProfile(String email);
	
	
	
	// 포인트내역리스트 총수
	public int getAllPointList(MypagePointListParam pageingparam);
	// 페이징된 포인트내역 리스트
	public List<PointHistoryDto> getPointHIstoryList(MypagePointListParam pageingparam );
	
	
	
	public int getMyWritingCount(String email);

	public int getMyCommentCount(String email);
	
	public List<MypageFollowListParam> getRecentFollowersPlay(String email);
	
	
	public List<MypageFollowListParam> getRecentFollowersFree(String email);
	
	
	
	
	
	
	/*혜연*/


	public List<PlayboardDto> getJoinPlayList(MypageListParam listparam);

	public List<PlayboardDto> getMakePlayList(MypageListParam listparam);
	
	public List<FundingDto> getMyFundingList(MypageListParam listparam);
	
	public List<MypageMsgDto> getRevMsgList(MypageMsgParam sparam);
	
	public List<MypageMsgDto> getSendMsgList(MypageMsgParam sparam);
	
	public int getAllRevMsg(MypageMsgParam sparam);
	
	public void writeNewMsg(MypageMsgDto msgdto);
	
	public MypageMsgDto getRevMsgDetail(MypageMsgDto msgdto);
	
	public MypageMsgDto getSendMsgDetail(MypageMsgDto msgdto);

	public void changeReadcheck(MypageMsgDto msgdto);

	public void deleteRevMsg(MypageMsgDto msgdto);
	
	public void deleteSendMsg(MypageMsgDto msgdto);

	public void deleteAllMsg(MypageMsgDto msgdto);

	public int getAllSendMsg(MypageMsgParam sparam);
	
	public int getAllUnreadMsg(MemberDto mdto);
	
	public int myFollowerCount(MypageFollowListParam flwparam);
	
	public int myFollowingCount(MypageFollowListParam flwparam);
	
	public List<MypageFollowListParam> myFollowerInfoList(MypageFollowListParam flwparam);
	
	public List<MypageFollowListParam> myFollowingInfoList(MypageFollowListParam flwparam);

	public void writeNewMultiMsgs(List<MypageMsgDto> msgdtolist);

	public MypageFollowListParam getFlwerEmail(int seq);

	public MypageFollowListParam getFlwingEmail(int seq);
	
	public MemberDto checkNicknameExist(String nickname);
}

