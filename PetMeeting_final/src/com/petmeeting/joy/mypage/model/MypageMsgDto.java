package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class MypageMsgDto implements Serializable {

	private int seq;
	
	private String to_email;
	private String from_email;
	
	private String nickname;
	
	private String content;
	private String senddate;
	private String readdate;
	
	private int important; //0 보통 1 중요
	private int readcheck; //0 안읽음 1 읽음
	
	public MypageMsgDto() {

	}


	
	public MypageMsgDto(int seq, String to_email, String from_email, String nickname, String content, String senddate,
			String readdate, int important, int readcheck) {
		super();
		this.seq = seq;
		this.to_email = to_email;
		this.from_email = from_email;
		this.nickname = nickname;
		this.content = content;
		this.senddate = senddate;
		this.readdate = readdate;
		this.important = important;
		this.readcheck = readcheck;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTo_email() {
		return to_email;
	}

	public void setTo_email(String to_email) {
		this.to_email = to_email;
	}

	public String getFrom_email() {
		return from_email;
	}

	public void setFrom_email(String from_email) {
		this.from_email = from_email;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSenddate() {
		return senddate;
	}

	public void setSenddate(String senddate) {
		this.senddate = senddate;
	}

	public String getReaddate() {
		return readdate;
	}

	public void setReaddate(String readdate) {
		this.readdate = readdate;
	}

	public int getImportant() {
		return important;
	}

	public void setImportant(int important) {
		this.important = important;
	}

	public int getReadcheck() {
		return readcheck;
	}

	public void setReadcheck(int readcheck) {
		this.readcheck = readcheck;
	}

	
	public String getNickname() {
		return nickname;
	}



	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


	@Override
	public String toString() {
		return "MypageMsgDto [seq=" + seq + ", to_email=" + to_email + ", from_email=" + from_email + ", nickname="
				+ nickname + ", content=" + content + ", senddate=" + senddate + ", readdate=" + readdate
				+ ", important=" + important + ", readcheck=" + readcheck + "]";
	}


	

	
}
