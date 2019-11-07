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
    <title>新增订单</title>
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
<form id="form1" style="height: 1000px;width: 1000px;">

    <script>
        var keyValue = request('keyValue');
        var instanceId = "";
        var formId = "";
        $(function () {
            initControl();
        })
        //初始化控件
        function initControl() {
            //加载自定义表单
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "/zone/getBean.action",
                    param: {id: keyValue},
                    success: function (data) {
                        $("#form1").SetWebControls(data);
                    }
                });
            }
        }
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData = $("#form1").GetWebControls(keyValue);
            $.AJAXSubmit({
                url: "/zone/save.action",
                param: postData,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    } else if (data.type) {
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        dialogMsg(data.obj, 1);
                        dialogClose();//关闭窗口
                    } else {
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <div class="tab-content" style="padding-top: 15px;">
            <table class="form" width="5000px">
                <input id="id" name="id" type="hidden" value=""/>
                <input id="state" name="state" type="hidden" value=""/>
                <tr>
                    <td class="formValue">
                        <div class="checkbox user-select"> 提货
                            <label><input id="is_up" type="checkbox"/>是</label>
                            <label><input id="is_up" type="checkbox"/>否</label>
                        </div>
                    </td>

                    <td class="formTitle">业务类型<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="name" type="" class="form-control" placeholder="请输入区域名称" isvalid="yes"
                               checkexpession="NotNull"/>
                    </td>
                    <td class="formTitle">区域代码<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="code" type="text" class="form-control" placeholder="请输入区域代码" isvalid="yes"
                               checkexpession="NotNull"/>
                    </td>
                </tr>
                <tr>
                    <th class="formTitle" valign="top" style="padding-top: 4px;">备注
                    </th>
                    <td class="formValue" colspan="3">
                        <textarea id="description" class="form-control" style="height: 50px;"></textarea>
                    </td>
                </tr>
            </table>
            <div id="ExpandInfo" class="tab-pane ">
                <div class="app_layout app_preview" style="border-top: 1px solid #ccc;" id="frmpreview"></div>
            </div>
        </div>
    </div>
</form>
</body>
</html>