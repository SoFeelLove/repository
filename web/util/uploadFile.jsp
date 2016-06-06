<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  
<title>独立文件操作</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="${pageContext.request.contextPath}/swfupload/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/swfupload/js/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/swfupload/swfupload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/swfupload/js/swfupload.queue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/swfupload/js/fileprogress.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/swfupload/js/filegroupprogress.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/swfupload/js/handlers_iframe.js"></script>
<%
	

String inputId = request.getParameter("inputId");
String fileStr = request.getParameter("fileStr");
String delfileids = request.getParameter("delfileids");
 %>
<script type="text/javascript">
<!--
var swfu;
window.onload = function()
{
    var settings = {
        flash_url: "${pageContext.request.contextPath}/swfupload/swfupload.swf",
        upload_url: "${pageContext.request.contextPath}/servlet/SwfUploadIFrame",
        file_size_limit: "1000 MB",
        file_types: "*.*",
        file_types_description: "All Files",
        file_upload_limit: 100,
        file_queue_limit: 0,
        custom_settings: {
            progressTarget: "divprogresscontainer",
            progressGroupTarget : "divprogressGroup",
            //progress object
            container_css: "progressobj",
            icoNormal_css: "IcoNormal",
            icoWaiting_css: "IcoWaiting",
            icoUpload_css: "IcoUpload",
            fname_css : "fle ftt",
            state_div_css : "statebarSmallDiv",
            state_bar_css : "statebar",
            percent_css : "ftt",
            href_delete_css : "ftt",
            //sum object
            /*
                页面中不应出现以"cnt_"开头声明的元素
            */
            s_cnt_progress: "cnt_progress",
            s_cnt_span_text : "fle",
            s_cnt_progress_statebar : "cnt_progress_statebar",
            s_cnt_progress_percent: "cnt_progress_percent",
            s_cnt_progress_uploaded : "cnt_progress_uploaded",
            s_cnt_progress_size : "cnt_progress_size"
        },
        debug: false,//debug模式 正式使用的时候设为 false
        // Button settings
        button_image_url: "${pageContext.request.contextPath}/swfupload/images/TestImageNoText_65x29.png",
        button_width: "65",
        button_height: "29",
        button_placeholder_id: "spanButtonPlaceHolder",
        button_text: '<span class="theFont">上传文件</span>',
        button_text_style: ".theFont { font-size: 12;color:#0068B7; }",
 		button_cursor:SWFUpload.CURSOR.HAND,
        button_text_left_padding: 12,
        button_text_top_padding: 3,

        // The event handler functions are defined in handlers.js
        file_queued_handler: fileQueued,
        file_queue_error_handler: fileQueueError,
        upload_start_handler: uploadStart,
        upload_progress_handler: uploadProgress,
        upload_error_handler: uploadError,
        upload_success_handler: uploadSuccess,
        upload_complete_handler:uploadComplete,
        queue_complete_handler:queueComplete,
        file_dialog_complete_handler: fileDialogComplete
    };
    swfu = new SWFUpload(settings);        
	initFrameH();
	initFile();
};
function initFrameH(){
	//初始化IFRAME高度
	var tableH = document.getElementById('frameTable').offsetHeight;
	this.frameElement.height = tableH;
}
function initFile(){
	var fileStr = parent.document.getElementById('<%=fileStr%>').value;
	
	var str = fileStr.split("$");
	var htmlStr="";
	for(var i=0;i<str.length;i++){
		var file = str[i];
		var fi = file.split(",");
		
		htmlStr += "<span id=\"file"+fi[0]+"\">&nbsp;&nbsp;&nbsp;&nbsp;"+fi[1]+"&nbsp;&nbsp;&nbsp;<a href=\"#\" onclick=\"delFileById('"+fi[0]+"','"+fi[2]+"','"+fi[3]+"')\">删除</a><br/></span>";
		
	}
	document.getElementById("innerfile").innerHTML = htmlStr;
}
function delFileById(id,curFileName,curDir){
	if(confirm('请确认删除!')){
		$.post('${pageContext.request.contextPath}/servlet/FileDelOperIFrame',
			{
				id: id,
				foder: curDir,
				name: curFileName
			},
     		function(data){
       			if(data=='1'){
       				var tempNode = document.getElementById('file' + id);
       				document.getElementById('innerfile').removeChild(tempNode);
       				initFrameH();
       			}
     		}
		);
		document.getElementById("delfileid").value = id;
		parent.document.getElementById("<%=delfileids%>").value += document.getElementById("delfileid").value+",";
	}
}
function quChongArr(aStr)
{
   var aData = aStr.splite(",");
   var aTemp = [];
   var bflag;
   for(var i = 0; i < aData.length; i++)
   {
	   bflag = true;
	   for(var j = 0; j < aTemp.length; j++)
	   {
		   if(aTemp[j] == aData[i])
		   {
			   bflag = false;
			   break;
		   }
	   }
	   if(bflag)
	   {
		  aTemp.push(aData[i]);
	   }
   }
   return aTemp.join(",");
}
function quChongArr(aStr)
{
	//aStr = aStr.substring(0,aStr.length-1);
	//alert(aStr);
   var aData = aStr.split(";");
   var aTemp = [];
   var bflag;
   for(var i = 0; i < aData.length; i++)
   {
	   bflag = true;
	   for(var j = 0; j < aTemp.length; j++)
	   {
		   if(aTemp[j] == aData[i])
		   {
			   bflag = false;
			   break;
		   }
	   }
	   if(bflag)
	   {
		  aTemp.push(aData[i]);
	   }
   }
   return aTemp.join(",");
}
function delIFrameParentInputId(delValue)
{
	parent.document.getElementById('<%=inputId%>').value = parent.document.getElementById('<%=inputId%>').value.replace(delValue,"");
}
function setIFrameParentInputId(){	
	
	parent.document.getElementById('<%=inputId%>').value += document.getElementById('inputId').value;
	parent.document.getElementById('<%=inputId%>').value = quChongArr(parent.document.getElementById('<%=inputId%>').value)+"";//对重复记录滤重
}
function download(id){

	document.location.href='${pageContext.request.contextPath}/system/prodownload.jsp?id=' + id;
}

function filedownload(id){
	document.location.href='${pageContext.request.contextPath}/util/download.jsp?id=' + id;
}
function addPiCi2(){
	window.location.href = '../system/Wordtemplet_add.jsp';
}

//-->
</script>
</head>

<body >
<input type="hidden" name="ufname" id="ufname" style="width: 100%;"/>
<input type="hidden" name="delfileid" id="delfileid" value="" style="width: 100%;"/>
<input type="hidden" name="delfilename" id="delfilename" value="" style="width: 100%;"/>
<input type="hidden" id="inputId"/>
<input type="hidden" name="fileStrs" id="fileStrs" value=""/>
<table id="frameTable" width="100%" border="2" height="100">
<tr >
	<td id="innerfile"></td>
</tr>
<tr>
<td id="container">
<div id="divprogresscontainer"></div>
<span id="spanButtonPlaceHolder" style="cursor:hand;"></span>
<div id="divprogressGroup" style="display:none;"></div>
</td>
</tr>
</table>
</body>
</html>