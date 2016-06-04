package com.lxf.repository.service.products;

import java.util.HashMap;
import java.util.List;

import net.sf.json.JSON;
import net.sf.json.JSONArray;

import org.springframework.stereotype.Service;

import com.lxf.base.dao.Pager;
import com.lxf.base.service.BaseService;
import com.lxf.commons.StringUtils;
import com.lxf.repository.po.Product;
@SuppressWarnings("rawtypes")
@Service
public class ProductsMgrService extends BaseService{

	public JSON getAllProductsJson() {
		String sql = this.getXmlSql("getAllProducts");
		return JSONArray.fromObject(commonMapper.runSql(sql));		
	}

	public JSON getProductsJsonById(String pid) {
		return JSONArray.fromObject(getProductsById(pid));
	}
	
	public List<HashMap<String, Object>> getProductsById(String pid) {
		String sql = this.getXmlSql("getProductsById").replace("${pid}", pid);
		return commonMapper.runSql(sql);
	}
	
	public boolean isExistProduct(String pid){
		if (getProductsById(pid).size() > 0) {
			return true;
		}
		return false;
	}
	
	public String insertProduct(Product productBean){
		String sql = getXmlSql().replace("${p_part_no}", productBean.getP_part_no())
				.replace("${p_name}", productBean.getP_name())
				.replace("${p_price}", productBean.getP_price())
				.replace("${p_total_num}", productBean.getP_total_num());
		commonMapper.executeSql(sql);
		return "true";
	}

	public List getAllProducts(Pager pager, String sord, String sidx,
			Product product) {
		String sql = this.getXmlSql();
		if (product!= null && !StringUtils.isNullOrEmpty(product.getP_name())) {
			sql += " and p.p_name like '%"+product.getP_name()+"%' ";
		}else if (product!= null && !StringUtils.isNullOrEmpty(product.getP_part_no())) {
			sql += " and p.p_part_no like '%"+product.getP_part_no()+"%' ";
		}
		// 排序
		if (sord != null && !"".equals(sord)) {
			sql += " order by " + sidx + " " + sord;
		} else {
			sql += " ORDER BY p.p_id desc,p.p_name";
		}
		if (pager == null) {
			return commonMapper.runSql(sql);
		}
		pager.setTotalRows(commonMapper.getCountBySql(sql));
		return commonMapper.getListByPageForMySQL(pager, sql);
	}
	/**
	 * 更新产品信息
	 * @param hashMap
	 * @return
	 */
	public String updateProduct(HashMap<String, String> hashMap) {
		try {
			String sql = this.getXmlSql().replace("${p_part_no}", hashMap.get("P_PART_NO"))
					.replace("${p_name}", hashMap.get("P_NAME"))
					.replace("${p_price}", hashMap.get("P_PRICE"))
					.replace("${p_total_num}", hashMap.get("P_TOTAL_NUM"))
					.replace("${p_id}", hashMap.get("P_ID"));
			commonMapper.executeSql(sql);
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return "true";
	}

	public String deleteProduct(HashMap<String, String> hashMap) {
		String sql = this.getXmlSql().replace("${p_id}", hashMap.get("P_ID"));
		commonMapper.executeSql(sql);
		return "true";
	}

	public String deleteProduct(String pid) {
		String sql = this.getXmlSql().replace("${p_id}", pid);
		commonMapper.executeSql(sql);
		return "true";
	}
	
}
