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
    <title>额</title>
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
        var keyValue = request('keyValue');
        var parentId = request('parentId');

        $(function () {
            initControl();
        })
        //初始化控件
        function initControl() {
            //上级$("[id='"+id+"']")
            $("#dataBook").ComboBoxTree({
                url: "databook/getTree.action",
                description:"==请选择==",
                param: {tableName:"JC_SYS_DATA_DICTIONARY"},
                height: "230px"
            });
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "databook/selectBean.action",
                    param: {tableName:"JC_SYS_DATA_DICTIONARY",id: keyValue},
                    success: function (data) {
                        $("#form1").SetWebControls(data);
                        $("#dataBook").ComboBoxTreeSetValue(data.dataBook.id);
                    }
                });
            } else {
                $("#dataBook").ComboBoxTreeSetValue(parentId);
            }
        }
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData = $("#form1").GetWebControls(keyValue);
            if (postData["dataBook.id"] == "" || postData["dataBook.id"] == undefined || postData["dataBook.id"] == null) {
                postData["dataBook"] = {
                    id:"root",
                }
            }else{
                postData["dataBook"] = postData["dataBook"] = {
                    id:postData["dataBook.id"],
                }}
            $.SaveForm({
                url: "databook/saveDataBook.action",
                param: {tableName:"JC_SYS_DATA_DICTIONARY",obj: JSON.stringify(postData)},
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    } else if (data.type) {
                        dialogMsg(data.obj, 1);
                        dialogClose();//关闭窗口
                        top.DataItemSort.$("#gridTable").resetSelection();
                        top.DataItemSort.$("#gridTable").trigger("reloadGrid");
                    } else {
                        dialogAlert(data.obj, -1);
                        dialogClose();
                    }
                }
            })
        }
    </script>
    <div style="margin-top: 20px; margin-right: 30px;">

        <table class="form">
            <input id="id" name="id" type="hidden" value=""/>
            <tr>
                <th class="formTitle">上级</th>
                <td class="formValue">
                    <div id="dataBook" name="dataBook.id" type="selectTree" class="ui-select"></div>
                </td>
            </tr>
            <tr>
                <td class="formTitle">名称<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="name" type="text" class="form-control" placeholder="请输入名称" isvalid="yes"
                           checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <td class="formTitle">编号<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="code" type="text" class="form-control" placeholder="请输入编号" isvalid="yes"
                           checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">排序<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="orderBy" type="text" class="form-control" isvalid="yes" checkexpession="Num"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle" style="height: 37px;"></th>
  <%--              <td class="formValue">
                    <div class="checkbox">
                        <label>
                            <input id="state" type="checkbox" checked="checked"/>
                            有效
                        </label>
                    </div>
                </td>--%>
            </tr>
            <tr>
                <th class="formTitle" valign="top" style="padding-top: 4px;">备注
                </th>
                <td class="formValue">
                    <textarea id="description" class="form-control" style="height: 70px;"></textarea>
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>
