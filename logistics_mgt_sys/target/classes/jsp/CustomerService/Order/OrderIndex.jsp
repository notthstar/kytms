<%--
  Created by IntelliJ IDEA.
  User: 孙德增
  Date: 2017/11/20 0020
  Time: 下午 1:43
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
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>订单信息</title>
    <!--框架必需start-->
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
    <style>
        body {
            margin: 10px;
            margin-bottom: 0px;
        }
    </style>
</head>
<body>

<script>
    $(function () {
        InitialPage();
        GetGrid();
    });
    //初始化页面
    function InitialPage() {
        //resize重设(表格、树形)宽高
        $(window).resize(function (e) {
            window.setTimeout(function () {
                $('#gridTable').setGridWidth(($('.gridPanel').width()));
                $("#gridTable").setGridHeight($(window).height() - 136.5);
            }, 200);
            e.stopPropagation();
        });
    }
    //加载表格
    function GetGrid() {
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: "/role/getRoleList.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '是否提货', name: 'name', width: 100, align: 'center'},
                {label: '业务类型', name: 'code', width: 100, align: 'center'},
                {label: '结算方式', name: 'code', width: 100, align: 'center'},
                {label: '客户订单号', name: 'code', width: 100, align: 'center'},
                {label: '订单日期', name: 'code', width: 100, align: 'center'},
                {label: '订单状态', name: 'code', width: 100, align: 'center'},
                {label: '出发站', name: 'code', width: 100, align: 'center'},
                {label: '目的站', name: 'code', width: 100, align: 'center'},
                {label: '合同是否超期', name: 'code', width: 100, align: 'center'},
                {label: '件数', name: 'code', width: 100, align: 'center'},
                {label: '体积', name: 'code', width: 100, align: 'center'},
                {label: '重量', name: 'code', width: 100, align: 'center'},
                {label: '发货人', name: 'code', width: 100, align: 'center'},
                {label: '发货单位', name: 'code', width: 100, align: 'center'},
                {label: '发货电话', name: 'code', width: 100, align: 'center'},
                {label: '收货人', name: 'code', width: 100, align: 'center'},
                {label: '收货单位', name: 'code', width: 100, align: 'center'},
                {label: '收货电话', name: 'code', width: 100, align: 'center'},
                {label: '回单状态', name: 'code', width: 100, align: 'center'},
                {label: '制单人', name: 'code', width: 100, align: 'center'},
                {label: "备注", name: "description", width: 140, align: "center"}
            ],
            viewrecords: true,
            rowNum: 30,
            rowList: [30, 50, 100],
            pager: "#gridPager",
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            multiselect: true,//复选框
            multiboxonly: true,
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            }
        });
        //$gridTable.authorizeColModel()
        //查询条件
        $("#queryCondition .dropdown-menu li").click(function () {
            var text = $(this).find('a').html();
            var value = $(this).find('a').attr('data-value');
            $("#queryCondition .dropdown-text").html(text).attr('data-value', value)
        });
        //查询事件
        $("#btn_Search").click(function () {
            var whereName= $("#queryCondition").find('.dropdown-text').attr('data-value');
            var whereValue= $("#txt_Keyword").val();
            $gridTable.jqGrid('setGridParam', {
                postData: { whereName: whereName,whereValue:whereValue }, page: 1
            }).trigger('reloadGrid');
        });
        //查询回车
        $('#txt_Keyword').bind('keypress', function (event) {
            if (event.keyCode == "13") {
                $('#btn_Search').trigger("click");
            }
        });
    }
    //新增
    function btn_add() {
        top.tablist.newTab({ id: "Form", title: "新增订单", closed: true, icon: "fa fa fa-user", url: top.contentPath+"jsp/CustomerService/Order/OrderForm.jsp" })
//        dialogContent({
//            id: "Form",
//            title: '新增订单',
//            url: 'jsp/CustomerService/Order/OrderForm.jsp',
//            width: "650px",
//            height: "420px",
//            callBack: function (iframeId) {
//                top.frames[iframeId].AcceptClick();
//            }
//        });
    };
    //编辑
    function btn_edit() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "Form",
                title: '修改订单',
                url: '/jsp/RBAC/Role/Form.jsp?keyValue=' + keyValue,
                width: "650px",
                height: "350px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    //删除
    function btn_delete() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (keyValue) {
            $.RemoveForm({
                url: "/role/deleteBean.action",
                param: { tableName:"JC_SYS_ROLE",id: keyValue },
                success: function (data) {
                    $("#gridTable").trigger("reloadGrid");
                    if (data.type) {
                        dialogMsg(data.obj, 1);
                    } else {
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        } else {
            dialogMsg('请选择需要删除的角色！', 0);
        }
    }
    //导出
    function btn_export() {
        $("#gridTable").ExportToExcel("export.xlsx");
    }
    //禁用
    function btn_disabled(keyValue) {
        if (keyValue == undefined) {
            keyValue = $("#gridTable").jqGridRowValue("id");
        }
        if (keyValue) {
            $.ConfirmAjax({
                msg: "注：您确定要【禁用】角色？",
                url: "/role/disabledRole.action",
                param: { id: keyValue },
                success: function (data) {
                    $("#gridTable").trigger("reloadGrid");
                    if (data.type) {
                        dialogMsg(data.obj, 1);
                    } else {
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }
    }
    //用户状态修改(生效、失效)
    function btn_Update(status) {
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        if (keyValue) {
            $.ConfirmAjax({
                msg: "注：您确定要修改账户状态？",
                url: "/role/updateStatus.action",
                param: { tableName:"JC_SYS_ROLE",id:keyValue,status:status},
                success: function (data) {
                    $("#gridTable").trigger("reloadGrid");
                    if (data.type) {
                        dialogMsg(data.obj, 1);
                    } else {
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }
    }
    function btn_authorize() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "selectFucntion",
                title: '菜单授权',
                url: 'jsp/RBAC/Role/SelectTree.jsp?id=' + keyValue,
                width: "700px",
                height: "690px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    function btn_buttonhorize() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "selectButtonFucntion",
                title: '按钮授权',
                url: 'jsp/RBAC/Role/SelectButtonTree.jsp?id=' + keyValue,
                width: "700px",
                height: "690px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
</script>
<div class="titlePanel">
    <div class="title-search">
        <table>
            <tr>
                <td>
                    <div id="queryCondition" class="btn-group">
                        <a class="btn btn-default dropdown-text" data-toggle="dropdown">选择条件</a>
                        <a class="btn btn-default dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a data-value="code">角色代码</a></li>
                            <li><a data-value="name">角色名称</a></li>
                            <li><a data-value="state">状态</a></li>
                            <li><a data-value="description">备注</a></li>
                        </ul>
                    </div>
                </td>
                <td style="padding-left: 2px;">
                    <input id="txt_Keyword" type="text" class="form-control" placeholder="请输入要查询关键字" style="width: 200px;" />
                </td>
                <td style="padding-left: 5px;">
                    <a id="btn_Search" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;查询</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="role-replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="role-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
            <a id="role-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
            <a id="role-delete" class="btn btn-default" onclick="btn_delete()"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
            <a id="role-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                <i class="fa fa-reorder"></i>&nbsp;更多<span class="caret"></span>
            </a>
            <ul class="dropdown-menu pull-right">
                <li id="role-export"><a onclick="btn_export()"><i></i>&nbsp;导出Excel</a></li>
                <li id="role-disabled"><a onclick="btn_Update(0)"><i></i>&nbsp;失效账户</a></li>
                <li id="role-enabled"><a onclick="btn_Update(1)"><i></i>&nbsp;生效账户</a></li>
            </ul>
        </div>
        <div class="btn-group">
            <a id="role-authorize" class="btn btn-default" onclick="btn_authorize()"><i class="fa fa-gavel"></i>&nbsp;菜单授权</a>
            <a id="role-buttonhorize" class="btn btn-default" onclick="btn_buttonhorize()"><i class="fa fa-th"></i>&nbsp;按钮授权</a>
        </div>

        <%--<script>$('.toolbar').authorizeButton()</script>--%>
    </div>

</div>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
    <div id="gridPager"></div>
</div>
</body>
</html>