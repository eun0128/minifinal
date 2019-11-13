package com.petmeeting.joy.store.model;

import java.io.Serializable;

/**
 * 페이징 및 주문 기간 별 조회용
 */
public class OrderParam implements Serializable {
	/**
	 * 경고 지워주기
	 */
	private static final long serialVersionUID = 1L;
	
	private String startdate;		// 조회 시작일
	private String enddate;		// 조회 마지막일
	
	private int pageNumber = 0;			
	private int recordCountPerPage = 5;  // 페이지 당 글 수
	
	private int start; 
	private int end;
	
	private String email;
	
	private int status = -1;
	
	private String sorting_category;
	private String search_category;
	private String s_keyword;
	
	public OrderParam() {
	}

	public OrderParam(String startdate, String enddate, int pageNumber, int recordCountPerPage, int start, int end,
			String email, int status, String sorting_category, String search_category, String s_keyword) {
		super();
		this.startdate = startdate;
		this.enddate = enddate;
		this.pageNumber = pageNumber;
		this.recordCountPerPage = recordCountPerPage;
		this.start = start;
		this.end = end;
		this.email = email;
		this.status = status;
		this.sorting_category = sorting_category;
		this.search_category = search_category;
		this.s_keyword = s_keyword;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getSorting_category() {
		return sorting_category;
	}

	public void setSorting_category(String sorting_category) {
		this.sorting_category = sorting_category;
	}

	public String getSearch_category() {
		return search_category;
	}

	public void setSearch_category(String search_category) {
		this.search_category = search_category;
	}

	public String getS_keyword() {
		return s_keyword;
	}

	public void setS_keyword(String s_keyword) {
		this.s_keyword = s_keyword;
	}


	@Override
	public String toString() {
		return "OrderParam [startdate=" + startdate + ", enddate=" + enddate + ", pageNumber=" + pageNumber
				+ ", recordCountPerPage=" + recordCountPerPage + ", start=" + start + ", end=" + end + ", email="
				+ email + ", status=" + status + ", sorting_category=" + sorting_category + ", search_category="
				+ search_category + ", s_keyword=" + s_keyword + "]";
	}

	


}

