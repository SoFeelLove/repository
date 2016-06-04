package com.lxf.commons;

import java.math.BigDecimal;
import java.sql.Clob;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public final class StringUtils {
	
	/**
	 * 如果传入的参数为null或者"null",返回空字符串
	 * @param str
	 * @return
	 */
	public static String NullToSpace(String str)
	{
		if(str==null || str.equals("null"))
		{
			return "";
		}
		else
		{
			return str.toString();
		}
	}
	public static String NullToEmpty(String str)
	{
		if(str==null || str.equals("null"))
		{
			return "";
		}
		else
		{
			return str.trim();
		}
	}
	/**
	 * 如果传入的参数为null或者"null",返回空字符串
	 * @param str
	 * @return
	 */
	public static String NullToSpace(Object obj)
	{
		if(obj==null)
		{
			return "";
		}
		else
		{
			return NullToSpace(obj.toString());
		}
	}
	public static boolean isNullOrEmpty(String str) {
		if(str==null ||"".equals(str.trim()))return true;
		else return false;
	}
	/**
	 * 如果传入的参数为null或者"null",返回0，其他转为float类型后返回
	 * @param obj
	 * @return
	 */
	public static float NullToZero(Object obj)
	{
		if(obj==null)
		{
			return 0f;
		}
		else
		{
			String objStr = obj.toString();
			if(objStr.equals("null"))
			{
				return 0f;
			}
			else
			{	
				String regExp ="^\\d+(\\.\\d+)?$";
				if(validateStringWithReg(objStr, regExp))
				{
					return Float.parseFloat(objStr);
				}
				else
				{
					return 0f;
				}
			}
		}
	}
	
	/**
	 * 验证字符串是否符合指定的正则表达式
	 * @author 朱强
	 */
	public static boolean validateStringWithReg(String content,String reg){
        Pattern p = Pattern.compile(reg);   
        Matcher m = p.matcher(content);
        if(m.find()){
        	return true;
        }else{
        	return false;
        }
		
	}
	/**
	 * 验证字符串是否符合指定的正则表达式，如果满足并取出该规则字符串
	 * @author 朱强
	 */
	public static String getStringWithReg(String content,String reg){
        Pattern p = Pattern.compile(reg);   
        Matcher m = p.matcher(content);
        if(m.find()){
        	String target=content.substring(m.start(), m.end());
        	return target;
        }else{
        	return "";
        }
	}
	
	/**
	 * 四舍五入，把数据转为浮点数
	 * @author 朱强
	 */
	public static String toFloat(float data, String patten){		
		DecimalFormat format = new DecimalFormat();
		format.applyPattern(patten);
		return format.format(data);
	}

	/**
	 * 四舍五入，取字符串形式小数的几位小数，针对那种BigDecimal而用
	 * @author 朱强
	 */
	public static String toFloat(String data, int precision){		
	        if(data.equals("0E-10")){
	        	return "0";
	        }else{
	        	String before=data.substring(0,data.indexOf("."));
	        	String after=data.substring(data.indexOf(".")+1).substring(0, precision);
	        	return before+"."+after;
	        }
	}
	
	/**
	 * 将双引号替换成单引号
	 * @param src
	 * @return
	 */
	public static String quoteDouble2Single(String src)
	{
		if(src == null && src.trim().equals("")) return "";
		src = src.replace("\"", "'");
		return src;
	}
	
	/**
	 * 将clob类型数据转换成字符串
	 * @param clob
	 * @return
	 * @throws java.sql.SQLException
	 */
	public static String clobtoString( Object clob ) throws SQLException
	 {
		Clob tmp=(Clob)clob;
		return clobtoString(tmp);
	 }
	/**
	 * 将clob类型数据转换成字符串
	 * @param clob
	 * @return
	 * @throws java.sql.SQLException
	 */
	 public static String clobtoString( Clob clob ) throws SQLException
	 {
		 try
		 {
			 if(clob!=null)
			 {
				 return clob.getSubString(((long)1),((int)(clob.length())));
			 }
			 else
			 {
				 return "";
			 }
		 }
		 catch(Exception e)
		 {
			 return "";
		 }
	 }
	 
	 public static String htmlTag2Empty(String html)
	 {
		String regAll = "<p\\s*.*>\\s*.*\\s*</p>";
		String myRegex = "<[^>]*>";
		Pattern myPattern = Pattern.compile(regAll,Pattern.CASE_INSENSITIVE);
		Matcher myMatcher = myPattern.matcher(html);
		String myStr = "";
		while(myMatcher.find())
		{
			myStr = myMatcher.group();
		}
		if(myStr == null || myStr.trim().equals(""))return html;
		String now = myStr.replaceAll(myRegex, "");
		return now;
	 }
	 
	 /**处理富文本框的方法
	  * @param html
	  * @return
	  */
	 public static String commentQuote2EmptySingle(String html)
	 {
		 if(html != null)
		 {
			 html = html.replace("<!--StartFragment-->", "");
			 html = html.replace("<!--EndFragment-->", "");
			 html = html.replace("<!--", "");
			 html = html.replace("-->", "");
			 html = html.replaceAll("\"", "'");
		 }
		 return html;
	 }
	 
	 /**
	  * 对象转换字符串，如果对象为空将返回空
	  * @param ob
	  * @return
	  */
	 public static String objectToString(Object ob)
	 {
		if(ob!=null)
		{
			return ob.toString();
		}
		else
		{
			return "";
		}
	 }
	 /**
	  * 得到百分比
	  * @param a分子
	  * @param b分母
	  * @return结果
	  */
	 public static String percentAge(Object a ,Object b)
	 {
		 if(a==null || a.toString().equals("") || b.toString().equals("0"))
		 {
			 return "0";
		 }
		 if(b==null || b.toString().equals("") || b.toString().equals("0"))
		 {
			 return "0";
		 }
		 
		 double aa = Double.valueOf(a.toString());
		 double bb = Double.valueOf(b.toString());
		 
		 DecimalFormat df = new DecimalFormat("#.##");
		 return df.format(aa/bb*100);
	 }
	 /**
	  * 用于生成一个唯一标识
	  * @return
	  */
	 public static String uuid(){
		 UUID uuid = UUID.randomUUID();
		 String uid = uuid.toString();
		 return uid;
	 }
    /**
     *
     * 方法名： cutDouble
     * 作用：  小数点后保留小数（四舍五入）
     * @param d
     * @param i 保留小数个数
     * @return double
     */
    public static double cutDouble(double d, int i) {
        BigDecimal b = new BigDecimal(d);
        return b.setScale(i, BigDecimal.ROUND_HALF_UP).doubleValue();
    }
    /**
     *
     * 方法名： cutDouble
     * 作用：  小数点后保留小数（四舍五入）
     * @param str
     * @param i 保留小数个数
     * @return double
     */
    public static double cutDouble(String str, int i) {
        if(null == str || "".equals(str) || 0 == str.length()){
            return 0.0;
        }
        BigDecimal b = new BigDecimal(str);
        return b.setScale(i, BigDecimal.ROUND_HALF_UP).doubleValue();
    }
	public static void main(String[] args) {
	}
}