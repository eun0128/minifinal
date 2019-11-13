package com.petmeeting.joy.mypage.dao;

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

import com.petmeeting.joy.mypage.model.PointHistoryDto;

import com.petmeeting.joy.mypage.model.MypagemylikeDto;
import com.petmeeting.joy.mypage.model.MypagemylikefreeboardDto;
import com.petmeeting.joy.playboard.model.PlayboardDto;


public interface mypageDao {
	
	public void mypagecertification(MemberDto member);
	
	//내가 구독하고있는 사람들의 이메일 리스트 알아내기위함
	public List<MypageFollowDto> myFollolistemail(MemberDto member);
	//내가 구독하고 있는 사람들의 닉네임을 알아내기 위함 
	public MypageFollowDto myFollolistnickname(MypageFollowDto emaildto);
	//내가 구독하고 있는 사람이 몇명을 구독하고 있는가를 알아보기 위함
	public MypageFollowDto mypageFolloingcount(String email);
	//내가 구독 하는 사람이 몇명에게 구독을 당하는가를 알아보기 위함
	public MypageFollowDto mypageFollowercount(String email);
	//내가 구독 하는 사람의 프로필 사진을 들고오기 위함
	public MypageFollowDto mypageprofileimg(String email);
    //내가 구독 하는 사람의 프로필 자기소개를 들고오기 위함
	public MypageFollowDto mypageprofileintro(String email);

	//구독취소 버튼을 눌렀을 때 구독을 취소하는 부분 
	public void mypagefollowdel(MypageFollowDto emaildto);
	
	//더보기 란을 눌렀을 경우
	public List<MypageFollowDto> mypagefollowmorelist(MypageFollowparam param);
 
	
	//회원 정보를 업데이트 할 경우 !
	public void mypageInfoUpdateaf(MemberDto member);

	
	//비밀번호를 변경 할 경우!
	public void mypagepasswordUpdateaf(MemberDto member);
	
	//회원 탈퇴 하였을 때
	public void mypageMemberleave(MypageMemberleave mem);
	
	//참여하는 소모임 리스트를 뽑아 낼 때
	public List<PlayboardDto> mypageattendplay(MemberDto member);
	
	//내가 구독하는 사람의 팔로우 팔로잉 목록 리스트를 보고싶을 때 
	public List<MypageFollowDto> mypagefollowfollwinglist(MypageFollowDto follow);
	
	
	//내가 구독하는 사람과 그사람의 펫 프로필을 동시에 보고싶을때 사용
	public Mypagememandpet mypageprofilememandpet(String email);
	
	
	//나의 메세지 웹 푸쉬 알람
	public int mypagemsgpush(String email);
	
	
   //나한테 메세지 보낸 놈 누구야
	public String mypagemsgpushnewperson(String email);
	
	
	//내가 좋아하는 후원!!
	public List<FundingDto> mypagefundinglike(MypagemylikeDto param);
	
	
	//내가 좋아하는 소모임!!
	public List<PlayboardDto> mypageplayboardlike(MypagemylikeDto param);
	
	//내가 좋아하는 게시판글 
	public List<FreeboardDto> mypagefreeboardlike(MypagemylikefreeboardDto param);
	
	
	///////////////////////////////유정//////////////////////

	public MemberDto getUser(String email);

	// 로그인유저 profile 정보가져오기
	public MyProfileDto getLoginUserProfile(String email);
	
	// 로그인유저 등급 가져오기
	public MyGradeDto getUserGrade(MemberDto user);
	
	// PM_CHECK_MYPROFILE테이블에 email 존재여부 확인 
	public boolean check_myprofile(MemberDto user);

	// 프로필업데이트
	public boolean updateProfile(MyProfileParam dto);
	
	// 닉네임 업데이트
	public boolean updateNickname(MyProfileParam dto);	
	
	//  PM_CHECK_MYPROFILE 에 유저등록 (point추가진행)
	public boolean addMyProfileCheck(String email);
	
	// 프로필등록 시 포인트추가 -------------
	public boolean addProfilePoint(String email);
		// 포인트 히스토리 테이블에 추가
		public boolean addprofilePointHistory(String email);
	
	
	// 펫프로필 등록 여부확인
	public boolean check_petprofile(String email);
	
	// 펫프로필 등록
	public boolean insertPetProfile(MyPetProfileDto petdto);
		// 포인트 히스토리 테이블에 추가
		public boolean addpetPointHistory(String email);
	
	// 펫프로필체크 테이블에 유저등록 
	public boolean addPetProfileCheck(String email);
	
	// 펫프로필 등록 포인트 지급 -------------
	public boolean addPetProfilePoint(String email);
	
	// 펫프로필 수정
	public boolean updatePetProfile(MyPetProfileDto petdto);
	
	// 로그인유저 펫프로필 가져오기
	public MyPetProfileDto getLoginUserPetProfile(String email);
	
	
	
	
	
	// 포인트내역리스트 총수
	public int getAllPointList(MypagePointListParam pageingparam);
	
	// 페이징된 포인트내역 리스트
	public List<PointHistoryDto> getPointHIstoryList(MypagePointListParam pageingparam );
	
	
	//혜연과 유정 사이
	
		public int getMyPlayCount(String email);
		
		public int getMyFreeCount(String email);

		public int getMyCommentCount(String email);
		
		public List<MypageFollowListParam> getRecentFollowersPlayJoin(String email);
		
		public List<MypageFollowListParam> getRecentFollowersPlayMake(String email);
		
		public List<MypageFollowListParam> getRecentFollowersFree(String email);
		
	
	
	
	
	//혜연//!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		public List<PlayboardDto> getJoinPlayList(MypageListParam listparam);
		
		public List<PlayboardDto> getMakePlayList(MypageListParam listparam);
		
		public List<FundingDto> getMyFundingList(MypageListParam listparam);
		
		////////////////////////////////////////////////////////////////
		
		public List<MypageMsgDto> getRevMsgList(MypageMsgParam sparam);
		
		public List<MypageMsgDto> getSendMsgList(MypageMsgParam sparam);
		
		public int getAllRevMsg(MypageMsgParam sparam);
		
		public int getAllSendMsg(MypageMsgParam sparam);
		
		public void writeNewMsg(MypageMsgDto msgdto);
		
		public MypageMsgDto getRevMsgDetail(MypageMsgDto msgdto);
		
		public MypageMsgDto getSendMsgDetail(MypageMsgDto msgdto);
		
		public void changeReadcheck1(MypageMsgDto msgdto);
		
		public void changeReadcheck2(MypageMsgDto msgdto);
		
		public void deleteRevMsg(MypageMsgDto msgdto);
		
		public void deleteSendMsg(MypageMsgDto msgdto);
		
		public int getAllUnreadMsg(MemberDto mdto);
		
		public int myFollowerCount(MypageFollowListParam flwparam);
		
		public int myFollowingCount(MypageFollowListParam flwparam);
		
		public List<MypageFollowListParam> myFollowerInfoList(MypageFollowListParam flwparam);
		
		public List<MypageFollowListParam> myFollowingInfoList(MypageFollowListParam flwparam);
		
		public void writeNewMultiMsgs1(List<MypageMsgDto> msgdtolist);
		
		public void writeNewMultiMsgs2(List<MypageMsgDto> msgdtolist);
		
		public MypageFollowListParam getFlwingEmail(int seq);
		
		public MypageFollowListParam getFlwerEmail(int seq);
		
		public MemberDto checkNicknameExist(String nickname);
		
	
}


