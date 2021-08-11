package com.center.lectureAdmin.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.center.lectureAdmin.model.EventBoardVO;
import com.center.lectureAdmin.model.InterLectureAdminDAO;
import com.center.lectureAdmin.model.LectureAdminVO;
import com.center.lectureAdmin.model.LectureStudentVO;

@Service
public class LectureAdminService implements InterLectureAdminService {

		// DI
		@Autowired
		private InterLectureAdminDAO dao;

		// 1. 강사 리스트 조회
		@Override
		public List<LectureAdminVO> getLectureAdminList(HashMap<String, String> paraMap) {
			List<LectureAdminVO> lectureAdminList = dao.getLectureAdminList(paraMap);
			return lectureAdminList;
		}
		
		// 2. 검색어가 없는 강좌 리스트 갯수
		@Override
		public int getTotalCountNoSearch() {
			int totalCountNoSearch = dao.getTotalCountNoSearch();
			return totalCountNoSearch;
		}
		
		// 3. 검색어가 있는 강좌 리스트 갯수
		@Override
		public int getTotalCountSearch(HashMap<String, String> paraMap) {
			int totalCountSearch = dao.getTotalCountSearch(paraMap);
			return totalCountSearch;
		}

		// 4. 강좌 상세 내역 조회
		@Override
		public LectureAdminVO getLectureInfo(String class_seq) {
			LectureAdminVO lectureInfo = dao.getLectureInfo(class_seq);
			return lectureInfo;
		}

		// 5. 강좌별 수강생 리스트 조회
		@Override
		public List<LectureStudentVO> getLectureStudentList(String class_seq) {
			List<LectureStudentVO> lectureStudentList = dao.getLectureStudentList(class_seq);
			return lectureStudentList;
		}
		
		// 6. 강좌 수강생 삭제
		@Override
		public int deleteStudentAdmin(LectureStudentVO studentvo) {
			int deleteStudent = dao.deleteStudentAdmin(studentvo);
			return deleteStudent;
		}
		
		// 7. 강좌별 대기자 리스트 조회
		@Override
		public List<LectureStudentVO> getWaitingtList(String classno_fk) {
			List<LectureStudentVO> waitingtList = dao.getWaitingtList(classno_fk);
			return waitingtList;
		}
		
		// 8. 강좌 등록(첨부파일 x)
		@Override
		public int insertLectureNoFile(LectureAdminVO lecturevo) {
			System.out.println("없음getClass_seq"+lecturevo.getClass_seq());
			
			int n = dao.insertLectureNoFile(lecturevo);
			System.out.println("없음n"+n);
			return n;
			
		}

		// 9. 강좌 등록 (첨부파일 o)
		@Override
		public int insertLectureFile(LectureAdminVO lecturevo) {
			System.out.println("있음getClass_seq"+lecturevo.getClass_seq());
			int n = dao.insertLectureFile(lecturevo);
			System.out.println("있음n"+n);
			return n;
		}
		
		// 10. 강좌 수정 (첨부파일 o)
		@Override
		public int editLecture(LectureAdminVO lecturevo) {
			int n = dao.editLecture(lecturevo);
			return n;
		}

		// 11. 강좌 수정(첨부파일x)
		@Override
		public int editLectureNoFile(LectureAdminVO lecturevo) {
			int n = dao.editLectureNoFile(lecturevo);
			return n;
		}
		
		// 12. 강좌 삭제
		@Override
		public int deleteLecture(String class_seq) {
			int n = dao.deleteLecture(class_seq);
			return n;
		}


		
		
		
		
		/// 이벤트 게시판 ///
		
		// a. 게시판 리스트 조회
		@Override
		public List<EventBoardVO> getEventList(HashMap<String, String> paraMapE) {
			List<EventBoardVO> eventList = dao.getEventList(paraMapE);
			return eventList;
		}

		// b. 검색어가 없는 게시판 글 갯수
		@Override
		public int getTotalCountBoard() {
			int count = dao.getTotalCountBoard();
			return count;
		}
		
		// b-1. 검색어가 있는 이벤트 게시판 글 갯수
		@Override
		public int getTotalCountBoardSearch(HashMap<String, String> paraMap) {
			int count = dao.getTotalCountBoardSearch(paraMap);
			return count;
		}

		// c. 이벤트 상세 내역 조회 (조회수 증가 o)
		@Override
		public EventBoardVO getEventInfo(String event_seq, String fk_userno) {
			
			EventBoardVO eventInfo = dao.getEventInfo(event_seq);
			
			if(!fk_userno.equals(eventInfo.getFk_userno())) {
				dao.setAddViewCount(event_seq);
				eventInfo = dao.getEventInfo(event_seq);
			}
			
			return eventInfo;
		}
		
		// c-1. 이벤트 상세 내역 조회 (조회수 증가 x)
		@Override
		public EventBoardVO getEventInfoNoCount(String event_seq) {		
			EventBoardVO eventInfo = dao.getEventInfo(event_seq);
			return eventInfo;
		}

		// d. 이벤트 게시판 글 수정 (첨부파일 x)
		@Override
		public int editEventBoardNoFile(EventBoardVO eventvo) {
			int count = dao.editEventBoardNoFile(eventvo);
			return count;
		}

		// e. 이벤트 게시판 글 수정 (첨부파일 o)
		@Override
		public int editEventBoardFile(EventBoardVO eventvo) {
			int count = dao.editEventBoardFile(eventvo);
			return count;
		}

		// f. 이벤트 게시판 글 작성 (첨부파일 x)
		@Override
		public int registerEventBoardNoFile(EventBoardVO eventvo) {
			int count = dao.registerEventBoardNoFile(eventvo);
			return count;
		}

		// g. 이벤트 게시판 글 작성 (첨부파일 o)
		@Override
		public int registerEventBoardFile(EventBoardVO eventvo) {
			int count = dao.registerEventBoardFile(eventvo);
			return count;
		}

		// h. 이벤트 게시글 삭제
		@Override
		public int deleteEvent(String event_seq) {
			int n = dao.deleteEvent(event_seq);
			return n;
		}

		

		
		
	
		
		

		
		
	
		

		
}
