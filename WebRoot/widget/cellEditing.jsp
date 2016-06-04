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
<script type="text/javascript" src="../js/json-js/json2.js"></script>
<script type="text/javascript" src="../main/js/myJson.js"></script>
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
        width: getGridWidth(),
        height: window['jqgridHeight']!== undefined?window['jqgridHeight']:getEasyUiGridHeight(),
        nowrap: true,
        autoRowHeight: false,
        striped: true,
        collapsible:true,
        url: dropURLParams(),
        //sortName: 'code',
        //sortOrder: 'desc',
        singleSelect: false,
        checkOnSelect:true,
        remoteSort: true,
        showHeader: true,
        pageSize: window['pageSize']!== undefined?window['pageSize']:30,
        pageList:[6, 15, 18, 20, 30, 50],
        queryParams: {
            colsTable:"${colsTable}"
        },
        //idField:'code',
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
        onBeforeEdit:function(index,row){
			row.editing = true;
			updateActions(index);
		},
		onAfterEdit:function(index,row){
			row.editing = false;
			updateActions(index);
		},
		onCancelEdit:function(index,row){
			row.editing = false;
			updateActions(index);
		},
        toolbar: window['toolBar'] ?window['toolBar']:null,
        pagination: window['isPagination'] !== undefined ? window['isPagination'] : true,
        rownumbers:true,
        rowStyler: window['rowStylerHandler'],
        onDblClickRow: window['doubleClickRowHandler'],
        onClickRow: window['singleClickRowHandler'],
        onBeforeLoad:function(param){
            if( window['beforequery'])
            {
                beforequery();
            }
            var paramArray = [];
            var form = document.forms[0];
            if(form){
                var allInput = form.getElementsByTagName("input");
                for ( var i = 0; i < allInput.length; i++) {
                    paramArray.push({name:allInput[i].name,value:allInput[i].value});
                }
                var allSelect = form.getElementsByTagName("select");
                for ( var i = 0; i < allSelect.length; i++) {
                    paramArray.push({name:allSelect[i].name,value:allSelect[i].value});
                }
                var allTextarea = form.getElementsByTagName("textarea");
                for ( var i = 0; i < allTextarea.length; i++) {
                    paramArray.push({name:allTextarea[i].name,value:allTextarea[i].value});
                }
                for ( var i = 0; i < paramArray.length; i++) {
                    param[paramArray[i].name] = paramArray[i].value;
                }
            }
            var _params = getURLParamNameAndValue();
            //form表单中的数据优先
            for(var prop in _params){
                if(param.hasOwnProperty(prop))continue;
                param[prop] = _params[prop];
            }
        },
        onLoadSuccess: function(data){
            if(window['jqGridLoadedCallback']){
                if(data.attachment){
                    window['jqGridLoadedCallback'](data.attachment,data.rows);
                }else{
                    window['jqGridLoadedCallback'](data.rows);
                }
            }
            //添加文字提示--当数据量大时候可以会耗时 300条数据18列大概62毫秒
            //var d1 = new Date().getTime();
            //var divs = $('table[class="datagrid-btable"] td div');
            if(window['isAddTitle'] === undefined || (window['isAddTitle'] !== undefined && window['isAddTitle'] === true)){
                $('table[class="datagrid-btable"] td div').each(function(i, obj){
                    if(obj.firstChild && obj.firstChild.nodeValue) obj.title = obj.firstChild.nodeValue;
                });
            }
            /*
             for(var i = 0; i < divs.length; i++){
             divs[i].title = divs[i].firstChild.nodeValue;
             }
             */
            //var d2 = new Date().getTime();
            //alert(d2 - d1);
            $('.datagrid-body').scrollTop(0);
        }
    });
    try{
        var w = $('.datagrid-toolbar').width()-$('.datagrid-toolbar').find('table').width()-20;
        $('.datagrid-toolbar').find('tr').prepend("<td width="+w+"px>&nbsp;<td>");
        $('.datagrid-cell').css('text-align','center');
    }catch(exception)
    {
    }
});
function updateActions(index){
	$('#dg').datagrid('updateRow',{
		index: index,
		row:{}
	});
}
function getRowIndex(target){
	var tr = $(target).closest('tr.datagrid-row');
	return parseInt(tr.attr('datagrid-row-index'));
}
/*编辑*/
function editrow(target){
	$('#dg').datagrid('beginEdit', getRowIndex(target));
}
/*删除*/
function deleteEditor(target,config){	
		var effectRow = new Object();
		var objArray = [];
		objArray.push(config.data);
        effectRow["deleted"] = JSON.stringify(objArray);
	   	var _config = {title:config.title == null ? '提示' : config.title,
			  msg:config.msg == null ? '确定删除吗？' : config.msg,
			  url:config.url == null ? '' : config.url,
			  data:effectRow,
			  rs:config.rs == null ? '删除' : config.rs,
			  index:getRowIndex(target)		  
	     };
     deleteRow(_config);  
}

/*保存*/
function saveEditor(target,config){
	$('#dg').datagrid('endEdit', getRowIndex(target));
	 var updated = $('#dg').datagrid('getChanges', "updated");
	 var inserted = $('#dg').datagrid('getChanges', "inserted");
	 if(inserted.length){
	 	updated = inserted;
	 }
	 var effectRow = new Object();
     if (updated.length) {
     	if(config.data != null){
    		objMerger(updated,config.data);
     	}
        effectRow[config.serviceKey] = JSON.stringify(updated);
     }
	 if(effectRow[config.serviceKey] != null){
   	 var _config = {title:config.title == null ? '提示' : config.title,
		  msg:config.msg == null ? '确定提交该订单吗？' : config.msg,
		  url:config.url == null ? '' : config.url,
		  data:effectRow,
		  rs:config.rs == null ? '提交' : config.rs
     };
	operateDataGrid(_config);
	}
}

function cancelrow(target){
	$('#dg').datagrid('cancelEdit', getRowIndex(target));
}
function insert(){
	var row = $('#dg').datagrid('getSelected');
	if (row){
		var index = $('#dg').datagrid('getRowIndex', row);
	} else {
		index = 0;
	}
	$('#dg').datagrid('insertRow', {
		index: index,
		row:{		
		}
	});
	$('#dg').datagrid('selectRow',index);
	$('#dg').datagrid('beginEdit',index);
}
//取得url的参数值以对象方式返回
function getURLParamNameAndValue(){
    var _url = window.location.href;
    var _a_param = _url.split("?");
    if(_a_param.length<=1)return null;
    //处理有参数的情况
    var _a_param_name_value = {};//函数最终返回值
    //如果只有一个参数名但是没有值
    if(_a_param[1].indexOf("=") < 0 && _a_param[1].indexOf("&") < 0){
        _a_param_name_value[_a_param[1]] = '';
        return _a_param_name_value;
    }
    var _a_params = _a_param[1].split("&");

    for(var i = 0; i < _a_params.length; i++){
        _a_param_name_value[_a_params[i].split("=")[0]] = _a_params[i].split("=")[1];
    }
    return _a_param_name_value;
}
function getGridWidth(){
    if(window['jqgridWidth'])return window['jqgridWidth'];
    var width = $('#outer_td').width();
    if(width && width > 0){
        return width;
    }
    return 800;
}
function resizeTable(iframeHeight){
    if(window['jqgridHeight']){
        $('#dg').datagrid('resize', {
            width: getGridWidth(),
            height: jqgridHeight
        });
        return;
    }
    $('#pagerText').remove();
    var clientHeight = 0;
    if(iframeHeight){
        clientHeight = iframeHeight;
    }else{
        
         clientHeight = document.documentElement.clientHeight;
         if(document.body.clientHeight > clientHeight)clientHeight = document.body.clientHeight;
         if(window['isUseFrameHeight'] === true && clientHeight > this.frameElement.clientHeight && this.frameElement.style.height){
         clientHeight = this.frameElement.clientHeight;
         }
        
        /* clientHeight = this.frameElement.clientHeight; */
    }
    var childs = null;
    var _ofirstChild = $('body').children()[0];
    //处理变态懒人的做法
    if((_ofirstChild.nodeName == 'FORM' || _ofirstChild.nodeName == 'CENTER') && $('body').children().length == 2){
        childs = $($('body').children()[0]).children();
    }else{//正常情况
        childs = $('body').children();
    }
    var tmpN = null;
    var isNeeded = false;
    for(var i = 0; i < childs.length; i++){
        //元素可见，且不包含grid
        var isStyleOrScript = childs[i].nodeName != 'SCRIPT' && childs[i].nodeName != 'STYLE'
        isNeeded = $(childs[i]).find('#dg').length == 0 && isStyleOrScript && childs[i].style.display != 'none';
        //alert(isStyleOrScript + '-' + childs[i].nodeName + '-' + childs[i].offsetHeight);
        if(isNeeded && (childs[i].nodeName != 'DIV' && childs[i].id != 'outer_td')){
            //alert(childs[i].nodeName + '-' + childs[i].offsetHeight);
            clientHeight -= childs[i].offsetHeight;
        }
        if($(childs[i]).find('#dg').length == 1){
            gridContainer = childs[i];
        }
    }
    var _trs_container = $($(gridContainer).children()[0]).children();
    for(i = 0; i < _trs_container.length; i++){
        if($(_trs_container[i]).find("table[id=dg]").length == 0){
            //alert(_trs_container[i].offsetHeight);
            clientHeight -= _trs_container[i].offsetHeight;
        }
    }
    $('#dg').datagrid('resize', {
        width: getGridWidth(),
        height: clientHeight
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
//当隐藏左侧菜单时会执行此函数
function resizeTableWidth(){
    resizeTable();
}
if(window.attachEvent){
    window.attachEvent('onload', resizeTableWhenLoaded);
    window.attachEvent('onunload',releaseEvent);
}else{
    window.addEventListener('load', resizeTableWhenLoaded, false);
    window.addEventListener('unload', releaseEvent, false);
}
function releaseEvent(){
    if(window.detachEvent){
        window.detachEvent('onload', resizeTableWhenLoaded)
        window.detachEvent('onunload', releaseEvent)
    }else{
        window.removeEventListener('load', resizeTableWhenLoaded, false);
        window.removeEventListener('unload', releaseEvent, false);
    }
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




//导出EXCEL表格，
function exportGrid(name)
{
    if(document.getElementById("MyExcelExport")==null)
    {
        var mydiv = document.createElement("div");
        mydiv.innerHTML = "<form action='../util/export_output.jsp' id = 'MyExcelExport' name = 'MyExcelExport' method='post' target='_blank'>" +
                "<input type='hidden' name='content'>" +
                "<input type='hidden' name='title_name' value='"+name+"'>" +
                "</form>";
        document.body.appendChild(mydiv);
    }

    var model = $(".datagrid-view2")[0];
    var content = model.cloneNode(true);
    while(true){
        var imgs = content.getElementsByTagName("img");
        if(imgs.length==0)break;
        for ( var i = 0; i < imgs.length; i++) {
            var main = imgs[i].parentNode;
            main.removeChild(imgs[i]);
        }
    }
    var tables = content.getElementsByTagName("table");
    for ( var i = 0; i < tables.length; i++) {
        tables[i].border=0;
    }
    document.MyExcelExport.content.value = content.innerHTML;
    document.MyExcelExport.submit();
}
//返回带有参数的URL
function withURLParams4Export(){
    var _url = window.location.href.replace("#","").replace(".action","Export.action");
    if( _url.indexOf("?")==-1){
        _url += "?timeStamp="+new Date();
    }
    var params = "";
    var form = document.forms[0];
    if(form){
        var allInput = form.getElementsByTagName("input");
        for ( var i = 0; i < allInput.length; i++) {
            params = params +"&"+allInput[i].name+"="+window.encodeURIComponent(allInput[i].value);
        }
        var allSelect = form.getElementsByTagName("select");
        for ( var i = 0; i < allSelect.length; i++) {
            params = params +"&"+allSelect[i].name+"="+window.encodeURIComponent(allSelect[i].value);
        }
        var allTextarea = form.getElementsByTagName("textarea");
        for ( var i = 0; i < allTextarea.length; i++) {
            params = params +"&"+allTextarea[i].name+"="+window.encodeURIComponent(allTextarea[i].value);
        }
    }

    return _url+params;
}
//返回带有参数的URL
function withoutURLParams4Export(){
    var _url = window.location.href.replace("#","").replace(".action","Export.action");
    _url = _url.substr(0,_url.indexOf(".action")+7);
    if( _url.indexOf("?")==-1){
        _url += "?timeStamp="+new Date();
    }
    var params = "";
    var form = document.forms[0];
    if(form){
        var allInput = form.getElementsByTagName("input");
        for ( var i = 0; i < allInput.length; i++) {
            params = params +"&"+allInput[i].name+"="+window.encodeURIComponent(allInput[i].value);
        }
        var allSelect = form.getElementsByTagName("select");
        for ( var i = 0; i < allSelect.length; i++) {
            params = params +"&"+allSelect[i].name+"="+window.encodeURIComponent(allSelect[i].value);
        }
        var allTextarea = form.getElementsByTagName("textarea");
        for ( var i = 0; i < allTextarea.length; i++) {
            params = params +"&"+allTextarea[i].name+"="+window.encodeURIComponent(allTextarea[i].value);
        }
    }

    return _url+params;
}
	function exportExcel() {
		var initialAction = $('#form').attr("action");
		var _action = initialAction.replace(".action",
				"Export.action");
		$('#form').attr("action", _action);
		$('#form').submit();
		$('#form').attr("action", initialAction);
	}
</script>