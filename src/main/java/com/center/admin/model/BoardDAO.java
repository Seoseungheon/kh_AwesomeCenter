package com.center.admin.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.center.member.model.MemberVO;


@Repository
public class BoardDAO implements InterBoardDAO {

	   // 의존객체 주입하기(DI: Dependency Injection) ===
		@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
		private SqlSessionTemplate sqlsession;

		@Override
		public int getTotalCountWithNOsearch() {
			int count = sqlsession.selectOne("awesomeAdmin.getTotalCountWithNOsearch");
			return count;
		}

		@Override
		public int getTotalCountWithSearch(HashMap<String, String> paraMap) {
			int count = sqlsession.selectOne("awesomeAdmin.getTotalCountWithSearch", paraMap);
			return count;
		}

		// 공지글 상세보기 
		@Override
		public BoardVO getNoticeBoardDetail(String Not_seq) {
			BoardVO boardvo = sqlsession.selectOne("awesomeAdmin.getNoticeBoardDetail", Not_seq);
			return boardvo;
		}

		// 공지글 상세보기(조회수)
		@Override
		public void setAddReadCount(String Not_seq) {
			sqlsession.update("awesomeAdmin.setAddReadCount", Not_seq);
			
		}

		// 공지게시판 글 쓰기 
		@Override
		public int addNotice(BoardVO boardvo) {
			int n = sqlsession.insert("awesomeAdmin.addNotice",boardvo);
			return n;
		}

		// 공지게시판 글 수정 
		@Override
		public int noticeEdit(BoardVO boardvo) {
			int n = sqlsession.update("awesomeAdmin.noticeEdit", boardvo);
			return n;
		}

		// 공지게시판 글 삭제 
		@Override
		public int noticedel(BoardVO boardvo) {
			int n = sqlsession.update("awesomeAdmin.noticedel",boardvo);  
			return n;
		}
		
		// 공지게시판 글 목록 
		@Override
		public List<BoardVO> boardListWithPaging(HashMap<String, String> paraMap) {
			List<BoardVO> boardList = sqlsession.selectList("awesomeAdmin.boardListWithPaging",paraMap);
			
			return boardList;
		}
		
		// 회원목록 
		@Override
		public List<MemberVO> memberListWithPaging(HashMap<String, String> paraMap) {
			List<MemberVO> memberList = sqlsession.selectList("awesomeAdmin.memberListWithPaging", paraMap);
			return memberList;
		}
		
		// 연도별 매출 통계 클릭 전 - 2018년, 2019년, 2020년 총매출 
		@Override
		public List<HashMap<String, String>> sumListJSON() {
			List<HashMap<String, String>> sumList = sqlsession.selectList("awesomeAdmin.sumListJSON");
			return sumList;
		}

		// 연도별 매출 통계 클릭 후 - 월별 매출 
		@Override
		public List<HashMap<String, String>> detailMonthJSON(String year) {
			List<HashMap<String, String>> monthList = sqlsession.selectList("awesomeAdmin.detailMonthJSON", year);
			return monthList;
		}

		@Override
		public List<HashMap<String, String>> classListJSON() {
			List<HashMap<String, String>> classList = sqlsession.selectList("awesomeAdmin.classListJSON");
			return classList;
		}

		@Override
		public List<HashMap<String, String>> detailClassJSON(String catename) {
			List<HashMap<String, String>> deatilclassList = sqlsession.selectList("awesomeAdmin.detailClassJSON", catename);
			return deatilclassList;
		}
		
		// 카테고리별 강사수 클릭 전
		@Override
		public List<HashMap<String, String>> teacherListJSON() {
			List<HashMap<String, String>> teacherList = sqlsession.selectList("awesomeAdmin.teacherListJSON");
			return teacherList;
		}
		
		// 카테고리별 강사수 클릭 후 - 성별 퍼센티지
		@Override
		public List<HashMap<String, String>> teacherGenderJSON(String catename) {
			List<HashMap<String, String>> genderList = sqlsession.selectList("awesomeAdmin.teacherGenderJSON", catename);
			return genderList;
		}


}
