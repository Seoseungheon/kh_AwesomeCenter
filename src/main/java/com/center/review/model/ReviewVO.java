package com.center.review.model;

public class ReviewVO {
	
	private String reviewno;
	private String userno;
	private String username;
	private String class_seq;
	private String class_semester;
	private String class_title;
	private String teacher_name;
	private String subject;
	private String content;
	private String imgfilename;
	private String orgfilename;
	private String wdate;
	private String readcount;
	private String commentCount;
	

	public ReviewVO() {}
	
	public ReviewVO(String reviewno, String username, String class_seq, String class_semester, String class_title, String teacher_name, String subject,
			String content, String imgfilename,String orgfilename, String wdate, String readcount) {
		super();
		this.reviewno = reviewno;
		this.username = username;
		this.class_seq = class_seq;
		this.class_semester = class_semester;
		this.class_title = class_title;
		this.teacher_name = teacher_name;
		this.subject = subject;
		this.content = content;
		this.imgfilename = imgfilename;
		this.orgfilename = orgfilename;
		this.wdate = wdate;
		this.readcount = readcount;
	}

	public String getReviewno() {
		return reviewno;
	}

	public void setReviewno(String reviewno) {
		this.reviewno = reviewno;
	}

	
	public String getUserno() {
		return userno;
	}

	public void setUserno(String userno) {
		this.userno = userno;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getClass_seq() {
		return class_seq;
	}

	public void setClass_seq(String class_seq) {
		this.class_seq = class_seq;
	}

	public String getClass_semester() {
		return class_semester;
	}

	public void setClass_semester(String class_semester) {
		this.class_semester = class_semester;
	}

	public String getClass_title() {
		return class_title;
	}

	public void setClass_title(String class_title) {
		this.class_title = class_title;
	}

	
	public String getTeacher_name() {
		return teacher_name;
	}

	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
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

	public String getImgfilename() {
		return imgfilename;
	}

	public void setImgfilename(String imgfilename) {
		this.imgfilename = imgfilename;
	}

	public String getOrgfilename() {
		return orgfilename;
	}

	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public String getReadcount() {
		return readcount;
	}

	public void setReadcount(String readcount) {
		this.readcount = readcount;
	}

	public String getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}
	
	

}
