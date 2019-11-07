<%--
  Created by IntelliJ IDEA.
  User: cxl
  Date: 2018-10-29
  Time: 11:41
  费用传递
  To change this template use File | Settings | File Templates.
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
    <title>费用传递</title>
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
        //按钮权限控制
        $('.toolbar').authorizeButton();
        InitialPage();
        GetGrid();
        initHigtQuery($("#btn_HigtSearch"),$('#gridTable'));
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
    }
    //加载表格
    function GetGrid() {
        var url="/feeSeed/getFeeSeedList.action"
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: url,
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
               /* {label: '组织机构', name: 'organization.name', width: 150, align: 'center'},*/
                {label: '发起机构', name: 'startOrganization.name', width: 150, align: 'center'},
                {label: '接收机构', name: 'receiveOrganization.name', width: 150, align: 'center'},
                {label: '费用编号', name: 'code', width: 200, align: 'center'},
                {label: '费用合计', name: 'amount', width: 100,align: 'center'},
                {label: '税金合计', name: 'input', width: 100,align: 'center'},
                {label: '费用标识', name: 'feeSign', width: 80,align: 'center',type:"DD&FeeSign",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.FeeSign['' + cellvalue + '']
                    }},
                {label: '发生时间', name: 'time', width: 150,align: 'center'},
                {label: '确认状态', name: 'confirmStatus', width: 100,align: 'center',type:"DD&ConfirmStatus",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.ConfirmStatus['' + cellvalue + '']
                    }},
                {label: "备注", name: "description", width: 300, align: "center"},
                {label: '创建人', name: 'create_Name', width: 100,align: 'center'},
                {label: '创建时间', name: 'create_Time', width: 150,align: 'center'},
                {label: '修改人', name: 'modify_Name', width: 100,align: 'center'},
                {label: '修改时间', name: 'modify_Time', width: 150,align: 'center'}
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
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            },
            loadComplete: function() {

            },
//            ondblClickRow:function(a,b,c){
//                btn_edit(  $gridTable.getCell(a,"id"))
//            },
        });
        //初始化查询页面
        $gridTable.jqGrid('setFrozenColumns');
        initJGGridselectView($gridTable);
    }
    function btn_add() {
        dialogOpen({
            id: "FeeSeedFrom",
            title: '添加',
            url: '/jsp/FeeSeed/FeeSeedForm.jsp',
            width: "800px",
            height: "450px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick();
            }
        });
    };
    function btn_edit(id) {

        var keyValue = undefined;
        var confirmStatus= escape($("#gridTable").jqGridRowValue("confirmStatus"));
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("id");
        }else {
            keyValue = id
        }
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "FeeSeedFrom",
                title: '修改',
                url: '/jsp/FeeSeed/FeeSeedForm.jsp?keyValue=' + keyValue+'&confirmStatus='+confirmStatus,
                width: "800px",
                height: "450px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }

    function confirm(status) {
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedArray(keyValue)) {
            $.ConfirmAjax({
                msg: "注：您确定要确认这些费用?确认后不能在更改!",
                url: "/feeSeed/confirm.action",
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
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="fee-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
            <a id="fee-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
            <a id="fee-confirm" class="btn btn-default" onclick="confirm()"><i class="fa fa-plus"></i>&nbsp;确认</a>
        </div>
    </div>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
    <div id="gridPager"></div>
</div>
</body>
</html>