package com.petmeeting.joy.store.model;

import java.io.Serializable;
import java.util.Date;

public class RefundDto implements Serializable{
	
	private int seq;				// 반품 시퀀스
	private String email;			
	private int order_seq;			// 주문 시퀀스
	private String refund_select;	// 반품 or 교환
	private String reason;			// 반품 사유
	private String reason_detail;	// 디테일 사유
	private String filename;
	private Date refund_date;
	
	private String ordernumber;
	private String rname;
	private String ordername;		
	
	private String productname;
	private int status;
	private int refund_seq;
	
	public RefundDto() {
	}

	public RefundDto(int seq, String email, int order_seq, String refund_select, String reason, String reason_detail,
			String filename, Date refund_date, String ordernumber, String rname, String ordername, String productname,
			int status, int refund_seq) {
		super();
		this.seq = seq;
		this.email = email;
		this.order_seq = order_seq;
		this.refund_select = refund_select;
		this.reason = reason;
		this.reason_detail = reason_detail;
		this.filename = filename;
		this.refund_date = refund_date;
		this.ordernumber = ordernumber;
		this.rname = rname;
		this.ordername = ordername;
		this.productname = productname;
		this.status = status;
		this.refund_seq = refund_seq;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getOrder_seq() {
		return order_seq;
	}

	public void setOrder_seq(int order_seq) {
		this.order_seq = order_seq;
	}

	public String getRefund_select() {
		return refund_select;
	}

	public void setRefund_select(String refund_select) {
		this.refund_select = refund_select;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getReason_detail() {
		return reason_detail;
	}

	public void setReason_detail(String reason_detail) {
		this.reason_detail = reason_detail;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public Date getRefund_date() {
		return refund_date;
	}

	public void setRefund_date(Date refund_date) {
		this.refund_date = refund_date;
	}

	public String getOrdernumber() {
		return ordernumber;
	}

	public void setOrdernumber(String ordernumber) {
		this.ordernumber = ordernumber;
	}

	public String getRname() {
		return rname;
	}

	public void setRname(String rname) {
		this.rname = rname;
	}

	public String getOrdername() {
		return ordername;
	}

	public void setOrdername(String ordername) {
		this.ordername = ordername;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
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

	@Override
	public String toString() {
		return "RefundDto [seq=" + seq + ", email=" + email + ", order_seq=" + order_seq + ", refund_select="
				+ refund_select + ", reason=" + reason + ", reason_detail=" + reason_detail + ", filename=" + filename
				+ ", refund_date=" + refund_date + ", ordernumber=" + ordernumber + ", rname=" + rname + ", ordername="
				+ ordername + ", productname=" + productname + ", status=" + status + ", refund_seq=" + refund_seq
				+ "]";
	}


	



}
