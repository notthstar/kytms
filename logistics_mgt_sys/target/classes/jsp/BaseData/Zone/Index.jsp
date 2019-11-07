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
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>

<html>
<head>
    <base href="<%=basePath%>">
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>行政区域</title>
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
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
        var item = {
            height: $(window).height() - 52,
            url: "/zone/getZoneTree.action",
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
        var  url="/zone/getZoneGrid.action";
        if(status != null && status != undefined && status != ""){
            url+= "?status="+status
        }
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: url,
            datatype: "json",
            height: $(window).height() - 141.5,
            autowidth: true,
            colModel: [
                { label: "主键", name: "id", index: "id", hidden: true },
                {label: "编码", name: "code", index: "code", width: 150, align: "left"},
                {label: "城市编码", name: "cityCode", index: "cityCode", width: 150, align: "left"},
                {label: "名称", name: "name", index: "name", width: 150, align: "left"},
                {label: "坐标", name: "latitude", index: "value", width: 170, align: "left"},
                {label: "等级", name: "level", width: 70, align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CityLevel['' + cellvalue + '']
                    }
                },
                {label: "状态", name: "status", width: 70, align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommDataStatus['' + cellvalue + '']
                    }
                },
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
                btn_edit(  $gridTable.getCell(a,"id"))
            },
        });
        var colmodel = $('#gridTable').jqGrid('getGridParam', 'colModel');
        var ment = $("#queryLi");
        for (i = 0; i < colmodel.length; i++) {
            var s = colmodel[i];
            if (s.label) {
                ment.append("<li><a data-value='" + s.name + "'>" + s.label + "</a></li>");
            }
        }
        //查询条件
        $("#queryCondition .dropdown-menu li").click(function () {
            var text = $(this).find('a').html();
            var value = $(this).find('a').attr('data-value');
            $("#queryCondition .dropdown-text").html(text).attr('data-value', value)
        });
        //查询事件
        $("#btn_Search").click(function () {
            var  url="/zone/getZoneGrid.action";
            if(status != null && status != undefined && status != ""){
                url+= "?status="+status
            }
            $gridTable.jqGrid('setGridParam', {
                url: url,
                postData: {
                    id: _parentId,
                    whereName: $("#queryCondition").find('.dropdown-text').attr('data-value'),
                    whereValue: $("#txt_Keyword").val()
                }
            }).trigger('reloadGrid');
        });
        //查询回车
        $('#txt_Keyword').bind('keypress', function (event) {
            if (event.keyCode == "13") {
                $('#btn_Search').trigger("click");
            }
        });
    }
    function btn_add() {
        var idd = _parentId;
        var url = null;
      if(idd != null){
        url ='jsp/BaseData/Zone/Form.jsp?idd='+idd;
       }else{
          url='jsp/BaseData/Zone/Form.jsp';
      }
        dialogOpen({
            id: "行政区域",
            title: '行政区域',
            url: url,
            width: "450px",
            height: "450px",
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
                id: "行政区域",
                title: '行政区域',
                url: 'jsp/BaseData/Zone/Form.jsp?keyValue=' + keyValue,
                width: "450px",
                height: "450px",
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
                msg: "注：您确定要修改状态？",
                url: "/zone/updateStatus.action",
                param: { tableName:"JC_ZONE",status:status,id: keyValue },
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

    function getZone() {
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
                <div class="title-search">
                    <table>
                        <tr>
                            <td>
                                <div id="queryCondition" class="btn-group">
                                    <a class="btn btn-default dropdown-text" data-value="code"
                                       data-toggle="dropdown">编号</a>
                                    <a class="btn btn-default dropdown-toggle" data-toggle="dropdown"><span
                                            class="caret"></span></a>
                                    <ul id="queryLi" class="dropdown-menu">
                                    </ul>
                                </div>
                            </td>
                            <td style="padding-left: 2px;">
                                <input id="txt_Keyword" type="text" class="form-control" placeholder="请输入要查询关键字"
                                       style="width: 200px;"/>
                            </td>
                            <td style="padding-left: 5px;">
                                <a id="btn_Search" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;查询</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="toolbar">
                    <div class="btn-group">
                        <a id="Zone-replace" class="btn btn-default" onclick="reload();"><i
                                class="fa fa-refresh"></i>&nbsp;刷新</a>
                        <a id="Zone-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
                        <a id="Zone-edit" class="btn btn-default" onclick="btn_edit()"><i
                                class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
                        <a id="Zone-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                           aria-expanded="false">
                            <i class="fa fa-reorder"></i>&nbsp;更多<span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu pull-right">
                            <li id="Zone-enabled"><a onclick="btn_Update('1')"><i></i>&nbsp;生效</a></li>
                            <li id="Zone-disabled"><a onclick="btn_Update('0')"><i></i>&nbsp;失效</a></li>

                        </ul>
                    </div>
                    <%--<script>$('.toolbar').authorizeButton()</script>--%>
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
