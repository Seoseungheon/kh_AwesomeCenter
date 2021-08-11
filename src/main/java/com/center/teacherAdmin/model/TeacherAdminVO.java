package com.center.teacherAdmin.model;

import org.springframework.web.multipart.MultipartFile;

public class TeacherAdminVO {

	private String teacher_seq;  
	private String fk_cate_no;
    private String teacher_name;
    private String teacher_gender;
    private String teacher_jubun;
    private String teacher_postcode;
    private String teacher_addr1; 
    private String teacher_addr2;
    private String teacher_phone1;
    private String teacher_phone2;
    private String teacher_email;
    private String teacher_photo;
    private String teacher_registerday;               
    private String teacher_shcool;
    private String teacher_major;
    private String teacher_career1;
    private String teacher_career2;
    private String teacher_reason;
    private String teacher_status;
    private String cate_code;
    private String cate_name;
    
    private String teafileName;      // WAS(톰캣)에 저장될 파일명(20190725092715353243254235235234.png)
	private String teaorgFilename;   // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
	private String teafileSize;      // 파일크기 
	private MultipartFile attach; // 진짜 파일 ==> WAS(톰캣) 디스크에 저장됨.
    
    public TeacherAdminVO() {}
    
    
    public TeacherAdminVO(String teacher_seq, String fk_cate_no, String teacher_name, String teacher_gender,
			String teacher_jubun, String teacher_postcode, String teacher_addr1, String teacher_addr2,
			String teacher_phone1, String teacher_phone2, String teacher_email, String teacher_photo,
			String teacher_registerday, String teacher_shcool, String teacher_major, String teacher_career1,
			String teacher_career2, String teacher_reason, String teacher_status, String cate_code, String cate_name,
			String teafileName, String teaorgFilename, String teafileSize) {
	
		this.teacher_seq = teacher_seq;
		this.fk_cate_no = fk_cate_no;
		this.teacher_name = teacher_name;
		this.teacher_gender = teacher_gender;
		this.teacher_jubun = teacher_jubun;
		this.teacher_postcode = teacher_postcode;
		this.teacher_addr1 = teacher_addr1;
		this.teacher_addr2 = teacher_addr2;
		this.teacher_phone1 = teacher_phone1;
		this.teacher_phone2 = teacher_phone2;
		this.teacher_email = teacher_email;
		this.teacher_photo = teacher_photo;
		this.teacher_registerday = teacher_registerday;
		this.teacher_shcool = teacher_shcool;
		this.teacher_major = teacher_major;
		this.teacher_career1 = teacher_career1;
		this.teacher_career2 = teacher_career2;
		this.teacher_reason = teacher_reason;
		this.teacher_status = teacher_status;
		this.cate_code = cate_code;
		this.cate_name = cate_name;
		this.teafileName = teafileName;
		this.teaorgFilename = teaorgFilename;
		this.teafileSize = teafileSize;
		
	}


	public String getTeacher_seq() {
		return teacher_seq;
	}
	public void setTeacher_seq(String teacher_seq) {
		this.teacher_seq = teacher_seq;
	}
	public String getFk_cate_no() {
		return fk_cate_no;
	}
	public void setFk_cate_no(String fk_cate_no) {
		this.fk_cate_no = fk_cate_no;
	}
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public String getTeacher_gender() {
		return teacher_gender;
	}
	public void setTeacher_gender(String teacher_gender) {
		this.teacher_gender = teacher_gender;
	}


	public String getTeacher_jubun() {
		return teacher_jubun;
	}
	public void setTeacher_jubun(String teacher_jubun) {
		this.teacher_jubun = teacher_jubun;
	}
	public String getTeacher_postcode() {
		return teacher_postcode;
	}
	public void setTeacher_postcode(String teacher_postcode) {
		this.teacher_postcode = teacher_postcode;
	}
	public String getTeacher_addr1() {
		return teacher_addr1;
	}
	public void setTeacher_addr1(String teacher_addr1) {
		this.teacher_addr1 = teacher_addr1;
	}
	public String getTeacher_addr2() {
		return teacher_addr2;
	}
	public void setTeacher_addr2(String teacher_addr2) {
		this.teacher_addr2 = teacher_addr2;
	}
	public String getTeacher_phone1() {
		return teacher_phone1;
	}
	public void setTeacher_phone1(String teacher_phone1) {
		this.teacher_phone1 = teacher_phone1;
	}
	public String getTeacher_phone2() {
		return teacher_phone2;
	}
	public void setTeacher_phone2(String teacher_phone2) {
		this.teacher_phone2 = teacher_phone2;
	}
	public String getTeacher_email() {
		return teacher_email;
	}
	public void setTeacher_email(String teacher_email) {
		this.teacher_email = teacher_email;
	}
	public String getTeacher_photo() {
		return teacher_photo;
	}
	public void setTeacher_photo(String teacher_photo) {
		this.teacher_photo = teacher_photo;
	}
	public String getTeacher_registerday() {
		return teacher_registerday;
	}
	public void setTeacher_registerday(String teacher_registerday) {
		this.teacher_registerday = teacher_registerday;
	}
	public String getTeacher_shcool() {
		return teacher_shcool;
	}
	public void setTeacher_shcool(String teacher_shcool) {
		this.teacher_shcool = teacher_shcool;
	}
	public String getTeacher_major() {
		return teacher_major;
	}
	public void setTeacher_major(String teacher_major) {
		this.teacher_major = teacher_major;
	}
	public String getTeacher_career1() {
		return teacher_career1;
	}
	public void setTeacher_career1(String teacher_career1) {
		this.teacher_career1 = teacher_career1;
	}
	public String getTeacher_career2() {
		return teacher_career2;
	}
	public void setTeacher_career2(String teacher_career2) {
		this.teacher_career2 = teacher_career2;
	}
	public String getTeacher_reason() {
		return teacher_reason;
	}
	public void setTeacher_reason(String teacher_reason) {
		this.teacher_reason = teacher_reason;
	}
	public String getTeacher_status() {
		return teacher_status;
	}
	public void setTeacher_status(String teacher_status) {
		this.teacher_status = teacher_status;
	}
	public String getCate_code() {
		return cate_code;
	}


	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}


	public String getCate_name() {
		return cate_name;
	}


	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}



	///////////// 파일 업로드 /////////////////
	public String getTeafileName() {
		return teafileName;
	}


	public void setTeafileName(String teafileName) {
		this.teafileName = teafileName;
	}


	public String getTeaorgFilename() {
		return teaorgFilename;
	}


	public void setTeaorgFilename(String teaorgFilename) {
		this.teaorgFilename = teaorgFilename;
	}


	public String getTeafileSize() {
		return teafileSize;
	}


	public void setTeafileSize(String teafileSize) {
		this.teafileSize = teafileSize;
	}


	public MultipartFile getAttach() {
		return attach;
	}


	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
   
	
	
    
}
