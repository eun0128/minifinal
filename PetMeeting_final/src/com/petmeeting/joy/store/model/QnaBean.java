package com.petmeeting.joy.store.model;

import java.io.Serializable;
import java.util.Date;

public class QnaBean implements Serializable {
	
	private int q_seq;
	private String productcode;
	private String p_filename;
	private String productname;
	private String email;
	private String nickname;
	private String category;
	private String q_content;
	private Date q_regdate;
	
	private int a_seq;
	private String a_content;
	private Date a_regdate;
	
	public QnaBean() {
	}

	public QnaBean(int q_seq, String productcode, String p_filename, String productname, String email, String nickname,
			String category, String q_content, Date q_regdate, int a_seq, String a_content, Date a_regdate) {
		super();
		this.q_seq = q_seq;
		this.productcode = productcode;
		this.p_filename = p_filename;
		this.productname = productname;
		this.email = email;
		this.nickname = nickname;
		this.category = category;
		this.q_content = q_content;
		this.q_regdate = q_regdate;
		this.a_seq = a_seq;
		this.a_content = a_content;
		this.a_regdate = a_regdate;
	}

	public int getQ_seq() {
		return q_seq;
	}

	public void setQ_seq(int q_seq) {
		this.q_seq = q_seq;
	}

	public String getProductcode() {
		return productcode;
	}

	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}

	public String getP_filename() {
		return p_filename;
	}

	public void setP_filename(String p_filename) {
		this.p_filename = p_filename;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
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

	public String getQ_content() {
		return q_content;
	}

	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}

	public Date getQ_regdate() {
		return q_regdate;
	}

	public void setQ_regdate(Date q_regdate) {
		this.q_regdate = q_regdate;
	}

	public int getA_seq() {
		return a_seq;
	}

	public void setA_seq(int a_seq) {
		this.a_seq = a_seq;
	}

	public String getA_content() {
		return a_content;
	}

	public void setA_content(String a_content) {
		this.a_content = a_content;
	}

	public Date getA_regdate() {
		return a_regdate;
	}

	public void setA_regdate(Date a_regdate) {
		this.a_regdate = a_regdate;
	}

	@Override
	public String toString() {
		return "QnaBean [q_seq=" + q_seq + ", productcode=" + productcode + ", p_filename=" + p_filename
				+ ", productname=" + productname + ", email=" + email + ", nickname=" + nickname + ", category="
				+ category + ", q_content=" + q_content + ", q_regdate=" + q_regdate + ", a_seq=" + a_seq
				+ ", a_content=" + a_content + ", a_regdate=" + a_regdate + "]";
	}

}
