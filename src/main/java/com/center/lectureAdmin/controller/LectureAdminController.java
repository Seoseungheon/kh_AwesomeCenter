package com.center.lectureAdmin.controller;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.center.lectureAdmin.model.EventBoardVO;
import com.center.lectureAdmin.model.LectureAdminVO;
import com.center.lectureAdmin.model.LectureStudentVO;
import com.center.lectureAdmin.service.InterLectureAdminService;
import com.center.member.model.MemberVO;
import com.center.common.FileManager;
import com.center.common.MyUtil;



@Controller
public class LectureAdminController {

	@Autowired
	private InterLectureAdminService service;
	
	@Autowired
	   private FileManager fileManager;
	
	// 관리자
	// 강좌 등록 페이지
	@RequestMapping(value="/registerLectureAdmin.to")
	public ModelAndView registerLectureAdmin(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null || !"8".equals(loginuser.getUserno()) ) {
			
			String msg="관리자만 접근 가능한 페이지입니다.";
			String loc="main.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
										
		} else {
			mav.setViewName("admin/lectureAdmin/registerLectureAdmin.tiles1");
		}	
		return mav;
	}
	
	// 강좌 등록 완료
	@RequestMapping(value="/registerEndLectureAdmin.to", method= {RequestMethod.POST})
	public ModelAndView registerEndLectureAdmin(LectureAdminVO lecturevo, MultipartHttpServletRequest mrequest, ModelAndView mav) {
	
		// 첨부파일 유무 알아오기
		MultipartFile attach = lecturevo.getAttach();
	
		// 첨부파일 O
		if(!attach.isEmpty()) {
			
			// WAS webapp 의 절대경로를 알아오기
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root + "resources" + File.separator + "images_lecture";
				
			String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null; // 첨부파일을 WAS(톰캣)의 디스크에 저장할 때 사용
		
			try {
				bytes = attach.getBytes(); //첨부된 파일을 바이트 단위로 읽어오기
				
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path); //파일 올리기
		//		System.out.println(">>> 확인용 newFileName ==> " + newFileName); 
			
				lecturevo.setClass_photo(newFileName);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}//(!attach.isEmpty())
		//========= !!첨부파일이 있는지 없는지 알아오기 끝!! ========= */
				
     /* // *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드)작성하기 ***
		lecturevo.setClass_title(MyUtil.replaceParameter(lecturevo.getClass_title()));
		lecturevo.setClass_content(MyUtil.replaceParameter(lecturevo.getClass_content()));
		lecturevo.setClass_content(lecturevo.getClass_content().replaceAll("\r\n", "<br/>"));
      */
		int n = 0;
		
  		if(attach.isEmpty()) {
  			// 첨부파일이 없는 경우
  			n = service.insertLectureNoFile(lecturevo);
  			
  			if(n==1) {
  				mav.addObject("msg", "신규 강좌 등록 성공");
  			}
  			else {
  				mav.addObject("msg", "신규 강좌 등록 실패");
  			}
  		}
  		else {
  			// 첨부파일이 있는 경우
  			n = service.insertLectureFile(lecturevo);
  			
  			if(n==1) {
  				mav.addObject("msg", "신규 강좌 등록 성공");
  			}
  			else {
  				mav.addObject("msg", "신규 강좌 등록 실패");
  			}
  		}
  		
  		mav.addObject("n",n);
		mav.addObject("loc", mrequest.getContextPath()+"/lectureListAdmin.to");
		mav.setViewName("msg");
		 
		return mav;
		
	}
	
	// 강좌 리스트
	@RequestMapping(value="/lectureListAdmin.to", method= {RequestMethod.GET})
	public ModelAndView lectureListAdmin(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null || !"8".equals(loginuser.getUserno()) ) {
			
			String msg="관리자만 접근 가능한 페이지입니다.";
			String loc="main.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("msg");								
		} 
		
		else {
			
		
		  List<LectureAdminVO> lectureAdminList = null;
	      		 
	      String str_currentShowPageNo = request.getParameter("currentShowPageNo");
	      
	      int totalCount = 0;        // 필요한것1 : 총 게시물 건수
	      int sizePerPage = 10;      // 필요한것2 : 한 페이지당 보여줄 게시물 수 
	      int currentShowPageNo = 0; // 필요한것3 : 현재 보여주는 페이지 번호로서, 초기치는 1페이지로 설정
	      int totalPage = 0; 		 // 필요한것4 : 총 페이지수(웹브라우저상에 보이는 
	      int startRno = 0; 		 // 필요한것5 : 시작 행 번호
	      int endRno = 0;			 // 필요한것6 : 끝 행 번호 
	      
	      String cate_code = request.getParameter("cate_code");
	      String fk_cate_no = request.getParameter("fk_cate_no");
	      String class_status = request.getParameter("class_status");
	      String class_title = request.getParameter("class_title");
	      
	      if(cate_code == null || cate_code.trim().isEmpty()) {
	    	  cate_code = "";
	      }
	      
	      if(fk_cate_no == null || fk_cate_no.trim().isEmpty()) {
	    	  fk_cate_no = "";
	      }
	      
	      if(class_status == null || class_status.trim().isEmpty()) {
	    	  class_status = "";
	      }
	      if(class_title == null || class_title.trim().isEmpty()) {
	    	  class_title = "";
	      }
	      
	      HashMap<String, String> paraMap = new HashMap<String, String >();
	      paraMap.put("cate_code", cate_code);
	      paraMap.put("fk_cate_no", fk_cate_no);
	      paraMap.put("class_status", class_status);
	      paraMap.put("class_title", class_title);
	      // 먼저 총 게시물 건수(totalCount)를 구해와야 하는데 이것은
	      // 검색 조건이 있을 떄와 없을 때로 나뉘어 진다.
	      if("".equals(cate_code) && "".equals(fk_cate_no) && "".equals(class_status) && "".equals(class_title)) {
		         totalCount = service.getTotalCountNoSearch();
		     //    System.out.println("검색조건이 없을 경우 totalCount : " + totalCount); 
		      }
		      else {
		    	  totalCount = service.getTotalCountSearch(paraMap);
		    //	  System.out.println("검색조건이 있을 경우 totalCount : " + totalCount); 
		      }
	  
	      totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
	      
	      if(str_currentShowPageNo == null) { 
	    	  
	    	  //검색어가 없음 -> 게시판에 보여지는 초기화면
	    	  currentShowPageNo = 1;  // =>  초기화면은 /list.action?currentShowPageNo=1로 한다.
	      }
	      else {
	    	  try {
	              currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
	              
	              if(currentShowPageNo < 1 || currentShowPageNo >totalPage) {
	                 currentShowPageNo = 1; ///teacherListAdmin.to?currentShowPageNo=1
	              }
	              
	          } catch (NumberFormatException e) {
	             currentShowPageNo = 1;
	          }
	      }
	      
	      // ******* (공식) 가져올 게시글의 범위를 구한다 **************
	      /*	currentShowPageNo       startRno     endRno
	       			1 page                  1           10
	        		2 page 				    2           20
	        		 ...                   ...          ...	    */
	      startRno = ((currentShowPageNo-1) * sizePerPage) +1;
	    	endRno =  startRno + sizePerPage - 1;
	    	
	     // db에서 가져오기
	    	paraMap.put("startRno", String.valueOf(startRno)); //paraMap이 <String,String>이니까 int인 startRno를 String으로 바꿔야함
	    	paraMap.put("endRno", String.valueOf(endRno));
	    	
	    	// 페이징처리한 글목록 가져오기 (검색값 유무 관계없이)
	    	lectureAdminList = service.getLectureAdminList(paraMap);    

	    	// 페이지바
	    	String pageBar = "<ul>";
	
			int blockSize = 10;  // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수 이다.
		
			int loop = 1; //loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(위의 설명상 지금은  10개(==blockSize))까지만 증가하는 용도이다. 
			
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1; // *** 공식 
			
		
			String url = "lectureListAdmin.to";	
			String lastStr = url.substring(url.length()-1);
			if(!"?".equals(lastStr)) 
				url += "?"; 
			
			// *** [맨처음] 만들기
			pageBar += "&nbsp;<a href='"+url+"&currentShowPageNo=1&sizePerPage="+sizePerPage+"&cate_code="+cate_code+"&fk_cate_no="+fk_cate_no+"&class_status="+class_status+"&class_title="+class_title+"'><img class='pagebar-btn' src='resources/images/pagebar-left-double-angle.png' /></a>&nbsp;";
			 		
			// *** [이전] 만들기 *** 
			if(pageNo != 1) {
				pageBar += "&nbsp;<a href='"+url+"&currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&cate_code="+cate_code+"&fk_cate_no="+fk_cate_no+"&class_status="+class_status+"&class_title="+class_title+"'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /></a>&nbsp;";
			} else {
				pageBar += "&nbsp;<a href='"+url+"&currentShowPageNo="+1+"&sizePerPage="+sizePerPage+"&cate_code="+cate_code+"&fk_cate_no="+fk_cate_no+"&class_status="+class_status+"&class_title="+class_title+"'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /></a>&nbsp;";
			}
			
			while( !(loop>blockSize || pageNo>totalPage) ) {
				if(pageNo == currentShowPageNo) {
					pageBar += "&nbsp;<span style='font-weight:bold; padding: 2px; color:red;'>"+pageNo+"</span>&nbsp;";
				}
				else {
					pageBar += "&nbsp;<a href='"+url+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&cate_code="+cate_code+"&fk_cate_no="+fk_cate_no+"&class_status="+class_status+"&class_title="+class_title+"'>"+pageNo+"</a>&nbsp;"; 
					       // ""+1+"&nbsp;"+2+"&nbsp;"+3+"&nbsp;"+......+10+"&nbsp;"
				}		
				loop++;
				pageNo++;
			}// end of while---------------------------------
			
			// *** [다음] 만들기 *** 
			
				pageBar += "&nbsp;<a href='"+url+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&cate_code="+cate_code+"&fk_cate_no="+fk_cate_no+"&class_status="+class_status+"&class_title="+class_title+"'><img class='pagebar-btn' src='resources/images/pagebar-right-angle.png' /></a>&nbsp;"; 
			
			
			// *** [맨마지막] 만들기 *** //
			pageBar += "&nbsp;<a href='"+url+"&currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&cate_code="+cate_code+"&fk_cate_no="+fk_cate_no+"&class_status="+class_status+"&class_title="+class_title+"'><img class='pagebar-btn' src='resources/images/pagebar-right-double-angle.png' /></a>&nbsp;";
			
			pageBar += "</ul>";
	    	
	    	mav.addObject("pageBar", pageBar);
	    	mav.addObject("paraMap", paraMap);
	    	mav.addObject("lectureAdminList", lectureAdminList);
	    	mav.setViewName("admin/lectureAdmin/lectureListAdmin.tiles1");
		}
	    	return mav;
	}
	
	// 강좌 수정 페이지
	@RequestMapping(value="/editLectureAdmin.to", method= {RequestMethod.GET})
	public ModelAndView editLectureAdmin(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null || !"8".equals(loginuser.getUserno()) ) {
			
			String msg="관리자만 접근 가능한 페이지입니다.";
			String loc="main.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
										
		} else {
		
			String class_seq = request.getParameter("class_seq");
			String class_status = request.getParameter("class_status");
		//	System.out.println("class_status:"+class_status);
			LectureAdminVO lectureInfo = service.getLectureInfo(class_seq);
			
			mav.addObject("lectureInfo", lectureInfo);
			mav.setViewName("admin/lectureAdmin/editLectureAdmin.tiles1");
		}
		return mav;
	}
	
	// 강좌 수정 완료
		@RequestMapping(value="/editLectureEndAdmin.to", method= {RequestMethod.POST})
		public ModelAndView editLectureEndAdmin(MultipartHttpServletRequest mrequest, LectureAdminVO lecturevo, ModelAndView mav) {
			
			// 첨부파일 유무 알아오기
			MultipartFile attach = lecturevo.getAttach();
			
			// 첨부파일 O
			if(!attach.isEmpty()) {
				
				// WAS webapp 의 절대경로를 알아오기
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root + "resources" + File.separator + "images_lecture";
					
				String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명
				
				byte[] bytes = null; // 첨부파일을 WAS(톰캣)의 디스크에 저장할 때 사용
			
				try {
					bytes = attach.getBytes(); //첨부된 파일을 바이트 단위로 읽어오기
					
					newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path); //파일 올리기
			//		System.out.println(">>> 확인용 newFileName ==> " + newFileName); 
				
					lecturevo.setClass_photo(newFileName);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}//(!attach.isEmpty())
			
			/* // *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드)작성하기 ***
			lecturevo.setClass_title(MyUtil.replaceParameter(lecturevo.getClass_title()));
			lecturevo.setClass_content(MyUtil.replaceParameter(lecturevo.getClass_content()));
			lecturevo.setClass_content(lecturevo.getClass_content().replaceAll("\r\n", "<br/>"));*/
			
			int n = 0;
			
	  		if(attach.isEmpty()) {
	  			// 첨부파일이 없는 경우
	  			n = service.editLectureNoFile(lecturevo);
	  			if(n==1) {
	  				mav.addObject("msg", "강좌 수정 성공");
	  			}
	  			else {
	  				mav.addObject("msg", "강좌 수정 실패");
	  			}
	  			
	  		}
	  		else {
	  			// 첨부파일이 있는 경우
	  			n = service.editLecture(lecturevo);
	  			if(n==1) {
	  				mav.addObject("msg", "강좌 수정 성공");
	  			}
	  			else {
	  				mav.addObject("msg", "강좌 수정 실패");
	  			}
	  		}
		  		
	  		 mav.addObject("n",n);
			 mav.addObject("loc", mrequest.getContextPath()+"/detailLectureAdmin.to?class_seq="+lecturevo.getClass_seq());
			 mav.setViewName("msg");
			 
			 return mav;
			
			
			
		}
	
	// 강좌 정보 상세 
	@RequestMapping(value="/detailLectureAdmin.to")
	public ModelAndView detailLectureAdmin(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null || !"8".equals(loginuser.getUserno()) ) {
			
			String msg="관리자만 접근 가능한 페이지입니다.";
			String loc="main.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
										
		} else {				
			String class_seq = request.getParameter("class_seq");
			
			LectureAdminVO lectureInfo = service.getLectureInfo(class_seq); //강좌 정보
			
			List<LectureStudentVO> studentList = service.getLectureStudentList(class_seq); //수강생 명단
			
			for(int i=0; i<studentList.size(); i++) {
				System.out.println("size"+studentList.size());
			}
		
			List<LectureStudentVO> waitingtList = service.getWaitingtList(class_seq); //대기자 명단
				
			mav.addObject("lectureInfo", lectureInfo);
			mav.addObject("studentList", studentList);
			mav.addObject("waitingtList", waitingtList);
			
			mav.setViewName("admin/lectureAdmin/detailLectureAdmin.tiles1");
		}
		return mav;		
	}
	
	// 수강중인 학생 삭제
	 @RequestMapping(value="/studentDelEnd.to", method= {RequestMethod.POST}) 
	   public ModelAndView studentDelEnd(HttpServletRequest request, ModelAndView mav, LectureStudentVO lvo) {
	      
		 String fk_userno = request.getParameter("fk_userno");
		 String fk_class_seq = request.getParameter("fk_class_seq");
	
		 lvo.setFk_userno(fk_userno);
		 lvo.setFk_class_seq(fk_class_seq);
		 
		 int n = service.deleteStudentAdmin(lvo); //수강생 삭제		
	      
		 if(n == 0) {
		     mav.addObject("msg", "수강생 삭제 실패");
		      }    
	      else {
	         mav.addObject("msg", "해당 수강생을 삭제했습니다.");
	      }
		 
		 mav.addObject("loc", "detailLectureAdmin.to?class_seq="+fk_class_seq);
		 mav.setViewName("msg");

	     return mav;
	   }
	
	
	// 11. 강좌 삭제
	 @RequestMapping(value="/delLectureEnd.to", method= {RequestMethod.POST}) 
	   public ModelAndView delLectureEnd(HttpServletRequest request, ModelAndView mav) {
	
		 String class_seq = request.getParameter("class_seq");
		 
		 int n = service.deleteLecture(class_seq);
		
		 if(n==0) {
			 mav.addObject("msg", "강좌 삭제 실패");
		 }
		 else {
			 mav.addObject("msg", "강좌 삭제 성공");
		 }
		 
		 mav.addObject("loc", request.getContextPath()+"/lectureListAdmin.to");
		 mav.setViewName("msg");
		 
		 return mav;
	     		
	 }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	 // 게시판 메뉴
	 @RequestMapping(value="/boardmenu2.to" , method= {RequestMethod.GET})
	 public ModelAndView eventBoardMenu(HttpServletRequest request, ModelAndView mav) {

		 List<EventBoardVO> eventList = null;
		 String searchType = request.getParameter("searchType");
		 String searchWord = request.getParameter("searchWord");

		 String str_currentShowPageNoE = request.getParameter("currentShowPageNoE"); 

		 int totalCountE = 0;        // 필요한것1 : 총 게시물 건수
		 int sizePerPageE = 10;      // 필요한것2 : 한 페이지당 보여줄 게시물 수 
		 int currentShowPageNoE = 0; // 필요한것3 : 현재 보여주는 페이지 번호로서, 초기치는 1페이지로 설정
		 int totalPageE = 0; 		 // 필요한것4 : 총 페이지수(웹브라우저상에 보이는 
		 int startRnoE = 0; 		 // 필요한것5 : 시작 행 번호
		 int endRnoE = 0;			 // 필요한것6 : 끝 행 번호 

		 if(searchType == null || searchType.trim().isEmpty()) {
			 searchType = "";
		 }		      

		 if(searchWord == null || searchWord.trim().isEmpty()) {
			 searchWord = "";
		 }

		 HashMap<String, String> paraMapE = new HashMap<String, String >();
		 paraMapE.put("searchType", searchType);		    
		 paraMapE.put("searchWord", searchWord);

		 // 먼저 총 게시물 건수(totalCount)를 구해와야 하는데 이것은
		 // 검색 조건이 있을 떄와 없을 때로 나뉘어 진다.
		 if("".equals(searchType) && "".equals(searchWord)) {
			 totalCountE = service.getTotalCountBoard();
			 //   System.out.println("검색조건이 없을 경우 totalCount : " + totalCountE); 
		 }
		 else {
			 totalCountE = service.getTotalCountBoardSearch(paraMapE);
			 //   System.out.println("검색조건이 있을 경우 totalCount : " + totalCountE); 
		 }


		 totalPageE = (int)Math.ceil((double)totalCountE/sizePerPageE);

		 if(str_currentShowPageNoE == null) {
			 // 게시판에 보여지는 초기화면

			 currentShowPageNoE = 1;
			 // 즉, 초기화면은  /list.action?currentShowPageNo=1 로 한다는 말이다.
		 }
		 else {

			 try {
				 currentShowPageNoE = Integer.parseInt(str_currentShowPageNoE);

				 if(currentShowPageNoE < 1 || currentShowPageNoE > totalPageE) {
					 currentShowPageNoE = 1;
				 }
			 } catch (NumberFormatException e) {
				 currentShowPageNoE = 1;
			 }
		 }


		 startRnoE = ((currentShowPageNoE-1) * sizePerPageE) +1;
		 endRnoE =  startRnoE + sizePerPageE - 1;

		 // db에서 가져오기	    	
		 paraMapE.put("startRnoE", String.valueOf(startRnoE)); 
		 paraMapE.put("endRnoE", String.valueOf(endRnoE));

		 // 페이징처리한 글목록 가져오기(검색값 유무 상관없이)
		 eventList = service.getEventList(paraMapE);	

		 if(!"".equals(searchWord)) {
			 mav.addObject("paraMapE", paraMapE);
		 }

		 // 페이지바 만들기 
		 String pageBarE = "<ul>";

		 int blockSizeE = 10;  // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수

		 int loopE = 1; //loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(위의 설명상 지금은  10개(==blockSize))까지만 증가하는 용도이다. 

		 int pageNoE = ((currentShowPageNoE - 1)/blockSizeE) * blockSizeE + 1; // *** 공식 

		 String urlE = "boardmenu2.to";	
		 String lastStrE = urlE.substring(urlE.length()-1);
		 if(!"?".equals(lastStrE)) 
			 urlE += "?"; 

		 // *** [맨처음] 만들기
		 pageBarE += "&nbsp;<a href='"+urlE+"&currentShowPageNoE=1&sizePerPageE="+sizePerPageE+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-left-double-angle.png' /></a>&nbsp;";

		 // *** [이전] 만들기 *** //    
		 if(pageNoE != 1) {
			 pageBarE += "&nbsp;<a href='"+urlE+"&currentShowPageNoE="+(pageNoE-1)+"&sizePerPageE="+sizePerPageE+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /></a>&nbsp;";
		 } else {
			 pageBarE += "&nbsp;<a href='"+urlE+"&currentShowPageNoE="+1+"&sizePerPageE="+sizePerPageE+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /></a>&nbsp;";
		 }

		 while( !(loopE>blockSizeE || pageNoE>totalPageE) ) {
			 if(pageNoE == currentShowPageNoE) {
				 pageBarE += "&nbsp;<span class='pagebar-number' style='color:red; font-weight:bold;'>"+pageNoE+"</span>&nbsp;";
			 }
			 else {
				 pageBarE += "&nbsp;<a class='pagebar-number' href='"+urlE+"&currentShowPageNoE="+pageNoE+"&sizePerPageE="+sizePerPageE+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNoE+"</a>&nbsp;"; 
				 // ""+1+"&nbsp;"+2+"&nbsp;"+3+"&nbsp;"+......+10+"&nbsp;"
			 }		
			 loopE++;
			 pageNoE++;
		 }// end of while---------------------------------

		 // *** [다음] 만들기 *** //
		 pageBarE += "&nbsp;<a href='"+urlE+"&currentShowPageNoE="+pageNoE+"&sizePerPageE="+sizePerPageE+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-right-angle.png' /></a>&nbsp;"; 


		 // *** [맨마지막] 만들기 *** //
		 pageBarE += "&nbsp;<a href='"+urlE+"&currentShowPageNoE="+totalPageE+"&sizePerPageE="+sizePerPageE+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-right-double-angle.png' /></a>&nbsp;";
		 pageBarE += "</ul>";


		 //글 조회수 증가
		 HttpSession session = request.getSession();
		 session.setAttribute("readCountPermissionE", "yes"); 

		 mav.addObject("currentShowPageNoE", String.valueOf(currentShowPageNoE));   
		 mav.addObject("totalCountE", String.valueOf(totalCountE));   
		 mav.addObject("sizePerPageE", sizePerPageE);
		 mav.addObject("pageBarE", pageBarE);    	
		 mav.addObject("eventList", eventList);
		 mav.setViewName("board4/boardmenu2.tiles1");
		 return mav;
	 }


	 // 이벤트 게시판 상세 내역
	 @RequestMapping(value="/eventBoardDetail.to", method= {RequestMethod.GET})
	 public ModelAndView eventBoardDetail(HttpServletRequest request, ModelAndView mav) {

		 String event_seq = request.getParameter("event_seq");
		 System.out.println("event_seq"+event_seq);
		 HttpSession session = request.getSession();
		 MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");

		 String userno = "";
		 if(loginuser != null) {
			 userno = loginuser.getUserno();
		 }

		 EventBoardVO eventBoardInfo = null;

		 if("yes".equals(session.getAttribute("readCountPermissionE"))) {
			 eventBoardInfo = service.getEventInfo(event_seq, userno); // 글 조회 + 조회수 증가
			 session.removeAttribute("readCountPermissionE"); // session에 저장된 readCountPermissionE 삭제
		 }
		 else {
			 eventBoardInfo = service.getEventInfoNoCount(event_seq); // 조회수 증가 없이 글 조회만  
		 }

		 mav.addObject("eventBoardInfo", eventBoardInfo);
		 mav.setViewName("board4/eventBoardDetail.tiles1");
		 return mav;
	 }


	 // 이벤트 게시판 글 수정 페이지
	 @RequestMapping(value="/eventBoardEdit.to", method= {RequestMethod.GET})
	 public ModelAndView eventBoardEdit(HttpServletRequest request,HttpServletResponse response, EventBoardVO eventvo, ModelAndView mav) {

		 HttpSession session = request.getSession();
		 MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		 if(loginuser == null || !"8".equals(loginuser.getUserno()) ) {

			 String msg="관리자만 접근 가능한 페이지입니다.";
			 String loc="boardmenu2.to";

			 mav.addObject("msg", msg);
			 mav.addObject("loc", loc);

			 mav.setViewName("msg");

		 } else {			
			 String event_seq = request.getParameter("event_seq");

			 EventBoardVO eventBoardInfo = service.getEventInfoNoCount(event_seq);

			 mav.addObject("eventBoardInfo", eventBoardInfo);
			 mav.setViewName("board4/eventBoardEdit.tiles1");
		 }

		 return mav;

	 }


	 // 이벤트 게시판 글 수정 완료
	 @RequestMapping(value="/eventBoardEditEnd.to", method= {RequestMethod.POST})
	 public ModelAndView eventBoardEditEnd(HttpServletRequest request, HttpServletResponse response, EventBoardVO eventvo, ModelAndView mav, MultipartHttpServletRequest mrequest) {

		 // 첨부파일 유무 알아오기
		 MultipartFile attach = eventvo.getAttach();

		 // 첨부파일 O
		 if(!attach.isEmpty()) {

			 // WAS webapp 의 절대경로를 알아오기
			 HttpSession session = request.getSession();
			 String root = session.getServletContext().getRealPath("/");
			 String path = root + "resources" + File.separator + "syimages";

			 String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명

			 byte[] bytes = null; // 첨부파일을 WAS(톰캣)의 디스크에 저장할 때 사용

			 try {
				 bytes = attach.getBytes(); //첨부된 파일을 바이트 단위로 읽어오기

				 newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path); //파일 올리기
				 //	System.out.println(">>> 확인용 newFileName ==> " + newFileName); 

				 eventvo.setEvent_photo(newFileName);

			 } catch (Exception e) {
				 e.printStackTrace();
			 }
		 }//(!attach.isEmpty())
		 //========= !!첨부파일이 있는지 없는지 알아오기 끝!! ========= */

		/* // *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드)작성하기 ***
		 eventvo.setEvent_title(MyUtil.replaceParameter(eventvo.getEvent_title()));
		 eventvo.setEvent_content(MyUtil.replaceParameter(eventvo.getEvent_content()));
		 eventvo.setEvent_content(eventvo.getEvent_content().replaceAll("\r\n", "<br/>"));*/



		 int n = 0;
		 eventvo.setFk_userno("8");

		 if(attach.isEmpty()) {
			 // 첨부파일이 없는 경우
			 n = service.editEventBoardNoFile(eventvo);	

			 if(n==1) {
				 mav.addObject("msg", "이벤트 수정 성공");
			 }
			 else {
				 mav.addObject("msg", "이벤트 수정 실패");
			 }
		 }
		 else {
			 // 첨부파일이 있는 경우
			 n = service.editEventBoardFile(eventvo);	

			 if(n==1) {
				 mav.addObject("msg", "이벤트 수정 성공");
			 }
			 else {
				 mav.addObject("msg", "이벤트 수정 실패");
			 }
		 }

		 mav.addObject("n",n);
		 mav.addObject("loc", request.getContextPath()+"/eventBoardDetail.to?event_seq="+eventvo.getEvent_seq()); 
		 mav.setViewName("msg");

		 return mav;

	 }



	 // 이벤트게시판 등록 페이지
	 @RequestMapping(value="/eventBoardRegister.to")
	 public ModelAndView eventBoardRegister(HttpServletRequest request, HttpServletResponse response, EventBoardVO eventvo, ModelAndView mav) {

		 HttpSession session = request.getSession();
		 MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		 if(loginuser == null || !"8".equals(loginuser.getUserno()) ) {

			 String msg="관리자만 접근 가능한 페이지입니다.";
			 String loc="boardmenu2.to";

			 mav.addObject("msg", msg);
			 mav.addObject("loc", loc);

			 mav.setViewName("msg");

		 } else {			
			 eventvo.setFk_userno(loginuser.getUserno());
			 mav.addObject("eventvo", eventvo);
			 mav.setViewName("board4/eventBoardRegister.tiles1");			
		 }

		 return mav;


	 }

	 // 이벤트게시판 등록 완료
	 @RequestMapping(value="/eventBoardRegisterEnd.to", method= {RequestMethod.POST})
	 public ModelAndView eventBoardRegisterEnd(HttpServletRequest request, MultipartHttpServletRequest mrequest, EventBoardVO eventvo, ModelAndView mav) {					

		 // 첨부파일 유무 알아오기
		 MultipartFile attach = eventvo.getAttach();

		 // 첨부파일 O
		 if(!attach.isEmpty()) {

			 // WAS webapp 의 절대경로를 알아오기
			 HttpSession session = request.getSession();
			 String root = session.getServletContext().getRealPath("/");
			 String path = root + "resources" + File.separator + "syimages";

			 String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명

			 byte[] bytes = null; // 첨부파일을 WAS(톰캣)의 디스크에 저장할 때 사용

			 try {
				 bytes = attach.getBytes(); //첨부된 파일을 바이트 단위로 읽어오기

				 newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path); //파일 올리기
				 //	System.out.println(">>> 확인용 newFileName ==> " + newFileName); 

				 eventvo.setEvent_photo(newFileName);

			 } catch (Exception e) {
				 e.printStackTrace();
			 }
		 }//(!attach.isEmpty())

		/* // *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드)작성하기 ***
		 eventvo.setEvent_title(MyUtil.replaceParameter(eventvo.getEvent_title()));
		 eventvo.setEvent_content(MyUtil.replaceParameter(eventvo.getEvent_content()));
		 eventvo.setEvent_content(eventvo.getEvent_content().replaceAll("\r\n", "<br/>"));
*/
		 int n = 0;
		 if(!attach.isEmpty()) {
			 // 첨부파일이 있는 경우
			 n = service.registerEventBoardFile(eventvo);	 		

			 if(n==1) {
				 mav.addObject("msg", "이벤트 등록 성공");
			 }
			 else {
				 mav.addObject("msg", "이벤트 등록 실패");
			 }
		 }
		 else {
			 // 첨부파일이 없는 경우
			 n = service.registerEventBoardNoFile(eventvo);					

			 if(n==1) {
				 mav.addObject("msg", "이벤트 등록 성공");
			 }
			 else {
				 mav.addObject("msg", "이벤트 등록 실패");
			 }
		 }

		 mav.addObject("n",n);
		 mav.addObject("loc", request.getContextPath()+"/boardmenu2.to");
		 mav.setViewName("msg");

		 return mav;

	 }

	 // 이벤트게시판 글 삭제
	 @RequestMapping(value="/deleteEvent.to")
	 public ModelAndView deleteEvent(HttpServletRequest request, ModelAndView mav) {

		 HttpSession session = request.getSession();
		 MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		 if(loginuser == null || !"8".equals(loginuser.getUserno()) ) {

			 String msg="관리자만 접근 가능한 페이지입니다.";
			 String loc="boardmenu2.to";

			 mav.addObject("msg", msg);
			 mav.addObject("loc", loc);

		 } else {			

			 String event_seq = request.getParameter("event_seq");

			 int n = service.deleteEvent(event_seq);

			 if(n==1) {
				 mav.addObject("msg", "이벤트 글 삭제 성공");
			 }
			 else {
				 mav.addObject("msg", "이벤트 글 삭제 실패");
			 }			
		 }
		 mav.addObject("loc", request.getContextPath()+"/boardmenu2.to");
		 mav.setViewName("msg");
		 return mav;
	 }


			
	
	

	
}
