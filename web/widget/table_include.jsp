<%@ page language="java" pageEncoding="utf-8"%>
<%--   ------------------------使用说明------------------------
为了动态设置jqgrid的高度，凡是有高度的最外层容器需要加 class="outerContainer"


0：如果想在 jqgrid加载数据完毕后处理自己的附加参数那么在java中调用此重载方法,并且在自己的页面中加入函数  jqGridLoadedCallback(xml)    xml格式为<attachment><name>ss</name></attachment>
	public void outXmlData(List list, HashMap<String, String>  attachment,Pager pager,String cols,HashMap<String, String> formate ) throws IOException


页面定义变量   var shrinkToFit = false;代表表格数据不在充满整个页面，默认为true   当设置为false并且数据列多时会自动出滚动条
1：为了动态设置jqgrid的高度，凡是有高度的最外层容器需要加 class="outerContainer"
	jqgrid默认高度为500
如：<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outerContainer">

java代码使用说明 在方法的最后面加个参数
boolean [] frozen = {true, true, false, false, false,false, false, false, false, false};
this.formatClosTable(colsTable, colsSort, widths, aligns, frozen);// 如果第二个参数为null，默认为全排序

如果想让标题分组  则在java中加属性  如：
this.groupHeader = "[{startColumnName: 'ORG_NAME',numberOfColumns:2, titleText:'单位概述'},{startColumnName: 'MAX_LOAD',numberOfColumns:2, titleText:'负载率'}]";

2：easyui引用方式
<link rel="stylesheet" type="text/css" href="../js/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../js/easyui/themes/icon.css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>

3：jqGridLoadedCallback
如果想在jqgrid加载完毕后处理一些操作，那么就实现此函数

4:改变jqgrid宽度，默认是100%    在JS中定义变量      _jqgrid_width = '96%';即可
--%>
<link type="text/css" href="../js/jqueryui/jquery-ui.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" media="screen" href="../js/jq-grid/ui.jqgrid.css" />
<style>
html, body {
 margin: 0; /* Remove body margin/padding */
 padding: 0;
 font-size: 75%;
}
/*----------------重写jquery ui和jqgrid的CSS---------------*/
.ui-jqgrid .ui-jqgrid-view {
    font-size: 12px;
}
.ui-priority-secondary{
	background-image:url(../images/22_r2_c2.jpg);
	background-repeat:repeat-x;
	text-align:center;
}
.ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight {
    background: url("../images/ui-bg_flat_55_fbec88_40x100.png") repeat-x scroll 50% 50% #FBF9EE;
    border: 1px solid #BED5F6;
    color: #363636;
}
.ui-jqgrid .ui-jqgrid-hdiv {
    background: none !important;
}
.ui-state-hover, .ui-widget-content .ui-state-hover, .ui-widget-header .ui-state-hover, .ui-state-focus, .ui-widget-content .ui-state-focus, .ui-widget-header .ui-state-focus {
    background: url("../images/ui_state_hover_hh.png") repeat-x scroll 50% 50% #BED5F6;
    border: 1px solid #BED5F6;
    color: #212121;
    font-weight: normal;
}
.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
    background: url("../images/tabletopBg.jpg") repeat-x scroll 50% 50% #ffffff;
    border: 1px solid #BED5F6;
    color: #000000;
    font-weight: normal;
}
.ui-widget-content {
    border: 1px solid #BED5F6;
}
.ui-jqgrid tr.jqgrow td {
    height: 26px;
}
.ui-jqgrid .ui-jqgrid-htable th {
    height: 26px;
    padding: 0 2px;
}
.ui-priority-secondary{
	background-image:url(../images/22_r2_c2.jpg);
	background-repeat:repeat-x;
	text-align:center;
}
/*IE6下在冻结列情况下如果字数太多会导致表格不正常显示，故先设置小点当请求数据时间动态改变大小*/
.ui-jqgrid-sortable{
	width: 10px;
}
/*----------------重写jquery ui和jqgrid的CSS   ending ---------------*/
#pagerText{
	color: #00524A;
}
#pagerText a{
	color: #00524A;
	cursor: pointer;
	text-decoration: underline;
}
.ui-jqgrid-view a:link,.ui-jqgrid-view a:visited,.ui-jqgrid-view a:hover {
	color: #00524A;
	text-decoration: underline;
}
</style>

<script src="../js/jqueryui/jquery-ui.js" type="text/javascript"></script>
<script src="../js/jq-grid/grid.locale-cn.js" type="text/javascript"></script>
<script src="../js/jq-grid/jquery.jqGrid.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/ToolTip.js"></script>
<script type="text/javascript">
<%
String groupHeader = (String)request.getAttribute("groupHeader");
%>
function getShrinkToFitParam(){
	if(window['shrinkToFit'] !== undefined && window['shrinkToFit'] == false){
		return false;
	}
	return true;
}
var _grid_data;
jQuery(document).ready(function(){
	if(!window['_jqgrid_width'])window['_jqgrid_width'] = '100%';
	$('body').append("<div id='outer_td' style='line-height: 0;font-size: 0px;border:0px;height: 0px; width: " + _jqgrid_width + ";'></div>");
	window.setTimeout(function(){
		jQuery("#dg").jqGrid({
			url : dropURLParams(),
			datatype: 'xml',
			pager: false,
			mtype: 'POST',
			rownumbers: true,
			autowidth : false,
			rowNum : 0,//单页20行限制取消，设为0时，如果加入限制的话   把rowNum注销
			width: getGridWidth(),
			height: window['jqgridHeight']!== undefined?window['jqgridHeight']:330,
			shrinkToFit: getShrinkToFitParam(),//设置是否有横轴滚动条
			altRows : true,
			caption: '',
			colNames:[${titlesTable}],
			colModel:[
				${item}
			],
			xmlReader: {
				root : "Items",
				row: "Item",
				page: "Items>currentPage",
				total: "Items>totalPages",
				records: "Items>totalRows",
				repeatitems: false,
				id: "asin"
			},
			beforeRequest:function(){
				resizeTitleWidth();
			},
			ondblClickRow:function(rowid,iRow,iCol,e){
				var index = iRow - 1;
				var selRow = _grid_data[index];
				if(window['dblClickRowHandler'])window['dblClickRowHandler'](selRow);
			},
			loadComplete:function(xhr){
				_grid_data = $(xhr).find('ItemAttributes');
				
				createSplit(xhr);
	            resizeTableWidth();
	            //resetJqgridHeight();
	            if(window['jqGridLoadedCallback']){
	            	//attachment代表附加参数 它为一个XML对象  格式为<attachment><name>ss</name></attachment>
	            	window['jqGridLoadedCallback'](xhr.getElementsByTagName("attachment")[0]);
	            }
	            initToolTip();
	            jQuery("#dg").jqGrid('hideCol','FLAG');
	            if(window['changeFontColor'])window['changeFontColor']();
	            //替换rownum
	            var numtds = $(".ui-jqgrid-view td[class$='jqgrid-rownum']");
	            var rowid = 0;
	            for(var i = 0; i < numtds.length; i++){
	            	rowid = $(numtds[i]).parent().attr('id');
	            	$(numtds[i]).html(rowid);
	            	$(numtds[i]).attr('title',rowid);
	            }
	            //处理IE6下如果使用分组标题时不显示边框
	            var bVersion = $.browser.version;
	        	if(bVersion == '6.0'){
	        		var ths = $("table[class='ui-jqgrid-htable'] th[class*=' ui-th-column-header ']");
	        		for(i = 0; i < ths.length; i++){
	        			if($(ths[i]).width() > 4 && $(ths[i]).html() == ''){
	        				$(ths[i]).html('&nbsp;');
	        			}
	        		}
	        	}
			},
			resizeStop:function(newWidth,index){
				resizeTitleWidth();
		    },
			loadError:function(xhr,status,error){
				alert("页面加载失败..........");
			},
			serializeGridData:function(postData){
				//提交列名
				postData.colsTable = '${colsTable}';
				//得到页面中第一个form表单的所有参数值数组
				var j = 0;
				var paramArray = new Array();
				var form = document.forms[0];
				if(form == null){//判断有没有表单
					//alert("页面中没有表单");
				}else{
					var allInput = form.getElementsByTagName("input");
					for ( var i = 0; i < allInput.length; i++) {
						paramArray[j] = {name:allInput[i].name,value:allInput[i].value};
						j++;
					}
					var allSelect = form.getElementsByTagName("select");
					for ( var i = 0; i < allSelect.length; i++) {
						paramArray[j] = {name:allSelect[i].name,value:allSelect[i].value};
						j++;
					}
					var allTextarea = form.getElementsByTagName("textarea");
					for ( var i = 0; i < allTextarea.length; i++) {
						paramArray[j] = {name:allTextarea[i].name,value:allTextarea[i].value};
						j++;
					}
					//把参数数组里面的值赋值给后台
					for ( var i = 0; i < paramArray.length; i++) {
						//alert("参数序列："+i+"；参数名称："+paramArray[i].name+"；参数值："+paramArray[i].value);
						postData[paramArray[i].name] = paramArray[i].value;
					}
				}
				var _params = getURLParamNameAndValue();
				//form表单中的数据优先
				for(var prop in _params){
					if(postData.hasOwnProperty(prop))continue;
					postData[prop] = _params[prop];
				}
				//url中的参数优先
				for(var prop_url in _global_var_hh.url_param){
					postData[prop_url] = _global_var_hh.url_param[prop_url];
				}
				return postData;
			}
		});
		<%
		if(groupHeader != null && !groupHeader.trim().equals("")){
		%>
		jQuery("#dg").jqGrid('setGroupHeaders',{
			useColSpanStyle: false,
			groupHeaders:<%=groupHeader%>
		});
		<%
		}
		%>
		jQuery("#dg").jqGrid('setFrozenColumns');
	}, 150);
});
function getGridWidth(){
	if(window['jqgridWidth'])return window['jqgridWidth'];
	var width = $('#outer_td').width();
	if(width && width > 0){
		return width;
	}
	return 800;
}
//根据页面的高度重新设置jqgrid的高度
function resetJqgridHeight(){
	var bodyHeight = document.body.clientHeight>document.documentElement.clientHeight?document.body.clientHeight:document.documentElement.clientHeight;
	var container = $('.outerContainer');
	//判断是否设置了页面中其它容器中的高度，以此动态设置jqgrid高度
	if(container.length > 0){
		for(var i = 0; i < container.length; i++){
			bodyHeight -= $(container).height();
		}
		jQuery("#dg").jqGrid('setGridHeight',bodyHeight - 100);
	}
}
//用于在IE6下重新设置jqgrid title宽度
function resizeTitleWidth(){
	var bVersion = $.browser.version;
	//if(bVersion == '6.0'){
		try{
			$('.ui-jqgrid-labels th div').each(function(){
	    		var width_ = this.parentNode.style.width.replace('px','');
	    		this.style.width = (parseInt(width_,10) - 5) + 'px';
	    	});
    	}catch(ex){}
	//}
}
//重新设置jqgrid宽度
function resizeTableWidth(){
	window.setTimeout(function(){
		jQuery("#dg").jqGrid('setGridWidth',getGridWidth(),getShrinkToFitParam());
	},150);
}
var currentPageTemp = 0;
var _global_var_hh = {};
function setPagerMethod(method,funName){//翻页
	_global_var_hh.url_param = {
		"pager.pagerMethod":method,
		"pager.currentPage":currentPageTemp
	};
	jQuery("#dg").trigger("reloadGrid");
}
//创建分页函数
function createSplit(documents){
	var currentPage = documents.getElementsByTagName("currentPage")[0].firstChild.nodeValue;
	var totalPage = documents.getElementsByTagName("totalPages")[0].firstChild.nodeValue;
	var totalRows = documents.getElementsByTagName("totalRows")[0].firstChild.nodeValue;
 	var msg = "共"+totalRows+"条数据&nbsp; 第"+currentPage+"页&nbsp; 共"+totalPage+"页&nbsp; <a onclick=\"setPagerMethod('first')\">首页</a>&nbsp;&nbsp;<a onclick=\"setPagerMethod('previous')\">上一页</a>&nbsp;&nbsp;<a onclick=\"setPagerMethod('next')\">下一页</a>&nbsp;&nbsp;<a onclick=\"setPagerMethod('last')\">尾页</a>";
 	msg += '   第<input type="text" style="width:30px;" class="pts" id="curPage" value="' + currentPage + '"/>页 <a onclick="setTargetPage()">跳转</a>';
	var mytd = document.getElementById("pagerText");
	mytd.innerHTML = msg;
	currentPageTemp = currentPage;
}
function setTargetPage(){
	var curPage = document.getElementById('curPage').value;
	var inReg = /^\d+$/;
	if(!inReg.test(curPage)){
		alert('请输入数字!');
		document.getElementById('curPage').value = 1;
		document.getElementById('curPage').focus();
		return;
	}
	_global_var_hh.url_param = {
	    "pager.pagerMethod":"",
		"pager.currentPage":curPage
	};
	jQuery("#dg").trigger("reloadGrid");
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
//重新设置jqgrid宽度及标题宽度
function resizeTableList(){
    	resizeTitleWidth();
    	resizeTableWidth();
}
</script>