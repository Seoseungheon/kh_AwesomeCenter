package com.center.member.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.center.member.model.HopeBoardVO;
import com.center.member.model.InterMbrBoardDAO;
import com.center.member.model.QnAVO;

@Service
public class MbrBoardService implements InterMbrBoardService {

	@Autowired
	private InterMbrBoardDAO dao;

	// 페이징 처리를 위한 글 갯수 가져오기
	@Override
	public int getTotalCountWithNOsearch(String userno) {
		int count = dao.getTotalCountWithNOsearch(userno);
		return count;
	}

	// 1:1문의 내역
	@Override
	public List<QnAVO> getQnAList(HashMap<String, String> map) {
		List<QnAVO> QnAList = dao.getQnAList(map);
		return QnAList;
	}

	// 1:1 문의 자세히
	@Override
	public QnAVO getQnAView(String no) {
		QnAVO qna = dao.getQnAView(no);
		return qna;
	}

	// 1:1 문의 삭제
	@Override
	public int delQuestion(String no) {
		int n = dao.delQuestion(no);
		return n;
	}

	// 1:1 문의 수정
	@Override
	public int editQuestion(HashMap<String, String> map) {
		int n = dao.editQuestion(map);
		return n;
	}

	// 1:1 문의 작성
	@Override
	public int writeQuestion(HashMap<String, String> map) {
		int n = dao.writeQuestion(map);
		return n;
	}

	// 관리자용 1:1 문의 내역 갯수
	@Override
	public int getTotalCountWithNOsearchAdmin() {
		int n = dao.getTotalCountWithNOsearchAdmin();
		return n;
	}

	// 관리자용 1:1 문의 내역
	@Override
	public List<QnAVO> getQnAListAdmin(HashMap<String, String> map) {
		List<QnAVO> QnAList = dao.getQnAListAdmin(map);
		return QnAList;
	}

	// 관리자용 1:1 문의 답변 수정
	@Override
	public int answerEdit(HashMap<String, String> map) {
		int n = dao.answerEdit(map);
		return n;
	}

	/* 효민 수정 */
	@Override
	public int getTotalCountWithNOsearchHM() {
		int count = dao.getTotalCountWithNOsearchHM();
		return count;
	}

	@Override
	public int getTotalCountWithSearchHM(HashMap<String, String> paraMap) {
		int count = dao.getTotalCountWithSearchHM(paraMap);
		return count;
	}

	@Override
	public List<HopeBoardVO> boardListWithPagingHM(HashMap<String, String> paraMap) {
		List<HopeBoardVO> boardList = dao.boardListWithPagingHM(paraMap);
		
		return boardList;
	}

	@Override
	public int writewishEnd(HashMap<String, String> paraMap) {
		int n = dao.writewishEnd(paraMap);
		return n;
	}

	@Override
	public HopeBoardVO getHopeBoardDetail(String no) {
		HopeBoardVO hvo = dao.getHopeBoardDetail(no);
		dao.setAddCount(no);
		return hvo;
	}

	@Override
	public int delHopeBoard(String no) {
		int n = dao.delHopeBoard(no);
		return n;
	}

	@Override
	public int updateWishEnd(HashMap<String, String> paraMap) {
		int n = dao.updateWishEnd(paraMap);
		return n;
	}

	@Override
	public int getRecentlyWrite(String userno) {
		int n = dao.getRecentlyWrite(userno);
		return n;
	}
	/* 효민 수정 끝 */
}
