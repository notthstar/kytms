<%--
  Created by IntelliJ IDEA.
  User: cxl
  Date: 2018-4-11
  Time: 11:58
  订单在途追踪
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
    var id = request('id');
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
            url: "/transportorder/getAbnormalList.action?id="+id,
            datatype: "json",
            height: $(window).height() - 100,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '异常时间', name: 'time', width: 150, align: 'center'},
                {label: '修改数量', name: 'number', width: 80, align: 'center'},
                {label: '修改人', name: 'create_Name', width: 150, align: 'center'},
                {label: '修改原因', name: 'description', width: 200, align: 'center'},
                {label: '备注', name: '1', width: 150, align: 'center'}
            ],
            pager: false,
            rowNum: "1000",
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            subGrid: true,
            frozen:true,
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
                        {label: '字段名称', name: 'targer',width: 150, align: "center"},
                        {label: '原有数据', name: 'sourceValue', width: 100, align: 'center'},
                        {label: '替换数据', name: 'targerValue', width: 100, align: 'center'},
                        {label: '备注',  width: 100, align: 'center'},
                    ],
                    caption: "费用明细",
                    rowNum: "1000",
                    rownumbers: true,
                    shrinkToFit: false,
                    gridview: true,
                    hidegrid: false,

                });
            },
        });
    }
</script>
<div class="gridPanel">
    <table id="gridTable"></table>
</div>
</body>
</html>