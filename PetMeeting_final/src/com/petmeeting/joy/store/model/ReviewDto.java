package com.petmeeting.joy.store.model;

import java.io.Serializable;
import java.util.Date;

public class ReviewDto implements Serializable {

	private int seq;
	private int order_seq;
	private String productcode;
	private String email;
	private int score;
	private String title;
	private String content;
	private String filename;
	private Date regdate;
	
	public ReviewDto() {
	}

	public ReviewDto(int seq, int order_seq, String productcode, String email, int score, String title,
			String content, String filename, Date regdate) {
		super();
		this.seq = seq;
		this.order_seq = order_seq;
		this.productcode = productcode;
		this.email = email;
		this.score = score;
		this.title = title;
		this.content = content;
		this.filename = filename;
		this.regdate = regdate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getOrder_seq() {
		return order_seq;
	}

	public void setOrder_seq(int order_seq) {
		this.order_seq = order_seq;
	}

	public String getProductcode() {
		return productcode;
	}

	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "StoreReviewDto [seq=" + seq + ", order_seq=" + order_seq + ", productcode=" + productcode + ", email="
				+ email + ", score=" + score + ", title=" + title + ", content=" + content + ", filename=" + filename
				+ ", regdate=" + regdate + "]";
	}

}
