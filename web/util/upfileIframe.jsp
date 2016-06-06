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
			document.form1.action="Company!update.action";
			var fileids = document.getElementById("fileids").value.substring(0,document.getElementById("fileids").value.length-1);
			document.getElementById("fileids").value=fileids;
			var delfileids = document.getElementById("delfileids").value.substring(0,document.getElementById("delfileids").value.length-1);
			document.getElementById("delfileids").value=delfileids;
			document.form1.submit();
		}
		
		function makeclose()
		{
			window.returnObj = {    //returnObj 即为返回值对象
					name:'value'
			};
			top.stackModelOper(false);//参数代表是否刷新父页面
			
		}
		
       
    </script>
	</head>
	<body>
	<% String fileStr="12,配网工程.txt,1336100884565.txt,20125$14,抓实地.exe,1336039292282.exe,20125$16,按规范.doc,1336039360116.doc,20125"; %>
	<form name="form1" method="post">
			<input type="hidden" name="fileids" id="fileids" value=""/>
			<input type="hidden" name="delfileids" id="delfileids" value="" />
			<input type="hidden" name="fileStr" id="fileStr" value="<%=fileStr %>"/>
		   	上传文件： <br/>
	   		  <iframe width="500" height="300" style="border: 0px green solid;"  frameborder="0" src="../util/uploadFile.jsp?inputId=fileids&delfileids=delfileids&fileStr=fileStr"></iframe>
		      <br/>
	<br>
	  &nbsp;
		  <input name="sub" type="button" class="yshi1" value="提交" onClick="submitData()"/>
	      &nbsp;
		  <input name="back" type="button" class="yshi1" value="关闭" onClick="makeclose()"/>
		  </form>
	</body>
</html>