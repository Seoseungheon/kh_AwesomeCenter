package com.center.review.service;

import java.util.HashMap;
import java.util.List;

import com.center.review.model.ReviewVO;

public interface InterReviewService {

	// 수강한 강좌 정보 가져오기
	List<HashMap<String, String>> finishClass_title(String userno);

	// 첨부파일이 없는 글쓰기
	int add(HashMap<String, String> addMap);

	// 첨부파일이 있는 글쓰기
	int add_withFile(HashMap<String, String> addMap);

	// 수강후기 리스트 조회
	List<ReviewVO> reviewList(HashMap<String, String> paramap);

	// 글 상세보기 
	ReviewVO reviewDetail(String reviewno);

	// 글 수정하기
	int editEnd(HashMap<String, String> addMap);

	// 글 삭제하기
	int reviewDelete(ReviewVO rvo);

	// pagination 처리 되어진 리뷰 갯수를 가져온다
	int totalCount(HashMap<String, String> paramap);
	
	///////////////////////////////////////////////// 대끌  /////////////////////////////////////////////////
		
	// 댓글 달기
	int addCmt(HashMap<String, String> paramap);

	// 댓글 리스트 조회(reviewno)
	List<HashMap<String, String>> selectCommentList(String reviewno);

	// 댓글 삭제하기
	int deleteCom(HashMap<String, String> map);

	// 원글 삭제인지 대댓글 삭제인지 ㅎㅎ 
	int countReply(HashMap<String, String> map);

	// 대댓글이 없어서 댓글 아예 삭제
	int realDeleteCom(HashMap<String, String> map);

	// status 가 0 으로 변경된 댓글 갯수
	int countStReply(HashMap<String, String> map);

}
