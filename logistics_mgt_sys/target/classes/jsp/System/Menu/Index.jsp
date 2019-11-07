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
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>系统功能</title>
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <!--bootstrap组件end-->
    <script src="/Content/scripts/plugins/layout/jquery.layout.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.js"></script>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <style>
        html, body {
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<body>

<script>
    $(function () {
        InitialPage();
        GetTree();
        GetGrid();
    });
    //初始化页面
    function InitialPage() {
        //layout布局
        $('#layout').layout({
            applyDemoStyles: true,
            onresize: function () {
                $(window).resize()
            }
        });
        //resize重设(表格、树形)宽高
        $(window).resize(function (e) {
            window.setTimeout(function () {
                $('#gridTable').setGridWidth(($('.gridPanel').width()));
                $("#gridTable").setGridHeight($(window).height() - 141.5);
                $("#itemTree").setTreeHeight($(window).height() - 52);
            }, 200);
            e.stopPropagation();
        });
    }
    //加载树
    var _parentId = "";
    function GetTree() {
        var item = {
            height: $(window).height() - 52,
            url: "/menu/getMenuTree.action",
            onnodeclick: function (item) {
                _parentId = item.id;
                $('#btn_Search').trigger("click");
            }
        };
        //初始化
        $("#itemTree").treeview(item);
    }
    //加载表格
    function GetGrid() {
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: "/menu/getSysMenuGrid.action",
            datatype: "json",
            height: $(window).height() - 141.5,
            autowidth: true,
            colModel: [
                { label: "主键", name: "id", index: "id", hidden: true },
                { label: "编号", name: "code", index: "code", width: 150, align: "left" },
                { label: "名称", name: "name", index: "name", width: 150, align: "left" },
                { label: "地址", name: "url", index: "url", width: 300, align: "left" },
                { label: "目标", name: "target", index: "target", width: 60, align: "center" },
                { label: "排序", name: "orderBy", index: "orderBy", width: 50, align: "center" },
                { label: "描述", name: "description", index: "description", width: 120, align: "left" }
            ],
            pager: false,
            rowNum: "1000",
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            }
        });
        //查询条件
        $("#queryCondition .dropdown-menu li").click(function () {
            var text = $(this).find('a').html();
            var value = $(this).find('a').attr('data-value');
            $("#queryCondition .dropdown-text").html(text).attr('data-value', value)
        });
        //查询事件
        $("#btn_Search").click(function () {
            $gridTable.jqGrid('setGridParam', {
                url: "/menu/getSysMenuGrid.action",
                postData: {
                    id: _parentId,
                    whereName: $("#queryCondition").find('.dropdown-text').attr('data-value'),
                    whereValue: $("#txt_Keyword").val()
                }
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
        dialogOpen({
            id: "Form",
            title: '添加功能',
            url: 'jsp/System/Menu/Form.jsp',
            width: "700px",
            height: "430px",
            btn: null
        });
    };
    //编辑
    function btn_edit() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "Form",
                title: '编辑功能',
                url: 'jsp/System/Menu/Form.jsp?keyValue=' + keyValue,
                width: "700px",
                height: "430px",
                btn: null
            });
        }
    }
    //删除
    function btn_delete() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (keyValue) {
            $.RemoveForm({
                url: "/menu/deleteBean.action",
                param: {tableName:"JC_SYS_MENU", id: keyValue},
                success: function (data) {
                    GetTree()
                    $("#gridTable").trigger("reloadGrid");
                    if (data.type) {
                        dialogMsg(data.obj, 1);
                    } else {
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        } else {
            dialogMsg('请选择需要删除的数据项！', 0);
        }
    }
</script>
<div class="ui-layout" id="layout" style="height: 100%; width: 100%;">
    <div class="ui-layout-west">
        <div class="west-Panel">
            <div class="panel-Title">功能目录</div>
            <div id="itemTree"></div>
        </div>
    </div>
    <div class="ui-layout-center">
        <div class="center-Panel">
            <div class="panel-Title">功能信息</div>
            <div class="titlePanel">
                <div class="title-search">
                    <table>
                        <tr>
                            <td>
                                <div id="queryCondition" class="btn-group">
                                    <a class="btn btn-default dropdown-text" data-value="code" data-toggle="dropdown">编号</a>
                                    <a class="btn btn-default dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a data-value="code" >编号</a></li>
                                        <li><a data-value="name">名称</a></li>
                                        <li><a data-value="url">地址</a></li>
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
                        <a id="lr-replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
                        <a id="lr-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
                        <a id="lr-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
                        <a id="lr-delete" class="btn btn-default" onclick="btn_delete()"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
                    </div>
                </div>
            </div>
            <div class="gridPanel">
                <table id="gridTable"></table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
