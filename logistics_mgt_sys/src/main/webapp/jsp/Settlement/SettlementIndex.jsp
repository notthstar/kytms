<%--
  Created by IntelliJ IDEA.
  User: 孙德增
  Date: 2018/5/25
  Time: 10:25
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
    <title>结算表</title>
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
    }
    //加载表格
    function GetGrid() {
        var url="/settlement/getSettlementList.action"
        if(status != null && status != undefined && status != ""){
            url+= "&status="+status
        }
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: url,
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '操作',width: 120, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return '<span onclick=\"btn_selectBean(\'' + rowObject[2] + '\',\''+rowObject[7]+'\')\" class=\"label label-info\" style=\"cursor: pointer;\">查看数据</span>';
                    }
                },
                {label: '项目名称', name: 'projectManagement.name', width: 160, align: 'center'},
                {label: '结算名称', name: 'name', width: 260, align: 'center'},
                {label: '结算代码', name: 'code', width: 200, align: 'center'},
                {label: '结算日期', name: 'time', width: 200, align: 'center',
                 formatter:function(cellvalue, options, row){
                     if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                         return "";
                     }
                     return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                 }},
                {label: '类型', name: 'way',type:"DD&JSLX", width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.JSLX['' + cellvalue + '']
                    }
                },
                {label: "状态", name: "jsStatus",type:"DD&JSZT",width: 80, align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.JSZT['' + cellvalue + '']
                    }
                },
                {label: '结算开始时间', name: 'beginTime', width: 150, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd")
                    }},
                {label: '结算结束时间', name: 'endTime', width: 150, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd")
                    }},
                {label: '描述',name:'description',width:220,align:'center'},
                {label: '创建人', name: 'create_Name', width: 120,align: 'center'},
                {label: '创建时间', name: 'create_Time',type:"date", width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '修改人', name: 'modify_Name', width: 120,align: 'center'},
                {label: '修改时间', name: 'modify_Time',type:"date", width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }}
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
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            }
        });
        //$gridTable.authorizeColModel()
        //初始化查询条件
        initJGGridselectView($gridTable);
    }
    function btn_selectBean(prmt,sta){
        if(sta == 3){
            var rpg = "项目预结算表组.rpg"; //报表名称
            var getUrl = "reportJsp/showReportGroup.jsp";//报表请求URL地址
            var url = getUrl + "?rpg=" + rpg + "&arg1=" + prmt; //按发运日期结算
                dialogOpen({
                    id: "xmyjs",
                    title: '项目预结算',
                    url: url,
                    width: "1200px",
                    height: "1000px",
                    btn: []
                });
        }else if(sta == 1){
            var rpg = "项目结算报表组.rpg"; //报表名称
            var getUrl = "reportJsp/showReportGroup.jsp";//报表请求URL地址
            var url = getUrl + "?rpg=" + rpg + "&arg1=" + prmt;//按发运日期结算
                dialogOpen({
                    id: "xmyjs",
                    title: '项目结算',
                    url: url,
                    width: "1200px",
                    height: "1000px",
                    btn: []
                });
        }

    }

    function btn_edit() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        var status1 = $("#gridTable").jqGridRowValue("jsStatus");
        var prmt = $("#gridTable").jqGridRowValue("name");
        if(status1 == "已结算"){
            dialogAlert("只能结算未结算的数据");
            return;
        }
        if (checkedRow(keyValue)) {
            $.ajax({
                url: "/settlement/updateAllSta.action?id="+ keyValue,
                type:"post",
                async:false,
                dataType : 'JSON',
                loading: "正在保存数据...",
                success:function(data) {
                    dialogAlert(data)
                    dialogClose();
                }
            })

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
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="vehiclePlan-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;结算</a>
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


