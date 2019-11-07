
<%--
  Created by IntelliJ IDEA.
  User:孙德增
  Date: 2017/12/04
  Time: 21:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>

<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet" />
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
    <script src="/Content/scripts/utils/jet-pinyin.js"></script>
</head>
<body>
    <script>
        var keyValue = request('keyValue');
        var shipment = request('shipment');
        //初始化控件
        $(function () {
        });
        //保存表单
        function AcceptClick(win) {
            if ($("#time").val() == null || $("#time").val() == undefined ||$("#time").val() ==""){
                ValidationMessage($("#time"),"请选择时间")
                return
            }
            $.ConfirmAjax({
                msg: "注：您确定要确认勾选的台账?",
                url: "/shipment/confirmLedger.action",
                param: { id:keyValue,time:$("#time").val()},
                success: function (data) {
                    if (data.result) {
                        dialogMsg(data.obj, 1);
                        $("#gridTable").trigger("reloadGrid");
                        win.reload();
                        dialogClose();//关闭窗口
                    } else {
                        dialogMsg(data.obj, -1);
                    }
                }
            })

        }
    </script>
            <table class="form">
                <tr >
                    <th style="padding-top: 60px;" class="formTitle">时间选择：<font face="宋体"></font></th>
                    <td class="formValue" style="padding-top: 60px">
                        <input id="time" type="text"  placeholder="请选时间" readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                </tr>
            </table>
</body>
</html>