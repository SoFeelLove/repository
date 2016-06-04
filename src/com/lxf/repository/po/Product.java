package com.lxf.repository.po;

public class Product {
	
	private String p_id;
	private String p_part_no;
	private String p_name;
	private String p_price;
	private String state;
	private String p_total_num;
	public String getP_part_no() {
		return p_part_no;
	}
	public void setP_part_no(String p_part_no) {
		this.p_part_no = p_part_no;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_id() {
		return p_id;
	}
	public void setP_id(String p_id) {
		this.p_id = p_id;
	}
	public String getP_price() {
		return p_price;
	}
	public void setP_price(String p_price) {
		this.p_price = p_price;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getP_total_num() {
		return p_total_num;
	}
	public void setP_total_num(String p_total_num) {
		this.p_total_num = p_total_num;
	}
	
	
}
