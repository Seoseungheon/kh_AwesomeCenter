package com.center.admin.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.center.admin.model.BoardVO;
import com.center.admin.service.InterBoardService;
import com.center.common.MyUtil;
import com.center.member.model.MemberVO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Component
@Controller
public class AdminMemberController {

	@Autowired
	private InterBoardService service;
	
	// 관리자 차트 페이지
	@RequestMapping(value="/adminMemberChartTest.to")
	public ModelAndView chartTest(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession sessionmem = request.getSession();
		MemberVO loginuser = (MemberVO) sessionmem.getAttribute("loginuser");
		
		if(loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
			
			String msg="관리자만 접근 가능한 페이지입니다.";
			String loc="main.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		} else {
		
		mav.setViewName("admin/memberAdmin/Admin_Chart.tiles1");
		
		}
		
		return mav;
		
	}
	
	// 연도별 매출 통계 클릭 전 - 2018년, 2019년, 2020년 총매출  
	@ResponseBody
	@RequestMapping(value="/adminMemberChart.to", produces="text/plain;charset=UTF-8")
	public String sumListJSON(HttpServletRequest request) {
		
	//	String year = request.getParameter("year");
	
		String year = "";
		
		List<HashMap<String, String>> sumList =  service.sumListJSON();
		
		Gson gson = new Gson(); 
		JsonArray jsonArr = new JsonArray(); 
		
		for(HashMap<String, String> map : sumList) {
			JsonObject jsonObj = new JsonObject(); 
			jsonObj.addProperty("YEARSUM", map.get("YEARSUM"));
			jsonObj.addProperty("YEAR", map.get("YEAR") );
		
			jsonArr.add(jsonObj);
		}
		return new Gson().toJson(jsonArr);
	}
	
	
	// 연도별 매출 통계 클릭 후 - 월별 매출 
	@ResponseBody
	@RequestMapping(value="/ChartDetailMonth.to", produces="text/plain;charset=UTF-8")
	public String detailMonthJSON(HttpServletRequest request) {
	
		String year = request.getParameter("year");
//		String month = request.getParameter("month");
		
		List<HashMap<String, String>> monthList =  service.detailMonthJSON(year);
		
		Gson gson = new Gson(); 
		JsonArray jsonArr = new JsonArray(); 
		
		for(HashMap<String, String> map : monthList) {
			JsonObject jsonObj = new JsonObject(); 
			jsonObj.addProperty("MONTHSUM", map.get("MONTHSUM"));
			jsonObj.addProperty("MONTH", map.get("MONTH") );
		
			jsonArr.add(jsonObj);
		}
		return new Gson().toJson(jsonArr);
	}
	
	// 이번년도 강좌별 총 매출 클릭 전 - 강좌 카테고리별 매출 
		@ResponseBody
		@RequestMapping(value="/adminTotalClass.to", produces="text/plain;charset=UTF-8")
		public String totalclass(HttpServletRequest request) {
			
			List<HashMap<String, String>> classList =  service.classListJSON();
			
			Gson gson = new Gson(); 
			JsonArray jsonArr = new JsonArray(); 
			
			for(HashMap<String, String> map : classList) {
				JsonObject jsonObj = new JsonObject(); 
				jsonObj.addProperty("CATENAME", map.get("CATENAME"));
				jsonObj.addProperty("CATETOTAL", map.get("CATETOTAL") );
			
				jsonArr.add(jsonObj);
			}
			return new Gson().toJson(jsonArr);
		}
	
	// 이번년도 강좌별 총 매출 클릭 후 - 카테고리별 2020년 월별 매출 	
		@ResponseBody
		@RequestMapping(value="/DetailMonthclass.to", produces="text/plain;charset=UTF-8")
		public String detailClassJSON(HttpServletRequest request) {
		
			String catename = request.getParameter("catename");
//			String month = request.getParameter("month");
			
			List<HashMap<String, String>> deatilclassList =  service.detailClassJSON(catename);
			
			Gson gson = new Gson(); 
			JsonArray jsonArr = new JsonArray(); 
			
			for(HashMap<String, String> map : deatilclassList) {
				JsonObject jsonObj = new JsonObject(); 
				jsonObj.addProperty("CLASSMONTHSUM", map.get("CLASSMONTHSUM"));
				jsonObj.addProperty("CLASSMONTH", map.get("CLASSMONTH") );
			
				jsonArr.add(jsonObj);
			}
			return new Gson().toJson(jsonArr);
		}
	
		// 강좌별 강사 수  
		@ResponseBody
		@RequestMapping(value="/teacherClass.to", produces="text/plain;charset=UTF-8")
		public String teacherclass(HttpServletRequest request) {
			
			List<HashMap<String, String>> teacherList =  service.teacherListJSON();
			
			Gson gson = new Gson(); 
			JsonArray jsonArr = new JsonArray(); 
			
			for(HashMap<String, String> map : teacherList) {
				JsonObject jsonObj = new JsonObject(); 
				jsonObj.addProperty("CATENAME", map.get("CATENAME"));
				jsonObj.addProperty("COUNT", map.get("COUNT") );
			
				jsonArr.add(jsonObj);
			}
			return new Gson().toJson(jsonArr);
		}
		
		// 강사의 성별  	
		@ResponseBody
		@RequestMapping(value="/teacherGender.to", produces="text/plain;charset=UTF-8")
		public String teacherGenderJSON(HttpServletRequest request) {
		
			String catename = request.getParameter("catename");
			
			List<HashMap<String, String>> genderList =  service.teacherGenderJSON(catename);
			
			Gson gson = new Gson(); 
			JsonArray jsonArr = new JsonArray(); 
			
			for(HashMap<String, String> map : genderList) {
				JsonObject jsonObj = new JsonObject(); 
				jsonObj.addProperty("GENDER", map.get("GENDER"));
				jsonObj.addProperty("PERCENTAGE", map.get("PERCENTAGE") );
			
				jsonArr.add(jsonObj);
			}
			return new Gson().toJson(jsonArr);
		}	

			
	// 공지 게시판 목록
		@RequestMapping(value="/boardmenu.to", method= {RequestMethod.GET})
		public ModelAndView list(HttpServletRequest request, ModelAndView mav) {
			
			List<BoardVO> boardList = null;
		
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
		
			boardList = service.boardListWithPaging(paraMap);
			// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한것)
		
			if(!"".equals(searchWord)) {
				mav.addObject("paraMap", paraMap);
			}
			
			// ==== #125. 페이지바 만들기 ==== // 
			String pageBar = "";
			
			int blockSize = 10;
			
			int loop = 1;
			
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			// *** !! 공식이다. !! *** //
			
		    String url = "boardmenu.to";
		    
			String lastStr = url.substring(url.length()-1);
			if(!"?".equals(lastStr)) 
				url += "?"; 
			
			// *** [맨처음] 만들기 *** //
			pageBar += "<a href='"+url+"&currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-left-double-angle.png' /></a>&nbsp;&nbsp;";
			
			// *** [이전] 만들기 *** //
			if(pageNo!=1) {
				pageBar += "<a href='"+url+"&currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /></a>";
			}
			else {
				pageBar += "<a href='"+url+"&currentShowPageNo="+(currentShowPageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /></a>&nbsp;&nbsp;&nbsp;&nbsp;";
			}
			// *** [번호] 만들기 *** //
			while(!(loop > blockSize || pageNo>totalPage)) {
				
				if(pageNo == currentShowPageNo) {
					pageBar += "<a href='"+url+"&currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'class='pagebar-number action2'>"+pageNo+"</a>&nbsp;&nbsp;&nbsp;&nbsp;";

				}
				else {
					pageBar += "<a href='"+url+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'class='pagebar-number'>"+pageNo+"</a>&nbsp;&nbsp;&nbsp;&nbsp;"; 
				}		
				
				pageNo++; 
				loop++;	  

			}
			
			// *** [다음] 만들기 *** //
			if(currentShowPageNo>totalPage) {
				pageBar += "&nbsp;<a href='"+url+"&currentShowPageNo="+currentShowPageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-right-angle.png' /></a>&nbsp;";
				System.out.println("pageNo :"+pageNo);
				System.out.println("totalPage :"+totalPage);
				System.out.println("currentShowPageNo :"+currentShowPageNo);
			}
			else {
				pageBar += "&nbsp;<a href='"+url+"&currentShowPageNo="+(currentShowPageNo+1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-right-angle.png' /></a>&nbsp;";
			
		//		System.out.println("totalCount"+totalCount);
			
			}
			// *** [맨마지막] 만들기 *** //
			pageBar += "&nbsp;<a href='"+url+"&currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-right-double-angle.png' /></a>&nbsp;";
	   		
			
			
			
			
			
			mav.addObject("pageBar", pageBar);
			
			String gobackURL = MyUtil.getCurrentURL(request);
			mav.addObject("gobackURL", gobackURL);
			// 글 조회수 
			HttpSession session = request.getSession();
			session.setAttribute("readCountPermission", "yes"); 
			
			mav.addObject("boardList",boardList);
			mav.setViewName("board4/boardmenu.tiles1");
			
			return mav;
		}		
		
	// 공지 게시판 글쓰기 폼페이지 
	@RequestMapping(value="/NoticeWrite.to")
	public ModelAndView NoticeWrite(BoardVO boardvo, ModelAndView mav, HttpServletRequest request) {
		
		HttpSession sessionmem = request.getSession();
		MemberVO loginuser = (MemberVO) sessionmem.getAttribute("loginuser");
		
		if(loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
			
			String msg="관리자만 접근 가능한 페이지입니다.";
			String loc="main.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		} else {
		
		mav.setViewName("admin/memberAdmin/NoticeWrite.tiles1");
		
		}
		
		return mav;
	}
	
	// 공지게시판 글쓰기 완료 페이지 
	@RequestMapping(value="/NoticeWriteEnd.to", method= {RequestMethod.POST})
	public ModelAndView NoticeWriteEnd(BoardVO boardvo, ModelAndView mav) {
		
		boardvo.setFk_userid("admin");
		
		int n = service.addNotice(boardvo);
		
		mav.addObject("n",n);
		mav.setViewName("board4/addEnd.tiles1");
		
		
		return mav;
	}
	
	// 공지게시판 상세
	@RequestMapping(value="/noticeBoardDetail.to", method= {RequestMethod.GET})
	public ModelAndView noticeBoardDetail(ModelAndView mav, HttpServletRequest request) {
		
		// 조회하고자 하는 글번호 받아오기
		String Not_seq = request.getParameter("not_seq");
		String gobackURL = request.getParameter("gobackURL");
	    mav.addObject("gobackURL",gobackURL); // 목록 눌렀을 때 돌아갈 주소 
	      
	    // 수정해야할 글 내용 가져오기
	    BoardVO boardvo = service.getNoticeBoardDetailNoCount(Not_seq); 
		
	    // 가져온 1개의 글을 글수정할 폼이 있는 view 단으로 보내준다.
	    mav.addObject("boardvo",boardvo);
	    mav.setViewName("board4/noticeBoardDetail.tiles1");
	      
	    return mav;
	}
	
	// === 공지게시판 글수정 페이지 요청 
	   @RequestMapping(value="/noticeedit.to", method= {RequestMethod.GET})
	   public ModelAndView noticeedit(HttpServletRequest request, ModelAndView mav) {
		   
		// 조회하고자 하는 글번호 받아오기
		String Not_seq = request.getParameter("not_seq");
		
	    // 수정해야할 글 내용 가져오기
	    BoardVO boardvo = service.getNoticeBoardDetailNoCount(Not_seq); 
		
	    // 가져온 1개의 글을 글수정할 폼이 있는 view 단으로 보내준다.
	    mav.addObject("boardvo",boardvo);
	    mav.setViewName("board4/noticeEdit.tiles1");
	    boardvo.setNot_content(boardvo.getNot_content().replaceAll("<br/>", "\r\n"));
		   
		return mav;
	   }
	   
	   // 공지게시판 글 수정 완료페이지 
	   @RequestMapping(value="/noticeeditEnd.to", method= {RequestMethod.POST})
	   public ModelAndView noticeeditEnd(HttpServletRequest request, BoardVO boardvo, ModelAndView mav) {
		   
		   
		// *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 *** //
		   boardvo.setNot_title(MyUtil.replaceParameter(boardvo.getNot_title()));
		   boardvo.setNot_content(MyUtil.replaceParameter(boardvo.getNot_content()));  	   
		   boardvo.setNot_content(boardvo.getNot_content().replaceAll("\r\n", "<br/>"));
		   
		   int n = service.noticeEdit(boardvo);
		   
		   mav.addObject("n",n);

		   if(n == 0) {
			   mav.addObject("msg", "글 수정 실패");
			   
		   }
		   else {
			   mav.addObject("msg", "글이 정상적으로 수정되었습니다.");
		   }
		   
		   mav.addObject("loc", request.getContextPath()+"/boardmenu.to?not_seq="+boardvo.getNot_seq());  // 글 수정 성공하고 이 쪽 뷰단으로 이동한다. 
		   mav.setViewName("msg");
		   
		   return mav;
		   
	   }
	   
	   // 공지게시판 글 삭제 
	   @RequestMapping(value="/noticedel.to", method= {RequestMethod.POST})
	   public ModelAndView noticedel(HttpServletRequest request, BoardVO boardvo , ModelAndView mav) {
		  
		   int n = service.noticedel(boardvo);
		   
		   mav.addObject("n",n);

		   if(n == 0) {
			   mav.addObject("msg", "글 삭제 실패");
			   
		   }
		   else {
			   mav.addObject("msg", "글이 삭제되었습니다.");
		   }
		   
		   mav.addObject("loc", request.getContextPath()+"/boardmenu.to");  // 글 수정 성공하고 이 쪽 뷰단으로 이동한다. 
		   mav.setViewName("msg");
		   
		   return mav;

		   
	   }
	   
}
