<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/3/10
  Time: 9:27
  组织机构列表.
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
    <meta name="viewport" content="width=device-width"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>组织机构</title>
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <!--bootstrap组件end-->
    <script src="/Content/scripts/plugins/layout/jquery.layout.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.js"></script>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <style>
        html, body {
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<body>

<script>
    var status = request('status');
    $(function () {
        InitialPage();
        GetTree();
        GetGrid();
    });
    //初始化页面
    function InitialPage() {
        //layout布局
        $('#layout').layout({
            applyDemoStyles: true,
            onresize: function () {
                $(window).resize()
            }
        });
        //resize重设(表格、树形)宽高
        $(window).resize(function (e) {
            window.setTimeout(function () {
                $('#gridTable').setGridWidth(($('.gridPanel').width()));
                $("#gridTable").setGridHeight($(window).height() - 141.5);
                $("#itemTree").setTreeHeight($(window).height() - 52);
            }, 200);
            e.stopPropagation();
        });
    }
    //加载树
    var _parentId = "";
    function GetTree() {
       var url="/org/getTree.action?tableName=JC_SYS_ORGANIZATION";
        //var url="/org/getOrgTreeW.action";
        var item = {
            height: $(window).height() - 52,
            url: url,
            onnodeclick: function (item) {
                _parentId = item.id;
                $('#btn_Search').trigger("click");
            }
        };
        //初始化
        $("#itemTree").treeview(item);
    }
    //加载表格
    function GetGrid() {
       var url="/org/getOrgGrid.action";
        if(status != null && status != undefined && status != ""){
            url+= "?status="+status
        }
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url:url,
            datatype: "json",
            height: $(window).height() - 141.5,
            autowidth: true,
            colModel: [
                {label: "主键", name: "id", index: "id", hidden: true},
                {label: "名称", name: "name",  width: 130, align: "left"},
                {label: "编码", name: "code",  width: 130, align: "left"},
                {label: "类型", name: "type", type:"DD&OrgType", width: 50, align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrgType['' + cellvalue + '']
                    }},
                {label: "状态", name: "status", width: 70,type:"DD&CommDataStatus", align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommDataStatus['' + cellvalue + '']
                }},
                {label: "行政等级", name: "level",type:"DD&CityLevel", width: 100, align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CityLevel['' + cellvalue + '']
                    }},
                {label: '是否能使用超期合同', name: 'isOverdueContract',type:"DD&CommIsNot", width: 120, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '是否能使用超期承运商', name: 'isOverdueCarrier',type:"DD&CommIsNot", width: 140, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: "负责人", name: "principal", index: "principal", width: 80, align: "left"},
                {label: "地址", name: "address", index: "address", width: 300, align: "left"},
                {label: '经纬度', name: 'latitude', width: 160, align: 'center'},
                {label: "备注", name: "description", index: "description", width: 200, align: "left"},
                {label: '创建人', name: 'create_Name', width: 120,align: 'center'},
                {label: '创建时间', name: 'create_Time', width: 150,align: 'center'},
                {label: '修改人', name: 'modify_Name', width: 120,align: 'center'},
                {label: '修改时间', name: 'modify_Time', width: 150,align: 'center'},
            ],
            pager: false,
            rowNum: "1000",
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            },
            ondblClickRow:function(a,b,c){
                btn_edit(  $gridTable.getCell(a,"id"));
            },
        });

       // initJGGridselectView($gridTable);
        var colmodel = $gridTable.jqGrid('getGridParam', 'colModel');
        var ment = $("#queryLi");
        for (i = 0; i < colmodel.length; i++) {
            var s = colmodel[i];
            if (s.label) {
                if(s.hidden != true){
                    if(s.index != undefined){
                        ment.append("<li><a selectType = "+s.type+" data-value='" + s.index + "'>" + s.label + "</a></li>");
                    }else{
                        ment.append("<li><a selectType = "+s.type+" data-value='" + s.name + "'>" + s.label + "</a></li>");
                    }
                }
            }
        }
        function queryView(em){
            $("#txt_Keyword").remove();
            $("#txt_Keyword2").remove();
            var arrt = em.attr("selectType");
            var tt = arrt.substring(0,3)
            if(tt =="DD&"){
                var value = arrt.substring(3,arrt.length)
                html = ' <div id="txt_Keyword" selectType="select" type="select" style="width: 200px;" class="ui-select" ><ul> </ul> </div>'
                $("#keyWord").prepend(html);
                $("#txt_Keyword").ComboBox({
                    description: "=请选择查询值=",
                    height: "200px",
                    data: top.clientdataItem[value]
                });
                return;
            }else if(em.attr("selectType") =="date"){
                html = '<input id="txt_Keyword" type="text"  selectType="date" placeholder="请选择开始时间"   readonly="readonly" style="width: 160px;"  class="form-control input-wdatepicker"  onfocus="WdatePicker()"></input>'
                html += '<input id="txt_Keyword2" type="text"  selectType="date" placeholder="请选结束择时间"   readonly="readonly" style="width: 160px;"  class="form-control input-wdatepicker"  onfocus="WdatePicker()"></input>'
                $("#keyWord").prepend(html);
                return
            }else{
                html = '<input  id="txt_Keyword" type="text" selectType="input" class="form-control" placeholder="请输入要查询关键字" style="width: 200px;"/>'
                $("#keyWord").prepend(html);
                return
            }
        }
        $("#queryCondition .dropdown-menu li").click(function () {
            queryView($(this).find('a'));
            var text = $(this).find('a').html();
            var value = $(this).find('a').attr('data-value');
            $("#queryCondition .dropdown-text").html(text).attr('data-value', value)
        });
        //查询事件
        $("#btn_Search").click(function () {
            var whereName= $("#queryCondition").find('.dropdown-text').attr('data-value');
            var whereValue= "";

            if($("#txt_Keyword").attr("selectType") == "select"){
                whereValue = $("#txt_Keyword").attr('data-value')
            }else if($("#txt_Keyword").attr("selectType") == "date"){
                whereName += " between '"+$("#txt_Keyword").val()+"' and '"+$("#txt_Keyword2").val()+"' and "+$("#queryCondition").find('.dropdown-text').attr('data-value');
                whereValue = "%";
            }else{
                whereValue = $("#txt_Keyword").val();
            }
            if(_parentId){
                $gridTable.jqGrid('setGridParam', {postData: {id: _parentId,whereName: whereName,whereValue:whereValue
                }, page: 1
                }).trigger('reloadGrid');
            }else {
                $gridTable.jqGrid('setGridParam', {postData: {whereName: whereName,whereValue:whereValue
                }, page: 1
                }).trigger('reloadGrid');
            }
        });
        //查询回车
        $('#txt_Keyword').bind('keypress', function (event) {
            if (event.keyCode == "13") {
                $('#btn_Search').trigger("click");
            }
        });
    }
    function btn_add() {
        dialogOpen({
            id: "组织机构",
            title: '组织机构',
            url: 'jsp/BaseData/Organization/Form.jsp',
            width: "450px",
            height: "500px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick();
            }
        });
    }
    ;
    //编辑
    function btn_edit(id) {
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("id");
        }else {
            keyValue = id
        }
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "组织机构",
                title: '组织机构',
                url: 'jsp/BaseData/Organization/Form.jsp?keyValue=' + keyValue,
                width: "450px",
                height: "500px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    //失效失效
    function btn_enabled(keyValue) {
        id = $("#gridTable").jqGridRowValue("id");
        if (id) {
            $.ConfirmAjax({
                msg: "注：你是否要改变状态？",
                url: "/organization/updataStatus.action",
                param: {id: id, status: keyValue},
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
    function btn_Update(status) {
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        if (keyValue) {
            $.ConfirmAjax({
                msg: "注：您确定要修改组织机构状态？",
                url: "/org/updateStatus.action",
                param: { tableName:"JC_SYS_ORGANIZATION",status:status,id: keyValue },
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
    function btn_export() {

    }

    //行政区域授权
    function zone_authorize() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "selectFucntion",
                title: '行政区域授权',
                url: 'jsp/BaseData/Organization/SelectZoneTree.jsp?id=' + keyValue,
                width: "700px",
                height: "690px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }

    function getOrg() {
        var id = $("#gridTable").jqGridRowValue("id");
        if (checkedIds(id)) {
            return $("#gridTable").jqGrid('getRowData', id);
        }
    }

</script>
<div class="ui-layout" id="layout" style="height: 100%; width: 100%;">
    <div class="ui-layout-west">
        <div class="west-Panel">
            <div class="panel-Title">功能目录</div>
            <div id="itemTree"></div>
        </div>
    </div>
    <div class="ui-layout-center">
        <div class="center-Panel">
            <div class="panel-Title">功能信息</div>
            <div class="titlePanel">
                <div  class="title-search">
                    <table>
                        <tr>
                            <td>
                                <div   id="queryCondition" class="btn-group">
                                    <a class="btn btn-default dropdown-text" data-value="code"
                                       data-toggle="dropdown">选择查询</a>
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
                        <a id="replace" class="btn btn-default" onclick="reload();"><i
                                class="fa fa-refresh"></i>&nbsp;刷新</a>
                        <a id="Organization-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
                        <a id="Organization-edit" class="btn btn-default" onclick="btn_edit()"><i
                                class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
                        <a id="Organization-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                           aria-expanded="false">
                            <i class="fa fa-reorder"></i>&nbsp;更多<span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu pull-right">
                            <li id="Organization-disabled"><a onclick="btn_Update(0)"><i></i>&nbsp;失效</a></li>
                            <li id="Organization-enabled"><a onclick="btn_Update(1)"><i></i>&nbsp;生效</a></li>
                        </ul>
                    </div>
                    <div class="btn-group">
                        <a id="Organization-authorization" class="btn btn-default" onclick="zone_authorize()"><i class="fa fa-gavel"></i>&nbsp;行政区域授权</a>
                    </div>
                    <script>$('.toolbar').authorizeButton()</script>
                </div>
            </div>
            <div class="gridPanel">
                <table id="gridTable"></table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
