<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/11
  Time: 15:40
  To change this template use File | Settings | File Templates.
  其他成本核销
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
    <title>其他成本核销</title>
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
//        //resize重设(表格、树形)宽高
//        $(window).resize(function (e) {
//            window.setTimeout(function () {
////                $('#gridTable').setGridWidth(($('.gridPanel').width()));
////                $("#gridTable").setGridHeight($(window).height() - 136.5);
//            }, 200);
//            e.stopPropagation();
//        });
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
    }
    //侧面切换显示/隐藏 //分布加载
    function onhand(id) {
        $(".profile-content").find('.flag').hide()
        $(".profile-content").find("#" + id).show();
        if(id = 'weiVerification'){//未核销
            weiVerification();
        }
        if(id = 'bufenVerification'){//部分核销
            bufenVerification();
        }
        if(id = 'yiVerification'){//已核销
            yiVerification();
        }
    }
    function weiVerification(){//未核销
        var selectedRowIndex = 0;
        var $gridTable1 = $('#weiVerification1');
        $gridTable1.jqGrid({
            url: "/shipment/getAddressInfo.action",
            datatype: "json",
            height: $(window).height() - 110,
            autowidth: false,
            width:1195,
            colModel: [
                {label: '主键', name: 'id', hidden: true,frozen:true},
                {label: '组织机构', name: 'organization.name',index:"b.name" ,width: 120, align: 'center',frozen:true},
                {label: '费用发生日期', name: 'time', index:"a.time", type:"date",width: 150, align: 'center',frozen:true,
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '费用名称', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '费用金额', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '经手人', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '已核销金额', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '未核销金额', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '核销人', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '核销日期', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
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
                {label: '异常', name: 'isAbnormal',index:"a.isAbnormal", hidden: true},
                {label: "状态", name: "st",hidden: true},
            ],
            pager: false,
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            multiselect: true,//复选框
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
        });
    }
    function bufenVerification(){//部分核销
        var selectedRowIndex = 0;
        var $gridTable1 = $('#bufenVerification1');
        $gridTable1.jqGrid({
            url: "/shipment/getAddressInfo.action",
            datatype: "json",
            height: $(window).height() - 110,
            autowidth: false,
            width:1195,
            colModel: [
                {label: '主键', name: 'id', hidden: true,frozen:true},
                {label: '组织机构', name: 'organization.name',index:"b.name" ,width: 120, align: 'center',frozen:true},
                {label: '费用发生日期', name: 'time', index:"a.time", type:"date",width: 150, align: 'center',frozen:true,
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '费用名称', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '费用金额', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '经手人', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '已核销金额', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '未核销金额', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '核销人', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '核销日期', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
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
                {label: '异常', name: 'isAbnormal',index:"a.isAbnormal", hidden: true},
                {label: "状态", name: "st",hidden: true},
            ],
            pager: false,
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            multiselect: true,//复选框
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
        });
    }
    function yiVerification(){//配送库
        var selectedRowIndex = 0;
        var $gridTable1 = $('#yiVerification1');
        $gridTable1.jqGrid({
            url: "/shipment/getAddressInfo.action",
            datatype: "json",
            height: $(window).height() - 110,
            autowidth: false,
            width:1195,
            colModel: [
                {label: '主键', name: 'id', hidden: true,frozen:true},
                {label: '组织机构', name: 'organization.name',index:"b.name" ,width: 120, align: 'center',frozen:true},
                {label: '费用发生日期', name: 'time', index:"a.time", type:"date",width: 150, align: 'center',frozen:true,
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '费用名称', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '费用金额', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '经手人', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '已核销金额', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '未核销金额', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '核销人', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '核销日期', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
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
                {label: '异常', name: 'isAbnormal',index:"a.isAbnormal", hidden: true},
                {label: "状态", name: "st",hidden: true},
            ],
            pager: false,
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            multiselect: true,//复选框
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
        });
    }

    function btn_addztzyd() {
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        if (keyValue) {
            dialogOpen({
                id: "SinceTicketForm",
                title: '自提作业单',
                url: '/jsp/OnRepertory/SinceTicketForm.jsp?id='+id,
                width: "1250px",
                height: "600px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
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
                <%--未核销--%>
                <div id="weiVerification" class="flag" style="display: none;">
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
                                <a id="other-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;整单核销</a>
                                <a id="other-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;部分核销</a>
                                <%--<a id="trailer-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">--%>
                                <%--<i class="fa fa-reorder"></i>&nbsp;更多<span class="caret"></span>--%>
                                <%--</a>--%>
                                <%--<ul class="dropdown-menu pull-right">--%>
                                <%--<li id="trailer-disabled"><a onclick="btn_Update(0)"><i></i>&nbsp;失效车挂</a></li>--%>
                                <%--<li id="trailer-enabled"><a onclick="btn_Update(1)"><i></i>&nbsp;生效车挂</a></li>--%>
                                <%--</ul>--%>
                            </div>
                            <script>$('.toolbar').authorizeButton()</script>
                        </div>
                    </div>
                    <div class="gridPanel">
                        <table id="weiVerification1"></table>
                    </div>
                </div>
                <%--部分核销--%>
                <div id="bufenVerification" class="flag" style="display: none;">
                    <div class="titlePanel">
                        <div class="title-search">
                            <table>
                                <tr>
                                    <td>
                                        <div   id="queryCondition1" class="btn-group">
                                            <a class="btn btn-default dropdown-text" data-value="code"
                                               data-toggle="dropdown">选择条件</a>
                                            <a class="btn btn-default dropdown-toggle" data-toggle="dropdown"><span
                                                    class="caret"></span></a>
                                            <ul  id="queryLi1" class="dropdown-menu">
                                            </ul>
                                        </div>
                                    </td>
                                    <td id="keyWord1" style="padding-left: 2px;">
                                        <input  id="txt_Keyword1" type="text" class="form-control" placeholder="请输入要查询关键字" style="width: 200px;"/>
                                    </td>
                                    <td style="padding-left: 5px;">
                                        <a id="btn_Search1" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;查询</a>
                                        <a id="btn_HigtSearch1" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;高级查询</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="toolbar">
                            <div class="btn-group">
                                <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
                                <a id="other-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;整单核销</a>
                                <a id="other-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;部分核销</a>
                                <%--<a id="trailer-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">--%>
                                <%--<i class="fa fa-reorder"></i>&nbsp;更多<span class="caret"></span>--%>
                                <%--</a>--%>
                                <%--<ul class="dropdown-menu pull-right">--%>
                                <%--<li id="trailer-disabled"><a onclick="btn_Update(0)"><i></i>&nbsp;失效车挂</a></li>--%>
                                <%--<li id="trailer-enabled"><a onclick="btn_Update(1)"><i></i>&nbsp;生效车挂</a></li>--%>
                                <%--</ul>--%>
                            </div>
                            <script>$('.toolbar').authorizeButton()</script>
                        </div>
                    </div>
                    <div class="gridPanel">
                        <table id="bufenVerification1"></table>
                    </div>
                </div>
                <%--已核销--%>
                <div id="yiVerification" class="flag" style="display: none;">
                    <div class="titlePanel">
                        <div class="title-search">
                            <table>
                                <tr>
                                    <td>
                                        <div   id="queryCondition2" class="btn-group">
                                            <a class="btn btn-default dropdown-text" data-value="code"
                                               data-toggle="dropdown">选择条件</a>
                                            <a class="btn btn-default dropdown-toggle" data-toggle="dropdown"><span
                                                    class="caret"></span></a>
                                            <ul  id="queryLi2" class="dropdown-menu">
                                            </ul>
                                        </div>
                                    </td>
                                    <td id="keyWord2" style="padding-left: 2px;">
                                        <input  id="txt_Keyword2" type="text" class="form-control" placeholder="请输入要查询关键字" style="width: 200px;"/>
                                    </td>
                                    <td style="padding-left: 5px;">
                                        <a id="btn_Search2" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;查询</a>
                                        <a id="btn_HigtSearch2" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;高级查询</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="toolbar">
                            <div class="btn-group">
                                <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
                                <%--<a id="imbedding-since" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;置入自提库</a>--%>
                                <%--<a id="imbedding-ransfer" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;置入中转库</a>--%>
                                <%--<a id="trailer-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">--%>
                                <%--<i class="fa fa-reorder"></i>&nbsp;更多<span class="caret"></span>--%>
                                <%--</a>--%>
                                <%--<ul class="dropdown-menu pull-right">--%>
                                <%--<li id="trailer-disabled"><a onclick="btn_Update(0)"><i></i>&nbsp;失效车挂</a></li>--%>
                                <%--<li id="trailer-enabled"><a onclick="btn_Update(1)"><i></i>&nbsp;生效车挂</a></li>--%>
                                <%--</ul>--%>
                            </div>

                            <script>$('.toolbar').authorizeButton()</script>
                        </div>
                    </div>
                    <div class="gridPanel">
                        <table id="yiVerification1"></table>
                    </div>
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