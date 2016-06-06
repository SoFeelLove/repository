<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="../css/style.css" rel="stylesheet" type="text/css" />
		
		<title> </title>
		<script type="text/javascript">


       function submitData()
		{
			document.form1.action="../auto/TType!save.action";
			document.form1.submit();
		}
		
		function makeclose()
		{
			window.returnObj = {    //returnObj 即为返回值对象
					name:'value'
			};
			top.stackModelOper(false);//参数代表是否刷新父页面
			
		}
		
       //以下Js  上传必用
       window.onload = function()
       {
       		//上传文件所需的配置
       		initialCfg();
       		//此方法用于自定义上传格式、条件！
       		adjustCfg();
       		initFile();
       };
       //限制上传文件个数
       
       //此方法用于自定义上传格式、条件！
       <% List<UploadFile> fileList = (List<UploadFile>)request.getAttribute("uploadFiles");

       %>
       var file_size = 1;
       var temp_file_size = 0;
       function adjustCfg()
		{
			var curSize = <%if(fileList==null)out.print(0);else out.print(fileList.size());%>;
			temp_file_size = curSize;
			settings.file_upload_limit = 0;
			swfu = new SWFUpload(settings);
			if(curSize>=file_size){
				document.getElementsByTagName('object')[0].style.display = 'none';
			}
		}
    </script>
	</head>
	<body >
	<form name="form1" method="post">
		   	 <br/>
	   		  <%@ include file="../util/upload2.jsp"%>
		      <br/>
	<br>
	  &nbsp;
		  <input name="sub" type="button" value="提交" onClick="submitData()"/>
	      &nbsp;
		  <input name="back" type="button" class="yshi1" value="关闭" onClick="makeclose()"/>
		  </form>
	</body>
</html>