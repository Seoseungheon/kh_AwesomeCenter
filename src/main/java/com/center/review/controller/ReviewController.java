package com.center.review.controller;

import java.io.File;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.center.member.model.MemberVO;
import com.center.review.model.ReviewVO;
import com.center.review.service.InterReviewService;
import com.center.common.FileManager;
import com.center.common.MyUtil;

@Controller
public class ReviewController {
	
	@Autowired
	private InterReviewService service;
	
	// === #142. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI: Dependency Injection) ===  
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="boardmenu4.to")
	public String board(HttpServletRequest request) {
		
		
		HashMap<String, String> paramap = new HashMap<String, String>();

   		String searchType = request.getParameter("searchType");
   		String searchWord = request.getParameter("rvSearchWord");
   		
		if(searchWord == null || "".equals(searchWord)) {
			
			searchWord = "";
			
		}
		
   		paramap.put("searchType", searchType);
   		paramap.put("searchWord", searchWord);
		
   		String orderby = request.getParameter("orderby");
   		
   		if("조회순".equals(orderby)) {
   			
   			orderby = "조회순";
   					
   		}
   		
   		paramap.put("orderby", orderby);
   		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
   		
   		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
   		
   		
		int sizePerPage = 10;
		
		int firstPage = (Integer.parseInt(currentShowPageNo) * sizePerPage) - (sizePerPage-1);

		int lastPage = (Integer.parseInt(currentShowPageNo) * sizePerPage);

		
		paramap.put("firstPage", String.valueOf(firstPage));
		paramap.put("lastPage", String.valueOf(lastPage));
   		
   		//  pagination 처리된 리뷰 게시판 조회
		List<ReviewVO> reviewList = service.reviewList(paramap);
   		
		// pagination 처리 되어진 리뷰 갯수를 가져온다
		int totalCount = service.totalCount(paramap);
		
   		// 총 강좌 수를 구해온다
   		int totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
   		int pageNo = 1; // 페이지 바에서 보여지는 페이지 번호		
		int blockSize = 10; // 블럭(토막)당 보여지는 페이지 번호의 갯수		
		int loop = 1; // 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(지금은 10개)까지만 증가하는 용도
		pageNo = ( (Integer.parseInt(currentShowPageNo)-1)/blockSize )*blockSize +1; // 처음 페이지 NO를 구하는 공식

		String pageBar = "";
		
		// 페이지 바 만들기
   		
		// *** [맨처음] 만들기 *** //
		pageBar += "<a><img class='pagebar-btn' src='resources/images/pagebar-left-double-angle.png' /><span>1</span></a>";
		
		// *** [이전] 만들기 *** //
		if(pageNo!=1) {
			pageBar += "<a><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /><span>"+(pageNo-1)+"</span></a>";
		}
		else {
			pageBar += "<a><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /><span>1</span></a>&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		// *** [번호] 만들기 *** //
		while(!(loop > blockSize || pageNo>totalPage)) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<a class='pagebar-number action2'>"+pageNo+"</a>&nbsp;&nbsp;&nbsp;&nbsp;";

			}
			else {
				pageBar += "<a class='pagebar-number'>"+pageNo+"</a>&nbsp;&nbsp;&nbsp;&nbsp;"; 
			}		
			
			pageNo++; 
			loop++;	  

		}
		
		// *** [다음] 만들기 *** //
		if(pageNo>totalPage) {
			pageBar += "&nbsp;<a><img class='pagebar-btn' src='resources/images/pagebar-right-angle.png' /><span>"+totalPage+"</span></a>&nbsp;";
		}
		else {
			pageBar += "&nbsp;<a><img class='pagebar-btn' src='resources/images/pagebar-right-angle.png' /><span>"+pageNo+"</span></a>&nbsp;";
		}
		// *** [맨마지막] 만들기 *** //
		pageBar += "&nbsp;<a><img class='pagebar-btn' src='resources/images/pagebar-right-double-angle.png' /><span>"+totalPage+"</span></a>&nbsp;";
   		
		
		
		request.setAttribute("reviewList", reviewList);
		
		request.setAttribute("paramap", paramap);

		request.setAttribute("pageBar", pageBar);
		
		return "board4/boardmenu4.tiles1";
	}
	
	// 수강후기 리스트 조회
	@RequestMapping(value="review.to")
	public String review(HttpServletRequest request) {
		
		return "board4/review/reviewBoard.tiles1";
	}
	
	// 수강후기 작성시작
	@RequestMapping(value="goReview.to")
	public String requiredLogin_goReview(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userno = loginuser.getUserno();
		
		List<HashMap<String, String>> finishList = service.finishClass_title(userno);  
		
		System.out.println("finishList" + finishList);
		
		if ( !finishList.isEmpty() ) {
			
			request.setAttribute("finishList", finishList);
			
			return "board4/review/goReview.tiles1";
			
		}
		else {

			request.setAttribute("msg", "후기를 작성할 강좌가 없습니다.");
			request.setAttribute("loc", "javascript:history.back();");
			
			return "msg";
		}
	}
	
	// 찐찐 수강후기 작성
	@RequestMapping(value="addReview.to", method = {RequestMethod.POST})
	public ModelAndView requiredLogin_addReview(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mrequest,  ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userno = loginuser.getUserno();
		
		MultipartFile filename = mrequest.getFile("addFile");
		String reviewLecNo = request.getParameter("reviewLecNo");
		String class_seq = request.getParameter("class_seq");
		
		System.out.println(reviewLecNo);
		
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
        // *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 *** //
		subject = MyUtil.replaceParameter(subject);     
        content = content.replaceAll("\r\n", "<br/>");
        
        HashMap<String, String> addMap = new HashMap<String, String>();
        
        addMap.put("userno", userno);
        addMap.put("reviewLecNo", reviewLecNo);
        addMap.put("subject", subject);
        addMap.put("content", content);
        addMap.put("class_seq", class_seq);

		
		MultipartFile attach = filename;
		
		if(!attach.isEmpty()) {
			// attach 가 비어있지 않다면(즉, 첨부파일이 있는 경우라면)
			
		/*
			1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
			>>> 파일이 업로드 되어질 특정 경로(폴더) 지정해주기
			우리는 WAS 의 webapp/resources/files 라는 폴더로 지정해준다. 
		*/	
			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			session = mrequest.getSession();
		 	String root = session.getServletContext().getRealPath("/");
		 	String path = root + "resources" + File.separator + "files";
		 	// File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		 	// 운영체제가 Windows 이라면 File.separator 은 "\" 이고,
		    // 운영체제가 UNIX, Linux 이라면 File.separator 은 "/" 이다.
		 	
		 	// path 가 첨부파일을 저장할 WAS(톰캣)의 폴더가 된다.
		 	System.out.println(">>> 확인용 path ==>" + path);
			// >>> 확인용 path ==>C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files 
		 
		 	
		 // == 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기 ==	//
		 	
		 	String newFileName = "";
		 	// WAS(톰캣)의 디스크에 저장될 파일명
		 	
		 	byte[] bytes = null;
		 	// 첨부파일을 WAS(톰캣)의 디스크에 저장할때 사용되는 용도
		 	
		 	long fileSize = 0;
		 	// 파일크기를 읽어오기 위한 용도 
		 	
		 	try {
				bytes = attach.getBytes();
				// getBytes() 메소드는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다. 
				// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
				// 이파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
				
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				// 이제 파일올리기를 한다.
				// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
				
				System.out.println(">>> 확인용 newFileName ==> " + newFileName); 
				// >>> 확인용 newFileName ==> 201907251244341722885843352000.jpg 
			/*	
				// == 3. BoardVO boardvo 에 fileName 값과 orgFilename 값과  fileSize 값을 넣어주기 
				boardvo.setFileName(newFileName);
				// WAS(톰캣)에 저장된 파일명(201907251244341722885843352000.jpg)
				
				boardvo.setOrgFilename(attach.getOriginalFilename());
				// 게시판 페이지에서 첨부된 파일의 파일명(강아지.png)을 보여줄때 및  
				// 사용자가 파일을 다운로드 할때 사용되어지는 파일명
				
				fileSize = attach.getSize();
				boardvo.setFileSize(String.valueOf(fileSize));
				// 게시판 페이지에서 첨부한 파일의 크기를 보여줄때 String 타입으로 변경해서 저장함.
			*/
				
				addMap.put("newFileName", newFileName);	
				addMap.put("fileName", attach.getOriginalFilename());
				
			} catch (Exception e) {
				e.printStackTrace();
			}


		 	
		}
		//	========= !! 첨부파일이 있는지 없는지 알아오기 끝 !! =========
		
		//  === #143. 파일첨부가 있는 경우와 없는 경우에 따라서 Service단 호출하기 === 
		//      먼저 위의 	int n = service.add(boardvo); 부분을 주석처리하고서 아래처럼 한다.
		
		int n = 0;
		if(attach.isEmpty()) {
			// 첨부파일이 없는 경우이라면
			n = service.add(addMap); 
		}
		else {
			// 첨부파일이 있는 경우이라면
			n = service.add_withFile(addMap);
		}

		mrequest.setAttribute("n", n);

		
		mav.setViewName("redirect:boardmenu4.to");
		
		return mav;
	}
	
	// 글 상세보기 
	@RequestMapping(value="reviewDetail.to")
	public ModelAndView reviewDetail(ModelAndView mav, HttpServletRequest request, String reviewno) {
		
		// 글 상세 보기
		ReviewVO rvo = service.reviewDetail(reviewno);
		
		// 댓글 리스트 조회(reviewno)
		List<HashMap<String,String>> commentList = service.selectCommentList(reviewno);
		
		mav.addObject("rvo", rvo);
		mav.addObject("commentList", commentList);
		
		mav.setViewName("board4/review/reviewDetail.tiles1");
		
		return mav;
		
	}
	
	// 글 수정 란 
	@RequestMapping(value="reviewEdit.to", method = {RequestMethod.POST})
	public ModelAndView requiredLogin_reviewEdit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, String reviewno) {
		
		ReviewVO rvo = service.reviewDetail(reviewno);
		
		mav.addObject("rvo", rvo);
		
		mav.setViewName("board4/review/reviewEdit.tiles1");
		
		return mav;
		
	}
	
	// 찐찐 글 수정
	@RequestMapping(value="reviewEditEnd.to")
	public ModelAndView requiredLogin_reviewEditEnd(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mrequest,  ModelAndView mav, ReviewVO rvo) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userno = loginuser.getUserno();
		
		MultipartFile filename = mrequest.getFile("addFile");
		String reviewno = request.getParameter("reviewno");
		
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
        // *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 *** //
		subject = MyUtil.replaceParameter(subject);     
        content = content.replaceAll("\r\n", "<br/>");
        
        HashMap<String, String> addMap = new HashMap<String, String>();
        
        addMap.put("userno", userno);
        addMap.put("reviewno", reviewno);
        addMap.put("subject", subject);
        addMap.put("content", content);

		
		MultipartFile attach = filename;
		
		if(!attach.isEmpty()) {
			// attach 가 비어있지 않다면(즉, 첨부파일이 있는 경우라면)
			
		/*
			1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
			>>> 파일이 업로드 되어질 특정 경로(폴더) 지정해주기
			우리는 WAS 의 webapp/resources/files 라는 폴더로 지정해준다. 
		*/	
			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			session = mrequest.getSession();
		 	String root = session.getServletContext().getRealPath("/");
		 	String path = root + "resources" + File.separator + "files";
		 	// File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		 	// 운영체제가 Windows 이라면 File.separator 은 "\" 이고,
		    // 운영체제가 UNIX, Linux 이라면 File.separator 은 "/" 이다.
		 	
		 	// path 가 첨부파일을 저장할 WAS(톰캣)의 폴더가 된다.
		 	System.out.println(">>> 확인용 path ==>" + path);
			// >>> 확인용 path ==>C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files 
		 
		 	
		 // == 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기 ==	//
		 	
		 	String newFileName = "";
		 	// WAS(톰캣)의 디스크에 저장될 파일명
		 	
		 	byte[] bytes = null;
		 	// 첨부파일을 WAS(톰캣)의 디스크에 저장할때 사용되는 용도
		 	
		 	long fileSize = 0;
		 	// 파일크기를 읽어오기 위한 용도 
		 	
		 	try {
				bytes = attach.getBytes();
				// getBytes() 메소드는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다. 
				// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
				// 이파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
				
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				// 이제 파일올리기를 한다.
				// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
				
				System.out.println(">>> 확인용 newFileName ==> " + newFileName); 
				// >>> 확인용 newFileName ==> 201907251244341722885843352000.jpg 
			/*	
				// == 3. BoardVO boardvo 에 fileName 값과 orgFilename 값과  fileSize 값을 넣어주기 
				boardvo.setFileName(newFileName);
				// WAS(톰캣)에 저장된 파일명(201907251244341722885843352000.jpg)
				
				boardvo.setOrgFilename(attach.getOriginalFilename());
				// 게시판 페이지에서 첨부된 파일의 파일명(강아지.png)을 보여줄때 및  
				// 사용자가 파일을 다운로드 할때 사용되어지는 파일명
				
				fileSize = attach.getSize();
				boardvo.setFileSize(String.valueOf(fileSize));
				// 게시판 페이지에서 첨부한 파일의 크기를 보여줄때 String 타입으로 변경해서 저장함.
			*/
				
				addMap.put("newFileName", newFileName);	
				addMap.put("fileName", attach.getOriginalFilename());
				
			} catch (Exception e) {
				e.printStackTrace();
			}


		 	
		}
		//	========= !! 첨부파일이 있는지 없는지 알아오기 끝 !! =========
		
		//  === #143. 파일첨부가 있는 경우와 없는 경우에 따라서 Service단 호출하기 === 
		//      먼저 위의 	int n = service.add(boardvo); 부분을 주석처리하고서 아래처럼 한다.
		
		int n = 0;
	/*	if(attach.isEmpty()) {
			// 첨부파일이 없는 경우이라면
			n = service.add(addMap); 
		}
		else {
			// 첨부파일이 있는 경우이라면
			n = service.add_withFile(addMap);
		}*/
		
		n = service.editEnd(addMap);

		mrequest.setAttribute("n", n);

		
		mav.setViewName("redirect:boardmenu4.to");
		
		return mav;
		
	}
	
	// 글 삭제하기
	@RequestMapping(value = "reviewDelete.to", method = {RequestMethod.POST})
	public ModelAndView requiredLogin_reviewDelete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String reviewno = request.getParameter("reviewno");
		
		ReviewVO rvo = service.reviewDetail(reviewno);
		
		int n = service.reviewDelete(rvo);
		
		mav.setViewName("redirect:boardmenu4.to");
		
		return mav;
		
	}
	
	
	///////////////////////////////////////////////// 대끌  /////////////////////////////////////////////////
	
	// 댓글 달기
	@RequestMapping(value = "addCmt.to", method = {RequestMethod.POST})
	public ModelAndView requiredLogin_addCmt(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String fk_userno = "";
		String name="";
		
		if(loginuser !=null) {
			fk_userno = loginuser.getUserno();
			name = loginuser.getUsername();
		}
		
		String comment = request.getParameter("comment");
		/*String name = request.getParameter("name");*/
		/*String fk_userno = request.getParameter("fk_userno");*/
		String fk_reviewno = request.getParameter("fk_reviewno");
		
		String fk_replyno = request.getParameter("fk_replyno");
		String groupno = request.getParameter("groupno");
		String depthno = request.getParameter("depthno");
		
		System.out.println("fk_userno :"+fk_userno);
		System.out.println("name :"+name);
		System.out.println("fk_reviewno :"+fk_reviewno);
		System.out.println("comment :"+comment);
		
		HashMap<String, String> paramap = new HashMap<String, String>();
		
		paramap.put("comment", comment);
		paramap.put("name", name);
		paramap.put("fk_userno", fk_userno);
		paramap.put("fk_reviewno", fk_reviewno);
	
		paramap.put("fk_replyno", fk_replyno);
		paramap.put("groupno", groupno);
		paramap.put("depthno", depthno);
		
		if( loginuser != null ) {
			service.addCmt(paramap);			
		}
		
		session.setAttribute("fk_reviewno", fk_reviewno);
		
		String loc = request.getContextPath()+"/reviewDetail.to?reviewno="+fk_reviewno;
		
		mav.addObject("loc", loc);
		mav.setViewName("msg");
		
		return mav;
		
	}
	
	@RequestMapping(value = "addCmt.to", method = {RequestMethod.GET})
	public ModelAndView requiredLogin_addCmt2(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		
		String fk_reviewno = (String)session.getAttribute("fk_reviewno");
		
		System.out.println(fk_reviewno);
		
		String loc = request.getContextPath()+"/reviewDetail.to?reviewno="+fk_reviewno; 
		mav.addObject("loc", loc);
		mav.setViewName("msg");
		
		session.removeAttribute("fk_reviewno");
		
		return mav;
	}
/*	
	// 댓글 달기
	@RequestMapping(value = "addCmt.to", method = {RequestMethod.POST})
	public ModelAndView requiredLogin_addCmt(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String fk_reviewno = request.getParameter("fk_reviewno");
		
			String comment = request.getParameter("comment");
			String name = request.getParameter("name");
		//	String fk_userno = request.getParameter("fk_userno");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String fk_userno = loginuser.getUserno();
		
			String fk_replyno = request.getParameter("fk_replyno");
			String groupno = request.getParameter("groupno");
			String depthno = request.getParameter("depthno");
			
			HashMap<String, String> paramap = new HashMap<String, String>();
			
			paramap.put("comment", comment);
			paramap.put("name", name);
			paramap.put("fk_userno", fk_userno);
			paramap.put("fk_reviewno", fk_reviewno);
		
			paramap.put("fk_replyno", fk_replyno);
			paramap.put("groupno", groupno);
			paramap.put("depthno", depthno);
			
			
			
			int n = service.addCmt(paramap);
			
			if(n == 1) {
				
				
			}
			
			mav.setViewName("redirect:reviewDetail.to?reviewno="+fk_reviewno);
			
		return mav;
		
	}
*/
	// 댓글 삭제하기
	@RequestMapping(value="deleteCom.to", method = {RequestMethod.POST})
	public void requiredLogin_deleteCom(HttpServletRequest request, HttpServletResponse response) {
		
		String replyno = request.getParameter("replyno");
		String groupno = request.getParameter("groupno");
		String reviewno = request.getParameter("reviewno");
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("replyno", replyno);
		map.put("groupno", groupno);
		map.put("reviewno", reviewno);
		
		// 원글 삭제인지 대댓글 삭제인지 ㅎㅎ 
		int n = service.countReply(map);
		
		if(n>1) {
			
			// 대댓글 o -> 댓글 status 0 으로 변경
			int m = service.deleteCom(map);
			
		}
		else if(n==1) {
			
			// status 가 0 으로 변경된 댓글 갯수
			int g = service.countStReply(map);
			
			if(g == 0) {
				// 대댓글x -> 댓글 아예 삭제
				map.put("chk", "");
				int x = service.realDeleteCom(map);
			}
			else if (g > 0) {
				
				map.put("chk", groupno);
				int x = service.realDeleteCom(map);
				
			}
			
			
		}
		
		
		
	}
	
	
	
	
	
}
