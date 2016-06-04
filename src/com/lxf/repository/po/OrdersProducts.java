package com.lxf.repository.po;

public class OrdersProducts {
	private String order_id;
	private String product_id;
	private String product_num;
	private String product_real_price;
	private String total_cost;
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getProduct_id() {
		return product_id;
	}
	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}
	public String getProduct_num() {
		return product_num;
	}
	public void setProduct_num(String product_num) {
		this.product_num = product_num;
	}
	public String getProduct_real_price() {
		return product_real_price;
	}
	public void setProduct_real_price(String product_real_price) {
		this.product_real_price = product_real_price;
	}
	public String getTotal_cost() {
		return total_cost;
	}
	public void setTotal_cost(String total_cost) {
		this.total_cost = total_cost;
	}
	
}
