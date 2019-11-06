<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/24 0024
  Time: 上午 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--@java_start--%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%--@java_end--%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>行政区域授权</title>
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
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/wizard/wizard.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
</head>
<body>
<form id="form1">

    <script type="text/javascript">
        var roleId = request('id');
        $(function () {
            initialPage();
            GetModuleTree();
        })
        //初始化页面
        function initialPage() {
            //加载导向
            //数据权限 、点击类型触发事件
            $("input[name='authorizeType']").click(function () {
                var value = $(this).val();
                if (value == -5) {
                    $("#OrganizeTreebackground").hide();
                } else {
                    $("#OrganizeTreebackground").show();
                }
            })
        }
        //获取系统功能
        function GetModuleTree() {
            var item = {
                height: 540,
                showcheck: true,
                url: "org/getZoneTree.action?roleId=" + roleId,
                onnodeclick: function (item) {
                    _parentId = item.id;
                }
            };
            $("#ModuleTree").treeview(item);
        }
        function AcceptClick(){
            var selectedData = $("#ModuleTree").getCheckedAllNodes();
            selectedData =selectedData.join(",");
            $.SaveForm({
                url: "/org/saveZone.action",
                param: {id:roleId,ids:selectedData},
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
                        dialogClose();
                    }
                }
            })
        }


        //获取数据范围权限选中值、返回Json
        function GetDataAuthorize() {
            var dataAuthorize = [];
            var authorizeType = $("input[name='authorizeType']:checked").val();
            if (authorizeType == -5) {
                var selectedData = $("#OrganizeTree").getCheckedAllNodes();
                for (var i = 0; i < selectedData.length; i++) {
                    var ResourceId = selectedData[i];
                    var IsRead = $("input[name='" + ResourceId + "']:checked").val() == 1 ? 1 : 0;
                    var rowdata = {
                        ResourceId: ResourceId,
                        IsRead: IsRead,
                        AuthorizeType: -5
                    }
                    dataAuthorize.push(rowdata);
                }
            } else {
                var rowdata = {
                    IsRead: 0,
                    AuthorizeType: authorizeType
                }
                dataAuthorize.push(rowdata);
            }
            return dataAuthorize;
        }
    </script>
    <div class="widget-body">
        <div id="wizard" class="wizard" data-target="#wizard-steps" style="border-left: none; border-top: none; border-right: none;">
            <ul class="steps">
                <li data-target="#step-1" class="active"><span class="step">*</span>角色列表<span class="chevron"></span></li>
            </ul>
        </div>
        <div class="step-content" id="wizard-steps" style="border-left: none; border-bottom: none; border-right: none;">
            <div class="step-pane active" id="step-1">
                <div id="ModuleTree" style="margin: 10px;"></div>
            </div>
        </div>
    </div>
</form>
</body>
</html>