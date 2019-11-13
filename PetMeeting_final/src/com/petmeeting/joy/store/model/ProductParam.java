package com.petmeeting.joy.store.model;

public class ProductParam {
	
	private String p_sorting;
	private String p_sorting_category;
	private String p_sorting_soldout;
	private String p_keyword;
	
	private int list_count;
	
	private int p_pageNumber;
	private int start;
	private int end;
	
	public ProductParam() {
	}

	public ProductParam(String p_sorting, String p_sorting_category, String p_sorting_soldout, String p_keyword,
			int list_count, int p_pageNumber, int start, int end) {
		super();
		this.p_sorting = p_sorting;
		this.p_sorting_category = p_sorting_category;
		this.p_sorting_soldout = p_sorting_soldout;
		this.p_keyword = p_keyword;
		this.list_count = list_count;
		this.p_pageNumber = p_pageNumber;
		this.start = start;
		this.end = end;
	}

	public String getP_sorting() {
		return p_sorting;
	}

	public void setP_sorting(String p_sorting) {
		this.p_sorting = p_sorting;
	}

	public String getP_sorting_category() {
		return p_sorting_category;
	}

	public void setP_sorting_category(String p_sorting_category) {
		this.p_sorting_category = p_sorting_category;
	}

	public String getP_sorting_soldout() {
		return p_sorting_soldout;
	}

	public void setP_sorting_soldout(String p_sorting_soldout) {
		this.p_sorting_soldout = p_sorting_soldout;
	}

	public String getP_keyword() {
		return p_keyword;
	}

	public void setP_keyword(String p_keyword) {
		this.p_keyword = p_keyword;
	}

	public int getList_count() {
		return list_count;
	}

	public void setList_count(int list_count) {
		this.list_count = list_count;
	}
	
	public int getP_pageNumber() {
		return p_pageNumber;
	}
	
	public void setP_pageNumber(int p_pageNumber) {
		this.p_pageNumber = p_pageNumber;
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
		return "ProductParam [p_sorting=" + p_sorting + ", p_sorting_category=" + p_sorting_category
				+ ", p_sorting_soldout=" + p_sorting_soldout + ", p_keyword=" + p_keyword + ", list_count=" + list_count
				+ ", p_pageNumber=" + p_pageNumber + ", start=" + start + ", end=" + end + "]";
	}

}
