package com.petmeeting.joy.freeboard.model;

import java.io.Serializable;

public class CommentDto implements Serializable{

	private int seq;
	private String board_code;
	private int board_seq;
	private int ref;
	private int step;
	private int depth;
	private String email;
	private String nickname;
	private String myprofile_img;
	private String filename;
	private String content;
	private int likecount;
	private int reportcount;
	private String regdate;
	private int del;
	
	public CommentDto() {
		
	}

	public CommentDto(int seq, String board_code, int board_seq, int ref, int step, int depth, String email,
			String nickname, String myprofile_img, String filename, String content, int likecount, int reportcount,
			String regdate, int del) {
		super();
		this.seq = seq;
		this.board_code = board_code;
		this.board_seq = board_seq;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.email = email;
		this.nickname = nickname;
		this.myprofile_img = myprofile_img;
		this.filename = filename;
		this.content = content;
		this.likecount = likecount;
		this.reportcount = reportcount;
		this.regdate = regdate;
		this.del = del;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getBoard_code() {
		return board_code;
	}

	public void setBoard_code(String board_code) {
		this.board_code = board_code;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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
		return "CommentDto [seq=" + seq + ", board_code=" + board_code + ", board_seq=" + board_seq + ", ref=" + ref
				+ ", step=" + step + ", depth=" + depth + ", email=" + email + ", nickname=" + nickname
				+ ", myprofile_img=" + myprofile_img + ", filename=" + filename + ", content=" + content
				+ ", likecount=" + likecount + ", reportcount=" + reportcount + ", regdate=" + regdate + ", del=" + del
				+ "]";
	}

	
	
	
	
}
