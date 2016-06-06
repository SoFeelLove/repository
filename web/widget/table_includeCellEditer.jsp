<%@ page language="java" pageEncoding="utf-8"%>
<%--   ------------------------使用说明------------------------


模态窗口有两个回调函数
//模态窗口加载完毕回调   contentHeight  模态窗口中的页面高度,这个是模态窗口传的
function modelWindowLoadedCallback(contentHeight){
	$('#content').height(contentHeight - $('#hh')[0].offsetHeight);
}
//模态窗口缩放回调    用于动态调整你自己的页面内容
function modelResizeCallback(){
	$('#content').height(document.documentElement.clientHeight - $('#hh')[0].offsetHeight);
}





页面有个回调函数，这个相对 window.onload,在它之后执行,可用于初始化,但要自己实现
function execCallback(){
}


默认情况下grid会自动适应页面高度  
_jqgrid_width = '82.5%';//设置grid宽度
jqgridHeight = '350';//如果加上此属性就 不再自适应

1：如果想在 jqgrid加载数据完毕后处理自己的附加参数那么在java中调用此重载方法,并且在自己的页面中加入函数  
	jqGridLoadedCallback(obj)    obj格式为{yourPro:'value'}
	public String grid(){
		String filedTitle = "单位,台区,线路,合格率(%),越上限率(%),越下限率(%),统计时间(分),合格时间(分),越上限时间(分),越下限时间(分),最小值,最小值发生时间,最大值,最大值发生时间,COLL_OBJ_ID";
		colsTable = "NAME,TG_NAME,LINE_NAME,VOLT_ELIGIBLE_RATE,OVER_HIGHLIMIT_RATE,UNDER_LOWLIMIT_RATE,TOTAL_TIME,ELIGIBLE_TIME,OVER_HIGHLIMIT_TIME,UNDER_LOWLIMIT_TIME,MIN,MIN_TIME,MAX,MAX_TIME,COLL_OBJ_ID";
		//字段是否显示
		boolean [] isShow = {true,true,true,true,true,true,true,true,true,true,true,true,true,true,false};
		//当前列是否自动排序
		boolean [] isFiledSort = {true,true,true,true,true,true,true,true,true,true,true,true,true,true,false};
		//当前列是否冻结
		boolean [] frozen = {true,true,true,false,false,false,false,false,false,false,false,false,false,false,false};
		//frozen = null;
		//单元格是否加格式化函数
		boolean [] isFormatColumn = {false,false,false,false,false,false,false,false,false,false,false,false,false,false,false};
		//单元格是否加样式函数
		boolean [] isStylerColumn = {false,false,false,false,false,false,false,false,false,false,false,false,false,false,false};
		//表格是否加操作列
		//表格列宽度
		String widths[] = {"100","100","120","120","100","100","100","100","100","100","100","100","100","100","100"};
		//表格列显示方式
		String aligns[] = {"center","center","center","center","center","center","center","center","center","center","center","center","center","center","center"};
		
		this.formatEasyuiFields(false, filedTitle, colsTable, isShow, frozen, isFiledSort,isFormatColumn, isStylerColumn, widths, aligns);// 如果第二个参数为null，默认为全排序
		//加操作
		operationField = "{title:'&nbsp',colspan:11},{field:'COLL_OBJ_ID',title:'操作',width:100,align:'center', rowspan:2,formatter: function(value,rec){return '<a onclick=\"alert(' + value + ');\">明细</a>';}}";
		//标题分组  就加此
		operationField = "{title:'基本信息',colspan:11},{field:'COLL_OBJ_ID',title:'操作',width:100,align:'center', rowspan:2,formatter: function(value,rec){return '<a onclick=\"alert(' + value + ');\">明细</a>';}}";
		
		return DEFAULT;
	}
	public void gridAjax() throws Exception{
		try{
			pager.setCurrentPage(Integer.valueOf(this.page));
			pager.setPageSize(Integer.valueOf(this.rows));
			HashMap<String,String> params = new HashMap<String,String>();
			params.put("orgno", this.orgno);
			params.put("datetime", this.datetime);
			params.put("tgname", this.tgname);
			params.put("_ysx", this.ysx);
			params.put("_yxx", this.yxx);
			List<HashMap> list = pbrateService.gridDataList(pager, params);
			pager = (Pager) pbrateService.getReturn("pager");
			//如果想在ajax返回数据后加自己的处理数据
			HashMap<String,String> attachement = new HashMap();
			attachement.put("name", "zhaoheng");
			
			super.outJsonData(list, attachement, pager, colsTable);
		}catch (Exception e){
			e.printStackTrace();
			throw e;// 不可缺少，向上抛出，保证前台页面友好提示错误
		}
	}

2：easyui引用方式
<link rel="stylesheet" type="text/css" href="../js/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../js/easyui/themes/icon.css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>

3：jqGridLoadedCallback
如果想在grid加载完毕后处理一些操作，那么就实现此函数

4:改变jqgrid宽度，默认是100%    在JS中定义变量      _jqgrid_width = '96%';即可

 
protected String order;
protected String sort;

5:如果操作不想使用页面JS处理
list中加
String filedTitle = "单位,台区,线路,合...,操作";
colsTable = "NAME,TG_NAME,LINE_N....,OPER";

listAjax中
要在list中的HashMap中加key值OPER
--%>
<style>
    .datagrid-row a{
        cursor: pointer;
        text-decoration: underline;
    }
    html,body,form{
        margin: 0;
        padding: 0;
    }
    html{
        overflow-y:hidden;
    }

</style>
<script type="text/javascript" src="../js/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../js/ToolTip.js"></script>
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript"
            src="../js/easyui/jquery.easyui.min.js"></script>

    <script type="text/javascript" src="../js/util.js"></script>
    <script type="text/javascript" src="../main/js/myJs.js"></script>
    <script type="text/javascript" src="../main/js/openWin.js"></script>
<script type="text/javascript">
<%
String operationField = (String)request.getAttribute("operationField");
String item = (String)request.getAttribute("item");
String frozenFileds = (String)request.getAttribute("frozenFileds");
%>
jQuery(document).ready(function(){
    if(!window['_jqgrid_width'])window['_jqgrid_width'] = '100%';
    $('body').append("<div id='outer_td' style='line-height: 0;font-size: 0px;border:0px;height: 0px; width: " + _jqgrid_width + ";'></div>");
    $('#dg').datagrid({
        title:'',
        iconCls:'icon-save',
        width: 100%,
        height: 100%,
        nowrap: true,
        autoRowHeight: false,
        striped: true,
        collapsible:true,
        url: dropURLParams(),
        singleSelect: false,
        remoteSort: true,
        showHeader: true,
        pageSize: window['pageSize']!== undefined?window['pageSize']:30,
        pageList:[6, 15, 18, 20, 30, 50],
        queryParams: {
            colsTable:"${colsTable}"
        },
        <%
            if(frozenFileds != null){
        %>
        frozenColumns:[[<%=frozenFileds%>]],
        <%
            }
        %>
        columns:[
            <%
            if(operationField != null){
            %>
            [
                <%=operationField%>
            ],
            <%
                }
            %>
            [
                ${item}
            ]
        ],
        toolbar: window['toolBar'] ?window['toolBar']:null,
        pagination: window['isPagination'] !== undefined ? window['isPagination'] : true,
        rownumbers:true,        
    });
    try{
        var w = $('.datagrid-toolbar').width()-$('.datagrid-toolbar').find('table').width()-20;
        $('.datagrid-toolbar').find('tr').prepend("<td width="+w+"px>&nbsp;<td>");
        $('.datagrid-cell').css('text-align','center');
    }catch(exception)
    {
    }
});
    try{
        var w = $('.datagrid-toolbar').width()-$('.datagrid-toolbar').find('table').width()-20;
        if(w>50)
        {
            $('.datagrid-toolbar').find('tr').prepend("<td width="+w+"px>&nbsp;<td>");
        }
    }catch(exception)
    {
    }
    //alert(document.documentElement.clientHeight + '-' + clientHeight);
}
//返回没有参数的URL
function dropURLParams(){
    var _url = window.location.href.replace("#","").replace(".action","Ajax.action")
    var _index = _url.indexOf("?");
    if(_index > 0){
        _url = _url.substring(0,_index);
    }    
    alert(_url);
    return _url;
}
//重新设置jqgrid宽度及标题宽度
function resizeTableList(){
    resizeTable();
}
function getEasyUiGridHeight(){
    var tmpH = 200;
    var wh = screen.width + '_' + screen.height;
    if(wh == '1024_768'){
        //tmpH = 350;
        tmpH = 200;
    }else if(wh == '1440_900'){
        //tmpH = 500;
        tmpH = 200;
        if(window['isTabPage'] !== undefined && window['isTabPage'] === true){
            tmpH = 200;
        }
    }
    return tmpH;
}
function getSelectedRow(){
    return $('#dg').datagrid('getSelected');
}
function setPagerMethod(){
    $('#dg').datagrid('reload');
}

var _resizeTableInterval;
function resizeTableWhenLoaded(){
    if(!window['jqgridHeight']){
        _resizeTableInterval = window.setTimeout(function(){
            resizeTable();
            window.clearTimeout(_resizeTableInterval);
            _resizeTableInterval = null;
        }, 1000)
    }
}
function setGridWidth(width){
    $('#dg').datagrid('resize', {
        width: width
    });
}
function autAjustGridWidth(){
    $('#dg').datagrid('resize', {
        width: getGridWidth()
    });
}




		var editIndex = undefined;
		var $dg = $('#dg');
		function endEditing(){
			if (editIndex == undefined){return true}
			if ($('#dg').datagrid('validateRow', editIndex)){
				var ed = $('#dg').datagrid('getEditor', {index:editIndex,field:'p_id'});
				var productname = $(ed.target).combobox('getText');
				$('#dg').datagrid('getRows')[editIndex]['p_name'] = productname;
				$('#dg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				showMsg("提示","有未填写项！");
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
					/* var pname = $('#dg').datagrid('getEditor', {index:index,field:'p_id'});
					var p_part_no = $('#dg').datagrid('getEditor', {index:index,field:'p_part_no'});
					$(pname.target).combobox('disable');//选择后只读
					$(p_part_no.target).textbox('disable');//选择后只读 */
					($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
					editIndex = index;
				} else {
					$('#dg').datagrid('selectRow', editIndex);
				}
			}
		}
		function append(){
			if(!checkCustomerName()){return false;}
			if (endEditing()){
				index = $('#dg').datagrid('getRows').length+1;
				$('#dg').datagrid('appendRow',{itemid:''+index+'',status:'已存储'});
				editIndex = $('#dg').datagrid('getRows').length-1;
				$('#dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		//删除
		function removeit(){
			if (editIndex == undefined){return}
			var effectRow = new Object();
			var deleted = $dg.datagrid('getChanges', "deleted");
			if (deleted.length) {
                effectRow["deleted"] = JSON.stringify(deleted);
                var config = {title:'提示',
		        				  msg:'确定删除选中项吗？',
		        				  url:'ordersMgr!deleteOrderProduct.action',
		        				  data:effectRow,
		        				  rs:'删除'
		        	};
		        operateDataGrid(config);
		    }
		    $('#dg').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		
		
		function accept(){
			if(!checkCustomerName()){return false;}
			if (endEditing()){
				$('#order_time').datetimebox('disable');
				var $dg =$('#dg');
				var inserted = $dg.datagrid('getChanges', "inserted");//最后一次提交以来更改的行
		        var updated = $dg.datagrid('getChanges', "updated");
		       	var suppliersName = $('#supplierId').combobox('getValue');
		        var effectRow = new Object();
		        if (inserted.length) {
		        		objMerger(inserted,titleJsonProp());
		        		//inserted.push(person);//数组最后加一条记录
		        		//inserted.pop();//删除最后一项
		        		//inserted.unshift(person);//数组最前面加一条记录
		                effectRow["inserted"] = JSON.stringify(inserted);
		              
		        }
		        if (updated.length) {
		                effectRow["updated"] = JSON.stringify(updated);
		        }
		        if(effectRow.updated != null || effectRow.inserted != null){
		        	var config = {title:'提示',
		        				  msg:'确定提交该订单吗？',
		        				  url:'ordersMgr!addOrder.action',
		        				  data:effectRow,
		        				  rs:'提交'
		        	};
		        	operateDataGrid(config);
		       }
			}
		}
		//撤销
		function reject(){
			$('#dg').datagrid('rejectChanges');
			editIndex = undefined;
		}
		
				
		/*
		 标题的Json格式数据
		*/
		function titleJsonProp(){
			var supplierId = $('#supplierId').combobox('getValue');
		    var orderTime = $('#order_time').datetimebox('getValue');	
		    var obj = {};
		    obj.supplierId = supplierId;
		    obj.orderTime = orderTime;
		    return obj;
		}

</script>