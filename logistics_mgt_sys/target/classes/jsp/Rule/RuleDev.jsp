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
    <script src="/Content/scripts/utils/monaco-editor/min/vs/loader.js"></script>
</head>
<body>
<form id="form1">

    <script>
        var editor
        var keyValue = request('keyValue');
        $(function () {

            //c初始化代码编辑器
            require.config({ paths: { 'vs': '/Content/scripts/utils/monaco-editor/min/vs' }});
            require(['vs/editor/editor.main'], function() { //默认异步 妈的
                editor = monaco.editor.create(document.getElementById('container'), {

                    language: 'java',
                    theme: "vs-dark",
                });
                if (!!keyValue) {
                    $.SetForm({
                        url: "/rule/selectBean.action",
                        param: {tableName: "JC_RULE", id: keyValue},
                        success: function (data) {
                            if(data.description !=null ){
                                editor.setValue(data.description);
                            }

                        }
                    });
                }
            });




        })
        //保存表单
        function AcceptClick() {
            $.SaveForm({
                url: "/rule/saveRuleData.action",
                param: {id:keyValue,data:editor.getValue()},
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {

                    }else if (data.type){
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
        <div id="container" style="width: 100%;height: 550px">
        </div>
    </div>
</form>
</body>
</html>