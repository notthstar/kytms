<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/3/10
  Time: 9:27
  用户管理表单
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
    <title>用户管理</title>
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
</head>
<body>
<form id="form1">

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
                    url: "/user/selectBean.action",
                    param: { tableName:"JC_SYS_USER",id: keyValue },
                    success: function (data) {
                        $("#form1").SetWebControls(data);
//                          $("#password").val("*****************");
//                          $("#password").attr('disabled',true);
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
            postData["password"] = "11111111";

            $.SaveForm({
                url: "/user/saveUser.action",
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
    <div style="margin-left: 10px; margin-right: 10px;">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#BaseInfo" data-toggle="tab">基本信息</a></li>
        </ul>
        <div class="tab-content" style="padding-top: 15px;">
                <table class="form">
                    <input id="id" name="id" type="hidden" value="" />
                    <input id="status" name="status" type="hidden" value="" />
                    <tr>
                        <th class="formTitle">账户<font face="宋体">*</font></th>
                        <td class="formValue">
                            <input id="code" type="text" class="form-control" placeholder="请输入账户" isvalid="yes" checkexpession="NotNull" />
                        </td>
                        <th class="formTitle">姓名<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input id="name" type="text" class="form-control" />
                        </td>
                        <%--&lt;%&ndash;<th class="formTitle">密码<font face="宋体">*</font></td>&ndash;%&gt;--%>
                        <%--<td class="formValue">--%>
                            <%--<input id="password" type="hidden" class="form-control" />--%>
                        <%--</td>--%>
                    </tr>
                    <tr>
                        <th class="formTitle">手机</th>
                        <td class="formValue">
                            <input id="phone" type="text" class="form-control" isvalid="yes" checkexpession="MobileOrNull"/></td>
                        <th class="formTitle">邮箱</th>
                        <td class="formValue">
                            <input id="email" type="text" class="form-control"/></td>

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