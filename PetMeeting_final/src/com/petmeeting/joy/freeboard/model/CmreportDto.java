package com.petmeeting.joy.freeboard.model;

import java.io.Serializable;

public class CmreportDto implements Serializable  {

   private int seq;
   private int comment_seq;
   private String board_code;
   private int board_seq;
   private String email;
   private String nickname;
   private String reason;
   private String reasonTxt;
	
	public CmreportDto() {
		// TODO Auto-generated constructor stub
	}

	public CmreportDto(int seq, int comment_seq, String board_code, int board_seq, String email, String nickname,
			String reason, String reasonTxt) {
		super();
		this.seq = seq;
		this.comment_seq = comment_seq;
		this.board_code = board_code;
		this.board_seq = board_seq;
		this.email = email;
		this.nickname = nickname;
		this.reason = reason;
		this.reasonTxt = reasonTxt;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getComment_seq() {
		return comment_seq;
	}

	public void setComment_seq(int comment_seq) {
		this.comment_seq = comment_seq;
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

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getReasonTxt() {
		return reasonTxt;
	}

	public void setReasonTxt(String reasonTxt) {
		this.reasonTxt = reasonTxt;
	}

	@Override
	public String toString() {
		return "CmreportDto [seq=" + seq + ", comment_seq=" + comment_seq + ", board_code=" + board_code
				+ ", board_seq=" + board_seq + ", email=" + email + ", nickname=" + nickname + ", reason=" + reason
				+ ", reasonTxt=" + reasonTxt + "]";
	}

	
}
