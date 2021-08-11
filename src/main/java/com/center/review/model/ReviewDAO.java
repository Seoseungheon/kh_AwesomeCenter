package com.center.review.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO implements InterReviewDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
	
	// 수강한 강좌 정보 가져오기
	@Override
	public List<HashMap<String, String>> finishClass_title(String userno) {

		List<HashMap<String, String>> finishList = sqlsession.selectList("awesomeReview.finishClass_title", userno);
		
		return finishList;
	}

	// 첨부파일이 없는 글쓰기
	@Override
	public int add(HashMap<String, String> addMap) {

		int n = sqlsession.insert("awesomeReview.add", addMap);
		
		return n;
	}


	// 첨부파일이 있는 글쓰기
	@Override
	public int add_withFile(HashMap<String, String> addMap) {
		int n = sqlsession.insert("awesomeReview.add_withFile", addMap);
		
		return n;
	}

	
	// 글쓰기를 성공하면 수강내역 업데이트 
	@Override
	public int myClassUpdate(HashMap<String, String> addMap) {

		int n = sqlsession.update("awesomeReview.myClassUpdate", addMap);
		
		return n;
	}

	// 수강후기 리스트 조회
	@Override
	public List<ReviewVO> reviewList(HashMap<String, String> paramap) {

		List<ReviewVO> reviewList = sqlsession.selectList("awesomeReview.reviewList", paramap);
		
		return reviewList;
	}

	// 글 상세보기 
	@Override
	public ReviewVO reviewDetail(String reviewno) {

		ReviewVO rvo = sqlsession.selectOne("awesomeReview.reviewDetail", reviewno);
		
		return rvo;
	}

	// 글 상세보기가 진행되면 조회수 1 증가
	@Override
	public void updateReadCount(String reviewno) {

		sqlsession.update("awesomeReview.updateReadCount", reviewno);
		
	}

	// 글 수정하기
	@Override
	public int editEnd(HashMap<String, String> addMap) {

		int n = sqlsession.update("awesomeReview.editEnd", addMap);
		
		return n;
	}

	// 글 삭제하기
	@Override
	public int reviewDelete(String reviewno) {

		int n = sqlsession.update("awesomeReview.reviewDelete", reviewno);
		
		return n;
	}

	// pagination 처리 되어진 리뷰 갯수를 가져온다
	@Override
	public int totalCount(HashMap<String, String> paramap) {
		
		int n = sqlsession.selectOne("awesomeReview.totalCount", paramap);
		
		
		return n;
	}

	
	///////////////////////////////////////////////// 대끌  /////////////////////////////////////////////////
		
	// 댓글 달기
	@Override
	public int addCmt(HashMap<String, String> paramap) {

		int n = sqlsession.insert("awesomeReview.addCmt", paramap);
		
		return n;
	}
	
	// 리뷰 테이블에 댓글 수 추가 (트랜잭션)
	@Override
	public int addCmtCount(HashMap<String, String> paramap) {

		int m = sqlsession.update("awesomeReview.addCmtCount", paramap);
		
		return m;
	}

	// 댓글 리스트 조회(reviewno)
	@Override
	public List<HashMap<String, String>> selectCommentList(String reviewno) {

		List<HashMap<String, String>> commentList = sqlsession.selectList("awesomeReview.selectCommentList", reviewno);
		
		return commentList;
	}

	// 댓글 삭제하기
	@Override
	public int deleteCom(String replyno) {

		int n = sqlsession.delete("awesomeReview.deleteCom", replyno);
		
		return n;
	}

	// 리뷰 테이블에 댓글 수 빼기 (트랜잭션)
	@Override
	public int subCmtCount(String replyno) {
		
		int m = sqlsession.update("awesomeReview.subCmtCount", replyno);
		
		return m;
	}

	// 원글 삭제인지 대댓글 삭제인지 ㅎㅎ 
	@Override
	public int countReply(HashMap<String, String> map) {
		
		int n = sqlsession.selectOne("awesomeReview.countReply", map);
		
		return n;
	}

	// 대댓글이 없어서 댓글 아예 삭제
	@Override
	public int realDeleteCom(HashMap<String, String> map) {
		
		int n = sqlsession.delete("awesomeReview.realDeleteCom", map);
		
		return n;
	}

	// status 가 0 으로 변경된 댓글 갯수
	@Override
	public int countStReply(HashMap<String, String> map) {

		int n = sqlsession.selectOne("awesomeReview.countStReply", map);
		
		return n;
	}
	
	// 글 삭제하면 다시 쓰기 가능
	@Override
	public int classReviewUpdate(ReviewVO rvo) {

		int n = sqlsession.update("awesomeReview.classReviewUpdate", rvo);
		
		return n;
	}


}
