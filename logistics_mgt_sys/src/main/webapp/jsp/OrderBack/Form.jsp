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
    <title>上传回单</title>
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



    <!-- 引用控制层插件样式 -->
    <link rel="stylesheet" href="/Content/scripts/driver/control/css/zyUpload.css" type="text/css">
    <!-- 引用核心层插件 -->
    <script src="/Content/scripts/driver/core/zyFile.js"></script>
    <!-- 引用控制层插件 -->
    <script src="/Content/scripts/driver/control/js/zyUpload.js"></script>

</head>
<script>
    var keyValue = request('keyValue');
    $(function () {
        initControl();
    })
    //初始化控件
    function initControl() {
// 初始化插件
        $("#demo").zyUpload({
            width            :   "650px",                 // 宽度
            height           :   "400px",                 // 宽度
            itemWidth        :   "120px",                 // 文件项的宽度
            itemHeight       :   "100px",                 // 文件项的高度
            url              :   "/orderback/uploadDri.action?id="+keyValue,   // 上传文件的路径
            multiple         :   true,                    // 是否可以多个文件上传
            dragDrop         :   false,                    // 是否可以拖动上传文件
            del              :   true,                    // 是否可以删除文件
            finishDel        :   true,  				  // 是否在上传文件完成后删除预览
            /* 外部获得的回调接口 */
            onSelect: function(files, allFiles){                    // 选择文件的回调方法
                console.info("当前选择了以下文件：");
                console.info(files);
                console.info("之前没上传的文件：");
                console.info(allFiles);
            },
            onDelete: function(file, surplusFiles){                     // 删除一个文件的回调方法
                console.info("当前删除了此文件：");
                console.info(file);
                console.info("当前剩余的文件：");
                console.info(surplusFiles);
            },
            onSuccess: function(file){                    // 文件上传成功的回调方法
                console.info("此文件上传成功：");
                console.info(file);
            },
            onFailure: function(file){                    // 文件上传失败的回调方法
                console.info("此文件上传失败：");
                console.info(file);
            },
            onComplete: function(responseInfo){           // 上传完成的回调方法
                console.info("文件上传完成");
                console.info(responseInfo);
            }
        });


        // $('#gallery1').imagesGrid({
        //     images: [
        //         'imgs/1.jpg',
        //         { src: 'imgs/2.jpg', alt: 'Second image', title: 'Second image' },
        //         'imgs/3.jpg',
        //         { src: 'imgs/4.jpg', caption: 'Beautiful forest' },
        //         'imgs/5.jpg',
        //         'imgs/6.jpg'
        //     ]
        // });

    }

</script>
<body>

<div id="gallery1"></div>
<h1 style="text-align:center;">回单上传</h1>

<div id="demo" class="demo"></div>
</body>
</html>