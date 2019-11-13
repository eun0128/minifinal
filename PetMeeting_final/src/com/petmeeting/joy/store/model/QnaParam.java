package com.petmeeting.joy.store.model;

import java.io.Serializable;

public class QnaParam implements Serializable{
	
	private String q_sorting;
	private String q_sorting_category;
	private String q_sorting_answer;
	private String q_category;
	private String q_keyword;
	
	private int q_pageNumber;
	
	private int start;
	private int end;
	
	private String email;
	private String productcode;
	
	public QnaParam() {
	}

	public QnaParam(String q_sorting, String q_sorting_category, String q_sorting_answer, String q_category,
			String q_keyword, int q_pageNumber, int start, int end, String email, String productcode) {
		super();
		this.q_sorting = q_sorting;
		this.q_sorting_category = q_sorting_category;
		this.q_sorting_answer = q_sorting_answer;
		this.q_category = q_category;
		this.q_keyword = q_keyword;
		this.q_pageNumber = q_pageNumber;
		this.start = start;
		this.end = end;
		this.email = email;
		this.productcode = productcode;
	}

	public String getQ_sorting() {
		return q_sorting;
	}

	public void setQ_sorting(String q_sorting) {
		this.q_sorting = q_sorting;
	}

	public String getQ_sorting_category() {
		return q_sorting_category;
	}

	public void setQ_sorting_category(String q_sorting_category) {
		this.q_sorting_category = q_sorting_category;
	}

	public String getQ_sorting_answer() {
		return q_sorting_answer;
	}

	public void setQ_sorting_answer(String q_sorting_answer) {
		this.q_sorting_answer = q_sorting_answer;
	}

	public String getQ_category() {
		return q_category;
	}

	public void setQ_category(String q_category) {
		this.q_category = q_category;
	}

	public String getQ_keyword() {
		return q_keyword;
	}

	public void setQ_keyword(String q_keyword) {
		this.q_keyword = q_keyword;
	}

	public int getQ_pageNumber() {
		return q_pageNumber;
	}

	public void setQ_pageNumber(int q_pageNumber) {
		this.q_pageNumber = q_pageNumber;
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
		return "QnaParam [q_sorting=" + q_sorting + ", q_sorting_category=" + q_sorting_category + ", q_sorting_answer="
				+ q_sorting_answer + ", q_category=" + q_category + ", q_keyword=" + q_keyword + ", q_pageNumber="
				+ q_pageNumber + ", start=" + start + ", end=" + end + ", email=" + email + ", productcode="
				+ productcode + "]";
	}

}
