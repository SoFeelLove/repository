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
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="themes/icon.css" />
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css" />
<script type="text/javascript" src="js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/outlook2.js"></script>
<script type="text/javascript" src="js/myJs.js"></script>
<script type="text/javascript">
	var _menus = {
		"menus" : [
				
				{
					"menuid" : "1",
					"icon" : "icon-sys",
					"menuname" : "基础信息",
					"menus" : [ {
						"menuid" : "11",
						"menuname" : "查看客户",
						"icon" : "icon-nav",
						"url" : "${pageContext.request.contextPath}/customers/customersMgr!list.action"
						
					},
					{
						"menuid" : "12",
						"menuname" : "查看产品",
						"icon" : "icon-nav",
						"url" : "${pageContext.request.contextPath}/products/productsMgr!list.action"
						
					}
					]
				} 
				,{
					"menuid" : "2",
					"icon" : "icon-sys",
					"menuname" : "进货管理",
					"menus" : [
							{
								"menuid" : "22",
								"menuname" : "查看进货单",
								"icon" : "icon-nav",
								"url" : "${pageContext.request.contextPath}/customers/ordersMgr!list.action"
							}]
				}, {
					"menuid" : "3",
					"icon" : "icon-sys",
					"menuname" : "出货管理",
					"menus" : [ {
						"menuid" : "31",
						"menuname" : "查看出货单",
						"icon" : "icon-nav",
						"url" : "${pageContext.request.contextPath}/customers/orderSaleMgr!list.action"
					}]
				}
				
			]
	};
	//设置登录窗口
	function openPwd() {
		$('#w').window({
			title : '修改密码',
			width : 300,
			modal : true,
			shadow : true,
			closed : true,
			height : 160,
			resizable : false
		});
	}
	//关闭登录窗口
	function closePwd() {
		$('#w').window('close');
	}

	//修改密码
	function serverLogin() {
		var $newpass = $('#txtNewPass');
		var $rePass = $('#txtRePass');
		
		if ($newpass.val() == '') {
			msgShow('系统提示', '请输入密码！', 'warning');
			return false;
		}
		if ($rePass.val() == '') {
			msgShow('系统提示', '请在一次输入密码！', 'warning');
			return false;
		}

		if ($newpass.val() != $rePass.val()) {
			msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
			return false;
		}
		
		/*保存*/

     var config = {
		  url:'../user/loginMgr!modifyPassword.action?username=${username}&password='+$newpass.val()		  
      };  
		$.post(config.url,function(rsp){
     		if(rsp=="true"){
     			$.messager.alert('系统提示','恭喜，密码修改成功！<br>您的新密码为：' + $newpass.val(),'info');
     			$newpass.val('');
				$rePass.val('');
				$('#w').window('close');
     		}else{
     			$.messager.alert("修改失败！");     			
     		}
     	},"text"); 

	}

	$(function() {

		openPwd();

		$('#editpass').click(function() {
			$('#w').window('open');
		});
		/**
		修改密码
		*/
		$('#btnEp').click(function() {
			serverLogin();
		})

		$('#btnCancel').click(function() {
			closePwd();
		})

		$('#loginOut').click(function() {
			$.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {
				if (r) {
					location.href = '../user/loginMgr!loginOut.action';
				}
			});
		})
	});
	
	setInterval(function(){
		var now = (new Date()).toLocaleString();
		$('#current_time').text(now);
	},1000);
</script>

<style type="text/css">
.admin_txt {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #FFFFFF;
	text-decoration: none;
	height: 38px;
	line-height: 38px;
}
</style>

</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<noscript>
		<div
			style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
			<img src="images/noscript.gif" alt='抱歉，请开启脚本支持！' />
		</div>
	</noscript>
	<div region="north" split="true" border="false"
		style="overflow: hidden; height: 64px;
        background: url(images/top-right.gif);
        line-height: 38px;color: #fff; font-family: Arial, Helvetica, sans-serif">        
		<span style="float:right; padding-right:20px;" class="head">
			<a href="#" id="loginOut"><img src="images/out.gif" alt="安全退出" style="padding-top:12px; "></a>
		</span> 
		<span style="float:right;padding-right:20px;" class="head">欢迎${username}管理员 <a href="#" id="editpass">修改密码</a></span>
		<span id="current_time" style="float:right;padding-right:20px;" class="head"></span>
		<span style="float:left"><img src="images/logo.gif"></span>
	</div>
	<div region="south" split="true"
		style="height: 30px; background: #D2E0F2; ">
		<div class="footer">Copyright © 2015-**** 625456668@qq.com
			版权所有，翻版必究</div>
	</div>
	<div region="west" hide="true" split="true" title="导航菜单"
		style="width:180px;" id="west">
		<div id="nav" class="easyui-accordion" fit="true" border="false">
			<!--  导航内容 -->

		</div>
	</div>
	<div id="mainPanle" region="center"
		style="background: #eee; overflow-y:hidden">
		<div id="tabs" class="easyui-tabs" fit="true" border="false">
			<div title="欢迎使用" style="padding:20px;overflow:hidden;">
				<h1 style="font-size:24px;">欢迎使用仓库管理系统  1.0</h1>
				<div
					style="align:left;margin: 1 auto; text-align: left;font-size: 14px;">
					&nbsp;<img src="images/ts.gif" width="16" height="16" /> 提示：<br />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您现在使用的是SoFeelLove（lxf）开发的简易仓库管理系统！用于管理平时的进销存，入账信息。
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;此程序操作简单，易于掌握，只需会打字，会上网，就可以方便管理！<br />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;此程序是您进行信息管理的首选方案！ <br /> &nbsp;<img
						src="images/icon-mail2.gif" width="16" height="11" />
					联系邮箱：625456668@qq.com
				</div>

			</div>
		</div>
	</div>
	<div region="east" title="其他" split="true"
		style="width:180px;overflow:hidden;">
		<div class="easyui-calendar"></div>
	</div>

	<!--修改密码窗口-->
	<div id="w" class="easyui-window" title="修改密码" collapsible="false"
		minimizable="false" maximizable="false" icon="icon-save"
		style="width: 300px; height: 150px; padding: 5px;
        background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false"
				style="padding: 10px; background: #fff; border: 1px solid #ccc;">
				<table cellpadding=3>
					<tr>
						<td>新密码：</td>
						<td><input id="txtNewPass" type="password" class="txt01" />
						</td>
					</tr>
					<tr>
						<td>确认密码：</td>
						<td><input id="txtRePass" type="password" class="txt01" />
						</td>
					</tr>
				</table>
			</div>
			<div region="south" border="false"
				style="text-align: right; height: 30px; line-height: 30px;">
				<a id="btnEp" class="easyui-linkbutton" icon="icon-ok"
					href="javascript:void(0)"> 确定</a> <a id="btnCancel"
					class="easyui-linkbutton" icon="icon-cancel"
					href="javascript:void(0)">取消</a>
			</div>
		</div>
	</div>
	<div id="mm" class="easyui-menu" style="width:150px;">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>
</body>
</html>