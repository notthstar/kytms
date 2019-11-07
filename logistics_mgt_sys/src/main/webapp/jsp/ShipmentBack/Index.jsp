<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/4 0004
  Time: 下午 7:23
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
    <title>运单回单</title>
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
            url: "/shipmentback/getShipmentBackList.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '运单ID', name: 'shipment.id', hidden: true},
                {label: '运单号',selectDefault:true, name: 'shipment.code', width: 220,align: 'center'},
                {label: '运单日期', name: 'shipment.time',type:"date", width: 150,align: 'center'},
                {label: '运输协议号', name: 'shipment.tan', width: 120,align: 'center'},
                {label: "状态", name: "status", width: 70,type:"DD&OrderStatus", align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    }},
                {label: "回单类型", name: "type", width: 90,type:"DD&type", align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.BackTypeDe['' + cellvalue + '']
                    }},
                {label: '共计回单份数', name: 'backNumber', width: 90,align: 'center'},
                {label: '共计签收份数', name: 'singNumber', width: 90,align: 'center'},
                {label: '签收完成日期', name: 'time',type:"date", type:"date",width: 150,align: 'center'},
                {label: '回单方式', name: 'backType', width: 80,type:"DD&BackType",align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.BackType['' + cellvalue + '']
                    }},
                {label: '回单完成时间', name: 'backTime',type:"date", width: 150,align: 'center'},
                {label: '快递名称', name: 'expressName', width: 150,type:"DD&Exppexx_type",align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                       if(cellvalue == undefined){
                           return "";
                       }
                        return top.clientdataItem.Exppexx_type['' + cellvalue + '']
                    }},
                {label: '快递单号', name: 'expressCode', width: 150,align: 'center'},
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
    /**
     * 签收登记
     */
    function sing(){
        var status = $("#gridTable").jqGridRowValue("status");
        for(var i in top.clientdataItem.OrderStatus){
            if(top.clientdataItem.OrderStatus[i] ==status){
                status=i
            }
        }
        if(status == '14'){
            dialogAlert("此运单无需签收", -1);
            return
        }
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "签收管理",
                title: '签收管理',
                url: 'jsp/ShipmentBack/Sing.jsp?keyValue=' + keyValue,
                width: "810px",
                height: "550px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    function back(){
        var status = $("#gridTable").jqGridRowValue("status");
        for(var i in top.clientdataItem.OrderStatus){
            if(top.clientdataItem.OrderStatus[i] ==status){
                status=i
            }
        }
        if(status == '14'){
            dialogAlert("此运单无需回单", -1);
            return
        }
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "回单管理",
                title: '回单管理',
                url: 'jsp/ShipmentBack/Back.jsp?keyValue=' + keyValue,
                width: "580px",
                height: "300px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    function end() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (keyValue) {
            $.RemoveForm({
                url: "/shipmentback/end.action",
                param: {ids: keyValue},
                msg: "请确定是否要完结此运单",
                loading: "正在完结运单...",
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
            dialogMsg('请选择完结数据！', 0);
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
            <a id="shipmentbacksing" class="btn btn-default" onclick="sing();"><i class="fa fa-refresh"></i>&nbsp;签收登记</a>
        </div>
        <div class="btn-group">
            <a id="shipmentbackback" class="btn btn-default" onclick="back();"><i class="fa fa-refresh"></i>&nbsp;回单登记</a>
        </div>
        <%--<div class="btn-group">--%>
            <%--<a id="shipmentbackend" class="btn btn-default" onclick="end();"><i class="fa fa-refresh"></i>&nbsp;运单完结</a>--%>
        <%--</div>--%>
        <script>$('.toolbar').authorizeButton()</script>
    </div>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
    <div id="gridPager"></div>
</div>
</body>
</html>
