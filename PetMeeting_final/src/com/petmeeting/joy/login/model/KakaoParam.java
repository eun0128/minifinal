package com.petmeeting.joy.login.model;

public class KakaoParam {

	private String kakaouserid;
	private String email;
	private String nickname;
	private String myprofile_img;
	private String accessToken;
	
	
	public KakaoParam() {
		// TODO Auto-generated constructor stub
	}
	
	public KakaoParam(String kakaouserid, String email, String nickname, String myprofile_img, String accessToken) {
		super();
		this.kakaouserid =  kakaouserid;
		this.email = email;
		this.nickname = nickname;
		this.myprofile_img = myprofile_img;
		this.accessToken = accessToken;
	}
	
	public KakaoParam(String email, String myprofile_img) {
		super();
		this.email = email;
		this.myprofile_img = myprofile_img;
	}
	
	

	public String getKakaouserid() {
		return kakaouserid;
	}

	public void setKakaouserid(String kakaouserid) {
		this.kakaouserid = kakaouserid;
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
	

	public String getAccessToken() {
		return accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

	@Override
	public String toString() {
		return "KakaoParam [kakaouserid=" + kakaouserid + ", email=" + email + ", nickname=" + nickname
				+ ", myprofile_img=" + myprofile_img + ", accessToken=" + accessToken + "]";
	}

}
