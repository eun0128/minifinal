package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class MypageListParam implements Serializable {

	private String email;
	private String selection;
	private String keyword;
	
	private String category;
	private String expired;
	
	private String play;
	
	public MypageListParam() {

	}

	
	//fundinglist 뽑는 생성자
	public MypageListParam(String email, String keyword, String expired) {
		
		this.email = email;
		this.keyword = keyword;
		this.expired = expired;
	}


	//playlist 뽑는 생성자
	public MypageListParam(String email, String selection, String keyword, String category, String expired,
			String play) {
	
		this.email = email;
		this.selection = selection;
		this.keyword = keyword;
		this.category = category;
		this.expired = expired;
		this.play = play;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getSelection() {
		return selection;
	}


	public void setSelection(String selection) {
		this.selection = selection;
	}


	public String getKeyword() {
		return keyword;
	}


	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public String getExpired() {
		return expired;
	}


	public void setExpired(String expired) {
		this.expired = expired;
	}


	public String getPlay() {
		return play;
	}


	public void setPlay(String play) {
		this.play = play;
	}


	@Override
	public String toString() {
		return "MypageListParam [email=" + email + ", selection=" + selection + ", keyword=" + keyword + ", category="
				+ category + ", expired=" + expired + ", play=" + play + "]";
	}



	
}
