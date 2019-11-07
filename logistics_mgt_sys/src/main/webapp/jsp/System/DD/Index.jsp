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
    <title>数据字典</title>
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
                $("#gridTable").setGridHeight($(window).height() - 141);
                $("#itemTree").setTreeHeight($(window).height() - 52);
            }, 200);
            e.stopPropagation();
        });
    }
    //加载树
    var id = "";
    var _itemName = "";
    var _isTree = "";
    function GetTree() {
        var item = {
            height: $(window).height() - 52,
            url: "databook/getDataBookList.action",
            onnodeclick: function (item) {
                id = item.id;
                _itemName = item.text;
                _isTree = item.isTree;
                $("#titleinfo").html(_itemName + "(" + item.value + ")");
                $("#txt_Keyword").val("");
                $('#btn_Search').trigger("click");
            }
        };
        //初始化
        $("#itemTree").treeview(item);
    }
    //加载表格
    function GetGrid() {
        var selectedRowIndex = 0;
        var $gridTable = $("#gridTable");
        $gridTable.jqGrid({
            datatype: "json",
            height: $(window).height() - 141,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {
                    label: '&nbsp;&nbsp;&nbsp;&nbsp;字典名称',
                    name: 'name',
                    index: 'name',
                    width: 200,
                    align: 'left',
                    sortable: false
                },
                {label: '字典值', name: 'value', index: 'value', width: 200, align: 'left', sortable: false},
                {label: '排序', name: 'orderBy', index: 'orderBy', width: 80, align: 'center', sortable: false},
                {label: "备注", name: "description", index: "description", width: 200, align: "left", sortable: false}
            ],
            rowNum: "10000",
            rownumbers: true,
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
                url: "databook/getDataBookItemList.action",
                postData: {
                    id: id,
                    condition: $("#queryCondition").find('.dropdown-text').attr('data-value'),
                    keyword: $("#txt_Keyword").val()
                },
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
        if (!id) {
            dialogMsg("请选择一个字典进行维护", 6);
            return false;
        }
        var parentId = id
        dialogOpen({
            id: "Form",
            title: '添加字典',
            url: 'jsp/System/DD/Form.jsp?parentId=' + id,
            width: "500px",
            height: "370px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick();
            }
        });
    };
    //编辑
    function btn_edit() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "Form",
                title: '编辑字典',
                url: 'jsp/System/DD/Form.jsp?keyValue=' + keyValue,
                width: "500px",
                height: "370px",
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
                url: "databook/deleteBean.action",
                param: {tableName:"JC_SYS_DATA_DICTIONARY_DETAIL",id: keyValue},
                success: function (data) {
                    if (data.type) {
                        dialogMsg(data.obj, 1);
                        $("#gridTable").resetSelection();
                        $("#gridTable").trigger("reloadGrid");
                    } else {
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        } else {
            dialogMsg('请选择需要删除的字典！', 0);
        }
    }
    //字典分类
    function btn_datacategory() {
        dialogOpen({
            id: "DataItemSort",
            title: '字典分类',
            url: 'jsp/System/DD/TypeIndex.jsp',
            width: "800px",
            height: "500px",
            btn: null
        });
    }
</script>
<div class="ui-layout" id="layout" style="height: 100%; width: 100%;">
    <div class="ui-layout-west">
        <div class="west-Panel">
            <div class="panel-Title">字典分类</div>
            <div id="itemTree"></div>
        </div>
    </div>
    <div class="ui-layout-center">
        <div class="center-Panel">
            <div class="panel-Title">
                字典数据
            </div>
            <div class="titlePanel">
                <div class="toolbar">
                    <div class="btn-group">
                        <a id="btn_Search" ></a>
                        <a id="lr-replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
                        <a id="lr-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
                        <a id="lr-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
                        <a id="lr-delete" class="btn btn-default" onclick="btn_delete()"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
                    </div>
                    <div class="btn-group">
                        <a id="lr-datacategory" class="btn btn-default" onclick="btn_datacategory()"><i class="fa fa-tags"></i>&nbsp;字典分类</a>
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
