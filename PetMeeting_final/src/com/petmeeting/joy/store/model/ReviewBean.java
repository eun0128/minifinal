package com.petmeeting.joy.store.model;

import java.io.Serializable;
import java.util.Date;

public class ReviewBean implements Serializable {
	
	private int seq;
	private String productcode;
	private String p_filename;
	private String productname;
	private String psize;
	private String pcolor;
	
	private String email;
	private String nickname;
	
	private int score;
	private String title;
	private String content;
	private String filename;
	private Date regdate;
	
	public ReviewBean() {
	}

	public ReviewBean(int seq, String productcode, String p_filename, String productname, String psize, String pcolor,
			String email, String nickname, int score, String title, String content, String filename, Date regdate) {
		super();
		this.seq = seq;
		this.productcode = productcode;
		this.p_filename = p_filename;
		this.productname = productname;
		this.psize = psize;
		this.pcolor = pcolor;
		this.email = email;
		this.nickname = nickname;
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

	public String getPsize() {
		return psize;
	}

	public void setPsize(String psize) {
		this.psize = psize;
	}

	public String getPcolor() {
		return pcolor;
	}

	public void setPcolor(String pcolor) {
		this.pcolor = pcolor;
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
		return "ReviewBean [seq=" + seq + ", productcode=" + productcode + ", p_filename=" + p_filename
				+ ", productname=" + productname + ", psize=" + psize + ", pcolor=" + pcolor + ", email=" + email
				+ ", nickname=" + nickname + ", score=" + score + ", title=" + title + ", content=" + content
				+ ", filename=" + filename + ", regdate=" + regdate + "]";
	}
	
}
