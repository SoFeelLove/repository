package com.lxf.repository.action.customers;

import com.lxf.base.action.BaseAction;
import com.lxf.repository.po.Customer;
import com.lxf.repository.po.Order;
import com.lxf.repository.po.OrdersProducts;
import com.lxf.repository.po.Product;

@SuppressWarnings("serial")
public class OrderSaleMgrActionBean extends BaseAction{
	protected String startTime;
	protected String endTime;
	protected Product product;
	protected Order orders;
	protected Customer customer;
	protected OrdersProducts ordersProducts;
	protected String effectRow;
	protected String customerName;
	protected String customerC;
	protected String orderIds;
	protected String p_part_no;
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Order getOrders() {
		return orders;
	}
	public void setOrders(Order orders) {
		this.orders = orders;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public OrdersProducts getOrdersProducts() {
		return ordersProducts;
	}
	public void setOrdersProducts(OrdersProducts ordersProducts) {
		this.ordersProducts = ordersProducts;
	}
	public String getEffectRow() {
		return effectRow;
	}
	public void setEffectRow(String effectRow) {
		this.effectRow = effectRow;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getOrderIds() {
		return orderIds;
	}
	public void setOrderIds(String orderIds) {
		this.orderIds = orderIds;
	}
	public String getP_part_no() {
		return p_part_no;
	}
	public void setP_part_no(String p_part_no) {
		this.p_part_no = p_part_no;
	}
	
}
