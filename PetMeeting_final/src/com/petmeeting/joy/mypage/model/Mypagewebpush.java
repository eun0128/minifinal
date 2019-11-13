package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class Mypagewebpush implements Serializable {

	
	//카운트
	private int count;
	private String email;
	
	public Mypagewebpush() {
		
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Mypagewebpush(int count, String email) {
		super();
		this.count = count;
		this.email = email;
	}

	@Override
	public String toString() {
		return "Mypagewebpush [count=" + count + ", email=" + email + "]";
	}
	
	
}
