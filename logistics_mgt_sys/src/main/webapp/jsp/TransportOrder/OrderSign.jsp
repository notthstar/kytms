<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/10/30
  Time: 11:20
  To change this template use File | Settings | File Templates.
  订单签收
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
    <title>订单签收</title>
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
            url: "/transportorder/getOrderYS.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true,frozen:true},
                {label: '出发机构', name: 'formOrganization.name',index:"b.name" ,width: 100, align: 'center',frozen:true},
                {label: '目的机构', name: 'toOrganization.name',index:"b.name" ,width: 100, align: 'center',frozen:true},
                {label: '分段订单号', name: 'code', index:"a.code", type:"text",width: 150, align: 'center',frozen:true,
                    cellattr:function addCellAttr(rowId, val, rawObject, cm, rdata) {
                        if(rawObject[25] == 1 ){
                            return "style='color:red'";
                        }
                    }},
                {label: '订单日期', name: 'time', index:"a.time", type:"date",width: 80, align: 'center',frozen:true,
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '客户订单号', selectDefault:true,name: 'relatebill1',index:"a.relatebill1", width: 80,frozen:true, align: 'center'},
                {label: '客户类型', name: 'costomerType',index:"a.costomerType",  type:"DD&CustomerType",width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CustomerType['' + cellvalue + '']
                    }},
                {label: '客户名称', name: 'customer.name',index:"c.name", width: 200, align: 'center'},
                /*{label: '项目名称', name: 'projectManagement.name', index:"d.name", width: 140, align: 'center'},*/
                {label: '货品名称',width: 0, hidden: true,index:"f.name",isIndex:true},
                {label: '货品备注', width: 0, hidden: true,index:"f.description",isIndex:true},
                {label: '订单状态', name: 'status',type:"DD&OrderStatus",index:"a.status", width: 60, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    }},
                {label: '交付方式', name: 'handoverType',type:"DD&HandoverType",index:"a.status", width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.HandoverType['' + cellvalue + '']
                    }},
                {label: '是否超期',name :'costomerIsExceed', type:"DD&CommIsNot",index:"a.costomerIsExceed",  width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '运输性质', name: 'transportPro',type:"DD&TransportPro", width:40,index:"a.transportPro", align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.TransportPro['' + cellvalue + '']
                    }},
                {label: '是否回单', name: 'isBack', type:"DD&CommIsNot",index:"a.isBack",width:40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '回单份数', name: 'backNumber', width:40, align: 'center',index:"a.backNumber"},
                {label: '件数', name: 'a.number',index:"a.number", width: 60, align: 'center'},
                {label: '重量', name: 'a.weight',index:"a.weight", width: 60, align: 'center'},
                {label: '体积', name: 'a.volume',index:"a.volume", width:60, align: 'center'},
                {label: '销售负责人', name: 'salePersion',index:"a.salePersion",  width: 100, align: 'center'},
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
                {label: '状态',name:'st', hidden: true, width: 0,index:"f.unit",isIndex:true},
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
    function btn_qianshou(){
        var   keyValue = $("#gridTable").jqGridRowValue("id");
       // var st =$("#gridTable").jqGridRowValue("st");
            if (checkedRow(keyValue)) {
                dialogOpen({
                    id: "SinceTicketForm",
                    title: '签收',
                    url: '/jsp/TransportOrder/OrderSignForm.jsp?keyValue=' + keyValue,
                    width: "650px",
                    height: "400px",
                    callBack: function (iframeId) {
                        top.frames[iframeId].AcceptClick();
                    }
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
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="order-add" class="btn btn-default" onclick="btn_qianshou()"><i class="fa fa-plus"></i>&nbsp;签收</a>
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

