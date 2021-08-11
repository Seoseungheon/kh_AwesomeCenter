package com.center.admin.model;

import java.util.HashMap;
import java.util.List;

import com.center.member.model.MemberVO;

public interface InterBoardDAO {

	List<BoardVO> boardListWithPaging(HashMap<String, String> paraMap); // 공지게시판 글 목록 

	int getTotalCountWithNOsearch();

	int getTotalCountWithSearch(HashMap<String, String> paraMap);

	BoardVO getNoticeBoardDetail(String Not_seq); // 공지게시글 조회수 증가 및 게시글 상세보기
	void setAddReadCount(String Not_seq); // 조회수 1증가 

	int addNotice(BoardVO boardvo);  // 공지게시판 글 쓰기 

	int noticeEdit(BoardVO boardvo); // 공지게시판 글 수정 

	int noticedel(BoardVO boardvo); // 공지게시판 글 삭제

	List<MemberVO> memberListWithPaging(HashMap<String, String> paraMap); // 회원목록 
	
	List<HashMap<String, String>> sumListJSON(); // 연도별 매출 통계 클릭 전 - 2018년, 2019년, 2020년 총매출 
	List<HashMap<String, String>> detailMonthJSON(String year); // 연도별 매출 통계 클릭 후 - 월별 매출 

	List<HashMap<String, String>> classListJSON();
	List<HashMap<String, String>> detailClassJSON(String catename);

	List<HashMap<String, String>> teacherListJSON();  // 카테고리별 강사수 클릭 전
	List<HashMap<String, String>> teacherGenderJSON(String catename); // 카테고리별 강사수 클릭 후 - 성별 퍼센티지


}
