package com.center.teacherAdmin.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.center.teacherAdmin.model.TeacherAdminVO;
import com.center.teacherAdmin.service.InterTeacherAdminService;
import com.center.common.FileManager;
import com.center.member.model.MemberVO;

	@Controller
	public class TeacherAdminController {

	@Autowired
	private InterTeacherAdminService service;
	
	@Autowired
	private FileManager fileManager;
	
	// 관리자		
	// 강사 리스트  불러오기
	@RequestMapping(value="/teacherListAdmin.to", method= {RequestMethod.GET})
	public ModelAndView teacherListAdmin(ModelAndView mav, HttpServletRequest request) {
	
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null || !"8".equals(loginuser.getUserno()) ) {
			
			String msg="관리자만 접근 가능한 페이지입니다.";
			String loc="main.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
										
		} else {
			
			List<TeacherAdminVO> teacherList = null;
			
			 // === #115. 페이징처리를 한 검색어가 있는 전체 글목록 보여주기 ===
		      // 페이징 처리를 통한 글목록 보여주기 : 3페이지의 내용을 보고싶다면
		      //                     /list.action?currentShowPageNo=3  처럼 하기
		      String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		      
		      int totalCount = 0;        // 필요한것1 : 총 게시물 건수
		      int sizePerPage = 10;      // 필요한것2 : 한 페이지당 보여줄 게시물 수 
		      int currentShowPageNo = 0; // 필요한것3 : 현재 보여주는 페이지 번호로서, 초기치는 1페이지로 설정
		      int totalPage = 0;        // 필요한것4 : 총 페이지수(웹브라우저상에 보이는 
		      int startRno = 0;        // 필요한것5 : 시작 행 번호
		      int endRno = 0;          // 필요한것6 : 끝 행 번호 
		      
		      String searchCode = request.getParameter("searchCode");
		      String searchText = request.getParameter("searchText");
		      String searchName =  request.getParameter("searchName");
		      String searchStatus =  request.getParameter("searchStatus");
	
	      
		      if(searchCode == null || searchCode.trim().isEmpty()) {
		    	  searchCode = "";
		      }
		      
		      if(searchName == null || searchName.trim().isEmpty()) {
		    	  searchName = "";
		      }
		      
		      if(searchText == null || searchText.trim().isEmpty()) {
		    	  searchText = "";
		      }
		      
		      if(searchStatus == null || searchStatus.trim().isEmpty()) {
		    	  searchStatus = "";
		      }
		      
		      
		      
		      HashMap<String, Object> paraMap = new HashMap<String, Object >();
		      paraMap.put("searchCode", searchCode);
		      paraMap.put("searchName", searchName);
		      paraMap.put("searchText", searchText);
		      paraMap.put("searchStatus", searchStatus);
		     
		     
		      
		      // 먼저 총 게시물 건수(totalCount)를 구해와야 하는데 이것은
		      // 검색 조건이 있을 떄와 없을 때로 나뉘어 진다.
		      if("".equals(searchCode) && "".equals(searchName) && "".equals(searchText) && "".equals(searchStatus)) {
		         totalCount = service.getTotalCountNoSearch();
		         System.out.println("검색조건이 없을 경우 totalCount : " + totalCount); 
		      }
		      else {
		    	  totalCount = service.getTotalCountSearch(paraMap);
		    	  System.out.println("검색조건이 있을 경우 totalCount : " + totalCount); 
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
		      /*   currentShowPageNo       startRno     endRno
		                1 page                  1           10
		              2 page                 2           20
		               ...                   ...          ...       */
		      startRno = ((currentShowPageNo-1) * sizePerPage) +1;
		      endRno =  startRno + sizePerPage - 1;
		       
		     // db에서 가져오기
		       paraMap.put("startRno", String.valueOf(startRno)); //paraMap이 <String,String>이니까 int인 startRno를 String으로 바꿔야함
		       paraMap.put("endRno", String.valueOf(endRno));
		       
		       // 페이징처리한 글목록 가져오기 (검색값 유무 관계없이)
		       teacherList = service.getTeacherList(paraMap);
		       
		    
		       
		      // 페이지바 만들기
		      String pageBar = "<ul>";
	
		      int blockSize = 10;  // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수 이다.
		   
		      int loop = 1; //loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(위의 설명상 지금은  10개(==blockSize))까지만 증가하는 용도이다. 
		      
		      int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1; // *** 공식 
		      
		     /* String url = "teacherListAdmin.to";   
		      String lastStr = url.substring(url.length()-1);
		      if(!"?".equals(lastStr)) 
		         url += "?"; */
		      
		      // *** [맨처음] 만들기 *** //
		      pageBar += "&nbsp;<a href='teacherListAdmin.to?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchCode="+searchCode+"&searchName="+searchName+"&searchText="+searchText+"&searchStatus="+searchStatus+"'><img class='pagebar-btn' src='resources/images/pagebar-left-double-angle.png' /></a>&nbsp;";
		      
		      // *** [이전] 만들기 *** //    
		      if(pageNo != 1) {
		         pageBar += "&nbsp;<a href='teacherListAdmin.to?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchCode="+searchCode+"&searchName="+searchName+"&searchText="+searchText+"&searchStatus="+searchStatus+"'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /></a>&nbsp;";
		      } else {
		    	  pageBar += "&nbsp;<a href='teacherListAdmin.to?currentShowPageNo="+1+"&sizePerPage="+sizePerPage+"&searchCode="+searchCode+"&searchName="+searchName+"&searchText="+searchText+"&searchStatus="+searchStatus+"'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /></a>&nbsp;";
		      }
		 
		      
		      while(!(loop > blockSize || pageNo > totalPage)) {
		         if(pageNo == currentShowPageNo) {
		            pageBar += "&nbsp;<span style='text-weight:bold; color:red;'>"+pageNo+"</span>&nbsp;";
		         }
		         else {
		            pageBar += "&nbsp;<a href='teacherListAdmin.to?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchCode="+searchCode+"&searchName="+searchName+"&searchText="+searchText+"&searchStatus="+searchStatus+"'>"+pageNo+"</a>&nbsp;"; 
		                   // ""+1+"&nbsp;"+2+"&nbsp;"+3+"&nbsp;"+......+10+"&nbsp;"
		         }      
		         loop++;
		         pageNo++;
		      }// end of while---------------------------------
		      
		      // *** [다음] 만들기 *** //		      
		      pageBar += "&nbsp;<a href='teacherListAdmin.to?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchCode="+searchCode+"&searchName="+searchName+"&searchText="+searchText+"&searchStatus="+searchStatus+"'><img class='pagebar-btn' src='resources/images/pagebar-right-angle.png' /></a>&nbsp;"; 
		            
		      // *** [맨마지막] 만들기 *** //	      
		      pageBar += "&nbsp;<a href='teacherListAdmin.to?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchCode="+searchCode+"&searchName="+searchName+"&searchText="+searchText+"&searchStatus="+searchStatus+"'><img class='pagebar-btn' src='resources/images/pagebar-right-double-angle.png' /></a>&nbsp;";
		      pageBar += "</ul>";
		       
		       mav.addObject("pageBar", pageBar);
		       mav.addObject("teacherList", teacherList);
		       mav.addObject("paraMap", paraMap);
			   mav.setViewName("admin/teacherAdmin/teacherListAdmin.tiles1");
		}	
			return mav;
	      //----------------------------------------------------------------------------------------   
	     
		
	}
	

	// 강사 정보 상세 
	@RequestMapping(value="/detailTeacherAdmin.to", method= {RequestMethod.GET})
	public ModelAndView detailTeacherAdmin(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null || !"8".equals(loginuser.getUserno()) ) {
			
			String msg="관리자만 접근 가능한 페이지입니다.";
			String loc="main.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
										
		} else {
			
			String teacher_seq = request.getParameter("teacher_seq");
			
			TeacherAdminVO teacherInfo = service.getTeacherDetail(teacher_seq);
		
			mav.addObject("teacherInfo", teacherInfo);
			mav.setViewName("admin/teacherAdmin/detailTeacherAdmin.tiles1");
		}
		return mav;
	}

	
	// 강사 정보 수정 페이지
		@RequestMapping(value="/editTeacherAdmin.to", method= {RequestMethod.GET})
		public ModelAndView editTeacherAdmin(HttpServletRequest request, ModelAndView mav) {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if(loginuser == null || !"8".equals(loginuser.getUserno()) ) {
				
				String msg="관리자만 접근 가능한 페이지입니다.";
				String loc="main.to";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
											
			} else {
			
				String teacher_seq = request.getParameter("teacher_seq");
				
				TeacherAdminVO teacherInfo = service.getTeacherDetail(teacher_seq);
				
				mav.addObject("teacherInfo", teacherInfo);
				mav.setViewName("admin/teacherAdmin/editTeacherAdmin.tiles1");
			}
			return mav;
		}
	
		
	// 강사 정보 수정 완료
		@RequestMapping(value="/editEndTeacherAdmin.to", method= {RequestMethod.POST})
		public ModelAndView editEndTeacherAdmin(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, TeacherAdminVO teachervo, MultipartHttpServletRequest mrequest) {
			
			
			// 첨부파일 유무 알아오기
			MultipartFile attach = teachervo.getAttach();
			
			// 첨부파일 O
			if(!attach.isEmpty()) {
				
				// WAS webapp 의 절대경로를 알아오기
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root + "resources" + File.separator + "syimages";
			
			//	System.out.println(">>> 확인용 path ==>" + path); // 첨부파일을 저장할 WAS(톰캣)의 폴더
			
				String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명
				
				byte[] bytes = null; // 첨부파일을 WAS(톰캣)의 디스크에 저장할 때 사용
				
				long fileSize = 0; // 파일크기 읽어오기
			
				try {
					bytes = attach.getBytes(); //첨부된 파일을 바이트 단위로 읽어오기
					
					newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path); //파일 올리기
				//	System.out.println(">>> 확인용 newFileName ==> " + newFileName); 
				
					teachervo.setTeafileName(newFileName);
					
					teachervo.setTeaorgFilename(attach.getOriginalFilename());
					
					fileSize = attach.getSize();
					teachervo.setTeafileSize(String.valueOf(fileSize));
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			int n = 0;
			
	  		if(attach.isEmpty()) {
	  			n = service.editTeacherAdmin(teachervo); // 첨부파일 x	
	  			mav.addObject("msg", "강사 정보 수정 완료");
	  			
	  		}
	  		else {		
	  			n = service.editTeacherAdminFile(teachervo); // 첨부파일 o
	  			mav.addObject("msg", "강사 정보 수정 완료");
	  		}
					
	  
	  		/*mav.addObject("loc", request.getContextPath() + "/editEndTeacherAdmin.to?teacher_seq="+teachervo.getTeacher_seq());*/
	
		
	  		mav.addObject("n",n);
			 mav.addObject("loc", mrequest.getContextPath()+"/detailTeacherAdmin.to?teacher_seq="+teachervo.getTeacher_seq());
			 mav.setViewName("msg");
			 return mav;
		}
	
	// 강사 등록 페이지
	@RequestMapping(value="/registerTeacherAdmin.to")
	public ModelAndView registerTeacherAdmin(HttpServletRequest request,  HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null || !"8".equals(loginuser.getUserno()) ) {
			
			String msg="관리자만 접근 가능한 페이지입니다.";
			String loc="main.to";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
										
		} else {
			mav.setViewName("admin/teacherAdmin/registerTeacherAdmin.tiles1");
		}
		return mav;
	}	
	
	// 강사 등록 완료
		@RequestMapping(value="/registerEndTeacherAdmin.to", method= {RequestMethod.POST})
		public String registerEndTeacherAdmin(TeacherAdminVO teachervo, MultipartHttpServletRequest mrequest) {
			
			// 첨부파일 유무 알아오기
			MultipartFile attach = teachervo.getAttach();
			
			// 첨부파일 O
			if(!attach.isEmpty()) {
				
				// WAS webapp 의 절대경로를 알아오기
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root + "resources" + File.separator + "syimages";
			
			//	System.out.println(">>> 확인용 path ==>" + path); // 첨부파일을 저장할 WAS(톰캣)의 폴더
			
				String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명
				
				byte[] bytes = null; // 첨부파일을 WAS(톰캣)의 디스크에 저장할 때 사용
				
				long fileSize = 0; // 파일크기 읽어오기
			
				try {
					bytes = attach.getBytes(); //첨부된 파일을 바이트 단위로 읽어오기
					
					newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path); //파일 올리기
				//	System.out.println(">>> 확인용 newFileName ==> " + newFileName); 
				
					teachervo.setTeafileName(newFileName);
					
					teachervo.setTeaorgFilename(attach.getOriginalFilename());
					
					fileSize = attach.getSize();
					teachervo.setTeafileSize(String.valueOf(fileSize));
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			int n = 0;
			
	  		if(attach.isEmpty()) {
	  			n = service.insertTeacherNoFile(teachervo); // 첨부파일 x
	  		}
	  		else {
	  			n = service.insertTeacher(teachervo); // 첨부파일 o
	  		}
			
	  		mrequest.setAttribute("n", n);
			
			return "admin/teacherAdmin/registerEndTeacherAdmin.tiles1";
		
		}	
		
}
