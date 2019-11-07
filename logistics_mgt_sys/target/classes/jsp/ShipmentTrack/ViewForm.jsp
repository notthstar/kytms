<%--
  Created by IntelliJ IDEA.
  User: 陈小龙
  Date: 2018-1-17
  Time: 11:40
  运单追踪
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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet" />
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <!--bootstrap组件end-->
    <script src="/Content/scripts/plugins/layout/jquery.layout.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>


    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/wizard/wizard.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/dialog/dialog.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/grid.locale-cn.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.js"></script>
    <style>
        body {
            margin: 10px;
            margin-bottom: 0px;
        }
    </style>
</head>

<body>
    <form id="form1">
    <script>
        var keyValue = request('keyValue');
        $(function () {
       $("#shipment").val(keyValue)//初始化参数
            InitialPage();
            GetGrid();
        })
        //保存表单
        function btn_add() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData ={
                id: $("#id").val(),
                person:$("#person").val(),
                time:$("#time").val(),
                event:$("#event").val(),
                type:1,
                time:$("#time").val(),
                'shipment.id':$("#shipment").val()
            }
            $.SaveForm({
                url: "shipmenttrack/saveTrack.action",
                param: postData,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    } else if (data.type) {
                        $("#gridTable").trigger("reloadGrid");
                        dialogMsg(data.obj, 1);
                        btn_celar()
                    } else {
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }

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
                url: "/shipmenttrack/getTrackList.action?id="+keyValue,
                datatype: "json",
                height: $(window).height() - 235,
                autowidth: true,
                colModel: [
                    {label: '主键', name: 'id', hidden: true},
                    {label: '主键', name: 'shipment.id', hidden: true},
                    {label: '登记时间', name: 'time',type:"date", width: 150,align: 'center',},
                    {label: "事件", name: "event", width: 600, align: "center"},
                    {label: '类型', name: 'type', width: 80, align: 'center'},
                    {label: '登记人', name: 'person', width: 140, align: 'center'},

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
                }
            });
            //初始化查询条件
            initJGGridselectView($gridTable);
        }

        function btn_edit() {
            var rowid = $("#gridTable").jqGrid('getGridParam','selrow');
            var data= $("#gridTable").jqGrid('getRowData',rowid)
            if (checkedRow(keyValue)) {
                    $("#id").val(data.id);
                    $("#person").val(data.person);
                    $("#time").val(data.time);
                    $("#event").val(data.event);
                    $("#time").val(data.time)
            }
        }
        function btn_celar(){
                $("#id").val(null);
                $("#person").val(null);
                $("#time").val(null);
                $("#event").val(null);
                $("#time").val(null)
        }

    </script>
    <div style="margin-right: 10px;">
        <table class="form">
            <input id="type"  type="hidden" value="1" />
            <input id="person" type="hidden" value="" />
            <input id="shipment" name="shipment.id" type="hidden" value="" />
            <input id="id"type="hidden" value="" />
            <tr>
                <th class="formTitle">登记时间<font face="宋体">*</font></th>
                <td class="formValue" style="width: 200px">
                    <input id="time" type="text"  placeholder="请选择登记时间"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle" valign="top" style="padding-top: 4px;">事件
                </th>
                <td class="formValue" colspan="3">
                    <textarea id="event" class="form-control" style="height: 50px;"></textarea>
                </td>
            </tr>
        </table>
    </div>

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
                <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
                <a id="shuomenttrackview-add" class="btn btn-default" onclick="btn_celar();"><i class="fa fa-plus"></i>&nbsp;新建</a>
                <a id="shuomenttrackview-save" class="btn btn-default" onclick="btn_add();"><i class="fa fa-plus"></i>&nbsp;保存</a>
                <a id="shuomenttrackview-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
            </div>
            <script>$('.toolbar').authorizeButton()</script>
        </div>
    </div>
    <div class="gridPanel">
        <table id="gridTable"></table>
        <div id="gridPager"></div>
    </div>
</form>
</body>
</html>
