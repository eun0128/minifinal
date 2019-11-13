package com.petmeeting.joy.store.model;

import java.io.Serializable;

public class ProductOptionDto implements Serializable {

	private int seq;
	private String productcode;
	private String psize;
	private String pcolor;
	private int pquantity;	// 총수량
	private int quantity;	// 주문수량
	
	public ProductOptionDto() {
	}

	public ProductOptionDto(int seq, String productcode, String psize, String pcolor, int pquantity) {
		super();
		this.seq = seq;
		this.productcode = productcode;
		this.psize = psize;
		this.pcolor = pcolor;
		this.pquantity = pquantity;
	}
	
	

	public ProductOptionDto(int seq, String productcode, String psize, String pcolor, int pquantity, int quantity) {
		super();
		this.seq = seq;
		this.productcode = productcode;
		this.psize = psize;
		this.pcolor = pcolor;
		this.pquantity = pquantity;
		this.quantity = quantity;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getProductcode() {
		return productcode;
	}

	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}

	public String getPsize() {
		return psize;
	}

	public void setPsize(String psize) {
		this.psize = psize;
	}

	public String getPcolor() {
		return pcolor;
	}

	public void setPcolor(String pcolor) {
		this.pcolor = pcolor;
	}

	public int getPquantity() {
		return pquantity;
	}

	public void setPquantity(int pquantity) {
		this.pquantity = pquantity;
	}
	
	

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "ProductOptionDto [seq=" + seq + ", productcode=" + productcode + ", psize=" + psize + ", pcolor="
				+ pcolor + ", pquantity=" + pquantity + ", quantity=" + quantity + "]";
	}
	
}
