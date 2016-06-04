<%@ page language="java" import="com.hnepri.commons.Log"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.hnepri.commons.SpringContextUtil"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hnepri.base.db.dao.*" %>
<%@ page import="com.hnepri.commons.StringUtils" %>
<%
    String id = request.getParameter("lineId");
    CommonMapper commonMapper = (CommonMapper) SpringContextUtil.getBean("commonMapper");
    String sql = "select SVG from v_svg_file where devicedid='" + id +"'";
    List<HashMap> list = commonMapper.RunSql(sql);
    if(list!=null && list.size()>0)
    {
        HashMap map = list.get(0);
        String svgPath = StringUtils.NullToSpace(map.get("SVG"));
        String fileName = svgPath.contains("/") ?
                (svgPath.substring(svgPath.lastIndexOf("/") + 1) ) : "svg.svg";
        fileName = new String(fileName.getBytes("gbk"), "ISO-8859-1");
        String path = Log.getRootPath() + "\\";
        String realpath = path + "/cim/" + svgPath;
        response.reset();
        response.setContentType("application;charset=UTF-8");
        response.setHeader("content-disposition", "attachment;filename="+fileName);
        FileInputStream in = new FileInputStream(realpath);
        int len = 0;
        byte buffer[] = new byte[1024];
        OutputStream sout = response.getOutputStream();
        while ((len = in.read(buffer)) > 0) {
            sout.write(buffer, 0, len);
        }
        sout.flush();
        sout.close();
        in.close();
        out.clear();
        out = pageContext.pushBody();
    }

    %>