package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class MypageMemberleave implements Serializable {

	
	private String email;
	private String reason;
	
	public MypageMemberleave() {
		
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	@Override
	public String toString() {
		return "MypageMemberleave [email=" + email + ", reason=" + reason + "]";
	}

	public MypageMemberleave(String email, String reason) {
		super();
		this.email = email;
		this.reason = reason;
	}
	
	
	
	
}
