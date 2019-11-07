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
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet" />
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
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "databook/selectBean.action",
                    param: { tableName:"JC_SYS_DATA_DICTIONARY_DETAIL",id: keyValue },
                    success: function (data) {
                        $("#form1").SetWebControls(data);
                        $("#dataBook").val(data.dataBook.id);
                       // $("#value").val();
                    }
                });
            } else {
                $("#dataBook").val(parentId);
                $("#id").val(keyValue);

            }
        }
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData =$("#form1").GetWebControls(keyValue);
            postData["dataBook.id"] = $("#dataBook").val();
           // postData["value"] = JSON.stringify($("#value").val());
           // postData["value"]= $("#value").repalce(/\"/g, "");
           // postData["value"].$$replace(/\"/g, "");
            console.log(postData);

           // postData["value"]=$("value").val().replace(/\"/g, "");
            $.SaveForm({
                url: "databook/savaBookItem.action",
                param: postData,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    }else if (data.type){
                        $.currentIframe().$("#gridTable").resetSelection();
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        dialogMsg(data.obj, 1);
                        dialogClose();//关闭窗口

                    }else{
                        dialogAlert(data.obj, -1);
                        dialogClose();
                    }
                }
            })
        }
        //验证：项目值、项目名 不能重复
        function OverrideExistField(id, url) {
            $.ExistField(id, url, {itemId: itemId});
        }
    </script>
    <div style="margin-top: 20px; margin-right: 30px;">
        <input id="dataBook" name="dataBook.id" type="hidden"/>
        <input id="id" type="hidden"/>
        <table class="form">
            <tr>
                <td class="formTitle">字典名<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="name" type="text" class="form-control" placeholder="请输入字典名" isvalid="yes"
                           checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <td class="formTitle">字典值<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="value" name="value" type="text" class="form-control" placeholder="请输入字典值" isvalid="yes"
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
