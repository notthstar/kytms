<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2019-08-05
  Time: 13:40
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
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>hello</title>
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/Content/scripts/plugins/layout/jquery.layout.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jqgrid/grid.locale-cn.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.js"></script>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
</head>
<body>
<script type="text/javascript">
    var keyValue = request('keyValue');
    function uploadFile(){
       // var form = new FormData(document.getElementById("program_form"));
       var csvfile = $.trim($("#upload_file").val()).split("\\")[2];
        var formData = new FormData();
        var name = $("#upload_file").val();
        formData.append("file",$("#upload_file")[0].files[0]);
        formData.append("name",csvfile);
        $.ajax({
            type:"post",
            data:formData,
            processData:false,
            contentType:false,
            url: "/ruletable/ruletableUpload.action?tableName="+keyValue,
            success: function (data) {
                if (data.result) {
                    dialogMsg(data.obj, 1);
                    dialogClose();
                 //    $.currentIframe().$("#gridTable").trigger("reloadGrid");
                 //    AcceptClick().reload();
                 // //   $("#gridTable").trigger("reloadGrid");
                } else {
                    dialogMsg(data.obj, -1);

                }
            }
        })
    }

</script>
<form id="program_form" action="/transportorder/ruletableUpload.action" method="post" enctype="multipart/form-data">
    <table>
        <%--<tr><td colspan="3">--%>
            <%--<a href="/Excels/KYTMS订单导入模板.xlsx" id="downloadModel" name="downloadModel" style="color: #00a65a; margin-left:7px;"><u style="font-size:26px;">点击下载订单导入模板</u>--%>
            <%--</a>--%>
        <%--</td>--%>
        <%--</tr>--%>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3">
                文件选择：<input type="file" id="upload_file" name="fileupload"/>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <%--<tr> 此方法也可以成功--%>
        <%--<td colspan="3">--%>
        <%--<input type="submit" value="导入"/>--%>
        <%--</td>--%>
        <%--</tr>--%>
        <%--此方法传到后台的是 ShiroHttpServletRequest 需要用--%>
        <%--<tr>--%>
        <%--<div class="toolbar">--%>
        <%--<div class="btn-group">--%>
        <%--<div>--%>
        <%--<a id="orderEx" class="btn btn-default"  onclick="AcceptClick()"><i class="fa fa-refresh"></i>&nbsp;订单导入</a>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</tr>--%>
    </table>
</form>
<button type="button" onclick="uploadFile()" style="margin-left:50px;"> &nbsp;上 传 &nbsp; </button>
<%--<form id="uploadForm" target="frameFile" class="bs-docs-example form-horizontal" method="post"--%>
<%--action="/transportorder/orderFileupload.action" enctype="multipart/form-data">--%>
<%--<input type="hidden" name="method" value="insertUserInfo">--%>
<%--<table cellpadding="0" cellspacing="0" border="0" style="width:600px;margin:20px auto;text-algin:left;">--%>
<%--<tr><td colspan="4"><input id="dyId" type="hidden"/></td></tr>--%>
<%--<tr><td colspan="3"><a href="/Excels/KYTMS订单导入模板.xlsx" id="downloadModel1" name="downloadModel" style="margin-left:7px;"><u>点击下载订单导入模板</u></a></td></tr>--%>
<%--<tr><td colspan="4"><br/></td></tr>--%>
<%--<tr><td colspan="3"><input id="files" name="files" type="file" style="width:200px;"/></td></tr><!-- background:url('/center/images/uploadImg.png') no-repeat 0px 10px; -->--%>
<%--<tr><td colspan="4"><br/></td></tr>--%>
<%--<tr>--%>
<%--<td colspan="4" style="text-align: center;">--%>
<%--<hr style="width:720px;border-width: 0.3px;margin-left:-10px;">--%>
<%--<input id="tiJiao" type="submit" class="czbtn" style="width:100px;font-size: 16px;">导入</input>--%>
<%--</td>--%>
<%--</tr>--%>
<%--</table>--%>
<%--</form>--%>
<form>
    <div id="light" class="white_content">
        <div class="close" style="margin-left:0px;">
            <span style="font-size:16px;color:red;margin-right:390px;">数据导入情况分析：</span>
        </div>
        <div class="con">
            <table class="table table-bordered table-hover" id="msgTable">
                <thead>
                <tr>
                    <th>总条数</th>
                    <th>成功数</th>
                    <th>失败数</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
    <div class="black_overlay">
        <table  id="fade">
            <tr>
                <th></th>
            </tr>
        </table>
    </div>

</form>

</body>
</html>


