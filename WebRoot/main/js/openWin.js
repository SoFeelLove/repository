/**
 * modelStack_hh 中的对象为{父窗体，是否刷新父窗体，模态窗口的ID}
 */
var modelStack_hh = [];
var model_id_hh = 1;

/**
 * 打开新的模态窗口
 * @param url 模态窗口页面
 * @param p   模态窗口的父窗体
 * @param config 配制内容
 */
function openModel(url,p,config){
	config.id = 'model' + model_id_hh;
	config.lock = true;
	//此外为模态窗口的默认设置
	if(!config.opacity)config.opacity = 0.3;
	if(!config.width)config.width = 980;
	if(!config.height)config.height = 500;
	//模态窗口的关闭事件
	config.close = function(){
		//释放iframe
		if(modelStack_hh.length > 0){
			var src = "iframe[src='" + modelStack_hh[modelStack_hh.length - 1].modelUrl + "']";
			var popWin = $(src)[0].contentWindow;
			if(popWin && popWin.clear_iframe_hnepri){
				popWin.clear_iframe_hnepri();
			}
		}
		refrushWin();
		modelStack_hh.pop();
	};
	config.init = function(iwin,_top, _height, iWidth){
		window.setTimeout(function(){
			resizeJQGrid();
		}, 150);
		if(iwin.modelWindowLoadedCallback)iwin.modelWindowLoadedCallback(_height,iWidth);
	};
	modelStack_hh.push({_parent_:p,isFrush:config.winRefush,id:config.id,modelUrl:url});
	art.dialog.open(url, config);
	model_id_hh++;
}
function resizeJQGrid(){
	/**
	 * 由于改动过源代码
	 * jquery.artDialog.source.js  line 1126  加入代码  resizeJQGrid()
	 * 它会在每次弹出的窗口拖动时候调用，但是当modelStack_hh为0时，会报错，这种情况出现在没有页面的模态窗口
	 */
	if(modelStack_hh.length > 0){
		var src = "iframe[src='" + modelStack_hh[modelStack_hh.length - 1].modelUrl + "']";
		var oframe = $(src)[0];
		if(oframe && oframe.contentWindow.resizeTableList){
			oframe.contentWindow.resizeTableList();
		}
		if(oframe && oframe.contentWindow.modelResizeCallback){
			oframe.contentWindow.modelResizeCallback();
		}
	}
}
/**
 * 刷新窗口
 * @param isRefrush
 */
function refrushWin(){
	var isRefrush = modelStack_hh[modelStack_hh.length - 1].isFrush;
	if(isRefrush && (isRefrush == true || isRefrush == 1)){
		//获得当前模态窗口的父窗口
		var win = getParentWin();
		if(win == top)return;
		//开始刷新父窗体
		if(win.query){
			win.query();
		}else if(win.setPagerMethod){
			win.setPagerMethod('first');
		}else{
			win.location.reload(true);
		}
	}
}
/**
 * 关闭当前模态窗口
 */
function closeModel(){
	var id = modelStack_hh[modelStack_hh.length - 1].id;
	art.dialog.list[id].close();
}
function closeModel2(ifRefrush){
	if(ifRefrush && (ifRefrush == true || ifRefrush == 1)){
		modelStack_hh[modelStack_hh.length - 1].isFrush = ifRefrush;
	}
	closeModel();
}
	/**
 * 取得当前窗口的父窗口
 * @returns window对象
 */
function getParentWin(){
	return modelStack_hh[modelStack_hh.length - 1]._parent_;
}
//-------------------------------------以下是旧弹出窗口的方式-------------------------------------------
/**
 * 旧弹出窗口调用方式
 * @param config
 */
function alertWinCall(config){
	var url = config.url;
	var title = config.title;
	var w = config.w;
	var h = config.h;
	var winChild = config.winChild;
	var winRefush = config.winRefush;
	openModel(url,winChild,{
		title:title,
		width:w,
		height:h,
		winRefush:winRefush
	});
}

/**
 * 旧弹出窗口关闭
 * @param isRefrush
 */
function stackModelOper(ifRefrush){
	closeModel2(ifRefrush);
}
