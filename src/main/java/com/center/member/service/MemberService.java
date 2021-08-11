package com.center.member.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.center.member.model.InterMemberDAO;
import com.center.member.model.MemberVO;
import com.center.member.model.OrderListVO;
import com.center.member.model.ReviewVO;
import com.center.member.model.TeacherVO;
import com.center.member.model.WaitingVO;
import com.center.member.model.CategoryVO;
import com.center.member.model.ClassVO;

@Service
public class MemberService implements InterMemberService {
	
	@Autowired
	private InterMemberDAO dao;

	// 장바구니 갯수
	@Override
	public String getCartListCnt(String userno) {
		String cartListcnt = dao.getCartListCnt(userno);
		return cartListcnt;
	}
	
	// 수강 내역 갯수
	@Override
	public String getOrderListCnt(String userno) {
		String orderListcnt = dao.getOrderListCnt(userno);
		return orderListcnt;
	}
	
	// 대기자 조회 갯수
	@Override
	public String getWaitingListCnt(String userno) {
		String waitingListcnt = dao.getWaitingListCnt(userno);
		return waitingListcnt;
	}
	
	// 수강 후기 갯수
	@Override
	public String getReviewListCnt(String userno) {
		String reviewListcnt = dao.getReviewListCnt(userno);
		return reviewListcnt;
	}
	
	// 좋아요 갯수
	@Override
	public String getHeartListCnt(String userno) {
		String heartListcnt = dao.getHeartListCnt(userno);
		return heartListcnt;
	}
	
	// 관심분야 카테고리 번호 채번
	@Override
	public List<String> getCategoryNo(String userno) {
		List<String> categorynoList = dao.getCategoryNo(userno);
		return categorynoList;
	}
	
	// 채번한 번호로 관심분야 조회
	@Override
	public List<CategoryVO> getWishCategoryList(HashMap<String, Object> map) {
		List<CategoryVO> wishcategoryList = dao.getWishCategoryList(map);
		return wishcategoryList;
	}
	
	// 카테고리 목록 가져오기
	@Override
	public List<CategoryVO> getCategoryList() {
		List<CategoryVO> categoryList = dao.getCategoryList();
		return categoryList;
	}
	
	// 마케팅 수신동의 변경
	@Override
	public int editMarketing(HashMap<String, String> map) {
		int n = dao.editMarketing(map);
		return n;
	}

	// 관심 분야 변경
	@Override
	public int editWishCategory(String userno, String[] cate_no) {
		int n = dao.editWishCategory(userno, cate_no);
		return n;
	}	

	// 수강 내역 조회 (검색x)
	@Override
	public List<OrderListVO> getOrderList(String userno) {
		List<OrderListVO> orderList = dao.getOrderList(userno);
		return orderList;
	}

	// 수강 내역 강좌 정보 (검색x)
	@Override
	public List<ClassVO> getClassInfo(HashMap<String, Object> map) {
		List<ClassVO> classList = dao.getClassInfo(map);
		return classList;
	}

	// 수강 내역 조회 (검색o)
	@Override
	public List<OrderListVO> getOrderListSearch(HashMap<String, String> paraMap) {
		List<OrderListVO> orderListSearch = dao.getOrderListSearch(paraMap);
		return orderListSearch;
	}
	
	// 결제 정보
	@Override
	public HashMap<String, String> getPayInfo(String no) {
		HashMap<String, String> payInfo = dao.getPayInfo(no);
		return payInfo;
	}
	
	// 결제 일자
	@Override
	public String getPayday(String no) {
		String payday = dao.getPayday(no);
		return payday;
	}
	
	// 강사 정보
	@Override
	public TeacherVO getTeacherInfo(String teacherno) {
		TeacherVO teacher = dao.getTeacherInfo(teacherno);
		return teacher;
	}
	
	// 대기자 조회
	@Override
	public List<WaitingVO> getWaitingList(String userno) {
		List<WaitingVO> waitingList = dao.getWaitingList(userno);
		return waitingList;
	}
	
	// 강사 리스트
	@Override
	public List<TeacherVO> getTeacherList(HashMap<String, Object> map) {
		List<TeacherVO> teacherList = dao.getTeacherList(map);
		return teacherList;
	}
	
	// 대기 목록 삭제
	@Override
	public int cancelWait(HashMap<String, Object> map) {
		int n = dao.cancelWait(map);
		return n;
	}
	
	// 강좌 번호 채번
	@Override
	public String getClassno(String no) {
		String classno = dao.getClassno(no);
		return classno;
	}

	// 결제 취소
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int payCancelEnd(HashMap<String, String> map) {
		int n = dao.payCancelEnd(map);
		int m = 0;
		if (n==1) {
			m = dao.editOrderlist(map);
		}
		return n*m;
	}
		
	// 취소한 강좌에 대한 대기 번호 1번인 유저 번호
	@Override
	public String getWaitingNo(HashMap<String, String> map) {
		String waitno = dao.getWaitingNo(map);
		return waitno;
	}
	
	// 대기번호 1번인 유저의 전화번호
	@Override
	public String getHp(String waitno) {
		String hp = dao.getHp(waitno);
		return hp;
	}
	
	// 문자 전송 후 대기자 변경
	@Override
	public void updateWait(HashMap<String, String> map) {
		dao.updateWait(map);
	}
	
	// 수강이 끝난 수강내역
	@Override
	public List<OrderListVO> getOrderListEnd(String userno) {
		List<OrderListVO> orderList = dao.getOrderListEnd(userno);
		return orderList;
	}
	
	// 수강이 끝난 수강내역
	@Override
	public List<OrderListVO> getOrderListSearchEnd(HashMap<String, String> paraMap) {
		List<OrderListVO> orderListsearch = dao.getOrderListSearchEnd(paraMap);
		return orderListsearch;
	}
	
	// 수강 후기
	@Override
	public List<ReviewVO> getReview(HashMap<String, Object> map) {
		List<ReviewVO> reviewList = dao.getReview(map);
		return reviewList;
	}
	
	// 강좌별 연령대 차트
	@Override
	public List<HashMap<String, String>> ageJSON(String class_seq) {
		List<HashMap<String, String>> agePercentList = dao.ageJSON(class_seq);
		return agePercentList;
	}
	
	
	
	
	
	
	
	
	
	
	/* 최효민 : 시작 */
	@Override
	public int idCheck(String userid) {
		int n = dao.idCheck(userid);
		return n;
	}

	@Override
	public int registerUser(HashMap<String, String> paraMap) {
		int n = dao.registerUser(paraMap);
		return n;
	}

	@Override
	public MemberVO isExistUser(HashMap<String, String> paraMap) {
		MemberVO loginuser = dao.isExistUser(paraMap);
		return loginuser;
	}

	@Override
	public int setLoginday(String userno) {
		int n = dao.setLoginday(userno);
		return n;
	}

	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	@Override
	public int setUserPwd(HashMap<String, String> paraMap) {
		int result = 0;
		int n = 0;
		n = dao.setUserPwd(paraMap);
		if(n==1) {
			result = dao.updateEditDay(paraMap);
		}
		return result;
	}

	@Override
	public int updateUser(HashMap<String, String> paraMap) {
		int result = 0;
		int n = 0;
		n = dao.updateUser(paraMap);
		if(n==1) {
			result = dao.updateEditDay(paraMap);
		}
		
		return result;
	}

	@Override
	public int delUser(String userno) {
		int n = dao.delUser(userno);
		return n;
	}

	@Override
	public String findidByEmail(HashMap<String, String> paraMap) {
		String userid = dao.findidByEmail(paraMap);
		return userid;
	}

	@Override
	public String findidByHp(HashMap<String, String> paraMap) {
		String userid = dao.findidByHp(paraMap);
		return userid;
	}

	@Override
	public int updatePW(HashMap<String, String> paraMap) {
		int result = 0;
		int n = 0;
		n = dao.updatePW(paraMap);
		if(n==1) {
			result = dao.updateEditDay(paraMap);
		}
		return result;
	}

	@Override
	public MemberVO getUserById(String userid) {
		MemberVO memvo = dao.getUserById(userid);
		return memvo;
	}

	@Override
	public List<HashMap<String, String>> genderJSON(String class_seq) {
		List<HashMap<String, String>> genderPercentList = dao.getgenderJSON(class_seq);
		return genderPercentList;
	}
	




	
	/* 최효민 : 끝 */
	
	// ===----- 회원목록 -----=== // 
	
	@Override
	public int getTotalCountWithNOsearch() {
		int count = dao.getTotalCountWithNOsearch();
		return count;
	}

	@Override
	public int getTotalCountWithSearch(HashMap<String, String> paraMap) {
		int count = dao.getTotalCountWithSearch(paraMap);
		return count;
	}

	@Override
	public List<MemberVO> memberListWithPaging(HashMap<String, String> paraMap) {
		List<MemberVO> memberList = dao.memberListWithPaging(paraMap);
		
		return memberList;
	}
	// 관리자 회원목록 - 상세정보 
	@Override 
	public MemberVO getOnememberInfo(String userno) {
		MemberVO membervo = dao.getOneMemberDetail(userno);
		return membervo;
	}

	// 관리자 회원목록 - 회원 탈퇴
	@Override
	public int memberwithdrawal(MemberVO membervo, String userno) {
		int n = dao.memberwithdrawal(membervo, userno);
		return n;
	}

	// 관리자 회원목록 - 수강정보 
	@Override
	public List<OrderListVO> getOnememberClass(String userno_fk) {
		List<OrderListVO> orderlistvo = dao.getOnememberclassDetail(userno_fk);
		
		return orderlistvo;
	}
	
	// 관리자 수강정보 - 수강취소(환불) 
	@Override
	public int admindeleteClass(OrderListVO orderlistvo, String orderlistno) {
		int n = dao.admindeleteClass(orderlistvo, orderlistno);
		return n;
	}


	
	

	// ===----- 회원목록 -----=== // 
	
	
	
	
	
}
