<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2019/1/3
  Time: 14:41
  To change this template use File | Settings | File Templates.
  外包作业单
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
    <title>外包作业单</title>
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
    function openAb(id){
        dialogOpen({
            id: "OrderAblist",
            title: '修改异常',
            url: 'jsp/Shipment/ShipmentAblist.jsp?id=' + id,
            width: "1150px",
            height: "750px",
            btn:[],
        });
    }
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
            url: "/shipment/getShipmentList.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'ship.id', hidden: true},
                {label: '所属组织机构', name: 'org.name', width: 90, align: 'center'},
                {label: '运单号',selectDefault:true, name: 'ship.code', width: 150, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        if(rowObject[26] ==1){
                            return '<a onclick=\"openAb(\'' + rowObject[0]+'\')\" class=\"label label-danger\" style=\"cursor: pointer;\">'+cellvalue+'</a>';
                        }else {
                            return cellvalue;
                        }

                    }},
                {label: '运单日期', name: 'ship.time', width: 150,align: 'center', type:"date",
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: "状态", name: "status", index:"ship.status",width: 70, align: "center",type:"DD&OrderStatus",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    }},
                {label: '车牌号', name: 'cph', width: 80,align: 'center'},
                {label: '出发站点', name: 'forg.name', width: 80,align: 'center'},
                {label: '当前站', name: 'norg.name', width: 80,align: 'center'},
                {label: '下一站', name: 'ntorg.name', width: 80,align: 'center'},
                {label: '目的站点', name: 'torg.name', width: 80,align: 'center'},
                {label: '总金额', name: 'led.amount', width: 60,align: 'center'},
                {label: '订单号', name: 'ship.orderCode', width: 230, align: 'center'},
                {label: '客户订单号', name: 'ship.relatebill1', width: 200, align: 'center'},
                {label: '运作模式', name: 'ship.operationPattern', width: 40,align: 'center',type:"DD&OperationPattern",
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
//                {label: "结算状态", name: "ship.jsStatus", width: 150,align: 'center',
//                    formatter: function (cellvalue, options, rowObject) {
//                        return top.clientdataItem.JSZT['' + cellvalue + '']
//                    }},
//                {label: "结算CODE", name: "slt.code", width: 150,align: 'center'}
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
            subGrid: true,
            subGridRowExpanded: function (subgrid_id, row_id) {
                function isInteger(obj) {
                    reg =/^[-\+]?\d+(\.\d+)?$/;
                    if (!reg.test(obj)) {
                        return false;
                    } else {
                        return true;
                    }
                }
                var numberValidator = function(val, nm){
                    var boolean = isInteger(val)
                    if(boolean){
                        return [true,parseFloat(val)];
                    }
                    return  [false,"请输入正确数字"];
                }
                var keyValue = $gridTable.jqGrid('getRowData', row_id)['ship.id'];
                var status = $gridTable.jqGrid('getRowData', row_id)['st']

                var subgrid_table_id = subgrid_id + "_t";
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "'></table>");
                var cellEdit = false;
                if (status == 1){
                    cellEdit = true
                }
                $("#" + subgrid_table_id).jqGrid({
                    url: "/shipment/getFreeList.action",
                    postData: {id: keyValue},
                    datatype: "json",
                    height: "100%",
                    cellEdit:cellEdit,
                    cellurl:"/orderledger/editFree.action",
                    colModel: [
                        {label: '主键', name: 'id', hidden: true},
                        {label: '费用名称', name: 'feeType.name',width: 150, align: 'center',
                        },
                        {label: '税率', name: 'taxRate', width: 100, align: 'center'},
                        {label: '金额', name: 'amount', width: 100, align: 'center' },
                        {label: '税金', name: 'input', width: 100, align: 'center'},
//
                        {label: '备注', name: 'description', width: 300, align: 'center'},
                        {label: '  ', name: '', width: 150, align: 'center'}
                    ],
                    caption: "费用明细",
                    rowNum: "1000",
                    rownumbers: true,
                    shrinkToFit: false,
                    gridview: true,
                    hidegrid: false,
                    afterSaveCell:function(rowid, cellname, value, iRow, iCol){
                        //计算税率
                        var rowData = $(this).getRowData(rowid)
                        var taxRate = parseFloat(rowData.amount / (1 + parseFloat(rowData.taxRate)) * parseFloat(rowData.taxRate));
                        var taxRate =taxRate.toFixed(${SystemConfig.inputRoundNumber}) ;
                        rowData.input = taxRate;
                        $(this).setRowData(rowid,rowData)

                        //计算合计
//                        feeTypeTotal($(this))

                    },
                });
            },
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
    //新增明细
    function  addSubGrid(id,jggirdId){
        $.ConfirmAjax({
            msg: "注：您确定要增加一个明细吗？",
            url: "/orderledger/addSubJgGird.action",
            param: { id:id,shipmentSign:true},
            success: function (data) {
                if (data.result) {
                    dialogMsg(data.obj, 1);
                    $("#" + jggirdId).trigger("reloadGrid");
                } else {
                    dialogMsg(data.obj, -1);
                }
            }
        })
    }

    //删除明细
    function dellSubJgGird(id,jggirdId){

        $.ConfirmAjax({
            msg: "注：您确定要删除这个明细吗？",
            url: "/orderledger/dellSubJgGird.action",
            param: { id:id},
            success: function (data) {
                if (data.result) {
                    dialogMsg(data.obj, 1);
                    $("#" + jggirdId).trigger("reloadGrid");
                } else {
                    dialogMsg(data.obj, -1);
                }
            }
        })
    }

    function btn_add() {
        var options ={
            width: "1180px",
            height: "650px",
        }
        var _width = top.$.windowWidth() > parseInt(options.width.replace('px', '')) ? options.width : top.$.windowWidth() + 'px';
        var _height = top.$.windowHeight() > parseInt(options.height.replace('px', '')) ? options.height : top.$.windowHeight() + 'px';
        top.layer.open({
            id: "orderFrom",
            type: 2,
            shade: 0.3,
            title: '运单管理',
            fix: false,
            area: [_width, _height],
            content: top.contentPath +  '/jsp/Shipment/EpibolyForm.jsp.jsp,
            cancel: function () {
                $("#gridTable").trigger("reloadGrid");
                if (options.cancel != undefined)
                {
                    options.cancel();
                }
                return true;
            }
        });
    };
    //编辑
    function btn_edit(id) {
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("ship.id");
        }else {
            keyValue = id
        }

        if (checkedRow(keyValue)) {
            var options ={
                width: "1180px",
                height: "650px",
            }
            var _width = top.$.windowWidth() > parseInt(options.width.replace('px', '')) ? options.width : top.$.windowWidth() + 'px';
            var _height = top.$.windowHeight() > parseInt(options.height.replace('px', '')) ? options.height : top.$.windowHeight() + 'px';
            top.layer.open({
                id: "orderFrom",
                type: 2,
                shade: 0.3,
                title: '运单管理',
                fix: false,
                area: [_width, _height],
                content: top.contentPath +  '/jsp/Shipment/v.jsp?keyValue=' + keyValue,
                cancel: function () {
                    $("#gridTable").trigger("reloadGrid");
                    if (options.cancel != undefined)
                    {
                        options.cancel();
                    }
                    return true;
                }
            });
        }
    }
    function btn_despatch(){
        var keyValue = $("#gridTable").jqGridRowValue("ship.id");
        var status = $("#gridTable").jqGridRowValue("st");
        var  oper=$("#gridTable").jqGridRowValue("ship.operationPattern");
//        for(var i in top.clientdataItem.OrderStatus){
//            if(top.clientdataItem.OrderStatus[i] ==status){
//                status=i
//            }
//        }

        if(status == '1' || status == '0'){
            dialogAlert('运单未确认，不能发运', 0);
            return
        }
        //2 是确认
        if(status == 2){
            if (checkedRow(keyValue)) {
                var options ={
                    width: "1180px",
                    height: "550px",
                }
                var _width = top.$.windowWidth() > parseInt(options.width.replace('px', '')) ? options.width : top.$.windowWidth() + 'px';
                var _height = top.$.windowHeight() > parseInt(options.height.replace('px', '')) ? options.height : top.$.windowHeight() + 'px';
                if (checkedRow(keyValue)) {
                    dialogOpen({
                        id: "selectDate",
                        title: '时间选择',
                        url: '/jsp/Shipment/SelectDate.jsp?keyValue=' + keyValue,
                        width: "310px",
                        height: "240px",
                        callBack: function (iframeId) {
                            top.frames[iframeId].AcceptClick(location);
                        }
                    });
                }
            }
        }else{
            alert("运单不符合发运状态！")
        }

    }

    //异常修改
    function AbnormalFrom(){
        var  keyValue = $("#gridTable").jqGridRowValue("ship.id");
        if (checkedRow(keyValue)) {

            var  status = $("#gridTable").jqGridRowValue("st");
            var  s =false;
            if(status == 0 || status == 1 ){
                s = true;
            }
            if(s){
                dialogAlert("只能修改确认后的运单", -1);
                return;
            }
            dialogOpen({
                id: "AbnormalFrom",
                title: '运单异常修改',
                url: 'jsp/Shipment/ShipmentForm.jsp?keyValue=' + keyValue+'&source=true',
                width: "1200px",
                height: "1000px",
                btn:[],
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }

    //批量确认
    function ConfirmAll(status) {
        var  keyValue = $("#gridTable").jqGridRowValue("ship.id");
        if (keyValue) {
            $.ConfirmAjax({
                msg: "注：您确定要确认这些运单?确认后不能在更改!",
                url: "/shipment/confirmShipmentAll.action",
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
    var LODOP; //声明为全局变量
    function btn_print(id) {
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("ship.id");
        }else {
            keyValue = id
        }
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "shipmentForm",
                title: '打印',
                url: '/jsp/Shipment/ShipmentPrint.jsp?keyValue=' + keyValue,
                width: "1150px",
                height: "750px",
                callBack: function (iframeId) {
                    var obj = top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    function btn_export(){
        dialogOpen({
            id: "single",
            title: '导出派车单数据',
            url: '/jsp/Shipment/taizhangdaochu.jsp',
            width: "550px",
            height: "450px",
            btn:[],
            callBack: function (iframeId) {
                //  top.frames[iframeId].AcceptClick();
            }
        });
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
            <a id="epiboly-export" class="btn btn-default" onclick="btn_export()"><i class="fa fa-pencil-square-o"></i>&nbsp;导出台账</a>
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="epiboly-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
            <a id="epiboly-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
            <a id="epiboly-print" class="btn btn-default" onclick="btn_print()"><i class="fa fa-pencil-square-o"></i>&nbsp;打印</a>
        </div>
        <%--<div class="btn-group">--%>
            <%--<a id="shipment-confirm" class="btn btn-default" onclick="ConfirmAll()"><i class="fa fa-th"></i>&nbsp;批量确认</a>--%>
        <%--</div>--%>
        <%--<div class="btn-group">--%>
            <%--<a id="shipment-despatch" class="btn btn-default" onclick="btn_despatch()"><i class="fa fa-play"></i>&nbsp;发运</a>--%>
        <%--</div>--%>
        <div class="btn-group">
            <a id="shipment-abnormal" class="btn btn-default" onclick="AbnormalFrom()"><i class="fa fa-th"></i>&nbsp;异常修改</a>
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
