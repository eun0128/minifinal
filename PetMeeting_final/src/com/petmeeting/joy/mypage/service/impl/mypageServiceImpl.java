package com.petmeeting.joy.mypage.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.tools.ant.types.CommandlineJava.SysProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import com.petmeeting.joy.mypage.model.MypagemylikeDto;
import com.petmeeting.joy.mypage.model.MypagemylikefreeboardDto;
import com.petmeeting.joy.mypage.model.Mypagewebpush;
import com.petmeeting.joy.mypage.model.PointHistoryDto;
import com.petmeeting.joy.mypage.service.mypageService;
import com.petmeeting.joy.playboard.model.PlayboardDto;

@Service
public class mypageServiceImpl implements mypageService {

	@Autowired
	mypageDao mypageDao;

	@Override
	public void mypagecertification(MemberDto member) {
		mypageDao.mypagecertification(member);
	}

	@Override
	public List<MypageFollowDto> myFollolistemail(MemberDto member) {
		List<MypageFollowDto> list = mypageDao.myFollolistemail(member);
		List<MypageFollowDto> rlist = new ArrayList<MypageFollowDto>();
		for (int i = 0; i < list.size(); i++) {
			System.out.println("내가 팔로우하고있는 사람의 email" + list.get(i));
		}

		System.out.println("list.size" + list.size());
		for (int i = 0; i < list.size(); i++) {
			MypageFollowDto emaildto = list.get(i);

			System.out.println("email" + emaildto.getEmail());

			// System.out.println("emaildto"+emaildto);

			MypageFollowDto nickdto = mypageDao.myFollolistnickname(emaildto);
			String nickname = "";
			// nickname 구했음

			if (nickdto != null) {

				nickname = nickdto.getNickname();
			}

			// 몇명을 구독 하고 있는지
			MypageFollowDto folloingcountdto = mypageDao.mypageFolloingcount(emaildto.getEmail());
			int following = 0;
			if (folloingcountdto == null) {
				following = 0;
			} else {
				following = folloingcountdto.getFolloing();
			}

			// 몇명에게 구독을 당하고 있는지
			MypageFollowDto followercountdto = mypageDao.mypageFollowercount(emaildto.getEmail());
			int follower = 0;
			if (folloingcountdto != null) {
				follower = followercountdto.getFollower();
			}

			// 프로필 사진 꺼내오기
			MypageFollowDto picturedto = mypageDao.mypageprofileimg(emaildto.getEmail());
			String picture = "";
			if (picturedto != null) {
				picture = picturedto.getPicture();
			}

			// 프로필 나의 소개 꺼내오기
			MypageFollowDto introdto = mypageDao.mypageprofileintro(emaildto.getEmail());
			String intro = "";
			if (introdto != null) {
				intro = introdto.getIntro();
			}

			// 리턴해 줄 리스트에 담길 dto
			MypageFollowDto rdto = new MypageFollowDto(emaildto.getEmail(), nickname, follower, following, intro,
					picture);

			System.out.println("return2" + rdto.toString());

			rlist.add(rdto);
		}

		return rlist;
	}

	@Override
	public void mypagefollowdel(MypageFollowDto emaildto) {
		mypageDao.mypagefollowdel(emaildto);

	}

	@Override
	public List<MypageFollowDto> mypagefollowmorelist(MypageFollowparam param) {
		List<MypageFollowDto> list = mypageDao.mypagefollowmorelist(param);

		List<MypageFollowDto> rlist = new ArrayList<MypageFollowDto>();
		for (int i = 0; i < list.size(); i++) {
			System.out.println("내가 팔로우하고있는 사람의 email" + list.get(i));
		}

		System.out.println("list.size" + list.size());
		for (int i = 0; i < list.size(); i++) {
			MypageFollowDto emaildto = list.get(i);

			System.out.println("email" + emaildto.getEmail());

			// System.out.println("emaildto"+emaildto);

			MypageFollowDto nickdto = mypageDao.myFollolistnickname(emaildto);
			String nickname = "";
			// nickname 구했음

			if (nickdto != null) {

				nickname = nickdto.getNickname();
			}

			// 몇명을 구독 하고 있는지
			MypageFollowDto folloingcountdto = mypageDao.mypageFolloingcount(emaildto.getEmail());
			int following = 0;
			if (folloingcountdto == null) {
				following = 0;
			} else {
				following = folloingcountdto.getFolloing();
			}

			// 몇명에게 구독을 당하고 있는지
			MypageFollowDto followercountdto = mypageDao.mypageFollowercount(emaildto.getEmail());
			int follower = 0;
			if (folloingcountdto != null) {
				follower = followercountdto.getFollower();
			}

			// 프로필 사진 꺼내오기
			MypageFollowDto picturedto = mypageDao.mypageprofileimg(emaildto.getEmail());
			String picture = "";
			if (picturedto != null) {
				picture = picturedto.getPicture();
			}

			// 프로필 나의 소개 꺼내오기
			MypageFollowDto introdto = mypageDao.mypageprofileintro(emaildto.getEmail());
			String intro = "";
			if (introdto != null) {
				intro = introdto.getIntro();
			}

			// 리턴해 줄 리스트에 담길 dto
			MypageFollowDto rdto = new MypageFollowDto(emaildto.getEmail(), nickname, follower, following, intro,
					picture);

			System.out.println("return2" + rdto.toString());

			rlist.add(rdto);
		}

		return rlist;

	}

	@Override
	public void mypageInfoUpdateaf(MemberDto member) {
		mypageDao.mypageInfoUpdateaf(member);
	}

	@Override
	public void mypagepasswordUpdateaf(MemberDto member) {
		mypageDao.mypagepasswordUpdateaf(member);
	}

	@Override
	public void mypageMemberleave(MypageMemberleave mem) {
		mypageDao.mypageMemberleave(mem);

	}

	// 44
	@Override
	public List<PlayboardDto> mypageattendplay(MemberDto member) {
		return mypageDao.mypageattendplay(member);
	}

	@Override
	public List<MypageFollowDto> mypagefollowfollwinglist(MypageFollowDto follow) {
		return mypageDao.mypagefollowfollwinglist(follow);
	}

	// 사람과 강아지 프로필 !
	@Override
	public Mypagememandpet mypageprofilememandpet(String email) {

		Mypagememandpet profile = mypageDao.mypageprofilememandpet(email);
		MypageFollowDto follow = mypageDao.mypageFolloingcount(email);
		MypageFollowDto follower = mypageDao.mypageFollowercount(email);

		// 닉네임 구하기 위함
		MypageFollowDto nickname = mypageDao.myFollolistnickname(new MypageFollowDto(email));

		if (profile == null) {
			System.out.println("profileisnull2");
			Mypagememandpet profile2 = new Mypagememandpet(email, follower.getFollower(), follow.getFolloing(),
					nickname.getNickname());
			System.out.println("profilenull" + profile2.toString());
			return profile2;
		} else {

			profile.setFollowing(follow.getFolloing());
			profile.setFollower(follower.getFollower());
			profile.setNickname(nickname.getNickname());
			System.out.println(profile.toString());
			return profile;
		}

	}

	@Override
	public Mypagewebpush mypagemsgpush(String email) {

		String email2 = mypageDao.mypagemsgpushnewperson(email);
		int count = mypageDao.mypagemsgpush(email);

		Mypagewebpush push = new Mypagewebpush(count, email2);

		return push;
	}

	@Override
	public List<FundingDto> mypagefundinglike(MypagemylikeDto param) {
		return mypageDao.mypagefundinglike(param);
	}

	
	@Override
	public List<PlayboardDto> mypageplayboardlike(MypagemylikeDto param) {
		return mypageDao.mypageplayboardlike(param);
	}
	
     @Override
	  public List<FreeboardDto> mypagefreeboardlike(MypagemylikefreeboardDto param) {
		return mypageDao.mypagefreeboardlike(param);
	}

	
	
	
	// 유정/////////////////

	/* ======================== 유정 ======================= */

	
	// 로그인 유저 정보 가져오기
	@Override
	public MemberDto getUser(String email) {
		return mypageDao.getUser(email);
	}

	// 로그인유저 profile 정보가져오기
	@Override
	public MyProfileDto getLoginUserProfile(String email) {
		System.out.println("MypageServiceImpl getLoginUserProfile 파라미터 : " + email);

		MyProfileDto dto = mypageDao.getLoginUserProfile(email);
		if (dto != null) {
			System.out.println("MypageServiceImpl getLoginUserProfile 리턴할dto : " + dto.toString());

		}

		return dto;
	}

	// 로그인유저 등급 가져오기
	@Override
	public MyGradeDto getUserGrade(MemberDto user) {
		MyGradeDto dto = mypageDao.getUserGrade(user);
		return dto;
	}

	// PM_CHECK_MYPROFILE테이블에 email 존재여부 확인
	@Override
	public boolean check_myprofile(MemberDto user) {

		return mypageDao.check_myprofile(user);
	}

	// PM_CHECK_MYPROFILE 에 유저등록 (point추가진행, 포인트 내역에 추가)
	@Override
	public boolean addMyProfileCheck(String email) {

		boolean isS = mypageDao.addMyProfileCheck(email);
		boolean res = false;
		if (isS) {
			// 프로필등록시 포인트추가
			res = mypageDao.addProfilePoint(email);
			mypageDao.addprofilePointHistory(email);
		}
		return res;
	}

	// 프로필업데이트
	@Override
	public boolean updateProfile(MyProfileParam dto) {

		boolean nickup = mypageDao.updateNickname(dto);//닉네임업데이트

		if (nickup) {
			System.out.println("MypageServiceImpl ---- 닉네임업데이트 성공");
			boolean proup = mypageDao.updateProfile(dto);

			if (proup) {
				System.out.println("MypageServiceImpl ---- 프로필업데이트 성공");

				return true;

			} else {
				System.out.println("MypageServiceImpl ---- 닉네임업데이트 성공, 프로필업데이트 실패");
				return false;
			}
		} else {
			System.out.println("MypageServiceImpl ---- 닉네임업데이트 실패, 프로필업데이트 실행X");
			return false;
		}
	}

	// 펫프로필 등록 여부확인
	@Override
	public boolean check_petprofile(String email) {
		return mypageDao.check_petprofile(email);
	}

	// 펫프로필 등록
	@Override
	public boolean insertPetProfile(MyPetProfileDto petdto) {
		boolean res = false;

		boolean insertIs = mypageDao.insertPetProfile(petdto);
		if (insertIs) {
			// 펫프로필체크 테이블에 유저등록
			boolean checkIs = mypageDao.addPetProfileCheck(petdto.getEmail());
			System.out.println("펫프로필체크 테이블에 유저등록 == " + checkIs);

			if (checkIs) {
				// 펫프로필등록시 포인트추가
				res = mypageDao.addPetProfilePoint(petdto.getEmail());
				mypageDao.addpetPointHistory(petdto.getEmail());
			}
		}

		System.out.println("펫프로필등록시 포인트추가  == " + res);

		return res;
	}

	// 펫 프로필 수정
	@Override
	public boolean updatePetProfile(MyPetProfileDto petdto) {
		return mypageDao.updatePetProfile(petdto);
	}

	// 로그인유저 펫프로필 가져오기
	@Override
	public MyPetProfileDto getLoginUserPetProfile(String email) {
		MyPetProfileDto dto = mypageDao.getLoginUserPetProfile(email);
		if (dto != null) {
			System.out.println("MypageServiceImpl getLoginUserPetProfile 리턴할dto : " + dto.toString());
		}

		return dto;
	}
	
	// 포인트내역 리스트 총개수
	@Override
	public int getAllPointList(MypagePointListParam pageingparam) {
		return mypageDao.getAllPointList(pageingparam);
	}
	
	// 포인트내역 페이징된 리스트
	@Override
	public List<PointHistoryDto> getPointHIstoryList(MypagePointListParam pageingparam) {
		return mypageDao.getPointHIstoryList(pageingparam);
	}
	
	
	
	
	@Override
	public int getMyWritingCount(String email) {
		int sum = 0;
		sum = mypageDao.getMyPlayCount(email);
		sum += mypageDao.getMyFreeCount(email);
		return sum;
	}

	@Override
	public int getMyCommentCount(String email) {

		return mypageDao.getMyCommentCount(email);
	}

	@Override
	   public List<MypageFollowListParam> getRecentFollowersPlay(String email) {

	      List<MypageFollowListParam> flwerPlayJoinList = mypageDao.getRecentFollowersPlayJoin(email);
	      List<MypageFollowListParam> flwerPlayMakeList = mypageDao.getRecentFollowersPlayMake(email);
	      
	      List<MypageFollowListParam> flwerAllPlayList = new ArrayList<MypageFollowListParam>();
	      
	      for (MypageFollowListParam mypageFollowListParam : flwerPlayJoinList) {
	         
	         mypageFollowListParam.setSort("[소모임 - 참여]");
	         flwerAllPlayList.add(mypageFollowListParam);
	      }
	      for (MypageFollowListParam mypageFollowListParam : flwerPlayMakeList) {
	         
	         mypageFollowListParam.setSort("[소모임 - 모집]");
	         flwerAllPlayList.add(mypageFollowListParam);
	      }
	        Date playDate1 = null;
	        Date playDate2 = null;
	        
	        for (int i = 0; i < flwerAllPlayList.size(); i++) {
	           for(int j = 0; j < flwerAllPlayList.size()-1; j++) {
	         
	            MypageFollowListParam mypageFollowListParam1 = flwerAllPlayList.get(j);
	            MypageFollowListParam mypageFollowListParam2 = flwerAllPlayList.get(j+1);
	            
	               playDate1 =  mypageFollowListParam1.getPdate();
	               playDate2 =  mypageFollowListParam2.getPdate(); 
	               int result = playDate1.compareTo(playDate2);
	               
	               
	               if(result == 1) {
	                  flwerAllPlayList.set(j, mypageFollowListParam2);
	                  flwerAllPlayList.set(j+1, mypageFollowListParam1);
	               }
	               else {
	                  flwerAllPlayList.set(j, mypageFollowListParam1);
	                  flwerAllPlayList.set(j+1, mypageFollowListParam2);
	               }
	           
	           }
	      }            
	      return flwerAllPlayList;
	   }
	@Override
	public List<MypageFollowListParam> getRecentFollowersFree(String email) {

		return mypageDao.getRecentFollowersFree(email);
	}

	// 혜연!!
	@Override
	public List<PlayboardDto> getJoinPlayList(MypageListParam listparam) {

		return mypageDao.getJoinPlayList(listparam);
	}

	@Override
	public List<PlayboardDto> getMakePlayList(MypageListParam listparam) {
		return mypageDao.getMakePlayList(listparam);
	}


	

	
	public List<FundingDto> getMyFundingList(MypageListParam listparam){

		return mypageDao.getMyFundingList(listparam);
	}

	@Override
	public List<MypageMsgDto> getRevMsgList(MypageMsgParam sparam) {

		return mypageDao.getRevMsgList(sparam);
	}

	@Override
	public List<MypageMsgDto> getSendMsgList(MypageMsgParam sparam) {

		return mypageDao.getSendMsgList(sparam);
	}

	@Override
	public void writeNewMsg(MypageMsgDto msgdto) {
		mypageDao.writeNewMsg(msgdto);

		/*
		 * mypageDao.writeNewMsg1(msgdto); mypageDao.writeNewMsg2(msgdto);
		 */

	}

	@Override
	public MypageMsgDto getRevMsgDetail(MypageMsgDto msgdto) {

		return mypageDao.getRevMsgDetail(msgdto);
	}

	@Override
	public void changeReadcheck(MypageMsgDto msgdto) {
		mypageDao.changeReadcheck1(msgdto);
		mypageDao.changeReadcheck2(msgdto);

	}

	@Override
	public void deleteRevMsg(MypageMsgDto msgdto) {
		mypageDao.deleteRevMsg(msgdto);

	}

	@Override
	public void deleteSendMsg(MypageMsgDto msgdto) {
		mypageDao.deleteSendMsg(msgdto);

	}

	@Override
	public void deleteAllMsg(MypageMsgDto msgdto) {
		mypageDao.deleteRevMsg(msgdto);
		mypageDao.deleteSendMsg(msgdto);

	}

	@Override
	public int getAllRevMsg(MypageMsgParam sparam) {

		return mypageDao.getAllRevMsg(sparam);
	}

	@Override
	public int getAllSendMsg(MypageMsgParam sparam) {

		return mypageDao.getAllSendMsg(sparam);
	}

	@Override
	public int getAllUnreadMsg(MemberDto mdto) {

		return mypageDao.getAllUnreadMsg(mdto);
	}

	@Override
	public int myFollowerCount(MypageFollowListParam flwparam) {
		return mypageDao.myFollowerCount(flwparam);
	}

	@Override
	public int myFollowingCount(MypageFollowListParam flwparam) {
		return mypageDao.myFollowingCount(flwparam);
	}

	@Override
	public List<MypageFollowListParam> myFollowerInfoList(MypageFollowListParam flwparam) {

		return mypageDao.myFollowerInfoList(flwparam);
	}

	@Override
	public List<MypageFollowListParam> myFollowingInfoList(MypageFollowListParam flwparam) {

		return mypageDao.myFollowingInfoList(flwparam);
	}

	@Override
	public void writeNewMultiMsgs(List<MypageMsgDto> msgdtolist) {
		mypageDao.writeNewMultiMsgs1(msgdtolist);
		mypageDao.writeNewMultiMsgs2(msgdtolist);

	}

	@Override
	public MypageFollowListParam getFlwerEmail(int seq) {
		return mypageDao.getFlwerEmail(seq);
	}

	@Override
	public MypageFollowListParam getFlwingEmail(int seq) {
		return mypageDao.getFlwingEmail(seq);
	}

	@Override
	public MypageMsgDto getSendMsgDetail(MypageMsgDto msgdto) {

		return mypageDao.getSendMsgDetail(msgdto);
	}

	@Override
	public MemberDto checkNicknameExist(String nickname) {
		return mypageDao.checkNicknameExist(nickname);
	}

}
