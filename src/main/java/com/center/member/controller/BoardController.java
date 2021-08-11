package com.center.member.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.center.common.MyUtil;
import com.center.member.model.HopeBoardVO;
import com.center.member.model.MemberVO;
import com.center.member.model.QnAVO;
import com.center.member.service.InterMbrBoardService;

@Controller
public class BoardController {
	
	@Autowired
	private InterMbrBoardService service;
	
	@RequestMapping(value="/QnA/FAQList.to")
	public String FAQList() {
		
		return "member/FAQ/FAQList.tiles1";
	}
	
	// 1:1문의 내역 조회
	@RequestMapping(value="/QnA/QnAList.to")
	public ModelAndView requiredLogin_QnAList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		List<QnAVO> QnAList = null;
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userid = "";
		String userno = "";
		
		if(loginuser != null) {
			userid = loginuser.getUserid();
			userno = loginuser.getUserno();
		}
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userno", userno);
		
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		int totalCount = 0;         // 총게시물 건수
		int sizePerPage = 5;       // 한 페이지당 보여줄 게시물 수 
		int currentShowPageNo = 0;  // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;          // 총 페이지수(웹브라우저상에 보여줄 총 페이지 갯수, 페이지바) 
		
		int startRno = 0;           // 시작 행번호
		int endRno = 0;             // 끝 행번호

		if(! "admin".equals(userid)) {
		totalCount = service.getTotalCountWithNOsearch(userno);
		} else {
			totalCount = service.getTotalCountWithNOsearchAdmin();
		}

		totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );
		
		if(str_currentShowPageNo == null) {
			
			currentShowPageNo = 1;
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
		
		map.put("startRno", String.valueOf(startRno));
		map.put("endRno", String.valueOf(endRno));
	
		if(! "admin".equals(userid)) {
		QnAList = service.getQnAList(map);
		} else {
			QnAList = service.getQnAListAdmin(map);
		}
		
		// ==== #125. 페이지바 만들기 ==== // 
		String pageBar = "<ul>";
				
		int blockSize = 5;
				
		int loop = 1;
				
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
				
		String url = "/awesomecenter/QnA/QnAList.to";
			    
		String lastStr = url.substring(url.length()-1);
		if(!"?".equals(lastStr)) 
			url += "?"; 
				
		// *** [이전] 만들기 *** //    
		
		pageBar += "&nbsp;<a style='text-decoration:none; color:black;' href='"+url+"currentShowPageNo=1&sizePerPage="+sizePerPage+"'> << </a>&nbsp;";
		
		if(currentShowPageNo > 1) {
		pageBar += "&nbsp;<a style='text-decoration:none; color:black;' href='"+url+"currentShowPageNo="+(currentShowPageNo-1)+"&sizePerPage="+sizePerPage+"'> < </a>&nbsp;";
		} else {
			pageBar += "&nbsp;<a style='text-decoration:none; color:black;' href='"+url+"currentShowPageNo=1&sizePerPage="+sizePerPage+"'> < </a>&nbsp;";
		}
				
		while( !(loop>blockSize || pageNo>totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "&nbsp;<span style='font-weight: bold; font-size: 15pt; text-decoration: underline;'>"+pageNo+"</span>&nbsp;";
			}
			else {
				pageBar += "&nbsp;<a href='"+url+"currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a>&nbsp;"; 
			}
					
			loop++;
			pageNo++;
		}// end of while---------------------------------
				
		// *** [다음] 만들기 *** //
		if(currentShowPageNo < totalPage) {
		pageBar += "&nbsp;<a style='text-decoration: none; color: black;' href='"+url+"currentShowPageNo="+(currentShowPageNo+1)+"&sizePerPage="+sizePerPage+"'> > </a>&nbsp;";
		} else {
			pageBar += "&nbsp;<a style='text-decoration: none; color: black;' href='"+url+"currentShowPageNo="+currentShowPageNo+"&sizePerPage="+sizePerPage+"'> > </a>&nbsp;";
		}
				
		pageBar += "&nbsp;<a style='text-decoration:none; color:black;' href='"+url+"currentShowPageNo="+(totalPage)+"&sizePerPage="+sizePerPage+"'> >> </a>&nbsp;";
		
		pageBar += "</ul>";
				
		mav.addObject("pageBar", pageBar);				
		
		mav.addObject("QnAList", QnAList);
		
		mav.setViewName("member/QnA/QnAList.tiles1");
		
		return mav;
	}
	
	// 1:1문의 자세히
	@RequestMapping(value="/QnA/QnAView.to", method= {RequestMethod.POST})
	public ModelAndView QnAView(HttpServletRequest request, ModelAndView mav) {
		
		String no = request.getParameter("no");
		
		QnAVO qna = service.getQnAView(no);
		
		mav.addObject("qna", qna);
		
		mav.setViewName("member/QnA/QnAView.tiles1");
		
		return mav;
	}
	
	// 1:1문의 자세히(GET : 수정 후 이동)
	@RequestMapping(value="/QnA/QnAView.to", method= {RequestMethod.GET})
	public ModelAndView QnAView2(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userno = loginuser.getUserno();
		
		String url = request.getQueryString();
		
		String no = url.substring(3);
		
		QnAVO qna = service.getQnAView(no);
		
		if ( qna.getUserno_fk().equals(userno) || userno.equals("8") ){
		
			mav.addObject("qna", qna);
			
			mav.setViewName("member/QnA/QnAView.tiles1");
			
		} else {
			String msg = "작성자가 아닙니다.";
			String loc = request.getContextPath()+"/main.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		}
		
		return mav;
	}
	
	// 1:1 문의 삭제
	@RequestMapping(value="/QnA/QnADelete.to", method= {RequestMethod.POST})
	public ModelAndView QnADelete(HttpServletRequest request, ModelAndView mav) {
		
		String no = request.getParameter("no");
		
		int n = service.delQuestion(no);
		
		String msg = "";
		
		if(n>0) {
			msg = "삭제되었습니다.";
		} else {
			msg = "삭제에 실패했습니다.";
		}
			String loc = request.getContextPath()+"/QnA/QnAList.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		
		return mav;
		
	}

	// 1:1 문의 수정
	@RequestMapping(value="/QnA/QnAEdit.to", method= {RequestMethod.POST})
	public ModelAndView QnAEdit(HttpServletRequest request, ModelAndView mav) {
		
		String no = request.getParameter("no");
		
		QnAVO qna = service.getQnAView(no);
		
		mav.addObject("qna", qna);
		
		mav.setViewName("member/QnA/QnAEdit.tiles1");
		
		return mav;
	}
	
	// 1:1 문의 수정 완료
	@RequestMapping(value="/QnA/QnAEditEnd.to", method= {RequestMethod.POST})
	public ModelAndView QnAEditEnd(HttpServletRequest request, ModelAndView mav) {
		
		String no = request.getParameter("no");
		String title = request.getParameter("Subject");
		String categoryno = request.getParameter("TypeCode");
		String content = request.getParameter("content");
		
		content = MyUtil.replaceParameter(content);
		content = content.replaceAll("\r\n", "<br/>");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("no", no);
		map.put("title", title);
		map.put("categoryno", categoryno);
		map.put("content", content);
		
		int n = service.editQuestion(map);
		
		if(n>0) {
			String msg = "수정되었습니다.";
			String loc = request.getContextPath()+"/QnA/QnAView.to?no="+no;
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
		} else {
			String msg = "수정 실패";
			String loc = "javascript:history.back()";
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
		}
		
		mav.setViewName("msg");
		
		return mav;
	
	}
	
	// 1:1 문의 작성
	@RequestMapping(value="/QnA/QnAWrite.to")
	public String QnAWrite() {
		
		return "member/QnA/QnAWrite.tiles1";
	}
	
	
	// 1:1 문의 작성 완료
	@RequestMapping(value="/QnA/QnAWriteEnd.to", method= {RequestMethod.POST})
	public ModelAndView QnAWriteEnd(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userno = loginuser.getUserno();
		String title = request.getParameter("Subject");
		String categoryno = request.getParameter("TypeCode");
		String content = request.getParameter("content");
		
		content = MyUtil.replaceParameter(content);
		content = content.replaceAll("\r\n", "<br/>");
		
		HashMap<String,String> map = new HashMap<String, String>();
		map.put("userno", userno);
		map.put("title", title);
		map.put("categoryno", categoryno);
		map.put("content", content);
		
		int n = service.writeQuestion(map);
		
		if( n > 0 ) {
			mav.setViewName("member/QnA/QnAEnd.tiles1");
		} else {
			String msg = "작성에 실패하셨습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/QnA/QnAEnd.to")
	public String QnAEnd() {
		
		return "member/QnA/QnAEnd.tiles1";
	}
	
	@RequestMapping(value="/QnA/writeAnswer.to", method= {RequestMethod.POST})
	public ModelAndView writeAnswer(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String no = request.getParameter("no");
		
		QnAVO qna = service.getQnAView(no);
		
		mav.addObject("qna", qna);
		
		mav.setViewName("member/QnA/AnswerWrite.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/QnA/editAnswer.to", method= {RequestMethod.POST})
	public ModelAndView editAnswer(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String no = request.getParameter("no");
		
		QnAVO qna = service.getQnAView(no);
		
		mav.addObject("qna", qna);
		
		mav.setViewName("member/QnA/AnswerEdit.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/QnA/answerEdit.to", method= {RequestMethod.POST})
	public ModelAndView answerEdit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String no = request.getParameter("no");
		String answer = request.getParameter("answer");
		
		answer = MyUtil.replaceParameter(answer);
		answer = answer.replaceAll("\r\n", "<br/>");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("no", no);
		map.put("answer", answer);
		
		int n = service.answerEdit(map);
		
		String msg = "수정 완료";
		String loc = request.getContextPath()+"/QnA/QnAView.to?no="+no;
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	@RequestMapping(value="/QnA/answerWrite.to", method= {RequestMethod.POST})
	public ModelAndView answerWrite(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String no = request.getParameter("no");
		String answer = request.getParameter("answer");
		
		answer = MyUtil.replaceParameter(answer);
		answer = answer.replaceAll("\r\n", "<br/>");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("no", no);
		map.put("answer", answer);
		
		int n = service.answerEdit(map);
		
		String msg = "답변 완료";
		String loc = request.getContextPath()+"/QnA/QnAView.to?no="+no;
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////// 효민 수정  /////////////////////////////////////////////////////////////
//////////////////////////////// 효민 수정  /////////////////////////////////////////////////////////////
//////////////////////////////// 효민 수정  /////////////////////////////////////////////////////////////
//////////////////////////////// 효민 수정  /////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/boardmenu3.to", method= {RequestMethod.GET})
	public ModelAndView list(HttpServletRequest request, ModelAndView mav) {
		
		List<HopeBoardVO> boardList = null;
	
		String str_currentShowPageNo = request.getParameter("currentShowPageNo"); 
		
		int totalCount = 0;         // 총게시물 건수
		int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 수 
		int currentShowPageNo = 0;  // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;          // 총 페이지수(웹브라우저상에 보여줄 총 페이지 갯수, 페이지바) 
		
		int startRno = 0;           // 시작 행번호
		int endRno = 0;             // 끝 행번호
		
		
		String searchType = request.getParameter("searchType"); 
		String searchWord = request.getParameter("searchWord");
		if(searchType==null) {
			searchType = "title";
		}
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchWord", searchWord);
		if(searchWord == null || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		HashMap<String,String> paraMap = new HashMap<String,String>(); 
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
	
	    // 검색조건이 없을 경우의 총 게시물 건수(totalCount)
		if("".equals(searchWord)) {
			totalCount = service.getTotalCountWithNOsearchHM();
		}
		
		// 검색조건이 있을 경우의 총 게시물 건수(totalCount)
		else {
			totalCount = service.getTotalCountWithSearchHM(paraMap);
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
	
		boardList = service.boardListWithPagingHM(paraMap);
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
		
	    String url = "boardmenu3.to";
	    
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
		mav.setViewName("board4/boardmenu3.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/writewish.to")
	public ModelAndView requiredLogin_writewish(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userno = "";
		if(loginuser != null)
			userno = loginuser.getUserno();
		
		int recentlyWrite = service.getRecentlyWrite(userno);
		
		if(recentlyWrite<10) {
			mav.addObject("msg","도배 방지를 위해 글 작성은 10분에 한번씩 가능합니다.");
			mav.addObject("loc","javascript:history.back();");
			mav.setViewName("msg");
			
		}
		else {
			mav.setViewName("board4/wantBoardRegister.tiles1");
		}
		return mav;
	}
	
	@RequestMapping(value="/writewishEnd.to")
	public ModelAndView writewishEnd(HttpServletRequest request, ModelAndView mav) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); 
		
		String msg = "";
		String userno = loginuser.getUserno();
		String title = request.getParameter("wish_title");
		String content = request.getParameter("wish_content");
		content = MyUtil.replaceParameter(content);
		content = content.replaceAll("\r\n", "<br/>");
		
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("userno", userno);
		paraMap.put("title", title);
		paraMap.put("content", content);
		
		int n = service.writewishEnd(paraMap);
		if(n == 0) {
			msg = "글 등록에 실패하였습니다. 고객센터로 문의해주세요.";
		}
		else {
			msg = "글 등록이 완료되었습니다.";
		}
		
		mav.addObject("msg",msg);
		mav.addObject("loc",request.getContextPath()+"/boardmenu3.to");
		mav.setViewName("msg");
		return mav;
	}
	
	@RequestMapping(value="/wishBoardDetail.to")
	public ModelAndView wishBoardDetail(HttpServletRequest request, ModelAndView mav) {
		String no = request.getParameter("no");
		HopeBoardVO hvo = service.getHopeBoardDetail(no);
		
		if(hvo==null) {
			String loc = request.getContextPath()+"/boardmenu3.to";
			String msg = "잘못된 접근입니다.";
			mav.addObject("loc",loc);
			mav.addObject("msg",msg);
			mav.setViewName("msg");
		}
		else {
			mav.addObject("hvo",hvo);
			mav.setViewName("board4/wantBoardDetail.tiles1");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/delHopeBoard.to")
	public ModelAndView delHopeBoard(HttpServletRequest request, ModelAndView mav) {
		String msg = "";
		String loc = "";
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); 
		String no = request.getParameter("no");
		HopeBoardVO hvo = service.getHopeBoardDetail(no);
		
		try {
			if(!hvo.getUsername().equals(loginuser.getUsername())) {
				msg = "잘못된 접근입니다.";
			}
			
			else {
				int n = service.delHopeBoard(no);
				if(n==0) {
					msg = "삭제에 실패했습니다. 고객센터에 문의해 주세요.";
				}
				else {
					msg = "글 삭제 완료";
				}
			}
		} catch (NullPointerException e) {
			msg = "잘못된 접근입니다.";
		}
		
		loc = request.getContextPath()+"/boardmenu3.to";
		mav.addObject("msg",msg);
		mav.addObject("loc",loc);
		mav.setViewName("msg");
		return mav;
	}
	
	@RequestMapping(value="/editHopeBoard.to")
	public ModelAndView editHopeBoard(HttpServletRequest request, ModelAndView mav) {
		String msg = "";
		String loc = "";
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); 
		String no = request.getParameter("no");
		HopeBoardVO hvo = service.getHopeBoardDetail(no);
		
		try {
			if(!hvo.getUsername().equals(loginuser.getUsername())) {
				msg = "잘못된 접근입니다.";
				loc = request.getContextPath()+"/boardmenu3.to";
				mav.setViewName("msg");
			}
			
			else {
				loc = request.getContextPath()+"/boardmenu3.to";
				mav.addObject("hvo",hvo);
				mav.setViewName("board4/wantBoardRegister.tiles1");
			}
			
		} catch (NullPointerException e) {
			msg = "잘못된 접근입니다.";
			loc = request.getContextPath()+"/boardmenu3.to";
			mav.setViewName("msg");
		}
		
		mav.addObject("msg",msg);
		mav.addObject("loc",loc);
		return mav;
	}
	
	@RequestMapping(value="/updateWishEnd.to")
	public ModelAndView updateWishEnd(HttpServletRequest request, ModelAndView mav) {
		String title = request.getParameter("wish_title");
		String content = request.getParameter("wish_content");
		String no = request.getParameter("wish_no");
		String msg = "";
		
		content = MyUtil.replaceParameter(content);
		content = content.replaceAll("\r\n", "<br/>");
		
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("no", no);
		paraMap.put("title", title);
		paraMap.put("content", content);
		
		int n = service.updateWishEnd(paraMap);
		if(n == 0) {
			msg = "글 수정에 실패하였습니다. 고객센터로 문의해주세요.";
			mav.addObject("loc",request.getContextPath()+"/boardmenu3.to");
		}
		else {
			msg = "글 수정이 완료되었습니다.";
			mav.addObject("loc",request.getContextPath()+"/boardmenu3.to?no="+no);
		}
		
		mav.addObject("msg",msg);
		mav.setViewName("msg");
		
		return mav;
	}
	
}
