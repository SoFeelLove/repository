package com.lxf.base.dao;


import java.util.HashMap;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;


/**
 * 公共操作接口
 * @author 谭磊
 *
 */
public interface CommonMapper {
    public JdbcTemplate getJdbcTemplate();
	/**
	 * 执行sql并返回结果
	 *
     * @param sql
     * @return
	 */
	public List<HashMap<String, Object>> runSql(String sql);
	/**
	 * 执行sql分页并返回结果集
	 * @param pager，要求pager对象中的sql必须有值
	 * @return结果为hashmap类型
	 */
	public List<HashMap<String, Object>> getListByPageForOracle(Pager pager, String sql);
	public List<HashMap<String, Object>> getListByPageForMySQL(Pager pager, String sql);

    /**
     * 执行sql分页并返回结果集
     * @param pager，要求pager对象中的sql必须有值
     * @param objects sql中的参数
     * @return结果为hashmap类型
     */
    public List<HashMap<String, Object>> getListByPage(Pager pager, String sql, Object... objects);
	/**
	 * 通过sql查询有多少条记录
	 * @param sql
	 * @return结果为记录数
	 */
	public Integer getCountBySql(String sql);

    /**
     * 通过sql查询有多少条记录
     * @param sql
     * @param objects sql中的参数
     * @return结果为记录数
     */
    public Integer getCountBySql(String sql, Object... objects);
	/**
	 * 执行sql语句不返回结果
	 * @param sql
	 */
	public void executeSql(String sql);


	
}