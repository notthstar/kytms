<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/3/10
  Time: 9:27
  异常订单
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
    <meta name="viewport" content="width=device-width"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>订单异常单</title>
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet"/>
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
            url: "/abnormal/getOrderAbnormalList.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '所属组织机构Id', name: 'order.id', hidden: true},
                {label: '组织机构', name: 'organization.name', width: 160, align: 'center'},
                {label: '异常单日期', name: 'time', width: 150, align: 'center'},
                {label: "异常原因", name: "description", width: 300, align: "center"},
                {label: '修改数量', name: 'number', width: 80, align: 'center'},
                {label: '订单号',selectDefault:true, name: 'order.code', width: 220, align: 'center'},
                {label: '客户订单号', name: 'order.relatebill1', width: 180, align: 'center'},
                {label: '订单号ID', name: 'order.id', hidden: true},
                {label: '订单日期', name: 'order.time', type:"date", width: 150, align: 'center'},
                {label: '订单状态', name: 'order.status', width: 80, align: 'center',type:"DD&OrderStatus",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    }},
                {label: '创建人', name: 'create_Name', width: 120,align: 'center'},
                {label: '创建时间', name: 'create_Time',type:"date", width: 150,align: 'center'},
             /*   {label: '修改人', name: 'modify_Name', width: 120,align: 'center'},
                {label: '修改时间', name: 'modify_Time',type:"date", width: 150,align: 'center'},*/
            ],
            viewrecords: true,
            rowNum: 30,
            rowList: [30, 50, 100],
            pager: "#gridPager",
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            multiboxonly: true,
            subGrid: true,
            subGridRowExpanded: function (subgrid_id, row_id) {
                var keyValue = $gridTable.jqGrid('getRowData', row_id)['id'];
                var subgrid_table_id = subgrid_id + "_t";
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "'></table>");
                $("#" + subgrid_table_id).jqGrid({
                    url: "/abnormal/getOrderAbnormalDetailList.action",
                    postData: {id: keyValue},
                    datatype: "json",
                    height: "100%",
                    colModel: [
                        {label: '主键', name: 'id', hidden: true},
                        {label: '字段名称', name: 'source', width: 150, align: 'center'},
                        {label: '原始数据', name: 'sourceValue', width: 150, align: 'center'},
                        {label: '新数据', name: 'targerValue', width: 150, align: 'center'},
                        {label: '备注', name: 'description', width: 250, align: 'center'},
                    ],
                    caption: "修改明细",
                    rowNum: "1000",
                    rownumbers: true,
                    shrinkToFit: false,
                    gridview: true,
                    hidegrid: false
                });
            },
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            }
        });
        //$gridTable.authorizeColModel()
        //初始化查询条件
        //初始化查询页面
        initJGGridselectView($gridTable);
    }
    function btn_add() {
        dialogOpen({
            id: "AbnormalFrom",
            title: '添加异常单',
            url: 'jsp/OrderAbnormal/Form.jsp',
            width: "750px",
            height: "550px",
            btn: [],
        });
    };
</script>
<div class="titlePanel">
    <div  class="title-search">
        <table>
            <tr>
                <td>
                    <div   id="queryCondition" class="btn-group">
                        <a class="btn btn-default dropdown-text" data-value="code"
                           data-toggle="dropdown">编号</a>
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
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
        </div>
        <%--// <script>$('.toolbar').authorizeButton()</script>--%>
    </div>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
    <div id="gridPager"></div>
</div>
</body>
</html>