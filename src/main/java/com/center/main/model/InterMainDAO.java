package com.center.main.model;

import java.util.List;

import com.center.admin.model.BoardVO;

public interface InterMainDAO {

	//공지사항 목록
	List<BoardVO> getNoticeList();

}
