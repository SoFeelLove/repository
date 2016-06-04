<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  
<title>独立文件操作</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    


<link href="../swfupload/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../swfupload/js/jquery.min.js"></script>
<script type="text/javascript" src="../swfupload/swfupload.js"></script>
<script type="text/javascript" src="../swfupload/js/swfupload.queue.js"></script>
<script type="text/javascript" src="../swfupload/js/fileprogress.js"></script>
<script type="text/javascript" src="../swfupload/js/filegroupprogress.js"></script>
<script type="text/javascript" src="../swfupload/js/handlers_iframe.js"></script>	
<script type="text/javascript" src="../swfupload/js/swfuploadcfg.js"></script>

<script type="text/javascript">

//swfupload初始化配置、调整相关属性和iframe高度
window.onload = function()
{
	initialCfg();
	adjustCfg();
	initFrameH();
}

//swfupload页面个性化配置
function adjustCfg()
{
	settings.file_types = "*.txt";
	settings.file_size_limit = "2 MB";
	swfu = new SWFUpload(settings);
}

//初始化IFRAME高度
function initFrameH(){
	var tableH = document.getElementById('frameTable').offsetHeight;
	this.frameElement.height = tableH;
}

//删除文件，用于文件上传后的删除
function delFileInfo(id,curFileName,curDir){
	if(confirm('请确认删除!')){
		$.post('${pageContext.request.contextPath}/servlet/SwfDeleteIFrame',
			{
				id: id,
				foder: curDir,
				name: curFileName
			},
     		function(data){
       			if(data=='1'){
       				var tempNode = document.getElementById('file' + id);
       				document.getElementById('container').removeChild(tempNode);
       				initFrameH();
       			}
     		}
		);
		
	}
}

function quChongArr(aStr)
{
   var aData = aStr.split(",");
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
	if(parent.document.getElementById('fileIds'))
		parent.document.getElementById('fileIds').value = parent.document.getElementById('fileIds').value.replace(delValue+",","");
}
function setIFrameParentInputId(){	
	if(parent.document.getElementById('fileIds'))
	{
		parent.document.getElementById('fileIds').value += document.getElementById('inputId').value;
		parent.document.getElementById('fileIds').value = quChongArr(parent.document.getElementById('fileIds').value)+"";//对重复记录滤重
	}
}

//-->
</script>
</head>

<body>
<input type="hidden" name="ufname" id="ufname" style="width: 100%;"/>
<input type="hidden" name="delfileid" id="delfileid" value="" style="width: 100%;"/>
<input type="hidden" name="delfilename" id="delfilename" value="" style="width: 100%;"/>
<input type="hidden" id="inputId"/>
<input type="hidden" id="returnId"/>
<p style="color: red">此页面用于多项多文件上传，嵌入到iframe中使用，父页面需要有个id为fileIds的隐藏域来保存多个文件id,使用时删除此行</p>
<table width="100%" height="30" border="0" cellpadding="0" cellspacing="0" id="frameTable">
<tr>
	<td>
		<!-- 下面的table表示要放置用户需要下载模板的链接 -->
		<table width="100%" height="0" border="0" cellpadding="0" cellspacing="0">
		</table>
	</td>
</tr>
<tr>
	<td align="left" >
		<!-- 下面的table表示要放置用户上传文件的链接列表,一个文件对一个一个tr，删除时通过调用delFileInfo将文件和此tr删除，具体的显示逻辑需要使用者负责 -->
		<table width="100%" height="0" border="0" cellpadding="0" cellspacing="1">
			<tbody id="container">
				<!-- 下面是一个tr的示例 -->
				<tr id="file4888"><!-- tr的id属性命名规则：file+文件id -->
		    		<td width="100%" height="23">
		    		<font style="color: #00524A;">
						<a href="javascript:void(0)" style="text-decoration: underline;" >有用的文件.txt</a>
					</font>&nbsp; &nbsp;
					<span style='cursor:pointer;color: #00524A;' onClick="javascript:delFileInfo(4888,'1307064355500.txt','20116');">删除</span>
		    		</td>
				</tr>
			</tbody>
		</table>
	<div id="divprogresscontainer"></div>
	<span id="spanButtonPlaceHolder" style="cursor:hand;"></span>
	<div id="divprogressGroup" style="display:none;"></div>
	</td>
</tr>
</table>
</body>
</html>
