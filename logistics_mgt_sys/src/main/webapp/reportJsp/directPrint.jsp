<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

	<head>
		<title>直接打印</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<meta http-equiv='Expires' content='0' /> 
		<meta http-equiv='Pragma' content='No-cache' /> 
		<meta http-equiv='Cache-Control' content='No-cache' />
	</head>

	<body onload="directPrint()">
		<%
			String raq = request.getParameter("raq");
			String params = request.getParameter("params");
			String raqParams = request.getParameter("raqParams");
	
			String userAgent = request.getHeader("User-Agent");
			if (userAgent.indexOf("MSIE") != -1) {
				params = new String(params.getBytes("ISO8859-1"), "UTF-8");
				if (raqParams != null) {
					raqParams = new String(raqParams.getBytes("ISO8859-1"), "UTF-8");
					params += raqParams;
				}
			} else {
				if (raqParams != null) {
					params += raqParams;
				}
			}
	
// 			System.out.println("params: " + params);
	
			String needSelectPrinter = request.getParameter("needSelectPrinter");
			String printServiceName = request.getParameter("printServiceName");
			String appmap = request.getContextPath();
			String serverPort = String.valueOf(request.getServerPort());
			String serverName = request.getServerName();
			if (serverName.toLowerCase().equals("localhost")) {
				serverName = "127.0.0.1";
			}
			String appRoot = "http://" + serverName + ":" + serverPort + appmap;
	
// 			System.out.println(appRoot);
// 			System.out.println(printServiceName);
// 			System.out.println("GWT Frame Index: " + request.getParameter("directIndex"));
		
		%>
		
		<script language="javascript">
		
			var browserType = navigator.appName;
			
			if (browserType == 'Netscape') { // Firefox,Chrome
				document.write('<object id="report1_directPrintApplet" name="report1_directPrintApplet" type="application/x-java-applet"  height="0" width="0" archive="<%=appRoot%>/runqianReport4Applet.jar" classid="java:VtradexDirectPrintApplet.class"> ');
					document.write('<param name="appRoot" value="<%=appRoot%>" />');
					document.write('<param name="dataServlet" value="/reportServlet?action=1" />');
					document.write('<param name="reportParams" value="<%=params%>" />');
					document.write('<param name="fileName" value="<%=raq%>" />');
					document.write('<param name="printServiceName" value="<%=printServiceName%>" />');
					document.write('<param name="srcType" value="file" />');
					document.write('<param name="needSelectPrinter" value="<%=needSelectPrinter%>" />');
					document.write('<param name="mayscript" value="<%=false%>" />');
				document.write('</object>');
			} else if (browserType == 'Microsoft Internet Explorer') { // IE
				document.write('<applet archive="<%=appRoot%>/runqianReport4Applet.jar" ');
		    	document.write(' code="VtradexDirectPrintApplet.class" ');
		    	document.write(' id="report1_directPrintApplet" ');
		    	document.write(' name="report1_directPrintApplet" ');
		    	document.write(' width=0 height=0 hspace=0 vspace=0  ');
		    	document.write(' type="application/x-java-applet;version=1.6" ');
		    	document.write(' dataServlet="/reportServlet?action=1" ');
		    	document.write(' appRoot="<%=appRoot%>" ');
		    	document.write(' fileName="<%=raq%>" ');
		    	document.write(' reportParams="<%=params%>" ');
		    	document.write(' printServiceName="<%=printServiceName%>" ');
		    	document.write(' needSelectPrinter="<%=needSelectPrinter%>" ');
		    	document.write(' srcType="file" ');
		    	document.write(' mayscript="false"> ');
		    	document.write(' 您的浏览器不支持打印，请安装JRE 1.6');
			    document.write(' </applet>');
			} else {
				alert("不支持的浏览器");
			}
			
			function directPrint() {
				setTimeout(lazyPrintReport, 1000);
			}
	
			function lazyPrintReport() {
				var dpa = document.getElementById("report1_directPrintApplet");
				dpa.print();
			}
		</script>
	</body>
</html>