package com.center.member.model;

public class QnAVO {
	
	String no;
	String userno_fk;
	String categoryno_fk;
	String title;
	String content;
	String writeday;
	String status;
	String answer;
	String rrno;
	
	
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getRrno() {
		return rrno;
	}
	public void setRrno(String rrno) {
		this.rrno = rrno;
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
	public String getCategoryno_fk() {
		return categoryno_fk;
	}
	public void setCategoryno_fk(String categoryno_fk) {
		this.categoryno_fk = categoryno_fk;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	

}
