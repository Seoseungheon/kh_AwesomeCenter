package com.center.member.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO implements InterMemberDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// 장바구니 갯수
	@Override
	public String getCartListCnt(String userno) {
		String cartListcnt = sqlsession.selectOne("awesomeMember.getCartListCnt", userno);
		return cartListcnt;
	}
	
	// 수강 내역 갯수
	@Override
	public String getOrderListCnt(String userno) {
		String orderListcnt = sqlsession.selectOne("awesomeMember.getOrderListCnt", userno);
		return orderListcnt;
	}
	
	// 대기자 조회 갯수
	@Override
	public String getWaitingListCnt(String userno) {
		String waitingListcnt = sqlsession.selectOne("awesomeMember.getWaitingListCnt", userno);
		return waitingListcnt;
	}
	
	// 수강 후기 갯수
	@Override
	public String getReviewListCnt(String userno) {
		String reviewListcnt = sqlsession.selectOne("awesomeMember.getReviewListCnt", userno);
		return reviewListcnt;
	}

	// 좋아요 갯수
	@Override
	public String getHeartListCnt(String userno) {
		String heartListcnt = sqlsession.selectOne("awesomeMember.getHeartListCnt", userno);
		return heartListcnt;
	}
	
	// 관심분야 카테고리 번호 채번
	@Override
	public List<String> getCategoryNo(String userno) {
		List<String> categorynoList = sqlsession.selectList("awesomeMember.getCategoryNo", userno);
		return categorynoList;
	}

	// 채번한 번호로 관심분야 조회
	@Override
	public List<CategoryVO> getWishCategoryList(HashMap<String, Object> map) {
		List<CategoryVO> wishcategoryList = sqlsession.selectList("awesomeMember.getWishCategoryList", map);
		return wishcategoryList;
	}
	
	// 카테고리 목록 가져오기
	@Override
	public List<CategoryVO> getCategoryList() {
		List<CategoryVO> categoryList = sqlsession.selectList("awesomeMember.getCategoryList");
		return categoryList;
	}
	
	// 마케팅 수신동의 변경
	@Override
	public int editMarketing(HashMap<String, String> map) {
		int n = sqlsession.update("awesomeMember.editMarketing", map);
		return n;
	}

	// 관심 분야 변경
	@Override
	public int editWishCategory(String userno, String[] cate_no) {
		int n = sqlsession.delete("awesomeMember.deleteWishCategory", userno);
		int m = 0;
		
		if(cate_no != null) {
			List<String> noList = new ArrayList<String>();
			for(int i=0; i<cate_no.length; i++) {
				noList.add(cate_no[i]);
			}
			
			for(int i=0; i<noList.size(); i++) {
				HashMap<String, String> map = new HashMap<String, String>();
				String cateno = noList.get(i);
				map.put("userno", userno);
				map.put("cateno", cateno);
				
				
				m = sqlsession.insert("awesomeMember.insertWishCategory", map);
			}
		} else {
				m = 0;
			}
			
		return n+m;
	}

	// 수강 내역 조회 (검색x)
	@Override
	public List<OrderListVO> getOrderList(String userno) {
		List<OrderListVO> orderList = sqlsession.selectList("awesomeMember.getOrderList", userno);
		return orderList;
	}

	// 수강 내역 강좌 정보 (검색x)
	@Override
	public List<ClassVO> getClassInfo(HashMap<String, Object> map) {
		
		List<ClassVO> classList = sqlsession.selectList("awesomeMember.getClassInfo", map);
	
		return classList;
	}
	
	// 수강 내역 조회 (검색o)
	@Override
	public List<OrderListVO> getOrderListSearch(HashMap<String, String> paraMap) {
		List<OrderListVO> orderListsearch = sqlsession.selectList("awesomeMember.getOrderListSearch", paraMap);
		return orderListsearch;
	}

	// 결제 정보
	@Override
	public HashMap<String, String> getPayInfo(String no) {
		HashMap<String, String> payInfo = sqlsession.selectOne("awesomeMember.getPayInfo", no);
		return payInfo;
	}
	
	// 결제 일자
	@Override
	public String getPayday(String no) {
		String payday = sqlsession.selectOne("awesomeMember.getPayday", no);
		return payday;
	}
	
	// 강사 정보
	@Override
	public TeacherVO getTeacherInfo(String teacherno) {
		TeacherVO teacher = sqlsession.selectOne("awesomeMember.getTeacherInfo", teacherno);
		return teacher;
	}
	
	// 대기자 조회
	@Override
	public List<WaitingVO> getWaitingList(String userno) {
		List<WaitingVO> waitingList = sqlsession.selectList("awesomeMember.getWaitingList", userno);
		return waitingList;
	}
	
	// 강사 리스트
	@Override
	public List<TeacherVO> getTeacherList(HashMap<String, Object> map) {
		List<TeacherVO> teacherList = sqlsession.selectList("awesomeMember.getTeacherList", map);
		return teacherList;
	}
	
	// 대기 목록 삭제
	@Override
	public int cancelWait(HashMap<String, Object> map) {
		int n = sqlsession.delete("awesomeMember.cancelWait", map);
		return n;
	}

	// 강좌 번호 채번
	@Override
	public String getClassno(String no) {
		String classno = sqlsession.selectOne("awesomeMember.getClassno", no);
		return classno;
	}
	
	// 결제 취소
	@Override
	public int payCancelEnd(HashMap<String, String> map) {
		int n = sqlsession.delete("awesomeMember.payCancelEnd", map);
		return n;
	}
	
	// 수강 내역 취소완료 변경
	@Override
	public int editOrderlist(HashMap<String, String> map) {
		int n = sqlsession.update("awesomeMember.editOrderlist", map);
		return n;
	}
	
	// 취소한 강좌에 대한 대기 번호 1번인 유저 번호
	@Override
	public String getWaitingNo(HashMap<String, String> map) {
		String waitno = sqlsession.selectOne("awesomeMember.getWaitingNo", map);
		return waitno;
	}
	
	// 대기번호 1번인 유저의 전화번호
	@Override
	public String getHp(String waitno) {
		String hp = sqlsession.selectOne("awesomeMember.getHp", waitno);
		return hp;
	}

	// 문자 전송 후 대기자 상태 변경
	@Override
	public void updateWait(HashMap<String, String> map) {
		sqlsession.delete("awesomeMember.updateWait", map);
	}
	
	// 수강이 끝난 수강내역
	@Override
	public List<OrderListVO> getOrderListEnd(String userno) {
		List<OrderListVO> orderList = sqlsession.selectList("awesomeMember.getOrderListEnd", userno);
		return orderList;
	}
	
	// 수강이 끝난 수강내역
	@Override
	public List<OrderListVO> getOrderListSearchEnd(HashMap<String, String> paraMap) {
		List<OrderListVO> orderListsearch = sqlsession.selectList("awesomeMember.getOrderListSearchEnd", paraMap);
		return orderListsearch;
	}
	
	// 수강 후기
	@Override
	public List<ReviewVO> getReview(HashMap<String, Object> map) {
		
		List<ReviewVO> reviewList = new ArrayList<ReviewVO>();
		
		HashMap<String, String> paraMap = null;
		
		String[] noArr = (String[]) map.get("noArr");
		String userno = (String) map.get("userno");
		
		for(int i=0; i<noArr.length; i++) {
			String classno = noArr[i];
			
			paraMap = new HashMap<String, String>();
			paraMap.put("userno", userno);
			paraMap.put("classno", classno);
			
			ReviewVO review = sqlsession.selectOne("awesomeMember.getReview", paraMap);
			
			if(review == null) {
				ReviewVO noReview = new ReviewVO();
				reviewList.add(noReview);
			} else {
				reviewList.add(review);
			}
			
		}
	
		return reviewList;
	}
	
	// 강좌별 연령대 차트
	@Override
	public List<HashMap<String, String>> ageJSON(String class_seq) {
		List<HashMap<String, String>> agePercentList = sqlsession.selectList("awesomeMember.ageJSON", class_seq);
		return agePercentList;
	}
	
	
	
	
	
	// 스케쥴러 강좌 시작날짜, 끝날짜를 알아오기 위한 강좌 목록
	@Override
	public List<OrderListVO> getAllOrderList() {
		List<OrderListVO> orderList = sqlsession.selectList("awesomeMember.getAllOrderList");
		return orderList;
	}
	
	// 강좌별 시작날짜, 끝날짜 조회
	@Override
	public List<ClassVO> getAllClassList(HashMap<String, Object> map) {
		List<ClassVO> classList = sqlsession.selectList("awesomeMember.getAllClassList", map);
		return classList;
	}
	
	// 주문내역 상태 업데이트
	@Override
	public int updateOrderListStatus(HashMap<String, String> paraMap) {
		int n = sqlsession.update("awesomeMember.updateOrderListStatus", paraMap);
		return n;
	}
	
	// 강좌 개강 시 대기목록 삭제
	@Override
	public int deleteWaitingList(String classno) {
		int n = sqlsession.delete("awesomeMmeber.deleteWaitingList", classno);
		return n;
	}
	
	
	
	
	
	
	
	/* 최효민 : 시작 */
	@Override
	public int idCheck(String userid) {
		int n = sqlsession.selectOne("awesomeMember.idCheck", userid);
		
		return n;
	}

	@Override
	public int registerUser(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("awesomeMember.insertUser", paraMap);
		return n;
	}

	@Override
	public MemberVO isExistUser(HashMap<String, String> paraMap) {
		MemberVO loginuser = sqlsession.selectOne("awesomeMember.isExistUser",paraMap);
		return loginuser;
	}

	@Override
	public int setLoginday(String userno) {
		int n = sqlsession.update("awesomeMember.setLoginday", userno);
		return n;
	}

	@Override
	public int setUserPwd(HashMap<String, String> paraMap) {
		int n = sqlsession.update("awesomeMember.setUserPwd", paraMap);
		return n;
	}

	@Override
	public int updateEditDay(HashMap<String, String> paraMap) {
		int n = sqlsession.update("awesomeMember.updateEditDay", paraMap);
		return n;
	}

	@Override
	public int updateUser(HashMap<String, String> paraMap) {
		int n = sqlsession.update("awesomeMember.updateUser", paraMap);
		return n;
	}

	@Override
	public int delUser(String userno) {
		int n = sqlsession.update("awesomeMember.delUser", userno);
		return n;
	}

	@Override
	public String findidByEmail(HashMap<String, String> paraMap) {
		String userid = sqlsession.selectOne("awesomeMember.findidByEmail", paraMap);
		return userid;
	}

	@Override
	public String findidByHp(HashMap<String, String> paraMap) {
		String userid = sqlsession.selectOne("awesomeMember.findidByHp", paraMap);
		return userid;
	}

	@Override
	public int updatePW(HashMap<String, String> paraMap) {
		int n = sqlsession.update("awesomeMember.updatePW", paraMap);
		return n;
	}

	@Override
	public MemberVO getUserById(String userid) {
		MemberVO memvo = sqlsession.selectOne("awesomeMember.getUserById", userid);
		return memvo;
	}

	@Override
	public List<MemberVO> getDelUserList() {
		List<MemberVO> delUserList = sqlsession.selectList("awesomeMember.getDelUserList");
		return delUserList;
	}

	@Override
	public void delDBuser(String userno) {
		sqlsession.delete("awesomeMember.delDBuser",userno);
	}
	
	@Override
	public List<HashMap<String, String>> getgenderJSON(String class_seq) {
		List<HashMap<String, String>> genderPercentList = sqlsession.selectList("awesomeMember.genderJSON", class_seq);
		return genderPercentList;
	}
	
	/* 최효민 : 끝 */
	
	// ===----- 회원목록 -----=== //
	@Override
	public int getTotalCountWithNOsearch() {
		int count = sqlsession.selectOne("awesomeMember.getTotalCountWithNOsearch");
		return count;
	}

	@Override
	public int getTotalCountWithSearch(HashMap<String, String> paraMap) {
		int count = sqlsession.selectOne("awesomeMember.getTotalCountWithSearch", paraMap);
		return count;
	}
	
	// ===----- 회원목록 -----=== //
	
	// 관리자 회원목록 
	@Override
	public List<MemberVO> memberListWithPaging(HashMap<String, String> paraMap) {
		List<MemberVO> memberList = sqlsession.selectList("awesomeMember.memberListWithPaging", paraMap);
		
		return memberList;
		
		
	}

	// 관리자 수강생 정보
	@Override
	public MemberVO getOneMemberDetail(String userno) {
		MemberVO membervo = sqlsession.selectOne("awesomeMember.getOneMemberDetail", userno);
		return membervo;
	}
	
	// 관리자 회원목록 - 회원 탈퇴
	@Override
	public int memberwithdrawal(MemberVO membervo, String userno) {
		int n = sqlsession.update("awesomeMember.memberwithdrawal", userno);
		
		return n;
	}

	@Override
	public List<OrderListVO> getOnememberclassDetail(String userno_fk) {
		List<OrderListVO> orderlistvo = sqlsession.selectList("awesomeMember.getOnememberclassDetail", userno_fk);
		
		return orderlistvo;
	}
	
	// 관리자 수강정보 - 수강취소(환불) 
	@Override
	public int admindeleteClass(OrderListVO orderlistvo, String orderlistno) {
		int n = sqlsession.update("awesomeMember.admindeleteClass", orderlistno);
		return n;
	}



}
