package com.center.member.model;

public class OrderListVO {

	String no;
	String userno_fk;
	String class_seq_fk;
	String status;
	String price;
	String payday;
	String review;
	
	String username; 
	String class_title; 
	String deleteday;
	String orderlistno;
	
	public OrderListVO() {}
	
	
	public OrderListVO(String no, String userno_fk, String class_seq_fk, String status, String price, String payday,
			String username, String class_title, String deleteday, String orderlistno, String review) {
		super();
		this.no = no;
		this.userno_fk = userno_fk;
		this.class_seq_fk = class_seq_fk;
		this.status = status;
		this.price = price;
		this.payday = payday;
		this.username = username;
		this.class_title = class_title;
		this.deleteday = deleteday;
		this.orderlistno = orderlistno;
		this.review = review;
	}


	public String getReview() {
		return review;
	}


	public void setReview(String review) {
		this.review = review;
	}


	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getUserno_fk() {
		return userno_fk;
	}
	public void setUserno_fk(String userno_fk) {
		this.userno_fk = userno_fk;
	}
	public String getClass_seq_fk() {
		return class_seq_fk;
	}
	public void setClass_seq_fk(String class_seq_fk) {
		this.class_seq_fk = class_seq_fk;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getPayday() {
		return payday;
	}
	public void setPayday(String payday) {
		this.payday = payday;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getClass_title() {
		return class_title;
	}
	public void setClass_title(String class_title) {
		this.class_title = class_title;
	}
	public String getDeleteday() {
		return deleteday;
	}
	public void setDeleteday(String deleteday) {
		this.deleteday = deleteday;
	}
	public String getOrderlistno() {
		return orderlistno;
	}
	public void setOrderlistno(String orderlistno) {
		this.orderlistno = orderlistno;
	} 
	
	
	
	
	
	
}
