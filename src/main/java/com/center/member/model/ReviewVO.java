package com.center.member.model;

public class ReviewVO {
	
	String reviewno;
	String fk_userno;
	String fk_class_seq;
	String subject;
	String content;
	String wdate;
	String wstatus;
	
	
	
	public String getWstatus() {
		return wstatus;
	}
	public void setWstatus(String wstatus) {
		this.wstatus = wstatus;
	}
	public String getReviewno() {
		return reviewno;
	}
	public void setReviewno(String reviewno) {
		this.reviewno = reviewno;
	}
	public String getFk_userno() {
		return fk_userno;
	}
	public void setFk_userno(String fk_userno) {
		this.fk_userno = fk_userno;
	}
	public String getFk_class_seq() {
		return fk_class_seq;
	}
	public void setFk_class_seq(String fk_class_seq) {
		this.fk_class_seq = fk_class_seq;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	


}
