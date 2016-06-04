<%@ page language="java" import="java.util.*"  pageEncoding="utf-8"%>
<%@page import="com.hnepri.commons.UploadFile"%>
<link href="../swfupload/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
		<script type="text/javascript" src="../swfupload/swfupload.js"></script>
		<script type="text/javascript" src="../swfupload/js/swfupload.queue.js"></script>
		<script type="text/javascript" src="../swfupload/js/fileprogress.js"></script>
		<script type="text/javascript" src="../swfupload/js/filegroupprogress.js"></script>
		<script type="text/javascript" src="../swfupload/js/handlers.js"></script>
		<script type="text/javascript" src="../swfupload/js/swfuploadcfg.js"></script>
<script type="text/javascript">


function delFileById(id,curFileName,curDir){
   		$.post('${pageContext.request.contextPath}/servlet/FileDelOper',
			{
				id: id,
				foder: curDir,
				name: curFileName
			},
     		function(data){
       			if(data=='1'){
       				var tempNode = document.getElementById('file' + id);
       				document.getElementById('innerfile').removeChild(tempNode);
       				//initFrameH();
       				var file_len = document.getElementById('innerfile').getElementsByTagName('a');
       				var _new_up_file_len = document.getElementById('divprogresscontainer').childNodes.length;
       				var len = file_len.length + _new_up_file_len; 
       				if(len < file_size){
       					document.getElementsByTagName('object')[0].style.display = '';
       				}
       				
       			}
       			
       			
     		});
		
		document.getElementById("delfileid").value += id+",";
}
function initFile(){
	//var fileStr = parent.document.getElementById('').value;
	var htmlStr="";
	<%
	
	if(fileList != null){
	for(int i=0;i<fileList.size();i++){
		UploadFile file = (UploadFile)fileList.get(i);
	%>
		htmlStr += "<span id=\"file<%=file.getId()%>\">&nbsp;&nbsp;&nbsp;&nbsp;<%=file.getOldname()%>&nbsp;&nbsp;&nbsp;<a href=\"#\" onclick=\"delFileById('<%=file.getId()%>','<%=file.getNewname()%>','<%=file.getDirect()%>')\">删除</a><br/></span>";
	<%}
	}%>
	document.getElementById("innerfile").innerHTML = htmlStr;
	
}
</script>

				<table>
				<tr>
					<td ><div id="innerfile"></div></td>
				</tr>
				</table>
				<input type="hidden" name="ufname" id="ufname"/>
				<input type="hidden" name="delfileid" id="delfileid" value=""/>
		          <span id="spanButtonPlaceHolder" style="cursor:hand;"></span>
		          <div id="divprogresscontainer"></div>
		          <div id="divprogressGroup" style="display:none;"></div>
