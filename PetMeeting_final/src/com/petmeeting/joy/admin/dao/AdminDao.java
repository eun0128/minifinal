package com.petmeeting.joy.admin.dao;

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
import com.petmeeting.joy.funding.model.FMsgDto;
import com.petmeeting.joy.funding.model.FundingDto;
import com.petmeeting.joy.funding.model.FundingStaDto;
import com.petmeeting.joy.funding.model.fundingBean;
import com.petmeeting.joy.mypage.model.MypageMemberleave;
import com.petmeeting.joy.playboard.model.PlayboardDto;
import com.petmeeting.joy.playboard.model.PlayboardSearchBean;

public interface AdminDao {
	
	
	/*playboard*/
	public List<PlayboardDto> getAllPlayboardList(PlayboardSearchBean search);
	public int getPlayboardTotalRowCount(PlayboardSearchBean search);
	
	public void deletePlayboard(int seq);
	public void deletePlayMem(int seq);
	public void deletePlayboardQnA(int seq);
	
	public PlayboardDto getPlayboardDetail(int seq);


	public List<BoardReportDto> getBoardReportReason(ReportDto reportDto);
	
	public void deleteBoardReport(ReportDto reportDto);
	public void minusReportCount(ReportDto reportDto);

	/*member*/
	public List<AdminMemberDto> getAllMemberList(MemberSearchBean memSearch);
	public int getMemberTotalCount(MemberSearchBean memSearch);
	
	public AdminMemberDto getMemberDetail(String email);
	
	public void pauseMember(String email);
	public void cancelPauseMember(String email);
	
	public int leaveMemberCheck(String email);
	public int memberProfileCheck(String email);
	public int petProfileCheck(String email);
	
	public List<ReportDto> getMemberReportReason(String email);
	
	public void deleteMemberReport(ReportDto reportDto);
	public void minusMemberReportCount(ReportDto reportDto);
	
	
	/* eventboard */
	public void insertEventboard(EventboardDto eventDto);
	
	public List<EventboardDto> getEventList();
	public List<EventboardDto> getMonthlyEventList(String date);
	
	
	public EventboardDto getEventDetail(int seq);
	
	public void eventDelete(int seq);
	
	public void eventUpdate(EventboardDto eventDto);
	
	
	/*funding*/
	public boolean addFunding(FundingDto dto);
	public List<FundingDto> getFundingList(fundingBean fbean);
	public int getFundingCount(fundingBean fbean);

	public FundingDto fundingDetail(int seq);
	public boolean addfundingSta(FundingStaDto sta);
	
	public boolean fundingUpdate(FundingDto dto);
	public void fundingDelete(int seq);
	public void fundingStaDel(int seq);
	public void fundingMemDel(int seq);
	public int fundingStacheck(int seq);
	
	public List<FundMemberDto> whofundingMem(int seq);

	
	public void sendMsgFund(List<FMsgDto> msgList);
	public void revMsgFund(List<FMsgDto> msgList);
	
	/*회원탈퇴*/
	public List<MypageMemberleave> memleave(Memberleaveparam param);
	public int memleavecount(Memberleaveparam param);

	/*notice*/
	public void noticeWrite(NoticeBoardDto dto);
	public List<NoticeBoardDto> getnoticeList(fundingBean bean);
	public int noticeListcount(fundingBean bean);
	public NoticeBoardDto noticeDetail(int seq);
	public void noticeDelete(int seq);
	public void noticeUpdate(NoticeBoardDto dto);
	public void noticeReadCount(int seq);

	/* main */
	public int getTodayPlay();
	public int getTodayFree();
	public int getTodayEndFunding();
	
	public List<AdminMemberDto> getReportTop5();

	public int getfbadminCount(FbParam param);
	public List<FreeboardDto> getfbadminList(FbParam param);
	public List<CommentDto> getfreeboardcmList(int seq);

	public void Freeboardadmindelete(int seq);
	public FreeboardDto getfreeboardadmindetail(int seq);
	public List<CommentDto> getfreeboardadmincmList(int seq);
	public List<ReportDto> getadminreport(ReportDto reportdto);
}
