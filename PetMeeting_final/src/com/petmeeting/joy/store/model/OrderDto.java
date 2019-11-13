package com.petmeeting.joy.store.model;

import java.io.Serializable;

public class OrderDto implements Serializable {

	private int seq;
	private int product_option_seq;
	private String email;
	private int quantity;
	private int totalprice;
	private String ordernumber;
	private int status;
	private int refund_seq;
	
	private String refund_select;
	
	public OrderDto() {
	}

	public OrderDto(int seq, int product_option_seq, String email, int quantity, int totalprice, String ordernumber,
			int status, int refund_seq, String refund_select) {
		super();
		this.seq = seq;
		this.product_option_seq = product_option_seq;
		this.email = email;
		this.quantity = quantity;
		this.totalprice = totalprice;
		this.ordernumber = ordernumber;
		this.status = status;
		this.refund_seq = refund_seq;
		this.refund_select = refund_select;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getProduct_option_seq() {
		return product_option_seq;
	}

	public void setProduct_option_seq(int product_option_seq) {
		this.product_option_seq = product_option_seq;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getOrdernumber() {
		return ordernumber;
	}

	public void setOrdernumber(String ordernumber) {
		this.ordernumber = ordernumber;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getRefund_seq() {
		return refund_seq;
	}

	public void setRefund_seq(int refund_seq) {
		this.refund_seq = refund_seq;
	}

	public String getRefund_select() {
		return refund_select;
	}

	public void setRefund_select(String refund_select) {
		this.refund_select = refund_select;
	}

	@Override
	public String toString() {
		return "OrderDto [seq=" + seq + ", product_option_seq=" + product_option_seq + ", email=" + email
				+ ", quantity=" + quantity + ", totalprice=" + totalprice + ", ordernumber=" + ordernumber + ", status="
				+ status + ", refund_seq=" + refund_seq + ", refund_select=" + refund_select + "]";
	}



	
}

	