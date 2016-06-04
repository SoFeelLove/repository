<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>Row Editing in DataGrid - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../css/demo.css">
	<script type="text/javascript" src="../js/easyui1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="../js/easyui1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../main/js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../main/js/myJs.js"></script>
</head>
<body>
	
	<table id="dg" class="easyui-datagrid" title="添加订单" style="width:700px;height:auto"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
				url: 'datagrid_data1.json',
				method: 'get',
				onClickCell: onClickCell
			">
		<thead>
			<tr>
				<th data-options="field:'itemid',width:80,align:'center'">序号</th>
				<th data-options="field:'productid',width:100,align:'center',
						formatter:function(value,row,index){
							return row.cname;
						},
						editor:{
							type:'combobox',							
							options:{
								valueField:'cid',
								textField:'cname',
								method:'post',								
								url:'${pageContext.request.contextPath}/customers/customersMgr!getAllCustomers.action',
								required:true
							}
						}">产品</th>
				<th data-options="field:'p_part_no',width:80,align:'center',editor:{type:'textbox',options:{required:true}}">件号</th>
				<th data-options="field:'p_price',width:80,align:'center',editor:{type:'numberbox',options:{precision:2}}">进价</th>
				<th data-options="field:'p_num',width:80,align:'center',editor:'numberbox'">进货量</th>
				<th data-options="field:'total_cost',width:80,align:'center',editor:{type:'numberbox',options:{precision:2}}">总价</th>
				<th data-options="field:'status',width:60,align:'center',editor:{type:'checkbox',options:{on:'P',off:''}}">存储状态</th>
			</tr>
		</thead>
	</table>

	<div id="tb" style="height:auto">
		供应商：<input type="text" id="suppliers_name"/>		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		订单时间: <input class="easyui-datetimebox" data-options="required:true" id="order_time" style="width:160px">	
		<br>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">添加</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">返回</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">GetChanges</a>
		
	</div>
	
	<script type="text/javascript">
		var editIndex = undefined;
		function endEditing(){
			if (editIndex == undefined){return true}
			if ($('#dg').datagrid('validateRow', editIndex)){
				var ed = $('#dg').datagrid('getEditor', {index:editIndex,field:'productid'});
				var productname = $(ed.target).combobox('getText');
				$('#dg').datagrid('getRows')[editIndex]['productname'] = productname;
				$('#dg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		//单击单元格
		function onClickCell(index, field){
			if (editIndex != index){
				if (endEditing()){
					$('#dg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					var ed = $('#dg').datagrid('getEditor', {index:index,field:field});
					($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
					editIndex = index;
				} else {
					$('#dg').datagrid('selectRow', editIndex);
				}
			}
		}
		function append(){
			if (endEditing()){
				index = $('#dg').datagrid('getRows').length+1;
				$('#dg').datagrid('appendRow',{itemid:index,status:'P'});
				editIndex = $('#dg').datagrid('getRows').length-1;
				$('#dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function removeit(){
			if (editIndex == undefined){return}
			$('#dg').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function accept(){
			if (endEditing()){
				$('#dg').datagrid('acceptChanges');
			}
		}
		function reject(){
			$('#dg').datagrid('rejectChanges');
			editIndex = undefined;
		}
		function getChanges(){
			var rows = $('#dg').datagrid('getChanges');
			alert(rows.length+' rows are changed!');
		}
		
		/*设置日期*/
		$(function(){
			$('#suppliers_name').combobox({
					valueField:'cid',
					textField:'cname',
					width:160,
					url:'customersMgr!getAllCustomers.action',
   					method:'post',
					mode:'remote',
					onBeforeLoad:function(param){
						if(param==null || param.q==null || param.q.replace(/ /g,'')==''){
							var value = $(this).combobox('getValue');
							if(value){
								param.id = value;
								return true;
							}
							return false;
						}
					},
					required:true
			});
			$('#order_time').textbox('setValue',getCurrTime());//替换所有汉字.replace(/[\u4e00-\u9fa5]/g, "-")
		});
	</script>
</body>
</html>
