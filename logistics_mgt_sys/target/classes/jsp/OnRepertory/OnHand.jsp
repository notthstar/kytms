<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2017/12/04
  Time: 21:27
  在库表单
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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>在库表单</title>
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
        $("#zitidan").hide();
    });
    //初始化数据
    function InitControl() {
        //resize重设(表格、树形)宽高
        $(window).resize(function (e) {
            window.setTimeout(function () {
                $('#gridTable').setGridWidth(($('.gridPanel').width()));
                $("#gridTable").setGridHeight($(window).height() - 136.5);
            }, 200);
            e.stopPropagation();
        });
    }
    //初始化页面
    function InitialPage() {
        //layout布局
        $('#layout').layout({
            applyDemoStyles: false,
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
//        $(".profile-content").find('.flag').hide();
//        $(".profile-content").find("#" + id).show();
        if(id =='operational'){//待运库
            $('#gridTable').jqGrid('setGridParam', {
                postData: {
//                    whereName: "a.status",
//                    whereValue:"2",
                    id:"operational"
                },
                page: 1
            }).trigger('reloadGrid');
            $("#zitidan").hide();
        }else if(id=='since'){//自提库
            $('#gridTable').jqGrid('setGridParam', {
                postData: {
//                    whereName: "a.status",
//                    whereValue:"9",
                    id:"since"
                },
                page: 1
            }).trigger('reloadGrid');
            $("#zitidan").show();
        }else if(id == 'dispatching'){//配送库
            $('#gridTable').jqGrid('setGridParam', {
                postData: {
//                    whereName: "a.status",
//                    whereValue:"10",
                    id:"dispatching"
                },
                page: 1
            }).trigger('reloadGrid');
            $("#zitidan").hide();
        }else if(id == 'ransfer'){//中转库
            $('#gridTable').jqGrid('setGridParam', {
                postData: {
//                    whereName: "a.status",
//                    whereValue:"5",
                    id:"ransfer"
                },
                page: 1
            }).trigger('reloadGrid');
            $("#zitidan").hide();
        }else if(id =='tomention'){//待提库
            $('#gridTable').jqGrid('setGridParam', {
                postData: {
//                    whereName: "a.status",
//                    whereValue:"12",
                    id:"tomention"
                },
                page: 1
            }).trigger('reloadGrid');
            $("#zitidan").hide();
        }
    }

    function GetGrid(){
        var url = "/transportorder/getOrderDy.action";
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url:url,
            datatype: "json",
            height: $(window).height()-150,
            autowidth: false,
            width:1195,
            colModel: [
                {label: '主键', name: 'id', hidden: true,frozen:true},
                {label: '订单主键', name: 'aor.id', hidden: true,frozen:true},
                {label: '组织机构', name: 'organization.name',index:"b.name" ,width: 80, align: 'center',frozen:true},
                {label: '分段订单号', name: 'code', index:"a.code", type:"text",width: 160, align: 'center',frozen:true,
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
                {label: '订单状态', name: 'status',type:"DD&OrderStatus",index:"a.status", width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
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
                {label: '货名',name:'f.name',width: 40,index:"f.name",align: 'center'},
                {label: '件数', name: 'number',index:"a.number", width: 80, align: 'center'},
                {label: '重量', name: 'weight',index:"a.weight", width: 80, align: 'center'},
                {label: '体积', name: 'volume',index:"a.volume", width:80, align: 'center'},
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
            pager: false,
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            multiselect: true,//复选框
            footerrow: true,
            multiboxonly: true,
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            ondblClickRow:function(a,b,c){
                    btn_edit($gridTable.getCell(a,"aor.id"))
            },
            gridComplete: function () {
                var number = $(this).getCol("number", false, "sum");
                var weight = $(this).getCol("weight", false, "sum");
                var volume = $(this).getCol("volume", false, "sum");
                //合计
                $(this).footerData("set", {
                    "code": "合计：",
                    "number": "数量:" + number,
                    "weight": "重量:" + weight,
                    "volume": "体积:" + volume
                });
            },
        });
    }
    function zitidan(){
        var   keyValue = $("#gridTable").jqGridRowValue("id");
        var st =$("#gridTable").jqGridRowValue("st");
        if(st!=9){
            alert("只能签收是自提的订单");
        }else{
            if (checkedRow(keyValue)) {
                dialogOpen({
                    id: "SinceTicketForm",
                    title: '修改预录单',
                    url: '/jsp/OnRepertory/SinceTicketForm.jsp?keyValue=' + keyValue,
                    width: "650px",
                    height: "400px",
                    callBack: function (iframeId) {
                        top.frames[iframeId].AcceptClick();
                    }
                });
            }
        }
    }

    function btn_edit(id) {
        var keyValue = $("#gridTable").jqGridRowValue("aor.id");
         id = $("#gridTable").jqGridRowValue("aor.id");
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
</script>
<div class="ui-layout" id="layout" style="height: 100%; width: 100%;">
    <div class="ui-layout-west">
        <div class="west-Panel">
            <div class="profile-nav">
                <ul style="padding-top: 20px;">
                    <li onclick="onhand('operational')">待运库</li>
                    <li onclick="onhand('since')">自提库</li>
                    <li onclick="onhand('dispatching')">配送库</li>
                    <li onclick="onhand('ransfer')">中转库</li>
                    <li onclick="onhand('tomention')">待提库</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="ui-layout-center">
        <div class="center-Panel">
            <div class="profile-content" style="background: #fff;">
                <%--<div id="operational" class="flag" style="display: none;">--%>
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
                                <a id="zitidan" class="btn btn-default" onclick="zitidan();"><i class="fa fa-refresh"></i>&nbsp;自提签收</a>
                            </div>
                            <script>$('.toolbar').authorizeButton()</script>
                        </div>
                    </div>
                        <div class="gridPanel" style="width: 1195px">
                            <table id="gridTable"></table>
                        </div>
                </div>
            <%--</div>--%>
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