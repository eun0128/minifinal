package com.petmeeting.joy.store.model;

import java.io.Serializable;
import java.util.Date;

public class AnswerDto implements Serializable {

	private int seq;
	private int question_seq;
	private String content;
	private Date regdate;

	public AnswerDto() {
	}

	public AnswerDto(int seq, int question_seq, String content, Date regdate) {
		super();
		this.seq = seq;
		this.question_seq = question_seq;
		this.content = content;
		this.regdate = regdate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getQuestion_seq() {
		return question_seq;
	}

	public void setQuestion_seq(int question_seq) {
		this.question_seq = question_seq;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "AnswerDto [seq=" + seq + ", question_seq=" + question_seq + ", content=" + content + ", regdate="
				+ regdate + "]";
	}
}
