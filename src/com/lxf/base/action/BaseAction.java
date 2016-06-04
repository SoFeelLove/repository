package com.lxf.base.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.validator.Var;
import org.apache.struts2.ServletActionContext;

import com.lxf.base.dao.Pager;
import com.lxf.commons.DateUtils;
import com.lxf.commons.StringUtils;
import com.mysql.jdbc.Clob;



/**
 * action的基础类，继承使用。
 * 
 */
public abstract class BaseAction extends BaseActionBean {


	/**
	 * 得到HttpServletRequest对象
	 * @author ZhaoYanJie
	 * 2009-5-21
	 * @return HttpServletRequest
	 *
	 */
	public HttpServletRequest getRequest()
	{
		
		return ServletActionContext.getRequest();
	}
	
	/**
	 * 得到HttpServletResponse对象
	 * @author ZhaoYanJie
	 * 2009-5-21
	 * @return HttpServletResponse
	 *
	 */
	public HttpServletResponse getResponse()
	{
		return ServletActionContext.getResponse();
	}
	
	/**
	 * 获取当前访问用户的ip
	 * @param
	 * @return String 
	 * */
	public String getUserIp()
	{
		return getRequest().getRemoteAddr();
	}
	
	/**
	 * 得到当前操作的执行人用户名信息
	 * 
	 * @return用户名
	 */
	public String getUserName() {
		// 得到当前操作人
//		CurrentUser user = getUser();
//		String result = (user == null ? "" : user.getUsername());
		return null;
	}

	/**
	 * 拿到当前操作的用户信息
	 * 
	 * @return
	 */
//	public CurrentUser getUser() {
//		 CurrentUser user = new CurrentUserService().getCurrentUser(getRequest());
//		 if(user == null){
//			   user =new CurrentUser();
//			   user.setUserid("");
//			   user.setUsername("");
//		 }
//		return user;
//	}
	
	/**
	 * 输出内容给前台ajax参数，以success:是否成功,message:信息
	 * 
	 * @param message
	 */
	public void AjaxPrint(boolean flog, String message) {
		AjaxPrint("({success:" + String.valueOf(flog).toLowerCase()
				+ ",message:'" + message.replace("'", "‘").replace(",", "，")
				+ "'})");

	}
	/**
	 * 输出内容给前台ajax参数，格式：({success:'true或false',message:'提示信息'})
	 * @param message
	 */
	public void AjaxPrint(String message) {
		AjaxPrint(message,"utf-8");
	}
	public void AjaxJsonPrint(Object obj) {
		AjaxPrint(JSONArray.fromObject(obj).toString(),"utf-8");
	}
	/**
	 * 输出内容给前台ajax参数，格式：({success:'true或false',message:'提示信息'})
	 * @param message
	 * @param code
	 */
	public void AjaxPrint(String message,String code) {
		HttpServletResponse response = this.getResponse();
		response.setContentType("text/html;charset="+code);
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		try {
			PrintWriter out = response.getWriter();
			out.print(message);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void AjaxPrintXml(String message) {
		AjaxPrintXml(message,"GBK");
	}
	public void AjaxPrintXml(String message,String code) {
		HttpServletResponse response = this.getResponse();
		response.setContentType("text/xml;charset="+code);
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		try {
			PrintWriter out = response.getWriter();
			out.print(message);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 直接输出结果
	 * @param message
	 */
	public void PrintMessage(String message) {
		AjaxPrint(message);
	}
	/**
	 * 直接输出结果到页面
	 * @param message
     */
	public void PrintMessage(String message,String code) {
		AjaxPrint(message,code);
	}

	/**
	 * 用于返回操作成功页面
	 * 
	 * @param javascript
	 *            js语句，为null时，默认返回上一页history.back();
	 * @param message
	 *            需要显示的信息
	 * @return string 返回成功页面
	 */
	public String getSucessPage(String javascript, String message) {
		this.setGmessage(message);
		this.setGjs(javascript);

		return "G_SUCCESS";
	}
	/**
	 * 用于返回操作成功页面
	 * 
	 * @param flush true 刷新父页面 false 不刷新
	 * @param message
	 *            需要显示的信息
	 * @return string 返回成功页面
	 */
	public String getSucessPage(boolean flush, String message) {
		if(message.equals(""))
		{
			message="操作成功";
		}
		this.setGmessage(message);
		this.setGjs("top.stackModelOper("+flush+");");

		return "G_SUCCESS";
	}
	/**
	 * 用于返回操作成功页面
	 * 
	 * @param javascript
	 *            js语句，为null时，默认返回上一页history.back();
	 * @param message
	 *            需要显示的信息
	 * @return string 返回成功页面
	 */
	public String getSucessPageModel(String javascript, String message) {
		this.setGmessage(message);
		this.setGjs(javascript);

		return "G_SUCCESS_MODEL";
	}
	
	public String getSucessNoTip(String javascript, String message) {
		this.setGmessage(message);
		this.setGjs(javascript);
		return "G_SUCCESS_NOTIP";
	}
	/**
	 * 用于返回操作失败页面
	 * 
	 * @param javascript
	 *            js语句，为null时，默认返回上一页history.back();
	 * @param message
	 *            需要显示的信息
	 * @return string 返回失败页面
	 */
	public String getFailPage(String javascript, String message) {
		this.setGmessage(message);
		this.setGjs(javascript);

		return "G_FAIL";
	}

	/**
	 * 用于关闭页面（包括普通页面、普通窗口、模态窗口），刷新父页面
	 * 
	 * @param message
	 *            仅用于模态窗口的window.returnValue值，可为null
	 * @return string 返回关闭页面
	 */
	public String getClosePage(String message) {
		this.setGmessage(message);

		return "G_CLOSE";
	}

	
	/**
	 * 格式化可调整宽度的列字段
	 * @author 赵延杰
	 * @param colsSort 列字段
	 * @param colsSort 列排序，如果为null，默认为全排序
	 */
	public void formatClosTable(String closTable, boolean[] colsSort)
	{
		formatClosTable(closTable,colsSort,null,null);
	}
	/**
	 * 格式化可调整宽度的列字段
	 * @param closTable
	 * @param colsSort
	 * @param widths
	 */
	public void formatClosTable(String closTable, boolean[] colsSort,String[] widths)
	{
		formatClosTable(closTable,colsSort,widths,null);
	}
	
	public void formatClosTable(String closTable, boolean[] colsSort,String[] widths,String[] aligns,boolean [] isFrozen){
		String colWid="60";
		String align="center";
		String cols[] = closTable.split(",");
		StringBuilder item = new StringBuilder();
		for (int i = 0; i < cols.length; i++){
			if(widths!=null && i<widths.length){
				colWid=widths[i];
			}
			if(aligns!=null && i<aligns.length){
				align=aligns[i];
			}
			if(colsSort != null && colsSort[i] == false){
				if(isFrozen[i] == true){
					item.append(",{name:'"+cols[i]+"',index:'"+cols[i]+"', width:"+colWid+",xmlmap:'ItemAttributes>"+cols[i]+"',sortable:false,align:'"+align+"', frozen:true}");
				}else{
					item.append(",{name:'"+cols[i]+"',index:'"+cols[i]+"', width:"+colWid+",xmlmap:'ItemAttributes>"+cols[i]+"',sortable:false,align:'"+align+"'}");
				}
			}else{
				if(isFrozen[i] == true){
					item.append(",{name:'"+cols[i]+"',index:'"+cols[i]+"', width:"+colWid+",xmlmap:'ItemAttributes>"+cols[i]+"',align:'"+align+"', frozen:true}");
				}else{
					item.append(",{name:'"+cols[i]+"',index:'"+cols[i]+"', width:"+colWid+",xmlmap:'ItemAttributes>"+cols[i]+"',align:'"+align+"'}");
				}
			}
		}
		String ss = item.substring(1);
		this.getRequest().setAttribute("item", ss);
	}
	/**
	 * 格式化可调整宽度的列字段，扩展方法
	 * @param closTable 列字段集合
	 * @param colsSort 列排序集合
	 * @param widths 宽度集合
	 */
	public void formatClosTable(String closTable, boolean[] colsSort,String[] widths,String[] aligns)
	{
		String colWid="60";
		String align="center";
		String cols[] = closTable.split(",");
		String item="";
		for (int i = 0; i < cols.length; i++)
		{
			if(widths!=null && i<widths.length)
			{
				colWid=widths[i];
			}
			
			if(aligns!=null && i<aligns.length)
			{
				align=aligns[i];
			}
			
			if(colsSort !=null&&colsSort[i] == false)
			{
				item+=",{name:'"+cols[i]+"',index:'"+cols[i]+"', width:"+colWid+",xmlmap:'ItemAttributes>"+cols[i]+"',sortable:false,align:'"+align+"'}";
			}else
			{
				item+=",{name:'"+cols[i]+"',index:'"+cols[i]+"', width:"+colWid+",xmlmap:'ItemAttributes>"+cols[i]+"',align:'"+align+"'}";
			}
		}
		item = item.substring(1);
		this.getRequest().setAttribute("item", item);
	}
	/**
	 * Easyui table标题格式化
	 * @param isCheckbox       是否添加复选框
	 * @param filedTitle       列标题                                                  必须
	 * @param closTable        列标题对应的数据库字段名                  必须
	 * @param isShow      字段是否显示                                       null默认全部显示
	 * @param frozen           是否冻结                                              null默认不冻结
	 * @param colsSort         表格列是否排序                                   null默认不排序
	 * @param isFormatColumn   是否对列进行格式化函数                     null默认不
	 * @param widths           列宽                                                     null默认100
	 * @param aligns           
	 */
	public void formatEasyuiFields(boolean isCheckbox,String filedTitle, String closTable, boolean[] isShow, boolean [] frozen,
			boolean[] colsSort,boolean [] isFormatColumn, boolean[] isStylerColumn, String[] widths,String[] aligns){
		String [] title = filedTitle.split(",");
		String [] cols  = closTable.split(",");
		String ch = "{field:'CHID',checkbox:true, width:100}";
		StringBuilder frozenFields = new StringBuilder();
		StringBuilder commonFields = new StringBuilder();
		int fieldLen = cols.length;
		for(int i = 0; i < fieldLen; i++){
			if(isShow != null && !isShow[i])continue;//字段不显示
			//处理冻结列
			if(frozen != null && frozen[i] == true){
				frozenFields.append(columnOperate(i,title[i],cols[i],"",colsSort,isFormatColumn,isStylerColumn,widths,aligns));
				continue;
			}
			commonFields.append(columnOperate(i,title[i],cols[i],"",colsSort,isFormatColumn,isStylerColumn,widths,aligns));
		}
//		System.out.println(frozenFileds.toString().length());
		if(frozenFields.length() > 0){
			
			String frozenStr = "";
			if(isCheckbox){
				frozenStr = ch + "," + frozenFields.substring(0,frozenFields.length() - 1);
			}else{
				frozenStr = frozenFields.substring(0,frozenFields.length() - 1);
			}
			this.getRequest().setAttribute("frozenFileds", frozenStr);
		}else{
			if(isCheckbox){
				this.getRequest().setAttribute("frozenFileds", ch);
			}else {
				this.getRequest().setAttribute("frozenFileds", "");
			}
		}
		String _commonFields = commonFields.substring(0,commonFields.length() - 1);
		this.getRequest().setAttribute("item", _commonFields);
	}
	
	/**
	 * Easyui table标题格式化
	 * @param isCheckbox       是否添加复选框
	 * @param filedTitle       列标题                                                  必须
	 * @param closTable        列标题对应的数据库字段名                  必须
	 * @param isShow      字段是否显示                                       null默认全部显示
	 * @param frozen           是否冻结                                              null默认不冻结
	 * @param colsSort         表格列是否排序                                   null默认不排序
	 * @param isFormatColumn   是否对列进行格式化函数                     null默认不
	 * @param isEditor         是否可对单元格编辑
	 * @param isRequired 
	 * @param widths           列宽                                                     null默认100
	 * @param aligns           
	 */
	public void formatEasyuiFields(boolean isCheckbox,String filedTitle, String closTable, boolean[] isShow, boolean [] frozen,
			boolean[] colsSort,boolean [] isFormatColumn, boolean[] isStylerColumn, boolean[] isEditor,boolean[] isRequired, String[] editorType, String[] widths,String[] aligns){
		String [] title = filedTitle.split(",");
		String [] cols  = closTable.split(",");
		String ch = "{field:'CHID',checkbox:true, width:100}";
		StringBuilder frozenFields = new StringBuilder();
		StringBuilder commonFields = new StringBuilder();
		String[] editors = opEditor(isEditor,isRequired, editorType);
		int fieldLen = cols.length;
		for(int i = 0; i < fieldLen; i++){
			if(isShow != null && !isShow[i])continue;//字段不显示
			//处理冻结列
			if(frozen != null && frozen[i] == true){
				frozenFields.append(columnOperate(i,title[i],cols[i],editors[i],colsSort,isFormatColumn,isStylerColumn,widths,aligns));
				continue;
			}
			commonFields.append(columnOperate(i,title[i],cols[i],editors[i],colsSort,isFormatColumn,isStylerColumn,widths,aligns));
		}
//		System.out.println(frozenFileds.toString().length());
		if(frozenFields.length() > 0){
			
			String frozenStr = "";
			if(isCheckbox){
				frozenStr = ch + "," + frozenFields.substring(0,frozenFields.length() - 1);
			}else{
				frozenStr = frozenFields.substring(0,frozenFields.length() - 1);
			}
			this.getRequest().setAttribute("frozenFileds", frozenStr);
		}else{
			if(isCheckbox){
				this.getRequest().setAttribute("frozenFileds", ch);
			}else {
				this.getRequest().setAttribute("frozenFileds", "");
			}
		}
		String _commonFields = commonFields.substring(0,commonFields.length() - 1);
		this.getRequest().setAttribute("item", _commonFields);
	}
	
	/**
	 * 处理编辑
	 * @author lxf
	 * @param isEditor //是否可编辑
	 * @param isRequired 
	 * @param editorType //编辑类型
	 * @return
	 */
	private String[] opEditor(boolean [] isEditor,boolean[] isRequired, String [] editorType){
		String[] editors = new String[isEditor.length];
    	int i = 0; //标记，记数
    	for (boolean bool : isEditor) {
			if (!bool) {
				editors[i]="";
				i++;
				continue;
			}
    		StringBuffer stringBuffer = new StringBuffer("editor:{");	
    		
			String[] types = editorType[i].split(",");
			stringBuffer.append("type:'"+types[0]+"'");
			if (isRequired[i]) {
				stringBuffer.append(", options:{required:"+isRequired[i]);
				if (types[0].equals("numberbox") && types.length ==  2) {//默认为保留两位小数，可以通过","设置
						stringBuffer.append(", precision:"+types[1]);
				}
				stringBuffer.append("}");
			}
			stringBuffer.append("}");
			editors[i] = stringBuffer.toString();
			i++;
		}
    	return editors;
    }
	
	private String columnOperate(int index,String filedTitle, String closTable,String editor,boolean[] colsSort,boolean [] isFormatColumn, 
			boolean[] isStylerColumn, String[] widths,String[] aligns){
			StringBuilder commonFields = new StringBuilder();
			commonFields.append("{field:\"" + closTable + "\",");
			if (!StringUtils.isNullOrEmpty(editor)) {
				commonFields.append(editor+",");
			}
			if(widths!=null){
				commonFields.append("width:\"" + widths[index] + "\",");
			}else{
				commonFields.append("width:\"100\",");
			}
			if(aligns!=null){
				commonFields.append("align:\"" + aligns[index] + "\",");
			}else{
				commonFields.append("align:\"center\",");
			}
			if(colsSort != null){
				commonFields.append("sortable:" + colsSort[index] + ",");
			}else{
				commonFields.append("sortable:false,");
			}
			if(isFormatColumn != null && isFormatColumn[index]){
				commonFields.append("formatter:formatter_" + closTable + "_handler,");
			}
			if(isStylerColumn != null && isStylerColumn[index]){
				commonFields.append("styler:styler_" + closTable + "_handler,");
			}
			commonFields.append("title:\"" + filedTitle + "\"},");
		return commonFields.toString();
	}
	/**
	 * 输出List<HashMap>分页的xml数据
	 * @author 赵延杰
	 * @param titles 表单标题数组
	 * @param list 为itabits执行sql语句的结果
	 * @param pager 分页
	 * @throws java.io.IOException
	 */
	@SuppressWarnings("unchecked")
	public void outXmlData(List list, Pager pager,String cols,HashMap<String, String> formate ) throws IOException 
	{
		outXmlData(list, pager, cols,formate,null);
	}
	
	
	@SuppressWarnings("unchecked")
	public void outXmlData(List list, Pager pager,String cols,HashMap<String, String> formate,HashMap<String, String> viewFormate) throws IOException {
		String[] columns = cols.split(",");
		StringBuffer sb = new StringBuffer();
		if(list != null && list.size() > 0)
		{
			sb.append("<Items>");
			int i = 1;
			for(Object obj:list)
			{
				HashMap<String,Object> map = (HashMap<String,Object>)obj;
				sb.append("<Item>");
				sb.append("<ItemAttributes>");
				sb.append("<asin>" + (pager.getStartRow() + i) + "</asin>");
				for (String col : columns)//循环所有的列
				{
					//System.err.println("--------------col:"+col+"--------formate.get(col):"+formate.get(col));
					if(formate==null||formate.get(col)==null)//没有格式化的列
					{
						sb.append("<"+col+"><![CDATA["+this.formatMapData(map.get(col),col,viewFormate)+"]]></"+col+">");
					}else//按formate内容格式化列数据
					{
						String colValue = formate.get(col);
						Pattern p = Pattern.compile("\\$\\{.*?\\}");
						Matcher m = p.matcher(colValue);
						StringBuffer ret = new StringBuffer();
						while (m.find()) {
							String key = m.group();
							key = key.substring(2,key.length()-1);
						    m.appendReplacement(ret, this.formatMapData(map.get(key),col,viewFormate)+"");
						}
						m.appendTail(ret);
						sb.append("<"+col+"><![CDATA["+ret.toString()+"]]></"+col+">");
					}
				}
				sb.append("</ItemAttributes>");
				sb.append("</Item>");
				i++;
			}
			sb.append("<currentPage>" + pager.getCurrentPage() +"</currentPage>");
			sb.append("<totalRows>" + pager.getTotalRows() +"</totalRows>");
			sb.append("<totalPages>" + pager.getTotalPages() +"</totalPages>");
			sb.append("</Items>");
		}
		else
		{
			sb.append("<rows><currentPage>1</currentPage><totalRows>0</totalRows><totalPages>1</totalPages></rows>");
		}
		HttpServletResponse response= this.getResponse();
		response.setContentType("text/xml;charset=utf-8");
		String xml = sb.toString();
		PrintWriter out = response.getWriter();
		out.print(xml);
		out.close();
	}
	public void outXmlData(List list, HashMap<String, String>  attachment,Pager pager,String cols,HashMap<String, String> formate ) throws IOException 
	{
		outXmlData(list,attachment, pager, cols,formate,null);
	}
	/**
	 * @param list
	 * @param attachment 附加信息
	 * @param pager
	 * @param cols
	 * @param formate
	 * @param viewFormate
	 * @throws java.io.IOException
	 */
	@SuppressWarnings("unchecked")
	public void outXmlData(List list, HashMap<String, String> attachment, Pager pager,String cols,HashMap<String, String> formate,HashMap<String, String> viewFormate) throws IOException {
		String[] columns = cols.split(",");
		StringBuffer sb = new StringBuffer();
		if(list != null && list.size() > 0){
			sb.append("<Items>");
			int i = 1;
			for(Object obj:list){
				HashMap<String,Object> map = (HashMap<String,Object>)obj;
				sb.append("<Item>");
				sb.append("<ItemAttributes>");
				sb.append("<asin>" + (pager.getStartRow() + i) + "</asin>");
				for (String col : columns){//循环所有的列
					if(formate==null||formate.get(col)==null){//没有格式化的列
					
						sb.append("<"+col+"><![CDATA["+this.formatMapData(map.get(col),col,viewFormate)+"]]></"+col+">");
					}else{//按formate内容格式化列数据
						String colValue = formate.get(col);
						Pattern p = Pattern.compile("\\$\\{.*?\\}");
						Matcher m = p.matcher(colValue);
						StringBuffer ret = new StringBuffer();
						while (m.find()) {
							String key = m.group();
							key = key.substring(2,key.length()-1);
						    m.appendReplacement(ret, this.formatMapData(map.get(key),col,viewFormate)+"");
						}
						m.appendTail(ret);
						sb.append("<"+col+"><![CDATA["+ret.toString()+"]]></"+col+">");
					}
				}
				sb.append("</ItemAttributes>");
				sb.append("</Item>");
				i++;
			}
			if(attachment != null){
				Set<String> keys = attachment.keySet();
				if(keys.size() > 0){
					sb.append("<attachment>");
					for(String key:keys){
						sb.append("<" + key + "><![CDATA[" + attachment.get(key) + "]]></" + key + ">");
					}
					sb.append("</attachment>");
				}
			}
			sb.append("<currentPage>" + pager.getCurrentPage() +"</currentPage>");
			sb.append("<totalRows>" + pager.getTotalRows() +"</totalRows>");
			sb.append("<totalPages>" + pager.getTotalPages() +"</totalPages>");
			sb.append("</Items>");
		}
		else
		{
			sb.append("<rows><currentPage>1</currentPage><totalRows>0</totalRows><totalPages>1</totalPages></rows>");
		}
		HttpServletResponse response= this.getResponse();
		response.setContentType("text/xml;charset=utf-8");
		String xml = sb.toString();
		PrintWriter out = response.getWriter();
		out.print(xml);
		out.close();
	}
	/**
	 * 输出JSON格式table数据
	 * @param list
	 * @param attachment 附加信息
	 * @param pager
	 * @param cols
	 * @throws java.io.IOException
	 */
	public void outJsonData(List<HashMap<String,Object>> list, HashMap<String, String> attachment, Pager pager,String cols) throws IOException {
		StringBuilder sb = new StringBuilder();
		String tmp = "";
		sb.append("{");
		if(list != null && list.size() > 0){
			sb.append("\"total\":\"" + pager.getTotalRows() + "\",");
			sb.append("\"rows\":[");
			String [] names = cols.split(",");
			StringBuilder data = null;
			int rownum = (pager.getCurrentPage() - 1) * pager.getPageSize() + 1;
			String tmpV = "";
			for(HashMap map:list){
				data = new StringBuilder();
				data.append("{\"code\":\"" + rownum + "\",");
				
				for(int j = 0; j < names.length; j++){
					if(map.get(names[j]) == null){
						data.append("\"" + names[j] + "\":\"\",");
					}else{
						tmpV = map.get(names[j]) + "";
						if(tmpV != null)tmpV = tmpV.replace("\\", "  ");
						data.append("\"" + names[j] + "\":\"" + tmpV.trim() + "\",");
					}
				}
				sb.append(data.substring(0,data.length() - 1) + "},");
				rownum++;
			}
			tmp = sb.substring(0,sb.length() - 1) + "]";
			//添加附加数据
			StringBuilder attBuf = new StringBuilder();
			if(attachment != null){
				Set<String> keys = attachment.keySet();
				if(keys.size() > 0){
					for(String key:keys){
						attBuf.append("\"" + key + "\":\"" + attachment.get(key) + "\",");
					}
				}
			}
			if(attBuf.length() > 0){
				tmp += ",\"attachment\":{" + attBuf.substring(0,attBuf.length() - 1) + "}}";
			}else{
				tmp += "}";
			}
			
		}else{
			tmp = "{\"total\":\"0\",\"rows\":[]}";
		}
		HttpServletResponse response= this.getResponse();
		response.setContentType("text/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		//System.out.println(tmp);
        tmp =tmp.replace("\n","");
		out.print(tmp);
		out.close();
	}
	/**
	 * 格式化从数据库里取出的Map数据，只供本类中outXmlData方法调用
	 * @author 赵延杰
	 * @param data
	 * @return
	 */
	private String formatMapData(Object data,String col,HashMap<String, String> viewFormate)
	{
		if(viewFormate!=null && viewFormate.get(col)!=null)
		{
			return formatMapData(data,viewFormate.get(col));
		}
		else
		{
			return formatMapData(data,DateUtils.YYYY_MM_DD);
		}
		
	}
	
	/**
	 * 根据数据类型，自动格式化
	 * @param data
	 * @param dateFormat
	 * @return
	 */
	private String formatMapData(Object data,String dateFormat)
	{
		if(data == null)
		{
			return "";
		}else if (data instanceof Date)
		{
			Date new_name = (Date) data;
			return DateUtils.format((Date)new_name, dateFormat);
			
		}else if (data instanceof String)
		{
			return (String) data;
		}
		else if (data instanceof Clob)
		{
			try {
				return StringUtils.clobtoString(data);
			} catch (SQLException e) {
				//e.printStackTrace();
				return "";
			}
		}else
		{
			return data.toString();
		}
	}
	
	/**
	 * json串，转换为List&lt;HashMap&gt;
	 * @author lxf
	 * @param object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List<HashMap<String, String>> formatToListHashMap(Object object){
		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		JSONArray jsonArray = JSONArray.fromObject(object);
		for (Object obj : jsonArray) {
			HashMap<String, String> data = new HashMap<String, String>();
			JSONObject jsonObject = (JSONObject) obj;
			Iterator keys = jsonObject.keys();
			while (keys.hasNext()) {
				String key = keys.next().toString();
				String value = jsonObject.get(key).toString();
				data.put(key, value);			
			}
			list.add(data);
		}		
		return list;
	}
}