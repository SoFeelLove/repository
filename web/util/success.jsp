<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>温馨提示</title>
		<link href="../css/style.css" rel="stylesheet" type="text/css" />
	</head>

	<script type="text/JavaScript">
function doJavaScript() {
	<s:if test="Gjs!=null && Gjs != ''">
		<s:property value="Gjs"/>
	</s:if>
	<s:else>
		history.back();
	</s:else>
  }

</script>
	<body
		onload="dialogWidth=33;dialogHeight=15;dialogTop=(screen.height-document.body.scrollHeight)/2-30;dialogLeft=(screen.width-document.body.scrollWidth)/2">
		<br>
<!--
		<div align="center">
			<table width="300" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td height="20" class="BiaoBg" align="left">
						<img src="../images/1_r24_c7.jpg" width="8" height="10">
						操作成功.............................
					</td>
				</tr>
				<tr>
					<td valign="top">
						<table width="100%" border="0" cellspacing="1" cellpadding="0"
							class="tableBorder">
							<tr>
								<td class="pading" align="left">
									<br>
									<br>

									<div align="center">
										<span class="l2"> <s:property value="Gmessage" /> <BR>
											<BR>  <A href="#" onclick="doJavaScript()"><div
													align="center" class="formtitle">
													返回
												</div>
										</A> </span>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div> -->
<script type="text/javascript">
<!--

//top.openSimpleTip('提示信息','<s:property value="Gmessage"/>',window,'doJavaScript');
top.openSimpleTip('提示信息','${Gmessage}',window,'doJavaScript');
//-->
</script>
	</body>
</html>
