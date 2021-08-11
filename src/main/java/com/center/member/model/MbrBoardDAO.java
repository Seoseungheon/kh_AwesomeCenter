package com.center.member.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.center.member.service.InterMbrBoardService;

@Repository
public class MbrBoardDAO implements InterMbrBoardDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// 페이징 처리를 위한 글 갯수 가져오기
	@Override
	public int getTotalCountWithNOsearch(String userno) {
		int count = sqlsession.selectOne("awesomeMbrBoard.getTotalCountWithNOsearch", userno);
		return count;
	}

	// 1:1 문의 내역
	@Override
	public List<QnAVO> getQnAList(HashMap<String, String> map) {
		List<QnAVO> QnAList = sqlsession.selectList("awesomeMbrBoard.getQnAList", map);
		return QnAList;
	}

	// 1:1 문의 자세히
	@Override
	public QnAVO getQnAView(String no) {
		QnAVO qna = sqlsession.selectOne("awesomeMbrBoard.getQnAView", no);
		return qna;
	}

	// 1:1 문의 삭제
	@Override
	public int delQuestion(String no) {
		int n = sqlsession.delete("awesomeMbrBoard.delQuestion", no);
		return n;
	}

	// 1:1 문의 수정
	@Override
	public int editQuestion(HashMap<String, String> map) {
		int n = sqlsession.update("awesomeMbrBoard.editQuestion", map);
		return n;
	}

	// 1:1 문의 작성
	@Override
	public int writeQuestion(HashMap<String, String> map) {
		int n = sqlsession.insert("awesomeMbrBoard.writeQuestion", map);
		return n;
	}

	// 관리자용 1:1 문의 내역 갯수
	@Override
	public int getTotalCountWithNOsearchAdmin() {
		int n = sqlsession.selectOne("awesomeMbrBoard.getTotalCountWithNOsearchAdmin");
		return n;
	}

	// 관리자용 1:1 문의 내역
	@Override
	public List<QnAVO> getQnAListAdmin(HashMap<String, String> map) {
		List<QnAVO> QnAList = sqlsession.selectList("awesomeMbrBoard.getQnAListAdmin", map);
		return QnAList;
	}

	// 관리자용 1:1 문의 답변 수정
	@Override
	public int answerEdit(HashMap<String, String> map) {
		int n = sqlsession.update("awesomeMbrBoard.answerEdit", map);
		return n;
	}

	/* 효민 수정 */
	
	@Override
	public List<HopeBoardVO> boardListWithPagingHM(HashMap<String, String> paraMap) {
		List<HopeBoardVO> boardList = sqlsession.selectList("awesomeMbrBoard.boardListWithPagingHM", paraMap);
		return boardList;
	}

	@Override
	public int getTotalCountWithSearchHM(HashMap<String, String> paraMap) {
		int count = sqlsession.selectOne("awesomeMbrBoard.getTotalCountWithSearchHM", paraMap);
		return count;
	}

	@Override
	public int getTotalCountWithNOsearchHM() {
		int count = sqlsession.selectOne("awesomeMbrBoard.getTotalCountWithNOsearchHM");
		return count;
	}

	@Override
	public int writewishEnd(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("awesomeMbrBoard.writewishEnd", paraMap);
		return n;
	}

	@Override
	public HopeBoardVO getHopeBoardDetail(String no) {
		HopeBoardVO hvo = sqlsession.selectOne("awesomeMbrBoard.getHopeBoardDetail", no);
		return hvo;
	}

	@Override
	public void setAddCount(String no) {
		sqlsession.update("awesomeMbrBoard.setAddCount", no);
	}

	@Override
	public int delHopeBoard(String no) {
		int n = sqlsession.update("awesomeMbrBoard.delHopeBoard", no);
		return n;
	}

	@Override
	public int updateWishEnd(HashMap<String, String> paraMap) {
		int n = sqlsession.update("awesomeMbrBoard.updateWishEnd", paraMap);
		return n;
	}

	@Override
	public int getRecentlyWrite(String userno) {
		int n = sqlsession.selectOne("awesomeMbrBoard.getRecentlyWrite",userno);
		return n;
	}
	
	/* 효민 수정 끝 */
}
