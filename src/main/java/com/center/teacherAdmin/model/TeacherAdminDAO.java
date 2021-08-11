package com.center.teacherAdmin.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TeacherAdminDAO implements InterTeacherAdminDAO {
	
	// DI
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	// 1. 강사 리스트 불러오기
	@Override
	public List<TeacherAdminVO> getTeacherList(HashMap<String, Object> paraMap) {
		List<TeacherAdminVO> teacherList = sqlsession.selectList("awesomeAdmin2.getTeacherList", paraMap);	
		return teacherList;
	}

	// 2. 검색어가 없을 떄의 총 게시물 건수(totalCount)
	@Override
	public int getTotalCountNoSearch() {
		int count = sqlsession.selectOne("awesomeAdmin2.getTotalCountNoSearch");
		return count;
	}

	// 2-1. 검색어가 있을 떄의 총 게시물 건수(totalCount)
	@Override
	public int getTotalCountSearch(HashMap<String, Object> paraMap) {
		int count = sqlsession.selectOne("awesomeAdmin2.getTotalCountSearch", paraMap);
		return count;
	}

	// 3. 강사 상세 정보 조회하기
	@Override
	public TeacherAdminVO getTeacherDetail(String teacher_seq) {
		TeacherAdminVO teacherDetail = sqlsession.selectOne("awesomeAdmin2.getTeacherDetail", teacher_seq);
		return teacherDetail;
	}

	// 4. 강사 정보 수정하기 (첨부파일 x)
	@Override
	public int editTeacherAdmin(TeacherAdminVO teachervo) {
		int n = sqlsession.update("awesomeAdmin2.editTeacherAdmin", teachervo);
		return n;
	}
	
	// 4-1. 강사 정보 수정하기 (첨부파일 o)
	@Override
	public int editTeacherAdminFile(TeacherAdminVO teachervo) {
		int n = sqlsession.update("awesomeAdmin2.editTeacherAdminFile", teachervo);
		return n;
	}

	// 5. 강사 등록하기
	@Override
	public int insertTeacher(TeacherAdminVO teachervo) {
		int n = sqlsession.insert("awesomeAdmin2.insertTeacher", teachervo);
		return n;
	}
	
	// 5-1. 강사 등록하기 (파일 첨부 x)
	@Override
	public int insertTeacherNoFile(TeacherAdminVO teachervo) {
		int n = sqlsession.insert("awesomeAdmin2.insertTeacherNoFile", teachervo);
		return n;
	}

	// 6. 강사 사진 원본 파일명 가져오기
	@Override
	public TeacherAdminVO getTeacherImage(String teacher_seq) {
		TeacherAdminVO teacherImage = sqlsession.selectOne("awesomeAdmin2.getTeacherImage", teacher_seq);
		return teacherImage;
	}
	

	
}
