package com.lxf.repository.action.customers;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxf.commons.DateUtils;
import com.lxf.commons.StringUtils;
import com.lxf.commons.export.ExcelUtils;
import com.lxf.commons.export.JsGridReportBase;
import com.lxf.commons.export.TableData;
import com.lxf.repository.service.customers.OrdersMgrService;

@SuppressWarnings("serial")
@Controller("/customers/ordersMgrAction")
@Scope("prototype")
public class OrdersMgrAction extends OrdersMgrActionBean{
	@Autowired
	private OrdersMgrService orderMgrService;
	public void addOrder() throws Exception{
		String jsonData = "";
		if (getRequest().getParameter("inserted") != null ) {
			jsonData = getRequest().getParameter("inserted");
			AjaxPrint(orderMgrService.operateOrder(formatToListHashMap(jsonData), "inserted"));
		}else if(getRequest().getParameter("updated") != null ){
			jsonData = getRequest().getParameter("updated");
			AjaxPrint(orderMgrService.operateOrder(formatToListHashMap(jsonData), "updated"));
		}
	}
		
	public void updateOrdersProduct() throws Exception{
		String jsonData = getRequest().getParameter("updated");
		AjaxPrint(orderMgrService.updateOrdersProducts(formatToListHashMap(jsonData).get(0)));
	}
	public void deleteOrderProducts() throws Exception{
		String jsonData = getRequest().getParameter("deleted");
		AjaxPrint(orderMgrService.deleteOrderProducts(formatToListHashMap(jsonData).get(0)));
	}
	/**
	 * 删除数据
	 * @author lxf
	 * @throws Exception 
	 */
	public void deleteOrderProduct() throws Exception{
		String jsonData = getRequest().getParameter("deleted");
		AjaxPrint(orderMgrService.deleteOrderProduct(formatToListHashMap(jsonData)));
	}
	public String list(){
		String filedTitle = "订单号,供应商,联系人,联系方式,下单时间";
		colsTable = "ORDER_ID,C_NAME,C_CONTACT,C_TEL,ADDTIME";
        //字段是否显示
        boolean [] isShow = {true,true,true,true,true};
        //当前列是否自动排序
        boolean [] isFiledSort = {true,true,true,true,true};
        //当前列是否冻结
        boolean [] frozen = {false,false,false,false,false};
        //单元格是否加格式化函数
        boolean [] isFormatColumn = {true,false,false,false,false};
        //单元格是否加样式函数
        boolean [] isStylerColumn = {false,false,false,false,false};
        String widths[] = {"120", "120","120","120","120"};

        String aligns[] = {"center","center", "center", "center", "center"};
        this.formatEasyuiFields(true, filedTitle, colsTable, isShow, frozen, isFiledSort,isFormatColumn, isStylerColumn, widths, aligns);// 如果第二个参数为null，默认为全排序
        if (StringUtils.isNullOrEmpty(endTime)) {
        	int intervalDays = 6;
			endTime = DateUtils.getCurrDateStr();
			startTime = DateUtils.getBeforeDate(DateUtils.getCurrentDate(), intervalDays);
		}
      //标题分组  就加此
      	return DEFAULT;
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void listAjax()throws Exception{
		try{
			colsTable+=",C_ID";
			pager.setPageSize(30);	
			List result = orderMgrService.getAllOrders(startTime,endTime,pager, sord, sidx,orders);			
			super.outJsonData(result, null, pager, colsTable);
		}catch (Exception e){
			e.printStackTrace();
			throw e;// 不可缺少，向上抛出，保证前台页面友好提示错误
		}
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void listExport() throws Exception{
    	String title = "订单";
        String filedTitle="订单号,供应商,联系人,联系方式,下单时间";	
        String colsName = "ORDER_ID,C_NAME,C_CONTACT,C_TEL,ADDTIME";
        String[] hearders = filedTitle.split(",");//表头数组
        String[] fields = colsName.split(",");//对象属性数组
        List<HashMap> list =  orderMgrService.getAllOrders(startTime,endTime,pager, sord, sidx,orders);			
        TableData td = ExcelUtils.createTableData(list, ExcelUtils.createTableHeader(hearders), fields);
        JsGridReportBase report = new JsGridReportBase(super.getRequest(), super.getResponse());
        report.exportToExcel(title, "", td);
    }
	
	public void deleteOrders(){
		orderMgrService.deleteOrdersByIds(orderIds);
	}
	
	public String getOrdersProductById(){
		String filedTitle = "pid,件号,产品,进价,进货量,总价";
		colsTable = "p_id,p_part_no,p_name,p_price,p_num,totalcost";
		   //字段是否显示
        boolean [] isShow = {false,true,true,true,true,true};
        //当前列是否自动排序
        boolean [] isFiledSort = {true,true,true,true,true,true};
        //当前列是否冻结
        boolean [] frozen = {false,false,false,false,false,false};
        //单元格是否加格式化函数
        boolean [] isFormatColumn = {false,false,false,false,false,false};
        //单元格是否加样式函数
        boolean [] isStylerColumn = {false,false,false,false,false,false};
        //单元格是否可以编辑
        boolean [] isEditor ={false,false,false,true,true,true};
        boolean[] isRequired = {false,false,false,false,false,false};
        String [] editorType ={"textbox","textbox","textbox","numberbox","numberbox","numberbox"};        
        String widths[] = {"120","120", "120","120","120","120"};
        String aligns[] = {"center","center","center", "center", "center", "center"};
        operationField = "{title:'订单信息',colspan:5},{field:'action',title:'操作',width:100,align:'center', rowspan:2,"
        			+"formatter: function(value,rec,index){"
        			+" if(rec.editing){ var s = '<a onclick=\"saverow(this);\">保存</a>';"
        				+" var c = '<a onclick=\"cancelrow(this);\">取消</a>'; "
        					+"return s+'    '+c;}"+
        				"else{ var e = '<a onclick=\"editrow(this);\">编辑</a>';"
        					+" var d = '<a onclick=\"deleterow(this);\">删除</a>';"
        					+ "return e +'    '+ d; }}}";
        this.formatEasyuiFields(true, filedTitle, colsTable, isShow, frozen, isFiledSort,isFormatColumn, isStylerColumn,isEditor,isRequired,editorType, widths, aligns);// 如果第二个参数为null，默认为全排序
		return DEFAULT;
	}
	
	/**
	 * 根据订单id查询，订单项
	 * @author lxf
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void getOrdersProductByIdAjax() throws Exception{
		pager.setPageSize(30);	
		List result = orderMgrService.getOrdersProductById(pager, sord, sidx,orderIds);
		super.outJsonData(result, null, pager, colsTable);
	}
	
	public void deleteOrdersProductsByIds(){
		orderMgrService.deleteOrdersProductsByIds(ordersProducts);
	}
	
	public void deleteOrdersProducts(){
		orderMgrService.deleteOrdersProducts(orderIds,p_part_no);
	}
	

}
