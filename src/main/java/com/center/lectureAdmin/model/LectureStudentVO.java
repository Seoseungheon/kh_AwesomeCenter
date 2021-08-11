package com.center.lectureAdmin.model;

public class LectureStudentVO {
	 
	private String studno;
	private String fk_userno;
	private String gender;
	private String username;
	private String hp1;
	private String hp2;
	private String hp3;
	private String email;
	private String fk_class_seq;
	
	
	public LectureStudentVO() { }
	
	public LectureStudentVO(String studno, String fk_userno, String gender, String username, String hp1, String hp2,
			String hp3, String email, String fk_class_seq) {
		this.studno = studno;
		this.fk_userno = fk_userno;
		this.gender = gender;
		this.username = username;
		this.hp1 = hp1;
		this.hp2 = hp2;
		this.hp3 = hp3;
		this.email = email;
		this.fk_class_seq = fk_class_seq;
	}
	
	
	public String getStudno() {
		return studno;
	}
	public void setStudno(String studno) {
		this.studno = studno;
	}
	public String getFk_userno() {
		return fk_userno;
	}
	public void setFk_userno(String fk_userno) {
		this.fk_userno = fk_userno;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getFk_class_seq() {
		return fk_class_seq;
	}

	public void setFk_class_seq(String fk_class_seq) {
		this.fk_class_seq = fk_class_seq;
	}

	
}

