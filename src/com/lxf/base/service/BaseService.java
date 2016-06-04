package com.lxf.base.service;


import java.util.HashMap;
import java.util.List;

import com.lxf.base.bean.BaseBean;
import com.lxf.base.dao.ClassInfo;
import com.lxf.base.dao.CommonMapper;
import com.lxf.base.dao.Pager;
import com.lxf.commons.SqlFileConfig;
import org.springframework.beans.factory.annotation.Autowired;


/**
 *  事务处理基类
 * @author 
 *
 */
public abstract class BaseService <T extends BaseBean>{


    /**
     * 当前对象数据库操作类
     */
    @Autowired
    protected CommonMapper commonMapper ;

    /**
     *  sql分页
     * @param pager 分页对象
     * @param sord  排序字段
     * @param sidx  升降序
     * @param bean  bean对象
     * @return 返回结果集
     */
    public List<HashMap<String, Object>> selectByPagerBySql(Pager pager, String sord,String sidx,T bean) {

        StringBuilder sql =new StringBuilder();
        sql.append("select * from "+bean.getTableName()+" ");

        //添加默认对象查询条件
        ClassInfo in = new ClassInfo();
        in.setFieldListByClass(bean);

        //in.setIfSqlByName("name")  对象的name既使有值也不参于查询，既不加入到where后
        //in.setLikeOperByName("name")  对象的name采用like 查询
        String whereSql=in.getWhereSql();

        if(whereSql!=null && !whereSql.equals(""))
            sql.append("where "+whereSql);//可以后加入and 自定义查询


        // 添加排序条件
        if (sidx != null && !sidx.equals("")) {
            sql.append(" order by " + sidx + " " + sord+", "+bean.getPkName()+" desc");
        } else {
            sql.append(" order by "+bean.getPkName()+" desc ");
        }

        // 查询记录数
        pager.setTotalRows(commonMapper.getCountBySql(sql.toString()));
        List<HashMap<String, Object>> list = commonMapper.getListByPageForOracle(pager,sql.toString());
        return list;
    }

	/**
	 * 根据xml名称和id来获得sql语句
	 * @param resource xml名称
	 * @param id xml中id名
	 * @return
	 */
	public String getXmlSql(String resource, String id)
	{
		return SqlFileConfig.getLocalSql(resource, id);
	}
	
	/**
	 * 根据xml中id来获得sql语句，xml名称需和service名称一致
	 * @param id
	 * @return
	 */
	public String getXmlSql(String id)
	{
		 StackTraceElement[] stacks = new Throwable().getStackTrace();   
	     int stacksLen = stacks.length;  
	     String classname = stacks[1].getClassName();
	     classname = classname.substring(classname.lastIndexOf('.')+1,classname.length()-7);
	     return SqlFileConfig.getLocalSql(classname+".xml", id);
	}
	
	/**
	 * 直接获得xml中sql语句，xml名称需和service名称一致，id需和调用方法名一致。
	 * @return
	 */
	public String getXmlSql()
	{
		 StackTraceElement[] stacks = new Throwable().getStackTrace();   
	     int stacksLen = stacks.length;  
	     String classname = stacks[1].getClassName();
	     classname = classname.substring(classname.lastIndexOf('.')+1,classname.length()-7);
	     return SqlFileConfig.getLocalSql(classname+".xml", stacks[1].getMethodName());
	}
	/**
	 * 分页查询
	 * @author 常建
	 *
	 */
	public class PagerQuery{
		private int pageSize=0;
		Pager pager=new Pager();
		public PagerQuery(int pageSize) {
			this.pageSize=pageSize;
			pager.setPageSize(pageSize);
		}
		public void query(String querySQL,IPagerQueryProcessor processor,Object... args){
			 int count= commonMapper.getCountBySql(querySQL);
			 pager.setTotalRows(count);
				int pages= pager.getTotalPages();//取得总页数
				for (int i = 0; i < pages; i++) {
					int start=i*pager.getPageSize();
					int end=i*pager.getPageSize()+pager.getPageSize();
					pager.setStartRow(start);
					pager.setEndRow(end);
					List<HashMap<String, Object>> list= commonMapper.getListByPageForOracle(pager, querySQL);
					if (processor!=null) {
						processor.process(list,args);
					}
				}	
		}
	}
	public interface IPagerQueryProcessor{
		void process(List<HashMap<String, Object>> resultList, Object[] args);
	}
	/**
	 *  数据库执行器
	 * @author 常建
	 *
	 */
	public class DbQueryExecutor{
		private String SQL;
		public DbQueryExecutor(String xmlResourceId,String sqlId){
			SQL=getXmlSql(xmlResourceId, sqlId);
		}
		/**
		 * 
		 * @param keys  SQL中的参数占位符如：${date},则key值为date
		 * @param values  参数值集合
		 * @throws Exception 
		 */
		public List<HashMap<String, Object>> runQuery(String[] keys,String [] values) throws Exception {
			initSQL(keys, values);
			return commonMapper.runSql(SQL);
		}
		private void initSQL(String[] keys,String [] values) throws Exception {
			if (keys.length!=values.length) throw new Exception("传入的键值个数不等！");
			int count=0;
			for (String key : keys) {
				String placeholder="${"+key+"}" ;
				SQL=SQL.replace(placeholder, values[count]);
				count++;
			}
		}
		/**
		 * 
		 * @param keys  SQL中的参数占位符如：${date},则key值为date
		 * @param values  参数值集合
		 * @throws Exception 
		 */
		
		public List<HashMap<String, Object>> runQuery(String[] keys,String [] values,Pager pager) throws Exception {
			initSQL(keys, values);
			pager.setTotalRows(commonMapper.getCountBySql(SQL));
			return commonMapper.getListByPageForOracle(pager, SQL);
		}
		
		public List<HashMap<String, Object>> runQuery(Pager pager) throws Exception {
			pager.setTotalRows(commonMapper.getCountBySql(SQL));
			List<HashMap<String, Object>> list=commonMapper.getListByPageForOracle(pager, SQL);		
			return list;
		}
		public List<HashMap<String, Object>> runQuery() throws Exception {
			List<HashMap<String, Object>> list=commonMapper.runSql(SQL);		
			return list;
		}
	}
}