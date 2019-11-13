package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class MypageMsgParam implements Serializable {

	private String email;
	private String selection;
	private String keyword;
	
	private String important;
	private String readcheck;
	
	private int pageNumber = 0;
	private int recordCountPerPage = 10; 
	
	private int start = 1; // 초기값
	private int end = 10; // 초기값
	
	public MypageMsgParam() {

	}


	public MypageMsgParam(String email, String selection, String keyword, int pageNumber, int recordCountPerPage,
			int start, int end) {
		super();
		this.email = email;
		this.selection = selection;
		this.keyword = keyword;
		this.pageNumber = pageNumber;
		this.recordCountPerPage = recordCountPerPage;
		this.start = start;
		this.end = end;
	}


	public MypageMsgParam(String email, String selection, String keyword, String important, String readcheck, int pageNumber,
			int recordCountPerPage, int start, int end) {
		super();
		this.email = email;
		this.selection = selection;
		this.keyword = keyword;
		this.important = important;
		this.readcheck = readcheck;
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

	public String getSelection() {
		return selection;
	}

	public void setSelection(String selection) {
		this.selection = selection;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
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

	public String getImportant() {
		return important;
	}

	public void setImportant(String important) {
		this.important = important;
	}

	public String getReadcheck() {
		return readcheck;
	}

	public void setReadcheck(String readcheck) {
		this.readcheck = readcheck;
	}

	@Override
	public String toString() {
		return "SearchParam [email=" + email + ", selection=" + selection + ", keyword=" + keyword + ", important="
				+ important + ", readcheck=" + readcheck + ", pageNumber=" + pageNumber + ", recordCountPerPage="
				+ recordCountPerPage + ", start=" + start + ", end=" + end + "]";
	}



	
}
