# repository
仓库管理系统
为完善记录平时工作，根据实际需求开发厂库管理系统

## 表设计  
![所用表](./web/images/table.png)

#### t_orders（订单表）  
	记录所有订单信息
		订单id,跟客户号，订单添加时间，state为逻辑删除字段
#### t_customers(客户表)
	记录所有客户信息，包含进货商（卖家）、购买商（买家）
#### t_orders_shd(售货单)
	记录所有货品销售信息
#### t_orders_jhd(进货单)
	记录所有进货信息
#### t_orders_td(退单信息)
	记录所有退单信息
#### t_products(商品信息)
	记录所有商品信息









