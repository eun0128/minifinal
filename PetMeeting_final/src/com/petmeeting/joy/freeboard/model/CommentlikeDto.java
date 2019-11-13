package com.petmeeting.joy.freeboard.model;

public class CommentlikeDto {

	private int seq;
	private String board_code;
	private int board_seq;
	private String email;
	
	public CommentlikeDto() {
		// TODO Auto-generated constructor stub
	}
	
	public CommentlikeDto(int seq, String board_code, int board_seq, String email) {
		super();
		this.seq = seq;
		this.board_code = board_code;
		this.board_seq = board_seq;
		this.email = email;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "commentlikeDto [seq=" + seq + ", board_code=" + board_code + ", board_seq=" + board_seq + ", email="
				+ email + "]";
	}
	
	
	
	
}
