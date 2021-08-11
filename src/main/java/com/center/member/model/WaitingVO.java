package com.center.member.model;

public class WaitingVO {
	
	String seq;
	String userno_fk;
	String classno_fk;
	String reciptday;
	String rnum;
	String status;
	
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getUserno_fk() {
		return userno_fk;
	}
	public void setUserno_fk(String userno_fk) {
		this.userno_fk = userno_fk;
	}
	public String getClassno_fk() {
		return classno_fk;
	}
	public void setClassno_fk(String classno_fk) {
		this.classno_fk = classno_fk;
	}
	public String getReciptday() {
		return reciptday;
	}
	public void setReciptday(String reciptday) {
		this.reciptday = reciptday;
	}
	
	

}
