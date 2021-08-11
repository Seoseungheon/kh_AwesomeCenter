package com.center.main.service;

import java.util.List;

import com.center.admin.model.BoardVO;

public interface InterMainService {

	//공지사항 목록
	List<BoardVO> getNoticeList();

}
