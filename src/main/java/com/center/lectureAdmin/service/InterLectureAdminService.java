package com.center.lectureAdmin.service;

import java.util.HashMap;
import java.util.List;

import com.center.lectureAdmin.model.EventBoardVO;
import com.center.lectureAdmin.model.LectureAdminVO;
import com.center.lectureAdmin.model.LectureStudentVO;

public interface InterLectureAdminService {
	
	// 1. 강좌 리스트 조회하기
	List<LectureAdminVO> getLectureAdminList(HashMap<String, String> paraMap);
	
	// 2. 검색어가 없는 강좌 리스트 갯수
	int getTotalCountNoSearch();
	
	// 3. 검색어가 있는 강좌 리스트 갯수
	int getTotalCountSearch(HashMap<String, String> paraMap);
	
	// 4. 강좌 상세 내역 조회
	LectureAdminVO getLectureInfo (String class_seq);
	
	// 5. 강좌별 수강생 리스트 조회
	List<LectureStudentVO> getLectureStudentList(String class_seq);
	
	// 6. 강좌 수강생 삭제
	int deleteStudentAdmin(LectureStudentVO studentvo);
	
	// 7. 강좌별 대기자 리스트 조회
	List<LectureStudentVO> getWaitingtList(String class_seq);
	
	// 8. 강좌 등록(첨부파일 x)
	int insertLectureNoFile(LectureAdminVO lecturevo);
	
	// 9. 강좌 등록 (첨부파일 o)
	int insertLectureFile(LectureAdminVO lecturevo);
	
	// 10. 강좌 수정 (첨부파일 o)
	int editLecture(LectureAdminVO lecturevo);
	
	// 11. 강좌 수정(첨부파일x)
	int editLectureNoFile(LectureAdminVO lecturevo);
	
	// 12. 강좌 삭제
	int deleteLecture(String class_seq);
	
	
	
	
	
	/// 이벤트 게시판 ///
	
	// a. 게시판 리스트 조회
	List<EventBoardVO> getEventList(HashMap<String, String> paraMapE);
	
	// b. 검색어가 없는 게시판 글 갯수
	int getTotalCountBoard();
	
	// b-1. 검색어가 있는 이벤트 게시판 글 갯수
	int getTotalCountBoardSearch(HashMap<String, String> paraMap);
	
	// c. 이벤트 게시글 상세 내역 조회 (+조회수 증가 o)
	EventBoardVO getEventInfo (String event_seq, String fk_userno); // 관리자가 아닐 떄만
	
	// c-1. 이벤트 게시글 상세 내역 조회 (+조회수 증가 x)
	EventBoardVO getEventInfoNoCount (String event_seq);
	
	// d. 이벤트 게시판 글 수정 (첨부파일 x)
	int editEventBoardNoFile (EventBoardVO eventvo);
	
	// e. 이벤트 게시판 글 수정 (첨부파일 o)
	int editEventBoardFile (EventBoardVO eventvo);
	
	// f. 이벤트 게시판 글 작성 (첨부파일 x)
	int registerEventBoardNoFile (EventBoardVO eventvo);
	
	// g. 이벤트 게시판 글 작성 (첨부파일 o)
	int registerEventBoardFile (EventBoardVO eventvo);
	
	// h. 이벤트 게시글 삭제
	int deleteEvent(String event_seq);
}
