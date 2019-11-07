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
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
</head>
<body>
<form id="form1">
    <script>
        //保存表单
        function AcceptClick() {
            var m1 =  $('#password').val();
            var m2 =  $('#password2').val();
            if(m1 != m2){
                alert("两次密码不一直");
                return
            }
//            if (!$('#form1').Validform()) {
//                return false;
//            }
            $.SaveForm({
                url: "user/upPassword.action",
                param: {str:$.md5($.trim(m1))},
                loading: "密码修改中……",
                success: function (data) {
                    if (data.result ==true) {
                        dialogMsg("密码修改成功", 1);
                        dialogClose();//关闭窗口
                        windows.reload();
                    } else{
                        alert("密码修改失败");
                    }
                }
            })
            // isvalid="yes" checkexpession="JQyz" 暂时把密码限制取消
        }
    </script>
    <div style="margin-top: 20px; margin-right: 30px;">
        <table class="form">
            <input id="id" name="id" type="hidden" value=""/>
            <tr>
                <th class="formTitle">修改密码<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="password" type="password" placeholder="1位大写数字+字母最少8位"  class="form-control" isvalid="yes" checkexpession="JQyz"  />
                </td>
            </tr>
            <tr>
                <th class="formTitle">再次输入<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="password2" type="password" placeholder="与上面密码一致" class="form-control"/>
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>
