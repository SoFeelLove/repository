package com.lxf.repository.po;

import org.springframework.stereotype.Component;

@Component
public class ShipmentBean {
	private String supplierId;
	private String productId;

	private SupplierBean supplierBean;
	private Product productBean;
	
	public String getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public SupplierBean getSupplierBean() {
		return supplierBean;
	}
	public void setSupplierBean(SupplierBean supplierBean) {
		this.supplierBean = supplierBean;
	}
	public Product getProductBean() {
		return productBean;
	}
	public void setProductBean(Product productBean) {
		this.productBean = productBean;
	}
	
	
}
