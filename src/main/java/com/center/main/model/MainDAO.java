package com.center.main.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.center.admin.model.BoardVO;

@Repository
public class MainDAO implements InterMainDAO {
	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public List<BoardVO> getNoticeList() {
		List<BoardVO> noticeList = sqlsession.selectList("awesomeMain.getNoticeList");
		return noticeList;
	}
	
	
}
