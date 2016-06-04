package com.lxf.base.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.lxf.base.dao.Pager;
import com.lxf.commons.UploadFile;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;


/**
 * 
 */
public abstract class BaseActionBean extends ActionSupport implements
		ModelDriven<Object> {

	public final String DEFAULT = "default"; // 默认返回的页面
	protected String jspFileName; // struts2返回页面地址

	protected Pager pager = new Pager();
	private String Gjs; // 页面输出js
	private String Gmessage; // 页面输出js

	protected String colsTable;// zyj，可调整宽度的table列字段
	protected String titlesTable;// zyj，可调整宽度的table列名称
	protected String groupHeader;// 标题是否分组
	protected String sidx;// 默认固定排序字段
	protected String sord;// 默认固定排序顺序
	protected Map<String, String> map = new HashMap<String, String>();
	protected String ufname;
	protected String delfileid;
	protected List<UploadFile> uploadFiles;
	/* excel导出用变量 */
	protected String whereClause; // where 条件
	protected String sqlXmlId; // 查询语句在xml配置id
	protected int currentPageOnly; // 只导出当前页
	protected String columns; // 数据库字段名
	protected String headers; // 对应列表中文名称
	protected String outputExcelContent; // excel数据表格(实际为html文本格式)
	protected String currentPage; // 当前页
	protected String term;
	protected String frozenFileds;
	protected String operationField;
	protected String rows;
	protected String page;
	protected String order;
	protected String sort;
	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
		this.sord = order;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
		this.sidx = sort;
	}

	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
        pager.setPageSize(Integer.valueOf(this.rows));
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		if(page!=null)
		{
			pager.setCurrentPage(Integer.valueOf(page));
		}
		this.page = page;
	}

	public String getFrozenFileds() {
		return frozenFileds;
	}

	public void setFrozenFileds(String frozenFileds) {
		this.frozenFileds = frozenFileds;
	}

	public String getOperationField() {
		return operationField;
	}

	public void setOperationField(String operationField) {
		this.operationField = operationField;
	}

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public String getGroupHeader() {
		return groupHeader;
	}

	public void setGroupHeader(String groupHeader) {
		this.groupHeader = groupHeader;
	}

	public String getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}

	// protected String excelAction;
	protected String sql;
	protected String sqlGenerateType; // java , js, customize

	public String getWhereClause() {
		return whereClause;
	}

	public void setWhereClause(String whereClause) {
		this.whereClause = whereClause;
	}

	public String getSqlXmlId() {
		return sqlXmlId;
	}

	public void setSqlXmlId(String sqlXmlId) {
		this.sqlXmlId = sqlXmlId;
	}

	public int getCurrentPageOnly() {
		return currentPageOnly;
	}

	public void setCurrentPageOnly(int currentPageOnly) {
		this.currentPageOnly = currentPageOnly;
	}

	public String getColumns() {
		return columns;
	}

	public void setColumns(String columns) {
		this.columns = columns;
	}

	public String getHeaders() {
		return headers;
	}

	public void setHeaders(String headers) {
		this.headers = headers;
	}

	public String getOutputExcelContent() {
		return outputExcelContent;
	}

	public void setOutputExcelContent(String outputExcelContent) {
		this.outputExcelContent = outputExcelContent;
	}

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public String getSqlGenerateType() {
		return sqlGenerateType;
	}

	public void setSqlGenerateType(String sqlGenerateType) {
		this.sqlGenerateType = sqlGenerateType;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public String getJspFileName() {
		return jspFileName;
	}

	public void setJspFileName(String jspFileName) {
		this.jspFileName = jspFileName;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public String getGmessage() {
		return Gmessage;
	}

	public void setGmessage(String gmessage) {
		Gmessage = gmessage;
	}

	public String getGjs() {
		return Gjs;
	}

	public void setGjs(String gjs) {
		Gjs = gjs;
	}

	public String getColsTable() {
		return colsTable;
	}

	public void setColsTable(String colsTable) {
		this.colsTable = colsTable;
	}

	public String getTitlesTable() {
		return titlesTable;
	}

	public void setTitlesTable(String titlesTable) {
		this.titlesTable = titlesTable;
	}

	public HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	public String getIp() {
		String ip = "";
		try {
			ip = getRequest().getRemoteAddr();
		} catch (Exception ee) {
		}
		return ip;
	}

	public HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	public Map getSession() {
		return ActionContext.getContext().getSession();
	}

	public Object getModel() {
		return null;
	}

	public Map<String, String> getMap() {
		return map;
	}

	public void setMap(Map<String, String> map) {
		this.map = map;
	}

	public String getUfname() {
		return ufname;
	}

	public void setUfname(String ufname) {
		this.ufname = ufname;
	}

	public String getDelfileid() {
		return delfileid;
	}

	public void setDelfileid(String delfileid) {
		this.delfileid = delfileid;
	}

	public List<UploadFile> getUploadFiles() {
		return uploadFiles;
	}

	public void setUploadFiles(List<UploadFile> uploadFiles) {
		this.uploadFiles = uploadFiles;
	}

}