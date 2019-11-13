package com.petmeeting.joy.store.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author 유림
 * 주문 정보 디테일
 */
public class OrderInfoDto implements Serializable {
	
	private String ordernumber;
	private String email;
	private String rname;
	private String rpostcode;
	private String raddress;
	private String raddress_detail;
	private String rphone;
	private String require;
	private Date orderdate;
	private int status;
	private int refund_status;
	private int totalprice;
	private int use_point;
	private Date refund_date;
	
	private String order_seq;
	private String ordername;		// 마이페이지에서 띄워줄 주문내역 담을 변수
	
	private String productcode;
	private String productname;
	private String filename;
	private int price;
	
	private String psize;
	private String pcolor;
	private int quantity;

	
	public OrderInfoDto() {
	}


	public OrderInfoDto(String ordernumber, String email, String rname, String rpostcode, String raddress,
			String raddress_detail, String rphone, String require, Date orderdate, int status, int refund_status,
			int totalprice, int use_point, Date refund_date, String order_seq, String ordername, String productcode,
			String productname, String filename, int price, String psize, String pcolor, int quantity) {
		super();
		this.ordernumber = ordernumber;
		this.email = email;
		this.rname = rname;
		this.rpostcode = rpostcode;
		this.raddress = raddress;
		this.raddress_detail = raddress_detail;
		this.rphone = rphone;
		this.require = require;
		this.orderdate = orderdate;
		this.status = status;
		this.refund_status = refund_status;
		this.totalprice = totalprice;
		this.use_point = use_point;
		this.refund_date = refund_date;
		this.order_seq = order_seq;
		this.ordername = ordername;
		this.productcode = productcode;
		this.productname = productname;
		this.filename = filename;
		this.price = price;
		this.psize = psize;
		this.pcolor = pcolor;
		this.quantity = quantity;
	}


	public String getOrdernumber() {
		return ordernumber;
	}


	public void setOrdernumber(String ordernumber) {
		this.ordernumber = ordernumber;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getRname() {
		return rname;
	}


	public void setRname(String rname) {
		this.rname = rname;
	}


	public String getRpostcode() {
		return rpostcode;
	}


	public void setRpostcode(String rpostcode) {
		this.rpostcode = rpostcode;
	}


	public String getRaddress() {
		return raddress;
	}


	public void setRaddress(String raddress) {
		this.raddress = raddress;
	}


	public String getRaddress_detail() {
		return raddress_detail;
	}


	public void setRaddress_detail(String raddress_detail) {
		this.raddress_detail = raddress_detail;
	}


	public String getRphone() {
		return rphone;
	}


	public void setRphone(String rphone) {
		this.rphone = rphone;
	}


	public String getRequire() {
		return require;
	}


	public void setRequire(String require) {
		this.require = require;
	}


	public Date getOrderdate() {
		return orderdate;
	}


	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}


	public int getStatus() {
		return status;
	}


	public void setStatus(int status) {
		this.status = status;
	}


	public int getRefund_status() {
		return refund_status;
	}


	public void setRefund_status(int refund_status) {
		this.refund_status = refund_status;
	}


	public int getTotalprice() {
		return totalprice;
	}


	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}


	public int getUse_point() {
		return use_point;
	}


	public void setUse_point(int use_point) {
		this.use_point = use_point;
	}


	public Date getRefund_date() {
		return refund_date;
	}


	public void setRefund_date(Date refund_date) {
		this.refund_date = refund_date;
	}


	public String getOrder_seq() {
		return order_seq;
	}


	public void setOrder_seq(String order_seq) {
		this.order_seq = order_seq;
	}


	public String getOrdername() {
		return ordername;
	}


	public void setOrdername(String ordername) {
		this.ordername = ordername;
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


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
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


	@Override
	public String toString() {
		return "OrderInfoDto [ordernumber=" + ordernumber + ", email=" + email + ", rname=" + rname + ", rpostcode="
				+ rpostcode + ", raddress=" + raddress + ", raddress_detail=" + raddress_detail + ", rphone=" + rphone
				+ ", require=" + require + ", orderdate=" + orderdate + ", status=" + status + ", refund_status="
				+ refund_status + ", totalprice=" + totalprice + ", use_point=" + use_point + ", refund_date="
				+ refund_date + ", order_seq=" + order_seq + ", ordername=" + ordername + ", productcode=" + productcode
				+ ", productname=" + productname + ", filename=" + filename + ", price=" + price + ", psize=" + psize
				+ ", pcolor=" + pcolor + ", quantity=" + quantity + "]";
	}

	

}