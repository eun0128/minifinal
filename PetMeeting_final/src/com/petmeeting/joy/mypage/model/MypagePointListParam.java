package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class MypagePointListParam implements Serializable {

	private String email;
	//private String selection;	//카테고리
	//private String keyword;	//검색어
		
	private int pageNumber = 0; // 현재페이지
	private int recordCountPerPage = 10;  // 표현할 한 페이지의 글 수
	
	//[1] -> DB에서 불러올때 1~10으로 불러오게됨, db 에서 불러와 넘겨줄 변수
	private int start = 1; // 초기값
	private int end = 10; // 초기값
	
	
	public MypagePointListParam() {

	}


	public MypagePointListParam(String email, int pageNumber, int recordCountPerPage, int start, int end) {
		super();
		this.email = email;
		this.pageNumber = pageNumber;
		this.recordCountPerPage = recordCountPerPage;
		this.start = start;
		this.end = end;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public int getPageNumber() {
		return pageNumber;
	}


	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}


	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}


	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}


	public int getStart() {
		return start;
	}


	public void setStart(int start) {
		this.start = start;
	}


	public int getEnd() {
		return end;
	}


	public void setEnd(int end) {
		this.end = end;
	}


	@Override
	public String toString() {
		return "MypagePointListParam [email=" + email + ", pageNumber=" + pageNumber + ", recordCountPerPage="
				+ recordCountPerPage + ", start=" + start + ", end=" + end + "]";
	}
	
	



	
}
