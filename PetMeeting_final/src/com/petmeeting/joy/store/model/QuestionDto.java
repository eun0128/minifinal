package com.petmeeting.joy.store.model;

import java.io.Serializable;

public class QuestionDto implements Serializable {

	private int seq;
	private String productcode;
	private String email;
	private String nickname;
	private String category;
	private String content;
	private String regdate;
	
	public QuestionDto() {
	}

	public QuestionDto(int seq, String productcode, String email, String nickname, String category,
			String content, String regdate) {
		super();
		this.seq = seq;
		this.productcode = productcode;
		this.email = email;
		this.nickname = nickname;
		this.category = category;
		this.content = content;
		this.regdate = regdate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
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
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}


	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "QuestionDto [seq=" + seq + ", productcode=" + productcode + ", email=" + email + ", nickname=" + nickname + ", category=" + category + ", content="
				+ content + ", regdate=" + regdate + "]";
	}

}
