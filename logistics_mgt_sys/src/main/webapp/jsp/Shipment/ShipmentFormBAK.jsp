<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2017/12/04
  Time: 21:27
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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>运单表单</title>
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
<body>
<script>
    var orgData;
    var orderInfoGird;
    var WaybillLedger;

    var keyValue = request('keyValue');
    var osType = request('osType');
    $(function () {
        InitialPage();
        InitControl();
    });
    //初始化数据
    function InitControl() {
        initFeeType();//初始化费用类型 运单
        $("#shipmentMethod").ComboBox({ //运输方式
            description: "=请选择运输性质=",
            height: "200px",
            data: top.clientdataItem.TransportMenth
        });
        $("#feeType").ComboBox({ //结算方式
            description: "=请选择结算方式=",
            height: "200px",
            data: top.clientdataItem.Clearing
        });
        $("#taxRate").ComboRadio({ //税率
            data: top.clientdataItem.Logistics_Tax_Rate,
            defaultVaue: '0.11'
        });

        $("#carrierType").ComboBox({ //承运商类型
            description: "==请选择==",
            height: "200px",
            data: top.clientdataItem.CarrierType
        });


        if (!!keyValue) {
            $.SetForm({
                url: "/shipment/selectBean.action",
                param: {tableName:"JC_SHIPMENT", id: keyValue },
                success: function (data) {
                    $("#form1").SetWebControls(data);
                    $("#carrier").val(data.carrier.id)
                    $("#carrierName").val(data.carrier.name)
                    $("#vehicle").val(data.vehicle.id)
                    $("#vehicleName").val(data.vehicle.code)
                    if(data.ledgers != null && data.ledgers.length >0){
                        var led = data.ledgers;
                        for(i=0;i<led.length;i++){
                            if(led[i].type == 0){
                                $("#input").val(led[i].input);
                                $("#amount").val(led[i].amount);
                                $("input:radio[name='taxRate'][value='"+led[i].taxRate+"']").attr("checked","checked")
                                //处理台账明细
                                var ledtdetail = led[i].ledgerDetails;
                                for(j=0;j<ledtdetail.length;j++){
                                    var s = ledtdetail[j]
                                    $("#"+s.feeType.id+"").val(s.amount);
                                }
                            }

                        }

                    }
                }
            });
        } else {
            showDate("time"); //初始化时间
            $("#transportPro").ComboBoxSetValue(0);
            $("#feeType").ComboBoxSetValue(0);
            $("#shipmentMethod").ComboBoxSetValue(0);
        }
        ButtonPageInit(); //初始化按钮
    }
    //初始化页面
    function InitialPage() {
        //layout布局
        $('#layout').layout({
            applyDemoStyles: true,
            onresize: function () {
                $(window).resize()
            }
        });
        $('.profile-nav').height($(window).height() - 20);
        $('.profile-content').height($(window).height() - 20);
        //resize重设(表格、树形)宽高
        $(window).resize(function (e) {
            window.setTimeout(function () {
                $('.profile-nav').height($(window).height() - 20);
                $('.profile-content').height($(window).height() - 20);
            }, 200);
            e.stopPropagation();
        });
    }
    //侧面切换显示/隐藏 //分布加载
    function profileSwitch(id) {
        $(".profile-content").find('.flag').hide()
        $(".profile-content").find("#" + id).show();
        if(id = 'LoadingManager'){
            ledInfoGirdFunction() //初始化配载信息
        }
        if(id = 'addressInfo'){
            addressInfoGird() //初始化地址信息
        }

    }
    function initFeeType(){
        $.ajax({
            url: "/feetype/getModelFeeType.action",
            data: {id:"2"},
            async:false,
            type: "post",
            dataType: "json",
            success: function (data) {
                var html ="";
                countFeetype = data;
                html += '<tr>'
                for(i=1;i<=data.length;i++){
                    var em = data[i-1];
                    if(i == 6 || i==11 || i==16 || i==21){
                        html += '</tr>'
                        html += '<tr>'
                    }
                    html+= ' <td class="formTitle" fee="1">'+em.name+'</td>'
                    html+= '<td class="formValue" >'
                    html+='<input id = "'+em.id+'"  fee="1" name = "fee" type="number" onchange="sumFee()" isCount="'+em.isCount+'" STYLE="width: 120px;text-align:center"  value="0" class="form-control" />'
                    html+= '</td>'
                }
                html += '</tr>'
                $("#feeTypeClass").prepend(html);
            },
        });
    }
    /**
     * 总计运费
     * @param self
     */
    function sumFee(){
        var sum = 0;
        $("#feeTypeClass").find("input[name='fee']").each(function(e){
            var self =$(this);
            if(self.attr("isCount") == 1){
                var number = 0
                if(self.val() != null && self.val() != undefined && self.val() != ""){
                    sum +=parseFloat(self.val());
                }
            }
        })
        $("#amount").val(sum.toFixed(${SystemConfig.moneyRoundNumber}))
        updateTaxRate();
    }
    /**
     * 税率计算
     */
    function updateTaxRate(){
        var number = parseFloat($("#amount").val()) / (1 + parseFloat($('input:radio[name=taxRate]:checked').val())) * parseFloat($('input:radio[name=taxRate]:checked').val());
        $("#input").val(number.toFixed(${SystemConfig.inputRoundNumber})) ;
    }
    function savaShipment() {
        if (!$('#form1').Validform()) {
            return false;
        }
        var postData = $("#form1").GetWebControls(keyValue);
        if( $("#carrier") != ""){
            postData['carrier']={
                id: $("#carrier").val()
            }
        }
        if( $("#vehicle") != ""){
            postData['vehicle']={
                id:$("#vehicle").val()
            }
        }
        //处理台账
        var ledgers = new Array(); //台账
        var LedgerDetails = new Array(); //台账
        var ledger = {
            amount:$("#amount").val(),
            taxRate:$('input:radio[name="taxRate"]:checked').val(),
            input:$("#input").val(),
            type:0,
            cost:1
        }
        $("#feeTypeClass").find("input[name='fee']").each(function(e){//台账明细
            var self =$(this);
            var LedgerDetail = {
                feeType : {
                    id:self.attr("id")
                },
                amount:self.val()
            }
            LedgerDetails.push(LedgerDetail)
        })
        ledger['LedgerDetails'] = LedgerDetails;
        ledgers.push(ledger)
        postData['ledgers'] = ledgers
        $.SaveForm({
            url: "shipment/saveShipment.action",
            param:{str:JSON.stringify(postData)} ,
            loading: "正在保存数据...",
            success: function (data) {
                if (data.type == "validator") {
                    $('#form1').ValidformResule(data.obj);//后台验证数据
                } else if (data.type) {
                    $.currentIframe().$("#gridTable").trigger("reloadGrid");
                    //赋值
                    $('#code').val(data.obj.code);
                    $('#id').val(data.obj.id);
                    $('#status').val(data.obj.status);
                    //修改和隐藏
                    dialogMsg("保存成功", 1);
                } else {
                    dialogAlert(data.obj, -1);
                }
            }
        })
    }
    /*地址信息加载*/
     function addressInfoGird(){
         var selectedRowIndex = 0;
         var $gridTable1 = $('#gridTableAddress');
         $gridTable1.jqGrid({
             url: "/shipment/getAddressInfo.action?id="+keyValue,
             datatype: "json",
             height: $(window).height() - 200,
             autowidth: true,
             colModel: [
                 {label: '主键', name: 'id', hidden: true},
                 {label: '方向', name: 'type', width: 60, align: 'center',
                     formatter: function (cellvalue, options, rowObject) {
                         if(cellvalue == undefined || cellvalue == null){
                             return "没有数据";
                         }
                         return top.clientdataItem.Direction['' + cellvalue + '']
                     }},
                 {label: '分段订单号', name: 'code', width: 170, align: 'center'},
                 {label: '发货单位', name: 'name', width: 100, align: 'center'},
                 {label: '城市', name: 'fromCity', width: 80, align: 'center'},
                 {label: '联系人', name: 'contactperson', width: 80, align: 'center'},
                 {label: '电话', name: 'iphone', width: 150, align: 'center'},
                 {label: '地址', name: 'address', width: 250, align: 'center'},
                 {label: '要求发运/到达时间', name: 'planLeaveTime', width: 150, align: 'center',
                        formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return '未设置';
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                 }},
                 {label: '实际发运/到达时间', name: 'factLeaveTime', width: 150, align: 'center',
                     formatter:function(cellvalue, options, row){
                         if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                             return '未完成';
                         }
                         return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                     }},
                 {label: '经纬度', name: 'ltl', width: 170, align: 'center'},

             ],
             pager: false,
             rownumbers: true,
             shrinkToFit: false,
             gridview: true,
             onSelectRow: function () {
                 selectedRowIndex = $("#" + this.id).getGridParam('selrow');
             },
         });
    }
    /**
     * 页面和按钮初始化
     * */
    function ButtonPageInit(){
        $('#saveShipment').hide();
        $('#confirmShipment').hide();
        $('#loadingShipment').hide();
        if(osType =='shipment'){
            if( $("#status").val() == undefined || $("#status").val() == null || $("#status").val() == ""){ //如果运单是保存状态
                $('#saveShipment').show();
            }
            if($("#status").val() == 1){
                $('#confirmShipment').show();
                $('#saveShipment').show();
                $('#loadingShipment').show();
            }
            //锁死订单
            if($("#status").val() == undefined || $("#status").val() == null || $("#status").val() == ""||$("#status").val() == 1){ //如果是确认状态则订单锁定

            }else {
                $("#form1").find('.form-control,.ui-select,input').attr('disabled', 'disabled');
            }
        }
    }

    /**
     * 初始化派车单
     * */
    function initDisptch(){
        var id = $("#id").val();
        if(id == null || id == undefined){
            return
        }
        $.SetForm({
            url: "/shipment/getDisptch.action",
            param: {id: id},
            success: function (data) {
                if(data != null && data != undefined){
                    if(data.carriage != null && data.carriage != undefined){
                        $("#carriage").val(data.carriage.id);
                        $("#carriageName").val(data.carriage.name);
                    }
                    if(data.driver != null && data.driver != undefined){
                        $("#driver").val(data.driver.id);
                        $("#driverName").val(data.driver.name);
                    }
                    if(data.trailer != null && data.trailer != undefined){
                        $("#trailer").val(data.trailer.id);
                        $("#trailerName").val(data.trailer.name);
                    }
                    if(data.vehicleHead != null && data.vehicleHead != undefined){
                        $("#vehicleHead").val(data.vehicleHead.id);
                        $("#vehicleHeadName").val(data.vehicleHead.name);
                    }
                    $("#Dispatchid").val(data.id);
                    $("#Dispatchstatus").val(data.status);
                    $("#Dispatchcode").val(data.code);
                    $("#Dispatchtime").val(data.time);
                    $("#DispatchdispatchTime").val(data.dispatchTime);
                    $("#Dispatchorganization").val(data.organization.id);Dispatchshipment
                    $("#Dispatchshipment").val(data.shipment.id);
                    $("#Dispatchdescription").val(data.description);
                }

            }
        });
    }
    /**
     * 保存派车单
     */
    function saveDispatch(){
        if (!$('#form2').Validform()) {
            return false;
        }
        var postData = {
            'carriage': {id:$("#carriage").val()},
            'driver': {id:$("#driver").val()},
            'trailer': {id:$("#trailer").val()},
            'vehicleHead':{id: $("#vehicleHead").val()},
            id: $("#Dispatchid").val(),
            status: $("#Dispatchstatus").val(),
            code: $("#Dispatchcode").val(),
            time: $("#Dispatchtime").val(),
            dispatchTime: $("#DispatchdispatchTime").val(),
            'organization':{id:$("#Dispatchorganization").val()},
            description:$("#Dispatchdescription").val(),
            'shipment':{id:$("#Dispatchshipment").val()}
        }
        var ledgers = new Array(); //台账
        var LedgerDetails = new Array(); //台账
        var ledger = {
            amount:$("#amount2").val(),
            taxRate:$('input:radio[name="taxRate2"]:checked').val(),
            input:$("#input2").val(),
            type:0,
            cost:1
        }
        $("#feeTypeClass2").find("input[name='fee2']").each(function(e){//台账明细
            var self =$(this);
            var LedgerDetail = {
                feeType : {
                    id:self.attr("id")
                },
                amount:self.val()
            }
            LedgerDetails.push(LedgerDetail)
        })
        ledger['LedgerDetails'] = LedgerDetails;
        ledgers.push(ledger)
        postData['ledgers'] = ledgers
        $.SaveForm({
            url: "dispatch/saveDispatch.action",
            param: {Str:JSON.stringify(postData)},
            loading: "正在保存数据...",
            success: function (data) {
                if (data.type == "validator") {
                    $('#form2').ValidformResule(data.obj);//后台验证数据
                } else if (data.type) {
                    dialogMsg(data.obj, 1);
                } else {
                    dialogAlert(data.obj, -1);
                }
            }
        })

    }
    /**
     * 加载货品明细
     */
    function ledInfoGirdFunction() {
        var selectedRowIndex = 0;
        var $gridTable1 = $('#gridTable2');
        $gridTable1.jqGrid({
            url: "/shipment/getStowage.action?id="+keyValue,
            datatype: "json",
            height: $(window).height() - 200,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '分段运单号', name: 'code', width: 170, align: 'center'},
                {label: '订单日期', name: 'time', width: 150, align: 'center'},
                {label: '出发城市', name: 'fromCity', width: 100, align: 'center'},
                {label: '目的城市', name: 'toCity', width: 100, align: 'center'},
                {label: '总件数', name: 'number', width: 80, align: 'center'},
                {label: '总体积', name: 'volume', width: 80, align: 'center'},
                {label: '总重量', name: 'weight', width: 80, align: 'center'},
                {label: '总货值', name: 'value', width: 80, align: 'center'},
                {label: '客户类型', name: 'costomerType', width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CustomerType['' + cellvalue + '']
                    }},
                {label: '客户名称', name: 'customer.name', width: 130, align: 'center'},
                {label: '订单号', name: 'order.code', width: 150, align: 'center'},
                {label: '客户订单号', name: 'relatebill1', width: 150, align: 'center'},
                {label: "备注", name: "description", width: 190, align: "center"}
            ],
            pager: false,
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            multiselect: true,//复选框
            footerrow: true,
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
    }
    /**
    *确认单据
    */
    function confirmShipment(){
        if (!$('#id').val()) {
            dialogAlert('运单数据没有保存，不能确认', -1);
            return
        }
        $.SetForm({
            url: "/shipment/confirmShipment.action",
            param: {id: $('#id').val() },
            success: function (data) {
                if (data.type == "validator") {
                    $('#form1').ValidformResule(data.obj);//后台验证数据
                } else if (data.type) {
                    $.currentIframe().$("#gridTable").trigger("reloadGrid");
                    $('#id').val(data.obj.id);
                    $('#status').val(data.obj.status);
                    //修改和隐藏
                    ButtonPageInit()
                    dialogMsg("确认成功", 1);
                } else {
                    dialogAlert(data.obj, -1);
                }
            }
        });


    }
    function saveLedInfo() {
        if (!$('#id').val()) {
            dialogAlert('运单数据没有保存，不能添加明细', -1);
            return
        }
            var options = {
                width: "1250px",
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
                content: top.contentPath + 'jsp/Shipment/LoadingForm.jsp?keyValue=' + $('#id').val(),
                cancel: function () {
                    $("#gridTable2").trigger("reloadGrid");
                    if (options.cancel != undefined) {
                        options.cancel();
                    }
                    return true;
                }
            });


    }
    function selectCarrier(){
        dialogOpen({
            id: "CarrierFrom",
            title: '承运商选择',
            url: 'jsp/Carrier/CarrierIndex.jsp?status=1',
            width: "1050px",
            height: "450px",
            callBack: function (iframeId) {
                var resule = top.frames[iframeId].getCarrier();
                top.frames[iframeId].dialogClose();//关闭窗口
                $("#carrier").val(resule.id)
                $("#carrierName").val(resule.name)
                for(var i in top.clientdataItem.CarrierType){
                      if(top.clientdataItem.CarrierType[i] ==resule.carrierType){
                          $("#carrierType").ComboBoxSetValue(i);
                      }
                }

            }
        });
    }
    /**
     * 车型选择
     * @param self
     */
    function selectVehicle (self){
        dialogOpen({
            id: "VehicleFrom",
            title: '车型选择',
            url: 'jsp/vehicle/VehicleIndex.jsp?status=1',
            width: "1050px",
            height: "450px",
            callBack: function (iframeId) {
                var resule = top.frames[iframeId].getVehicle();
                top.frames[iframeId].dialogClose();//关闭窗口
                $("#vehicle").val(resule.id)
                $("#vehicleName").val(resule.code)
            }
        });
    }
    /**
     * 车头选择
     * @param self
     */
    function getVehicleHead (self){
        dialogOpen({
            id: "VehicleFrom",
            title: '车头选择',
            url: 'jsp/VehicleHead/VehicleHeadIndex.jsp?status=1',
            width: "1050px",
            height: "450px",
            callBack: function (iframeId) {
                var resule = top.frames[iframeId].getVehicleHead();
                $.SetForm({
                    url: "/vehicleHead/getVehicleHeadInfo.action",
                    param: {id:resule.id },
                    success: function (data) {
                        if(data.carriage != null && data.carriage != undefined){
                            $("#carriage").val(data.carriage.id);
                            $("#carriageName").val(data.carriage.name);
                        }
                        if(data.driver != null && data.driver != undefined){
                            $("#driver").val(data.driver.id);
                            $("#driverName").val(data.driver.name);
                        }
                        if(data.trailer != null && data.trailer != undefined){
                            $("#trailer").val(data.trailer.id);
                            $("#trailerName").val(data.trailer.name);
                        }
                        if(data.vehicleHead != null && data.vehicleHead != undefined){
                            $("#vehicleHead").val(data.vehicleHead.id);
                            $("#vehicleHeadName").val(data.vehicleHead.name);
                        }
                    }
                });
                top.frames[iframeId].dialogClose();//关闭窗口
            }
        });
    }
    /**
     * 车厢选择
     * @param self
     */
    function getCarriage (self){
        dialogOpen({
            id: "CarriageFrom",
            title: '车厢选择',
            url: 'jsp/Carriage/CarriageIndex.jsp?status=1',
            width: "1050px",
            height: "450px",
            callBack: function (iframeId) {
                var resule = top.frames[iframeId].getCarriage();
                $("#carriage").val(resule.id);
                $("#carriageName").val(resule.name);
                top.frames[iframeId].dialogClose();//关闭窗口
            }
        });
    }
    /**
     * 车挂选择
     * @param self
     */
    function getTrailer(){
        dialogOpen({
            id: "TrailerFrom",
            title: '车挂选择',
            url: 'jsp/JcTrailer/TrailerIndex.jsp?status=1',
            width: "1050px",
            height: "450px",
            callBack: function (iframeId) {
                var resule = top.frames[iframeId].getTrailer();
                $("#trailer").val(resule.id);
                $("#trailerName").val(resule.name);
                top.frames[iframeId].dialogClose();//关闭窗口
            }
        });
    }
    /**
     * 司机选择
     * @param self
     */
    function getDriver(){
        dialogOpen({
            id: "DriverFrom",
            title: '司机选择',
            url: 'jsp/BaseData/DriverSet/DriverIndex.jsp?status=1',
            width: "1050px",
            height: "450px",
            callBack: function (iframeId) {
                var resule = top.frames[iframeId].getDriver();
                $("#driver").val(resule.id);
                $("#driverName").val(resule.name);
                top.frames[iframeId].dialogClose();//关闭窗口
            }
        });
    }



</script>
<div class="ui-layout" id="layout" style="height: 100%; width: 100%;">
    <div class="ui-layout-west">
        <div class="west-Panel">
            <div class="profile-nav">
                <ul style="padding-top: 20px;">
                    <li class="active" onclick="profileSwitch('ShipmentInfo')">运单信息</li>
                    <li onclick="profileSwitch('LoadingManager')">配载管理</li>
                    <li onclick="profileSwitch('addressInfo')">地址时效</li>
                    <li onclick="profileSwitch('Dispatch')">派车单信息</li>
                    <li onclick="profileSwitch('RevisePassword')">运单在途</li>
                    <div class="divide"></div>
                    <li onclick="profileSwitch('s')">异常信息</li>
                    <li onclick="profileSwitch('SystemLog')">运单位置</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="ui-layout-center">
        <div class="center-Panel">
            <div class="profile-content" style="background: #fff;">
                <div id="ShipmentInfo" class="flag">
                    <div class="title">
                        运单信息
                    </div>
                    <form id="form1">
                        <table class="form" style="margin-top: 20px;">
                            <input id="id" name="id" type="hidden" value=""/>
                            <input id="status" name="status" type="hidden" value=""/>
                            <input id="carrier" name="carrier.id" type="hidden" value=""/>
                            <input id="vehicle" name="vehicle.id" type="hidden" value=""/>
                            <tr>
                                <td class="formTitle">运单号</td>
                                <td class="formValue">
                                    <input id="code" disabled = "disabled"  type="text" class="form-control" placeholder="系统自动生成" />
                                </td>
                                <th class="formTitle">运单日期<font face="宋体">*</font></th>
                                <td class="formValue">
                                    <input id="time" type="text"  placeholder="请选择运单时间"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                                </td>
                                <th class="formTitle">运输协议号</th>
                                <td class="formValue">
                                    <input id="tan" onclick="setSend()" type="text" class="form-control" maxlength="50"/>
                                </td>
                            </tr>
                            <tr>
                                <th class="formTitle">承运商<font face="宋体">*</font></th>
                                <td class="formValue">
                                    <input id="carrierName"  onclick="selectCarrier()"  isvalid="yes"  checkexpession="NotNull" type="text" readonly class="form-control" placeholder="承运商必须"/>
                                    <span class="input-button" onclick="selectCarrier()" title="请选择承运商" >.......</span>
                                </td>
                                <th class="formTitle">承运商类型</th>
                                <td class="formValue">
                                    <div id="carrierType" disabled="disabled" name="carrierType" type="select" class="ui-select"
                                         isvalid="yes" checkexpession="NotNull"></div>
                                </td>
                                <th class="formTitle">付款方式</th>
                                <td class="formValue">
                                    <div id="feeType" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull"><ul> </ul> </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="formTitle">指定车型<font face="宋体">*</font></th>
                                <td class="formValue">

                                    <input id="vehicleName" onclick="selectVehicle($(this));" placeholder="指定派车单车型"  isvalid="yes" readonly  checkexpession="NotNull" type="text" class="form-control"/>
                                    <span class="input-button" ForderBy = "1" onclick="selectVehicle($(this))" title="请选择车型" >.......</span>
                                </td>
                                <th class="formTitle">回单份数</th>
                                <td class="formValue">
                                    <input id="backNumber" value="0" disabled = "disabled" type="text" class="form-control"/>
                                </td>
                                <th class="formTitle">装卸信息</th>
                                <td class="formValue">
                                    <input id="loadingInfo" disabled = "disabled" type="text" class="form-control"/>
                                </td>
                            <tr>
                                <th class="formTitle">运输方式</th>
                                <td class="formValue">
                                    <div id="shipmentMethod" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                                        <ul>
                                        </ul>
                                    </div>
                                </td>
                                <th class="formTitle">要求发车日期<font face="宋体">*</font></th>
                                <td class="formValue">
                                    <input id="planLeaveTime" type="text"  placeholder="请选择要求发车日期"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                                </td>
                                <th class="formTitle">要求到车日期<font face="宋体">*</font></th>
                                <td class="formValue">
                                    <input id="requireArriveTime" type="text"  placeholder="请选择要求到车日期"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                                </td>
                            </tr>
                            <tr>
                                <th class="formTitle">线路选择<font face="宋体">*</font></th>
                                <td class="formValue">
                                    <input id="line" name="line.id" isvalid="yes"  checkexpession="NotNull" type="text" class="form-control"/>
                                </td>
                                <th class="formTitle">实际发车日期</th>
                                <td class="formValue">
                                    <input id="factLeaveTime" type="text"  disabled = "disabled"  disabled = "disabled" class="form-control input-wdatepicker" onfocus="WdatePicker()"/>
                                </td>
                                <th class="formTitle">实际到车日期</th>
                                <td class="formValue">
                                    <input id="factArriveTime" type="text" disabled = "disabled"   disabled = "disabled"  class="form-control input-wdatepicker" onfocus="WdatePicker()"/>
                                </td>
                            </tr>
                            <tr>
                                <th class="formTitle">备注</th>
                                <td class="formValue">
                                    <textarea id="description" type="text" style="width: 700px;" class="form-control"></textarea>
                                </td>
                            </tr>
                            <td>
                                <hr style="color: #0a2b1d" width="900px">
                            </td>
                                <tr>
                                    <td class="formTitle" STYLE="font-weight: bold ">运费总计</td>
                                    <td class="formValue" >
                                        <input id="amount" type="number" style="text-align:center"  disabled = "disabled" value="0" class="form-control"/>
                                    </td>
                                    <td class="formTitle" STYLE="font-weight: bold ">税率</td>
                                    <td class="formValue" >
                                        <div id="taxRate" name = "taxRate" onchange="updateTaxRate()" class="radio" type="radio">
                                        </div>
                                    </td>
                                    <td class="formTitle" STYLE="font-weight: bold ">税金</td>
                                    <td class="formValue" >
                                        <input id="input" type="number" style="text-align:center"  disabled = "disabled" value="0" class="form-control"/>
                                    </td>
                                    <td class="formTitle"></td>
                                    <td class="formValue" >
                                        <Span></Span>
                                    </td>
                                </tr>
                        </table>
                        <table class="form" id = "feeTypeClass">
                        </table>
                        <div id="bottomField">
                            <a id="saveShipment" class="btn btn-success" onclick="savaShipment()">保存单据</a>
                            <a id="confirmShipment" class="btn btn-warning" onclick="confirmShipment();">确认单据</a>
                            <a id="printShipment" class="btn btn-default" onclick="AcceptClick(2)">打印单据</a>
                        </div>
                    </form>
                </div>

                <%--车辆配载--%>
                <div id="LoadingManager" class="flag" style="display: none;">
                    <div class="title">
                        配载信息
                    </div>
                    <div class="bills">
                        <div class="gridPanel">
                            <table id="gridTable2"></table>
                        </div>
                    </div>
                    <div id="bottomField4">
                        <a id="loadingShipment" class="btn btn-default" onclick="saveLedInfo()">配载</a>
                    </div>
                </div>
                <%--地址信息--%>
                <div id="addressInfo" class="flag" style="display: none;">
                    <div class="title">
                        地址明细
                    </div>
                    <div class="bills">
                        <div class="gridPanel">
                            <table id="gridTableAddress"></table>
                        </div>
                    </div>
                </div>
                <div id="Dispatch" class="flag" style="display: none;">
                    <div class="title">
                        派车单信息
                    </div>
                    <iframe width=960 height=510 frameborder=0 scrolling=auto src="/jsp/Dispatch/DisptchFrom.jsp"></iframe>

                </div>
                <div id="RevisePassword" class="flag" style="display: none;">
                    <div class="title">
                        在途跟踪
                    </div>
                    <table class="form" style="margin-top: 20px;">
                        <tr>
                            <td class="formValue">
                                <input id="RedoNewPassword" type="input" class="form-control input-profile"
                                       style="float: left;width: 800px;height: 400px"/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="SystemLog" class="flag" style="display: none;">
                    <div style="margin-top: 10px;">
                        <div class="titlePanel">
                            <div class="title-search">
                            </div>
                        </div>
                        <div class="gridPanel">
                            <table id="gridTable3"></table>
                            <div id="gridPager"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .file {
        position: relative;
        display: inline-block;
        overflow: hidden;
        text-decoration: none;
        text-indent: 0;
        cursor: pointer !important;
    }

    .file input {
        position: absolute;
        font-size: 150px;
        right: 0;
        top: 0;
        opacity: 0;
        cursor: pointer !important;
    }

    .file:hover {
        text-decoration: none;
        cursor: pointer !important;
    }

    .profile-content .formTitle {
        width: 100px;
        height: 20px;
        text-align: right;
    }
    .profile-content .formValue {
        width: 200px;
    }
    .profile-content .input-profile {
        border-radius: 4px;
        width: 60px;
    }
</style>
<%--高德导航--%>
<link href="/Content/styles/jet-gd.css" rel="stylesheet"/>
<%--<script src="/Content/scripts/utils/jet-gdutil.js?v=1.3&key=49df3dbb93cc593e8cceedfe8f8be185"></script>--%>
<script src="https://webapi.amap.com/maps?v=1.3&key=49df3dbb93cc593e8cceedfe8f8be185"></script>
<script src="/Content/scripts/utils/jet-gd.js"></script>
</body>
</html>