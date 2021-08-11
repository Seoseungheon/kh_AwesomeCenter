package com.center.teacherAdmin.service;

import java.util.HashMap;
import java.util.List;

import com.center.teacherAdmin.model.TeacherAdminVO;

public interface InterTeacherAdminService {

	// 1. 강사 리스트 불러오기
	List<TeacherAdminVO> getTeacherList(HashMap<String,Object> paraMap);

	// 2. 검색어가 없을 떄의 총 게시물 건수(totalCount)
	int getTotalCountNoSearch();

	// 2-1. 검색어가 있을 떄의 총 게시물 건수(totalCount)
	int getTotalCountSearch(HashMap<String, Object> paraMap);
	
	// 3. 강사 상세 정보 조회하기
	TeacherAdminVO getTeacherDetail(String teacher_seq);
	
	// 4. 강사 정보 수정하기 (첨부파일 x)
	int editTeacherAdmin(TeacherAdminVO teachervo);
	
	// 4-1. 강사 정보 수정하기 (첨부파일 o)
	int editTeacherAdminFile(TeacherAdminVO teachervo);

	// 5. 강사 등록하기 (파일 첨부 o)
	int insertTeacher(TeacherAdminVO teachervo);
	
	// 5-1. 강사 등록하기 (파일 첨부 x)
	int insertTeacherNoFile(TeacherAdminVO teachervo);
	
	// 6. 강사 사진 원본 파일명 가져오기
	TeacherAdminVO getTeacherImage(String teacher_seq);
}
