package com.center.lectureAdmin.model;

public class LectureWaitingVO {
	
	private String userno_fk;
	private String username;
	private String gender;
	private String hp1;
	private String hp2;
	private String hp3;
	private String reciptday;
	private String classno_fk;
	
	public LectureWaitingVO() {}
	
	public LectureWaitingVO(String userno_fk, String username, String gender, String hp1, String hp2, String hp3,
			String reciptday, String classno_fk) {
		this.userno_fk = userno_fk;
		this.username = username;
		this.gender = gender;
		this.hp1 = hp1;
		this.hp2 = hp2;
		this.hp3 = hp3;
		this.reciptday = reciptday;
		this.classno_fk = classno_fk;
	}
	
	
	public String getUserno_fk() {
		return userno_fk;
	}
	public void setUserno_fk(String userno_fk) {
		this.userno_fk = userno_fk;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getHp1() {
		return hp1;
	}
	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}
	public String getHp2() {
		return hp2;
	}
	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}
	public String getHp3() {
		return hp3;
	}
	public void setHp3(String hp3) {
		this.hp3 = hp3;
	}
	public String getReciptday() {
		return reciptday;
	}
	public void setReciptday(String reciptday) {
		this.reciptday = reciptday;
	}
	
	public String getClassno_fk() {
		return classno_fk;
	}

	public void setClassno_fk(String classno_fk) {
		this.classno_fk = classno_fk;
	}

	
}
