package com.petmeeting.joy.store.model;

import java.io.Serializable;
import java.util.Date;

public class ProductDto implements Serializable {
	
	private String productcode;
	private String productname;
	private String category;
	private int price;
	private String filename;
	private String content;
	private Date regdate;
	private int quantity;
	
	private boolean soldout;
	private int recommend;
	 
	public ProductDto() {
	}

	public ProductDto(String productcode, String productname, String category, int price, String filename,
			String content, Date regdate, int quantity, boolean soldout, int recommend) {
		super();
		this.productcode = productcode;
		this.productname = productname;
		this.category = category;
		this.price = price;
		this.filename = filename;
		this.content = content;
		this.regdate = regdate;
		this.quantity = quantity;
		this.soldout = soldout;
		this.recommend = recommend;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
		
		if(quantity <= 0) {
			this.soldout = true;
		}else if(quantity > 0) {
			this.soldout = false;
		}
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public boolean isSoldout() {
		return soldout;
	}

	@Override
	public String toString() {
		return "ProductDto [productcode=" + productcode + ", productname=" + productname + ", category=" + category
				+ ", price=" + price + ", filename=" + filename + ", content=" + content + ", regdate=" + regdate
				+ ", quantity=" + quantity + ", soldout=" + soldout + ", recommend=" + recommend + "]";
	}

}
