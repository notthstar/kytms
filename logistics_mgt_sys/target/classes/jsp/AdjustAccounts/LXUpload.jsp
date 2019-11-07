<%--
  Created by IntelliJ IDEA.
  User: 孙德增
  Date: 2018/5/15
  Time: 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/plugins/dialog/dialog.js"></script>
    <link href="/Content/scripts/plugins/uploadify/uploadify.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/uploadify/uploadify.extension.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/uploadify/jquery.uploadify.min.js"></script>
</head>
<body>
<script>
    var keyValue = request('keyValue');
    $(function () {
        uploadify();
    })
    //上传文件
    function uploadify() {
        $("#uploadify").uploadify({
            method: 'post',
            uploader: top.contentPath+'serverZone/lxupload.action',
            swf: top.contentPath + '/Content/scripts/plugins/uploadify/uploadify.swf',
            buttonText: "添加文件",
            height: 30,
            width: 90,
            auto:false,
            fileObjName : 'file',
            fileTypeExts: '*.xls; *.xlsx;',
            removeCompleted: false,
            onSelect: function (file) {
                $("#" + file.id).prepend('<div style="float:left;width:50px;margin-right:2px;"><img src="/Content/images/filetype/' + file.type.replace('.', '') + '.png" style="width:40px;height:40px;" /></div>');
                $('.border').hide();
            },
            onUploadSuccess: function (file,mse) {
                var obj = JSON.parse(mse)
                if(obj.result){
                    $("#" + file.id).find('.uploadify-progress').remove();
                    $("#" + file.id).find('.data').html('上传成功！');
                    $("#" + file.id).prepend('<a class="succeed" title="成功"><i class="fa fa-check-circle"></i></a>');
                }else {
                    $("#" + file.id).removeClass('uploadify-error');
                    $("#" + file.id).find('.uploadify-progress').remove();
                    $("#" + file.id).find('.data').html('上传失败！'+obj.obj);
                    $("#" + file.id).prepend('<span class="error" title="失败"><i class="fa fa-exclamation-circle"></i></span>');
                }
                Loading(false);
            },
            onUploadError: function (file) {
                $("#" + file.id).removeClass('uploadify-error');
                $("#" + file.id).find('.uploadify-progress').remove();
                $("#" + file.id).find('.data').html(' 很抱歉，上传失败！');
                $("#" + file.id).prepend('<span class="error" title="失败"><i class="fa fa-exclamation-circle"></i></span>');
            }
        });
        $("#uploadify-button").prepend('<i style="opacity: 0.6;" class="fa fa-cloud-upload"></i>&nbsp;');
        //$(document).scrollTop(300);
    }
    function AcceptClick(){
        $('#uploadify').uploadify('upload', '*');
    }
</script>
<div style="margin: 10px">
    <div style="height: 38px;">
     <input id="uploadify" name="upload" type="file" />
    </div>
    <div class="border" style="height: 295px; border-radius: 5px;">
        <div class="drag-tip" style="text-align: center; padding-top: 100px;">
            <h1 style="color: #666; font-size: 20px; font-family: Microsoft Yahei; padding-bottom: 2px;">试试将电脑里的文件拖拽到此上传</h1>
            <p style="color: #666; font-size: 12px;">
                （您的浏览器不支持此拖拽功能）
            </p>
        </div>
    </div>
</div>
</body>
</html>
