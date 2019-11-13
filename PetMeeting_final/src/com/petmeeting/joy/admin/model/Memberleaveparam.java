package com.petmeeting.joy.admin.model;

import java.io.Serializable;

public class Memberleaveparam implements Serializable {

	
	private String email;
	private String reason;
	
	private String category;
	private String keyword;
	private String search_category;
	
	//페이징을 위해 넣은 부분 
	
	private int pageNumber = 0;
	private int recordCountPerPage = 10;
	
	private int start;
	private int end;
	
	public Memberleaveparam() {
		
	}

	//송혜연이 넣은 전체 생성자
	public Memberleaveparam(String category, String keyword, String search_category,
			int pageNumber, int recordCountPerPage, int start, int end) {
		this.category = category;
		this.keyword = keyword;
		this.search_category = search_category;
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

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
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

	public String getSearch_category() {
		return search_category;
	}

	public void setSearch_category(String search_category) {
		this.search_category = search_category;
	}
	

	//송혜연이 넣은 getter/setter
	
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

	
	public Memberleaveparam(String email, String reason, String category, String keyword, String search_category,
			int start, int end) {
		super();
		this.email = email;
		this.reason = reason;
		this.category = category;
		this.keyword = keyword;
		this.search_category = search_category;
		this.start = start;
		this.end = end;
	}

	public Memberleaveparam(int start, int end) {
		super();
		this.start = start;
		this.end = end;
	}

	//변경 사항 들어가는 toString. 만약 다시 바꿔야하면 다시해야함
	@Override
	public String toString() {
		return "Memberleaveparam [email=" + email + ", reason=" + reason + ", category=" + category + ", keyword="
				+ keyword + ", search_category=" + search_category + ", pageNumber=" + pageNumber
				+ ", recordCountPerPage=" + recordCountPerPage + ", start=" + start + ", end=" + end + "]";
	}
	
	
}
