<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2017/12/04
  Time: 21:27
  收发货方表单
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
    <title>规则</title>
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
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/grid.locale-cn.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.js"></script>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-report.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-bill.css" rel="stylesheet"/>
</head>
<body>
<form id="form1">

    <script>
        var keyValue = request('keyValue');
        $(function () {
            if (!!keyValue) {
                $.SetForm({
                    url: "/rule/selectBean.action",
                    param: {tableName: "JC_RULE", id: keyValue},
                    success: function (data) {
                       // $("#zone").ComboBoxTreeSetValue(data.zone.id);
                        $("#form1").SetWebControls(data);
                    }
                });
            }else{

            }
        })
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData =$("#form1").GetWebControls(keyValue);
            $.SaveForm({
                url: "/rule/saveRule.action",
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
                        dialogClose();//关闭窗口
                    }
                }
            })
        }
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
            <table class="form">
                <input id="id" name="id" type="hidden" value="" />
                <tr>
                    <td class="formTitle">规则名称<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="code" type="text" autocomplete="off" class="form-control" placeholder="客户名称" isvalid="yes" checkexpession="NotNull" />
                    </td>
               </tr>
                <tr>
                    <th class="formTitle">规则</th>
                    <td class="formValue">
                        <textarea id="description" readonly type="text" style="width: 580px;height: 500px" class="form-control"></textarea>
                        <%--<input id="description" type="text" style="width: 500px;height: 50px" class="form-control" />--%>
                    </td>
                </tr>
            </table>
    </div>
</form>
</body>
</html>