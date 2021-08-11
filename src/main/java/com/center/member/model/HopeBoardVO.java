package com.center.member.model;

public class HopeBoardVO {
	private String no;
	private String userno_fk;
	private String title;
	private String content;
	private String writeday;
	private String viewcount;
	private String status;
	private String username; 
	
	public HopeBoardVO() {}
	
	public HopeBoardVO(String no, String userno_fk, String title, String content, String writeday, String viewcount,
			String status, String username) {
		super();
		this.no = no;
		this.userno_fk = userno_fk;
		this.title = title;
		this.content = content;
		this.writeday = writeday;
		this.viewcount = viewcount;
		this.status = status;
		this.username = username;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriteday() {
		return writeday;
	}

	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}

	public String getViewcount() {
		return viewcount;
	}

	public void setViewcount(String viewcount) {
		this.viewcount = viewcount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	
	
	
}
