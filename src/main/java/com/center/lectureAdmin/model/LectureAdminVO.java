package com.center.lectureAdmin.model;

import org.springframework.web.multipart.MultipartFile;

public class LectureAdminVO {
	
		// 강좌
		private String class_seq;                                // 강좌 시퀀스
		private String fk_cate_no;                               // 강좌 카테고리
		private String fk_teacher_seq;                          // 강사 시퀀스
		private String class_title;            // 강좌명          
		private String class_semester;                 // 학기 구분 ??
		private String class_startDate;                            // 강좌 시작날짜
		private String class_endDate;                              // 강좌 종료날짜
		private String class_fee;                      // 수강료
		private String class_subFee;                   // 재료비
		private String class_day;                      // 수강요일
		private String class_place;             // 강의실 ?? (강의실코드/text)
		private String class_personnel;     // 수강 정원
		private String class_time;             // 수업 시간 ??
		private String class_photo;                      // 글 첨부사진
		private String class_content;                   // 강좌 내용
		private String class_status;               // 접수상태
		private String class_heart;
		
		private String teacher_name;
		
		private String cate_no;
		private String cate_name;
		private String cate_code;

		private String teafileName;      // WAS(톰캣)에 저장될 파일명(20190725092715353243254235235234.png)
		private String teaorgFilename;   // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
		private String teafileSize;      // 파일크기 
		private MultipartFile attach;

		public LectureAdminVO() { }
		
		public LectureAdminVO(String class_seq, String fk_cate_no, String fk_teacher_seq, String class_title,
				String class_semester, String class_startDate, String class_endDate, String class_fee,
				String class_subFee, String class_day, String class_place, String class_personnel, String class_time,
				String class_photo, String class_content, String class_status, String class_heart, String teacher_name, String cate_no, String cate_name, String cate_code,
				String teafileName, String teaorgFilename, String teafileSize) {
			this.class_seq = class_seq;
			this.fk_cate_no = fk_cate_no;
			this.fk_teacher_seq = fk_teacher_seq;
			this.class_title = class_title;
			this.class_semester = class_semester;
			this.class_startDate = class_startDate;
			this.class_endDate = class_endDate;
			this.class_fee = class_fee;
			this.class_subFee = class_subFee;
			this.class_day = class_day;
			this.class_place = class_place;
			this.class_personnel = class_personnel;
			this.class_time = class_time;
			this.class_photo = class_photo;
			this.class_content = class_content;
			this.class_status = class_status;
			this.class_heart = class_heart;
			this.teacher_name = teacher_name;
			this.cate_code = cate_code;
			this.cate_name = cate_name;
			this.cate_no = cate_no;
			this.teafileName = teafileName;
			this.teaorgFilename = teaorgFilename;
			this.teafileSize = teafileSize;
		} 
	

		public String getClass_seq() {
			return class_seq;
		}
		public void setClass_seq(String class_seq) {
			this.class_seq = class_seq;
		}
		public String getFk_cate_no() {
			return fk_cate_no;
		}
		public void setFk_cate_no(String fk_cate_no) {
			this.fk_cate_no = fk_cate_no;
		}
		public String getFk_teacher_seq() {
			return fk_teacher_seq;
		}
		public void setFk_teacher_seq(String fk_teacher_seq) {
			this.fk_teacher_seq = fk_teacher_seq;
		}
		public String getClass_title() {
			return class_title;
		}
		public void setClass_title(String class_title) {
			this.class_title = class_title;
		}
		public String getClass_semester() {
			return class_semester;
		}
		public void setClass_semester(String class_semester) {
			this.class_semester = class_semester;
		}
		public String getClass_startDate() {
			return class_startDate;
		}
		public void setClass_startDate(String class_startDate) {
			this.class_startDate = class_startDate;
		}
		public String getClass_endDate() {
			return class_endDate;
		}
		public void setClass_endDate(String class_endDate) {
			this.class_endDate = class_endDate;
		}
		public String getClass_fee() {
			return class_fee;
		}
		public void setClass_fee(String class_fee) {
			this.class_fee = class_fee;
		}
		public String getClass_subFee() {
			return class_subFee;
		}
		public void setClass_subFee(String class_subFee) {
			this.class_subFee = class_subFee;
		}
		public String getClass_day() {
			return class_day;
		}
		public void setClass_day(String class_day) {
			this.class_day = class_day;
		}
		public String getClass_place() {
			return class_place;
		}
		public void setClass_place(String class_place) {
			this.class_place = class_place;
		}
		public String getClass_personnel() {
			return class_personnel;
		}
		public void setClass_personnel(String class_personnel) {
			this.class_personnel = class_personnel;
		}
		public String getClass_time() {
			return class_time;
		}
		public void setClass_time(String class_time) {
			this.class_time = class_time;
		}
		public String getClass_photo() {
			return class_photo;
		}
		public void setClass_photo(String class_photo) {
			this.class_photo = class_photo;
		}
		public String getClass_content() {
			return class_content;
		}
		public void setClass_content(String class_content) {
			this.class_content = class_content;
		}
		public String getClass_status() {
			return class_status;
		}
		public void setClass_status(String class_status) {
			this.class_status = class_status;
		}
		public String getClass_heart() {
			return class_heart;
		}
		public void setClass_heart(String class_heart) {
			this.class_heart = class_heart;
		}
		
		public String getTeacher_name() {
			return teacher_name;
		}

		public void setTeacher_name(String teacher_name) {
			this.teacher_name = teacher_name;
		}
		
		public String getCate_no() {
			return cate_no;
		}

		public void setCate_no(String cate_no) {
			this.cate_no = cate_no;
		}

		public String getCate_name() {
			return cate_name;
		}

		public void setCate_name(String cate_name) {
			this.cate_name = cate_name;
		}

		public String getCate_code() {
			return cate_code;
		}

		public void setCate_code(String cate_code) {
			this.cate_code = cate_code;
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
