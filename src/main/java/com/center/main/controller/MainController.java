package com.center.main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.center.admin.model.BoardVO;
import com.center.main.service.InterMainService;


@Controller
public class MainController {
	@Autowired
	private InterMainService service;
	
	@RequestMapping(value="/main.to")
	public String main(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("gobackURL");
		
		List<BoardVO> noticeList = service.getNoticeList();
		request.setAttribute("noticeList", noticeList);
		return "main/main.tiles1";
	}
	
	@RequestMapping(value="/mainCarousel.to")
	public String mainCarousel() {
		return "main/mainCarousel";
	}

}
