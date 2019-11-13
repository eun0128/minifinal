package com.petmeeting.joy.store.model;

import java.io.Serializable;


/**
 * @author 유림
 * 주문 시 뿌려주는 데이터를 담아줄 dto
 */
public class OrderBean implements Serializable {

	private int seq;
	private String productcode;
	private String productname;
	private String psize;
	private String pcolor;
	private int quantity;	// 주문수량
	private int totalprice;
	private String filename;

	public OrderBean() {
	}

	public OrderBean(int seq, String productcode, String productname, String psize, String pcolor, int quantity,
			int totalprice, String filename) {
		super();
		this.seq = seq;
		this.productcode = productcode;
		this.productname = productname;
		this.psize = psize;
		this.pcolor = pcolor;
		this.quantity = quantity;
		this.totalprice = totalprice;
		this.filename = filename;
	}
	
	
	
	public OrderBean(int seq, String productcode, String psize, String pcolor, int quantity) {
		super();
		this.seq = seq;
		this.productcode = productcode;
		this.psize = psize;
		this.pcolor = pcolor;
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
	}

	public int getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	@Override
	public String toString() {
		return "OrderBean [seq=" + seq + ", productcode=" + productcode + ", productname=" + productname + ", psize="
				+ psize + ", pcolor=" + pcolor + ", quantity=" + quantity + ", totalprice=" + totalprice + ", filename="
				+ filename + "]";
	}
	
}
	
	