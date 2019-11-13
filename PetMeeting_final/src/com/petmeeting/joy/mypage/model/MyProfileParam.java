package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class MyProfileParam implements Serializable {
	
	private String email;
	private String nickname;
	private String myprofile_img;
	private int myage;
	private int mysex;
	private String myintro;
	
	public MyProfileParam() { }

	public MyProfileParam(String email, String nickname, String myprofile_img, int myage, int mysex, String myintro) {
		super();
		this.email = email;
		this.nickname = nickname;
		this.myprofile_img = myprofile_img;
		this.myage = myage;
		this.mysex = mysex;
		this.myintro = myintro;
	}
	
	

	public MyProfileParam(String email, String nickname, int myage, int mysex, String myintro) {
		super();
		this.email = email;
		this.nickname = nickname;
		this.myage = myage;
		this.mysex = mysex;
		this.myintro = myintro;
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

	public int getMyage() {
		return myage;
	}

	public void setMyage(int myage) {
		this.myage = myage;
	}

	public int getMysex() {
		return mysex;
	}

	public void setMysex(int mysex) {
		this.mysex = mysex;
	}

	public String getMyintro() {
		return myintro;
	}

	public void setMyintro(String myintro) {
		this.myintro = myintro;
	}

	@Override
	public String toString() {
		return "MyProfileParam [email=" + email + ", nickname=" + nickname + ", myprofile_img=" + myprofile_img
				+ ", myage=" + myage + ", mysex=" + mysex + ", myintro=" + myintro + "]";
	}
	
	

	
	
	

}
