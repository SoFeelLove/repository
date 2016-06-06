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
	var oframe = document.frames?document.frames['_content_']:document.getElementById('_content_');
	if(oframe.contentWindow){
		oframe.contentWindow.location.href = url;
	}else{
		oframe.location.href = url;
	}
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