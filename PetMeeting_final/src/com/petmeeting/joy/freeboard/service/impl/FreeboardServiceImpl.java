package com.petmeeting.joy.freeboard.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petmeeting.joy.freeboard.dao.FreeboardDao;
import com.petmeeting.joy.freeboard.model.BoardlikeDto;
import com.petmeeting.joy.freeboard.model.CmreportDto;
import com.petmeeting.joy.freeboard.model.CommentDto;
import com.petmeeting.joy.freeboard.model.CommentlikeDto;
import com.petmeeting.joy.freeboard.model.FbParam;
import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.freeboard.model.ReportDto;
import com.petmeeting.joy.freeboard.service.FreeboardService;
import com.petmeeting.joy.login.model.MemberDto;


@Service
public class FreeboardServiceImpl implements FreeboardService {

	@Autowired
	FreeboardDao fbDao;

	@Override
	public void fbwritedown(FreeboardDto fb) {
		System.out.println("fb서비스 fbwritedown 왔다감");
		System.out.println(fb.toString());
		fbDao.fbwritedown(fb);	
	}

	@Override
	public List<FreeboardDto> getfbList(FbParam param) {
		System.out.println("fb서비스 fblist.do 왔다감");
		return fbDao.getfbList(param);
	}

	@Override
	public FreeboardDto getdetail(int seq) {
		return fbDao.getdetail(seq);
	}

	@Override
	public void fbupdate(FreeboardDto fb) {
		System.out.println("fb서비스 fbwritupdate 왔다감");
		fbDao.fbupdate(fb);
	}

	@Override
	public boolean fbdelete(int seq) {
	
		return fbDao.fbdelete(seq);
	}

	

	@Override
	public int getfbCount(FbParam param) {		
		return fbDao.getfbCount(param);		
	}
	
	@Override
	public List<FreeboardDto> soltingfree(FbParam param) {
		System.out.println("fb서비스 soltingfree 왔다감");
		return fbDao.soltingfree(param);
	}

	@Override
	public List<FreeboardDto> soltingmiss(FbParam param) {
		System.out.println("fb서비스 getfbsoltingmiss 왔다감");
		return fbDao.soltingmiss(param);
	}

	@Override
	public List<FreeboardDto> soltinginfor(FbParam param) {
		System.out.println("fb서비스 getfbsoltinginfor 왔다감");
		return fbDao.soltinginfor(param);
	}

	@Override
	public List<FreeboardDto> soltingqna(FbParam param) {
		System.out.println("fb서비스 getfbsoltinqna 왔다감");
		return fbDao.soltingqna(param);
	}

	@Override
	public List<FreeboardDto> soltingboast(FbParam param) {
		System.out.println("fb서비스 getfbsoltinqna 왔다감");
		return fbDao.soltingboast(param);
	}

	@Override
	public List<FreeboardDto> soltingdate(FbParam param) {
		System.out.println("fb서비스 getfbsoltingdate 왔다감");
		return fbDao.soltingdate(param);
	}

	
	@Override
	public List<FreeboardDto> solting_date(FbParam param) {
		System.out.println("fb서비스 getfbsoltingdate 왔다감");
		return fbDao.solting_date(param);
	}
	
	@Override
	public List<FreeboardDto> soltinglike(FbParam param) {
		System.out.println("fb서비스 getfbsoltingdate 왔다감");
		return fbDao.soltinglike(param);
	}

	@Override
	public List<FreeboardDto> solting_like(FbParam param) {
		System.out.println("fb서비스 getfbsoltingdate 왔다감");
		return fbDao.solting_like(param);
	}
	
	
	@Override
	public List<FreeboardDto> soltingread(FbParam param) {
		System.out.println("fb서비스 getfbsoltingdate 왔다감");
		return fbDao.soltingread(param);
	}

	@Override
	public List<FreeboardDto> solting_read(FbParam param) {
		System.out.println("fb서비스 getfbsoltingdate 왔다감");
		return fbDao.solting_read(param);
	}
	
	@Override
	public void writedowncomment(CommentDto cmdto) {
		System.out.println("fb서비스 writedowncomment  왔다감");
		System.out.println(cmdto.toString());
		fbDao.writedowncomment(cmdto);	
	}

	@Override
	public List<CommentDto> getcmlist(int seq) {
		System.out.println("fb서비스 getcmlist.do 왔다감");
		return fbDao.getcmList(seq);
	}

	@Override
	public boolean cmdelete(CommentDto cmdto) {
		return fbDao.cmdelete(cmdto);
	}

	@Override
	public void readcountup(int seq) {
		fbDao.readcountup(seq);
	}

	@Override
	public void likeboard(int seq) {
		fbDao.likeboard(seq);
	}

	@Override
	public void likecheck(String email, int seq) {
		fbDao.likecheck(email, seq);
	}

	@Override
	public void addlike(BoardlikeDto likedto) {
		fbDao.addlike(likedto);
	}

	@Override
	public boolean dolikecheck(BoardlikeDto likedto) {
		System.out.println("fb서비스 dolikedto  왔다감");
		boolean like = fbDao.dolikecheck(likedto);
		return like;
	}

	@Override
	public void dellike(BoardlikeDto likedto) {
		fbDao.dellike(likedto);
	}

	@Override
	public void dislikeboard(int seq) {
		fbDao.dislikeboard(seq);
	}

	
   @Override 
   public int getlikecount(BoardlikeDto likedto) { 
	   return fbDao.getlikecount(likedto); 
   }

	@Override
	public boolean docmlikecheck(CommentlikeDto cmlikedto) {
		return fbDao.docmlikecheck(cmlikedto);
	}
	
	@Override
	public void addcmlike(CommentlikeDto cmlikedto) {
		fbDao.addcmlike(cmlikedto);
	}
	
	@Override
	public void delcmlike(CommentlikeDto cmlikedto) {
		fbDao.delcmlike(cmlikedto);
	}

	@Override
	public void cmlikeup(int seq) {
		fbDao.cmlikeup(seq);
	}

	@Override
	public void cmlikedown(int seq) {
		fbDao.cmlikedown(seq);
	}

	@Override
	public CommentDto getcmdetail(int seq) {
		return fbDao.getcmdetail(seq);
	}

	@Override
	public void cmupdate(CommentDto cmdto) {
		System.out.println("fb서비스 cmupdate 왔다감");
		fbDao.cmupdate(cmdto);
		}

	@Override
	public void recommentwrite(CommentDto cmdto) {
		fbDao.recommentupdate(cmdto);
		fbDao.recommentinsert(cmdto);
	}

	@Override
	public int _getlikecount(int seq) {
		return fbDao._getlikecount(seq); 
	}

	@Override
	public int _getcmlikecount(int seq) {
		return fbDao._getcmlikecount(seq); 
	}

	@Override
	public boolean doreportcheck(ReportDto reportdto) {
		System.out.println("fb서비스 dolikedto  왔다감");
		boolean report = fbDao.doreportcheck(reportdto);
		System.out.println("오는가ㅏㅏㅏㅏ");
		return report;
	}

	@Override
	public void reportwritedown(ReportDto reportDto) {
		System.out.println("fb서비스 reportwritedown 왔다감");
		System.out.println(reportDto.toString());
		fbDao.reportwritedown(reportDto);	
	}

	@Override
	public boolean docmreportcheck(CmreportDto cmreportdto) {
		System.out.println("오는가ㅏㅏㅏㅏ");
		boolean cmreport = fbDao.docmreportcheck(cmreportdto);
		System.out.println("오는가ㅏㅏㅏㅏ");
		return cmreport;
	}

	@Override
	public void cmreportwritedown(CmreportDto cmreportDto) {
		System.out.println("fb서비스 cmreportwritedown 왔다감");
		System.out.println(cmreportDto.toString());
		fbDao.cmreportwritedown(cmreportDto);	
	}

	@Override
	public void fbpointup(MemberDto mem) {
		fbDao.fbpointup(mem);
	}

	@Override
	public void cmpointup(MemberDto mem) {
		fbDao.cmpointup(mem);
	}

	@Override
	public List<FreeboardDto> getfbadminList(FbParam param) {
		System.out.println("fb서비스 fbadminlist.do 왔다감");
		return fbDao.getfbadminList(param);
	}

	@Override
	public void Freeboardadmindelete(int seq) {
		System.out.println(seq);
		fbDao.Freeboardadmindelete(seq);
	}

	@Override
	public int getfbadminCount(FbParam param) {
		return fbDao.getfbadminCount(param);	
	}

	/*
	 * @Override public List<ReportDto>ReportDto getadminreport(ReportDto reportdto)
	 * { return fbDao.getadminreport(reportdto); }
	 */

	@Override
	public List<ReportDto> getadminreport(ReportDto reportdto) {
		return fbDao.getadminreport(reportdto);
	}

	@Override
	public boolean admincmdelete(CommentDto cmdto) {
		return fbDao.admincmdelete(cmdto);
	}


	

}
