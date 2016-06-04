var liSaveFlag = 'saved' ;
function getClassName(element){
	return element.className.replace(/\s+/,' ').split(' ');
}
function addClassName(element,className){
	element.className += (element.className?' ' :'') + className
}
function removeClassName(element,className){
	var classes = getClassName(element);
	var length = classes.length;
	for(var i = length - 1; i >= 0; i--){
		if(classes[i] == className){delete(classes[i]);}
	}
	element.className = classes.join(' ');
}

function changeState(obj,url){
 	//控制页面条跳转
 	if(liSaveFlag=='unsaved' && isExist == 'false'){
 		alert("请首先提交当前接班人员，以及值班信息！");
 		$('#dutyclasses').combobox("enable");
		$('#weathers').combobox("enable");
		document.getElementById('saftdates').disabled = "";
		document.getElementById('dutydatestart').disabled = "";
		document.getElementById('dutydateend').disabled = "";
		document.getElementById('receivedate').disabled = "";
		document.getElementById("editbutton").style.display = "";
		return ;
	}
	
	var contentId = obj.id + 'content';
	var oframe = document.all?document.all['content']:document.getElementById('content');
	oframe.src = url;
	/*
	if(oframe.contentWindow){
		oframe.src = url;
	}else{
		oframe.location.href = url;
	}*/
	var lis = document.getElementById('main').getElementsByTagName('li');
	var idCon = '';
	for(var i = 0; i < lis.length; i++){
		removeClassName(lis[i],'ui-state-active');
	}
	addClassName(obj,'ui-state-active');
}
function liover(obj){
	addClassName(obj,'ui-state-hover');
}
function liout(obj){
	removeClassName(obj,'ui-state-hover');
}
