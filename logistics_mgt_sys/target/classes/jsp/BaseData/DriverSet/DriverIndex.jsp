<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/3/10
  Time: 9:27
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
    <title>司机管理</title>
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
        var url="/driver/getDriverList.action"
        if(status != null && status != undefined && status != ""){
            url+= "?status="+status
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
                {label: '司机名称', name: 'name', width: 100, align: 'center'},
                {label: '司机代码', name: 'code', width: 100, align: 'center'},
                {label: '组织机构', name: 'organization.name', width: 100,align: 'center'},
                //{label: '油卡', name: 'oilCards.code', width: 150,align: 'center'},
                {label: '性别', name: 'sex', width: 50,align: 'center'},
                {label: '出生日期', name: 'birthday',type:"date", width: 100,align: 'center',
                    formatter: function (cellvalue){
                        return formatDate(cellvalue,"yyyy-MM-dd");
                }},
                {label: '年龄', name: 'age', width: 50,align: 'center'},
                {label: '身份证', name: 'card', width: 200,align: 'center'},
                {label: '查看证件', width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return '<span onclick=\"getCredentials(\'' +rowObject.id+'\')\" class=\"label label-info\" style=\"cursor: pointer;\">点击查看</span>';
                    }},
                {label: '手机号', name: 'iphone1', width: 150,align: 'center'},
                {label: '领取驾驶证日期', name: 'dri', type:"date", width: 200,align: 'center',
                     formatter:function(cellvalue, options, rowObject){
                         return formatDate(cellvalue, "yyyy-MM-dd");
                     }},
                {label: '基本工资', name: 'baseWages', width: 80,align: 'center'},
                {label: '联系方式', name: 'contactway', width: 80,align: 'center'},
                {label: "状态", name: "status",type:"DD&CommDataStatus", width: 50, align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommDataStatus['' + cellvalue + '']
                    }
                },
                {label: '备注', name: 'description', width: 120,align: 'center'},
                {label: '创建人', name: 'create_Name', width: 120,align: 'center'},
                {label: '创建时间', name: 'create_Time',type:"date", width: 150,align: 'center'},
                {label: '修改人', name: 'modify_Name', width: 120,align: 'center'},
                {label: '修改时间', name: 'modify_Time', type:"date",width: 150,align: 'center'},
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
    }

    //外界调用返回id
    function getDriver(){
        var id = $("#gridTable").jqGridRowValue("id");
        if (checkedIds(id)) {
            return $("#gridTable").jqGrid('getRowData', id);
        }
    }
    function btn_add() {
        dialogOpen({
            id: "DriverForm",
            title: '添加司机',
            url: '/jsp/BaseData/DriverSet/DriverForm.jsp',
            width: "750px",
            height: "400px",
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
                id: "DriverForm",
                title: '修改司机',
                url: '/jsp/BaseData/DriverSet/DriverForm.jsp?keyValue=' + keyValue,
                width: "750px",
                height: "400px",
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
                msg: "注：您确定要修改司机状态？",
                url: "/driver/updateStatus.action",
                param: { tableName:"JC_DRIVER",status:status,id: keyValue },
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

    //上传证件
    function btn_upload(){
            keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "DForm",
                title: '上传',
                url: '/jsp/BaseData/DriverSet/index.jsp?keyValue=' + keyValue,
                width: "950px",
                height: "580px",
                btn: [],
                callBack: function (iframeId) {
                    //top.frames[iframeId].AcceptClick();
                }
            });
        }
    }

    //查看证件
    function  getCredentials(id) {
        dialogOpen({
            id: "DetailFrom",
            title: '证件明细',
            url: 'jsp/BaseData/DriverSet/showPic.jsp?driverId='+id,
            width: "1100px",
            height: "550px",
            callBack: function (iframeId) {
                top.frames[iframeId].dialogClose();//关闭窗口
            }
        });
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
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="driver-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
            <a id="driver-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
            <a id="driver-upload" class="btn btn-default" onclick="btn_upload()"><i class="fa fa-pencil-square-o"></i>&nbsp;上传证件</a>
            <a id="driver-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                <i class="fa fa-reorder"></i>&nbsp;更多<span class="caret"></span>
            </a>
            <ul class="dropdown-menu pull-right">
                <li id="driver-disabled"><a onclick="btn_Update(0)"><i></i>&nbsp;失效司机</a></li>
                <li id="driver-enabled"><a onclick="btn_Update(1)"><i></i>&nbsp;生效司机</a></li>
            </ul>
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