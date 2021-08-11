package com.center.lectureAdmin.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LectureAdminDAO implements InterLectureAdminDAO {

	// DI
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	
	// 1. 강좌 리스트 조회
	@Override
	public List<LectureAdminVO> getLectureAdminList(HashMap<String, String> paraMap) {
		List<LectureAdminVO> lectureAdminList = sqlsession.selectList("awesomeAdminLecture.getLectureAdminList", paraMap);
		return lectureAdminList;
	}

	// 2. 검색어가 없는 강좌 리스트 갯수
	@Override
	public int getTotalCountNoSearch() {
		int count = sqlsession.selectOne("awesomeAdminLecture.getTotalCountNoSearch");
		return count;
	}

	// 3. 검색어가 있는 강좌 리스트 갯수
	@Override
	public int getTotalCountSearch(HashMap<String, String> paraMap) {
		int count = sqlsession.selectOne("awesomeAdminLecture.getTotalCountSearch", paraMap);
		return count;
	}

	// 4. 강좌 상세 내역 조회
	@Override
	public LectureAdminVO getLectureInfo(String class_seq) {
		LectureAdminVO lectureInfo = sqlsession.selectOne("awesomeAdminLecture.getLectureInfo", class_seq);	
		return lectureInfo;
	}
	
	// 5. 강좌별 수강생 리스트 조회
	@Override
	public List<LectureStudentVO> getLectureStudentList(String class_seq) {
		List<LectureStudentVO> lectureStudentList = sqlsession.selectList("awesomeAdminLecture.getLectureStudentList", class_seq);
		return lectureStudentList;
	}	
	
	// 6. 강좌 수강생 삭제
	@Override
	public int deleteStudentAdmin(LectureStudentVO studentvo) {	
	//	System.out.println("service:"+studentvo.getFk_userno());
		int n = sqlsession.delete("awesomeAdminLecture.deleteStudentAdmin", studentvo);
		return n;
	}
	
	// 7. 강좌별 대기자 리스트 조회
	@Override
	public List<LectureStudentVO> getWaitingtList(String classno_fk) {
		List<LectureStudentVO> waitingList = sqlsession.selectList("awesomeAdminLecture.getWaitingtList", classno_fk);
		return waitingList;
	}
	
	// 8. 강좌 등록(첨부파일 x)
	@Override
	public int insertLectureNoFile(LectureAdminVO lecturevo) {
		System.out.println("없음getClass_seq"+lecturevo.getClass_seq());
		int n = sqlsession.insert("awesomeAdminLecture.insertLectureNoFile", lecturevo);
		System.out.println("없음n"+n);
		return n;
	}

	// 9. 강좌 등록(첨부파일 o)
	@Override
	public int insertLectureFile(LectureAdminVO lecturevo) {
		System.out.println("있음getClass_seq"+lecturevo.getClass_seq());
		int n = sqlsession.insert("awesomeAdminLecture.insertLectureFile", lecturevo);
		System.out.println("있음n"+n);
		
		return n;
	}
	
	// 10. 강좌 수정(첨부파일 o)
	@Override
	public int editLecture(LectureAdminVO lecturevo) {
		
		int n = sqlsession.update("awesomeAdminLecture.editLecture", lecturevo);
		return n;
	}
	
	// 11. 강좌 수정(첨부파일x)
	@Override
	public int editLectureNoFile(LectureAdminVO lecturevo) {
		int n = sqlsession.update("awesomeAdminLecture.editLectureNoFile", lecturevo);		
		return n;
	}
	
	// 12. 강좌 삭제
	@Override
	public int deleteLecture(String class_seq) {
		int n = sqlsession.delete("awesomeAdminLecture.deleteLecture", class_seq);
		return n;
	}


	
	
	// a. 게시판 리스트 조회
	@Override
	public List<EventBoardVO> getEventList(HashMap<String, String> paraMapE) {
		List<EventBoardVO> eventList = sqlsession.selectList("awesomeAdminLecture.getEventList", paraMapE);
		return eventList;
	}

	// b. 검색어가 없는 게시판 글 갯수
	@Override
	public int getTotalCountBoard() {
		int count = sqlsession.selectOne("awesomeAdminLecture.getTotalCountBoard");
		return count;
	}
	
	// b-1. 검색어가 있는 이벤트 게시판 글 갯수
	@Override
	public int getTotalCountBoardSearch(HashMap<String, String> paraMap) {
		int count = sqlsession.selectOne("awesomeAdminLecture.getTotalCountBoardSearch", paraMap);
		return count;
	}

	// c. 이벤트 게시글 상세 내역 조회
	@Override
	public EventBoardVO getEventInfo(String event_seq) {
		EventBoardVO eventInfo = sqlsession.selectOne("awesomeAdminLecture.getEventInfo", event_seq);
		return eventInfo;
	}
	
	// c-1. 조회수+1
	@Override
	public void setAddViewCount(String event_seq) {
		sqlsession.update("awesomeAdminLecture.setAddViewCount", event_seq);	
	}

	// d. 이벤트 게시판 글 수정 (첨부파일 x)
	@Override
	public int editEventBoardNoFile(EventBoardVO eventvo) {
		int count = sqlsession.update("awesomeAdminLecture.editEventBoardNoFile", eventvo);
		System.out.println("제발!!"+count);
		return count;
	}

	// e. 이벤트 게시판 글 수정 (첨부파일 o)
	@Override
	public int editEventBoardFile(EventBoardVO eventvo) {
		int count = sqlsession.update("awesomeAdminLecture.editEventBoardFile", eventvo);
		System.out.println("제발!!!!"+count);
		return count;
	}

	// f. 이벤트 게시판 글 작성 (첨부파일 x)
	@Override
	public int registerEventBoardNoFile(EventBoardVO eventvo) {
		int count = sqlsession.insert("awesomeAdminLecture.registerEventBoardNoFile", eventvo);
		return count;
	}

	// g. 이벤트 게시판 글 작성 (첨부파일 o)
	@Override
	public int registerEventBoardFile(EventBoardVO eventvo) {
		int count = sqlsession.insert("awesomeAdminLecture.registerEventBoardFile", eventvo);
		return count;
	}
	
	// h. 이벤트 게시글 삭제
	@Override
	public int deleteEvent(String event_seq) {
		int n = sqlsession.update("awesomeAdminLecture.deleteEvent", event_seq);
		return n;
	}

	

	

	

	
	

	
	

	
	

}
