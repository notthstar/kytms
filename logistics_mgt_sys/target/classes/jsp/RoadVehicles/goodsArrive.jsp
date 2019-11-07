<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2017/12/04
  Time: 21:27
  货物到站
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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>货物到站</title>
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet"/>
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-uuid.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/grid.locale-cn.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.js"></script>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-report.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-bill.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/layout/jquery.layout.js"></script>

    <style>
        html, body {
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<script>
    var status = request('status');

    $(function () {
        InitialPage();
        InitControl();
        GetGrid();
        GetGrid1();
    });
    //初始化数据
    function InitControl() {
        //resize重设(表格、树形)宽高
        $(window).resize(function (e) {
            window.setTimeout(function () {
//
            }, 200);
            e.stopPropagation();
        });
    }
    //初始化页面
    function InitialPage() {
        //layout布局
        $('#layout').layout({
            applyDefaultStyles: false,//应用默认样式
            north__resizable:false,//可以改变大小
            spacing_open:8,//边框的间隙
            spacing_closed:60,//关闭时边框的间隙
            resizerTip:"可调整大小",//鼠标移到边框时，提示语
            //resizerCursor:"resize-p" 鼠标移上的指针样式
            resizerDragOpacity:0.9,//调整大小边框移动时的透明度
            sliderTip:"显示/隐藏侧边栏",//在某个Pane隐藏后，当鼠标移到边框上显示的提示语。
            sliderCursor:"pointer",//在某个Pane隐藏后，当鼠标移到边框上时的指针样式。
            togglerTip_open:"关闭",//pane打开时，当鼠标移动到边框上按钮上，显示的提示语
            togglerTip_closed:"打开",//pane关闭时，当鼠标移动到边框上按钮上，显示的提示语
            togglerContent_open:"<div style='background:red'>AAA</div>",//pane打开时，边框按钮中需要显示的内容可以是符号"<"等。需要加入默认css样式.ui-layout-toggler .content
            fxName:"drop",//打开关闭的动画效果
//            onresize :ons,//调整大小时调用的函数
//            onshow_start:start,
//            onshow_end:end,
            west: {
                size:500,
                spacing_closed:10,
//
            },
            center:{
                size:1000,
            },
            onresize: function (e,s,c,b) {
                if(c.edge == 'west'){
                    $("#gridTable").setGridWidth(c.innerWidth-10);
                }
                if(c.edge == 'center'){
                    $("#gridTable1").setGridWidth(c.innerWidth);
                }
            }
        });
//        $('.ui-layout-west').width(500);
//        $('.ui-layout-center').width(1051);

        // $('.ui-layout-center').left(405);

//        $('.profile-nav').height($(window).height() - 200);
//        $('.profile-content').height($(window).height() - 92);
//        $('.profile-nav1').height($(window).height() - 200);
        //resize重设(表格、树形)宽高
        //initHigtQuery($("#btn_HigtSearch"),$('#gridTable'));
    }

    function GetGrid() {
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: "/shipment/getDZShipmentList.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'ship.id', hidden: true},
                {label: '所属组织机构', name: 'org.name', width: 100, align: 'center'},
                {label: '运单号',selectDefault:true, name: 'ship.code', width: 150, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {

                        if(rowObject[24] ==1){
                            return '<a onclick=\"openAb(\'' + rowObject[0]+'\')\" class=\"label label-danger\" style=\"cursor: pointer;\">'+cellvalue+'</a>';
                        }else {
                            return cellvalue;
                        }

                    }},
                {label: '运单日期', name: 'ship.time', width: 80,align: 'center', type:"date",
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: "状态", name: "status", index:"ship.status",width: 70, align: "center",type:"DD&OrderStatus",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    }},
                {label: '车牌号', name: 'cph', width: 100,align: 'center'},
                {label: '出发站点', name: 'forg.name', width: 80,align: 'center'},
                {label: '当前站', name: 'norg.name', width: 80,align: 'center'},
                {label: '下一站', name: 'ntorg.name', width: 80,align: 'center'},
                {label: '目的站点', name: 'torg.name', width: 80,align: 'center'},
                {label: '订单号', name: 'ship.orderCode', width: 230, align: 'center'},
                {label: '客户订单号', name: 'ship.relatebill1', width: 200, align: 'center'},
                {label: '运作模式', name: 'ship.operationPattern', width: 90,align: 'center',type:"DD&OperationPattern",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OperationPattern['' + cellvalue + '']
                    }},
                {label: '承运商名称', name: 'carr.name', width: 150,align: 'center'},
                {label: '承运商类型', name: 'carrierType', width: 90,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CarrierType['' + cellvalue + '']
                    }},
                {label: '是否超期', name: 'carriageIsExceed', width: 70,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '运输协议号', name: 'ship.tan', width: 120,align: 'center'},
                /* {label: '线路', name: 'line.name', width: 120,align: 'center'},*/
//                {label: '装卸信息', name: 'ship.loadingInfo', width: 100,align: 'center'},
                {label: '数量', name: 'ship.number', width: 80,align: 'center'},
                {label: '重量', name: 'ship.weight', width: 80,align: 'center'},
                {label: '体积', name: 'ship.volume', width: 80,align: 'center'},
                {label: '货值', name: 'ship.value', width: 80,align: 'center'},
                {label: '创建人', name: 'ship.create_Name', width: 120,align: 'center'},
                {label: '创建时间', name: 'ship.create_Time', width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '修改人', name: 'ship.modify_Name', width: 120,align: 'center'},
                {label: '修改时间', name: 'ship.modify_Time', width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},


                {label: '异常', name: 'isAbnormal', hidden: true},
                {label: "状态", name: "st",hidden: true},
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
            onSelectRow: function (a) {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
                GetGrid1( $gridTable.getCell(a,"ship.id"));
                $('#gridTable1').jqGrid('setGridParam', {
                    postData: {
                        id: $gridTable.getCell(a,"ship.id"),
                       },
                    page: 1
                }).trigger('reloadGrid');
//                reload();
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            },
            ondblClickRow:function(a,b,c){
                GetGrid1( $gridTable.getCell(a,"ship.id"))
            },
        });

        //初始化查询页面
        initJGGridselectView($gridTable);
        $gridTable.jqGrid('setFrozenColumns');
    }
    function GetGrid1(id) {
        var url="/transportorder/getDZLedList.action";
        var selectedRowIndex = 0;
        var $gridTable1 = $('#gridTable1');
        $gridTable1.jqGrid({
            url: url,
            datatype: "json",
            height: $(window).height()-135,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'a.id', hidden: true,frozen:true},
                {label: '组织机构', name: 'organization.name',index:"b.name" ,width: 120, align: 'center',frozen:true},
                {label: '订单号',selectDefault:true, name: 'code', index:"a.code", type:"text",width: 150, align: 'center',frozen:true,
                    cellattr:function addCellAttr(rowId, val, rawObject, cm, rdata) {
                        if(rawObject[26] == 1 ){
                            return "style='color:red'";
                        }
                    }},
                {label: '订单日期', name: 'time', index:"a.time", type:"date",width: 80, align: 'center',frozen:true,
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '客户订单号', name: 'relatebill1',index:"a.relatebill1", width: 80,frozen:true, align: 'center'},
                {label: '客户类型', name: 'costomerType',index:"a.costomerType",  type:"DD&CustomerType",width: 60, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CustomerType['' + cellvalue + '']
                    }},
                {label: '客户名称', name: 'customer.name',index:"c.name", width: 200, align: 'center'},
                {label: '订单状态', name: 'status',type:"DD&OrderStatus",index:"a.status", width: 60, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    }},
                {label: '货名', name: 'als.name',index:"als.name", width: 70,align: 'center'},
                {label: '数量', name: 'a.number',index:"a.number", width: 70,align: 'center'},
                {label: '重量', name: 'a.weight',index:"a.weight", width: 70,align: 'center'},
                {label: '体积', name: 'a.volume',index:"a.volume", width: 70,align: 'center'},
                {label: '是否超期',name :'costomerIsExceed', type:"DD&CommIsNot",index:"a.costomerIsExceed",  width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '目的网点', name: 'torg.name', index:"torg.name", width: 100, align: 'center'},
                {label: '销售负责人', name: 'salePersion',index:"a.salePersion",  width: 100, align: 'center'},
                {label: '运输性质', name: 'transportPro',type:"DD&TransportPro", width: 100,index:"a.transportPro", align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.TransportPro['' + cellvalue + '']
                    }},
                {label: '是否回单', name: 'isBack', type:"DD&CommIsNot",index:"a.isBack",width: 60, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '回单份数', name: 'backNumber', width: 80, align: 'center',index:"a.backNumber"},
                {label: '实际发运日期', name: 'fyTime',index:"a.fyTime", width: 100,frozen:true, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '实际运抵日期', name: 'ydTime',index:"a.ydTime", width: 100,frozen:true, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: "备注", name: "description",index:"a.description", index: "description", width: 200, align: "center"},
                {label: '创建人', name: 'create_Name',index:"a.create_Name", width: 120,align: 'center'},
                {label: '创建时间', name: 'create_Time',index:"a.create_Time", width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '修改人', name: 'modify_Name', index:"a.modify_Name",width: 120,align: 'center'},
                {label: '修改时间', name: 'modify_Time', index:"a.modify_Time",width: 150,align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '异常', name: 'isAbnormal',index:"a.isAbnormal", hidden: true},
                {label: "状态", name: "st",hidden: true},
                {label: '货品单位',  width: 0,hidden: true,index:"f.unit",isIndex:true},
                {label: '货品数量', width: 0, hidden: true,index:"f.number",isIndex:true},
                {label: '货品重量', width: 0, hidden: true,index:"f.weight",isIndex:true},
                {label: '货品体积',  width: 0,hidden: true,index:"f.volume",isIndex:true},
                {label: '货品货值', width: 0, hidden: true,index:"f.value",isIndex:true}
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
            footerrow: true,
            frozen:true,
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                var number = $(this).getCol("a.number", false, "sum");
                var weight = $(this).getCol("a.weight", false, "sum");
                var volume = $(this).getCol("a.volume", false, "sum");
                //合计
                $(this).footerData("set", {
                    "code": "合计：",
                    "a.number": "数量:" + number,
                    "a.weight": "重量:" + weight,
                    "a.volume": "体积:" + volume,
                });// $("#" + this.id).setSelection(selectedRowIndex, false);
            }
        });
        //初始化查询条件
        initJGGridselectView($gridTable1);
    }

    /**
     * 再次装货
     */

     function btn_zaizhuanghuo(){
        var  keyValue = $("#gridTable").jqGridRowValue("ship.id");
        var options = {
            width: "1150px",
            height: "650px",
        }
        var _width = top.$.windowWidth() > parseInt(options.width.replace('px', '')) ? options.width : top.$.windowWidth() + 'px';
        var _height = top.$.windowHeight() > parseInt(options.height.replace('px', '')) ? options.height : top.$.windowHeight() + 'px';
        top.layer.open({
            id: "orderFromInfo",
            type: 2,
            shade: 0.3,
            title: '配载信息',
            fix: false,
            area: [_width, _height],
            content: top.contentPath + 'jsp/RoadVehicles/goodInLording.jsp?keyValue='+keyValue,
            cancel: function () {
                $("#gridTable").trigger("reloadGrid");
                return true;
            }
        });
    }

    /**
     * 货品到站
     */
    function btn_hwdaozhan(){
        var  keyValue = $("#gridTable1").jqGridRowValue("a.id");
        if (keyValue) {
            dialogOpen({
                id: "VehiclesForm",
                title: '货品到站',
                url: '/jsp/RoadVehicles/goodsArriveForm.jsp?keyValue='+ keyValue,
                width: "350px",
                height: "400px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    var windowsSize=1
    function windowSize(){

       var layout =  $('#layout').layout()
        var jggird=$("#gridTable")
        if(windowsSize ==1){
            layout.sizePane("west", 200);
            jggird.setGridWidth(200-10);
            layout.sizePane("center", 200);
            jggird.setGridWidth(200-10);
            windowsSize --
            return
        }else{
            layout.sizePane("west", 900);
            jggird.setGridWidth(900-10);
            layout.sizePane("center", 900);
            jggird.setGridWidth(900-10);

            windowsSize++
            return

        }
    }
    function btn_fayun() {
        var keyValue = $("#gridTable").jqGridRowValue("ship.id");
        var norgName = $("#gridTable").jqGridRowValue("norg.name");
        var torgName = $("#gridTable").jqGridRowValue("torg.name");
        var dqorg ='${orgId.name}';//获取当前登陆的组织机构
        if(norgName != dqorg){
            return dialogAlert("当前站与登陆组织机构不相同，不能再次发运");
        }
        if(torgName == norgName ){
            return dialogAlert("目的站点和登陆组织机构相同，不能再次发运");
        }
            if (keyValue) {
                var options ={
                    width: "1180px",
                    height: "550px",
                }
                var _width = top.$.windowWidth() > parseInt(options.width.replace('px', '')) ? options.width : top.$.windowWidth() + 'px';
                var _height = top.$.windowHeight() > parseInt(options.height.replace('px', '')) ? options.height : top.$.windowHeight() + 'px';
                if (checkedRow(keyValue)) {
                    dialogOpen({
                        id: "selectDate",
                        title: '时间选择',
                        url: '/jsp/Shipment/SelectDate.jsp?keyValue=' + keyValue,
                        width: "310px",
                        height: "240px",
                        callBack: function (iframeId) {
                            top.frames[iframeId].AcceptClick(location);
                        }
                    });
                }
            }
    }


</script>
<div class="ui-layout" id="layout" style="height: 100%; width: 100%;">
    <div class="ui-layout-north"><!-- 页面顶部工具栏区域-->
        <div class="north-Panel">
            <div class="profile-top">
                <div class="titlePanel" >
                    <div class="title-search">
                        <table>
                            <tr>
                                <td>
                                    <div   id="queryCondition1" class="btn-group">
                                        <a class="btn btn-default dropdown-text" data-value="code"
                                           data-toggle="dropdown">选择条件</a>
                                        <a class="btn btn-default dropdown-toggle" data-toggle="dropdown"><span
                                                class="caret"></span></a>
                                        <ul  id="queryLi1" class="dropdown-menu">
                                        </ul>
                                    </div>

                                </td>
                                <td id="keyWord1" style="padding-left: 2px;">
                                    <input  id="txt_Keyword1" type="text" class="form-control" placeholder="请输入要查询关键字" style="width: 200px;"/>
                                </td>
                                <td style="padding-left: 5px;">
                                    <a id="btn_Search1" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;查询</a>
                                    <a id="btn_HigtSearch1" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;高级查询</a>
                                    <a id="roadVehicles-edit" class="btn btn-default" onclick="btn_fayun();"><i class="fa fa-pencil-square-o"></i>&nbsp;再发运</a>
                                    <a STYLE="margin-left: 100px" id="windows-Size-d"  class="btn btn-default" onclick="windowSize(1)"><i class="fa fa-pencil-square-o"></i>调整窗口</a>

                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="toolbar">
                        <div class="btn-group">
                            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
                            <a id="goods-arrive1" class="btn btn-default"><i class="fa fa-pencil-square-o"></i>&nbsp;卸车报告</a>
                            <a id="goods-arrive" class="btn btn-default" onclick="btn_hwdaozhan();" ><i class="fa fa-pencil-square-o"></i>&nbsp;货品到站</a>
                            <a id="goods-arrive11" class="btn btn-default" onclick="btn_zaizhuanghuo();" ><i class="fa fa-pencil-square-o"></i>&nbsp;在装货</a>
                        </div>

                        <script>$('.toolbar').authorizeButton()</script>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="ui-layout-west"><!-- 页面西部区域-->
        <div class="west-Panel">
                <div class="gridPanel">
                    <table id="gridTable"></table>
                </div>
        </div>
    </div>
    <div class="ui-layout-center" ><!-- 页面中心区域-->
        <div class="center-Panel">
                <%--到站车辆装载订单明细--%>
                <%--<div class="gridPane2">--%>
                    <table id="gridTable1"></table>
                    <%--<div id="gridPager"></div>--%>
                <%--</div>--%>
        </div>
    </div>
</div>


</body>
</html>