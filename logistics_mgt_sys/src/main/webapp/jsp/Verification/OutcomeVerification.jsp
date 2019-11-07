<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/11
  Time: 15:40
  To change this template use File | Settings | File Templates.
  干线成本核销
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>

<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>干线成本核销</title>
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet"/>
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-uuid.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/grid.locale-cn.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.js"></script>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-report.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-bill.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/layout/jquery.layout.js"></script>

    <style>
        html, body {
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<body>
<script>

    $(function () {
        InitialPage();
        InitControl();
    });
    //初始化数据
    function InitControl() {
        //resize重设(表格、树形)宽高
        $(window).resize(function (e) {
            window.setTimeout(function () {
//                $('#gridTable').setGridWidth(($('.gridPanel').width()));
//                $("#gridTable").setGridHeight($(window).height() - 136.5);
            }, 200);
            e.stopPropagation();
        });
    }
    //初始化页面
    function InitialPage() {
        //layout布局
        $('#layout').layout({
            applyDemoStyles: true,
            onresize: function () {
                $(window).resize()
            }
        });
        $('.profile-nav').height($(window).height() - 20);
        $('.profile-content').height($(window).height() - 20);
        //resize重设(表格、树形)宽高
        GetGrid();
    }
    //侧面切换显示/隐藏 //分布加载
    function onhand(id) {
//        $(".profile-content").find('.flag').hide()
//        $(".profile-content").find("#" + id).show();
        if(id == 'weiVerification'){//未核销
            $('#gridTable').jqGrid('setGridParam', {
                postData: {
                    id:"weiVerification"
                },
                page: 1
            }).trigger('reloadGrid');
        }else if(id == 'bufenVerification'){//部分核销
            $('#gridTable').jqGrid('setGridParam', {
                postData: {
                    id:"bufenVerification"
                },
                page: 1
            }).trigger('reloadGrid');
        }else if(id == 'yiVerification'){//已核销
            $('#gridTable').jqGrid('setGridParam', {
                postData: {
                    id:"yiVerification"
                },
                page: 1
            }).trigger('reloadGrid');
        }
    }
    function GetGrid(){
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: "/verification/getVerCostList.action",
            datatype: "json",
            height: $(window).height() - 145,
            autowidth: false,
            width:1195,
            colModel: [
                {label: '主键', name: 'a.id', hidden: true,frozen:true},
                {label: '组织机构', name: 'b.name',index:"b.name" ,width: 80, align: 'center',frozen:true},
                {label: '承运商/车牌号', name: 'c.liense',index:"c.liense" ,width: 90, align: 'center',frozen:true},
                {label: '承运商', name: 'car.name',index:"car.name" ,width: 80, align: 'center',frozen:true},
                {label: '司机', name: 'c.outDriver',index:"c.outDriver" ,width: 80, align: 'center',frozen:true},
                {label: '运单号',selectDefault:true, name: 'code', index:"a.code", type:"text",width: 150, align: 'center',frozen:true},
                {label: "核销状态", name: "slt.code", width: 60,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.HXZT['' + cellvalue + '']
                    }},
                {label: '运单日期', name: 'time', index:"a.time", type:"date",width: 80, align: 'center',frozen:true,
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '客户订单号', name: 'relatebill1',index:"a.relatebill1", width: 100,frozen:true, align: 'center'},
                {label: "核销", name: "a.jsStatus", width: 80,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return '<span onclick=\"hexiao(\''+rowObject[0]+'\',\'' + rowObject[11]+'\',\''+rowObject[12]+'\',\''+rowObject[13]+'\',\''+rowObject[24]+'\')\" class=\"label label-info\" style=\"cursor: pointer;\">核销操作</span>';}
                },
                {label: "台账明细", name: "a.jsStatus", width: 100,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return '<span onclick=\"feiyongmingxi(\''+ rowObject[24] +'\')\" class=\"label label-info\" style=\"cursor: pointer;\">查看费用明细</span>';}
                },
                {label: "应付金额", name: "a.jsStatus", width: 100,align: 'center'},
                {label: "已核销金额", name: "a.yhxmoney", width: 100,align: 'center'},
                {label: "未核销金额", name: "slt.code", width: 100,align: 'center'},
                {label: "总税金", name: "slt.code", width: 100,align: 'center'},
                {label: "核销次数", name: "slt.code", width: 70,align: 'center'},
                {label: "台账类型", name: "slt.code", width: 100,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.TZLX['' + cellvalue + '']
                    }},
                {label: '出发站点', name: 'fromCity',index:"a.fromCity",  width: 100, align: 'center'},
                {label: '目的站点', name: 'toCity', index:"a.toCity", width: 100, align: 'center'},
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
                {label: '运单号', name: 'ship.id',index:'ship.id',width: 10,hidden: true}
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
                var keyValue = $gridTable.jqGrid('getRowData', row_id)['a.id'];
                var subgrid_table_id = subgrid_id + "_t";
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "'></table>");
                var cellEdit = false;
                if (status == 1){
                    cellEdit = true
                }
                $("#" + subgrid_table_id).jqGrid({
                    url: "/verification/getVerificationRecordList.action",
                    postData: {id: keyValue},
                    datatype: "json",
                    height: "100%",
                    cellEdit:cellEdit,
                    cellurl:"/orderledger/editFree.action",
                    colModel: [
                        {label: '主键', name: 'id', hidden: true},
                        {label: '总金额', name: 'feeType.name',width: 100, align: 'center'},
                        {label: '已核销金额', name: 'taxRate', width: 100, align: 'center'},
                        {label: '核销金额', name: 'amount', width: 100, align: 'center' },
                        {label: '未核销金额', name: 'input', width: 100, align: 'center'},
                        {label: '核销人', name: 'operator', width: 100, align: 'center'},
                        {label: '核销时间', name: 'hxtime', width: 150, align: 'center',
                            formatter:function(cellvalue, options, row){
                                if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                                    return "";
                                }
                                return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                            }},
                        {label: '  ', name: '', width: 150, align: 'center'}
                    ],
                    caption: "核销明细",
                    rowNum: "1000",
                    rownumbers: true,
                    shrinkToFit: false,
                    gridview: true,
                    hidegrid: false,
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
                });
            },
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
        });
    }
    function hexiao(id,money,hxMoney,whxMoney,shipid) {
        dialogOpen({
            id: "Form",
            title: '核销',
            url: '/jsp/Verification/OutcomeVerificationForm.jsp?id=' + id +"&money="+money + "&hxmoney=" +hxMoney +"&whxMoney="+ whxMoney+"&shipid="+shipid,
            width: "850px",
            height: "550px",
            btn:[],
        });
    }
    var atype ="YD";
    function feiyongmingxi(id) {
        dialogOpen({
            id: "Form",
            title: '核销',
            url: '/jsp/Verification/FeeMXIndex.jsp?id=' + id+"&atype="+atype,
            width: "850px",
            height: "450px",
            btn:[],
        });
    }

</script>
<div class="ui-layout" id="layout" style="height: 100%; width: 100%;">
    <div class="ui-layout-west">
        <div class="west-Panel">
            <div class="profile-nav">
                <ul style="padding-top: 20px;">
                    <li onclick="onhand('weiVerification')">未核销</li>
                    <li onclick="onhand('bufenVerification')">部分核销</li>
                    <li onclick="onhand('yiVerification')">已核销</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="ui-layout-center">
        <div class="center-Panel">
            <div class="profile-content" style="background: #fff;">
                <div class="titlePanel">
                    <div class="title-search">
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
                            <%--<a id="income-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;整单核销</a>--%>
                            <%--<a id="income-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;部分核销</a>--%>
                        </div>
                        <script>$('.toolbar').authorizeButton()</script>
                    </div>
                </div>
                <div class="gridPanel">
                    <table id="gridTable"></table>
                    <div id="gridPager"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .file {
        position: relative;
        display: inline-block;
        overflow: hidden;
        text-decoration: none;
        text-indent: 0;
        cursor: pointer !important;
    }

    .file input {
        position: absolute;
        font-size: 150px;
        right: 0;
        top: 0;
        opacity: 0;
        cursor: pointer !important;
    }

    .file:hover {
        text-decoration: none;
        cursor: pointer !important;
    }

    .profile-content .formTitle {
        width: 100px;
        height: 20px;
        text-align: right;
    }
    .profile-content .formValue {
        width: 200px;
    }
    .profile-content .input-profile {
        border-radius: 4px;
        width: 60px;
    }
</style>
</body>
</html>