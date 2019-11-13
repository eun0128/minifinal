package com.petmeeting.joy.login.model;

import java.io.Serializable;

public class LoginParam implements Serializable {

	private String email;
	private String ldate;
	private int addpoint;
	
	public LoginParam() {	}
	
	public LoginParam(String email, String ldate) {
		super();
		this.email = email;
		this.ldate = ldate;
	}
	
	public LoginParam(String email, String ldate, int addpoint) {
		super();
		this.email = email;
		this.ldate = ldate;
		this.addpoint = addpoint;
	}
	
	

	public int getAddpoint() {
		return addpoint;
	}

	public void setAddpoint(int addpoint) {
		this.addpoint = addpoint;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLdate() {
		return ldate;
	}

	public void setLdate(String ldate) {
		this.ldate = ldate;
	}

	@Override
	public String toString() {
		return "LoginParam [email=" + email + ", ldate=" + ldate + ", addpoint=" + addpoint + "]";
	}
	
	
	
	
	
}
