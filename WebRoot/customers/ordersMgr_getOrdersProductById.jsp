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
    <script type="text/javascript" src="../main/js/myJs.js"></script>
    <script type="text/javascript" src="../main/js/openWin.js"></script>
    <script type="text/javascript" src="../js/json-js/json2.js"></script>
    <script type="text/javascript">
        function query() {
            setPagerMethod('first');
           // $("#form").submit();
        }
        var toolBar= [
         	'-',
       		{
                text:'删除',
                iconCls:'icon-remove',
                handler:function(){
                 	var deleteConfig = {
                 		url:'ordersMgr!deleteOrdersProducts.action',
                 		data:'?orderIds=${orderIds}&p_part_no='+getDeleteRows('p_id'),
                 	};
                	deleteRowsMultiCondition(deleteConfig);
                }
            },
            '-',
            {
                text:'导出',
                iconCls:'icon-save',
                handler:function(){
                	var orderId = $('#orderId').val();
                    exportGrid("订单"+orderId);
                }
            },'-'];
/*保存*/
function saverow(target){
     var config = {
		  msg:'确定修改吗？',
		  url:'ordersMgr!updateOrdersProduct.action',
		  serviceKey:'updated',
		  rs:'修改',
		  data:titleJsonProp()
       	};  
	saveEditor(target,config);
}
/*删除*/
function deleterow(target){
	$('#dg').datagrid('selectRow',getRowIndex(target));
	var row = $('#dg').datagrid('getSelected');
	row.orderId = $('#orderId').val();
    var config = {
		  url:'ordersMgr!deleteOrderProducts.action',
		  data:row
       	};  
	 deleteEditor(target,config);
}
/*
 标题的Json格式数据
*/
function titleJsonProp(){
	var orderId = $('#orderId').val();
    var obj = {};
    obj.orderId = orderId;
    return obj;
}  

</script>
</head>
<body >
<input type="hidden" id="orderId" name="orderId" value="${orderIds}"/>
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

