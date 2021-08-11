package com.center.member.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.center.member.service.InterMemberService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Controller
public class ChartController {
	@Autowired
	private InterMemberService service;
	
	//차트그리기(Ajax) 부서번호별 인원수
	@RequestMapping(value="/chart/lectureChart.to")
	public ModelAndView chartTest(ModelAndView mav) {
		mav.setViewName("member/chart/lectureChart");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/chart/ageJSON.to", produces="text/plain;charset=UTF-8")
	public String ageJSON(HttpServletRequest request, String class_seq) {
		
		List<HashMap<String, String>> agePercentList = service.ageJSON(class_seq);
		
		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();
		for(HashMap<String,String> map : agePercentList) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("age", map.get("age"));
			jsonObj.addProperty("cnt", map.get("cnt"));
			jsonObj.addProperty("percentage", map.get("percentage"));
			jsonArr.add(jsonObj);
		}
		return gson.toJson(jsonArr);
	}
	
	
	@ResponseBody
	@RequestMapping(value="/chart/genderJSON.to", produces="text/plain;charset=UTF-8")
	public String genderJSON(HttpServletRequest request, String class_seq) {
		
		List<HashMap<String, String>> genderPercentList = service.genderJSON(class_seq);
		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();
		for(HashMap<String,String> map : genderPercentList) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("gender", map.get("gender"));
			jsonObj.addProperty("CNT", map.get("CNT"));
			jsonObj.addProperty("PERCENTAGE", map.get("PERCENTAGE"));
			jsonArr.add(jsonObj);
		}
		return gson.toJson(jsonArr);
		//return new Gson().toJson(jsonArr);
	} 
	
}
