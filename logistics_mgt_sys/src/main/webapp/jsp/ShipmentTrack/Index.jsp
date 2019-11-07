<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/4 0004
  Time: 下午 7:23
  运单追踪
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
    <title>运单追踪</title>
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
        initHigtQuery($("#btn_HigtSearch"),$('#gridTable'));
    }
    //加载表格
    function GetGrid() {
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: "/shipment/getShipmentList.action",
            datatype: "json",
            height: $(window).height() - 136.5,

            autowidth: true,
            colModel: [
                {label: '主键', name: 'ship.id',frozen:true, hidden: true},
                {label: '所属组织机构', name: 'org.name', width: 120,frozen:true, align: 'center'},
                {label: '运单号',selectDefault:true, name: 'ship.code', width: 230,frozen:true, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        if(rowObject[25] ==1){
                            return '<a onclick=\"openAb(\'' + rowObject[0]+'\')\" class=\"label label-danger\" style=\"cursor: pointer;\">'+cellvalue+'</a>';
                        }else {
                            return cellvalue;
                        }

                    }},
                {label: '运单日期', name: 'ship.time', width: 150,align: 'center',frozen:true, type:"date",
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: "状态", name: "status", index:"ship.status",width: 70,frozen:true, align: "center",type:"DD&OrderStatus",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    }},
                {label: '车牌号', name: 'cph', width: 120,frozen:true,align: 'center'},
                {label: '出发站点', name: 'forg.name', width: 120,align: 'center'},
                {label: '当前站', name: 'norg.name', width: 120,align: 'center'},
                {label: '下一站', name: 'ntorg.name', width: 120,align: 'center'},
                {label: '目的站点', name: 'torg.name', width: 120,align: 'center'},
                {label: '订单号', name: 'ship.orderCode', width: 230, align: 'center'},
                {label: '客户订单号', name: 'ship.relatebill1', width: 200, align: 'center'},
                {label: '运作模式', name: 'ship.operationPattern', width: 90,align: 'center',type:"DD&OperationPattern",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OperationPattern['' + cellvalue + '']
                    }},
                {label: '承运商名称', name: 'carr.name', width: 150,align: 'center'},
                {label: '承运商类型', name: 'carrierType', width: 90,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CarrierType['' + cellvalue + '']
                    }},
                {label: '是否超期', name: 'carriageIsExceed', width: 70,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '运输协议号', name: 'ship.tan', width: 120,align: 'center'},
                /* {label: '线路', name: 'line.name', width: 120,align: 'center'},*/
//                {label: '装卸信息', name: 'ship.loadingInfo', width: 100,align: 'center'},
                {label: '数量', name: 'ship.number', width: 80,align: 'center'},
                {label: '重量', name: 'ship.weight', width: 80,align: 'center'},
                {label: '体积', name: 'ship.volume', width: 80,align: 'center'},
                {label: '货值', name: 'ship.value', width: 80,align: 'center'},
                {label: '创建人', name: 'ship.create_Name', width: 120,align: 'center'},
                {label: '创建时间', name: 'ship.create_Time', width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '修改人', name: 'ship.modify_Name', width: 120,align: 'center'},
                {label: '修改时间', name: 'ship.modify_Time', width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},


                {label: '异常', name: 'isAbnormal', hidden: true},
                {label: "状态", name: "st",hidden: true},
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
            frozen:true,
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            },
            loadComplete: function() {

            },
            ondblClickRow:function(a,b,c){
                btn_view( $gridTable.getCell(a,"id"))
            },
        });

        //初始化查询页面
        initJGGridselectView($gridTable);
        $gridTable.jqGrid('setFrozenColumns');
    }
    function btn_view(id){
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("ship.id");
        }else {
            keyValue = id
        }
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "ViewForm",
                title: '查看在途信息',
                url: 'jsp/ShipmentTrack/ViewForm.jsp?keyValue=' + keyValue,
                width: "1050px",
                height: "600px",
                btn: [],
            });
        }
    }

</script>
<div class="titlePanel">
    <div  class="title-search">
        <table>
            <tr>
                <td>
                    <div   id="queryCondition" class="btn-group">
                        <a class="btn btn-default dropdown-text" data-value="code"
                           data-toggle="dropdown">选择查询</a>
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
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
        </div>
        <div class="btn-group">
            <a id="shuomenttrack-despatch" class="btn btn-default" onclick="btn_view()"><i class="fa fa-play"></i>&nbsp;查看在途信息</a>
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
