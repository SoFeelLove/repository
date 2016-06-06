//页面打开新窗口,src传的是绝对路径
function tabOpen(title,src)
{
	parent.frames['topFrame'].goTo(title,src,true);
}
//判断是否是Float类型
function checkFloat(str)
{
	if(parseFloat(str)==str)   
 		return true; 
 	else
 		return false;
}
//判断是否是int类型
function checkInt(str)
{
	if(parseInt(str)==str)   
 		return true; 
 	else
 		return false;
}
//表格隔行换色
function setTrColor(tableId)
{
	var table = document.getElementById(tableId);
	if(table){
		var tr = table.getElementsByTagName("tr");
		for ( var i = 1; i < tr.length; i++) {
			if(i%2==0)
			{
				tr[i].className = "text_bottmes";
			}else{
				tr[i].className = "text_bottmes_other";
			}
		}
	}
}
function selectTR(tableId)
{
	var table = document.getElementById(tableId);
	var tr = table.getElementsByTagName("tr");
	for ( var i = 1; i < tr.length; i++) {
		if(i%2==0)
		{
			tr[i].className = "text_bottmes";
		}
		else
		{
			tr[i].className = "text_bottmes";
		}
	}
}
//导出EXCEL表格，把需要导入的内容放到一个div内，把div的ID传进来
function doExport(divID)
{
	if(document.getElementById("MyExcelExport")==null)
	{
		var mydiv = document.createElement("div");
		mydiv.innerHTML = "<form action='../util/export_output.jsp' id = 'MyExcelExport' name = 'MyExcelExport' method='post' target='_blank'><input type='hidden' name='content'></form>";
	  	document.body.appendChild(mydiv);
	}
	
	var model = document.getElementById(divID);
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
		tables[i].border=1;
	}
  	document.MyExcelExport.content.value = content.innerHTML;
	document.MyExcelExport.submit();
}
function openWin(url)
{
	window.open(url,"","scrollbars=yes,resizable=yes,width=900,height=800");
}
function openWin2(url,width,height)
{
	var y = (window.screen.availHeight-30-height)/2;    //获得窗口的垂直位置;
	var x = (window.screen.availWidth-10-width)/2;      //获得窗口的水平位置;
	window.open(url,"","scrollbars=yes,center=yes,resizable=yes,status=no,width="+width+",height="+height+",top="+y+",left="+x+"");
}
function openModelWin(url)
{	
	
	var r=Math.random();
	var returnValue = window.showModalDialog(url,'','dialogWidth=1000px;dialogHeight=250px;status=no;center=yes;');
	return returnValue;
	
}
function om2(url)
{	
	
	var r=Math.random();
	url=url+"&r="+r;
	var returnValue = window.showModalDialog(url,'','dialogWidth=1000px;dialogHeight=240px;status=no;center=yes;');
	return returnValue;
	
}

//删除字符串左边的空格
function ltrim(str) { 
	if(str.length==0)
		return(str);
	else {
		var idx=0;
		while(str.charAt(idx).search(/\s/)==0)
			idx++;
		return(str.substr(idx));
	}
}

//删除字符串右边的空格
function rtrim(str) { 
	if(str.length==0)
		return(str);
	else {
		var idx=str.length-1;
		while(str.charAt(idx).search(/\s/)==0)
			idx--;
		return(str.substring(0,idx+1));
	}
}
String.prototype.trim=function(){
	var regEx = /^\s*(.*?)\s*$/;
	return this.replace(regEx,"$1");
};
//删除字符串左右两边的空格
function trim(str) { 
	return(rtrim(ltrim(str)));
}
//导出jsp页面，测试EXCEL用，把需要导入的内容放到一个div内，把div的ID传进来
function doExportTest(divID)
{
	if(document.getElementById("MyExcelExportTest")==null)
	{
		var mydiv = document.createElement("div");
		mydiv.innerHTML = "<form action='../util/export_test.jsp' id = 'MyExcelExportTest' name = 'MyExcelExportTest' method='post' target='_blank'><input type='hidden' name='content'></form>";
	  	document.body.appendChild(mydiv);
	}
	
	var model = document.getElementById(divID);
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
		tables[i].border=1;
	}
  	document.MyExcelExportTest.content.value = content.innerHTML;
	document.MyExcelExportTest.submit();
	
}
/*
 * table:表格对象
 * startRow:开始计算的行位置
 * endRow:结束计算的行位置
 * column:要计算的哪一列数据
 * return:列和
 */
function computerData(table,startRow,endRow,column)
{
    var rows = table.rows;
    var counter = 0;
    var data = 0;
    var tdNode;
    var tempNode;
    for(var i = startRow; i <= endRow; i++)
    {
        tdNode = rows[i - 1].cells[column - 1];
       
        tempNode = tdNode.firstChild;
        if(tempNode)
        {
            data = tempNode.data.trim();
            if(data == "")data = "0";
            counter += parseFloat(data);
        }
    }
    return counter;
}
/*
 * fenZi:分子
 * fenMu:分母
 * return:百分比
 */
function percentValue(fenZi,fenMu)
{
    var temp;
    var split;
    var len;
    if(fenMu == 0)return 0;
    else
    {
        temp = fenZi / fenMu;
        temp = temp * 100;
        temp = temp + "";
        if(temp.indexOf(".") != -1)
        {
            len = temp.indexOf(".");
            split = temp.split(".");
            var ss = split[1];
            if(ss.length > 2)
                ss = ss.substring(0,2);
            temp = split[0] + "." + ss;
        }
    }
    return temp + "%";
}

// 精度运算
//除法函数，用来得到精确的除法结果 
//说明：javascript的除法结果会有误差，在两个浮点数相除的时候会比较明显。这个函数返回较为精确的除法结果。 
//调用：accDiv(arg1,arg2) 
//返回值：arg1除以arg2的精确结果 

function accDiv(arg1,arg2){ 
var t1=0,t2=0,r1,r2; 
try{t1=arg1.toString().split(".")[1].length}catch(e){} 
try{t2=arg2.toString().split(".")[1].length}catch(e){} 
with(Math){ 
r1=Number(arg1.toString().replace(".","")) 
r2=Number(arg2.toString().replace(".","")) 
return (r1/r2)*pow(10,t2-t1); 
} 
} 
//给Number类型增加一个div方法，调用起来更加方便。 
Number.prototype.div = function (arg){ 
return accDiv(this, arg); 
} 
//乘法函数，用来得到精确的乘法结果 
//说明：javascript的乘法结果会有误差，在两个浮点数相乘的时候会比较明显。这个函数返回较为精确的乘法结果。 
//调用：accMul(arg1,arg2) 
//返回值：arg1乘以arg2的精确结果 
function accMul(arg1,arg2) 
{ 
var m=0,s1=arg1.toString(),s2=arg2.toString(); 
try{m+=s1.split(".")[1].length}catch(e){} 
try{m+=s2.split(".")[1].length}catch(e){} 
return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m) 
} 
//给Number类型增加一个mul方法，调用起来更加方便。 
Number.prototype.mul = function (arg){ 
return accMul(arg, this); 
} 
//加法函数，用来得到精确的加法结果 
//说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。 
//调用：accAdd(arg1,arg2) 
//返回值：arg1加上arg2的精确结果 
function accAdd(arg1,arg2){ 
var r1,r2,m; 
try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
m=Math.pow(10,Math.max(r1,r2)) ;
return accDiv((accMul(arg1,m)+accMul(arg2,m)),m); 
} 
//给Number类型增加一个add方法，调用起来更加方便。 
Number.prototype.add = function (arg){ 
return accAdd(arg,this); 
}

// 减法函数
function Subtr(arg1,arg2){
     var r1,r2,m,n;
     try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
     try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
     m=Math.pow(10,Math.max(r1,r2));
     //last modify by deeka
     //动态控制精度长度
     n=(r1>=r2)?r1:r2;
     return ((arg1*m-arg2*m)/m).toFixed(n);
}

//给Number类型增加一个sub方法，调用起来更加方便。 
Number.prototype.sub = function (arg){ 
return Subtr(arg,this); 
}

/*
 在你要用的地方包含这些函数，然后调用它来计算就可以了。 
比如你要计算：7*0.8 ，则改成 (7).mul(8) 
其它运算类似，就可以得到比较精确的结果。
 */



/*
 * 取得元素坐标（左上角-针对IE/FF
 * 返回值:e.x,e.y 对应于X坐标，Y坐标
 */
function getElementPos(elementId) {
	var ua = navigator.userAgent.toLowerCase();
	var isOpera = (ua.indexOf('opera') != -1);
	var isIE = (ua.indexOf('msie') != -1 && !isOpera);
	var el = document.getElementById(elementId);
	if(el.parentNode === null || el.style.display == 'none') {
		return false;
	}      
	var parent = null;
	var pos = [];     
	var box;
	box = el.getBoundingClientRect();
	var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
	var scrollLeft = Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);
	var oo = {x:box.left + scrollLeft, y:box.top + scrollTop};
	if(isIE)
	{
		oo.x = oo.x -2;
		oo.y = oo.y - 2;
	}
	return oo;
}
/*
 * 打开模态窗口
*var _config = {
*		title:’title’,                //窗口名称
*		url:'../yxjc/PBRate!listdetail.action’ , //窗口的地址
*		w:800,                             //宽度
*		h:600,                             //高度
*		winChild:this,                     //父窗口，即当前窗口
*		winRefush:0,                       //当关闭子窗口时，是否刷新父窗口
*		opacity:0.3                        //层的透明度，可以都设置为相等(要求为小数),也可以不设置，默认为0.3
*	};
*/
function openDialog(config){
	top.alertWinCall(config);
}
//获取当前模态窗口的父窗口
function getParentWindow(){
	top.getParentWin();
}
//关闭模态窗口isRefrush  true 或者 false   true代表关闭模态窗口是刷新父窗口
function closeDialog(isRefrush){
	top.stackModelOper(isRefrush);
}
/**
 * 验证英文
 * 输入正确:return true,输入错误:return false
 */
function checkEn(str)
{
	var _reEn_ = /^[a-zA-Z]+$/g;
	return _reEn_.test(str);
}
//用于释放iframe
function clear_iframe_hnepri(){
	var dd = document.getElementsByTagName('iframe');
	var aFrames = [];
	for(var i = 0; i < dd.length; i++ ){
		aFrames.push(dd[i]);
	}
	var tempFrame = null;
	while((tempFrame = aFrames.pop())){
		tempFrame.contentWindow.document.open();
		tempFrame.contentWindow.document.write('');
		tempFrame.contentWindow.document.clear();
		tempFrame.contentWindow.document.close();
		tempFrame.contentWindow.close();
		tempFrame.src = 'about:blank';
		try{
			tempFrame.removeNode(true);
		}catch(ex){
			tempFrame.parent.removeChild(tempFrame);
		}
		tempFrame = null;
	}
	dd = null;
	aFrames = null;
	try{
		CollectGarbage();
	}catch(ex){ }
}
//获取第一个form中的数据
function getFormData(){
	var paramArray = new Array();
	var form = document.forms[0];
	var j = 0;
	var allInput = form.getElementsByTagName("input");
	var reObj = {};
	
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
	
	//alert("表单中参数个数为空:"+paramArray.length);
	//把参数数组里面的值赋值给后台
	for ( var i = 0; i < paramArray.length; i++) {
		reObj[paramArray[i].name] = paramArray[i].value;
	}
	return reObj;
}
/**
 * 获取URL相对应的文件名，不带扩展名
 * 如center.jsp:center
 * @param url
 * @returns
 */
function getURL2FileName(url){
	var indexQuestionMark = url.indexOf('?');
	var indexPound = url.indexOf('#');
	if(indexQuestionMark != -1){
		url = url.substring(0,indexQuestionMark);
	}else if(indexPound != -1){
		url = url.substring(0,indexPound);
	}
	return url.substring(url.lastIndexOf('/') + 1,url.lastIndexOf('.'));
}

//把Date对象添加format方法
Number.prototype.pad2 =function(){   
  return this>9?this:'0'+this;   
};   
Date.prototype.format=function (format) {   
	var it=new Date();   
	var it=this;   
	var M=it.getMonth()+1,H=it.getHours(),m=it.getMinutes(),d=it.getDate(),s=it.getSeconds();   
	var n={ 'yyyy': it.getFullYear()   
			,'MM': M.pad2(),'M': M   
			,'dd': d.pad2(),'d': d   
			,'HH': H.pad2(),'H': H   
			,'mm': m.pad2(),'m': m   
			,'ss': s.pad2(),'s': s   
	};   
	return format.replace(/([a-zA-Z]+)/g,function (s,$1) { return n[$1]; });   
};
//获得当前日期
function getDate(obj,accepttime){
	var dateTemp = obj.value ;
	if(dateTemp == ''){
		setDate(obj,accepttime);
	}
};

//设置当前时间加上随即10分钟到15分钟
function getAfterDate(obj,accepttime){
	var dateTemp = obj.value ;
	if(dateTemp == ''){
		setDateAfter(obj,accepttime);
	}
}

function setDateAfter(obj,accepttime){
	var temp = Math.random()*3 + 8;
	var currentdate = new Date(Date.parse(accepttime.replace(/-/g, '/')));
	currentdate.setMinutes(currentdate.getMinutes()+temp);
	document.getElementById(obj.id).value = currentdate.format('yyyy-MM-dd HH:mm:ss');
}

function setDate(obj,accepttime){
	var accept = Date.parse(accepttime.replace(/-/g, '/'));
	var random = Math.random()*10000+10000;
	var date = new Date(accept+random);
	document.getElementById(obj.id).value = date.format('yyyy-MM-dd HH:mm:ss');
}
