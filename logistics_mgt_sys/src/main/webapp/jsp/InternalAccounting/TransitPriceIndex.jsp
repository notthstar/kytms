<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/26
  Time: 13:36
  To change this template use File | Settings | File Templates.
  中转区域单价表
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
    <title>中转区域单价表</title>
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
    var shipmentSign=request('shipmentSign');
    $(function () {
        //按钮权限控制
        $('.toolbar').authorizeButton();
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
    function getVehicleHead(){
        var id = $("#gridTable").jqGridRowValue("id");
        if (checkedIds(id)) {
            return id;
        }
    }

    //加载表格
    function GetGrid() {
        var url="/vehicleHead/getVehicleHeadList.action"
        if(status != null && status != undefined && status != ""){
            url+= "?status="+status
        }
        if(shipmentSign=="1"){
            url+="&whereValue="+shipmentSign;
        }
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: url,
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id',index:'jvh.id', hidden: true},
                {label: '区域名称', name: 'jcRegistration.name',index:'jvh.jcRegistration.name', width: 150, align: 'center'},
                {label: '区域代码', name: 'organization.name',index:'jvh.organization.name', width: 150, align: 'center'},
                {label: '最低收费', name: 'organization1.name',index:'jvh.organization1.name', width: 150, align: 'center'},
                {label: '吨单价',selectDefault:true,name: 'code',index:'jvh.code', width: 100,align: 'center'},
                {label: '方单价',selectDefault:true,name: 'code',index:'jvh.code', width: 100,align: 'center'},
                {label: '创建人', name: 'create_Name',index:'jvh.create_Name', width: 100,align: 'center'},
                {label: '创建时间', name: 'create_Time',index:'jvh.create_Time',type:'date', width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '修改人', name: 'modify_Name',index:'jvh.modify_Name', width: 100,align: 'center'},
                {label: '修改时间', name: 'modify_Time',index:'jvh.modify_Time', type:'date', width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},

                {label: "备注", name: "description", width: 300, align: "center"}
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
//            ondblClickRow:function(a,b,c){
//                btn_edit(  $gridTable.getCell(a,"id"))
//            },


        });
        //初始化查询页面
        initJGGridselectView($gridTable);
    }
    function btn_add() {
        dialogOpen({
            id: "OrderPriceForm",
            title: '添加提派单价',
            url: '/jsp/InternalAccounting/OrderPriceForm.jsp',
            width: "900px",
            height: "525px",
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
                id: "Form",
                title: '修改体派单家',
                url:  '/jsp/InternalAccounting/OrderPriceForm.jsp?keyValue=' + keyValue,
                width: "900px",
                height: "525px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }


    //修改状态
    function btn_Update(status) {
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        if (keyValue) {
            $.ConfirmAjax({
                msg: "注：您确定要修改车头状态？",
                url: "/vehicleHead/updateStatus.action",
                param: { tableName:"JC_VEHICLE_HEAD",status:status,id: keyValue },
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
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="vehicleHead-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
            <a id="vehicleHead-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
            <a id="vehicleHead-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                <i class="fa fa-reorder"></i>&nbsp;更多<span class="caret"></span>
            </a>
            <%--<ul class="dropdown-menu pull-right">--%>
            <%--<li id="vehicleHead-disabled"><a onclick="btn_Update(0)"><i></i>&nbsp;停运</a></li>--%>
            <%--<li id="vehicleHead-enabled"><a onclick="btn_Update(1)"><i></i>&nbsp;在用</a></li>--%>
            <%--</ul>--%>
        </div>
        <%--<div class="btn-group">
            <a id="user-authorize" class="btn btn-default" onclick="btn_authorize()"><i class="fa fa-gavel"></i>&nbsp;角色授权</a>
            <a id="user-dataAuthorize" class="btn btn-default" onclick="btn_dataAuthorize()"><i class="fa fa-gavel"></i>&nbsp;数据授权</a>
        </div>--%>
        <%--<script>$('.toolbar').authorizeButton()</script>--%>
    </div>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
    <div id="gridPager"></div>
</div>
</body>
</html>