<%--
  Created by IntelliJ IDEA.
  User: 陈小龙
  Date: 2018/4/9
  Time: 9:00
  运单模板
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
    <title>运单模板</title>
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
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: "/template/getTemplateList.action",
            datatype: "json",
            height: $(window).height() - 136.5,

            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '所属组织机构', name: 'organization.name', width: 120, align: 'center'},
                {label: '模板名称', name: 'name', width: 120, align: 'center'},
                {label: '模板代码', name: 'code', width: 120, align: 'center'},
                {label: '运作模式', name: 'operationPattern', width: 90,align: 'center',type:"DD&OperationPattern",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OperationPattern['' + cellvalue + '']
                    }},
                {label: '承运商名称', name: 'carrier.name', width: 150,align: 'center'},
               /* {label: '承运商类型', name: 'carrierType', width: 90,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CarrierType['' + cellvalue + '']
                    }},*/
                {label: '出发站', name: 'fromOrganization.name', width: 120,align: 'center'},
                {label: '目的站', name: 'toOrganization.name', width: 120,align: 'center'},
                {label: '车型', name: 'vehicle.code', width: 120,align: 'center'},

                {label: '创建人', name: 'create_Name', width: 120,align: 'center'},
                {label: '创建时间', name: 'create_Time', width: 150,align: 'center'},
                {label: '修改人', name: 'modify_Name', width: 120,align: 'center'},
                {label: '修改时间', name: 'modify_Time', width: 150,align: 'center'},
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
            ondblClickRow:function(a,b,c){
                btn_edit(  $gridTable.getCell(a,"id"))
            },
        });

        //初始化查询页面
        initJGGridselectView($gridTable);
        $gridTable.jqGrid('setFrozenColumns');
    }

    function btn_add() {
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
            title: '运单模板',
            fix: false,
            area: [_width, _height],
            content: top.contentPath +  '/jsp/ShipmentTemplate/TemplateForm.jsp?',
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
    ;
    //编辑
    function btn_edit() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
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
                title: '运单模板',
                fix: false,
                area: [_width, _height],
                content: top.contentPath +  '/jsp/ShipmentTemplate/TemplateForm.jsp?keyValue=' + keyValue,
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

    /**
     * 别的窗口调用此方法，返回选择值，并过滤掉失效合同
     */
    function getTemplate() {
        var id = $("#gridTable").jqGridRowValue("id");
        if (checkedIds(id)) {
            return $("#gridTable").jqGrid('getRowData', id);
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
            <a id="template-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增模板</a>
            <a id="template-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑模板</a>
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
