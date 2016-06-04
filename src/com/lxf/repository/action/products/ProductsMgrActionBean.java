package com.lxf.repository.action.products;

import com.lxf.base.action.BaseAction;
import com.lxf.repository.po.Product;

public class ProductsMgrActionBean extends BaseAction{
	protected String pid;

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}
	
	protected Product product;

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	
	

}
