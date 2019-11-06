<%@ page import="java.io.PrintWriter"%>
<%@ page contentType="text/html;charset=gb2312" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

	<head>
		<title>多任务直接打印 - 按顺序打印</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<meta http-equiv='Expires' content='0' /> 
		<meta http-equiv='Pragma' content='No-cache' /> 
		<meta http-equiv='Cache-Control' content='No-cache' />
	</head>
	
	<body onload="directPrint()">
		<%
			request.setCharacterEncoding( "GBK" );
			
		  	String originalReport = request.getParameter( "report" );
		  	String beSupportIds = request.getParameter( "beSupportIds" );
		  	
		  	if( originalReport == null || originalReport.trim().length() == 0 ) {
		  		throw new Exception( "report参数不能为空. 格式为：report={xxx.raq}{xxx.raq(arg1=1;arg2=2)}{yyy.raq(arg1=1;arg2=2)}...." );
		  	}
		  	StringBuffer buffer = new StringBuffer("");
		  	String[] raqArray = originalReport.split(";");
		  	for (String raqs : raqArray) {
		  		String[] raq = raqs.split(":");
		  		if (beSupportIds.equals("yes")) {
		  			buffer.append("{" + raq[0] + ".raq(id=" + raq[1]  + ")}");
		  		} else {
		  			String[] ids = raq[1].split(",");
		  			for (String id : ids) {
			  			buffer.append("{" + raq[0] + ".raq(id=" + id  + ")}");
			  		}
		  		}
		  	}
		  	String report = buffer.toString();
		  	
		  	String prompt = request.getParameter( "p" );
		  	if (prompt == null || prompt.trim().length() == 0) {
		  		prompt = "no";
		  	}
		  	
		    String printServiceName = request.getParameter("printServiceName");
			
		  	String appmap = request.getContextPath();
		  	String serverPort = String.valueOf( request.getServerPort() );
			String serverName = request.getServerName();
			if(serverName.toLowerCase().equals("localhost")){
		    	serverName = "127.0.0.1";
		    }
			String appRoot = "http://" + serverName + ":" + serverPort + appmap;
			
// 			System.out.println(">>>> originalReport: " + originalReport);
// 			System.out.println(">>>> report: " + report);
// 			System.out.println(">>>> prompt: " + prompt);
// 			System.out.println(">>>> printServiceName: " + printServiceName);
// 			System.out.println(">>>> appRoot: " + appRoot);
// 			System.out.println(">>>> directIndex: " + request.getParameter( "directIndex" ));
		%>
		
		<script language="javascript">
		
			var browserType = navigator.appName;
			
			if (browserType == 'Netscape') { // Firefox,Chrome
				document.write('<object id="report1_multiDirectPrintApplet" name="report1_multiDirectPrintApplet" type="application/x-java-applet"  height="0" width="0" archive="<%=appRoot%>/runqianReport4Applet.jar" classid="java:VtradexDirectPrintApplet.class"> ');
					document.write('<param name="appRoot" value="<%=appRoot%>" />');
					document.write('<param name="dataServlet" value="/reportServlet?action=1" />');
					document.write('<param name="reportParams" value="null" />');
					document.write('<param name="fileName" value="<%=report%>" />');
					document.write('<param name="printServiceName" value="<%=printServiceName%>" />');
					document.write('<param name="srcType" value="file" />');
					document.write('<param name="needSelectPrinter" value="<%=prompt%>" />');
					document.write('<param name="mayscript" value="<%=false%>" />');
				document.write('</object>');
			} else if (browserType == 'Microsoft Internet Explorer') { // IE
				document.write('<applet archive="<%=appRoot%>/runqianReport4Applet.jar" ');
		    	document.write(' code="VtradexDirectPrintApplet.class" ');
		    	document.write(' id="report1_multiDirectPrintApplet" ');
		    	document.write(' name="report1_multiDirectPrintApplet" ');
		    	document.write(' width=0 height=0 hspace=0 vspace=0  ');
		    	document.write(' type="application/x-java-applet;version=1.6" ');
		    	document.write(' dataServlet="/reportServlet?action=1" ');
		    	document.write(' appRoot="<%=appRoot%>" ');
		    	document.write(' fileName="<%=report%>" ');
		    	document.write(' reportParams="null" ');
		    	document.write(' printServiceName="<%=printServiceName%>" ');
		    	document.write(' needSelectPrinter="<%=prompt%>" ');
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
				var dpa = document.getElementById("report1_multiDirectPrintApplet");
				dpa.print();
			}
		</script>
	</body>
</html>