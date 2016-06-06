<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>仓库管理系统</title>
	<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../css/demo.css">
	<script type="text/javascript" src="../js/easyui1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="../js/easyui1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../main/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
/**
跳出框架
*/
if(window != top){
top.location.href = location.href;
window.event.returnValue=false;
}
function doLogin(){
		$("#ff").submit();
}
</script>

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

</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">

	<div region="north" split="false" border="false"
		style="overflow: hidden; height: 64px;
        background: url(images/top-right.gif);
        line-height: 38px;color: #fff; font-family: Arial, Helvetica, sans-serif">        
		<span style="float:left"><img src="images/logo.gif"></span>
	</div>
	<div region="south" split="false"
		style="height: 40px; background: url(images/footer_bg.png)">
		<div class="footer" style="text-align:center;12px;line-height: 38px;color: #fff; font-family: Arial, Helvetica, sans-serif">Copyright © 2015-**** 625456668@qq.com
			版权所有，翻版必究</div>
	</div>
	
	<div id="mainPanle" region="center"	style="background: #eee; overflow-y:hidden">
		<form id="ff" method="post" action="../user/loginMgr!checkLogin.action">
		<div id="center">
			<div class="easyui-panel"  title="欢迎登录" style="width:400px;padding:30px 60px;margin:0 auto">
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
		</div>
		</form>
	</div>

	
</body>
</html>