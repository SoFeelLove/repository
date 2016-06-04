package com.lxf.base.dao;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
 

/**
 * 类信息实体类
 * 创建人： 谭磊
 * 创建时间：Apr 28, 2012 9:03:19 AM
 * 功能：
 */
public class ClassInfo {

	private static ArrayList<String> numList= new ArrayList<String>();//判断数据是否为数值型
	private List<FieldInfo> list = new ArrayList<FieldInfo>();
	
	
	
	private static void setNumList()
	{
		numList.add("Number");
		numList.add("BigDecimal");
		numList.add("BigInteger");
		numList.add("Double");
		numList.add("Float");
		numList.add("Integer");
		numList.add("Long");
		numList.add("Short");
		numList.add("Math");
	}
	/**
	 * 根据类拿到类的属性集合
	 * @param obj  范型类
	 * @return
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 */
	public <T> void setFieldListByClass(T obj) 
	{
		list.clear();
		Field[]f = obj.getClass().getDeclaredFields();
		for(int i=0;i<f.length;i++)
		{
			FieldInfo fi= new FieldInfo();
			f[i].setAccessible(true);//设置允许访问值
			fi.setName(f[i].getName());
			try {
				fi.setValue(f[i].get(obj));
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(numList.contains(f[i].getType().toString()))
			{
				fi.setType(TYPE.MATH);
			}
			list.add(fi);
		}
		 
	}

	/**
	 * 根据类属性拿到where后面的sql语句,只能进行数值型=、字符串=或like
	 * @return
	 */
	public String getWhereSql()
	{
		return getWhereSql(list);
	}
	/**
	 * 根据类属性拿到where后面的sql语句,只能进行数值型=、字符串=或like
	 * @param list
	 * @return
	 */
	public String getWhereSql(List<FieldInfo> _list)
	{
		int flog=0;
		StringBuilder sql=new StringBuilder();
		sql.append(" where");
		for(int i=0;i<_list.size();i++)
		{
			FieldInfo fi = _list.get(i);
			if(fi.ifSql && fi.getValue()!=null && !fi.getValue().equals(""))
			{
				flog++;
				sql.append("and "+fi.getName());
				if(fi.getType().equals(TYPE.MATH))
				{
					sql.append("="+fi.getValue()+" ");//如果数值型直接=于操作
				}
				else
				{
					if(fi.getOper().equals(OPER.EQUALS))
					{
						sql.append("='"+fi.getValue()+"' ");
					}
					else
					{
						sql.append(" like '%"+fi.getValue()+"%' ");
					}
				}
			}
		}
		if(flog==0)
		{
			return "";
		}
		else
		{
			return sql.toString().replace("whereand", " ");
		}
	}
	/**
	 * 设置对比条件为like
	 * @param name
	 */
	public void setLikeOperByName(String name)
	{
		for(int i=0;i<list.size();i++)
		{
			FieldInfo fi = list.get(i);
			if(fi.getName().equals(name))
			{
				fi.setOper(OPER.LIKE);
			}
		}
	}
	/**
	 * 设置某个字段不生成sql语句，方便手动添加处理，例如数值的>=<之类
	 * @param name
	 */
	public void setIfSqlByName(String name)
	{
		for(int i=0;i<list.size();i++)
		{
			FieldInfo fi = list.get(i);
			if(fi.getName().equals(name))
			{
				fi.setIfSql(false);
			}
		}
	}
	
	
	
	 
		/**
		 * 属性对象
		 * 创建人： 谭磊
		 * 创建时间：Apr 28, 2012 11:31:02 AM
		 * 功能：
		 */
		public class FieldInfo{
		
			private String name;  //字段名称
			private Object value; //字段值
			private TYPE type=TYPE.STRING; //字段类型
			private OPER oper=OPER.EQUALS;//比较符
			private boolean ifSql=true;
			
			public boolean isIfSql() {
				return ifSql;
			}
			public void setIfSql(boolean ifSql) {
				this.ifSql = ifSql;
			}
			
			public String getName() {
				return name;
			}
			public void setName(String name) {
				this.name = name;
			}
			public Object getValue() {
				return value;
			}
			public void setValue(Object value) {
				this.value = value;
			}
			
			public TYPE getType() {
				return type;
			}
			public void setType(TYPE type) {
				this.type = type;
			}
			public OPER getOper() {
				return oper;
			}
			public void setOper(OPER oper) {
				this.oper = oper;
			}
			 
		}
	
		public enum OPER
		{
			LIKE,EQUALS
		}
		public enum TYPE
		{
			STRING,MATH
		}
		
		
//	public static void main(String[] args) throws IllegalArgumentException, IllegalAccessException 
//	{
//		TImages ff = new TImages();
//		ff.setId(new BigDecimal(2));
//		
//		Field[]f = ff.getClass().getDeclaredFields();
//		for(int i=0;i<f.length;i++)
//		{
//			f[i].setAccessible(true);
//			System.out.println((f[i].getName()));
//			System.out.println(f[i].get(ff));
//			System.out.println(f[i].getType());
//			System.out.println();
//			 
//		}
//	}
}
