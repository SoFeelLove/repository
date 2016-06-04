package com.lxf.base.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;


/**
 * 数据库操作基类
 */
@Component("commonMapper")
public class CommonMapperImp implements CommonMapper{

	protected JdbcTemplate jdbcTemplate;

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }
    @Resource
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    /**
     * 执行sql并返回结果
     *
     * @param sql
     * @return
     */
    public List<HashMap<String, Object>> runSql(String sql)
    {
        List list =jdbcTemplate.queryForList(sql);
        return list;

    }
    /**
     * 执行sql分页并返回结果集
     * @param pager，要求pager对象中的sql必须有值
     * @return结果为hashmap类型
     */
    public List<HashMap<String, Object>> getListByPageForOracle(Pager pager,String sql)
    {
        String pageSql="select * from (select a.*,rownum AS linenum from ( "+sql+ " ) a   where rownum <= "+pager.getEndRow()+" ) b where linenum > "+pager.getStartRow();
        List list = jdbcTemplate.queryForList(pageSql);
        return list;
    }
    
    /**
     * MySQL执行分页并返回结果集
     * @author lxf
     * @param pager
     * @param sql
     * @return
     */
    public List<HashMap<String, Object>> getListByPageForMySQL(Pager pager,String sql)
    {
    	if (pager.getStartRow() < 0) {
			pager.setStartRow(0);
		}
    	String pageSql="select a.* from ( "+sql+ " ) a  limit "+pager.getStartRow()+","+pager.getPageSize();
    	List list = jdbcTemplate.queryForList(pageSql);
    	return list;
    }

    /**
     * 通过sql查询有多少条记录
     * @param sql
     * @return结果为记录数
     */
    public Integer getCountBySql(String sql)
    {
        return jdbcTemplate.queryForInt("select count(*) from ( "+sql+" ) a");
    }
    /**
     * 执行sql语句不返回结果
     * @param sql
     */
    public void executeSql( String sql)
    {
         jdbcTemplate.execute(sql);
    }

    /**
     * 执行sql分页并返回结果集
     * @param pager，要求pager对象中的sql必须有值
     * @param objects sql中的参数
     * @return结果为hashmap类型
     */
    public List<HashMap<String, Object>> getListByPage(Pager pager, String sql, Object... objects) {
        String pageSql="select * from (select a.*,rownum AS linenum from ( "+sql+ " ) a   where rownum <= "+pager.getEndRow()+" ) b where linenum > "+pager.getStartRow();
        List list = jdbcTemplate.queryForList(pageSql,objects);
        return list;
    }

    /**
     * 通过sql查询有多少条记录
     * @param sql
     * @param objects sql中的参数
     * @return结果为记录数
     */
    public Integer getCountBySql(String sql, Object... objects) {
        return jdbcTemplate.queryForInt("select count(*) from ( "+sql+" ) a", objects);
    }
}
