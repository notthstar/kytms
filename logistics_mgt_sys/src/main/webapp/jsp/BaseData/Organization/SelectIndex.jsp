<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/4/8
  Time: 19:44
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
    <title>查询用组织机构</title>
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
        getOrg();
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
    function getOrg(){
        var id = $("#gridTable").jqGridRowValue("id");
        var selectedRowIndex = $("#gridTable").getGridParam('selrow');
//        if (checkedIds(id)) {
            return id;
//        }
    }

    //加载表格
    function GetGrid() {
        var url="/org/getOrgList.action"
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: url,
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: "主键", name: "id", index: "id", hidden: true},
                {label: "名称", name: "name",  width: 130, align: "left"},
                {label: "编码", name: "code",  width: 130, align: "left"}
//                {label: "类型", name: "type", type:"DD&OrgType", width: 50, align: "center",
//                    formatter: function (cellvalue, options, rowObject) {
//                        return top.clientdataItem.OrgType['' + cellvalue + '']
//                    }
//                },
//                {
//                    label: "状态", name: "status", width: 70,type:"DD&CommDataStatus", align: "center",
//                    formatter: function (cellvalue, options, rowObject) {
//                        return top.clientdataItem.CommDataStatus['' + cellvalue + '']
//                    }
//                }
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
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            },
        });
        //初始化查询页面
        initJGGridselectView($gridTable);
    }
//    function btn_add() {
//        dialogOpen({
//            id: "JcPlanForm",
//            title: '添加计划',
//            url: '/jsp/PlanOrder/JcPlanForm.jsp',
//            width: "800px",
//            height: "400px",
//            callBack: function (iframeId) {
//                top.frames[iframeId].AcceptClick();
//            }
//        });
//    };
//    function btn_edit() {
//        var keyValue = $("#gridTable").jqGridRowValue("id");
//        console.log(keyValue)
//        if (checkedRow(keyValue)) {
//            dialogOpen({
//                id: "JcPlanForm",
//                title: '修改计划',
//                url: '/jsp/PlanOrder/JcPlanForm.jsp?keyValue=' + keyValue,
//                width: "800px",
//                height: "400px",
//                callBack: function (iframeId) {
//                    top.frames[iframeId].AcceptClick();
//                }
//            });
//        }
//
//    }
//    function btn_complete(planstarts) {
//        var keyValue = $("#gridTable").jqGridRowValue("id");
//        if(keyValue){
//            $.ConfirmAjax({
//                msg: "注：您确定该计划已经完成？",
//                url: "/plan/updatePlanStarts.action",
//                param: { tableName:"JC_PLAN",planstarts:planstarts,id: keyValue },
//                success: function (data) {
//                    $("#gridTable").trigger("reloadGrid");
//                    if (data.type) {
//                        dialogMsg(data.obj, 1);
//                    } else {
//                        dialogAlert(data.obj, -1);
//                    }
//                }
//            })
//        }
//    }
//    function btn_Update(status) {
//        var  keyValue = $("#gridTable").jqGridRowValue("id");
//        if (keyValue) {
//            $.ConfirmAjax({
//                msg: "注：您确定要修改计划单状态？",
//                url: "/plan/updateStatus.action",
//                param: { tableName:"JC_PLAN",status:status,id: keyValue },
//                success: function (data) {
//                    $("#gridTable").trigger("reloadGrid");
//                    if (data.type) {
//                        dialogMsg(data.obj, 1);
//                    } else {
//                        dialogAlert(data.obj, -1);
//                    }
//                }
//            })
//        }
//    }
</script>
<div class="titlePanel">
    <div  class="title-search">
        <table>
            <tr>
                <td>
                    <div   id="queryCondition" class="btn-group">
                        <a class="btn btn-default dropdown-text" data-value="code" data-toggle="dropdown">选择条件</a>
                        <a class="btn btn-default dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
                        <ul  id="queryLi" class="dropdown-menu"></ul>
                    </div>
                </td>
                <td id="keyWord" style="padding-left: 2px;">
                    <input  id="txt_Keyword" type="text" class="form-control" placeholder="请输入要查询关键字" style="width: 100px;"/>
                </td>
                <td style="padding-left: 5px;">
                    <a id="btn_Search" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;查询</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="org-buttonhorize" class="btn btn-default" onclick="ConfirmAll()"><i class="fa fa-th"></i>&nbsp;批量确认</a>
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <%--<a id="plan-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>--%>
            <%--<a id="plan-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>--%>
            <%--<a id="plan-complete" class="btn btn-default" onclick="btn_complete(0)"><i class="fa fa-pencil-square-o"></i>&nbsp;计划完成</a>--%>
            <%--<a id="plan-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">--%>
                <%--<i class="fa fa-reorder"></i>&nbsp;更多<span class="caret"></span>--%>
            <%--</a>--%>
            <%--<ul class="dropdown-menu pull-right">--%>
                <%--<li id="plan-disabled"><a onclick="btn_Update(1)"><i></i>&nbsp;生效计划</a></li>--%>
                <%--<li id="plan-enabled"><a onclick="btn_Update(0)"><i></i>&nbsp;失效计划</a></li>--%>
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


