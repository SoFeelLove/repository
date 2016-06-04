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
    <script type="text/javascript">
   function query() {
       setPagerMethod('first');
       $("#form").submit();
   }
   var toolBar= [
   	'-',
  		{
           text:'新增客户',
           iconCls:'icon-add',
           handler:function(){
	      		var config ={
	           		title:'新增客户',
	           		url:'addCustomer.html',
	           		width:'392',
	           		height:'450'
	           	};
	           	showMyWindow(config);
           } 
       },
   	'-',
  		{
           text:'删除',
           iconCls:'icon-remove',
           handler:function(){
           var deleteConfig = {
           		url:'customersMgr!deleteCustomersById.action',
           		serviceKey:'customerId',
           		rowKey:'C_ID'
           	};
           deleteChoiceRows(deleteConfig);    
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
       
function doubleClickRowHandler(rowid, rec) {
	if (rec.SM_ID !== undefined && rec.SM_ID !== '') {
		mx();
	}
}
function mx() {
	var config = {
		title : '进货',
		url : '${pageContext.request.contextPath}/suppliers/addGoods.jsp',
		width : '560',
		height : '450'
	};
	showMyWindow(config);
}

function saverow(target){
	var config = {
		  msg:'确定提交吗？',
		  url:'customersMgr!insertOrUpdateCustomers.action',
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
		  url:'customersMgr!deleteCustomer.action',
		  data:row
       	};  
	 deleteEditor(target,config);
}
					
				</script>
</head>
<body >

<form id="form" action="customersMgr!list.action" method="post">

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
										客户：<input type="text" name="customer.customer_name" value="${customer.customer_name}" style="width: 120px;"/>&nbsp;&nbsp;
										联系人：<input type="text" name="customer.customer_contact" value="${customer.customer_contact}"  style="width: 120px;"/>&nbsp;&nbsp;
										联系方式：<input type="text" name="customer.customer_tel" value="${customer.customer_tel}"  style="width: 120px;"/>&nbsp;&nbsp;
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

