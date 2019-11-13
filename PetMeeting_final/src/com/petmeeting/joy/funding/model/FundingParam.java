package com.petmeeting.joy.funding.model;

import java.io.Serializable;

public class FundingParam implements Serializable{
	
	private String keyword;//검색어
	private String ing_end;// 마감,진행
	private String categorys; //카테고리
	
	
	public FundingParam() {}


	public String getKeyword() {
		return keyword;
	}


	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}


	public String getCategorys() {
		return categorys;
	}


	public void setCategorys(String categorys) {
		this.categorys = categorys;
	}


	
	public String getIng_end() {
		return ing_end;
	}


	public void setIng_end(String ing_end) {
		this.ing_end = ing_end;
	}


	public FundingParam(String keyword, String categorys) {
		super();
		this.keyword = keyword;
		this.categorys = categorys;
	}


	public FundingParam(String keyword, String ing_end, String categorys) {
		super();
		this.keyword = keyword;
		this.ing_end = ing_end;
		this.categorys = categorys;
	}


	@Override
	public String toString() {
		return "FundingParam [keyword=" + keyword + ", ing_end=" + ing_end + ", categorys=" + categorys + "]";
	}
	
}
