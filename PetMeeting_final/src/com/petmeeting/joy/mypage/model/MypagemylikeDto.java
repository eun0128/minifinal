package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class MypagemylikeDto implements Serializable {

	
	private String email;
	private String category;
	private String selection;
	private String keyword;
	
	
	public MypagemylikeDto() {
		
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
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


	public MypagemylikeDto(String email, String category, String selection, String keyword) {
		super();
		this.email = email;
		this.category = category;
		this.selection = selection;
		this.keyword = keyword;
	}


	@Override
	public String toString() {
		return "MypagemylikeDto [email=" + email + ", category=" + category + ", selection=" + selection + ", keyword="
				+ keyword + "]";
	}
	
	
}
