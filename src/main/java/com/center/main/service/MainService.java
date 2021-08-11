package com.center.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.center.admin.model.BoardVO;
import com.center.main.model.InterMainDAO;


@Service
public class MainService implements InterMainService {
	
	@Autowired
	private InterMainDAO dao;

	@Override
	public List<BoardVO> getNoticeList() {
		List<BoardVO> noticeList = dao.getNoticeList();
		return noticeList;
	}
}
