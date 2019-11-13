package com.petmeeting.joy.store.model;

import java.io.Serializable;

public class SalesDto implements Serializable {
	
	private String month;
	private String productcode;
	private String productname;
	private String category;
	
	private int sales;
	
	public SalesDto() {
	}
	
	public SalesDto(String month, String productcode, String productname, String category, int sales) {
		super();
		this.month = month;
		this.productcode = productcode;
		this.productname = productname;
		this.category = category;
		this.sales = sales;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getProductcode() {
		return productcode;
	}

	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getSales() {
		return sales;
	}

	public void setSales(int sales) {
		this.sales = sales;
	}

	@Override
	public String toString() {
		return "SalesDto [month=" + month + ", productcode=" + productcode + ", productname=" + productname
				+ ", category=" + category + ", sales=" + sales + "]";
	}
	
}
