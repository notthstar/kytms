<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/28
  Time: 18:14
  To change this template use File | Settings | File Templates.
  服务区域
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
    <title>服务区域</title>
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
    var st = request('type');
    var orgId=  request('orgId');
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
        var url="/serverZone/getServerZoneList.action"
        if(st != null && st != undefined && st != ""){
            url+= "?other="+st+"&id="+orgId;
        }else{
            url+= "?id="+orgId;
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
                {label: '组织区域', name: 'organization.name',index:"b.name", width: 150, align: 'center'},
                {label: '目的运点', name: 'zone.name',index:"c.name", frozen:true, width: 150, align: 'center'},
                {label: '服务类型', name: 'type',type:"DD&serviceType",index:"a.type", width: 150, align: 'center',
                    formatter:function(cellvalue,options,rowObject){
                        return top.clientdataItem.serviceType['' + cellvalue + '']
                    }
                },
                {label: '公里数', name: 'mileage', width: 100, align: 'center'},
                {label: '最低收费', name: 'minMoney', width: 150, align: 'center'},
                {label: '送货费', name: 'songhf', width: 150, align: 'center'},
                {label: '吨单价', name: 'weightPrices', width: 150, align: 'center'},
                {label: '方单价', name: 'volumePrices', width: 150, align: 'center'},
                {label: '单价表', name: 'track', width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return '<span onclick=\"getPrice(\''+rowObject[0]+'\')\" class=\"label label-info\" style=\"cursor: pointer;\">点击查看</span>';
                    }},
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
                    }},
                {label: 'st', name: 'st', width: 120,hidden: true, align: 'center'},
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
            ondblClickRow:function(a,b,c){
                btn_edit(  $gridTable.getCell(a,"id"))
            },

        });
        //$gridTable.authorizeColModel()
        //初始化查询条件
        initJGGridselectView($gridTable);
    }
    function btn_add() {
        var url= null;
        if(orgId != null){
            url = '/jsp/AdjustAccounts/ServerZoneForm.jsp?orgId='+orgId;
        }else{
            url = '/jsp/AdjustAccounts/ServerZoneForm.jsp';
        }
        dialogOpen({
            id: "ServerZoneForm",
            title: '添加服务区域',
            url: url,
            width: "750px",
            height: "350px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick()
            }
        });
    };
    function getPrice(pid) {
            dialogOpen({
                id: "IntervalForm",
                title: '其他单价表',
                url: '/jsp/AdjustAccounts/IntervalForm.jsp?pid='+pid,
                width: "750px",
                height: "650px",
                btn:[],
            });
    }

    function btn_edit(id) {
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("id");
        }else {
            keyValue = id
        }
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "ServerZoneForm",
                title: '修改提派单',
                url: '/jsp/AdjustAccounts/ServerZoneForm.jsp?keyValue=' + keyValue,
                width: "750px",
                height: "350px",
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
                msg: "注：您确定要修改派车单状态？",
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

    function btn_qtdj(){
        dialogOpen({
            id: "OtherCostIndex",
            title: '单价表',
            url: '/jsp/AdjustAccounts/OtherCostIndex.jsp',
            width: "750px",
            height: "650px",
            btn:[],
        });
    }
    function szImport() {
        dialogOpen({
            id: "上传EXCEL",
            title: '上传EXCEL',
            url: 'jsp/AdjustAccounts/LXUpload.jsp',
            width: "530px",
            height: "450px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick();
            }
        });
    }


    /**
     * 别的窗口调用此方法，返回选择值
     */
    function getServerZone() {
        var grid = $("#gridTable")
        var id = grid.jqGridRowValue("id");
        var name = grid.jqGridRowValue("zone.name");
        if (checkedIds(id)) {
            return {
                id:id,
                name:name
            }
        }
    }

</script>
<div class="titlePanel">
    <div class="title-search">
        <table>
            <tr>
                <td>
                    <div   id="queryCondition" class="btn-group">
                        <a class="btn btn-default dropdown-text" data-value="c.name"
                           data-toggle="dropdown">目的运点</a>
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
                    <a id="btn_qtdjb" class="btn btn-success" onclick="btn_qtdj()"><i class="fa fa-plus"></i>&nbsp;其他单价表</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="replace" class="btn btn-default" onclick="reload()"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="serverZone-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
            <a id="serverZone-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
            <a id="serverZone-Import" class="btn btn-default" onclick="szImport()"><i class="fa fa-pencil-square-o"></i>&nbsp;导入</a>
            <%--<a id="trailer-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">--%>
                <%--<i class="fa fa-reorder"></i>&nbsp;更多<span class="caret"></span>--%>
            <%--</a>--%>
            <%--<ul class="dropdown-menu pull-right">--%>
                <%--<li id="trailer-disabled"><a onclick="btn_Update(0)"><i></i>&nbsp;失效</a></li>--%>
                <%--<li id="trailer-enabled"><a onclick="btn_Update(1)"><i></i>&nbsp;生效</a></li>--%>
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
