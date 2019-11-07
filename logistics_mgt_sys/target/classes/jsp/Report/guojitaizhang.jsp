<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/3/10
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>

<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>国际收购台账</title>
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet"/>
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
</head>
<body>
<form id="form1">

    <script>
        $(function () {
            initControl();
        })
        //初始化控件
        function initControl() {
            //加载自定义表单
            //获取表单


        }
        function queryReport(){
            //获取开始时间和结束时间
            var start = $("#start").val().substring(0,10);
            var end = $("#end").val().substring(0,10);
            var raq="3.raq"; //报表名称
            var getUrl = "reportJsp/showReport.jsp"//报表请求URL地址
            var url = getUrl+"?raq="+raq+"&arg1="+start+"&arg2="+end+"&arg3="+start+"&arg4="+end//拼接请求请求连接并传入GET参数
            dialogOpen({
                id: "guojitaizhang",
                title: '国际手工台账',
                url: url,
                width: "1200px",
                height: "1000px",
                btn:[],
            });

        }
        //保存表单
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#BaseInfo" data-toggle="tab">收购台账报表</a></li>
            <a id="lr-replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="lr-add" class="btn btn-default" onclick="queryReport()"><i class="fa fa-plus"></i>&nbsp;查询</a>
        </ul>
        <div class="tab-content" style="padding-top: 15px;">
            <table class="form">
                <input id="id" name="id" type="hidden" value=""/>
                <input id="state" name="state" type="hidden" value=""/>
                <tr>
                    <td class="formTitle">开始时间<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="start" type="text"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                    </td>
                    <td class="formTitle">结束时间<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="end" type="text"     readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                    </td>
                </tr>

            </table>

        </div>
    </div>
</form>
</body>
</html>