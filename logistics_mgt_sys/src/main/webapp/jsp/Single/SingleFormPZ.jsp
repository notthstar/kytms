<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/01/09 0004
  Time: 下午 7:23
  配载订单
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
    <title>配载订单</title>
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
    <%--<link href="/Content/scripts/utils/mTips/mTips.css" rel="stylesheet" />--%>
    <%--<script src="/Content/scripts/utils/mTips/mTips.js"></script>--%>
    <style>
        body {
            margin: 10px;
            margin-bottom: 0px;
        }
    </style>
</head>
<body>

<script>
    var keyValue = request('keyValue');
    $(function () {
        InitialPage();
        GetGrid();
        GetGridsdz();
    });
    //初始化页面
    function InitialPage() {
        //resize重设(表格、树形)宽高
        $(window).resize(function (e) {
            window.setTimeout(function () {
                $('#gridTable').setGridWidth(($('.gridPanel').width()));
                $("#gridTable").setGridHeight($(window).height() - 136.5);
                $('#gridTable1').setGridWidth(($('.gridPanel').width()));
                $("#gridTable1").setGridHeight($(window).height() - 136.5);
            }, 100);
            e.stopPropagation();
        });
    }
//    function ts(sb){
//        var id = sb;
//        $.SetForm({
//            url: "/shipment/mTips.action",
//            param: {id:id},
//            success: function (data) {
//                mTips.s(data.obj, function() {
//                });
//            }
//        });
//
//    }
//    function yc(sb){
//        mTips.h(function(){
//
//        });
//    }
    //加载分段订单表格
    function GetGrid() {
        function isInteger(obj) {
            reg =/^[-\+]?\d+(\.\d+)?$/;
            if (!reg.test(obj)) {
                return false;
            } else {
                return true;
            }
        }
        var numberValidator = function(val, nm){
            var boolean = isInteger(val)
            if(boolean){
                return [true,parseFloat(val)];
            }
            return  [false,"请输入正确数字"];
        }
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: "/single/getNotStowage.action?id=" + keyValue,
            datatype: "json",
            height: $(window).height() - 350,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '提派信息值', name: 'typeValue', hidden: true},
                {label: '提派信息', name: 'type', intex: "type", width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.TPType['' + cellvalue + '']
                    }},
                {label: '单据号', name: 'code', intex: "code", width: 220, align: 'center'},
                {label: '日期', name: 'time', index: "time", type: 'date', width: 150, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '目的区域', name: 'serverZone', intex: "serverZone", width: 100, align: 'center'},
                {label: '总件数', name: 'number', intex: "number", width: 80, align: 'center',editable:true,editrules: { required: true, custom:true, custom_func: numberValidator}},
                {label: '总重量', name: 'weight', intex: "weight", width: 80, align: 'center',editable:true,editrules: { required: true, custom:true, custom_func: numberValidator}},
                {label: '总体积', name: 'volume', intex: "volume", width: 80, align: 'center',editable:true,editrules: { required: true, custom:true, custom_func: numberValidator}},
                {label: '总货值', name: 'value', intex: "value", width: 80, align: 'center',editable:true,editrules: { required: true, custom:true, custom_func: numberValidator}},
                {
                    label: '客户类型', name: 'costomerType', width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CustomerType['' + cellvalue + '']
                    }
                },
                {label: '客户名称', name: 'customer', intex: "customer", width: 130, align: 'center'},
                {label: "备注", name: "description", intex: "description", width: 190, align: "center"}
            ],
            viewrecords: true,
            pager: false,
            rowNum: "1000",
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            footerrow: true,
            multiselect: true,//复选框
            cellEdit:true,
            cellsubmit:"clientArray",
            caption: "等待配载分段订单……",
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            }
        });
        //初始化查询页面
        initJGGridselectView($gridTable);
    }
    //加载以被运单配载的表格
    function GetGridsdz() {

        var selectedRowIndex = 0;
        var $gridTablesdz = $('#gridTablesdz');
        $gridTablesdz.jqGrid({
            url: "/single/getStowage.action?id=" + keyValue,
            datatype: "json",
            height: $(window).height() - 410,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '提派信息值', name: 'typeValue', hidden: true},
                {label: '提派信息', name: 'type', intex: "type", width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.TPType['' + cellvalue + '']
                    }},
                {label: '单据号', name: 'code', intex: "code", width: 220, align: 'center'},
                {label: '日期', name: 'time', index: "time", type: 'date', width: 150, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '目的区域', name: 'serverZone', intex: "serverZone", width: 100, align: 'center'},
                {label: '总件数', name: 'number', intex: "number", width: 80, align: 'center'},
                {label: '总重量', name: 'weight', intex: "weight", width: 80, align: 'center'},
                {label: '总体积', name: 'volume', intex: "volume", width: 80, align: 'center'},
                {label: '总货值', name: 'value', intex: "value", width: 80, align: 'center'},
                {
                    label: '客户类型', name: 'costomerType', width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CustomerType['' + cellvalue + '']
                    }
                },
                {label: '客户名称', name: 'customer', intex: "customer", width: 130, align: 'center'},
                {label: "备注", name: "description", intex: "description", width: 190, align: "center"}
            ],
            // viewrecords: true,
            pager:false,
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            rowNum: "1000",
            multiselect: true,//复选框
            caption: "已装载分段订单",
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                var number = $(this).getCol("number", false, "sum");
                var weight = $(this).getCol("weight", false, "sum");
                var volume = $(this).getCol("volume", false, "sum");
                var value = $(this).getCol("value", false, "sum");
                //合计
                $(this).footerData("set", {
                    "code": "合计：",
                    "number": "数量:" + number,
                    "weight": "重量:" + weight,
                    "volume": "体积:" + volume,
                    "value": "货值:" + value,
                });
            },
        });
        initJGGridselectViewsdz($gridTablesdz);

    }

    function btn_add() {
        var ids = $("#gridTable").jqGridRowValue("id");
        if (ids == null || ids == undefined || ids == "") {
            dialogAlert("请选择上面配载数据", -1);
            return;
        }
        var rowData = $("#gridTable").jqGridRow()

        $.SetForm({
            url: "/single/addOrder.action",
            param: {id: keyValue, data: JSON.stringify(rowData)},
            success: function (data) {
                if (data.result){
                    dialogMsg("配载成功", 1);
                }else {
                    dialogAlert(data.obj, -1);
                }
                $("#gridTable").trigger("reloadGrid");
                $("#gridTablesdz").trigger("reloadGrid");
            }
        });
    }
    function btn_del(){
        var ids = $("#gridTablesdz").jqGridRowValue("id");
        if(ids == null || ids == undefined ||ids ==""){
            dialogAlert("请选择下列移除配载数据", -1);
            return;
        }
        var rowData = $("#gridTablesdz").jqGridRow()
        $.SetForm({
            url: "/single/delOrder.action",
            param: {id:keyValue, data: JSON.stringify(rowData) },
            success: function (data) {
                dialogMsg("移除配载成功", 1);
                $("#gridTable").trigger("reloadGrid");
                $("#gridTablesdz").trigger("reloadGrid");
            }
        });
    }

    /**
     * 初始化查询条件 传入Jquery Jggird对象
     * @param Jggird
     */
    initJGGridselectViewsdz = function(Jggird){
        var  $gridTable11 = Jggird;
        var colmodel = $gridTable11.jqGrid('getGridParam', 'colModel');
        var ment = $("#queryLisdz");
        for (i = 0; i < colmodel.length; i++) {
            var s = colmodel[i];
            if (s.label) {
                if(s.hidden != true || s.isIndex == true ){
                    if(s.index != undefined){
                        ment.append("<li><a selectType = "+s.type+" data-value='" + s.index + "'>" + s.label + "</a></li>");
                    }else{
                        ment.append("<li><a selectType = "+s.type+" data-value='" + s.name + "'>" + s.label + "</a></li>");
                    }
                }
            }
        }
        function queryViewsdz(em){
            $("#txt_Keywordsdz").remove();
            $("#txt_Keyword2").remove();
            var arrt = em.attr("selectType");
            var tt = arrt.substring(0,3);
            if(tt =="DD&"){
                var value = arrt.substring(3,arrt.length)
                html = ' <div id="txt_Keywordsdz" selectType="select" type="select" style="width: 200px;" class="ui-select" ><ul> </ul> </div>'
                $("#keyWordsdz").prepend(html);
                $("#txt_Keywordsdz").ComboBox({
                    description: "=请选择查询值=",
                    height: "200px",
                    data: top.clientdataItem[value]
                });
                return;
            }else if(em.attr("selectType") =="date"){
                html = '<input id="txt_Keywordsdz" type="text"  selectType="date" placeholder="请选择开始时间"   readonly="readonly" style="width: 160px;"  class="form-control input-wdatepicker"  onfocus="WdatePicker()"></input>'
                html += '<input id="txt_Keyword2" type="text"  selectType="date" placeholder="请选结束择时间"   readonly="readonly" style="width: 160px;"  class="form-control input-wdatepicker"  onfocus="WdatePicker()"></input>'
                $("#keyWordsdz").prepend(html);
                return
            }else{
                html = '<input  id="txt_Keywordsdz" type="text" selectType="input" class="form-control" placeholder="请输入要查询关键字" style="width: 200px;"/>'
                $("#keyWordsdz").prepend(html);
                return
            }
        }
        $("#queryConditionsdz .dropdown-menu li").click(function () {
            queryViewsdz($(this).find('a'));
            var text = $(this).find('a').html();
            var value = $(this).find('a').attr('data-value');
            $("#queryConditionsdz .dropdown-text").html(text).attr('data-value', value)
        });
        //查询事件
        $("#btn_Searchsdz").click(function () {
            var whereName= $("#queryConditionsdz").find('.dropdown-text').attr('data-value');
            var whereValue= "";

            if($("#txt_Keywordsdz").attr("selectType") == "select"){
                whereValue = $("#txt_Keywordsdz").attr('data-value')
            }else if($("#txt_Keywordsdz").attr("selectType") == "date"){
                whereName += " between '"+$("#txt_Keyword1").val()+"' and '"+$("#txt_Keyword2").val()+"' and "+$("#queryConditionsdz").find('.dropdown-text').attr('data-value');
                whereValue = "%";
            }else{
                whereValue = $("#txt_Keywordsdz").val();
            }
            $gridTable11.jqGrid('setGridParam', {postData: {whereName: whereName,whereValue:whereValue},
                page: 1
            }).trigger('reloadGrid');
        });
        //查询回车
        $('#txt_Keywordsdz').bind('keypress', function (event) {
            if (event.keyCode == "13") {
                $('#btn_Searchsdz').trigger("click");
            }
        });
    }
</script>
<div class="gridPanel">
    <table id="gridTable"></table>
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
                        <input  id="txt_Keyword" type="text" class="form-control" placeholder="请输入要查询关键字" style="width: 200px;"/>
                    </td>
                    <td style="padding-left: 5px;">
                        <a id="btn_Search" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;查询</a>
                    </td>
                    <td>
                        <a id="plan-add" style=" background:chartreuse; margin-left: 100px;" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;装车</a>
                        <a id="plan-del" style=" background:#C35353  ;text-align:center" class="btn btn-default" onclick="btn_del()"><i class="fa fa-minus"></i>&nbsp;卸车</a>
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>
                        <div   id="queryConditionsdz" class="btn-group">
                            <a class="btn btn-default dropdown-text" data-value="code" data-toggle="dropdown">选择条件</a>
                            <a class="btn btn-default dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
                            <ul  id="queryLisdz" class="dropdown-menu"></ul>
                        </div>
                    </td>
                    <td id="keyWordsdz" style="padding-left: 2px;">
                        <input  id="txt_Keywordsdz" type="text" class="form-control" placeholder="请输入要查询关键字" style="width: 200px;"/>
                    </td>
                    <td style="padding-left: 5px;">
                        <a id="btn_Searchsdz" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;查询</a>
                    </td>
                </tr>
            </table>

        </div>
    </div>

    <table id="gridTablesdz"></table>
</div>
</body>
</html>
