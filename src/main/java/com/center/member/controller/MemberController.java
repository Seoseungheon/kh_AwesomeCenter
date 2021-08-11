package com.center.member.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.center.common.MyUtil;
import com.center.common.SHA256;
import com.center.member.model.CategoryVO;
import com.center.member.model.ClassVO;
import com.center.member.model.MemberVO;
import com.center.member.model.OrderListVO;
import com.center.member.model.ReviewVO;
import com.center.member.model.TeacherVO;
import com.center.member.model.WaitingVO;
import com.center.member.service.InterMemberService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@Controller
public class MemberController {

	@Autowired
	private InterMemberService service;
	
	// 마이페이지
	@RequestMapping(value="/member/mypage.to")
	public ModelAndView requiredLogin_mypage(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); 
		
		String userno = "";
		if(loginuser != null) {
			userno = loginuser.getUserno();
		}
		
			// 장바구니 갯수
			String cartListcnt = service.getCartListCnt(userno);
			mav.addObject("cartListcnt", cartListcnt);
		
			// 수강 내역 갯수
			String orderListcnt = service.getOrderListCnt(userno);
			mav.addObject("orderListcnt", orderListcnt);
			
			// 대기자 조회 갯수
			String waitingListcnt = service.getWaitingListCnt(userno);
			mav.addObject("waitingListcnt", waitingListcnt);
			
			// 수강 후기 갯수
			String reviewListcnt = service.getReviewListCnt(userno);
			mav.addObject("reviewListcnt", reviewListcnt);
			
			// 좋아요 갯수
			String heartListcnt = service.getHeartListCnt(userno);
			mav.addObject("heartListcnt", heartListcnt);
			
			// 관심분야 카테고리 번호 채번
			List<String> categorynoList = service.getCategoryNo(userno);
			
			String[] noArr = new String[categorynoList.size()];
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			for(int i=0; i<categorynoList.size(); i++) {
				noArr[i] = categorynoList.get(i);
			}
			
			map.put("noArr", noArr);
			
			// 채번한 번호로 관심분야 조회
						List<CategoryVO> wishcategoryList = null;
						
						if( !(noArr.length == 0) ) {
							wishcategoryList = service.getWishCategoryList(map);
							
							int y = wishcategoryList.size();
							
							String wish1 = "";
							String wish2 = "";
							String wish3 = "";
							
							/*String[] wishArr = new String[wishcategoryList.size()];*/
							
							for(int i=0; i<y; i++) {
								/*wishArr[i] = wishcategoryList.get(i).getCate_no();*/
								if(i==0) {
									wish1 = wishcategoryList.get(i).getCate_no();
								} else if(i==1) {
									wish2 = wishcategoryList.get(i).getCate_no();
								} else {
									wish3 = wishcategoryList.get(i).getCate_no();
								}
							}
							
							mav.addObject("wish1", wish1);
							mav.addObject("wish2", wish2);
							mav.addObject("wish3", wish3);
						}
			
			// 카테고리 목록 가져오기
			List<CategoryVO> categoryList = service.getCategoryList();			
			
			if(wishcategoryList != null) {
			mav.addObject("wishcategoryList", wishcategoryList);
			}
			mav.addObject("categoryList", categoryList);

			mav.setViewName("member/mypage/mypage.tiles1");
		
		return mav;
			
	}
	
	// 마케팅 수신동의 변경
	@RequestMapping(value="/member/editMarketing.to", method= {RequestMethod.GET})
	public ModelAndView editMarketing(ModelAndView mav, HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userno = "";
		
		if(loginuser != null) {
			userno = loginuser.getUserno();
		}
		
		String emailCheck = request.getParameter("email_kdh");
		String smsCheck = request.getParameter("sms_kdh");
		
		if(emailCheck == null) {
			emailCheck = "N";
		}
		if(smsCheck == null) {
			smsCheck = "N";
		}
		
		HashMap<String,String> map = new HashMap<String, String>();
		map.put("emailCheck", emailCheck);
		map.put("smsCheck", smsCheck);
		map.put("userno", userno);
		
		int n = service.editMarketing(map);
		
		if(n==1) {
			
			loginuser.setMarketing_email(emailCheck);
			loginuser.setMarketing_sms(smsCheck);
			
			String msg = "저장되었습니다.";
			String loc = request.getContextPath()+"/member/mypage.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		} 
		
		return mav;
		
	}
	
	// 관심 분야 변경
	@RequestMapping(value="/member/editWishCategory.to", method= {RequestMethod.GET})
	public ModelAndView editWishCategory(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userno = "";
		
		if(loginuser != null) {
			userno = loginuser.getUserno();
		}
		
		String onArr = request.getParameter("onArr");
		
		String[] cate_no = null;
		
		if(onArr == null || "".equals(onArr)) {
			cate_no = null;
		} else {
			cate_no = onArr.split(",");
		}
		
		int n = service.editWishCategory(userno, cate_no);
		
		if(n>=1) {
			String msg = "저장되었습니다";
			String loc = request.getContextPath()+"/member/mypage.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		} else {
			String msg = "꺼졍";
			String loc = request.getContextPath()+"/main.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	// 수강내역
	@RequestMapping(value="/member/lectureList.to", method= {RequestMethod.GET})
	public ModelAndView requiredLogin_lectureList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null) {
			mav.setViewName("member/login/login.tiles1");
		} else {
		String userno = "";
		
		if(loginuser != null) {
			userno = loginuser.getUserno();
		}
		
		String year = request.getParameter("year");
		String term = request.getParameter("term");
		
		// 년도, 학기 설정 없이 초기 로딩
		if(("".equals(year) || year == null) && ("".equals(term) ||term == null)){
		
		// 수강내역
		List<OrderListVO> orderList = service.getOrderList(userno);
		
		String[] noArr = new String[orderList.size()];
		
		if(! (orderList.size() == 0)) {
		// 수강 내역 강좌 정보
			for (int i=0; i<orderList.size(); i++) {
				String classno = orderList.get(i).getClass_seq_fk();
				noArr[i] = classno;
			}
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("noArr", noArr);
			
			List<ClassVO> classList = service.getClassInfo(map);
			
			mav.addObject("orderList", orderList);
			mav.addObject("classList", classList);
		
		}
		
		else {
			mav.addObject("year", year);
			mav.addObject("term", term);
			mav.addObject("orderList", null);
		}
		}
		
		// 년도, 학기 검색
		else {
			
			HashMap<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("year", year);
			paraMap.put("term", term);
			paraMap.put("userno", userno);
			
			List<OrderListVO> orderListSearch = service.getOrderListSearch(paraMap);
			
			if(! (orderListSearch.size() == 0)) {
			
			String[] noArr = new String[orderListSearch.size()];
			
			// 수강 내역 강좌 정보
			for (int i=0; i<orderListSearch.size(); i++) {
				String classno = orderListSearch.get(i).getClass_seq_fk();
				noArr[i] = classno;
			}
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("noArr", noArr);
			
			List<ClassVO> classListSearch = service.getClassInfo(map);
			
			mav.addObject("year", year);
			mav.addObject("term", term);
			mav.addObject("orderList", orderListSearch);
			mav.addObject("classList", classListSearch);
			
			}
			
			else {
				
				mav.addObject("year", year);
				mav.addObject("term", term);
				mav.addObject("orderList", null);
			}
		}
		
		mav.setViewName("member/mypage/lectureList.tiles1");
		
		}
		return mav;
	}
	
	// 결제 정보
	@RequestMapping(value="/member/mypage/payInfo.to", method= {RequestMethod.GET})
	public ModelAndView payInfo(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null) {
			String msg="로그인을 하십시오.";
			String loc="self.close()";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		} else {
			
			String no = request.getParameter("no");
			
			HashMap<String, String> payInfo = service.getPayInfo(no);
			String startD = service.getPayday(no);
			
			int startday = Integer.parseInt(startD);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());
			
			int today = Integer.parseInt(strToday);
			
			int day = startday - today;
			
			if( ! loginuser.getUserno().equals(payInfo.get("userno_fk"))  ) {
				String msg="비정상적인 접근입니다..";
				String loc="self.close()";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
				
			} else {
		
				String teacherno = payInfo.get("fk_teacher_seq");
				
				// 강사 정보
				TeacherVO teacher = service.getTeacherInfo(teacherno); 
				
				mav.addObject("day", day);
				mav.addObject("teacher", teacher);
				mav.addObject("payInfo", payInfo);
				mav.setViewName("member/mypage/payInfo");
					
			}
			
		}
		
		return mav;
	}
	
	// 대기자 조회
	@RequestMapping(value="/member/waitingList.to")
	public ModelAndView requiredLogin_classList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userno = "";
		if(loginuser != null) {
			userno = loginuser.getUserno();
		}
		
		List<WaitingVO> waitingList = service.getWaitingList(userno);
		
		String[] noArr = new String[waitingList.size()];
		
		if(! (waitingList.size() == 0)) {
		// 수강 내역 강좌 정보
			for (int i=0; i<waitingList.size(); i++) {
				String classno = waitingList.get(i).getClassno_fk();
				noArr[i] = classno;
			}
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("noArr", noArr);
			
			List<ClassVO> classList = service.getClassInfo(map);
			
			String[] teacherArr = new String[classList.size()];
			
			if(! (classList.size() == 0)) {
				// 강사 정보
				for(int i=0; i<classList.size(); i++) {
					String teacherno = classList.get(i).getFk_teacher_seq();
					teacherArr[i] = teacherno;
				}
				
				map.put("teacherArr", teacherArr);
				
				List<TeacherVO> teacherList = service.getTeacherList(map);
				
				mav.addObject("teacherList", teacherList);
			}
			
			mav.addObject("classList", classList);
		}
		
		mav.addObject("waitingList", waitingList);
		
		mav.setViewName("member/mypage/waitingList.tiles1");
		
		return mav;
	}
	
	// 대기 목록 삭제
	@RequestMapping(value="/member/cancelWait.to")
	public ModelAndView cancelWait(HttpServletRequest request, ModelAndView mav) {
		String[] seq = request.getParameterValues("seq");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("seq", seq);
		
		if(! (seq.length == 0) ) {
			int n = service.cancelWait(map);
			
			if(n >= 1 ) {
				String msg = "삭제되었습니다.";
				String loc = request.getContextPath()+"/member/waitingList.to";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
			}
		} else {
		
		mav.setViewName("member/mypage/waitingList.tiles1");
		
		}
		
		return mav;
	}
	
	
	// 결제 취소 확인
	@RequestMapping(value="/member/payCancelCheck.to", method= {RequestMethod.POST})
	public String payCancelCheck(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		String no = request.getParameter("no");
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		request.setAttribute("hp1", loginuser.getHp1());
		request.setAttribute("hp2", loginuser.getHp2());
		request.setAttribute("hp3", loginuser.getHp3());
		
		request.setAttribute("no", no);
		
		return "member/mypage/payCancelCheck";
	}
	
	// 결제 취소
	@RequestMapping(value="/member/payCancelEnd.to", method= {RequestMethod.POST})
	public ModelAndView payCancelEnd(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String pwd = loginuser.getUserpw();
		
		String no = request.getParameter("no");
		String pw = SHA256.encrypt(request.getParameter("pw"));
		
		if(pw.equals(pwd)) {
			
			String userno = loginuser.getUserno();
			
			// 강좌 번호 채번
			String classno = service.getClassno(no);
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("userno", userno);
			map.put("classno", classno);
			map.put("no", no);
			
			int n = service.payCancelEnd(map);
			
			if(n > 0) {
				String msg = "취소되었습니다";
				String loc = "javascript:self.close(); javascript:opener.location.reload();";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
				
/////////////////////////////////////////////////////////////////////
				// 취소한 강좌에 대한 대기 번호 1번인 유저 번호
				String waitno = service.getWaitingNo(map);
				
				if(waitno != null) {
					
					// 1번인 유저의 전화 번호
					String hp = service.getHp(waitno);
					
					/*String api_key = MyUtilHM.coolKey(); //api key*/					
					String api_key = "test"; //api key			        
					/*String api_secret = MyUtilHM.coolSecretKey();  //api secret */			        
					String api_secret = "test";
			        com.center.sms.Coolsms coolsms = new com.center.sms.Coolsms(api_key, api_secret);
	
			        HashMap<String, String> params = new HashMap<String, String>();
			        params.put("to", hp);
	
			        params.put("from", "01086885219"); 
			        params.put("text", "니 차례다."); 
			        params.put("type", "sms");
			        params.put("mode", "test");
			        //문자메세지 확인용
			        System.out.println(params);
	
			        JSONObject result = coolsms.send(params);
			        System.out.println(result.get("code"));
			        
			        map.put("waitno", waitno);
			        
			        service.updateWait(map);
			        
				}

			}
			
		}
		else {
			String msg = "비밀번호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		} 
		
		return mav;
	}
	
	// 수강 후기
	@RequestMapping(value="/member/review.to")
	public ModelAndView requiredLogin_review(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userno = "";
		
		if(loginuser != null) {
			userno = loginuser.getUserno();
		}
		
		String year = request.getParameter("year");
		String term = request.getParameter("term");
		
		// 년도, 학기 설정 없이 초기 로딩
		if(("".equals(year) || year == null) && ("".equals(term) ||term == null)){
		
		// 수강이 끝난 수강내역
		List<OrderListVO> orderList = service.getOrderListEnd(userno);
		
		String[] noArr = new String[orderList.size()];
		
		if(! (orderList.size() == 0)) {
		// 수강 내역 강좌 정보
			for (int i=0; i<orderList.size(); i++) {
				String classno = orderList.get(i).getClass_seq_fk();
				noArr[i] = classno;
			}
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("noArr", noArr);
			
			List<ClassVO> classList = service.getClassInfo(map);
			map.clear();
			
			noArr = new String[classList.size()];
			
			if(! (classList.size() == 0) ) {
				
				for(int i=0; i<classList.size(); i++) {
					String classno = classList.get(i).getClass_seq();
					noArr[i] = classno;
				}
				
				map.put("userno", userno);
				map.put("noArr", noArr);
				
				List<ReviewVO> reviewList = service.getReview(map);
				
				mav.addObject("reviewList", reviewList);
			}
			
			mav.addObject("orderList", orderList);
			mav.addObject("classList", classList);
		
		}
		
		else {
			mav.addObject("year", year);
			mav.addObject("term", term);
			mav.addObject("orderList", null);
		}
		}
		
		// 년도, 학기 검색
		else {
			
			HashMap<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("year", year);
			paraMap.put("term", term);
			paraMap.put("userno", userno);
			
			// 수강이 끝난 수강내역
			List<OrderListVO> orderListSearch = service.getOrderListSearchEnd(paraMap);
			
			if(! (orderListSearch.size() == 0)) {
			
			String[] noArr = new String[orderListSearch.size()];
			
			// 수강 내역 강좌 정보
			for (int i=0; i<orderListSearch.size(); i++) {
				String classno = orderListSearch.get(i).getClass_seq_fk();
				noArr[i] = classno;
			}
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("noArr", noArr);
			
			List<ClassVO> classListSearch = service.getClassInfo(map);
			
			map.clear();
			
			noArr = new String[classListSearch.size()];
			
			if(! (classListSearch.size() == 0) ) {
				
				for(int i=0; i<classListSearch.size(); i++) {
					String classno = classListSearch.get(i).getClass_seq();
					noArr[i] = classno;
				}
				
				map.put("userno", userno);
				map.put("noArr", noArr);
				
				List<ReviewVO> reviewList = service.getReview(map);
				
				mav.addObject("reviewList", reviewList);
			}
			mav.addObject("year", year);
			mav.addObject("term", term);
			mav.addObject("orderList", orderListSearch);
			mav.addObject("classList", classListSearch);
			
			}
			
			else {
				
				mav.addObject("year", year);
				mav.addObject("term", term);
				mav.addObject("orderList", null);
			}
		}
		
		mav.setViewName("member/mypage/review.tiles1");
		
		return mav;
		
	}
	
	// 센터 찾기
	@RequestMapping(value="/centerplace.to")
	public String CenterPlace(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		return "member/centerplace.tiles1";
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 회원목록 페이지 - 관리자 
		@RequestMapping(value="/adminMemberList.to", method= {RequestMethod.GET})
		public ModelAndView adminMemberList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav ,MemberVO membervo) {
			
			HttpSession sessionmem = request.getSession();
			MemberVO loginuser = (MemberVO) sessionmem.getAttribute("loginuser");
			
			if(loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
				
				String msg="관리자만 접근 가능한 페이지입니다.";
				String loc="main.to";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
				
			} else {
			
			List<MemberVO> memberList = null;
			
					String str_currentShowPageNo = request.getParameter("currentShowPageNo"); 
					
					int totalCount = 0;         // 총게시물 건수
					int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 수 
					int currentShowPageNo = 0;  // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
					int totalPage = 0;          // 총 페이지수(웹브라우저상에 보여줄 총 페이지 갯수, 페이지바) 
					
					int startRno = 0;           // 시작 행번호
					int endRno = 0;             // 끝 행번호
					
					
					String searchType = request.getParameter("searchType"); 
					String searchWord = request.getParameter("searchWord"); 
					
					if(searchWord == null || searchWord.trim().isEmpty() ) {
						searchWord = "";
					}
					
					HashMap<String,String> paraMap = new HashMap<String,String>(); 
					paraMap.put("searchType", searchType);
					paraMap.put("searchWord", searchWord);
				
				    // 검색조건이 없을 경우의 총 게시물 건수(totalCount)
					if("".equals(searchWord)) {
						totalCount = service.getTotalCountWithNOsearch();
					}
					
					// 검색조건이 있을 경우의 총 게시물 건수(totalCount)
					else {
						totalCount = service.getTotalCountWithSearch(paraMap);
					}
					
					totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );  
					
					if(str_currentShowPageNo == null) {
						// 게시판에 보여지는 초기화면
						
						currentShowPageNo = 1;
						// 즉, 초기화면은  /list.action?currentShowPageNo=1 로 한다는 말이다.
					}
					else {
						
						try {
							  currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
							
							  if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
								  currentShowPageNo = 1;
							  }
						} catch (NumberFormatException e) {
							  currentShowPageNo = 1;
						}
					}
				
					startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
					endRno = startRno + sizePerPage - 1;
					
					paraMap.put("startRno", String.valueOf(startRno));
					paraMap.put("endRno", String.valueOf(endRno));
		
			memberList = service.memberListWithPaging(paraMap);
			// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한것)
		
			if(!"".equals(searchWord)) {
				mav.addObject("paraMap", paraMap);
			}
			
					// ==== #125. 페이지바 만들기 ==== // 
					String pageBar = "<ul>";
					
					int blockSize = 10;
					
					int loop = 1;
					
					int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
					// *** !! 공식이다. !! *** //
			
		    String url = "adminMemberList.to";
		    
					String lastStr = url.substring(url.length()-1);
					if(!"?".equals(lastStr)) 
						url += "?"; 
					
					// *** [이전] 만들기 *** //    
					if(pageNo != 1) {
						pageBar += "&nbsp;<a style='text-decoration: none; color: black;'href='"+url+"&currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a>&nbsp;";
					}
					
					while( !(loop>blockSize || pageNo>totalPage) ) {
						
						if(pageNo == currentShowPageNo) {
							pageBar += "&nbsp;<span style='color: black; padding: 2px 4px; text-decoration: none; font-size: 14pt;'>"+pageNo+"</span>&nbsp;";
						}
						else {
							pageBar += "&nbsp;<a style='color:#666666; text-decoration: none; font-size: 12pt;'href='"+url+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;"; 
							       // ""+1+"&nbsp;"+2+"&nbsp;"+3+"&nbsp;"+......+10+"&nbsp;"
						}
						
						loop++;
						pageNo++;
					}// end of while---------------------------------
					
					// *** [다음] 만들기 *** //
					if( !(pageNo>totalPage) ) {
						pageBar += "&nbsp;<a style='text-decoration: none; color: black;'href='"+url+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a>&nbsp;"; 
					}
					
					pageBar += "</ul>";
					
					mav.addObject("pageBar", pageBar);
					
					String gobackURL = MyUtil.getCurrentURL(request);
					mav.addObject("gobackURL", gobackURL);
			
					// 글 조회수 
					HttpSession session = request.getSession();
					session.setAttribute("readCountPermission", "yes"); 
					
			mav.addObject("memberList",memberList);
			mav.setViewName("admin/memberAdmin/Admin_memberList.tiles1");
			
			}
			
			return mav;
			
		}
		
		// 관리자 회원목록 - 상세정보
		@RequestMapping(value="/adminMemberInfo.to", method= {RequestMethod.GET})
		public ModelAndView adminMemberInfo(ModelAndView mav, HttpServletRequest request) {
			
			// 조회하고자 하는 글번호 받아오기
			String userno= request.getParameter("userno");
		      
		    // 조회하고자 하는 회원정보 불러오기 
		    MemberVO membervo = service.getOnememberInfo(userno); 
			
		    // 가져온 1개의 글을 글수정할 폼이 있는 view 단으로 보내준다.
		    mav.addObject("membervo",membervo);
		    mav.setViewName("admin/memberAdmin/Admin_memberInfo.tiles1");
		      
		    return mav;
		}
		
			// 관리자 회원별 수강정보 페이지
			@RequestMapping(value="/adminMemberClass.to", method= {RequestMethod.GET})
			public ModelAndView adminMemberClass(ModelAndView mav, HttpServletRequest request) {
				
				String userno= request.getParameter("userno");
				
				List<OrderListVO> orderlistvo = service.getOnememberClass(userno);
				MemberVO membervo = service.getOnememberInfo(userno); 
				
				mav.addObject("orderlistvo",orderlistvo);
				mav.addObject("membervo",membervo);
				mav.addObject("userno",userno);
				
				mav.setViewName("admin/memberAdmin/Admin_memberClass.tiles1");
				
				return mav;
			} 
			
			
				
		// 관리자 회원목록 - 회원 탈퇴  
		   @RequestMapping(value="/memberwithdrawal.to", method= {RequestMethod.POST})
		   public ModelAndView memberwithdrawal(HttpServletRequest request, MemberVO membervo, String userno, ModelAndView mav) {
			  
			   int n = service.memberwithdrawal(membervo, membervo.getUserno());
			   mav.addObject("n",n);

			   if(n == 0) {
				   mav.addObject("msg", "회원 탈퇴 실패");
			   }
			   else {
				   mav.addObject("msg", "회원이 탈퇴되었습니다.");
			   }
			   
			   mav.addObject("loc", request.getContextPath()+"/adminMemberList.to"); 
			   mav.setViewName("msg");
			   
			   return mav;
			   
		   }
		   
		// 관리자 수강정보 - 수강취소(환불) 
		   @RequestMapping(value="/admindeleteClass.to", method= {RequestMethod.POST})
		   public ModelAndView admindeleteClass(HttpServletRequest request,String userno, OrderListVO orderlistvo, ModelAndView mav) {
			  
			   int n = service.admindeleteClass(orderlistvo, orderlistvo.getOrderlistno());
			   mav.addObject("n",n);

			   if(n == 0) {
				   mav.addObject("msg", "수강취소 실패");
			   }
			   else {
				   mav.addObject("msg", "수강취소 되었습니다.");
			   }
			   
			   mav.addObject("loc", request.getContextPath()+"/adminMemberClass.to?userno="+userno); 
			   mav.setViewName("msg");
			   
			   return mav;
			   
		   }

}
