<%--
  Created by IntelliJ IDEA.
  User: 陈小龙
  Date: 2017/3/23
  Time: 9:27
  分段订单
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
    <title>分段订单</title>
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
        initHigtQuery($("#btn_HigtSearch"),$('#gridTable'));
    }
    //加载表格
    function GetGrid() {
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: "/transportorder/getLedList.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true,frozen:true},
                { label: 'ss', name: 'aor.id', hidden: true,frozen:true},
                {label: '组织机构', name: 'organization.name',index:"b.name" ,width: 120, align: 'center',frozen:true},
                {label: '分段订单号', name: 'code', index:"a.code", type:"text",width: 220, align: 'center',frozen:true,
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
                {label: '发货单号', selectDefault:true,name: 'relatebill1',index:"a.relatebill1", width: 80,frozen:true, align: 'center'},
                {label: '客户单号', selectDefault:true,name: 'relatebill2',index:"a.relatebill2", width: 80,frozen:true, align: 'center'},
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
                {label: '是否超期',name :'costomerIsExceed', type:"DD&CommIsNot",index:"a.costomerIsExceed",  width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},

               /* {label: '出发城市', name: 'fromCity',index:"a.fromCity",  width: 100, align: 'center'},
                {label: '目的城市', name: 'toCity', index:"a.toCity", width: 100, align: 'center'},*/

                {label: '销售负责人', name: 'salePersion',index:"a.salePersion",  width:80, align: 'center'},

              /*  {label: '执行计划', name: 'plan.name', width: 100,index:"e.name", align: 'center'},*/
                {label: '运输性质', name: 'transportPro',type:"DD&TransportPro", width: 40,index:"a.transportPro", align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.TransportPro['' + cellvalue + '']
                    }},
                {label: '是否回单', name: 'isBack', type:"DD&CommIsNot",index:"a.isBack",width:40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '回单份数', name: 'backNumber', width: 40, align: 'center',index:"a.backNumber"},
                {label: '件数', name: 'number', width: 40, align: 'center',index:"a.number"},
                {label: '重量', name: 'weight', width: 40, align: 'center',index:"a.weight"},
                {label: '体积', name: 'volume', width: 40, align: 'center',index:"a.volume"},
                {label: "备注", name: "description",index:"a.description",width: 200, align: "center"},
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
            multiselect: true,//复选框
            subGridRowExpanded: function (subgrid_id, row_id) {
                var keyValue = $gridTable.jqGrid('getRowData', row_id)['id'];
                var subgrid_table_id = subgrid_id + "_t";
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "'></table>");
                $("#" + subgrid_table_id).jqGrid({
                    url: "/transportorder/getOrderLedProductList.action",
                    postData: {id: keyValue},
                    datatype: "json",
                    height: "100%",
                    colModel: [
                        {label: '主键', name: 'id', hidden: true},
                        {label: '货品名称', name: 'name', width: 150, align: 'center'},
                        {label: '单位', name: 'unit', width: 100, align: 'center'},
                        {label: '数量', name: 'number', width: 100, align: 'center'},
                        {label: '重量', name: 'weight', width: 100, align: 'center'},
                        {label: '体积', name: 'volume', width: 100, align: 'center'},
                        {label: '货值', name: 'value', width: 100, align: 'center'},
                        {label: '备注', name: 'description', width: 300, align: 'center'},
                        {label: '  ', name: '', width: 150, align: 'center'}
                    ],
                    caption: "货品信息",
                    rowNum: "1000",
                    rownumbers: true,
                    shrinkToFit: false,
                    gridview: true,
                    hidegrid: false,
                });
            },
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            },
            ondblClickRow:function(a,b,c){
                var resule = $gridTable.getCell(a,"aor.id");
                if(resule){
                    btn_edit(resule)
                }
            },
        });
        //初始化查询页面
        initJGGridselectView($gridTable);
    }
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


    function  peizaiShip() {
        var status=$("#gridTable").jqGridRowValue("status");
        var keyValue = $("#gridTable").jqGridRowValue("id");

            if (checkedArray(keyValue)) {
                if(status.indexOf("确认")<0){
                    dialogMsg("只能配载确认的分段订单", -1);
                    return;
                }
                dialogOpen({
                    id: "ShipmentTemplateFrom",
                    title: '运单模板',
                    url: '/jsp/ShipmentTemplate/ShipmentTemplate.jsp',
                    width: "1050px",
                    height: "450px",
                    callBack: function (iframeId) {
                        var resule = top.frames[iframeId].getTemplate();
                        var templateId = resule.id;
                        top.frames[iframeId].dialogClose();//关闭窗口

                        $.ConfirmAjax({
                            msg: "确定配载此模板?",
                            url: "/transportorder/peizaiShip.action",
                            param: {ids: keyValue, templateId: templateId},
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
                });
        }
    }
    function edit_nwv(){
        var keyValue = $("#gridTable").jqGridRowValue("id");
        var number = $("#gridTable").jqGridRowValue("number");
        var weight = $("#gridTable").jqGridRowValue("weight");
        var volume = $("#gridTable").jqGridRowValue("volume");

        if(keyValue == null || keyValue == undefined  || keyValue ==""){
            alert("请选择需要修改的单子")
            return
            }
        dialogOpen({
            id: "LedFrom",
            title: '修改件重尺',
            url: '/jsp/LedOrder/ledForm.jsp?keyValue=' + keyValue + "&number=" + number + "&weight=" + weight + "&volume=" + volume,
            width: "850px",
            height: "450px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick();
            }
        })
    }

    /**
     * 多条分段订单配载一条运单模板
     */
    function  peizaiShip() {
        var status=$("#gridTable").jqGridRowValue("status");
        var keyValue = $("#gridTable").jqGridRowValue("id");

        if (checkedArray(keyValue)) {
            if(status.indexOf("确认")<0){
                dialogMsg("只能配载确认的分段订单", -1);
                return;
            }
            dialogOpen({
                id: "ShipmentTemplateFrom",
                title: '运单模板',
                url: '/jsp/ShipmentTemplate/ShipmentTemplate.jsp',
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getTemplate();
                    var templateId = resule.id;
                    top.frames[iframeId].dialogClose();//关闭窗口

                    $.ConfirmAjax({
                        msg: "确定配载此模板?",
                        url: "/transportorder/peizaiShip.action",
                        param: {ids: keyValue, templateId: templateId},
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
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="led-xgjdz" class="btn btn-default" onclick="edit_nwv();"><i class="fa fa-refresh"></i>&nbsp;修改件重尺</a>
            <a id="peizaiShip" class="btn btn-default" onclick="peizaiShip();"><i class="fa fa-random"></i>&nbsp;配载运单</a>
        </div>
        <%----%>
        <script>$('.toolbar').authorizeButton()</script>
        <%----%>
    </div>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
    <div id="gridPager"></div>
</div>
</body>
</html>