<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/4 0004
  Time: 下午 7:23
  收发货方
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
    <title>规则引擎</title>
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
    function  dev(id){
        dialogOpen({
            id: "RuleDev",
            title: '规则开发',
            url: 'jsp/Rule/RuleDev.jsp?keyValue=' + id,
            width: "800px",
            height: "650px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick();
            }
        });
    }
    function ziduanweihu(id){
        dialogOpen({
            id: "ziduanweihu",
            title: '字段维护',
            url: 'jsp/RuleTable/RuleTableDev.jsp?keyValue=' + escape(id),
            width: "800px",
            height: "550px",
            callBack: function (iframeId) {

            },
            btn: [],
        });
    }
    function dataSafeguard(id){
        dialogOpen({
            id: "shujuweihu",
            title: '数据维护',
            url: 'jsp/RuleTable/RuleTableData.jsp?keyValue=' + escape(id),
            width: "800px",
            height: "550px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick();
            },
        });
    }


    //加载表格
    function GetGrid() {
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: "/ruletable/getList.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'TABLE_NAME', hidden: true},
                {label: '表名称',selectDefault:true, name: 'TABLE_NAME', width: 300, align: 'center'},
                {label: '引擎类型',name: 'ENGINE', width: 150, align: 'center'},
                {label: '数据量',name: 'TABLE_ROWS', width: 150, align: 'center'},
                {label: '字段维护', name: '123', width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return '<span onclick=\"ziduanweihu(\'' +rowObject.TABLE_NAME+'\')\" class=\"label label-info\" style=\"cursor: pointer;\">字段维护</span>';
                    }},
                {label: '数据维护', name: '4321', width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return '<span onclick=\"dataSafeguard(\'' +rowObject.TABLE_NAME+'\')\" class=\"label label-info\" style=\"cursor: pointer;\">数据维护</span>';
                    }},
                {label: '备注',name: 'TABLE_COMMENT', width: 150, align: 'center'},
            ],
            pager: false,
            rowNum: "1000",
            viewrecords: true,
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            multiselect: true,//复选框
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            },
//            ondblClickRow:function(a,b,c){
//                btn_edit(  $gridTable.getCell(a,"id"))
//            },
        });
        //初始化查询页面

    }
    function btn_add() {
        dialogOpen({
            id: "addRuleTable",
            title: '添加表',
            url: 'jsp/RuleTable/RuleTableForm.jsp',
            width: "300px",
            height: "250px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick();
            }
        });
    };
    function getReceivingParty(){
        var id = $("#gridTable").jqGridRowValue("id");
        if (checkedIds(id)) {
            return $("#gridTable").jqGrid('getRowData', id);
        }
    }
    function btn_edit(id) {
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("TABLE_NAME");
        }else {
            keyValue = id
        }

        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "AlertRuleTable",
                title: '修改表',
                url: 'jsp/RuleTable/RuleTableForm.jsp?keyValue='+escape(keyValue),
                width: "300px",
                height: "250px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }





    //删除
    function btn_delete() {
        keyValue = $("#gridTable").jqGridRowValue("TABLE_NAME");
        console.log(keyValue)
        if (keyValue) {
            $.RemoveForm({
                url: "/ruletable/deleteTable.action",
                param: { tableName:keyValue},
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
            dialogMsg('请选择需要删除的数据！', 0);
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
            <a id="receivingParty-replace" class="btn btn-default" onclick="reload();"></i>&nbsp;刷新</a>
            <a id="receivingParty-add" class="btn btn-default" onclick="btn_add()"></i>&nbsp;新增</a>
            <a id="receivingParty-edit" class="btn btn-default" onclick="btn_edit()">&nbsp;编辑</a>
            <a id="receivingParty-del" class="btn btn-default" onclick="btn_delete()"></i>&nbsp;删除</a>
        </div>
    </div>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
</div>
</body>
</html>