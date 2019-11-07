<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/3/10
  Time: 9:27
  应收台账
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
    <title>应收台账</title>
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
    var accountStatue=request('accountStatue');
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
        initHigtQuery($("#btn_HigtSearch"),$('#gridTable'));
    }

    function getLedger(){
        var id = $("#gridTable").jqGridRowValue("a.id");
        if (checkedArray(id)) {
            return id;
        }
    }

    //加载表格
    function GetGrid() {
        var url="/orderledger/getOrderLengerList.action";
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        if(accountStatue!=null && accountStatue!=""){
            url="/orderledger/getOrderLengerList.action?status=0";
        }
        $gridTable.jqGrid({
            url:url,
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'a.id', hidden: true},
                {label: '所属组织机构Id', name: 'o.id', hidden: true},
                {label: '组织机构', name: 'o.name', width: 150, align: 'center'},
                {label: '订单号',selectDefault:true, name: 'b.code', width: 220, align: 'center'},
                {label: '订单号ID', name: 'a.order.id', hidden: true},
                {label: '订单日期', name: 'a.order.time', type:"date", width: 150, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '台账类型', name: 'a.type',type:"DD&Ledger", width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.Ledger['' + cellvalue + '']
                    }},
                {label: '数量', name: 's.number', width: 80, align: 'center'},
                {label: '重量', name: 's.weight', width: 80, align: 'center'},
                {label: '体积', name: 's.volume', width: 80, align: 'center'},
                {label: '应收金额', name: 'a.amount', width: 80, align: 'center'},
                {label: '税率', name: 'a.taxRate', width: 80, align: 'center'},
                {label: '税金', name: 'a.input', width: 80, align: 'center'},
                {label: "对账状态", name: "a.accountState",type:"DD&accountState", width: 90, align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.accountState['' + cellvalue + '']
                    }},
                {label: "结算状态", name: "a.jsStatus", width: 90, align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.JSZT['' + cellvalue + '']
                    }},
                {label: "结算码", name: "sts.code", width: 190, align: "center"},
            ],
            viewrecords: true,
            rowNum: 30,
            rowList: [30, 50, 100],
            pager: "#gridPager",
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            multiboxonly: true,
            multiselect:true,
            subGrid: true,
            subGridRowExpanded: function (subgrid_id, row_id) {
                var keyValue = $gridTable.jqGrid('getRowData', row_id)['a.id'];
                var subgrid_table_id = subgrid_id + "_t";
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "'></table>");
                $("#" + subgrid_table_id).jqGrid({
                    url: "/orderledger/getOrderLengerListDetail.action",
                    postData: {id: keyValue},
                    datatype: "json",
                    height: "100%",
                    colModel: [
                        {label: '主键', name: 'id', hidden: true},
                        {label: '费用名称', name: 'feeType.name', width: 150, align: 'center'},
                        {label: '费用代码', name: 'feeType.code', width: 150, align: 'center'},
                        {label: '金额', name: 'amount', width: 120, align: 'center'},
                        {label: '税率', name: 'taxRate', width: 90, align: 'center'},
                        {label: '税金', name: 'input', width: 90, align: 'center'},
                        {label: '备注', name: 'description', width: 80, align: 'center'},
                    ],
                    caption: "费用明细",
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
                    <a id="btn_HigtSearch" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;高级查询</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="Zone-replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
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