package com.lxf.repository.action.products;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxf.commons.export.ExcelUtils;
import com.lxf.commons.export.JsGridReportBase;
import com.lxf.commons.export.TableData;
import com.lxf.repository.service.products.ProductsMgrService;

@SuppressWarnings("serial")
@Controller("/products/productsMgrAction")
@Scope("prototype")
public class ProductsMgrAction extends ProductsMgrActionBean {
	@Autowired
	private ProductsMgrService productsMgrService;
	
	
	public void getProductsById(){
		String json = productsMgrService.getProductsJsonById(pid).toString();
		System.out.println(json);
		AjaxPrint(json);
	}
	
	public void getAllProductsJson(){
		String json = productsMgrService.getAllProductsJson().toString();
		AjaxPrint(json);
	}
	
	public String list(){
		String filedTitle = "序号,产品名称,件号,库存,价格";
		colsTable = "P_ID,P_NAME,P_PART_NO,P_TOTAL_NUM,P_PRICE";
        //字段是否显示
        boolean [] isShow = {false,true,true,true,true};
        //当前列是否自动排序
        boolean [] isFiledSort = {true,true,true,true,true};
        //当前列是否冻结
        boolean [] frozen = {false,false,false,false,false};
        //单元格是否加格式化函数
        boolean [] isFormatColumn = {false,false,false,false,false};
        //单元格是否加样式函数
        boolean [] isStylerColumn = {false,false,false,false,false};
      //单元格是否可以编辑
        boolean [] isEditor ={true,true,true,true,true};
        //是否必填
        boolean[] isRequired = {false,true,false,false,false};
        String [] editorType ={"text","text","numberbox","numberbox","numberbox"}; 
        String widths[] = {"100", "100","100","100","100"};
        String aligns[] = {"center","center", "center", "center", "center"};
        this.formatEasyuiFields(true, filedTitle, colsTable, isShow, frozen, isFiledSort,isFormatColumn, isStylerColumn,isEditor,isRequired,editorType,widths, aligns);// 如果第二个参数为null，默认为全排序
      //标题分组  就加此
        operationField = "{title:'产品信息',colspan:4},{field:'action',title:'操作',width:100,align:'center', rowspan:2,"
    			+"formatter: function(value,rec,index){"
    			+" if(rec.editing){ var s = '<a onclick=\"saverow(this);\">保存</a>';"
    				+" var c = '<a onclick=\"cancelrow(this);\">取消</a>'; "
    					+"return s+'    '+c;}"+
    				"else{ var e = '<a onclick=\"editrow(this);\">编辑</a>';"
    					+" var d = '<a onclick=\"deleterow(this);\">删除</a>';"
    					+ "return e +'    '+ d; }}}";
      	return DEFAULT;
		
	}
	
	@SuppressWarnings("rawtypes")
	public void listAjax()throws Exception{
		try{
			List result = productsMgrService.getAllProducts(pager, sord, sidx,product);	
			super.outJsonData(result, null, pager, colsTable);
		}catch (Exception e){
			e.printStackTrace();
			throw e;// 不可缺少，向上抛出，保证前台页面友好提示错误
		}
	}
	
	public void listExport() throws Exception{
    	String title = "产品列表";
        String filedTitle="产品名称,件号,库存,价格";
        String colsName = "P_NAME,P_PART_NO,P_TOTAL_NUM,P_PRICE";
        String[] hearders = filedTitle.split(",");//表头数组
        String[] fields = colsName.split(",");//对象属性数组
        List<HashMap> list =  productsMgrService.getAllProducts(null, sord, sidx,product);	
        TableData td = ExcelUtils.createTableData(list, ExcelUtils.createTableHeader(hearders), fields);
        JsGridReportBase report = new JsGridReportBase(super.getRequest(), super.getResponse());
        report.exportToExcel(title, "", td);
    }
	
	public void updateCustomers(){
		String jsonData = getRequest().getParameter("updated");
		AjaxPrint(productsMgrService.updateProduct(formatToListHashMap(jsonData).get(0)));
	}
	
	/**
	 * 删除客户,带参数
	 */
	public void deleteCustomer(){
		String jsonData = getRequest().getParameter("deleted");
		AjaxPrint(productsMgrService.deleteProduct(formatToListHashMap(jsonData).get(0)));
	}
	/**
	 * 删除客户，
	 * @author lxf
	 */
	public void deleteCustomersById(){
		AjaxPrint(productsMgrService.deleteProduct(pid));
	}
	public void addProduct(){
		AjaxPrint(productsMgrService.insertProduct(product));
	}
}
