package com.center.review.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.center.review.model.InterReviewDAO;
import com.center.review.model.ReviewVO;

@Service
public class ReviewService implements InterReviewService {
	
	@Autowired
	private InterReviewDAO dao;
	
	// 수강한 강좌 정보 가져오기
	@Override
	public List<HashMap<String, String>> finishClass_title(String userno) {

		List<HashMap<String, String>> finishList = dao.finishClass_title(userno);
		
		return finishList;
	}

	// 첨부파일이 없는 글쓰기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int add(HashMap<String, String> addMap) {

		int n = dao.add(addMap);
		
		int m = 0;
		if(n==1) {

			// 글쓰기를 성공하면 수강내역 업데이트 
			m = dao.myClassUpdate(addMap);
		}
		
		return m;
	}

	// 첨부파일이 있는 글쓰기
	@Override
	public int add_withFile(HashMap<String, String> addMap) {
		
		int n = dao.add_withFile(addMap);
		
		int m = 0;
		if(n==1) {

			// 글쓰기를 성공하면 수강내역 업데이트 
			m = dao.myClassUpdate(addMap);
		}
		
		return m;
	}

	// 수강후기 리스트 조회
	@Override
	public List<ReviewVO> reviewList(HashMap<String, String> paramap) {

		List<ReviewVO> reviewList = dao.reviewList(paramap);
		
		return reviewList;
	}

	// 글 상세보기 
	@Override
	public ReviewVO reviewDetail(String reviewno) {

		ReviewVO rvo = dao.reviewDetail(reviewno);
		
		if(rvo != null) {
			
			dao.updateReadCount(reviewno);
		}
		
		return rvo;
		
	}

	// 글 수정하기
	@Override
	public int editEnd(HashMap<String, String> addMap) {

		int n = dao.editEnd(addMap);
			
		return n;
	}

	// 글 삭제하기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int reviewDelete(ReviewVO rvo) {
		
		int n = dao.reviewDelete(rvo.getReviewno());
		
		int m = 0;
		if(n == 1) {
			
			m = dao.classReviewUpdate(rvo);
		}
		
		return m; 
	}

	// pagination 처리 되어진 리뷰 갯수를 가져온다
	@Override
	public int totalCount(HashMap<String, String> paramap) {

		int n = dao.totalCount(paramap);
		
		return n;
	}

	
	///////////////////////////////////////////////// 대끌  /////////////////////////////////////////////////
		
	// 댓글 달기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int addCmt(HashMap<String, String> paramap) {

		// 댓글 테이블에 댓글 추가
		int n = dao.addCmt(paramap);
		
		int m = 0;
		
		if(n==1) {
			
			// 리뷰 테이블에 댓글 수 추가 
			m = dao.addCmtCount(paramap);
			
		}
		
		return m;
	}

	// 댓글 리스트 조회(reviewno)
	@Override
	public List<HashMap<String, String>> selectCommentList(String reviewno) {

		List<HashMap<String, String>> commentList = dao.selectCommentList(reviewno);
		
		return commentList;
	}

	// 댓글 삭제하기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int deleteCom(HashMap<String, String> map) {

		int n = dao.deleteCom(map.get("replyno"));
		
		int m = 0;
		
		if(n==1) {
			
			// 리뷰 테이블에 댓글 수 빼기
			m = dao.subCmtCount(map.get("reviewno"));
			
		}
		
		
		return m;
	}

	// 원글 삭제인지 대댓글 삭제인지 ㅎㅎ 
	@Override
	public int countReply(HashMap<String, String> map) {

		int n = dao.countReply(map);
		
		return n;
	}

	// 대댓글이 없어서 댓글 아예 삭제
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int realDeleteCom(HashMap<String, String> map) {

		int n = dao.realDeleteCom(map);
		
		int m = 0;
		
		if(n==1) {
			
			// 리뷰 테이블에 댓글 수 빼기
			m = dao.subCmtCount(map.get("reviewno"));
			
		}
		
		return m;
	}

	// status 가 0 으로 변경된 댓글 갯수
	@Override
	public int countStReply(HashMap<String, String> map) {

		int n = dao.countStReply(map);
		
		return n;
	}

}
