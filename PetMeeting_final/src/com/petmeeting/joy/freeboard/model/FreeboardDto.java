package com.petmeeting.joy.freeboard.model;

import java.io.Serializable;

public class FreeboardDto implements Serializable {

	
	private String board_code;
	private int seq;
	private String email;
	private String nickname;
	private String myprofile_img;
	private String filename;
	private String category;
	private String title;
	private String content;
	private int readcount;
	private int likecount;
	private int reportcount;
	private int countreply;
	private String regdate;
	private int del;

	
	 	
	public FreeboardDto() {
		
	}



	public FreeboardDto(String board_code, int seq, String email, String nickname, String myprofile_img,
			String filename, String category, String title, String content, int readcount, int likecount,
			int reportcount, int countreply, String regdate, int del) {
		super();
		this.board_code = board_code;
		this.seq = seq;
		this.email = email;
		this.nickname = nickname;
		this.myprofile_img = myprofile_img;
		this.filename = filename;
		this.category = category;
		this.title = title;
		this.content = content;
		this.readcount = readcount;
		this.likecount = likecount;
		this.reportcount = reportcount;
		this.countreply = countreply;
		this.regdate = regdate;
		this.del = del;
	}



	public String getBoard_code() {
		return board_code;
	}



	public void setBoard_code(String board_code) {
		this.board_code = board_code;
	}



	public int getSeq() {
		return seq;
	}



	public void setSeq(int seq) {
		this.seq = seq;
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



	public String getMyprofile_img() {
		return myprofile_img;
	}



	public void setMyprofile_img(String myprofile_img) {
		this.myprofile_img = myprofile_img;
	}



	public String getFilename() {
		return filename;
	}



	public void setFilename(String filename) {
		this.filename = filename;
	}



	public String getCategory() {
		return category;
	}



	public void setCategory(String category) {
		this.category = category;
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



	public int getReadcount() {
		return readcount;
	}



	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}



	public int getLikecount() {
		return likecount;
	}



	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}



	public int getReportcount() {
		return reportcount;
	}



	public void setReportcount(int reportcount) {
		this.reportcount = reportcount;
	}



	public int getCountreply() {
		return countreply;
	}



	public void setCountreply(int countreply) {
		this.countreply = countreply;
	}



	public String getRegdate() {
		return regdate;
	}



	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}



	public int getDel() {
		return del;
	}



	public void setDel(int del) {
		this.del = del;
	}



	@Override
	public String toString() {
		return "FreeboardDto [board_code=" + board_code + ", seq=" + seq + ", email=" + email + ", nickname=" + nickname
				+ ", myprofile_img=" + myprofile_img + ", filename=" + filename + ", category=" + category + ", title="
				+ title + ", content=" + content + ", readcount=" + readcount + ", likecount=" + likecount
				+ ", reportcount=" + reportcount + ", countreply=" + countreply + ", regdate=" + regdate + ", del="
				+ del + "]";
	}








	
	
}
