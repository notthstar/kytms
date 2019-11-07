<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2019-08-02
  Time: 9:08
  To change this template use File | Settings | File Templates.
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
    <title>收入确认表</title>
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
            url: "/transportorder/getLedgerdetailsList.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true,frozen:true},
                {label: '组织机构', name: 'organization.name',index:"b.name" ,width: 80, align: 'center',frozen:true},
                {label: '订单号',selectDefault:true, name: 'code', index:"a.code", type:"text",width: 150, align: 'center',frozen:true,
                    formatter: function (cellvalue, options, rowObject) {

                        if(rowObject[39] ==1){
                            return '<a onclick=\"openAb(\'' + rowObject[0]+'\')\" class=\"label label-danger\" style=\"cursor: pointer;\">'+cellvalue+'</a>';
                        }else {
                            return cellvalue;
                        }

                    }},
                {label: '发货单号', name: 'relatebill1',index:"a.relatebill1", width: 120,frozen:true, align: 'center'},
                {label: '开单日期', name: 'time', index:"a.time", type:"date",width: 80, align: 'center',frozen:true,
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '确认时间', name: 'affirm_Time', index:"d.affirm_Time", type:"date",width: 80, align: 'center',frozen:true,
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd")
                    }},
                {label: '台账状态', name: 'status',type:"DD&TZLX",index:"a.status", width: 70, align: 'center',frozen:true,
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.TZLX['' + cellvalue + '']
                    }},
                {label: '确认状态', name: 'is_inoutcome',type:"DD&INOUTCOME",index:"a.status", width: 70, align: 'center',frozen:true,
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.ConfirmStatus['' + cellvalue + '']
                    }},
                {label: '客户类型', name: 'costomerType',index:"a.costomerType",  type:"DD&CustomerType",width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CustomerType['' + cellvalue + '']
                    }},
                {label: '客户名称', name: 'customer.name',index:"c.name", width: 200, align: 'center'},
                {label: '费用名称', name: 'f.name',index:"f.name", width: 60, align: 'center'},
                {label: '总金额', name: 'led.amount',index:"led.amount", width: 100, align: 'center'},
                {label: '税金', name: 'd.input',index:"d.input", width: 80, align: 'center'},
                {label: '收入', name: 'd.income',index:"d.income", width: 100, align: 'center'},
                {label: "备注", name: "description",index:"a.description", index: "description", width: 200, align: "center"},
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
           // subGrid: true,
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
                <%--$("#" + subgrid_table_id).jqGrid({--%>
                    <%--url: "/transportorder/getFreeList.action",--%>
                    <%--postData: {id: keyValue},--%>
                    <%--datatype: "json",--%>
                    <%--height: "100%",--%>
                    <%--cellEdit:cellEdit,--%>
                    <%--cellurl:"/orderledger/editFree.action",--%>
                    <%--colModel: [--%>
                        <%--{label: '主键', name: 'id', hidden: true},--%>
                        <%--{label: '费用名称', name: 'feeType.name',width: 150, align: 'center',editable:true,edittype:'select', align: "center",editoptions: {value: feeTypeData}--%>
                        <%--},--%>
                        <%--{label: '金额', name: 'amount', width: 100, align: 'center' ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator}},--%>
                        <%--{label: '税率', name: 'taxRate', width: 100, align: 'center',editable:true,edittype:'select', editoptions: {value: top.clientdataItem.TaxRate}},--%>
                        <%--{label: '税金', name: 'input', width: 100, align: 'center'},--%>
                        <%--{label: '删除', width: 40, align: 'center', formatter: function (cellvalue, options, rowObject) {--%>
                                <%--if (status == 1){--%>
                                    <%--return '<span onclick=\"dellSubJgGird(\'' +rowObject['id']+'\',\'' +subgrid_table_id+'\')\" class=\"fa fa-trash-o\" style=\"cursor: pointer;\"></span>';--%>
                                <%--}else{--%>
                                    <%--return 'NO'--%>
                                <%--}--%>
                            <%--}},--%>
                        <%--{label: '新增', width: 40, align: 'center', formatter: function (cellvalue, options, rowObject) {--%>
                                <%--if (status == 1){--%>
                                    <%--return '<span onclick=\"addSubGrid(\'' +keyValue+'\',\'' +subgrid_table_id+'\')\" class=\"fa fa-plus\" style=\"cursor: pointer;\"></span>';--%>
                                <%--}else{--%>
                                    <%--return 'NO'--%>
                                <%--}--%>
                            <%--}},--%>
                        <%--{label: '备注', name: 'description', width: 300, align: 'center',editable: true},--%>
                        <%--{label: '  ', name: '', width: 150, align: 'center'}--%>
                    <%--],--%>
                    <%--caption: "费用明细",--%>
                    <%--rowNum: "1000",--%>
                    <%--rownumbers: true,--%>
                    <%--shrinkToFit: false,--%>
                    <%--gridview: true,--%>
                    <%--hidegrid: false,--%>
                    <%--afterSaveCell:function(rowid, cellname, value, iRow, iCol){--%>
                        <%--//计算税率--%>
                        <%--var rowData = $(this).getRowData(rowid)--%>
                        <%--var taxRate = parseFloat(rowData.amount / (1 + parseFloat(rowData.taxRate)) * parseFloat(rowData.taxRate));--%>
                        <%--var taxRate =taxRate.toFixed(${SystemConfig.inputRoundNumber}) ;--%>
                        <%--rowData.input = taxRate;--%>
                        <%--$(this).setRowData(rowid,rowData)--%>

                        <%--//计算合计--%>
<%--//                        feeTypeTotal($(this))--%>

                    <%--},--%>
                <%--}--%>
                <%--);--%>
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
        //$gridTable.jqGrid('setFrozenColumns');

    }
    //新增明细
    function  addSubGrid(id,jggirdId){
        $.ConfirmAjax({
            msg: "注：您确定要增加一个明细吗？",
            url: "/orderledger/addSubJgGird.action",
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
    //收入确认
    function affirmAll() {
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        var is_inoutcome =$("#gridTable").jqGridRowValue("is_inoutcome");
         if(is_inoutcome != "已确认"){
             if (checkedArray(keyValue)) {
                 dialogOpen({
                     id: "selectDate",
                     title: '时间选择',
                     url: '/jsp/Finance/AffirmTime.jsp?keyValue=' + keyValue,
                     width: "310px",
                     height: "240px",
                     callBack: function (iframeId) {
                         top.frames[iframeId].AcceptClick(location);
                     }
                 });
                 // $.ConfirmAjax({
                 //     msg: "注：您确定要订单收入确认?",
                 //     url: "/transportorder/affirmOrder.action",
                 //     param: { id:keyValue},
                 //     success: function (data) {
                 //         if (data.result) {
                 //             dialogMsg(data.obj, 1);
                 //             $("#gridTable").trigger("reloadGrid");
                 //         } else {
                 //             dialogMsg(data.obj, -1);
                 //         }
                 //     }
                 // })
             }
         }else{
             dialogMsg("该数据已经被确认，不能重复确认", -1);
         }
    }
    //反确认
    function FanAffirmAll() {
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        var is_inoutcome =$("#gridTable").jqGridRowValue("is_inoutcome");
        if(is_inoutcome!="未确认"){
            if (checkedArray(keyValue)) {
                // dialogOpen({
                //     id: "selectDate",
                //     title: '时间选择',
                //     url: '/jsp/Shipment/YDDate.jsp?keyValue=' + keyValue,
                //     width: "310px",
                //     height: "240px",
                //     callBack: function (iframeId) {
                //         top.frames[iframeId].AcceptClick(location);
                //     }
                // });
                $.ConfirmAjax({
                    msg: "注：您确定要撤销订单的收入确认?",
                    url: "/transportorder/fanaffirmOrder.action",
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
        }else{
            dialogMsg("该单据还没确认，不能操作反确认", -1);
        }

    }
    // function btn_delete(ss){
    //     var  keyValue = $("#gridTable").jqGridRowValue("id");
    //     var  status = $("#gridTable").jqGridRowValue("st");
    //     if (checkedArray(keyValue)){
    //         $.ConfirmAjax({
    //             msg: "注：您确定要删除订单？",
    //             url: "/transportorder/deleteOrder.action",
    //             param: { tableName:"JC_ORDER",status:status,id: keyValue },
    //             success: function (data) {
    //                 if (data.result) {
    //                     dialogMsg(data.obj, 1);
    //                     $("#gridTable").trigger("reloadGrid");
    //                 } else {
    //                     dialogMsg(data.obj, -1);
    //                 }
    //             }
    //         })
    //     }
    // }



    //复制新建
    // function copyOrder() {
    //     var  keyValue = $("#gridTable").jqGridRowValue("id");
    //     var keys=keyValue.split(',')
    //     if(keys.length>=1){
    //         dialogMsg("请选择一条数据","5");
    //     }
    //     if (checkedRow(keyValue)) {
    //         $.ConfirmAjax({
    //             msg: "注：您确定要复制新建此条订单?",
    //             url: "/transportorder/copyOrder.action",
    //             param: { id:keyValue},
    //             success: function (data) {
    //                 if (data.result) {
    //                     dialogMsg(data.obj, 1);
    //                     $("#gridTable").trigger("reloadGrid");
    //                 } else {
    //                     dialogMsg(data.obj, -1);''
    //                 }
    //             }
    //         })
    //     }
    // }
    // function orderExport(){
    //     dialogOpen({
    //         id: "order",
    //         title: '导出订单数据',
    //         url: '/jsp/TransportOrder/orderExport.jsp',
    //         width: "650px",
    //         height: "450px",
    //         btn:[],
    //         callBack: function (iframeId) {
    //             //  top.frames[iframeId].AcceptClick();
    //         }
    //     });
    // }
    // function  orderImport() {
    //     dialogOpen({
    //         id: "上传EXCEL",
    //         title: '订单导入',
    //         url: '/jsp/TransportOrder/orderImport.jsp',
    //         width: "550px",
    //         height: "550px",
    //         btn:[],
    //         callBack: function (iframeId) {
    //             top.frames[iframeId].AcceptClick();
    //         }
    //     });
    // }
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
                    <a id="btn_history" class="btn btn-default" onclick="sdfsdf()"  style="margin-left: 25px">已确认单据</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <%--<a id="order-export" class="btn btn-default" onclick="orderExport();"><i class="fa fa-refresh"></i>&nbsp;导出</a>--%>
            <%--<a id="uploadify" class="btn btn-default" onclick="orderImport();"><i class="fa fa-refresh"></i>&nbsp;导入</a>--%>
            <a id="replace" class="btn btn-default" onclick="reload();"></i>&nbsp;刷新</a>
            <%--<a id="order-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>--%>
            <%--<a id="order-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>--%>
            <%--<a id="order-delete" class="btn btn-default" onclick="btn_delete(0)"><i class="fa fa-trash-o"></i>&nbsp;删除</a>--%>
        </div>
        <div class="btn-group">
            <a id="order-buttonhorize" class="btn btn-default" onclick="affirmAll()"></i>&nbsp;确认</a>
            <a id="order-fanqueren" class="btn btn-default" onclick="FanAffirmAll()"></i>&nbsp;反确认</a>
        </div>
        <%--<div class="btn-group">--%>
            <%--<a id="order-abnormal" class="btn btn-default" onclick="AbnormalFrom()"><i class="fa fa-th"></i>&nbsp;异常修改</a>--%>
        <%--</div>--%>
        <%--<div class="btn-group">--%>
            <%--<a id="order-copy" class="btn btn-default" onclick="copyOrder()"><i class="fa fa-th"></i>&nbsp;复制新建</a>--%>
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

