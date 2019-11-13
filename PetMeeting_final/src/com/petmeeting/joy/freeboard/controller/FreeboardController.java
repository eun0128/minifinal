package com.petmeeting.joy.freeboard.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.petmeeting.joy.freeboard.model.BoardlikeDto;
import com.petmeeting.joy.freeboard.model.CmreportDto;
import com.petmeeting.joy.freeboard.model.CommentDto;
import com.petmeeting.joy.freeboard.model.CommentlikeDto;
import com.petmeeting.joy.freeboard.model.FbParam;
import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.freeboard.model.ReportDto;
import com.petmeeting.joy.freeboard.service.FreeboardService;
import com.petmeeting.joy.login.model.MemberDto;


@Controller
public class FreeboardController {

	@Autowired
	FreeboardService fbService;

	// 자유게시판 리스트 불러오기
	@RequestMapping(value="freeboard_listview.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String freeboard_listview(Model model, FbParam param) throws Exception{
		System.out.println("fb컨트롤러 fblistview 다녀감");
		
		//페이징
		int sn = param.getPageNumber();		// 0 1 2 
		int start = sn * param.getRecordCountPerPage() + 1;	// 1  11 
		int end = (sn + 1) * param.getRecordCountPerPage();	// 10 20
		
		param.setStart(start);
		param.setEnd(end);				
				
		List<FreeboardDto> list = fbService.getfbList(param);
		model.addAttribute("list", list);
		
		int totalRecordCount = fbService.getfbCount(param);
		System.out.println("리스트 사이즈 : " + list.size());
		System.out.println("총 글의 갯수 : " + totalRecordCount);
		
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", totalRecordCount);
		
		
		model.addAttribute("board_code", param.getBoard_code());
		model.addAttribute("s_category", param.getS_category());
		model.addAttribute("s_keyword", param.getS_keyword());
		model.addAttribute("category", param.getCategory());
		model.addAttribute("sorting", param.getSorting());
		
		return "freeboard/freeboard";
	}
	
	
	//자유게시판 글쓰기 뷰 불러오기
	@RequestMapping(value="freeboard_boardwrite.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String freeboard_boardwrite(Model model, FreeboardDto fb) {
		System.out.println("fb컨트롤러 fbwrite.do 왔다감");
		model.addAttribute("board_code", fb.getBoard_code());
		return "freeboard/fbwrite"; // 폴더명, 파일명
	}
	
	
	// 자유게시판 글쓰기 내용 작성
	@RequestMapping(value="freeboard_boardwritedown.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String freeboard_boardwritedown(FreeboardDto fb) {
		System.out.println("fb컨트롤러 fbwrite.do 왔다감");
		fbService.fbwritedown(fb);
		String boardcode = fb.getBoard_code();
	
		MemberDto mem = new MemberDto();
		String email = fb.getEmail();
		mem.setEmail(email);
		fbService.fbpointup(mem);
		
		
		return "redirect:/freeboard_listview.do?board_code="+boardcode;
	}
	
	
	// 자유게시판 글내용 보기	
	@RequestMapping(value="freeboard_boarddetail.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String freeboard_boarddetail(Model model, int seq, HttpServletRequest req) throws Exception {
		
		String email = "";
		
		if(req.getSession().getAttribute("login")!=null) {
		MemberDto mem = (MemberDto)(req.getSession().getAttribute("login"));
		email = mem.getEmail();
		}
		
		BoardlikeDto likedto = new BoardlikeDto();
		likedto.setEmail(email);
		likedto.setBoard_seq(seq);
		likedto.setBoard_code("DOG");
		boolean like = fbService.dolikecheck(likedto);
		String ch;
		
		if(like == true) {
			ch = "1111";
		}else {
			ch = "2222";
		}
				model.addAttribute("like", like);
				model.addAttribute("check", ch);
				
				FreeboardDto fb = fbService.getdetail(seq);
				model.addAttribute("dto", fb);
			
				List<CommentDto> cmlist = fbService.getcmlist(seq);
				model.addAttribute("cmlist", cmlist);
		
			
				CommentlikeDto cmlikedto = new CommentlikeDto();
				
				cmlikedto.setEmail(email);
				cmlikedto.setBoard_seq(seq);
				cmlikedto.setBoard_code("DOG");
				
				boolean cmlike = fbService.docmlikecheck(cmlikedto);

				String chh;
				
				if(like == true) {
					chh = "1111";
				}else {
					chh = "2222";
				}
				
				model.addAttribute("cmlike", cmlike);
				model.addAttribute("cmcheck", chh);
			
		model.addAttribute("dto", fb);
		fbService.readcountup(seq);
		
		return "freeboard/fbdetail";
	}
	
	//자유게시판 글 수정 화면 불러오기
	@RequestMapping(value="freeboard_boardmodify.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String freeboard_boardmodify(Model model, int seq) throws Exception {
		System.out.println("fb컨트롤러 fbmodify.do 왔다감");
		FreeboardDto fb = fbService.getdetail(seq);
		model.addAttribute("dto", fb);
		
		return "freeboard/fbmodify";
		
	}
	
	
   // 자유게시판 게시글 글수정
	@RequestMapping(value="freeboard_boardupdate.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String fbupdate(FreeboardDto fb) {
		System.out.println("fb컨트롤러 update.do 왔다감");
		fbService.fbupdate(fb);
		String boardcode = fb.getBoard_code();
		int seq = fb.getSeq();
		
		return "redirect:/freeboard_boarddetail.do?seq="+seq; //컨트롤러로 보내는 방법
		
	}
	
	// 자유게시판 글 삭제
	@RequestMapping(value="freeboard_boarddelete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String fbdelete(int seq, String board_code) throws Exception{
		System.out.println("fbdelete 옴");
		boolean isS = fbService.fbdelete(seq);
		
		return "redirect:/freeboard_listview.do?board_code="+board_code;
	}
	
	
	
	// 자유게시판 코맨트 작성
	@RequestMapping(value="freeboard_commentwritedown.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String freeboard_commentwritedown(CommentDto cmdto) {
		System.out.println("fb컨트롤러 writedowncomment.do 왔다감");
		//System.out.println(cmdto.toString());
		int seq = cmdto.getBoard_seq();
		fbService.writedowncomment(cmdto);
		
		MemberDto mem = new MemberDto();
		String email = cmdto.getEmail();
		mem.setEmail(email);
		fbService.cmpointup(mem);
		
		return "redirect:/freeboard_boarddetail.do?seq="+seq;
	}
	
	
	
	// 자유게시판 코맨트 삭제
	@RequestMapping(value="freeboard_commentdelete.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String freeboard_commentdelete(CommentDto cmdto) throws Exception{
		System.out.println("fb컨트롤러 cmdelete 왔다감");
		int seq = cmdto.getBoard_seq();
		
		boolean isSS = fbService.cmdelete(cmdto);
		return "redirect:/freeboard_boarddetail.do?seq="+seq;
	}
	
	// 자유게시판 게시글 좋아요 체크 및 추가 / 삭제 
	 @ResponseBody
	 @RequestMapping(value="freeboard_boardlikecheck.do", method= {RequestMethod.GET})
	 public String test(BoardlikeDto likedto, HttpServletRequest req) throws Exception{
		System.out.println("freeboard_boardlikecheck.do 들어옴");
		System.out.println("§§§§§§§§§§§§§§§§§§§§§§§§§§§§");
		 System.out.println(likedto.toString());
		 HttpSession session = req.getSession();
		 int seq = likedto.getBoard_seq();
		 boolean like = fbService.dolikecheck(likedto);
		 String test = "";
		 
		int a = fbService.getlikecount(likedto);
		 
		 if(like == false) {
				//System.out.println("없음");
				fbService.addlike(likedto);
				//System.out.println("likedtobbbbbbbbb"+likedto);
				//System.out.println("필요값"+seq);
				fbService.likeboard(seq);
				test = "likeit";
		}else {
			//	System.out.println("있음");
				fbService.dellike(likedto);
				fbService.dislikeboard(seq);
				test = "dislikeit";
		}
		
		 return test;
	 }
	 
	 // 자유게시판 코맨트 좋아요 체크 및 추가/삭제
	@ResponseBody
	 @RequestMapping(value="freeboard_commentlikecheck.do", method= {RequestMethod.GET})
	 public String freeboard_commentlikecheck(CommentlikeDto cmlikedto, HttpServletRequest req) throws Exception{
		MemberDto mem = (MemberDto)(req.getSession().getAttribute("login")); 
		String email = mem.getEmail();
		 cmlikedto.setEmail(email);
		 String cmtest = "";
		 int seq = cmlikedto.getSeq();
		boolean cmlike = fbService.docmlikecheck(cmlikedto);
		
		if(cmlike == false) {
			fbService.addcmlike(cmlikedto);
			fbService.cmlikeup(seq);
			cmtest = "likeit";
		}else {
			fbService.delcmlike(cmlikedto);
			fbService.cmlikedown(seq);
			cmtest = "dislikeit";
		}
		 return cmtest;
	 }
	
	
	
	// 코맨트 수정
	@RequestMapping(value="freeboard_commentupdate.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String freeboard_commentupdate(CommentDto cmdto) throws Exception {
		System.out.println("fb컨트롤러 recomment.do 왔다감");
		fbService.cmupdate(cmdto);
		return "";
		
	}
	
	// 코맨트 답글
	@RequestMapping(value="freeboard_recomment.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String freeboard_recomment(CommentDto cmdto) throws Exception {
		System.out.println("fb컨트롤러 test * 3.do 왔다감");
		fbService.recommentwrite(cmdto);
		String abc;
		abc = "abc";
		
		return abc;
		
	}
	
	//게시글 좋아요 숫자 업데이트
	@ResponseBody
	@RequestMapping(value="freeboard_boardlikecount.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String likecount(int seq) throws Exception{
		int a = fbService._getlikecount(seq);
		return a+"";
	}
	
	
	
	
	
	// 코맨트 좋아요 숫자 업데이트
	@ResponseBody
	@RequestMapping(value="freeboard_commentlikecount.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String cmlikecount(int seq) throws Exception{
		int b = fbService._getcmlikecount(seq);
		return b+"";
	}
	
	
	// 게시글 신고 체크
	@ResponseBody
	@RequestMapping(value="freeboard_boardreportCheck.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reportCheck(ReportDto rdto) throws Exception{
		String check;
		boolean report = fbService.doreportcheck(rdto);
		if(report == false) {
			System.out.println("없음");
			check = "OK";
		}else {
			System.out.println("있음");
			check = "NO";
		}
		
		return check;
	}
	
	
	// 게시글 신고창 띄움
	@RequestMapping(value="freeboard_boardReport.do", method={RequestMethod.GET, RequestMethod.POST})
	public String freeboard_boardReport(int seq, HttpServletRequest req, Model model)
	{
		MemberDto mem = (MemberDto)(req.getSession().getAttribute("login"));
		String email = mem.getEmail();
		
		ReportDto reportdto = new ReportDto();
		FreeboardDto fbDTO = new FreeboardDto();
				
		fbDTO = fbService.getdetail(seq);
		
		// 보드코드, 보드 시퀀스, 보드 이메일 
		reportdto.setBoard_code(fbDTO.getBoard_code());
		reportdto.setBoard_seq(fbDTO.getSeq());
		reportdto.setNickname(fbDTO.getNickname());
		reportdto.setEmail(email);
		
		model.addAttribute("dto", fbDTO);
		model.addAttribute("reportform", reportdto);
		
		
		return "freeboard/report";
	}
	
	// 게시글 신고 작성완료
	@RequestMapping(value="freeboard_reportAf.do", method={RequestMethod.GET, RequestMethod.POST})
	public String freeboard_reportAf(ReportDto reportDto){
		
		if (reportDto.getReason().equals("기타")) {
			reportDto.setReason("기타 : " + reportDto.getReasonTxt());
			}
		fbService.reportwritedown(reportDto);
		return "";
	}
	
	
	
// 코맨트 신고 체크
	@ResponseBody
	@RequestMapping(value="freeboard_commentreportCheck.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String cmreportCheck(CmreportDto cmreportdto) throws Exception{
		String cmcheck;
		System.out.println("cmreport컨트롤러옴");
		boolean cmreport = fbService.docmreportcheck(cmreportdto);
		if(cmreport == false) {
			System.out.println("없음");
			cmcheck = "OK";
		}else {
			System.out.println("있음");
			cmcheck = "NO";
		}
		
		return cmcheck;
	}
	
	// 코맨트 신고창 띄움
	@RequestMapping(value="freeboard_commentreport.do", method={RequestMethod.GET, RequestMethod.POST})
	public String freeboard_commentreport(int seq, HttpServletRequest req, Model model){
		MemberDto mem = (MemberDto)(req.getSession().getAttribute("login"));
		String email = mem.getEmail();
		
		CmreportDto cmreportdto = new CmreportDto();
		CommentDto cmDTO = new CommentDto();
		cmDTO = fbService.getcmdetail(seq);
		
		cmreportdto.setBoard_code(cmDTO.getBoard_code());
		cmreportdto.setBoard_seq(cmDTO.getBoard_seq());
		cmreportdto.setComment_seq(cmDTO.getSeq());
		cmreportdto.setEmail(email);
		
		model.addAttribute("cmreportform", cmreportdto);
		
		
		return "freeboard/cmreport";
	}
	
	
	
	
	// 코맨트 신고 작성완료
	@RequestMapping(value="freeboard_commentreportAf.do", method={RequestMethod.GET, RequestMethod.POST})
	public String cmreportwritedown(CmreportDto cmreportDto){
		System.out.println(cmreportDto.toString());
		
		if (cmreportDto.getReason().equals("기타")) {
			cmreportDto.setReason("기타 : " + cmreportDto.getReasonTxt());
			}
		fbService.cmreportwritedown(cmreportDto);
		return "";
	}
	
	
	// 관리자페이지
	@RequestMapping(value="freeboard_admin.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String admin(FbParam param, Model model) {
		System.out.println("fb컨트롤러 admin 다녀감");
				
		//페이징
		int sn = param.getPageNumber();		// 0 1 2 
		int start = sn * param.getRecordCountPerPage() + 1;	// 1  11 
		int end = (sn + 1) * param.getRecordCountPerPage();	// 10 20
		
		param.setStart(start);
		param.setEnd(end);				
				
		//List<FreeboardDto> list = fbService.getfbList(param);
		List<FreeboardDto> list = fbService.getfbadminList(param);
		
		model.addAttribute("list", list);
		
		//int totalRecordCount = fbService.getfbCount(param);
		int totalRecordCount = fbService.getfbadminCount(param);
		
		System.out.println("리스트 사이즈 : " + list.size());
		System.out.println("총 글의 갯수 : " + totalRecordCount);
		
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", totalRecordCount);
		
		model.addAttribute("board_code", param.getBoard_code());
		model.addAttribute("s_category", param.getS_category());
		model.addAttribute("s_keyword", param.getS_keyword());
		model.addAttribute("category", param.getCategory());
		model.addAttribute("sorting", param.getSorting());
		
		return "freeboard/admin";
	}
	
	// 관리자페이지 글 삭제
	
	@RequestMapping(value={"freeboard_admin_delete.do"}, method={RequestMethod.GET, RequestMethod.POST})
	public String adminPlayboardDelete(HttpServletRequest req){
	System.out.println("관리자삭제옴");
	System.out.println(req);
	String[] dels = req.getParameterValues("deleteboard");
	System.out.println("@@@@@@@@@@@@@@@@");
	System.out.println(dels);
	for (int i = 0; i < dels.length; i++) {
		System.out.println("%%%%%%%%%%%%%%%");
		this.fbService.Freeboardadmindelete(Integer.parseInt(dels[i]));}
	return "redirect:freeboard_admin.do";
	}
	
	
	@RequestMapping(value="freeboard_boardadmindetail.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String freeboard_boardadmindetail(Model model, int seq, HttpServletRequest req) throws Exception {
		
		String email = "";
		
		if(req.getSession().getAttribute("login")!=null) {
		MemberDto mem = (MemberDto)(req.getSession().getAttribute("login"));
		email = mem.getEmail();
		}
		
		BoardlikeDto likedto = new BoardlikeDto();
		likedto.setEmail(email);
		likedto.setBoard_seq(seq);
		likedto.setBoard_code("DOG");
		boolean like = fbService.dolikecheck(likedto);
		String ch;
		
		if(like == true) {
			ch = "1111";
		}else {
			ch = "2222";
		}
				model.addAttribute("like", like);
				model.addAttribute("check", ch);
				
				FreeboardDto fb = fbService.getdetail(seq);
				model.addAttribute("dto", fb);
			
				List<CommentDto> cmlist = fbService.getcmlist(seq);
				model.addAttribute("cmlist", cmlist);
		
			
				CommentlikeDto cmlikedto = new CommentlikeDto();
				
				cmlikedto.setEmail(email);
				cmlikedto.setBoard_seq(seq);
				cmlikedto.setBoard_code("DOG");
				
				boolean cmlike = fbService.docmlikecheck(cmlikedto);

				String chh;
				
				if(like == true) {
					chh = "1111";
				}else {
					chh = "2222";
				}
				
				model.addAttribute("cmlike", cmlike);
				model.addAttribute("cmcheck", chh);
			
		model.addAttribute("dto", fb);
		fbService.readcountup(seq);
		
		return "freeboard/fbadmindetail";
	}
	
	
	
		@ResponseBody
		@RequestMapping(value="beforereportchk.do", method= {RequestMethod.GET})
		public int beforereportchk(int seq)throws Exception{
			System.out.println("**********************");
			System.out.println("---------" + seq);
			
			String str = "";
			
			ReportDto reportdto = new ReportDto();
			FreeboardDto fbDTO = new FreeboardDto();
					
			fbDTO = fbService.getdetail(seq);
			
			// 보드코드, 보드 시퀀스, 보드 이메일 
			reportdto.setBoard_code(fbDTO.getBoard_code()); //보드코드가져옴
			reportdto.setSeq(seq);
			reportdto.setNickname(fbDTO.getNickname());
			
			List<ReportDto> _reportdto = fbService.getadminreport(reportdto);
			
			int size = 0;
			size = _reportdto.size();
			
			return size;
		}
		
	
	
	
	// 게시글 신고창 띄움
		@RequestMapping(value="freeboard_adminreportcheck.do", method={RequestMethod.GET, RequestMethod.POST})
		public String freeboard_adminreportcheck(int seq, Model model)
		{
			ReportDto reportdto = new ReportDto();
			FreeboardDto fbDTO = new FreeboardDto();
					
			fbDTO = fbService.getdetail(seq);
			
			// 보드코드, 보드 시퀀스, 보드 이메일 
			reportdto.setBoard_code(fbDTO.getBoard_code()); //보드코드가져옴
			reportdto.setSeq(seq);
			reportdto.setNickname(fbDTO.getNickname());
			
			List<ReportDto> _reportdto = fbService.getadminreport(reportdto);
			
			model.addAttribute("dto", fbDTO);
			model.addAttribute("reportform", _reportdto);
			
			
			return "freeboard/fbadminreportcheck";
		}
	
		
		@RequestMapping(value="freeboard_adminboarddetail.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String freeboard_adminboarddetail(Model model, int seq, HttpServletRequest req) throws Exception {
			
			String email = "";
			
			if(req.getSession().getAttribute("login")!=null) {
			MemberDto mem = (MemberDto)(req.getSession().getAttribute("login"));
			email = mem.getEmail();
			}
			
			BoardlikeDto likedto = new BoardlikeDto();
			likedto.setEmail(email);
			likedto.setBoard_seq(seq);
			likedto.setBoard_code("DOG");
			boolean like = fbService.dolikecheck(likedto);
			String ch;
			
			if(like == true) {
				ch = "1111";
			}else {
				ch = "2222";
			}
					model.addAttribute("like", like);
					model.addAttribute("check", ch);
					
					FreeboardDto fb = fbService.getdetail(seq);
					model.addAttribute("dto", fb);
				
					List<CommentDto> cmlist = fbService.getcmlist(seq);
					model.addAttribute("cmlist", cmlist);
			
				
					CommentlikeDto cmlikedto = new CommentlikeDto();
					
					cmlikedto.setEmail(email);
					cmlikedto.setBoard_seq(seq);
					cmlikedto.setBoard_code("DOG");
					
					boolean cmlike = fbService.docmlikecheck(cmlikedto);

					String chh;
					
					if(like == true) {
						chh = "1111";
					}else {
						chh = "2222";
					}
					
					model.addAttribute("cmlike", cmlike);
					model.addAttribute("cmcheck", chh);
				
			model.addAttribute("dto", fb);
			fbService.readcountup(seq);
			
			return "freeboard/fbadmindetail";
		}
		
		
		// 관리자 코멘트 삭제
		@RequestMapping(value="freeboard_admincommentdelete.do", method= {RequestMethod.GET, RequestMethod.POST})
		public String freeboard_admincommentdelete(CommentDto cmdto) throws Exception{
			System.out.println("fb컨트롤러 cmdelete 왔다감");
			int seq = cmdto.getBoard_seq();
			
			//boolean isSS = fbService.cmdelete(cmdto);
			boolean isSS = fbService.admincmdelete(cmdto);
			
			
			return "redirect:/freeboard_adminboarddetail.do?seq="+seq;
		}


		
	
}


