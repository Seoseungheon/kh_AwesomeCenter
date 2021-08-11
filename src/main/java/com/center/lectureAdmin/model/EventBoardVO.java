package com.center.lectureAdmin.model;

import org.springframework.web.multipart.MultipartFile;

public class EventBoardVO {
	
	private String event_seq;
	private String fk_userno;
	private String event_title;
	private String event_photo;
	private String event_date;
	private String event_view;
	private String event_status;
	private String event_content;
	
	private String previousseqE;      // 이전글번호
	private String previoussubjectE;  // 이전글제목
	private String nextseqE;          // 다음글번호
	private String nextsubjectE;      // 다음글제목
	
	private String teaorgFilename;  
	private MultipartFile attach;
	
	public EventBoardVO() { }
	
	public EventBoardVO(String event_seq, String fk_userno, String event_title, String event_content, String event_photo, String event_date,
			String event_view, String event_status, String previousseqE, String previoussubjectE, String nextseqE, 
			String nextsubjectE, String teaorgFilename) {
		this.event_seq = event_seq;
		this.fk_userno = fk_userno;
		this.event_title = event_title;
		this.event_photo = event_photo;
		this.event_date = event_date;
		this.event_view = event_view;
		this.event_status = event_status;
		this.previousseqE = previousseqE;
		this.previoussubjectE = previoussubjectE;
		this.nextseqE = nextseqE;
		this.nextsubjectE = nextsubjectE;
		this.event_content = event_content;
		this.teaorgFilename = teaorgFilename;
	}
	public String getEvent_seq() {
		return event_seq;
	}
	public void setEvent_seq(String event_seq) {
		this.event_seq = event_seq;
	}
	public String getFk_userno() {
		return fk_userno;
	}
	public void setFk_userno(String fk_userno) {
		this.fk_userno = fk_userno;
	}
	public String getEvent_title() {
		return event_title;
	}
	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}
	public String getEvent_photo() {
		return event_photo;
	}
	public void setEvent_photo(String event_photo) {
		this.event_photo = event_photo;
	}
	public String getEvent_date() {
		return event_date;
	}
	public void setEvent_date(String event_date) {
		this.event_date = event_date;
	}
	public String getEvent_view() {
		return event_view;
	}
	public void setEvent_view(String event_view) {
		this.event_view = event_view;
	}
	public String getEvent_status() {
		return event_status;
	}
	public void setEvent_status(String event_status) {
		this.event_status = event_status;
	}
	public String getPreviousseqE() {
		return previousseqE;
	}
	public void setPreviousseqE(String previousseqE) {
		this.previousseqE = previousseqE;
	}
	public String getPrevioussubjectE() {
		return previoussubjectE;
	}
	public void setPrevioussubjectE(String previoussubjectE) {
		this.previoussubjectE = previoussubjectE;
	}
	public String getNextseqE() {
		return nextseqE;
	}
	public void setNextseq(String nextseqE) {
		this.nextseqE = nextseqE;
	}
	public String getNextsubjectE() {
		return nextsubjectE;
	}
	public void setNextsubjectE(String nextsubjectE) {
		this.nextsubjectE = nextsubjectE;
	}
	
	public String getEvent_content() {
		return event_content;
	}

	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}
	
	
	
	
	public String getTeaorgFilename() {
		return teaorgFilename;
	}
	
	
	public void setTeaorgFilename(String teaorgFilename) {
		this.teaorgFilename = teaorgFilename;
	}
	
	
	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
}
