package com.petmeeting.joy.admin.service;

import java.util.List;

import com.petmeeting.joy.admin.model.AdminMemberDto;
import com.petmeeting.joy.admin.model.BoardReportDto;
import com.petmeeting.joy.admin.model.EventboardDto;
import com.petmeeting.joy.admin.model.FundMemberDto;
import com.petmeeting.joy.admin.model.MemberSearchBean;
import com.petmeeting.joy.admin.model.Memberleaveparam;
import com.petmeeting.joy.admin.model.NoticeBoardDto;
import com.petmeeting.joy.admin.model.ReportDto;
import com.petmeeting.joy.freeboard.model.CommentDto;
import com.petmeeting.joy.freeboard.model.FbParam;
import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.funding.model.DayBean;
import com.petmeeting.joy.funding.model.FundingDto;
import com.petmeeting.joy.funding.model.FundingStaDto;
import com.petmeeting.joy.funding.model.fundingBean;
import com.petmeeting.joy.mypage.model.MypageMemberleave;
import com.petmeeting.joy.playboard.model.PlayboardDto;
import com.petmeeting.joy.playboard.model.PlayboardSearchBean;

public interface AdminService {
	public List<PlayboardDto> getAllPlayboardList(PlayboardSearchBean search);
	public int getPlayboardTotalRowCount(PlayboardSearchBean search);
	
	public void deletePlayboard(int seq);
	
	public List<BoardReportDto> getBoardReportReason(ReportDto reportDto);
	
	public void deleteBoardReport(ReportDto reportDto);
	public PlayboardDto getPlayboardDetail(int seq);
	
	public List<AdminMemberDto> getAllMemberList(MemberSearchBean memSearch);
	public int getMemberTotalCount(MemberSearchBean memSearch);
	
	public AdminMemberDto getMemberDetail(String email);
	
	public void pauseMember(String email);
	public void cancelPauseMember(String email);
	
	public List<ReportDto> getMemberReportReason(String email);
	
	public void deleteMemberReport(ReportDto reportDto);

	/* Funding */
	
	public void insertEventboard(EventboardDto eventDto);
	
	public List<EventboardDto> getEventList();
	
	public List<EventboardDto> getMonthlyEventList(String date);
	
	public EventboardDto getEventDetail(int seq);
	
	public void eventDelete(int seq);
	
	public void eventUpdate(EventboardDto eventDto);

	public boolean addFunding(FundingDto dto, DayBean bean);
	public List<FundingDto> getFundingList(fundingBean fbean);
	public int getFundingCount(fundingBean fbean);
	public void deletefunding(int seq);
	public boolean fundUpdate(FundingDto dto, DayBean bean);
	public boolean addfundingSta(FundingStaDto sta);
	public FundingDto fundingDetail(int seq);
	public List<FundMemberDto> whofundingMem(int seq);
	public void sendMsgfund(List<FundMemberDto> mlist, String title);
	public void sendMsgUpfund(List<FundMemberDto> mList, String title);
	public void fundingStaDel(int seq);
	
	/* Notice */
	public void noticeWrite(NoticeBoardDto dto);
	public List<NoticeBoardDto> getnoticeList(fundingBean bean);
	public int noticeListcount(fundingBean bean);
	public NoticeBoardDto noticeDetail(int seq);
	public void noticeDelete(int seq);
	public void noticeUpdate(NoticeBoardDto dto);
	public void noticeReadCount(int seq);
	
	//회원탈퇴
	public List<MypageMemberleave> memleave(Memberleaveparam param);
	public int memleavecount(Memberleaveparam param);
	
	// 관리자 메인
	public int getTodayPlay();
	public int getTodayFree();
	public int getTodayEndFunding();

	public List<AdminMemberDto> getReportTop5();


	// 자유게시판 관리자 글갯수 카운팅
	public int getfbadminCount(FbParam param);
	//자유게시판 관리자 글 리스트 불러오기
	public List<FreeboardDto> getfbadminList(FbParam param);
	
	public List<CommentDto> getfreeboardcmlist(int seq);
	public void Freeboardadmindelete(int seq);
	
	
	public FreeboardDto getfreeboardadmindetail(int seq);
	public List<CommentDto> getfreeboardadmincmlist(int seq);
	public List<ReportDto> getadminreport(ReportDto reportdto);

	
}
