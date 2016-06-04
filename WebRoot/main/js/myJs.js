/*弹出框及系统消息框*/
function showMsg(title, msg, isAlert) {
	if (isAlert != undefined && isAlert) {
		$.messager.alert(title, msg);
	} else {
		$.messager.show({
			title : title,
			msg : msg,
			showType:'fade',
			style:{
				right:'',
				bottom:''
			}
		});
	}
}
/* 确认框 */
function showConfirm(title, msg, callback) {
	$.messager.confirm(title, msg, function(r) {
		if (r) {
			if (jQuery.isFuncion(callback)) {
				callback.call();
			}
		}
	});
}
/**
 * 管理数据编辑
 * @param config{title,msg,url,data,rs}
 */
function operateDataGrid(config){
	var $dg =$('#dg');
	showConfirm(config.title,config.msg,function(){
     	$.post(config.url,config.data,function(rsp){
     		showProcess(true,'温馨提示','正在提交数据。。。');
     		if(rsp=="true"){
     			showProcess(false,'温馨提示','正在提交数据。。。');
     			$.messager.alert(config.title,config.rs+"成功！");
     			$dg.datagrid('acceptChanges');		        			
     		}else{
     			$.messager.alert(config.title,config.rs+"失败！");     			
     		}
     	},"text"); 
     });
}


function deleteRow(config){
	return showConfirm(config.title,config.msg,function(){
     	$.post(config.url,config.data,function(rsp){
     		showProcess(true,'温馨提示','正在提交数据。。。');
     		if(rsp=="true"){
     			showProcess(false,'温馨提示','正在提交数据。。。');
     			$('#dg').datagrid('deleteRow', config.index);
     			$.messager.alert(config.title,config.rs+"成功！");
     		}else{
     			$.messager.alert(config.title,config.rs+"失败！");     			
     		}
     	},"text"); 
     });
}



/*进度条，防止表单重复提交*/
function showProcess(isShow,title,msg){
	if(!isShow){
		$.messager.progress('close');
		return;
	}
	var win = $.messager.progress({
		title:title,
		msg:msg
	});
}
/*防止重复提交，显示进度条。提交完成，关闭进度条并提示操作信息 data：1,提交成功*/
function sumbitForm(url){
	$('#ff').form('submit',{
		url:(url === undefined ? "/ajax/common.jsp" : url),
		onSubmit:function(){
			var flag = $(this).form('validate');
			if(flag){
				showProcess(true,'温馨提示','正在提交数据。。。');
			}
			return flag;
		},
		success: function(data){
			showProcess(false);
			if(data == 1){
				showMsg('温馨提示','提交成功！');
				if(parent !== undefined){
					if($.isFunction(window.reloadParent)){
						reloadParent.call();
					}else{
						parent.$('#dg').datagrid('reload');
						parent.closeMyWindow();
					}
				}
			}else{
				$.messager.alert('温馨提示',data);
			}
		},
		onLoadError:function(){
			showProcess(false);
			$.messager.alert('温馨提示','由于网络或服务器太忙，提交失败，请重试！');
		}
		
	});
}

/*窗口*/
function showMyWindow(config){
	$('body').append('<div id="myWindow" class="easyui-window" closed="true" data-options="iconCls:\'icon-save\'" style="padding:1px; margin:0 auto;"></div>').css("padding","0px");
	$('#myWindow').window({
		title:config.title,
		iconCls: 'icon-edit',
		width:config.width === undefined ? 600 :config.width,
		height:config.height === undefined ? 400 :config.height,
	    content:'<iframe scrolling="yes" frameborder="0" src="' + config.url +'"style="width:100%;height:100%;"></iframe>',
	    //href:href === undefined?null:href,
		modal:config.modal === undefined ? true : config.modal,
		minimizable:config.minimizable=== undefined ? false :config.minimizable,
		maximizable:config.maximizable=== undefined ? false :config.maximizable,
		shadow:config.shadow === undefined ? true : config.shadow,
		cache:config.cache === undefined ? false : config.cache,
		closed:config.closed === undefined ? false : config.closed,
		collapsible:config.collapsible === undefined ? false : config.collapsible,
		inline:config.inline === undefined ? false : config.inline,
		loadingMessage:'正在加载数据，请稍等片刻。。。。。。',
		onClose:function(){
			if(config.refresh !== null && config.refresh){
			if($('#dg') !== undefined )
				$('#dg').datagrid('reload');
			}
		}
	});
}
/*关闭窗口*/
function closeMyWindow(){
	$('#myWindow').window('close');
}
function deleteConfirm(){
	return showConfirm('温馨提示','确定要删除吗？');
}
function showConfirm(title,msg,callback){
	$.messager.confirm(title,msg,function(r){
		if(r){
			if(jQuery.isFunction(callback))
				callback.call();
		}else{
			return false;
		}
	});
	return true;
}
//时间格式化
Date.prototype.format = function (format) {
	    if (!format) {
		format = "yyyy-MM-dd hh:mm:ss";
	}
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	// millisecond
	};
	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
};

function getCurrTime(){
	var nowTime = new Date();
	var date = nowTime.toLocaleDateString();
	var year = nowTime.getFullYear();
	var month = nowTime.getMonth()+1;
	var day = nowTime.getDate();	
	var hour = nowTime.getHours();
	var min = nowTime.getMinutes();
	var ss = nowTime.getSeconds();
//		var nowTimeStr = date.replace(/\//g, "-")+" "+hour+":"+min+":"+ss;
	return year+"-"+(month<10?('0'+month):month)+"-"+(day<10?('0'+day):day)+" "
		+(hour<10?('0'+hour):hour)+":"+(min<10?('0'+min):min)+":"+(ss<10?('0'+ss):ss);
	
}
//格式化时间
function fomatDate(str) {
   return (new Date(parseInt(str.substring(str.indexOf('(') + 1, str.indexOf(')'))))).format("yyyy-MM-dd hh:mm:ss");
}
//删除选中行,serviceKey服务器关键字，rowKey前台对应后台的关键字
function deleteChoiceRows(deleteConfig) {
	var rows = $('#dg').datagrid('getSelections');
	//判断是否选择行
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择要删除的数据!', 'info');
		return;
	}
	var ids = [];
	for ( var i = 0; i < rows.length; i++) {
		ids.push(rows[i][deleteConfig.rowKey]);//确定要删除的对象
	}
	var href = deleteConfig.url + "?" +deleteConfig.serviceKey + "=" +ids;
	$.messager.confirm('提示', '是否删除选中的'+ids.length+'条数据?', function (r) {
		if (!r) {
			return;
		}else{
			$.ajax({
				type : "POST",
				url : href,
				dataType: "text",
				success : function(msg) {
					$('#dg').datagrid('reload');
				}
			});
		}			
	});
}

//删除选中行,serviceKey服务器关键字，rowKey前台对应后台的关键字
function deleteRowsMultiCondition(deleteConfig) {
	var href = deleteConfig.url + deleteConfig.data;
	$.messager.confirm('提示', '是否删除选中的条数据?', function (r) {
		if (!r) {
			return;
		}else{
			$.ajax({
				type : "POST",
				url : href,
				dataType: "text",
				success : function(msg) {
					$('#dg').datagrid('reload');
				}
			});
		}			
	});
}
/**
 * 获取选中行的数据
 * @returns {Array}
 */
function getDeleteRows(key){	
	var rows = $('#dg').datagrid('getSelections');
	var ids = [];
	for ( var i = 0; i < rows.length; i++) {
		ids.push(rows[i][key]);//确定要删除的对象
	}
	return ids;
}        
	

//全局模态窗口
dialog = function (opts) {
    var query = parent.$, fnClose = opts.onClose;
    opts = query.extend({
        title: 'My Dialog',
        width: 400,
        height: 220,
        closed: false,
        cache: false,
        modal: true,
        html: '',
        url: '',
        viewModel: query.noop
    }, opts);

    opts.onClose = function () {
        if (query.isFunction(fnClose)) fnClose();
        query(this).dialog('destroy');
    };

    if (query.isFunction(opts.html))
        opts.html = utils.functionComment(opts.html);
    else if (/^\#.*\-template$/.test(opts.html))
        opts.html = $(opts.html).html();

    var win = query('<div></div>').appendTo('body').html(opts.html);
    if (opts.url)
        query.ajax({ async: false, url: opts.url, success: function (d) { win.empty().html(d); } });
    win.dialog(opts);
    query.parser.onComplete = function () {
        if ("undefined" === typeof ko)
            opts.viewModel(win);
        else
            ko.applyBindings(new opts.viewModel(win), win[0]);

        query.parser.onComplete = query.noop;
    };
    query.parser.parse(win);
    return win;
};




  