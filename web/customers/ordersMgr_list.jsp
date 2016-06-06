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
	<script type="text/javascript" src="../main/js/myJs.js"></script>
    <script type="text/javascript" src="../js/util.js"></script>
    <script type="text/javascript" src="../main/js/openWin.js"></script>
    <script type="text/javascript">
        function query() {
            setPagerMethod('first');
           // $("#form").submit();
        }
        var toolBar= [
        	'-',
       		{
                text:'新增订单',
                iconCls:'icon-add',
                handler:function(){
                	var config = {
                		title:'添加进货单',
                		url:'${pageContext.request.contextPath}/customers/addRowGoods.html',
                		width:'720',
                		height:'450',
                		refresh:true,
                		target:$('#dg')
                	};
                	top.showMyWindow(config);
               /*  var _config1 = {
	                title: '工单列表',                //窗口名称
	                url: '${pageContext.request.contextPath}/suppliers/addGoods.jsp', //窗口的地址
	                w: 860,                             //宽度
	                h: 450,                             //高度
	                winChild: this,                     //父窗口，即当前窗口
	                winRefush: 0,                       //当关闭子窗口时，是否刷新父窗口
	                level: 101,                         //背景DIV层的Z轴高度,模态窗口的Z轴高度会自动加1,如果多次生成模态窗口要注意新层高于旧层
	                opacity: 0.3                        //层的透明度，可以都设置为相等(要求为小数),也可以不设置，默认为0.3
           		 };
                alertWinCall(_config1);*/
                } 
            },
            '-',
       		{
                text:'删除订单',
                iconCls:'icon-remove',
                handler:function(){
                 	var deleteConfig = {
                 		url:'${pageContext.request.contextPath}/customers/ordersMgr!deleteOrders.action',
                 		serviceKey:'orderIds',
                 		rowKey:'ORDER_ID'
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
            
        //订单号，格式化函数
        function formatter_JH_NUM_handler(value,rec)
        {
        	if(value >= 1)
            	return '<a onclick=showDetails("'+rec.ORDER_ID+'",1) >'+value+'</a>';
            else
            	return value;
        }
        function formatter_TD_NUM_handler(value,rec)
        {
        	if(value >= 1)
            	return '<a onclick=showDetails("'+rec.ORDER_ID+'",2) >'+value+'</a>';
            else 
            	return value;
        }
        function formatter_TOTAL_NUM_handler(value,rec)
        {
        	if(value >= 1)
            	return '<a onclick=showDetails("'+rec.ORDER_ID+'",3) >'+value+'</a>';
           	else
           	 	return value;
        }
        /**
        	显示订单详情
        */
        function showDetails(orderId,queryType){
        	var url = "${pageContext.request.contextPath}/customers/ordersMgr!getOrdersProductById.action?orderIds=";
        	if(queryType == 2){
        		url = "${pageContext.request.contextPath}/customers/ordersMgr!getReturnOrdersProductById.action?orderIds=";
        	}else if(queryType == 3){
        		url = "${pageContext.request.contextPath}/customers/ordersMgr!getAllOrdersProductById.action?orderIds=";
        	}        	
        	var config ={
                		title:orderId+' 退货详情',
                		url:url+orderId,
                		width:'760',
                		height:'450',
                		refresh:false
                	};
                	top.showMyWindow(config);
        }
            
            
		function doubleClickRowHandler(rowid, rec) {
			if (rec.SM_ID !== undefined && rec.SM_ID !== '') {
				mx();
			}
		}
					
				</script>
</head>
<body >

<form id="form" action="ordersMgr!list.action" method="post">

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
										下单时间： <input class="text" style="width: 120px;"
											type="text" id="startTime" name="startTime"
											value="${startTime}"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" /> 至 <input
											class="text" style="width: 120px;" type="text" id="endTime"
											name="endTime" value="${endTime}"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" /> &nbsp;&nbsp;
										订单号：<input type="text" name="orders.order_id" value="${orders.order_id}" style="width: 120px;"/>&nbsp;&nbsp;
										供应商：<input type="text" name="orders.customer_name" value="${orders.customer_name}" style="width: 120px;"/>&nbsp;&nbsp;
										联系人：<input type="text" name="orders.customer_lxr" value="${orders.customer_lxr}"  style="width: 120px;"/>&nbsp;&nbsp;
										联系方式：<input type="text" name="orders.customer_tel" value="${orders.customer_tel}"  style="width: 120px;"/>&nbsp;&nbsp;
										
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

<%@ include file="../widget/table_includeBeta.jsp"%>
<style type="text/css">
    html{
        overflow-y:auto;
    }

</style>
</body>
</html>

