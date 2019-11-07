<%@ page contentType="text/html;charset=gb2312" %>
<%@ taglib uri="/WEB-INF/report/runqianReport4.tld" prefix="report"%>
<%@ page session="true"  import="java.lang.StringBuffer,com.runqian.report4.usermodel.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.view.*"%>
<%@ page import="com.runqian.base4.util.*"%>

<html>
<head>
<title>是否打印</title>
<LINK rel="stylesheet" type="text/css" href="styles.css">
<style type="text/css">
<!--
.style1 {
    font-size: 18px;
    color: #0000FF;
}
-->
</style>
<style>
a{TEXT-DECORATION:none}.style3 {
    font-size: 16px;
    font-family: "宋体";
    color: #0000FF;
}
.style4 {color: #666666}
.style5 {font-size: 14pt}
.style6 {color: #0000FF}
.style7 {color: #000000}
.style15 {font-family: "华文新魏"}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"></head>
<body onload="directPrint()">
<div align="center">
  <%
    request.setCharacterEncoding( "GBK" );
    String raq = request.getParameter("raq");
    String path = request.getContextPath();
    System.out.println(path);
%>
  
  <object classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"    codebase="<%=path%>/j2re-1_4_1-windows-i586-i.exe#Version=1,4,1,0"    width="40" height="16" id="report1_directPrintApplet" name="report1_directPrintApplet" style="vertical-align:middle">    
          <param name="name" value="report1_directPrintApplet">    
          <param name="code" value="VtradexDirectPrintApplet.class">    
          <param name="archive" value="../runqianReport4Applet.jar">    
          <param name="type" value="application/x-java-applet;version=1.4">    
          <param name="appRoot" value="<%=path%>">    
          <param name="dataServlet" value="/reportServlet?action=1">    
        
        
        
	  <param name="fileName" value="<%=raq%>">
    <param name="srcType" value="file">    
    <param name="scriptable" value="true">
    <param name="reportParams" value="arg1=abc;arg2=123">
  </object>
       
    <script language=javascript>

    function directPrint(){
	document.report1_directPrintApplet.print();
    }
  </script>
</div>
<input type="button" name="DirectPrint" value="DirectPrint" onclick="directPrint()">
</body>
</html>