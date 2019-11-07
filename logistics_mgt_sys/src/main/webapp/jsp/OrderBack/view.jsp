<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/6
  Time: 9:27
  预录表单
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
    <title>预录表单</title>
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


    <%--图片--%>
    <script src="/Content/utils/imageGrid/images-grid.js"></script>
    <link rel="stylesheet" href="/Content/utils/imageGrid/images-grid.css">

</head>
<script>
    var keyValue = request('keyValue');
    $(function () {
        initControl();
    })
    //初始化控件
    function initControl() {
        $.SaveForm({
            url: "/orderback/getImages.action",
            param:{id:keyValue},
            loading: "正在保存数据...",
            success: function (data) {
                $('#gallery1').imagesGrid({
                    images:data
                    //     [
                    //     { src: '/images/upload/20190315/5ef6cc2ab03e475e952f1b39c81e64cb.png', alt: '123', title: '3321' },
                    // ]
                });

            }
        })


    }

</script>
<body>

<div id="gallery1"></div>

</body>
</html>