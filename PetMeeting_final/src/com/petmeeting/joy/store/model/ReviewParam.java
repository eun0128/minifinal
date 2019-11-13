package com.petmeeting.joy.store.model;

import java.io.Serializable;

public class ReviewParam implements Serializable{
	
	private String r_sorting;
	private String r_sorting_score;
	private String r_category;
	private String r_keyword;
	
	private int r_pageNumber;
	
	private int start;
	private int end;
	
	private String email;
	private String productcode;
	
	public ReviewParam() {
	}

	public ReviewParam(String r_sorting, String r_sorting_score, String r_category, String r_keyword, int r_pageNumber,
			int start, int end, String email, String productcode) {
		super();
		this.r_sorting = r_sorting;
		this.r_sorting_score = r_sorting_score;
		this.r_category = r_category;
		this.r_keyword = r_keyword;
		this.r_pageNumber = r_pageNumber;
		this.start = start;
		this.end = end;
		this.email = email;
		this.productcode = productcode;
	}

	public String getR_sorting() {
		return r_sorting;
	}

	public void setR_sorting(String r_sorting) {
		this.r_sorting = r_sorting;
	}

	public String getR_sorting_score() {
		return r_sorting_score;
	}

	public void setR_sorting_score(String r_sorting_score) {
		this.r_sorting_score = r_sorting_score;
	}

	public String getR_category() {
		return r_category;
	}

	public void setR_category(String r_category) {
		this.r_category = r_category;
	}

	public String getR_keyword() {
		return r_keyword;
	}

	public void setR_keyword(String r_keyword) {
		this.r_keyword = r_keyword;
	}

	public int getR_pageNumber() {
		return r_pageNumber;
	}

	public void setR_pageNumber(int r_pageNumber) {
		this.r_pageNumber = r_pageNumber;
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

	public String getProductcode() {
		return productcode;
	}

	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}

	@Override
	public String toString() {
		return "ReviewParam [r_sorting=" + r_sorting + ", r_sorting_score=" + r_sorting_score + ", r_category="
				+ r_category + ", r_keyword=" + r_keyword + ", r_pageNumber=" + r_pageNumber + ", start=" + start
				+ ", end=" + end + ", email=" + email + ", productcode=" + productcode + "]";
	}

}
