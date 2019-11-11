<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/10/29
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/7
  Time: 16:21
  To change this template use File | Settings | File Templates.
  车辆到站
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
    <title>车辆到站</title>
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
    var status = request('status');
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
        var url="/vehicleRecord/show";
        $gridTable.jqGrid({
            url:url ,
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '所属组织机构', name: 'name', width: 100, align: 'center'},
                {label: '运单号',selectDefault:true, name: 'code', width: 150, align: 'center',
                    cellattr:function addCellAttr(rowId, val, rawObject, cm, rdata) {
                        if(rawObject[24] == 1 ){
                            return "style='color:red'";
                        }
                    }},
                {label: '运单日期', name: 'time', width: 80,align: 'center', type:"date",
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '出发站点', name: 'organName1', width: 80,align: 'center'},
                {label: '当前站', name: 'organName2', width: 80,align: 'center'},
                {label: '下一站', name: 'organName3', width: 80,align: 'center'},
                {label: '目的站点', name: 'organName4', width: 80,align: 'center'},
                {label: '订单号', name: 'orderCode', width: 230, align: 'center'},
                {label: '客户订单号', name: 'relateBill', width: 200, align: 'center'},
                {label: "状态", name: "status", index:"ship.status",width: 70, align: "center",type:"DD&OrderStatus"
                    // formatter: function (cellvalue, options, rowObject) {
                    //     return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    // }
                    },
                {label: '运作模式', name: 'operationPattern', width: 90,align: 'center',type:"DD&OperationPattern"
                    // formatter: function (cellvalue, options, rowObject) {
                    //     return top.clientdataItem.OperationPattern['' + cellvalue + '']
                    // }
                    },
                {label: '承运商名称', name: 'carName', width: 150,align: 'center'},
                {label: '承运商类型', name: 'carrierType', width: 90,align: 'center'
                    // formatter: function (cellvalue, options, rowObject) {
                    //     return top.clientdataItem.CarrierType['' + cellvalue + '']
                    // }
                    },
                {label: '车牌号', name: 'liens', width: 120,align: 'center'},
                {label: '司机名称', name: 'outDriver', width: 120,align: 'center'},
                {label: '是否超期', name: 'carriageIsExceed', width: 70,align: 'center'
                    // formatter: function (cellvalue, options, rowObject) {
                    //     return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    // }
                    },
                {label: '运输协议号', name: 'tan', width: 120,align: 'center'},
                {label: '数量', name: 'number', width: 80,align: 'center'},
                {label: '重量', name: 'weight', width: 80,align: 'center'},
                {label: '体积', name: 'volume', width: 80,align: 'center'},
                {label: '货值', name: 'value', width: 80,align: 'center'},
                {label: '创建人', name: 'createName', width: 120,align: 'center'},
                {label: '创建时间', name: 'createTime', width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '修改人', name: 'modifyName', width: 120,align: 'center'},
                {label: '修改时间', name: 'modifyTime', width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},


                {label: '异常', name: 'isAbnormal', hidden: true},
                {label: "状态", name: "status",hidden: true},
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
                btn_edit(  $gridTable.getCell(a,"id"));
            },
        });

        //初始化查询页面
        initJGGridselectView($gridTable);
        $gridTable.jqGrid('setFrozenColumns');
    }
    function btn_print(id){
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("id");
        }else {
            keyValue = id
        }
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "shipmentForm",
                title: '打印',
                url: '/jsp/RoadVehicles/vehicleArrivePrint.jsp?keyValue=' + keyValue,
                width: "1150px",
                height: "750px",
                callBack: function (iframeId) {
                    var obj = top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    function btn_export(){
        var  keyValue = $("#gridTable").jqGridRowValue("ship.id");
        //获取开始时间和结束时间
        <%--var xmmc ='${orgId.id}';--%>
        <%--var start = $("#start").val().substring(0,10);--%>
        <%--var end = $("#end").val().substring(0,10);--%>
        var raq="导出运单配载表.raq"; //报表名称
        var getUrl = "reportJsp/showReport.jsp"//报表请求URL地址
        var url = getUrl+"?raq="+raq+"&id="+keyValue//拼接请求请求连接并传入GET参数
        dialogOpen({
            id: "daochu",
            title: '配载信息导出',
            url: url,
            width: "1000px",
            height: "600px",
            btn:[],
        });
    }

</script>
<div class="titlePanel">
    <div class="title-search">
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="vehicleinfo-print" class="btn btn-default" onclick="btn_print()"><i class="fa fa-arrow-down"></i>&nbsp;打印</a>
            <a id="vehicleinfo-export1" class="btn btn-default" onclick="btn_export()"><i class="fa fa-arrow-down"></i>&nbsp;导出</a>
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
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
