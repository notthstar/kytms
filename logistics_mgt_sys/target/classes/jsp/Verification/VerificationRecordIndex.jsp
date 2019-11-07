<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/29
  Time: 17:03
  To change this template use File | Settings | File Templates.
  核销记录表
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
    <title>核销记录表</title>
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
        var url="/trailer/getTrailerList.action"
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: url,
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true,frozen:true},
                {label: '组织机构', name: 'organization.name',index:"b.name" ,width: 120, align: 'center',frozen:true},
                {label: '订单号',selectDefault:true, name: 'code', index:"a.code", type:"text",width: 220, align: 'center',frozen:true,
                    cellattr:function addCellAttr(rowId, val, rawObject, cm, rdata) {
                        if(rawObject[26] == 1 ){
                            return "style='color:red'";
                        }
                    }},
                {label: '总金额', name: 'time', index:"a.time", type:"date",width: 150, align: 'center',frozen:true},
                {label: '核销金额', name: 'relatebill1',index:"a.relatebill1", width: 140,frozen:true, align: 'center'},
                {label: '未核销金额', name: 'fyTime',index:"a.fyTime", width: 140,frozen:true, align: 'center'},
                {label: '核销时间', name: 'ydTime',index:"a.ydTime", width: 140,frozen:true, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '核销人', name: 'costomerType',index:"a.costomerType",  type:"DD&CustomerType",width: 60, align: 'center'},
                {label: '核销状态', name: 'customer.name',index:"c.name", width: 200, align: 'center'},

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
            ],
            viewrecords: true,
            rowNum: 30,
            rowList: [30, 50, 100],
            pager: "#gridPager",
            sortname: 'invdate',
            sortorder: "desc",
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
                btn_edit(  $gridTable.getCell(a,"id"))
            },

        });
        //$gridTable.authorizeColModel()
        //初始化查询条件
        initJGGridselectView($gridTable);
    }
    function btn_add() {
        dialogOpen({
            id: "PrescoForm",
            title: '新增预录单',
            url: '/jsp/Presco/PrescoForm.jsp',
            width: "1250px",
            height: "600px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick();
            }
        });
    };

    function btn_edit(id) {
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("id");
        }else {
            keyValue = id
        }
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "PrescoForm",
                title: '修改预录单',
                url: '/jsp/Presco/PrescoForm.jsp?keyValue=' + keyValue,
                width: "850px",
                height: "500px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    function btn_Update(status) {
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        if (keyValue) {
            $.ConfirmAjax({
                msg: "注：您确定要修改预录单状态？",
                url: "/single/updateStatus.action",
                param: { tableName:"JC_TRAILER",status:status,id: keyValue },
                success: function (data) {
                    $("#gridTable").trigger("reloadGrid");
                    if (data.type) {
                        dialogMsg(data.obj, 1);
                    } else {
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }
    }
</script>
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
                    <a id="btn_history" class="btn btn-default"  style="margin-left: 25px">历史单据</a>
                    <a id="btn_new" class="btn btn-default"   style="margin-left: 25px;display:none">未执行单据</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <%--<a id="beforehand-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>--%>
            <%--<a id="beforehand-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>--%>
            <%--<a id="beforehand-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-trash-o"></i>&nbsp;删除</a>--%>
            <%--<a id="beforehand-edit" class="btn btn-default" onclick="btn_zz()"><i class="fa fa-trash-o"></i>&nbsp;转成订单</a>--%>
            <%--<a id="beforehand-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">--%>
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
    <table id="gridTable"></table>
    <div id="gridPager"></div>
</div>
</body>
</html>

