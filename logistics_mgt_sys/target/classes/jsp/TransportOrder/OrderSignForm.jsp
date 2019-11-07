<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/7
  Time: 11:56
  To change this template use File | Settings | File Templates.
  自提作业单
--%>
<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/28
  Time: 18:28
  To change this template use File | Settings | File Templates.
  服务区域表单
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
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet" />
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <!--bootstrap组件end-->

    <%--   <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>--%>
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
        var keyValue = request('keyValue');
        $(function () {
            initControl();
        })

        //初始化控件
        function initControl() {
            //加载自定义表单
            //获取表单
//            if (!!keyValue) {
//                $.SetForm({
//                    url: "/serverZone/selectBean.action",
//                    param: { tableName:"JC_SERVER_ZONE",id: keyValue },
//                    success: function (data) {
//                        $("#form1").SetWebControls(data);
//                        $("#organization").ComboBoxSetValue(data.organization.id);
//                        $("#zone").ComboBoxSetValue(data.zone.id);
//                    }
//                });
//            }

        }
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            // var postData = $("#form1").GetWebControls(keyValue);
            var postData={
                id:keyValue,
                qsperson:$("#qsperson").val(),
                qsTime:$("#qsTime").val()
            }
            $.SaveForm({
                url: "/transportorder/setqsr.action",
                param: postData,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    }else if (data.type){
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        dialogMsg(data.obj, 1);
                        dialogClose();//关闭窗口
                    }else{
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }

    </script>
    <div id="111" style="margin-left: 10px; margin-right: 10px;">
        <table class="form">
            <input id="id" name="id" type="hidden" value="" />
            <tr>
                <td class="formTitle">收货人<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="qsperson" autocomplete="off" name="qsperson" type="text" class="form-control" isvalid="yes" checkexpession="NotNull"></input>
                </td>
                <td class="formTitle">时间<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="qsTime" autocomplete="off" name="qsTime" type="text"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"></input>
                </td>
            </tr>
            <tr>
                <td class="formTitle" valign="top" style="padding-top: 4px;">备注</td>
                <td class="formValue" colspan="3">
                    <textarea id="description" class="form-control" style="height: 50px;"></textarea>
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>