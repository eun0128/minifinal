package com.petmeeting.joy.freeboard.dao;

import java.util.List;

import com.petmeeting.joy.freeboard.model.BoardlikeDto;
import com.petmeeting.joy.freeboard.model.CmreportDto;
import com.petmeeting.joy.freeboard.model.CommentDto;
import com.petmeeting.joy.freeboard.model.CommentlikeDto;
import com.petmeeting.joy.freeboard.model.FbParam;
import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.freeboard.model.ReportDto;
import com.petmeeting.joy.login.model.MemberDto;


public interface FreeboardDao {

	public void fbwritedown(FreeboardDto fb);

	public List<FreeboardDto> getfbList(FbParam param);

	public FreeboardDto getdetail(int seq);

	public void fbupdate(FreeboardDto fb);

	public boolean fbdelete(int seq);

	public int getfbCount(FbParam param);

	public List<FreeboardDto> soltingfree(FbParam param);

	public List<FreeboardDto> soltingmiss(FbParam param);

	public List<FreeboardDto> soltinginfor(FbParam param);

	public List<FreeboardDto> soltingqna(FbParam param);

	public List<FreeboardDto> soltingboast(FbParam param);

	public List<FreeboardDto> soltingdate(FbParam param);

	public List<FreeboardDto> soltinglike(FbParam param);

	public List<FreeboardDto> solting_date(FbParam param);

	public List<FreeboardDto> solting_like(FbParam param);

	public List<FreeboardDto> soltingread(FbParam param);
	
	public List<FreeboardDto> solting_read(FbParam param);
	
	public void writedowncomment(CommentDto cmdto);

	public List<CommentDto> getcmList(int seq);

	public boolean cmdelete(CommentDto cmdto);

	public void readcountup(int seq);

	public void likeboard(int seq);

	public void likecheck(String email, int seq);

	public void addlike(BoardlikeDto likedto);

	public boolean dolikecheck(BoardlikeDto likedto);

	public void dellike(BoardlikeDto likedto);

	public void dislikeboard(int seq);

	public int getlikecount(BoardlikeDto likedto);

	public boolean docmlikecheck(CommentlikeDto cmlikedto);

	public void addcmlike(CommentlikeDto cmlikedto);

	public void delcmlike(CommentlikeDto cmlikedto);

	public void cmlikeup(int seq);

	public void cmlikedown(int seq);

	public CommentDto getcmdetail(int seq);

	public void cmupdate(CommentDto cmdto);

	public void recommentupdate(CommentDto cmdto);

	public void recommentinsert(CommentDto cmdto);

	public int _getlikecount(int seq);

	public int _getcmlikecount(int seq);

	public boolean doreportcheck(ReportDto reportdto);

	public void reportwritedown(ReportDto reportDto);

	public boolean docmreportcheck(CmreportDto cmrdto);

	public void cmreportwritedown(CmreportDto cmreportDto);

	public void fbpointup(MemberDto mem);

	public void cmpointup(MemberDto mem);

	public List<FreeboardDto> getfbadminList(FbParam param);

	public void Freeboardadmindelete(int seq);

	public int getfbadminCount(FbParam param);

	public List<ReportDto> getadminreport(ReportDto reportdto);

	public boolean admincmdelete(CommentDto cmdto);


	
	
}
