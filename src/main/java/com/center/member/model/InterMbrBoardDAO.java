package com.center.member.model;

import java.util.HashMap;
import java.util.List;

public interface InterMbrBoardDAO {

	// 페이징 처리를 위한 글 갯수 가져오기
	int getTotalCountWithNOsearch(String userno);
	
	// 1:1문의 내역
	List<QnAVO> getQnAList(HashMap<String, String> map);

	// 1:1 문의 자세히
	QnAVO getQnAView(String no);

	// 1:1 문의 삭제
	int delQuestion(String no);

	// 1:1 문의 수정
	int editQuestion(HashMap<String, String> map);

	// 1:1 문의 작성
	int writeQuestion(HashMap<String, String> map);

	// 관리자용 1:1 문의 내역 갯수
	int getTotalCountWithNOsearchAdmin();

	// 관리자용 1:1 문의 내역
	List<QnAVO> getQnAListAdmin(HashMap<String, String> map);

	// 관리자용 1:1 문의 답변 수정
	int answerEdit(HashMap<String, String> map);

	/* 효민 수정 */
	List<HopeBoardVO> boardListWithPagingHM(HashMap<String, String> paraMap);

	int getTotalCountWithSearchHM(HashMap<String, String> paraMap);

	int getTotalCountWithNOsearchHM();

	//개설희망 글쓰기
	int writewishEnd(HashMap<String, String> paraMap);

	//개설희망 글 보기
	HopeBoardVO getHopeBoardDetail(String no);

	//개설희망 조회수 증가
	void setAddCount(String no);

	//개설희망 글 삭제
	int delHopeBoard(String no);

	//개설희망 글 수정
	int updateWishEnd(HashMap<String, String> paraMap);

	//최근 글 작성시간
	int getRecentlyWrite(String userno);
	/* 효민 수정 끝 */
}
