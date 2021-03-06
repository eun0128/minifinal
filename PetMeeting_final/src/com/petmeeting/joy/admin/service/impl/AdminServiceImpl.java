package com.petmeeting.joy.admin.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petmeeting.joy.admin.dao.AdminDao;
import com.petmeeting.joy.admin.model.AdminMemberDto;
import com.petmeeting.joy.admin.model.BoardReportDto;
import com.petmeeting.joy.admin.model.EventboardDto;
import com.petmeeting.joy.admin.model.FundMemberDto;
import com.petmeeting.joy.admin.model.MemberSearchBean;
import com.petmeeting.joy.admin.model.Memberleaveparam;
import com.petmeeting.joy.admin.model.NoticeBoardDto;
import com.petmeeting.joy.admin.model.ReportDto;
import com.petmeeting.joy.admin.service.AdminService;
import com.petmeeting.joy.freeboard.model.CommentDto;
import com.petmeeting.joy.freeboard.model.FbParam;
import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.funding.model.DayBean;
import com.petmeeting.joy.funding.model.FMsgDto;
import com.petmeeting.joy.funding.model.FundingDto;
import com.petmeeting.joy.funding.model.FundingStaDto;
import com.petmeeting.joy.funding.model.fundingBean;
import com.petmeeting.joy.mypage.model.MypageMemberleave;
import com.petmeeting.joy.playboard.Util.DateUtil;
import com.petmeeting.joy.playboard.model.PlayboardDto;
import com.petmeeting.joy.playboard.model.PlayboardSearchBean;

@Service
public class AdminServiceImpl implements AdminService {
	


	@Autowired
	AdminDao adminDao;
	

	//////////////////////////////////// 소모임 ////////////////////////////////////
	/* 소모임 글목록 불러오기 */
	@Override
	public List<PlayboardDto> getAllPlayboardList(PlayboardSearchBean search) {
		List<PlayboardDto> all =  adminDao.getAllPlayboardList(search);
		List<PlayboardDto> checkList = new ArrayList<PlayboardDto>();
		
		for (PlayboardDto dto : all) {
			if(DateUtil.isEnd(dto.getEdate()) == true) {	// 마감
				dto.setDeadlineCheck(true);
			}else if(DateUtil.isEnd(dto.getEdate()) == false) {
				dto.setDeadlineCheck(false);
			}
			
			if(dto.getPeople() == dto.getPersoncount()) {	// 모집인원이 다 찬경우
				dto.setFullCheck(true);
			}else {
				dto.setFullCheck(false);
			}
			
			if(DateUtil.isEnd(dto.getPdate()) == true) {	// 모임예정일 지남
				dto.setPdateCheck(true);
			}else {
				dto.setPdateCheck(false);
			}
			
			checkList.add(dto);
		}
		return checkList;
	}
	
	/* 페이징을 위한 소모임 글 수 알아내기 */
	@Override
	public int getPlayboardTotalRowCount(PlayboardSearchBean search) {
		return adminDao.getPlayboardTotalRowCount(search);
	}
	
	/* 관리자에의한 소모임 글 삭제(DB에서 삭제) */
	@Override
	public void deletePlayboard(int seq) {
		adminDao.deletePlayboardQnA(seq);
		adminDao.deletePlayMem(seq);
		adminDao.deletePlayboard(seq);		
	}
	
	/* 게시판 신고 내역 뽑기 */
	@Override
	public List<BoardReportDto> getBoardReportReason(ReportDto reportDto) {
		return adminDao.getBoardReportReason(reportDto);
	}
	
	/* 게시판 신고 삭제 */
	@Override
	public void deleteBoardReport(ReportDto reportDto) {
		adminDao.deleteBoardReport(reportDto);
		adminDao.minusReportCount(reportDto);
	}
	
	/* 소모임 글 디테일 */
	@Override
	public PlayboardDto getPlayboardDetail(int seq) {
		PlayboardDto detail = adminDao.getPlayboardDetail(seq);
		if(DateUtil.isEnd(detail.getEdate()) == true) {	// 마감
			detail.setDeadlineCheck(true);
		}else if(DateUtil.isEnd(detail.getEdate()) == false) {
			detail.setDeadlineCheck(false);
		}
		
		if(detail.getPeople() == detail.getPersoncount()) {	// 모집인원이 다 찬경우
			detail.setFullCheck(true);
		}else {
			detail.setFullCheck(false);
		}			
		return detail;
	}
	
	//////////////////////////////////// 회원관리 ////////////////////////////////////
	/* 회원 목록 리스트 */
	@Override
	public List<AdminMemberDto> getAllMemberList(MemberSearchBean memSearch) {
		
		List<AdminMemberDto> memlist = adminDao.getAllMemberList(memSearch);
		
		for (AdminMemberDto dto : memlist) {
			int leavememCheck = adminDao.leaveMemberCheck(dto.getEmail());
			if(leavememCheck > 0) {
				dto.setLeavememberCheck(true);
			}else {
				dto.setLeavememberCheck(false);
			}
			
			int myPcheck = adminDao.memberProfileCheck(dto.getEmail());
			if(myPcheck > 0) {
				dto.setMyProfileCheck(true);
			}else {
				dto.setMyProfileCheck(false);
			}
			
			int petPcheck = adminDao.petProfileCheck(dto.getEmail());
			if(petPcheck > 0) {
				dto.setPetProfileCheck(true);
			}else {
				dto.setPetProfileCheck(false);
			}
		}
				
		return memlist;
	}
	
	/* 페이징을 위한 멤버 수 구하기 */
	@Override
	public int getMemberTotalCount(MemberSearchBean memSearch) {
		return adminDao.getMemberTotalCount(memSearch);
	}
	
	/* 회원 디테일(기본정보 + 회원프로필 + 펫프로필) */
	@Override
	public AdminMemberDto getMemberDetail(String email) {
		AdminMemberDto dto = adminDao.getMemberDetail(email);
		int leavememCheck = adminDao.leaveMemberCheck(dto.getEmail());
		if(leavememCheck > 0) {
			dto.setLeavememberCheck(true);
		}else {
			dto.setLeavememberCheck(false);
		}
		
		int myPcheck = adminDao.memberProfileCheck(dto.getEmail());
		if(myPcheck > 0) {
			dto.setMyProfileCheck(true);
		}else {
			dto.setMyProfileCheck(false);
		}
		
		int petPcheck = adminDao.petProfileCheck(dto.getEmail());
		if(petPcheck > 0) {
			dto.setPetProfileCheck(true);
		}else {
			dto.setPetProfileCheck(false);
		}
		return dto;
	}
	
	/* 관리자에 의한 활동 중지 */
	@Override
	public void pauseMember(String email) {
		adminDao.pauseMember(email);
	}
	/* 활동중지 해제 */
	@Override
	public void cancelPauseMember(String email) {
		adminDao.cancelPauseMember(email);
	}

	/* 회원 신고 내역 뽑기 */
	@Override
	public List<ReportDto> getMemberReportReason(String email) {
		return adminDao.getMemberReportReason(email);
	}
	
	@Override
	public void deleteMemberReport(ReportDto reportDto) {
		adminDao.deleteMemberReport(reportDto);
		adminDao.minusMemberReportCount(reportDto);
	}
	
	
	//////////////////////////////////// 행사게시판 ////////////////////////////////////
	@Override
	public void insertEventboard(EventboardDto eventDto) {
		adminDao.insertEventboard(eventDto);
	}	

	@Override
	public List<EventboardDto> getEventList() {
		return adminDao.getEventList();
	}
	
	@Override
	public List<EventboardDto> getMonthlyEventList(String date) {
		return adminDao.getMonthlyEventList(date);
	}

	@Override
	public EventboardDto getEventDetail(int seq) {
		
		EventboardDto eventDto = adminDao.getEventDetail(seq);
		
		if(DateUtil.isProgress(eventDto.getEvent_sdate(), eventDto.getEvent_edate())) {
			eventDto.setProgressCheck(true);
		}else {
			eventDto.setProgressCheck(false);
		}
		return eventDto;
	}
	
	@Override
	public void eventDelete(int seq) {
		adminDao.eventDelete(seq);
	}

	@Override
	public void eventUpdate(EventboardDto eventDto) {
		adminDao.eventUpdate(eventDto);
	}

	
	
	
	
	
	//////////////////////////////////// 후원게시판 ////////////////////////////////////

	@Override
	public boolean addFunding(FundingDto dto , DayBean bean) {
		
		FundingDto fundDto = new FundingDto(bean.getEmail(),
											dto.getTitle(), 
											dto.getIntro(), 
											dto.getContent(),
											dto.getThumbnail(),
											dto.getMax_price(), 
											bean.getSDate(), 
											bean.getEDate()
											);
			
		return adminDao.addFunding(fundDto);
	}

	@Override
	public List<FundingDto> getFundingList(fundingBean fbean) {
		List<FundingDto> list = adminDao.getFundingList(fbean);
		List<FundingDto> flist = new ArrayList<FundingDto>();
		
		for(FundingDto fund : list) {
			int seq = fund.getSeq();
			
			int count = adminDao.fundingStacheck(seq);
			
			if(count == 1) {
				fund.setIsfundingsta(true);
			}else {
				fund.setIsfundingsta(false);
			}
			flist.add(fund);
		}
		return flist;
	}

	@Override
	public int getFundingCount(fundingBean fbean) {
		return adminDao.getFundingCount(fbean);
	}
	

	@Override
	public void deletefunding(int seq) {		
			adminDao.fundingStaDel(seq);
			adminDao.fundingMemDel(seq);
			adminDao.fundingDelete(seq);
	}
	
	
	@Override
	public boolean fundUpdate(FundingDto dto, DayBean bean) {
		System.out.println("서비스들어오는 dto 와 빈: " +dto.toString()+","+bean.toString());
		FundingDto fundDto = new FundingDto(
											dto.getSeq(),
											bean.getEmail(),
											dto.getTitle(), 
											dto.getIntro(), 
											dto.getContent(),
											dto.getThumbnail(),
											dto.getMax_price(), 
											bean.getSDate(), 
											bean.getEDate()
											);

		 return adminDao.fundingUpdate(fundDto);
	}

	@Override
	public boolean addfundingSta(FundingStaDto sta) {
		return adminDao.addfundingSta(sta);
	}

	@Override
	public FundingDto fundingDetail(int seq) {
		return adminDao.fundingDetail(seq);
	}
	
	@Override
	public List<FundMemberDto> whofundingMem(int seq) {
		return adminDao.whofundingMem(seq);
	}

	@Override
	public void sendMsgfund(List<FundMemberDto> mList, String title) {
		List<FMsgDto> msgList = new ArrayList<FMsgDto>();
		
		for(FundMemberDto mem : mList) {
			FMsgDto mdto = new FMsgDto();
			FundingDto dto = adminDao.fundingDetail(mem.getFunding_seq());
			
			mdto.setTo_email(mem.getEmail());
			mdto.setFrom_email("admin");
			mdto.setContent(mem.getNickname() +"님 " + "[" + dto.getTitle() +"]" +" 에 후원을 해주셔서 진심으로 감사드립니다. 후원관련 내역서를 확인해 주세요.");
			
			msgList.add(mdto);
		}
		adminDao.sendMsgFund(msgList);
		adminDao.revMsgFund(msgList);
	}
	
	@Override
	public void sendMsgUpfund(List<FundMemberDto> mList, String title) {
		List<FMsgDto> msgList = new ArrayList<FMsgDto>();
		
		for(FundMemberDto mem : mList) {
			FMsgDto mdto = new FMsgDto();
			FundingDto dto = adminDao.fundingDetail(mem.getFunding_seq());
			
			mdto.setTo_email(mem.getEmail());
			mdto.setFrom_email("admin");
			mdto.setContent(mem.getNickname() +"님 " + "후원명  [" + dto.getTitle() +"]" +" 의 내용이 변경 되었습니다. 확인해주세요.");
			
			msgList.add(mdto);
		}
		adminDao.sendMsgFund(msgList);
		adminDao.revMsgFund(msgList);
	}

	@Override
	public void fundingStaDel(int seq) {
		adminDao.fundingStaDel(seq);
	}

	@Override
	public void noticeWrite(NoticeBoardDto dto) {
		adminDao.noticeWrite(dto);
	}

	@Override
	public List<NoticeBoardDto> getnoticeList(fundingBean bean) {
		return adminDao.getnoticeList(bean);
	}

	@Override
	public int noticeListcount(fundingBean bean) {
		return adminDao.noticeListcount(bean);
	}

	@Override
	public NoticeBoardDto noticeDetail(int seq) {
		return adminDao.noticeDetail(seq);
	}

	@Override
	public void noticeDelete(int seq) {
		adminDao.noticeDelete(seq);
	}
	
	@Override
	public List<MypageMemberleave> memleave(Memberleaveparam param) {
		return adminDao.memleave(param);
	}

	@Override
	public int memleavecount(Memberleaveparam param) {
		return adminDao.memleavecount(param);
	}
	
	@Override
	public int getTodayPlay() {
		return adminDao.getTodayPlay();
	}
	
	@Override
	public int getTodayFree() {
		return adminDao.getTodayFree();
	}

	@Override
	public int getTodayEndFunding() {
		return adminDao.getTodayEndFunding();
	}

	@Override
	public List<AdminMemberDto> getReportTop5() {
		return adminDao.getReportTop5();
	}

	@Override
	public void noticeUpdate(NoticeBoardDto dto) {
		adminDao.noticeUpdate(dto);
	}

	@Override
	public void noticeReadCount(int seq) {
		adminDao.noticeReadCount(seq);
	}
	

	@Override
	public int getfbadminCount(FbParam param) {
		return adminDao.getfbadminCount(param);
	}

	@Override
	public List<FreeboardDto> getfbadminList(FbParam param) {
		return adminDao.getfbadminList(param);
	}

	
	@Override
	public List<CommentDto> getfreeboardcmlist(int seq) {
		// TODO Auto-generated method stub
		return adminDao.getfreeboardcmList(seq);
	}

	@Override
	public void Freeboardadmindelete(int seq) {
		adminDao.Freeboardadmindelete(seq);	
	}

	@Override
	public FreeboardDto getfreeboardadmindetail(int seq) {
		return adminDao.getfreeboardadmindetail(seq);
	}

	@Override
	public List<CommentDto> getfreeboardadmincmlist(int seq) {
		return adminDao.getfreeboardadmincmList(seq);
	}

	@Override
	public List<ReportDto> getadminreport(ReportDto reportdto) {
		return adminDao.getadminreport(reportdto);
	}
	
}
