<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/5
  Time: 11:11
  To change this template use File | Settings | File Templates.
  提派单
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
    <title>提派单</title>
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
    <%--&lt;%&ndash;打印及插件&ndash;%&gt;--%>
    <%--<script src="/Content/lodopPrint/LodopFuncs.js"></script>--%>
    <%--<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>--%>
        <%--<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>--%>
    <%--</object>--%>


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
    function getSinele(){
        var grid = $("#gridTable")
        var id = grid.jqGridRowValue("id");

        if (checkedIds(id)) {
            return id;
        }
    }
    function GetGrid() {
        var url="/single/getSingleList.action"
        if(status !=null && status != undefined && status != ""){
            url="/single/getSingleList.action?status=20"
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
                {label: '隐藏状态', name: 'statusValue', hidden: true,
                    formatter: function (cellvalue, options, rowObject) {
                        return rowObject[1]
                    }},
                {label: '单号', name: 'code', width: 200, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        if(rowObject[23] ==1){
                            return '<a onclick=\"openAb(\'' + rowObject[0]+'\')\" class=\"label label-danger\" style=\"cursor: pointer;\">'+cellvalue+'</a>';
                        }else {
                            return cellvalue;
                        }

                    }},
                {label: '计划时间', name: 'dateBilling', width: 80, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '当前状态', name: 'status', width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.TPDZT['' + cellvalue + '']
                    }},
                {label: '件数', name: 'number', width: 80, align: 'center'},
                {label: '重量', name: 'weight', width: 80, align: 'center'},
                {label: '体积', name: 'volume', width: 80, align: 'center'},
                {label: '提派信息', name: 'toSendInfo', width: 70, align: 'center'},
                {label: '承运类型', name: 'carrierType', width: 70, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.Cytp['' + cellvalue + '']
                    }},
                {label: '承运商', name: 'carrier.name', width: 150, align: 'center'},
                {label: '承运商是否超期', name: 'isOverdueCarrier', width: 70, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                            if(cellvalue ==1){
                             return "<span class='label label-danger' style='cursor: pointer;'>是</span>"
                            }else {
                                return "<span class='label label-success' style='cursor: pointer;'>否</span>"
                            }

                }},
                {label: '车型', name: 'vehicle.code', width: 70, align: 'center'},
                {label: '车牌号', name: 'vehicleHead', width: 70, align: 'center'},
                {label: '司机姓名', name: 'driver', width: 70, align: 'center'},
                {label: '司机电话', name: 'driverIphone', width: 110, align: 'center'},
//                {label: '临时车牌号', name: 'vehicleHeadTemporary', width: 150, align: 'center'},
//                {label: '临时司机姓名', name: 'driverTemporary', width: 150, align: 'center'},
//                {label: '临时司机电话', name: 'driverIphoneTemporary', width: 150, align: 'center'},
                {label: '重泡比', name: 'reBubbleRatio', width: 80, align: 'center'},
                {label: '代收代付', name: 'height', width: 80, align: 'center'},
                {label: '结算方式', name: 'accountType', width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.Clearing['' + cellvalue + '']
                    }},
                {label: '实际出发时间', name: 'planStartTime', width: 90, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '实际结束时间', name: 'planEndTime', width: 90, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '实际出发点击时间', name: 'planCilckStartTime', width: 110, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '实际结束点击时间', name: 'planCilckEndTime', width: 110, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '是否有异常', name: 'isAbnormail', width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
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
            frozen:true,
            subGridRowExpanded: function (subgrid_id, row_id) {
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
                var keyValue = $gridTable.jqGrid('getRowData', row_id)['id'];

                var subgrid_table_id = subgrid_id + "_t";
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "'></table>");
                var cellEdit = false;
                if (status == 1){
                    cellEdit = true
                }
                $("#" + subgrid_table_id).jqGrid({
                    url: "/single/getSingleLedgerDetailList.action",
                    postData: {id: keyValue},
                    datatype: "json",
                    height: "100%",
                    cellEdit:cellEdit,
                    cellurl:"/orderledger/editFree.action",
                    colModel: [
                        {label: '主键', name: 'id', hidden: true},
                        {label: '费用名称', name: 'feeType.name',width: 150, align: "center"},
                        {label: '金额', name: 'amount', width: 100, align: 'center'},
                        {label: '税率', name: 'taxRate', width: 100, align: 'center'},
                        {label: '税金', name: 'input', width: 100, align: 'center'},
                        {label: '费用类型', name: 'cost', width: 100, align: 'center',
                            formatter: function (cellvalue, options, rowObject) {
                                return top.clientdataItem.LedgerCost['' + cellvalue + '']
                            }},
                        {label: '',  width: 100, align: 'center'},
                    ],
                    caption: "费用明细",
                    rowNum: "1000",
                    rownumbers: true,
                    shrinkToFit: false,
                    gridview: true,
                    hidegrid: false,
                    afterSaveCell:function(rowid, cellname, value, iRow, iCol){
                        //计算税率
                        var rowData = $(this).getRowData(rowid)
                        var taxRate = parseFloat(rowData.amount / (1 + parseFloat(rowData.taxRate)) * parseFloat(rowData.taxRate));
                        var taxRate =taxRate.toFixed(${SystemConfig.inputRoundNumber}) ;
                        rowData.input = taxRate;
                        $(this).setRowData(rowid,rowData)

                        //计算合计
//                        feeTypeTotal($(this))

                    },
                });
            },
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
        dialogOpen({
            id: "SingleForm",
            title: '添加提派单',
            url: '/jsp/Single/SingleForm.jsp',
            width: "1150px",
            height: "750px",
            btn:[],
        });
    };
    function getTrailer(){
        var id = $("#gridTable").jqGridRowValue("id");
        if (checkedIds(id)) {
            return $("#gridTable").jqGrid('getRowData', id);
        }
    }
    function btn_edit(id) {
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("id");
        }else {
            keyValue = id
        }
        var status =$("#gridTable").jqGridRowValue("statusValue");

//        if( parseInt(status)>3){
//            dialogAlert("不能修改状态为保存的单据");
//            return
//        }

        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "SingleForm",
                title: '修改提派单',
                url: '/jsp/Single/SingleForm.jsp?keyValue=' + keyValue,
                width: "1150px",
                height: "750px",
                btn:[],
            });
        }
    }
    var LODOP; //声明为全局变量
    function btn_print(id) {
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("id");
        }else {
            keyValue = id
        }
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "SingleForm",
                title: '打印',
                url: '/jsp/Single/SinglePrint.jsp?keyValue=' + keyValue,
                width: "1150px",
                height: "750px",
                callBack: function (iframeId) {
                    var obj = top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    function updateFeetype(){
            var keyValue = $("#gridTable").jqGridRowValue("id");
            var status =$("#gridTable").jqGridRowValue("statusValue");
        if( parseInt(status)<3){
            dialogAlert("不能修改状态为保存的单据");
            return
        }
            if (checkedRow(keyValue)) {
                dialogOpen({
                    id: "trimFeeType",
                    title: '费用调整',
                    url: 'jsp/Single/UpdateFee.jsp?keyValue='+keyValue,
                    width: "650px",
                    height: "350px",
                    callBack: function (iframeId) {
                        var resule = top.frames[iframeId].AcceptClick ();
                        var LedgerDetail = {
                            feeType : {
                                id:'4028f08166809ebd016680aa2e1f0001' //提派成本
                            },
                            amount:resule.cost,
                            taxRate:resule.crate,
                            input:resule.taxes,
                            cost:0,
                            type:5
                        }
                        $.SaveForm({
                            url: "single/trimFeeType.action",
                            param:{id:keyValue,ledgerDetail:JSON.stringify(LedgerDetail)},
                            loading: "正在保存数据...",
                            success: function (data) {
                                dialogMsg("调整成功", 1);
                            }
                        })
                        top.frames[iframeId].dialogClose();//关闭窗口
                    }
                });
            }
    }
    function btn_abnormal(id){
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("id");
        }else {
            keyValue = id
        }
        if( parseInt(status)<3){
            dialogAlert("不能修改状态为保存的单据");
            return
        }
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "SingleForm",
                title: '异常修改',
                url: '/jsp/Single/SingleForm.jsp?keyValue=' + keyValue+"&abnormal=1",
                width: "1150px",
                height: "750px",
                btn:[],
            });
        }
    }
    function openAb(id){
        dialogOpen({
            id: "SingleAblist",
            title: '修改异常',
            url: '/jsp/Single/SingleAblist.jsp?id=' + id,
            width: "1150px",
            height: "750px",
            btn:[],
        });
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
    function startExe(){
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        $.ConfirmAjax({
            msg: "你确定要执行这些任务?",
            url: "/single/startExe.action",
            param: { id:keyValue},
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
    function endExe(){
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        $.ConfirmAjax({
            msg: "你确定要执行这些任务?",
            url: "/single/endExe.action",
            param: { id:keyValue},
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
    function mapSingle(){
        dialogOpen({
            id: "maoSingle",
            title: '地图配载',
            url: 'jsp/Single/SingleMap.jsp',
            width: "1150px",
            height: "750px",
            btn:[],
        });
    }
    function btn_export(){
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        dialogOpen({
            id: "single",
            title: '导出派车单数据',
            url: '/jsp/Single/SingleExport.jsp',
            width: "550px",
            height: "450px",
            callBack: function (iframeId) {
              //  top.frames[iframeId].AcceptClick();
            }
        });
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
            <a id="single-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
            <a id="single-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
            <a id="single-print" class="btn btn-default" onclick="btn_print();"><i class="fa fa-refresh"></i>&nbsp;打印</a>
            <a id="single-export" class="btn btn-default" onclick="btn_export()"><i class="fa fa-arrow-down"></i>&nbsp;导出</a>
            <a id="single-abnormal" class="btn btn-default dropdown-toggle"  onclick="btn_abnormal()">
                <i class="fa fa-reorder"></i>&nbsp;异常修改</span>
            </a>
            <a id="single-map" class="btn btn-default dropdown-toggle"  onclick="mapSingle()">
                <i class="fa fa-reorder"></i>&nbsp;地图配载</span>
            </a>
            <a id="singleStart" class="btn btn-default dropdown-toggle" onclick="startExe()" >
                <i class="fa fa-reorder"></i>&nbsp;开始执行</span>
            </a>
            <a id="singleEnd" class="btn btn-default dropdown-toggle" onclick="endExe()">
                <i class="fa fa-reorder"></i>&nbsp;结束执行</span>
            </a>
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
