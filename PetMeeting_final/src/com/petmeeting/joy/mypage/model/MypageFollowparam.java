package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class MypageFollowparam implements Serializable {

	
	//나의 이메일
	private String myemail;
	
	
   private String s_category;
   private String s_keyword;
	
	
	private int start=1;
	private int end=6;
	
	public MypageFollowparam() {
		
	}

	public String getMyemail() {
		return myemail;
	}

	public void setMyemail(String myemail) {
		this.myemail = myemail;
	}

	public String getS_category() {
		return s_category;
	}

	public void setS_category(String s_category) {
		this.s_category = s_category;
	}

	public String getS_keyword() {
		return s_keyword;
	}

	public void setS_keyword(String s_keyword) {
		this.s_keyword = s_keyword;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public MypageFollowparam(String myemail, String s_category, String s_keyword, int start, int end) {
		super();
		this.myemail = myemail;
		this.s_category = s_category;
		this.s_keyword = s_keyword;
		this.start = start;
		this.end = end;
	}

	@Override
	public String toString() {
		return "MypageFollowparam [myemail=" + myemail + ", s_category=" + s_category + ", s_keyword=" + s_keyword
				+ ", start=" + start + ", end=" + end + "]";
	}


	
}
