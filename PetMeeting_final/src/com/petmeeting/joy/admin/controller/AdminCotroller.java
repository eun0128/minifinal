package com.petmeeting.joy.admin.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
import com.petmeeting.joy.freeboard.service.FreeboardService;
import com.petmeeting.joy.funding.model.DayBean;
import com.petmeeting.joy.funding.model.FundingDto;
import com.petmeeting.joy.funding.model.FundingStaDto;
import com.petmeeting.joy.funding.model.fundingBean;
import com.petmeeting.joy.funding.util.FUpUtil;
import com.petmeeting.joy.mypage.model.MypageMemberleave;
import com.petmeeting.joy.mypage.util.MypageDateUtil;
import com.petmeeting.joy.playboard.Util.DateUtil;
import com.petmeeting.joy.playboard.model.MyProfileDto;
import com.petmeeting.joy.playboard.model.PlayMemDto;
import com.petmeeting.joy.playboard.model.PlayboardDateBean;
import com.petmeeting.joy.playboard.model.PlayboardDto;
import com.petmeeting.joy.playboard.model.PlayboardHashTagDto;
import com.petmeeting.joy.playboard.model.PlayboardQnADto;
import com.petmeeting.joy.playboard.model.PlayboardSearchBean;
import com.petmeeting.joy.playboard.service.PlayboardService;
import com.petmeeting.joy.store.model.QnaBean;
import com.petmeeting.joy.store.model.QnaParam;
import com.petmeeting.joy.store.service.OrderService;
import com.petmeeting.joy.store.service.QnaService;

@Controller
public class AdminCotroller {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PlayboardService playboardService;
	
	@Autowired
	QnaService qnaService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	FreeboardService freeboardService;
	
	
	@RequestMapping(value = "adminMain.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String adminMain(Model model, QnaParam param) {

		/*PetMeeting*/
		int todayPlayCount = adminService.getTodayPlay();			// 오늘 올라온 소모임 게시글 수
		int todayFreeCount = adminService.getTodayFree();			// 오늘 올라온 자유게시판 게시글 수
		int todayEndFundCount = adminService.getTodayEndFunding();		// 오늘 마감된 펀딩 수
		
		model.addAttribute("todayPlayCount", todayPlayCount);
		model.addAttribute("todayFreeCount", todayFreeCount);
		model.addAttribute("todayEndFundCount", todayEndFundCount);
		
		List<AdminMemberDto> reportlist = adminService.getReportTop5();
		model.addAttribute("reportlist", reportlist);
		
		/* Store */ 
		int todayQnACount = qnaService.getTodayQuestion();			// 오늘의 문의 내역 수
		int todayOrderCount = orderService.getTodayOrder();			// 오늘 주문 건수 
		int deliveryWaitCount = orderService.getDeliveryWait();		// 배송대기중 건수
		int deliveryIngCount = orderService.getDeliveryIng();		// 배송중 건수
		
		param.setStart(1);
		param.setEnd(5);
		List<QnaBean> qlist = qnaService.getQnalistAll(param);
		
		model.addAttribute("todayQnACount", todayQnACount);
		model.addAttribute("todayOrderCount", todayOrderCount);
		model.addAttribute("deliveryWaitCount", deliveryWaitCount);
		model.addAttribute("deliveryIngCount", deliveryIngCount);
		model.addAttribute("qlist", qlist);
		
		
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "adminPlayboardList.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminPlayboardList(PlayboardSearchBean search, Model model) {
				
	//	System.out.println("searchBean : " + search.toString());
		
		if(search.getPlayCategory() == null || search.getPlayCategory().equals("선택")) {
			search.setPlayCategory("");
		}	
		if(search.getSearchCategory() == null) {
			search.setSearchCategory("선택");
			search.setSearchText("");
		}
		if(search.getSortingType() == null) {
			search.setSortingType("선택");
		}
		
		int totalRowCount = adminService.getPlayboardTotalRowCount(search);
		System.out.println("소모임 총 글 수 : " + totalRowCount);
		
		search.setStartRow((search.getCurrPage() * 10) + 1);
		
		int end = (search.getCurrPage() + 1) * 10;
		if(end > totalRowCount) {
			end = totalRowCount;
		}
		search.setEndRow(end);
			
		System.out.println("searchBean : " + search.toString());
		List<PlayboardDto> playboardList = adminService.getAllPlayboardList(search);

		model.addAttribute("searchBean", search);
		model.addAttribute("playboardList", playboardList);
		model.addAttribute("totalRowCount", totalRowCount);
		
		return "admin/playboard/playboardList";
	}
	
	@RequestMapping(value = "adminPlayboardDelete.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminPlayboardDelete(HttpServletRequest req) {
		String[] dels = req.getParameterValues("delcheck");
		System.out.println(Arrays.toString(dels));
		for (int i = 0; i < dels.length; i++) {
			adminService.deletePlayboard(Integer.parseInt(dels[i]));
		}
		return "redirect:adminPlayboardList.do";
	}
	
	@RequestMapping(value = "adminPlayboardDetail.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminPlayboardDetail(int seq, Model model, PlayboardQnADto qnaDto) {
		PlayboardDto pDto = adminService.getPlayboardDetail(seq);
		
		List<PlayMemDto> partList = playboardService.getPlayMems(seq);
		
		MyProfileDto profile = playboardService.getMyProfile(pDto.getEmail());
		
		PlayboardHashTagDto hashs = playboardService.getHashTags(seq);
		
		if(qnaDto.getCurrPage() == 0) {
			qnaDto = new PlayboardQnADto(seq, 1, 1, 10);
		}else {
			int totalQnA = playboardService.getTotalQnACount(seq);
			int end = qnaDto.getCurrPage()*10;
			if(end > totalQnA) {
				end = totalQnA;
			}
			qnaDto = new PlayboardQnADto(seq, qnaDto.getCurrPage(), ((qnaDto.getCurrPage()-1)*10)+1, end);
		}
		
		List<PlayboardQnADto> qnaList = playboardService.getPlayboardQnAList(qnaDto);
		
		model.addAttribute("detail", pDto);
		model.addAttribute("totalCount", playboardService.getTotalQnACount(seq));
		model.addAttribute("currPage", qnaDto.getCurrPage());
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("hashs", hashs);
		model.addAttribute("profile", profile);
		model.addAttribute("partList", partList);
		return "admin/playboard/playboardDetail";

	}

	@RequestMapping(value = "adminBoardReportReason.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminBoardReportReason(@RequestParam("seq") int seq, @RequestParam("board_code") String board_code, Model model) {
		
		System.out.println("seq : " + seq);
		System.out.println("board_code : " + board_code);
		
		List<BoardReportDto> reportList = adminService.getBoardReportReason(new ReportDto(board_code, seq));
		model.addAttribute("board_seq", seq);
		model.addAttribute("board_code", board_code);
		model.addAttribute("board_reasons", reportList);
		return "admin/reportReason";
	}
	
	@RequestMapping(value = "adminBoardReportDelete.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminBoradReportDelete(ReportDto reportDto, RedirectAttributes redirectAttributes) {
		System.out.println(reportDto.toString());
		adminService.deleteBoardReport(reportDto);
		
		redirectAttributes.addAttribute("seq", reportDto.getBoard_seq());
		redirectAttributes.addAttribute("board_code", reportDto.getBoard_code());
		
		return "redirect:/adminBoardReportReason.do";
	}
	
	
	@RequestMapping(value = "adminMemberList.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminMemberList(MemberSearchBean memSearchBean, Model model) {
				
		if(memSearchBean.getSortingType() == null) {
			memSearchBean.setSortingType("전체");
		}
		
		if(memSearchBean.getGrade() == null || memSearchBean.getGrade().equals("전체")) {
			memSearchBean.setGrade("");
		}
		
		if(memSearchBean.getSearch_category() == null) {
			memSearchBean.setSearch_category("선택");
		}
		
		int totalRowCount = adminService.getMemberTotalCount(memSearchBean);
			System.out.println("총 회원 수 : " + totalRowCount);
			
			memSearchBean.setStart((memSearchBean.getCurrPage() * 10) + 1);
			
			int end = (memSearchBean.getCurrPage() + 1) * 10;
			if(end > totalRowCount) {
				end = totalRowCount;
			}
			memSearchBean.setEnd(end);
		
		System.out.println("memSearchBean : " + memSearchBean);
		List<AdminMemberDto> memberList = adminService.getAllMemberList(memSearchBean);
		//System.out.println(memberList.toString());
		model.addAttribute("totalRowCount", totalRowCount);
		model.addAttribute("searchBean", memSearchBean);
		model.addAttribute("memberList", memberList);
		return "admin/member/memberList";
	}
	
	@RequestMapping(value = "adminPauseMember.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminPauseMember(HttpServletRequest req) {
		String[] mems = req.getParameterValues("memcheck");
		System.out.println(Arrays.toString(mems));
	
		System.out.println(Arrays.toString(mems));
		for (String email : mems) {
			adminService.pauseMember(email);
		}	
		
		return "redirect:/adminMemberList.do";
	}
	
	@RequestMapping(value = "adminCancelPauseMember.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminCancelPauseMember(String email) {
		System.out.println("활중 해제 이멜  : " + email);
		adminService.cancelPauseMember(email);
		return "redirect:/adminMemberList.do";
	}
	@RequestMapping(value = "adminMemberDetail.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminMemberDetail(String email, Model model) {
		System.out.println("정보 볼 이메일 : " + email);
		AdminMemberDto memberDetail = adminService.getMemberDetail(email);
		System.out.println("멤버 정보 : " + memberDetail.toString());
		model.addAttribute("detail", memberDetail);
		return "admin/member/memberDetail";
	}
	
	@RequestMapping(value = "adminMemberReportReason.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminMemberReportReason(@RequestParam("email") String email, Model model) {
		System.out.println("신고내역 확인 할 email : " + email);
		
		List<ReportDto> reportList = adminService.getMemberReportReason(email);
		model.addAttribute("bad_email", email);
		model.addAttribute("member_reasons", reportList);
		return "admin/reportReason";
	}
	
	@RequestMapping(value = "adminMemberReportDelete.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminMemberReportDelete(ReportDto reportDto, RedirectAttributes redirectAttributes) {
		System.out.println("삭제할 reportDto : " + reportDto.toString());
		
		adminService.deleteMemberReport(reportDto);
		
		redirectAttributes.addAttribute("email", reportDto.getBad_email());
		return "redirect:/adminMemberReportReason.do";
	}
	
	

	/* 이벤트 게시판 */
	@RequestMapping(value = "adminEventBoard.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminEventBoard(Model model) {
		List<EventboardDto> eventList = adminService.getEventList();
		
		String jsonData = "[";
		if(!eventList.isEmpty()) {
			for (EventboardDto edto : eventList) {
				jsonData += "{id:"+edto.getSeq()+", title:'"+edto.getTitle()
				 		+"', start:'"+MypageDateUtil.ConvertDate(edto.getEvent_sdate())
				 		+"', end:'"+MypageDateUtil.ConvertDate(edto.getEvent_edate())
				 		+"'},";
			}
		}
		if(jsonData.equals("[")){
			jsonData = "";			
		}
		else{
			jsonData = jsonData.substring(0, jsonData.lastIndexOf(","));
			jsonData += "]";		
		}
	//	System.out.println("jsonData체크" + jsonData);
		
		model.addAttribute("jsonData", jsonData);
		model.addAttribute("eventList", eventList);
		return "admin/eventboard/eventboardList";
	}
	
	@RequestMapping(value = "adminEventWrite.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminEventWrite() {
		return "admin/eventboard/eventWrite";
	}
	
	// CK Editor 속 파일 업로드
	@RequestMapping(value="adminEventfileupload.do", method={RequestMethod.GET,RequestMethod.POST})
	public void fileUpload(@RequestParam MultipartFile upload, 
							HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8"); 
		
		String filename = upload.getOriginalFilename();
		System.out.println("admin 행사등록//  원본 filename : " + filename);
		
		int index = filename.lastIndexOf(".");
		String filetype = filename.substring(index);
		System.out.println("admin 행사등록//  파일 유형 : "+filetype);
		
		filename = UUID.randomUUID().toString() + filetype;
		System.out.println("admin 행사등록//  UUID filename : " + filename);
		
		String fupload = req.getServletContext().getRealPath("/eventboardUpload");
		System.out.println("admin 행사등록//  fupload : " + fupload);
		
		File file = new File(fupload + "/" + filename);
		
		try {
			// 실제 파일 업로드 되는 부분
			FileUtils.writeByteArrayToFile(file, upload.getBytes());
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		PrintWriter pw = resp.getWriter();
		
		String callback = req.getParameter("CKEditorFuncNum");
		System.out.println("callback : " + callback);
		
		String fileUrl = req.getContextPath()+"/eventboardUpload/"+filename;
		
		String script="<script>window.parent.CKEDITOR.tools.callFunction(";
	    script +=callback;
	    script +=",'";
	    script +=fileUrl;
	    script +="','이미지를 업로드 했습니다.') ";
	    script +="</script>";
	    
	    pw.println(script);
	    pw.flush();

	}
	
	// 글쓰기 완료 후
	@RequestMapping(value="adminEventWriteAf.do", method={RequestMethod.GET,RequestMethod.POST})
	public String playboardWriteAf(EventboardDto eventDto, PlayboardDateBean datebean, 
								   @RequestParam(value = "fileload", required = false)MultipartFile fileload, HttpServletRequest req) {
		
		System.out.println(eventDto.toString());
		System.out.println(datebean.toString());	
		
		// Date형식으로 변환
		Date sdate = DateUtil.toDate(datebean.getPyear(), datebean.getPmonth(), datebean.getPday());
		Date edate = DateUtil.toDate(datebean.getEyear(), datebean.getEmonth(), datebean.getEday());
		eventDto.setEvent_sdate(sdate);
		eventDto.setEvent_edate(edate);
		
		// 썸네일 첨부파일의 원본 파일명
		String filename = fileload.getOriginalFilename();
		System.out.println("썸네일 원본 filename : " + filename);
		
		// 첨부파일의 파일 유형 얻어내기
		int index = filename.lastIndexOf(".");
		String filetype = filename.substring(index);
		System.out.println("썸네일 파일 유형 : "+filetype);
		
		// 파일명 중복방지를 위한 UUID 사용
		filename = UUID.randomUUID().toString() + filetype;
		System.out.println("썸네일 UUID filename : " + filename);
		eventDto.setFilename(filename);
		
		// 업로드 경로
		String fupload = req.getServletContext().getRealPath("/eventboardUpload");
		System.out.println("썸네일 fupload : " + fupload);
		
		File file = new File(fupload + "/" + filename);
		
		try {
			// 실제 파일 업로드 되는 부분
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	//	System.out.println("insert할 pdto : " + eventDto.toString());
		adminService.insertEventboard(eventDto);
		
		return "redirect:/adminEventBoard.do";
	}
	
	@RequestMapping(value = "adminEventDetail.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminEventDetail(int seq, Model model) {
		System.out.println("디테일 볼 seq :  " + seq);
		EventboardDto eventDto = adminService.getEventDetail(seq);
		model.addAttribute("detail", eventDto);
		return "admin/eventboard/eventDetail";
	}
		
	@RequestMapping(value = "adminEventDelete.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminEventDelete(int seq) {
		System.out.println("삭제할 행사 seq : " + seq);
		adminService.eventDelete(seq);
		return "redirect:/adminEventBoard.do";
	}
	
	@RequestMapping(value = "adminEventUpdate.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String adminEventUpdate(int seq, Model model) {
		EventboardDto eventDto = adminService.getEventDetail(seq);
		
		PlayboardDateBean date = new PlayboardDateBean();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(eventDto.getEvent_sdate());
		date.setPyear(cal.get(Calendar.YEAR));
		date.setPmonth(cal.get(Calendar.MONTH) + 1);
		date.setPday(cal.get(Calendar.DATE));
		
		cal.setTime(eventDto.getEvent_edate());
		date.setEyear(cal.get(Calendar.YEAR));
		date.setEmonth(cal.get(Calendar.MONTH) + 1);
		date.setEday(cal.get(Calendar.DATE));
		
		model.addAttribute("dateBean", date);
		
		model.addAttribute("detail", eventDto);
		return "admin/eventboard/eventUpdate";
	}	
	
	@RequestMapping(value="adminEventUpdateAf.do", method={RequestMethod.GET,RequestMethod.POST})
	public String adminEventUpdateAf(EventboardDto eventDto, PlayboardDateBean datebean,
			   @RequestParam(value = "fileload", required = false)MultipartFile fileload, HttpServletRequest req) {
		
		System.out.println(eventDto.toString());
		System.out.println(datebean.toString());		

		// Date형식으로 변환
		Date sdate = DateUtil.toDate(datebean.getPyear(), datebean.getPmonth(), datebean.getPday());
		Date edate = DateUtil.toDate(datebean.getEyear(), datebean.getEmonth(), datebean.getEday());
		eventDto.setEvent_sdate(sdate);
		eventDto.setEvent_edate(edate);
		
		// 썸네일 첨부파일의 원본 파일명
		String filename = ""; 

		if(fileload.isEmpty()) {
			filename = eventDto.getFilename();
			System.out.println("수정파일 없음");
		}else {
			filename = fileload.getOriginalFilename();
			System.out.println("파일명: " + filename);
			// 첨부파일의 파일 유형 얻어내기
			int index = filename.lastIndexOf(".");
			String filetype = filename.substring(index);
			System.out.println("썸네일 파일 유형 : "+filetype);
			
			// 파일명 중복방지를 위한 UUID 사용
			filename = UUID.randomUUID().toString() + filetype;
			System.out.println("썸네일 UUID filename : " + filename);
			eventDto.setFilename(filename);
			
			// 업로드 경로
			String fupload = req.getServletContext().getRealPath("/eventboardUpload");
			System.out.println("썸네일 fupload : " + fupload);
			
			File file = new File(fupload + "/" + filename);
			
			try {
				// 실제 파일 업로드 되는 부분
				FileUtils.writeByteArrayToFile(file, fileload.getBytes());
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		System.out.println("filename : " + filename);
			
	//	System.out.println("update할 pdto : " + eventDto.toString());
		adminService.eventUpdate(eventDto);
		return "redirect:/adminEventBoard.do";
	}
		
		
		
		

	/*funding 관리자*/
	@RequestMapping(value = "adminFundingList.do",method = {RequestMethod.GET,RequestMethod.POST})
	public String adminFundingList(Model model, fundingBean fbean) {
		//System.out.println("펀딩 리스트에 들어온 admin: " + fbean.toString());
		
		int totalfundingCount = adminService.getFundingCount(fbean);
		int sn = fbean.getPageNumber();
		
		int start = sn * fbean.getRecordCountPerPage() + 1;
		fbean.setStart(start);
		
		int end = (sn + 1) * fbean.getRecordCountPerPage();
		if (end > totalfundingCount) {
			end = totalfundingCount;
		}
		fbean.setEnd(end);

		List<FundingDto> flist = adminService.getFundingList(fbean);
		
		System.out.println("펀딩 admin리스트 수: " + totalfundingCount);
		
		model.addAttribute("flist", flist);
		model.addAttribute("f_categorys", fbean.getF_categorys());
		model.addAttribute("f_keyword", fbean.getF_keyword());
			
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", fbean.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", totalfundingCount);
		
		return "admin/fundingboard/fundingAdminList";
	}
	
	/*funding 삭제*/
	@RequestMapping(value = "adminFundDelete.do",method = {RequestMethod.GET,RequestMethod.POST})
	public String fundDelete(HttpServletRequest req) {
		String [] Sseq = req.getParameterValues("seq");
		int[] seq = new int[Sseq.length];
		
		for(int i=0; i<Sseq.length; i++) {
			seq[i] = Integer.parseInt(Sseq[i]);
			//System.out.println("들어온 seq : " + seq[i] );

			adminService.deletefunding(seq[i]);
			}
		return "redirect:/adminFundingList.do";
	}
	
	/*funding 글쓰기*/
	@RequestMapping(value = "fundingWrite.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String fundingWrite() {
		 
		return "admin/fundingboard/fundingWrite"; 
	
	}
	
	/*funding 글쓰기 Af*/
	@RequestMapping(value = "fundingWriteAf.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String fundingWriteAf(FundingDto dto, DayBean bean,
			@RequestParam(value = "fileload",required = false)MultipartFile fileload, HttpServletRequest req) {
		
		String filename = fileload.getOriginalFilename();
		dto.setThumbnail(filename);// dto에 파일네임 넣기
		
		String fupload = req.getServletContext().getRealPath("/fundingFileupload");
		System.out.println("fupload 파일 업로드위치: " + fupload);
	
		String f = dto.getThumbnail();
		String newfilename = FUpUtil.getNewFileName(f);

		dto.setThumbnail(newfilename);
		File file = new File(fupload + "/" + newfilename);
		
		try {
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());
		
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		System.out.println("들어온 정보: " + dto.toString() + " , " + bean.toString());
		
		adminService.addFunding(dto, bean);
		return "redirect:/adminFundingList.do";
	}
	
	
	/*수정*/
	@RequestMapping(value = "fundUpdate.do",method = {RequestMethod.GET,RequestMethod.POST})
	public String fundUpdate(int seq, Model model) {
		//System.out.println("들어옴: " + seq);
		FundingDto dto = adminService.fundingDetail(seq);
		model.addAttribute("dto", dto);
		return "admin/fundingboard/fundingUpdate";
	}
	
	
	/*funding 수정 Af*/
	@RequestMapping(value = "fundingUpateAf.do" , method = {RequestMethod.GET,RequestMethod.POST})
	public String fundingUpateAf(FundingDto dto ,  DayBean bean, @RequestParam(value = "fileload",required = false)MultipartFile fileload, HttpServletRequest req) {

				String filename = fileload.getOriginalFilename();
				dto.setThumbnail(filename);// dto에 파일네임 넣기

				String fupload = req.getServletContext().getRealPath("/fundingFileupload");
				System.out.println("fupload 파일 업로드위치: " + fupload);

				String f = dto.getThumbnail();

				File file = new File(fupload + "/" + f);
				
				try {
					FileUtils.writeByteArrayToFile(file, fileload.getBytes());
				
				} catch (IOException e) {
					e.printStackTrace();
				}
			
		//System.out.println("수정Af에 들어온 dto: " + dto.toString());
		//System.out.println("수정Af에 들어온 bean: " +bean.toString());
		
		boolean b = adminService.fundUpdate(dto,bean);
		if(b) {
			//System.out.println("업데이트 성공");
			
			
			List<FundMemberDto> memList = adminService.whofundingMem(dto.getSeq());
			for(int i=0; i<memList.size(); i++ ) {
			System.out.println("글수정 Af 에들어온 List : " + memList.get(i).toString() );
			}
			
			if(memList.size() > 0 ) {
				adminService.sendMsgUpfund(memList, dto.getTitle());
			}
			return "redirect:/adminFundingList.do";
		}
		else {
			System.out.println("업데이트 실패");
			return "redirect:/adminFundingList.do";
		}
	}
	
	/*funding 디테일*/
	@RequestMapping(value = "adminFundingDetail.do" , method = {RequestMethod.GET,RequestMethod.POST})
	public String fundingDetail(Model model,int seq) {
		FundingDto dto = adminService.fundingDetail(seq);
		model.addAttribute("dto", dto);
		return "admin/fundingboard/fundingAdminDetail";
	}	
	
	/*fundingMem popup*/
	@RequestMapping(value = "fundingMempop.do",method = {RequestMethod.GET,RequestMethod.POST})
	public String fundingMempop(int seq, Model model){
		System.out.println("memlistPop:" + seq);
		List<FundMemberDto> mlist = adminService.whofundingMem(seq);
		FundingDto dto = adminService.fundingDetail(seq);
		model.addAttribute("mlist", mlist);
		model.addAttribute("dto", dto);
		return "admin/fundingboard/fundingMemPop";
	}
	
	
	/*funding 내역서 글쓰기 Af*/
	@RequestMapping(value = "statementAf.do" , method = {RequestMethod.GET,RequestMethod.POST})
	public String statementAf(FundingStaDto sta) {
		System.out.println("들어온 sta : " + sta.toString());
		
		FundingDto dto = adminService.fundingDetail(sta.getSeq());
		
		List<FundMemberDto> memList = adminService.whofundingMem(sta.getSeq());
		for(int i=0; i<memList.size(); i++ ) {
		System.out.println("글쓰기 Af 에들어온 List : " + memList.get(i).toString() );
		}
		
		if(memList.size() > 0 ) {
			adminService.sendMsgfund(memList, dto.getTitle());
		}
		
		adminService.addfundingSta(sta);
		
		return "redirect:/adminFundingList.do";
	}
	
	/*funding 내역서만 삭제*/
	@ResponseBody
	@RequestMapping(value = "fundingStaDel.do" ,method = {RequestMethod.GET,RequestMethod.POST})
	public void fundingStaDel(int seq) {
		adminService.fundingStaDel(seq);
	}
	
	/*공지 게시판*/
	@RequestMapping(value = "noticeList.do",method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeListHome(fundingBean bean, Model model) {
		System.out.println("공지게시판 들어온 bean: " + bean.toString());
		int totalCount = adminService.noticeListcount(bean);
		int sn = bean.getPageNumber();
		
		int start = sn * bean.getRecordCountPerPage() + 1;
		bean.setStart(start);
		int end = (sn + 1) * bean.getRecordCountPerPage();
		if( end > totalCount ) {
			end  = totalCount;
		}
		bean.setEnd(end);
		List<NoticeBoardDto> list = adminService.getnoticeList(bean);
		
		model.addAttribute("list", list);
		model.addAttribute("f_keyword", bean.getF_keyword());
		model.addAttribute("f_categorys", bean.getF_categorys());
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", bean.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", totalCount);
		
		return "admin/noticeboard/noticeList";
	}
	
	@RequestMapping(value = "noticeWrite.do",method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeWrite() {
		return "admin/noticeboard/noticeWrite";
	}
	
	@RequestMapping(value = "noticeWriteAf.do",method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeWriteAf(NoticeBoardDto dto) {
		System.out.println("공지dto[controller] = " + dto.toString());
		adminService.noticeWrite(dto);
		
		return "redirect:/noticeList.do";
	}
	
	@RequestMapping(value = "noticeDetail.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeDetail(int seq, Model model) {
		NoticeBoardDto dto = adminService.noticeDetail(seq);
		model.addAttribute("dto", dto);
		return "admin/noticeboard/noticeDetail";
	}
	
	@RequestMapping(value = "noticeDelete.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeDelete(HttpServletRequest req) {
		
		String [] Sseq = req.getParameterValues("seq");
		int[] seq = new int[Sseq.length];
		
		for(int i=0; i<Sseq.length; i++) {
			seq[i] = Integer.parseInt(Sseq[i]);
			System.out.println("들어온 seq : " + seq[i] );

			adminService.noticeDelete(seq[i]);
			}
		return "redirect:/noticeList.do";
	}
	
	/*공지게시판 수정*/
	@RequestMapping(value = "noticeUpdate.do",method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeUpdate(int seq,Model model) {
		NoticeBoardDto dto = adminService.noticeDetail(seq);
		model.addAttribute("dto", dto);
		return "admin/noticeboard/noticeUpdate";
	}
	
	@RequestMapping(value = "noticeUpdateAf.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeUpdateAf(NoticeBoardDto dto) {
		System.out.println("수정 Af에 들어온 dto: " +dto.toString());
		adminService.noticeUpdate(dto);
		return "redirect:/noticeList.do";
	}
	
	/*공지게시판 회원에게 보여줄 리스트*/
	@RequestMapping(value = "noticeboard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeboard(fundingBean bean, Model model) {

		int totalCount = adminService.noticeListcount(bean);
		int sn = bean.getPageNumber();
		
		int start = sn * bean.getRecordCountPerPage() + 1;
		bean.setStart(start);
		int end = (sn + 1) * bean.getRecordCountPerPage();
		if( end > totalCount ) {
			end  = totalCount;
		}
		bean.setEnd(end);
		List<NoticeBoardDto> list = adminService.getnoticeList(bean);
		
		model.addAttribute("list", list);
		model.addAttribute("f_keyword", bean.getF_keyword());
		model.addAttribute("f_categorys", bean.getF_categorys());
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", bean.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", totalCount);
		
		return "notice/noticeboardList";
	}
	
	@RequestMapping(value = "noticeboardDetail.do",method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeboardDetail(int seq, Model model) {
		adminService.noticeReadCount(seq);
		NoticeBoardDto dto = adminService.noticeDetail(seq);
		model.addAttribute("dto", dto);
		return "notice/noticeboardDetail";
	}
	
	/*회원탈퇴 통계 */
	@RequestMapping(value = "adminMemleavegraph.do",method = {RequestMethod.GET,RequestMethod.POST})
	public String adminMemleavegraph(Model model, Memberleaveparam param){
			
			int page = param.getPageNumber();
			int start = page * param.getRecordCountPerPage() + 1;
			int end = (page + 1) * param.getRecordCountPerPage();
			
			param.setStart(start);
			param.setEnd(end);
	
			System.out.println("회원탈퇴통계1"+param.toString());
			//검색할 때마다 초기화 해주기 위한 존재
			Memberleaveparam mparam = new Memberleaveparam("", //category
														   "", //keyword
														   "", //search_category
														   0, //pageNumber
														   0, //recordCountPerPage
														   start,
														   end);
			
			//초기화 해주는 중
			int totalRecordCount = adminService.memleavecount(mparam);
			List<MypageMemberleave> leavelist = adminService.memleave(mparam);
			
			//그러고 값 넣는 중
			totalRecordCount = adminService.memleavecount(param);
			leavelist = adminService.memleave(param);
			
			model.addAttribute("pageNumber", page);
			model.addAttribute("list", leavelist);
			model.addAttribute("pageCountPerScreen", 10);
			model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());
			model.addAttribute("totalRecordCount", totalRecordCount);
			model.addAttribute("searchbean", param);
			
		/*
		 * 
		 * if(param.getStart()==0) { param.setStart(1); param.setEnd(10);
		 * List<MypageMemberleave> list=adminService.memleave(param); int
		 * totalcount=adminService.memleavecount(param);
		 * System.out.println("토탈"+totalcount);
		 * 
		 * 
		 * model.addAttribute("totalcount",totalcount); model.addAttribute("list",
		 * list); model.addAttribute("searchbean", param);
		 * 
		 * }
		 */
		
		
		return "admin/memberleave/memleavegraph";
	}

	
	// 관리자페이지 자유게시판 리스트 불러오기
		@RequestMapping(value="adminFreeboardList.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String admin(FbParam param, Model model) {
			System.out.println("----------------페이지 : " + param.getPageNumber());
			
			//페이징
			int sn = param.getPageNumber();		// 0 1 2 
			int start = sn * param.getRecordCountPerPage() + 1;	// 1  11 
			int end = (sn + 1) * param.getRecordCountPerPage();	// 10 20
			
			param.setStart(start);
			param.setEnd(end);				
					
			List<FreeboardDto> list = freeboardService.getfbadminList(param);
			//List<FreeboardDto> list = adminService.getfbadminList(param);
			
			int totalRecordCount = freeboardService.getfbadminCount(param);
			//int totalRecordCount = adminService.getfbadminCount(param);
			
			System.out.println("리스트 사이즈 : " + list.size());
			System.out.println("총 글의 갯수 : " + totalRecordCount);
			
			
			//paging
			model.addAttribute("pageNumber", sn);
			model.addAttribute("pageCountPerScreen", 10);
			model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());
			model.addAttribute("totalRecordCount", totalRecordCount);
			//param
			model.addAttribute("board_code", param.getBoard_code());
			model.addAttribute("s_category", param.getS_category());
			model.addAttribute("s_keyword", param.getS_keyword());
			model.addAttribute("category", param.getCategory());
			model.addAttribute("sorting", param.getSorting());

			model.addAttribute("list", list);
			
			return "admin/freeboard/freeboardList";
		}
		
		
		
		// 자유게시판 관리자 글삭제
		@RequestMapping(value= "adminFreeboardDelete.do", method= {RequestMethod.GET, RequestMethod.POST})
		public String adminFreeboardDelete(HttpServletRequest req) {
			System.out.println("관리자삭제옴");
			String[] dels = req.getParameterValues("deleteboard");
			for (int i = 0; i < dels.length; i++) {
				this.adminService.Freeboardadmindelete(Integer.parseInt(dels[i]));}
			return "redirect:adminFreeboardList.do";
		}
		
		
		@RequestMapping(value="adminFreeboardDetail.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String adminFreeboardDetail(Model model, int seq, HttpServletRequest req) throws Exception {
			
			FreeboardDto fb = adminService.getfreeboardadmindetail(seq);
			model.addAttribute("dto", fb);
				
			List<CommentDto> cmlist = adminService.getfreeboardadmincmlist(seq);
			model.addAttribute("cmlist", cmlist);
			
			
			return "admin/freeboard/freeboardDetail";
		}
		
}
