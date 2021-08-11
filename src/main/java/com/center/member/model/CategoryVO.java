package com.center.member.model;

public class CategoryVO {
	
	String cate_no;
	String cate_name;
	String cate_code;
	
	public String getCate_no() {
		return cate_no;
	}
	public void setCate_no(String cate_no) {
		this.cate_no = cate_no;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public String getCate_code() {
		return cate_code;
	}
	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}
	
	public String getWishCategory() {
		return cate_code+" - "+cate_name;
	}
	
	

}
