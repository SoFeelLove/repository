<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.math.BigDecimal"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../css/style.css" type="text/css" rel="stylesheet" />
    <link href="../css/gray.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript"
            src="../js/MyDatePicker/WdatePicker.js"></script>
    <link rel="stylesheet" type="text/css"
          href="../js/easyui/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css"
          href="../js/easyui/themes/icon.css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript"
            src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/util.js"></script>
    <script type="text/javascript" src="../main/js/openWin.js"></script>
    <script type="text/javascript">
   function query() {
       setPagerMethod('first');
       $("#form").submit();
   }
   var toolBar= [
   	'-',
  		{
           text:'新增产品',
           iconCls:'icon-add',
           handler:function(){
	      		var config ={
	           		title:'新增产品',
	           		url:'${pageContext.request.contextPath}/products/addProduct.html',
	           		width:'392',
	           		height:'265',
	           		target:$('#dg')
	           	};
	           	top.showMyWindow(config);
           } 
       },
   	'-',
  		{
           text:'删除',
           iconCls:'icon-remove',
           handler:function(){
           var deleteConfig = {
           		url:'${pageContext.request.contextPath}/products/productsMgr!deleteProductsById.action',
           		serviceKey:'pid',
           		rowKey:'P_ID'
           	};
           top.deleteChoiceRows($("#dg"),deleteConfig);    
           } 
       },
       '-',
       {
           text:'导出',
           iconCls:'icon-save',
           handler:function(){
               exportExcel();
           }
       },'-'];
       

function saverow(target){
	var config = {
		  msg:'确定提交吗？',
		  url:'${pageContext.request.contextPath}/products/productsMgr!updateProducts.action',
		  rs:'提交',
		  serviceKey:'updated'
       	};  
	saveEditor(target,config);
}

/*删除*/
function deleterow(target){
	$('#dg').datagrid('selectRow',getRowIndex(target));
	var row = $('#dg').datagrid('getSelected');
    var config = {
		  url:'${pageContext.request.contextPath}/products/productsMgr!deleteProduct.action',
		  data:row
       	};  
	 deleteEditor(target,config);
}
			
     //订单号，格式化函数
function formatter_P_PART_NO_handler(value,rec)
{
    return '<a onclick=showDetails("'+value+'") >'+value+'</a>';
}
/**
	显示商品详情
*/
function showDetails(p_part_no){
	var config ={
        		title:orderId+' 订单详情',
        		url:'${pageContext.request.contextPath}/products/productsMgr!getOrdersProductById.action?orderIds='+orderId,
        		width:'760',
        		height:'450',
        		refresh:false
    };
    top.showMyWindow(config);
}
		
</script>
</head>
<body >

<form id="form" action="productsMgr!list.action" method="post">

		<table border="0" cellpadding="0" cellspacing="0" class="outerTable" style="padding:1px;">
			<tr>
				<td valign=top>
					<table width="100%" border="0" cellspacing="1" cellpadding="0"
						class="innerTable" height="35">
						<tr>
							<td class=pading align=left colspan=3>
								<table cellspacing=0 cellpadding=0 style="width: 100%;" border=0>
									<tr>
										<td>
										产品名：<input type="text" name="product.p_name" value="${product.p_name}" style="width: 120px;"/>&nbsp;&nbsp;
										件号：<input type="text" name="product.p_part_no" value="${product.p_part_no}"  style="width: 120px;"/>&nbsp;&nbsp;
											<input
											type="button" onclick="query();this.blur();" value="查询"
											class="button_silver" /> &nbsp;&nbsp;</td>
									</tr>
								</table></td>
						</tr>
					</table>
					</td>
			</tr>
		</table>
	</form>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
       class="margin">
    <tr>
        <td valign="top" colspan="2">
            <div id="exp"><table id="dg"></table></div>
            <div id="pagerText" style="text-align: center; margin-top: 10px;">
                <!-- 页面正在加载.......... -->
            </div>
        </td>
    </tr>
</table>

<%@ include file="../widget/cellEditing.jsp"%>
<style type="text/css">
    html{
        overflow-y:auto;
    }

</style>
</body>
</html>

