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
    String params=request.getParameter("params");
    System.out.println("raq:" + raq);
    System.out.println("params:" + params);
    String appmap = request.getContextPath();
    String serverPort = String.valueOf( request.getServerPort() );
    String serverName = request.getServerName();
    String appRoot = "http://" + serverName + ":" + serverPort + appmap;
%>
   <APPLET 
		ARCHIVE="<%=appRoot%>/runqianReport4Applet.jar" 
		CODE="VtradexDirectPrintApplet.class" 
		id = "report1_directPrintApplet" 
		NAME = "report1_directPrintApplet" 
		WIDTH = 0 HEIGHT = 0 
		HSPACE = 0 VSPACE = 0 
		type="application/x-java-applet;version=1.6"
		appRoot="<%=appRoot%>"
		dataServlet="/reportServlet?action=1"
		reportParams="<%=params%>"
		fileName="<%=raq%>"
		srcType="file"
		needSelectPrinter="yes"
		MAYSCRIPT="false"> 
		Your browser does not support Java... 
</APPLET>

    <script language=javascript>

    function directPrint(){
	document.report1_directPrintApplet.print();
    }
  </script>
</div>
</body>
</html>