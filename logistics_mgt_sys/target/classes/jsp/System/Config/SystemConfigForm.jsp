<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/4/7
  Time: 12:54
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
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet"/>
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <!--bootstrap组件end-->

    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/wizard/wizard.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/dialog/dialog.js"></script>
</head>
<body>
<form id="form1">
    <script>
        $(function () {
            initPage()
            //获取表单
        })
        function initPage(){
            $.SetForm({
                url: "/systemconfig/selectBean.action",
                param: {tableName:"JC_SYS_CONFIG", id: "root" },
                success: function (data) {
                    $("#form1").SetWebControls(data);
                }
            });
        }
        //保存表单
        function AcceptClick() {
            var postData = $("#form1").GetWebControls("root");
                $.SaveForm({
                url: "systemconfig/saveSystemConfig.action",
                param: postData,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    } else if (data.type) {
                        dialogMsg(data.obj, 1);
                        initPage();
                    } else {
                        dialogAlert(data.obj, -1);
                        dialogClose();
                    }
                }
            })
        }
    </script>
    <div style="margin-top: 30px; margin-right: 30px;">

        <table class="form" style="width: 400px">
            <input id="id" name="id" type="hidden" value=""/>
            <H2  style="text-align:center">系统设置</H2>
            <tr >
                <th class="formTitle">系统名称：<font face="宋体"  >*</font></th>
                <td class="formValue" >
                    <input id="systemName" type="text"  class="form-control"  maxlength="50" isvalid="yes" checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">公司名称：<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="companyName" type="text" class="form-control" isvalid="yes" maxlength="50" checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">金额省略位数：<font face="宋体">*</font></th>
                <td class="formValue" >
                    <input id="moneyRoundNumber" type="number" class="form-control" isvalid="yes" maxlength="2" checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">运量省略位数：<font face="宋体">*</font></th>
                <td class="formValue" >
                    <input id="trafficRoundNumber" type="number" class="form-control" isvalid="yes" maxlength="2"  checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">税金省略位数：<font face="宋体">*</font></th>
                <td class="formValue" >
                    <input id="inputRoundNumber" type="number" class="form-control" isvalid="yes" maxlength="2"  checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <td class="formValue" >
                    <div id="bottomField" style="margin-left: 300px">
                        <a id="savaAndAdd" class="btn btn-success" onclick="AcceptClick()">保存</a>
                    </div>
                </td>
            </tr>


        </table>
    </div>
</form>
</body>
</html>
