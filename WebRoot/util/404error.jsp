<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>温馨提示</title>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/JavaScript">
<!--
function doJavaScript() {
	history.back();
  }
//-->
</script>
<body onload="dialogWidth=33;dialogHeight=15;dialogTop=(screen.height-document.body.scrollHeight)/2-30;dialogLeft=(screen.width-document.body.scrollWidth)/2">
<br>
	<table width="300"  border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td height="20"  class="BiaoBg" align="left"> 
			<img src="<%=request.getContextPath()%>/images/1_r24_c7.jpg" width="8" height="10"> 操作失败.............................</td>
		</tr>
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tableBorder">
					<tr>
						<td class="pading" align="left">
							<br><br>

							<div align="center">
								<span class="l2">
									很抱歉，您访问的页面不存在！
									<BR><BR>
									<A href="#" onclick="doJavaScript()"><div align="center" class="formtitle">返回</div></A>
								</span>
							</div>
						</td>
					</tr>		                    
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
