package com.lxf.repository.service.customers;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lxf.base.dao.Pager;
import com.lxf.base.service.BaseService;
import com.lxf.commons.DateUtils;
import com.lxf.commons.StringUtils;
import com.lxf.repository.po.Order;
import com.lxf.repository.po.OrdersProducts;
import com.sun.org.apache.bcel.internal.generic.RETURN;
@SuppressWarnings("rawtypes")
@Service
public class OrderSaleMgrService extends BaseService{

	public List getAllOrders(String startTime,String endTime,Pager pager, String sord, String sidx,Order order) {
		String sql = this.getXmlSql();
		sql += " and o.order_date >= '"+startTime+"' and o.order_date <= '"+endTime+" 23:59:59'";
		if (!StringUtils.isNullOrEmpty(order.getOrder_id())) {
			sql += " and o.order_id like '%"+order.getOrder_id()+"%'";
		}else if (!StringUtils.isNullOrEmpty(order.getCustomer_name())) {
			sql += " and c.customer_name like '%" +order.getCustomer_name()+"%'";
		}else if (!StringUtils.isNullOrEmpty(order.getCustomer_lxr())) {
			sql += " and c.customer_contact like '%" +order.getCustomer_lxr()+"%'";
		}else if (!StringUtils.isNullOrEmpty(order.getCustomer_tel())) {
			sql += " and c.customer_tel like '%" +order.getCustomer_tel()+"%'";
		}
		// 排序
		if (sord != null && !"".equals(sord)) {
			sql += " order by " + sidx + " " + sord;
		} else {
			sql += " ORDER BY o.order_id desc,c.customer_name";
		}
		if (pager == null) {
			return commonMapper.runSql(sql);
		}
		pager.setTotalRows(commonMapper.getCountBySql(sql));
		return commonMapper.getListByPageForMySQL(pager, sql);
	}
	/**
	 * 订单操作
	 * @author lxf
	 * @param List
	 * @param type 操作类型，更新，删除，插入
	 * @return
	 * @throws Exception 
	 */
	public String operateOrder(List<HashMap<String, String>> list,String type) throws Exception{
		if (type.equals("inserted")) {
			for (HashMap<String, String> hashMap : list) {
				insertOrderData(hashMap);
			}
		}else if (type.equals("updated")) {
			for (HashMap<String, String> hashMap : list) {
				updateOrderProduct(hashMap);
			}
		}
		return "true";
	}
	
	/**
	 * 更新订单详情
	 * @author lxf
	 * @param hashMap
	 * @return
	 * @throws Exception
	 */
	public String  updateOrdersProducts(HashMap<String, String> hashMap) throws Exception {
		String updateOrderProduct = this.getXmlSql("updateOrdersProducts").replace("${order_id}",hashMap.get("orderId")).replace("${p_part_no}", hashMap.get("p_part_no"))
				.replace("${product_num}", hashMap.get("p_num")).replace("${product_real_price}", hashMap.get("p_price")).replace("${real_total_cost}", hashMap.get("totalcost"))
				.replace("${p_id}", hashMap.get("p_id"));
		commonMapper.executeSql(updateOrderProduct);
		return "true";
	}
	
	/**
	 * 更新数据
	 * @author lxf
	 * @param hashMap
	 * @throws Exception 
	 */
	private void updateOrderProduct(HashMap<String, String> hashMap) throws Exception {
		String orderDate = hashMap.get("orderTime").toString();
		String orderId = DateUtils.format(DateUtils.parse(orderDate, DateUtils.YYYY_MM_DD_HH_MM_SS), DateUtils.YYYYMMDDHHMMSS);
		String updateOrderProduct = this.getXmlSql("updateOrderProduct").replace("${order_id}",orderId).replace("${product_id}", hashMap.get("p_id"))
				.replace("${product_num}", hashMap.get("p_num")).replace("${product_real_price}", hashMap.get("p_price")).replace("${real_total_cost}", hashMap.get("realTotal"));
		commonMapper.executeSql(updateOrderProduct);
	}
	/**
	 * 插入数据操作
	 * @author lxf
	 * @param hashMap
	 * @return
	 */
	private boolean insertOrderData(HashMap<String, String> hashMap){
		try {
			insertOrders(hashMap);
			insertOrdersProducts(hashMap);		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	/**
	 * 插入订单
	 * @author lxf
	 * @return
	 * @throws Exception 
	 */
	private void insertOrders(HashMap<String,String> hashMap) throws Exception{
		String orderDate = hashMap.get("orderTime").toString();
		String orderId = DateUtils.format(DateUtils.parse(orderDate, DateUtils.YYYY_MM_DD_HH_MM_SS), DateUtils.YYYYMMDDHHMMSS);
		String customerId = hashMap.get("supplierId").toString();
		String queryById = this.getXmlSql("queryOrderById").replace("${orderId}", orderId);
		
		String sql = this.getXmlSql("insertOrder").replace("${order_id}",orderId).replace("${customer_id}", customerId)
				.replace("${order_date}", orderDate).replace("${state}", "1").replace("${order_type}", "0");//state 0:订单，1出货单
		if (commonMapper.runSql(queryById).size() <= 0) {
			commonMapper.executeSql(sql);
		}
	}
	/**
	 * 插入订单详情
	 * @author lxf
	 * @return
	 * @throws Exception 
	 */
	private void insertOrdersProducts(HashMap<String, String> hashMap) throws Exception{
		String orderDate = hashMap.get("orderTime").toString();
		String orderId = DateUtils.format(DateUtils.parse(orderDate, DateUtils.YYYY_MM_DD_HH_MM_SS), DateUtils.YYYYMMDDHHMMSS);
		String orderProduct = this.getXmlSql("orderProduct").replace("${order_id}",orderId).replace("${product_id}", hashMap.get("p_id"))
				.replace("${product_num}", hashMap.get("p_num")).replace("${product_real_price}", hashMap.get("p_price")).replace("${real_total_cost}", hashMap.get("realTotal"));
		commonMapper.executeSql(orderProduct);
	}
	
	
	public String deleteOrderProduct(List<HashMap<String, String>> list) throws Exception{
		for (HashMap<String, String> hashMap : list) {
			deleteOrderProduct(hashMap);
		}
		return "true";
	}
	/**
	 * 删除数据
	 * @author lxf
	 * @param formatToListHashMap
	 * @return
	 * @throws Exception 
	 */
	private void deleteOrderProduct(
		HashMap<String, String> hashMap) throws Exception {
		String orderDate = hashMap.get("orderTime").toString();
		String orderId = DateUtils.format(DateUtils.parse(orderDate, DateUtils.YYYY_MM_DD_HH_MM_SS), DateUtils.YYYYMMDDHHMMSS);
		String deleteOrderProduct = this.getXmlSql().replace("${order_id}",orderId).replace("${product_id}", hashMap.get("p_id"));
		commonMapper.executeSql(deleteOrderProduct);
		deleteOrderProductByOrderIds(orderId);
	}
	
	private void deleteOrderProductByOrderIds(String orderIds) {
		orderIds = orderIds.replace(",", "','");
		String sql = "update t_orders_shd set state = 0 where order_id in ('"+orderIds+"')";
		commonMapper.executeSql(sql);
	}
	/**
	 * 通过id删除订单
	 * @author lxf
	 * @param orderIds
	 */
	public void deleteOrdersByIds(String orderIds) {
		orderIds = orderIds.replace(",", "','");
		String sql = "update t_orders set state = 0 where order_id in ('"+orderIds+"')";
		commonMapper.executeSql(sql);
		deleteOrderProductByOrderIds(orderIds);
	}
	/**
	 * 得到订单详情
	 * @author lxf
	 * @param pager 
	 * @param orderIds
	 * @param orderIds2 
	 * @param sidx 
	 * @return 
	 */
	public List<HashMap<String, Object>> getOrdersProductById(Pager pager,String sord,String  sidx, String orderIds) {
		// TODO Auto-generated method stub
		if (StringUtils.isNullOrEmpty(orderIds)) {
			orderIds = "";
		}
		String sql = this.getXmlSql("orderSaleMgr.xml","getOrdersProductById").replace("${orderId}", orderIds);
		// 排序
		if (sord != null && !"".equals(sord)) {
			sql += " order by " + sidx + " " + sord;
		} else {
			sql += " order by tp.p_part_no desc";
		}
		if (pager == null) {
			return commonMapper.runSql(sql);
		}
		pager.setTotalRows(commonMapper.getCountBySql(sql));
		return commonMapper.getListByPageForMySQL(pager, sql);
	}
	/**
	 * 通过ID删除
	 * @author lxf
	 * @param ordersProducts
	 */
	public void deleteOrdersProductsByIds(OrdersProducts ordersProducts) {
		// TODO Auto-generated method stub
		
	}
	/**
	 * 删除订单详情数据
	 * @author lxf
	 * @param hashMap
	 * @return
	 */
	public String deleteOrderProducts(HashMap<String, String> hashMap) {
		String updateOrderProduct = this.getXmlSql("deleteOrderProducts").replace("${order_id}",hashMap.get("orderId"))
				.replace("${p_id}", hashMap.get("p_id"));
		commonMapper.executeSql(updateOrderProduct);
		return "true";
		
	}
	/**
	 * 删除具体订单项
	 * @author lxf
	 * @param orderId
	 * @param p_part_no
	 */
	public String deleteOrdersProducts(String orderId, String p_part_no) {
		// TODO Auto-generated method stub
		String sql = this.getXmlSql("deleteOrderProducts").replace("${order_id}",orderId).replace("${p_id}", p_part_no);
		commonMapper.executeSql(sql);
		return "true";
	}
	

}
