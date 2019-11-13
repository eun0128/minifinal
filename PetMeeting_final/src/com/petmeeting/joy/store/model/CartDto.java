package com.petmeeting.joy.store.model;

import java.io.Serializable;

public class CartDto implements Serializable {
	
	private int product_option_seq;
	private String productcode;
	private String productname;
	private String psize;
	private String pcolor;
	private int quantity;
	private int price;
	private int totalprice;
	private String filename;
	
	private boolean soldout;
	
	public CartDto() {
	}

	public CartDto(int product_option_seq, String productcode, String productname, String psize, String pcolor,
			int quantity, int price, int totalprice, String filename, boolean soldout) {
		super();
		this.product_option_seq = product_option_seq;
		this.productcode = productcode;
		this.productname = productname;
		this.psize = psize;
		this.pcolor = pcolor;
		this.quantity = quantity;
		this.price = price;
		this.totalprice = totalprice;
		this.filename = filename;
		this.soldout = soldout;
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

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
		
		this.totalprice = this.quantity * this.price;
	}
	
	public int getTotalprice() {
		return totalprice;
	}
	
	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getProduct_option_seq() {
		return product_option_seq;
	}

	public void setProduct_option_seq(int product_option_seq) {
		this.product_option_seq = product_option_seq;
	}

	public boolean isSoldout() {
		return soldout;
	}

	public void setSoldout(boolean soldout) {
		this.soldout = soldout;
	}

	@Override
	public String toString() {
		return "CartDto [product_option_seq=" + product_option_seq + ", productcode=" + productcode + ", productname="
				+ productname + ", psize=" + psize + ", pcolor=" + pcolor + ", quantity=" + quantity + ", price="
				+ price + ", totalprice=" + totalprice + ", filename=" + filename + ", soldout=" + soldout + "]";
	}

}
