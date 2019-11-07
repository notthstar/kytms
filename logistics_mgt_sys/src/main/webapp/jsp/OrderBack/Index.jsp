<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/4 0004
  Time: 下午 7:23
  订单回单
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
    <title>订单回单</title>
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
        initHigtQuery($("#btn_HigtSearch"),$('#gridTable'));
    }
    //加载表格
    function GetGrid() {
        var selectedRowIndex = 0;
        var ids =[];
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url: "/orderback/getOrderYQS.action",
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true,frozen:true},
                {label: '主键', name: 'idd', hidden: true,frozen:true},
                {label: "是否有图片", name: "isUpload",hidden: true,},
                {label: '组织机构', name: 'organization.name',index:"b.name" ,width: 80, align: 'center',frozen:true},
                {label: '订单号',selectDefault:true, name: 'code', index:"a.code", type:"text",width: 220, align: 'center',frozen:true,
                    formatter: function (cellvalue, options, rowObject) {
                          if(rowObject[2] !=0){
                              return '<a onclick=\"viewImage(\'' + rowObject[0]+'\')\" class=\"label label-info\" style=\"cursor: pointer;\">'+cellvalue+'（查看图片）</a>';
                          }else{
                              return cellvalue;
                          }
                    }},
                {label: '发货单号', name: 'relatebill1',index:"a.relatebill1", width: 80,frozen:true, align: 'center'},
                {label: '客户单号', name: 'relatebill2',index:"a.relatebill2", width: 80,frozen:true, align: 'center'},

                {label: '开单日期', name: 'time', index:"a.time", type:"date",width: 80, align: 'center',frozen:true,
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},


                {label: '订单状态', name: 'status',type:"DD&OrderStatus",index:"a.status", width: 70, align: 'center',frozen:true,
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    }},
                {label: '客户类型', name: 'costomerType',index:"a.costomerType",  type:"DD&CustomerType",width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CustomerType['' + cellvalue + '']
                    }},
                {label: '是否拆单',name :'costomerIsExceed', type:"DD&CommIsNot",index:"a.costomerIsExceed",  width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '客户名称', name: 'customer.name',index:"c.name", width: 200, align: 'center'},
                {label: '结算方式', name: 'feeType',index:"a.feeType",type:"DD&Clearing", width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.Clearing['' + cellvalue + '']
                    }},
                {label: '出发运点', name: 'startZone.name',index:"sz.name", width: 80, align: 'center'},
                {label: '目的网点', name: 'ton.name',index:"ton.name", width: 80, align: 'center'},
                {label: '目的运点', name: 'endZone.name',index:"ez.name", width: 80, align: 'center'},
                {label: '交付方式', name: 'handoverType',index:"a.handoverType",type:"DD&HandoverType", width: 40, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.HandoverType['' + cellvalue + '']
                    }},
                {label: '货名', name: 'f.name',index:"f.name", width: 60, align: 'center'},
                {label: '金额', name: 'f.name',index:"f.name", width: 60, align: 'center'},
                {label: '件数', name: 'a.number',index:"a.number", width: 60, align: 'center'},
                {label: '重量', name: 'a.weight',index:"a.weight", width: 60, align: 'center'},
                {label: '体积', name: 'a.volume',index:"a.volume", width:60, align: 'center'},
                {label: '计重', name: 'a.jzWeight',index:"a.jzWeight", width: 60, align: 'center'},
                {label: '实际发运日期', name: 'a.factLeaveTime',index:"a.factArriveTime", width: 140, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '实际运抵日期', name: 'a.factArriveTime',index:"a.factArriveTime", width: 140, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},


                {label: '在途跟踪', name: 'track', width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return '<span onclick=\"getTrack(\'' +rowObject[1]+'\')\" class=\"label label-info\" style=\"cursor: pointer;\">点击查看</span>';
                    }},
                {label: '是否超期',name :'costomerIsExceed', type:"DD&CommIsNot",index:"a.costomerIsExceed",  width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '销售负责人', name: 'salePersion',index:"a.salePersion",  width: 100, align: 'center'},
                /*{label: '执行计划', name: 'plan.name', width: 100,index:"e.name", align: 'center'},*/
                {label: '运输性质', name: 'transportPro',type:"DD&TransportPro", width: 100,index:"a.transportPro", align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.TransportPro['' + cellvalue + '']
                    }},
                {label: '是否回单', name: 'isBack', type:"DD&CommIsNot",index:"a.isBack",width: 60, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},
                {label: '回单份数', name: 'backNumber', width: 80, align: 'center',index:"a.backNumber"},
                {label: '入库区域', name: 'zoneStoreroom.name',index:"zs.name", width: 60, align: 'center'},
                {label: '订单公里数', name: 'orderMileage',index:"a.orderMileage", width: 80, align: 'center',frozen:true},
                /*{label: '是否开票', name: 'isBilling',index:"a.isBilling",type:"DD&CommIsNot", width: 60, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommIsNot['' + cellvalue + '']
                    }},*/
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
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                $("#" + this.id).setSelection(selectedRowIndex, false);
            },
        });
        //初始化查询页面
        initJGGridselectView($gridTable);
    }

    function receive() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        var status = $("#gridTable").jqGridRowValue("status");
        if(status != 5){
               return alert("单据状态不符合接收回单的条件，请检查状态！");
        }
        $.RemoveForm({
            msg: "注：您确定要接收回单吗？该操作将无法恢复",
            url: "/orderback/receive.action",
            param: {id: keyValue},
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
    /**
     * 回单上传
     */
    function upload() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "FeeSeedFrom",
                title: '回单上传',
                url: '/jsp/OrderBack/Form.jsp?keyValue=' + keyValue,
                width: "1000px",
                height: "550px",
                btn:[]
            });
        }
    }
    function  getTrack(id) {
        // var keyValue = $("#gridTable").jqGridRowValue("id");
        dialogOpen({
            id: "TrackFrom",
            title: '在途跟踪',
            url: 'jsp/TransportOrder/OrderTrackList.jsp?orderId='+id,
            width: "900px",
            height: "400px",
            callBack: function (iframeId) {
                top.frames[iframeId].dialogClose();//关闭窗口
            }
        });
    }
    /**
     * 回单交单
     */
    function submit() {
        var keyValue = $("#gridTable").jqGridRowValue("id");
        var status = $("#gridTable").jqGridRowValue("status");
        if(status != 15){
            return alert("单据状态不符合回单交单，请检查状态！");
        }
        $.RemoveForm({
            url: "/orderback/submit.action",
            msg: "注：您确定要交单吗？该操作将无法恢复",
            param: {id: keyValue},
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
    function viewImage(id){
        dialogOpen({
            id: "FeeSeedFrom",
            title: '查看回单',
            url: '/jsp/OrderBack/view.jsp?keyValue=' + id,
            width: "1000px",
            height: "550px",
            btn:[]
        });
    }

   function exportorderBack() {
       dialogOpen({
           id: "orderBack",
           title: '导出订单数据',
           url: '/jsp/OrderBack/orderBackExport.jsp',
           width: "650px",
           height: "450px",
           btn:[],
           callBack: function (iframeId) {
               //  top.frames[iframeId].AcceptClick();
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
                           data-toggle="dropdown">编号</a>
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
            <a id="orderBack" class="btn btn-default" onclick="exportorderBack();"><i class="fa fa-refresh"></i>&nbsp;导出</a>
        </div>
        <div class="btn-group">
            <a id="plan-replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
        </div>
        <div class="btn-group">
            <a id="plan-2" class="btn btn-default" onclick="receive();"><i class="fa fa-refresh"></i>&nbsp;接收回单</a>
        </div>
        <div class="btn-group">
            <a id="plan-4" class="btn btn-default" onclick="upload();"><i class="fa fa-refresh"></i>&nbsp;回单上传</a>
        </div>
        <div class="btn-group">
            <a id="plan-3" class="btn btn-default" onclick="submit();"><i class="fa fa-refresh"></i>&nbsp;回单交单</a>
        </div>
        <%--<script>$('.toolbar').authorizeButton()</script>--%>
    </div>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
    <div id="gridPager"></div>
</div>
</body>
</html>