package com.lxf.repository.action.customers;

import com.lxf.base.action.BaseAction;
import com.lxf.repository.po.Customer;

public class CustomersMgrActionBean extends BaseAction{
	protected String customerId;
	protected String customerName;
	protected Customer customer;
	protected String q;

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getQ() {
		return q;
	}

	public void setQ(String q) {
		this.q = q;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	
	
	
}
