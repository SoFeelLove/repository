<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<%--     <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'login.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../css/demo.css">
	<script type="text/javascript" src="../js/easyui1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="../js/easyui1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../main/js/easyui-lang-zh_CN.js"></script>
	<style type="text/css">
#center{  
position: absolute;  
width: 400px;  
height: 400px; 
left: 50%;  
top: 50%;  
margin-left: -200px;  
margin-top: -200px;  
}
	</style>
	
	<script type="text/javascript">
		function doLogin(){
			$("#ff").submit();
		}
	</script>

  </head>
  
  <body>
  
  <div id = "center" >
  <form id="ff" method="post" action="../user/loginMgr!checkLogin.action">
  <div class="easyui-panel" title="登录" style="width:400px;padding:30px 60px;margin:0 auto">
 
  <!-- 
  <div style="margin:20px 0;">
   		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#w').window('open')">Open</a>
  		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#w').window('close')">Close</a>
  </div>
  -->
  <div style="margin-bottom: 10px;">
  	<input class="easyui-textbox" name ="username" id="username" style="width:100%;height:30px;padding:12px" 
  		data-options="prompt:'登录名',iconCls:'icon-man',iconWidth:38"/>  	
  </div>
  <div style="margin-bottom: 20px;">
  	<input class="easyui-textbox" name="password" id="password" type="password" style="width:100%;height:30px;padding:12px" 
  		data-options="prompt:'登录密码',iconCls:'icon-lock',iconWidth:38"/>  	
  </div>
  <div>
  	<a herf="javascript:;" onclick="doLogin()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="padding: 5px 0px;width:100%">
  	<span style="font-size:14px;">登录</span></a>
  </div>  
   </div>
   </form>
   </div>
  </body>
</html>
