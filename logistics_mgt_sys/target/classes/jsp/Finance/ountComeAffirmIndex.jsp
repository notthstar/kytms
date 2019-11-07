<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/2 0004
  Time: 下午 7:23
  成本确认
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
    <title>运单</title>
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
    var feeTypeData;//费用变量存储
    $(function () {
        InitialPage();
        GetGrid();
        initHigtQuery($("#btn_HigtSearch"),$('#gridTable'));
//        getFeeType()//初始化费用类型
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
            url: "/shipment/getLedgerList.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'ledgerDetails.id', hidden: true},
                {label: '所属组织机构', name: 'org.name', width: 90, align: 'center'},
                {label: '运单号',selectDefault:true, name: 'ship.code', width: 150, align: 'center'},
                {label: '运单日期', name: 'ship.time', width: 150,align: 'center', type:"date",
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '承运商名称', name: 'carr.name', width: 150,align: 'center'},
                {label: '台账类型', name: 'ledgerDetails.cost', width: 70,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.LedgerCost['' + cellvalue + '']
                    }},

                {label: '确认状态', name: 'ledgerDetails.is_inoutcome', width: 70,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.ConfirmStatus['' + cellvalue + '']
                    }},
                {label: '费用名称', name: 'feeType.name', width: 120,align: 'center'},
               /* {label: '线路', name: 'line.name', width: 120,align: 'center'},*/
//                {label: '装卸信息', name: 'ship.loadingInfo', width: 100,align: 'center'},
                {label: '金额', name: 'ledgerDetails.amount', width: 80,align: 'center'},
                {label: '税率', name: 'ledgerDetails.taxRate', width: 80,align: 'center'},
                {label: '税金', name: 'ledgerDetails.input', width: 80,align: 'center'},
                {label: '成本', name: 'ledgerDetails.outcome', width: 80,align: 'center'},
                {label: '创建人', name: 'ledgerDetails.create_Name', width: 120,align: 'center'},
                {label: '创建时间', name: 'ledgerDetails.create_Time', width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }}
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
            },
            ondblClickRow:function(a,b,c){
                btn_edit(  $gridTable.getCell(a,"ship.id"));
            },
        });

        //初始化查询页面
        initJGGridselectView($gridTable);
        $gridTable.jqGrid('setFrozenColumns');
    }



    //确认
    function confirmLedger(status) {
        var  keyValue = $("#gridTable").jqGridRowValue("ledgerDetails.id");
        var options ={
            width: "1180px",
            height: "550px",
        }
        var _width = top.$.windowWidth() > parseInt(options.width.replace('px', '')) ? options.width : top.$.windowWidth() + 'px';
        var _height = top.$.windowHeight() > parseInt(options.height.replace('px', '')) ? options.height : top.$.windowHeight() + 'px';
        if (checkedArray(keyValue)) {
            dialogOpen({
                id: "selectDate",
                title: '时间选择',
                url: '/jsp/Finance/SelectDate1.jsp?keyValue=' + keyValue,
                width: "310px",
                height: "240px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick(location);
                }
            });
          /*  $.ConfirmAjax({
                msg: "注：您确定要确认勾选的台账?",
                url: "/shipment/confirmLedger.action",
                param: { id:keyValue},
                success: function (data) {
                    if (data.result) {
                        dialogMsg(data.obj, 1);
                        $("#gridTable").trigger("reloadGrid");
                    } else {
                        dialogMsg(data.obj, -1);
                    }
                }
            })*/
        }
    }

    //反确认
    function backConfirmLedger(status) {
        var  keyValue = $("#gridTable").jqGridRowValue("ledgerDetails.id");
        if (checkedArray(keyValue)) {
            $.ConfirmAjax({
                msg: "注：您确定要反确认勾选的台账?",
                url: "/shipment/backConfirmLedger.action",
                param: { id:keyValue},
                success: function (data) {
                    if (data.result) {
                        dialogMsg(data.obj, 1);
                        $("#gridTable").trigger("reloadGrid");
                    } else {
                        dialogMsg(data.obj, -1);
                    }
                }
            })
        }
    }

    function sdfsdf() {
        $('#gridTable').jqGrid('setGridParam', {postData: {status:1},
            page: 1
        }).trigger('reloadGrid');
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
                    <a id="btn_history" class="btn btn-default" onclick="sdfsdf()"  style="margin-left: 25px">已确认单据</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
        <div class="btn-group">
            <a id="out-confirm" class="btn btn-default" onclick="confirmLedger()"><i class="fa fa-th"></i>&nbsp;确认</a>
        </div>
        <div class="btn-group">
            <a id="out-backConfirm" class="btn btn-default" onclick="backConfirmLedger()"><i class="fa fa-th"></i>&nbsp;反确认</a>
        </div>

        <script>$('.toolbar').authorizeButton()</script>
    </div>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
    <div id="gridPager"></div>
</div>
</body>
</html>
