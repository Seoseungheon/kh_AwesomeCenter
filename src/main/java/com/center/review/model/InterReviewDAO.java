package com.center.review.model;

import java.util.HashMap;
import java.util.List;

public interface InterReviewDAO {

	// 수강한 강좌 정보 가져오기
	List<HashMap<String, String>> finishClass_title(String userno);

	// 첨부파일이 없는 글쓰기
	int add(HashMap<String, String> addMap);

	// 첨부파일이 있는 글쓰기
	int add_withFile(HashMap<String, String> addMap);

	// 글쓰기를 성공하면 수강내역 업데이트 
	int myClassUpdate(HashMap<String, String> addMap);

	// 수강후기 리스트 조회
	List<ReviewVO> reviewList(HashMap<String, String> paramap);

	// 글 상세보기 
	ReviewVO reviewDetail(String reviewno);

	// 글 상세보기가 진행되면 조회수 1 증가
	void updateReadCount(String reviewno);

	// 글 수정하기
	int editEnd(HashMap<String, String> addMap);

	// 글 삭제하기
	int reviewDelete(String reviewno);

	// pagination 처리 되어진 리뷰 갯수를 가져온다
	int totalCount(HashMap<String, String> paramap);

	
	///////////////////////////////////////////////// 대끌  /////////////////////////////////////////////////
		
	// 댓글 달기
	int addCmt(HashMap<String, String> paramap);

	// 리뷰 테이블에 댓글 수 추가 (트랜잭션)
	int addCmtCount(HashMap<String, String> paramap);

	// 댓글 리스트 조회(reviewno)
	List<HashMap<String, String>> selectCommentList(String reviewno);

	// 댓글 삭제하기
	int deleteCom(String replyno);

	// 리뷰 테이블에 댓글 수 빼기 (트랜잭션)
	int subCmtCount(String replyno);

	// 원글 삭제인지 대댓글 삭제인지 ㅎㅎ 
	int countReply(HashMap<String, String> map);

	// 대댓글이 없어서 댓글 아예 삭제
	int realDeleteCom(HashMap<String, String> map);

	// status 가 0 으로 변경된 댓글 갯수
	int countStReply(HashMap<String, String> map);

	// 글 삭제하면 다시 쓰기 가능
	int classReviewUpdate(ReviewVO rvo);


}
