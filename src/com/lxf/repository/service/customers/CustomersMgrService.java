package com.lxf.repository.service.customers;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

import net.sf.json.JSON;
import net.sf.json.JSONArray;

import org.springframework.jdbc.object.SqlCall;
import org.springframework.stereotype.Service;

import com.lxf.base.dao.Pager;
import com.lxf.base.service.BaseService;
import com.lxf.commons.StringUtils;
import com.lxf.repository.po.Customer;
import com.sun.org.apache.regexp.internal.recompile;

@Service
public class CustomersMgrService extends BaseService{

	public JSON getCustomersJsonByName(String customerName) {
		return JSONArray.fromObject(getCustomersByName(customerName));
	}
	public List<HashMap<String, Object>>  getCustomersByName(String customerName) {
		String queryWhere = "";
		if(!StringUtils.isNullOrEmpty(customerName))
			queryWhere = " and c.customer_name like '%"+customerName+"%'";
		String sql = this.getXmlSql().replace("${qWhere}", queryWhere);
		return commonMapper.runSql(sql);
	}
	public List<HashMap<String,Object>> getAllCustomers(){
		String sql = this.getXmlSql();
		return commonMapper.runSql(sql);
	}
	
	public List getAllCustomers(Pager pager, String sord, String sidx, Customer customer) {
		String sql = this.getXmlSql();
		if (customer != null && !StringUtils.isNullOrEmpty(customer.getCustomer_name())) {
			sql += " and c.customer_name like '%"+customer.getCustomer_name()+"%' ";
		}else if (customer != null&& !StringUtils.isNullOrEmpty(customer.getCustomer_contact())) {
			sql += " and c.customer_contact like '%"+customer.getCustomer_contact()+"%' ";
		}else if(customer != null&& !StringUtils.isNullOrEmpty(customer.getCustomer_tel())) {
			sql += " and c.customer_tel like '%"+customer.getCustomer_tel()+"%' ";
		}
		// 排序
		if (sord != null && !"".equals(sord)) {
			sql += " order by " + sidx + " " + sord;
		} else {
			sql += " ORDER BY c.customer_id desc,c.customer_name";
		}
		if (pager == null) {
			return commonMapper.runSql(sql);
		}
		pager.setTotalRows(commonMapper.getCountBySql(sql));
		return commonMapper.getListByPageForMySQL(pager, sql);
	}
	
	/**
	 * 新增或者添加客户
	 * @param formatToListHashMap
	 * @return
	 */
	public String insertOrUpdateCustomers(
			HashMap<String, String> hashMap) {
		try {
			String sql = "";
			if(!StringUtils.isNullOrEmpty(hashMap.get("C_ID")))
				sql = this.getXmlSql("updateCustomerByName").replace("${c_id}", hashMap.get("C_ID"));
			//用户已存在，更新
			else{
				sql = this.getXmlSql("insertCustomer");
			}
			sql = sql.replace("${customer_name}", hashMap.get("CNAME"))
					.replace("${customer_contact}", hashMap.get("CONTACT"))
					.replace("${customer_tel}", hashMap.get("TEL"))
					.replace("${customer_address}", hashMap.get("ADDRESS"))
					.replace("${customer_other}", hashMap.get("OTHER"));
			commonMapper.executeSql(sql);
		} catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
		return "true";
	}
	
	/**
	 * 根据具体名查询客户
	 * @param customerName
	 * @return
	 */
	public List<HashMap<String, Object>> getCustomersByCustomerName(String customerName){
		String sql = this.getXmlSql().replace("${customer_name}", customerName);
		return commonMapper.runSql(sql);
	}
	
	/**
	 * 更新数据
	 * @param hashMap
	 */
	public void updateCustomerByName(HashMap<String, String> hashMap){
		String sql = this.getXmlSql().replace("${customer_name}", hashMap.get("CNAME"))
				.replace("${customer_contact}", hashMap.get("CONTACT"))
				.replace("${customer_tel}", hashMap.get("TEL"))
				.replace("${customer_address}", hashMap.get("ADDRESS"))
				.replace("${customer_other}", hashMap.get("OTHER"));
		commonMapper.executeSql(sql);
	}
	
	public void insertCustomer(HashMap<String, String> hashMap){
		String sql = this.getXmlSql().replace("${customer_name}", hashMap.get("CNAME"))
				.replace("${customer_contact}", hashMap.get("CONTACT"))
				.replace("${customer_tel}", hashMap.get("TEL"))
				.replace("${customer_address}", hashMap.get("ADDRESS"))
				.replace("${customer_other}", hashMap.get("OTHER"));
		commonMapper.executeSql(sql);
	}
	/**
	 * 删除客户
	 * @param hashMap
	 * @return
	 */
	public String deleteCustomer(HashMap<String, String> hashMap) {
		String sql = this.getXmlSql().replace("${c_id}", hashMap.get("C_ID"));
		commonMapper.executeSql(sql);
		return "true";
	}
	/**
	 * 
	 * @author lxf
	 * @param customerId
	 * @return
	 */
	public String deleteCustomer(String customerId) {
		try {
			String sql = this.getXmlSql().replace("${c_id}", customerId);
			commonMapper.executeSql(sql);
		} catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
		return "true";
	}
	/**
	 * 新增客户
	 * @author lxf
	 * @param customer
	 * @return
	 */
	public String addCustomer(Customer customer) {
		String sql = this.getXmlSql("insertCustomer").replace("${customer_name}", customer.getCustomer_name())
				.replace("${customer_contact}", customer.getCustomer_contact())
				.replace("${customer_tel}", customer.getCustomer_tel())
				.replace("${customer_address}", customer.getCustomer_address())
				.replace("${customer_other}", customer.getCustomer_other());
		commonMapper.executeSql(sql);
		return "1";
	}

}
