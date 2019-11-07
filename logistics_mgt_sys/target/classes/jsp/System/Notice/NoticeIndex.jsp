<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/4 0004
  Time: 下午 7:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>

<html>
<head>
    <base href="<%=basePath%>">
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>系统通告</title>
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
     /*   GetGrid();*/
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
            url: "/notice/getNoticeList.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '通告名称', name: 'name', width: 150, align: 'center'},
                {label: '通告代码', name: 'code', width: 150, align: 'center'},
                {label: '类型', name: 'type', width: 100,align: 'center' ,type:"DD&NoticeType",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.NoticeType['' + cellvalue + '']
                    }},
                {label: '发布时间', name: 'time', width: 150,align: 'center',type:"date"},
                {label: '正文', name: 'notice', width: 400,align: 'center'},
                {label: '创建人', name: 'create_Name', width: 120,align: 'center'},
                {label: '创建时间', name: 'create_Time', width: 150,align: 'center'},
                {label: '修改人', name: 'modify_Name', width: 120,align: 'center'},
                {label: '修改时间', name: 'modify_Time', width: 150,align: 'center'},
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
        //初始化查询页面
        initJGGridselectView($gridTable);
    }
    function btn_add() {
        dialogOpen({
            id: "NoticeForm",
            title: '通告添加',
            url: 'jsp/System/Notice/NoticeForm.jsp',
            width: "750px",
            height: "350px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick();
            }
        });
    };
    function btn_edit() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "NoticeForm",
                title: '通告编辑',
                url: 'jsp/System/Notice/NoticeForm.jsp?keyValue=' + keyValue,
                width: "750px",
                height: "350px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    function btn_delete() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (keyValue) {
            $.RemoveForm({
                url: "/notice/deleteBean.action",
                param: { tableName:"JC_SYS_NOTICE",id: keyValue },
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
            dialogMsg('请选择需要删除的公告！', 0);
        }
    }
</script>
<div class="titlePanel">
    <div class="title-search">
        <table>
            <tr>
                <td>
                    <div   id="queryCondition" class="btn-group">
                        <a class="btn btn-default dropdown-text" data-value="code"
                           data-toggle="dropdown">选择条件</a>
                        <a class="btn btn-default dropdown-toggle" data-toggle="dropdown"><span
                                class="caret"></span></a>
                        <ul  id="queryLi" class="dropdown-menu">
                        </ul>
                    </div>
                </td>
                <td id="keyWord" style="padding-left: 2px;">
                    <input  id="txt_Keyword" type="text" class="form-control" placeholder="请输入要查询关键字" style="width: 200px;"/>
                </td>
                <td style="padding-left: 5px;">
                    <a id="btn_Search" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;查询</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="Notice-replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="Notice-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
            <a id="Notice-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
            <a id="Notice-delete" class="btn btn-default" onclick="btn_delete()"><i class="fa fa-pencil-square-o"></i>&nbsp;删除</a>
        </div>
<%--        <div class="btn-group">
            <a id="driver-authorize" class="btn btn-default" onclick="btn_authorize()"><i class="fa fa-gavel"></i>&nbsp;角色授权</a>
            <a id="driver-dataAuthorize" class="btn btn-default" onclick="btn_dataAuthorize()"><i class="fa fa-gavel"></i>&nbsp;数据授权</a>
        </div>--%>
        <%--<script>$('.toolbar').authorizeButton()</script>--%>
    </div>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
    <div id="gridPager"></div>
</div>
</body>
</html>
