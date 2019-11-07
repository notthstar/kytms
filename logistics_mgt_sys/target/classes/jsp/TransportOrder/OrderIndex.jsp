<%--
  Created by IntelliJ IDEA.
  User: 孙德增
  Date: 2017/11/20 0020
  Time: 下午 1:43
  订单信息
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
    <title>订单信息</title>
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
        getFeeType()//初始化费用类型
    });

    function getFeeType(){
        $.ajax({
            url: "/feetype/getFeeType.action",
            data: {id:"1.1"},
            async:false,
            type: "post",
            dataType: "json",
            success: function (data) {
                feeTypeData =data;
            },
        });
    }

    function openAb(id){
        dialogOpen({
            id: "OrderAblist",
            title: '修改异常',
            url: 'jsp/TransportOrder/OrderAblist.jsp?id=' + id,
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
            url: "/transportorder/getOrderGrid.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true,frozen:true},
                {label: '组织机构', name: 'organization.name',index:"b.name" ,width: 80, align: 'center',frozen:true},
                {label: '订单号',selectDefault:true, name: 'code', index:"a.code", type:"text",width: 150, align: 'center',frozen:true,
                    formatter: function (cellvalue, options, rowObject) {

                        if(rowObject[40] ==1){
                            return '<a onclick=\"openAb(\'' + rowObject[0]+'\')\" class=\"label label-danger\" style=\"cursor: pointer;\">'+cellvalue+'</a>';
                        }else {
                            return cellvalue;
                        }

                    }},
                {label: '发货单号', name: 'relatebill1',index:"a.relatebill1", width: 80,frozen:true, align: 'center'},
                {label: '客户单号', name: 'relatebill2',index:"a.relatebill2", width: 80,frozen:true, align: 'center'},
                {label: '开单日期', name: 'time', index:"a.time", type:"date",width: 80, align: 'center',frozen:true,
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},


                {label: '订单状态', name: 'status',type:"DD&OrderStatus",index:"a.status", width: 70, align: 'center',frozen:true,
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    }},
                {label: '客户类型', name: 'costomerType',index:"a.costomerType",  type:"DD&CustomerType",width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CustomerType['' + cellvalue + '']
                    }},
                {label: '是否拆单',name :'costomerIsExceed', type:"DD&CommIsNot",index:"a.costomerIsExceed",  width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '客户名称', name: 'customer.name',index:"c.name", width: 200, align: 'center'},
                {label: '结算方式', name: 'feeType',index:"a.feeType",type:"DD&Clearing", width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.Clearing['' + cellvalue + '']
                    }},
                {label: '收入成本确认状态', name: ' a.is_inoutcome',index:"a.is_inoutcome", width: 60, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.ConfirmStatus['' + cellvalue + '']
                    }
                },
                {label: '出发运点', name: 'startZone.name',index:"sz.name", width: 80, align: 'center'},
                {label: '目的网点', name: 'ton.name',index:"ton.name", width: 80, align: 'center'},
                {label: '目的运点', name: 'endZone.name',index:"ez.name", width: 80, align: 'center'},
                {label: '交付方式', name: 'handoverType',index:"a.handoverType",type:"DD&HandoverType", width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.HandoverType['' + cellvalue + '']
                    }},
                {label: '货名', name: 'f.name',index:"f.name", width: 60, align: 'center'},
                {label: '总金额', name: 'led.amount',index:"led.amount", width: 60, align: 'center'},
                {label: '件数', name: 'a.number',index:"a.number", width: 60, align: 'center'},
                {label: '重量', name: 'a.weight',index:"a.weight", width: 60, align: 'center'},
                {label: '体积', name: 'a.volume',index:"a.volume", width:60, align: 'center'},
                {label: '计重', name: 'a.jzWeight',index:"a.jzWeight", width: 60, align: 'center'},
                {label: '实际发运日期', name: 'a.factLeaveTime',index:"a.factArriveTime", width: 140, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '实际运抵日期', name: 'a.factArriveTime',index:"a.factArriveTime", width: 140, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},


                {label: '在途跟踪', name: 'track', width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return '<span onclick=\"getTrack(\'' +rowObject[0]+'\')\" class=\"label label-info\" style=\"cursor: pointer;\">点击查看</span>';
                    }},
                {label: '是否超期',name :'costomerIsExceed', type:"DD&CommIsNot",index:"a.costomerIsExceed",  width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '销售负责人', name: 'salePersion',index:"a.salePersion",  width: 100, align: 'center'},
                /*{label: '执行计划', name: 'plan.name', width: 100,index:"e.name", align: 'center'},*/
                {label: '运输性质', name: 'transportPro',type:"DD&TransportPro", width: 100,index:"a.transportPro", align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.TransportPro['' + cellvalue + '']
                    }},
                {label: '是否回单', name: 'isBack', type:"DD&CommIsNot",index:"a.isBack",width: 60, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '回单份数', name: 'backNumber', width: 80, align: 'center',index:"a.backNumber"},
                {label: '入库区域', name: 'zoneStoreroom.name',index:"zs.name", width: 60, align: 'center'},
                {label: '订单公里数', name: 'orderMileage',index:"a.orderMileage", width: 80, align: 'center',frozen:true},
                /*{label: '是否开票', name: 'isBilling',index:"a.isBilling",type:"DD&CommIsNot", width: 60, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},*/
                {label: "备注", name: "description",index:"a.description", index: "description", width: 200, align: "center"},
                {label: '创建人', name: 'create_Name',index:"a.create_Name", width: 120,align: 'center'},
                {label: '创建时间', name: 'create_Time',index:"a.create_Time", width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '修改人', name: 'modify_Name', index:"a.modify_Name",width: 120,align: 'center'},
                {label: '修改时间', name: 'modify_Time', index:"a.modify_Time",width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '同步状态', name: 'relatebill3', index:"a.relatebill3",width: 120,align: 'center'},
                {label: '异常', name: 'isAbnormal',index:"a.isAbnormal", hidden: true},
                {label: "状态", name: "st",hidden: true},
                {label: '异常', name: 'abn', hidden: true},
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
            frozen:true,
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
                    if(val == null || val =="" || val == undefined){
                        return [true,parseFloat(0)]
                    }

                    var boolean = isInteger(val)
                    if(boolean){
                        return [true,parseFloat(val)];
                    }
                    return  [false,"请输入正确数字"];
                }
                var keyValue = $gridTable.jqGrid('getRowData', row_id)['id'];
                var status = $gridTable.jqGrid('getRowData', row_id)['st']

                var subgrid_table_id = subgrid_id + "_t";
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "'></table>");
                var cellEdit = false;
                if (status == 1){
                    cellEdit = true
                }
                $("#" + subgrid_table_id).jqGrid({
                    url: "/transportorder/getFreeList.action",
                    postData: {id: keyValue},
                    datatype: "json",
                    height: "100%",
                    cellEdit:cellEdit,
                    cellurl:"/transportorder/editFree.action",
                    colModel: [
                        {label: '主键', name: 'id', hidden: true},
                        {label: "台账类型", name: "cost",width: 70, align: "center",type:"DD&LedgerCost",
                            formatter: function (cellvalue, options, rowObject) {
                                return top.clientdataItem.LedgerCost['' + cellvalue + '']
                            }},
                        {label: '费用名称', name: 'feeType.name',width: 150, align: 'center',editable:true,edittype:'select', align: "center",editoptions: {value: feeTypeData}
                           },
                        {label: '金额', name: 'amount', width: 100, align: 'center' ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator}},
                        {label: '税率', name: 'taxRate', width: 100, align: 'center',editable:true,edittype:'select', editoptions: {value: top.clientdataItem.TaxRate}},
                        {label: '税金', name: 'input', width: 100, align: 'center'},
//                        {label: '保存', width: 40, align: 'center', formatter: function (cellvalue, options, rowObject) {
//                            if (status == '保存'){
//                                return '<span onclick=\"getTrack(\'' +rowObject[0]+'\')\" class=\"fa fa-save\" style=\"cursor: pointer;\"></span>';
//                            }else{
//                                return 'NO'
//                            }
//
//                        }},
                        {label: '结算方式', name: 'settlementMethod', width: 100, align: 'center',editable:true,edittype:'select', editoptions: {value: top.clientdataItem.SettlementMethod}},
                        {label: '结款方式', name: 'collectMethod', width: 100, align: 'center',editable:true,edittype:'select', editoptions: {value: top.clientdataItem.CollectMethod}},
                        {label: '删除', width: 40, align: 'center', formatter: function (cellvalue, options, rowObject) {
                            if (status == 1){
                            return '<span onclick=\"dellSubJgGird(\'' +rowObject['id']+'\',\'' +subgrid_table_id+'\')\" class=\"fa fa-trash-o\" style=\"cursor: pointer;\"></span>';
                            }else{
                                return 'NO'
                            }
                        }},
                        {label: '新增', width: 40, align: 'center', formatter: function (cellvalue, options, rowObject) {
                            if (status == 1){
                            return '<span onclick=\"addSubGrid(\'' +keyValue+'\',\'' +subgrid_table_id+'\')\" class=\"fa fa-plus\" style=\"cursor: pointer;\"></span>';
                        }else{
                            return 'NO'
                        }
                        }},
                        {label: '备注', name: 'description', width: 300, align: 'center',editable: true},
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
            ondblClickRow:function(a,b,c){
                var resule = $gridTable.getCell(a,"id");
                if(resule){
                    btn_edit(resule)
                }
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            }
        });
        //初始化查询页面
        initJGGridselectView($gridTable);
        $gridTable.jqGrid('setFrozenColumns');

    }
    //新增明细
   function  addSubGrid(id,jggirdId){
       $.ConfirmAjax({
           msg: "注：您确定要增加一个明细吗？",
           url: "/transportorder/addSubJgGird.action",
           param: { id:id,shipmentSign:false},
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
            url: "/transportorder/dellSubJgGird.action",
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

    //新增
    function btn_add() {
        //top.tablist.newTab({ id: "orderForm", title: "新增订单", closed: true, icon: "fa fa fa-user", url: top.contentPath+"/jsp/TransportOrder/OrderForm.jsp" })


        var options ={
            width: "1230px",
            height: "650px",
        }
        var _width = top.$.windowWidth() > parseInt(options.width.replace('px', '')) ? options.width : top.$.windowWidth() + 'px';
        var _height = top.$.windowHeight() > parseInt(options.height.replace('px', '')) ? options.height : top.$.windowHeight() + 'px';
        top.layer.open({
            id: "orderFrom",
            type: 2,
            shade: 0.3,
            title: '订单管理',
            fix: false,
            area: [_width, _height],
            content: top.contentPath +  '/jsp/TransportOrder/OrderForm.jsp',
            cancel: function () {
                $("#gridTable").trigger("reloadGrid");
                if (options.cancel != undefined)
                {
                    options.cancel();
                }
                return true;
            }
        });
//        dialogContent({
//            id: "Form",
//            title: '新增订单',
//            url: 'jsp/CustomerService/Order/OrderForm.jsp',
//            width: "650px",
//            height: "420px",
//            callBack: function (iframeId) {
//                top.frames[iframeId].AcceptClick();
//            }
//        });
    };
    //编辑
    function btn_edit(id) {
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("id");
        }else {
            keyValue = id
        }
        if (checkedRow(keyValue)) {
            //top.tablist.newTab({ id: "orderForm", title: "修改订单", closed: true, icon: "fa fa fa-user", url: top.contentPath+"/jsp/TransportOrder/OrderForm.jsp?keyValue=" + keyValue })
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
            title: '修改订单',
            fix: false,
            area: [_width, _height],
            content: top.contentPath +  '/jsp/TransportOrder/OrderForm.jsp?keyValue=' + keyValue,
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
    //导出
    function btn_export() {
        $("#gridTable").ExportToExcel("export.xlsx");
    }
    //用户状态修改(生效、失效)
    function ConfirmAll(status) {
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedArray(keyValue)) {
            $.ConfirmAjax({
            msg: "注：您确定要确认这些订单?确认后不能在更改!",
            url: "/transportorder/confirmOrder.action",
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
    function btn_delete(ss){
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        var  status = $("#gridTable").jqGridRowValue("st");
        if (checkedArray(keyValue)){
            $.ConfirmAjax({
                msg: "注：您确定要删除订单？",
                url: "/transportorder/deleteOrder.action",
                param: { tableName:"JC_ORDER",status:status,id: keyValue },
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
    function AbnormalFrom(){
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "AbnormalFrom",
                title: '订单异常修改',
                url: 'jsp/TransportOrder/OrderForm.jsp?keyValue=' + keyValue+'&source=true',
                width: "1200px",
                height: "1000px",
                btn:[],
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }

    /**
     * 查看在途跟踪
     */
    function  getTrack(id) {
       // var keyValue = $("#gridTable").jqGridRowValue("id");
        dialogOpen({
            id: "TrackFrom",
            title: '在途跟踪',
            url: 'jsp/TransportOrder/OrderTrackList.jsp?orderId='+id,
            width: "900px",
            height: "400px",
            callBack: function (iframeId) {
                top.frames[iframeId].dialogClose();//关闭窗口
            }
        });
    }
    

    //复制新建
    function copyOrder() {
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        var keys=keyValue.split(',')
        if(keys.length>=1){
            dialogMsg("请选择一条数据","5");
        }
        if (checkedRow(keyValue)) {
            $.ConfirmAjax({
                msg: "注：您确定要复制新建此条订单?",
                url: "/transportorder/copyOrder.action",
                param: { id:keyValue},
                success: function (data) {
                    if (data.result) {
                        dialogMsg(data.obj, 1);
                        $("#gridTable").trigger("reloadGrid");
                    } else {
                        dialogMsg(data.obj, -1);''
                    }
                }
            })
        }
    }
    function orderExport(){
        dialogOpen({
            id: "order",
            title: '导出订单数据',
            url: '/jsp/TransportOrder/orderExport.jsp',
            width: "650px",
            height: "450px",
            btn:[],
            callBack: function (iframeId) {
                //  top.frames[iframeId].AcceptClick();
            }
        });
    }
    function  orderImport() {
            dialogOpen({
                id: "上传EXCEL",
                title: '订单导入',
                url: '/jsp/TransportOrder/orderImport.jsp',
                width: "550px",
                height: "550px",
                btn:[],
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
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
                    <a id="btn_HigtSearch" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;高级查询</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="order-export" class="btn btn-default" onclick="orderExport();">导出</a>
            <a id="uploadify" class="btn btn-default" onclick="orderImport();">导入</a>
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="order-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
            <a id="order-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
            <a id="order-delete" class="btn btn-default" onclick="btn_delete(0)"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
        </div>
        <div class="btn-group">
            <a id="order-buttonhorize" class="btn btn-default" onclick="ConfirmAll()"><i class="fa fa-th"></i>&nbsp;批量确认</a>
        </div>
        <div class="btn-group">
        <a id="order-abnormal" class="btn btn-default" onclick="AbnormalFrom()"><i class="fa fa-th"></i>&nbsp;异常修改</a>
        </div>
        <div class="btn-group">
            <a id="order-copy" class="btn btn-default" onclick="copyOrder()"><i class="fa fa-th"></i>&nbsp;复制新建</a>
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

