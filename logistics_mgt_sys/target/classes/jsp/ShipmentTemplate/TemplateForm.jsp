<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2017/12/04
  Time: 21:27
  运单模板表单
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
    <title>运单模板</title>
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
    <script src="/Content/scripts/utils/jet-pinyin.js"></script>

    <style>
        html, body {
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<body>
<script>
    var feeTypeData;//费用变量存储
    var carrierData ;//承运商变量存储
    var keyValue = request('keyValue');
    var isCreate = true;
    var orgList =null;
    var orgtoList =null;
    $(function () {
        getOrgList();
        InitialPage();
        InitControl();
        //changeLiense();
    });
    //初始化数据
    function InitControl() {
        getFeeType();//初始化运单费用类型
        getCarrierData();//初始化承运商
        $("#startOrg").ComboBox({ //运输方式
            description: "=你选择站点=",
            height: "200px",
            data:orgList
        });
        $("#endOrg").ComboBox({ //运输方式
            description: "=你选择站点=",
            height: "200px",
            data:orgList
        });
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
        $("#operationPattern").ComboBox({ //作业模式
            description: "=请选择作业模式=",
            height: "200px",
            data: top.clientdataItem.OperationPattern,
        });

        if (!!keyValue) {
            isCreate = false;
            $.SetForm({
                url: "/template/selectBean.action",
                param: {tableName:"JC_SHIPMENT_TEMPLATE", id: keyValue },
                success: function (data) {
                    $("#form1").SetWebControls(data);
                    if(data.carrier != null && data.carrier != undefined){
                        $("#carrier").val(data.carrier.id);
                        $("#carrierName").val(data.carrier.name);
                    }
                    $("#vehicle").val(data.vehicle.id);
                    $("#vehicleName").val(data.vehicle.code);
                    if(data.vehicleHead != null && data.vehicleHead != undefined){
                        $("#vehicleHead").val(data.vehicleHead.id);
                        $("#vehicleHeadName").val(data.vehicleHead.code);
                    }else{
                        $("#vehicleHeadName").val(data.liense);
                    }

                    if(data.driver != null && data.driver != undefined){
                        $("#driver").val(data.driver.id);
                        $("#driverName").val(data.driver.name);
                        $("#driverTel").val(data.driver.iphone1);
                    }else{
                        $("#driverName").val(data.outDriver);
                        $("#driverTel").val(data.outIphpne);
                    }

                    if(data.toOrganization !=null){
                        var toOrganization = $("#endOrg")
                        toOrganization.attr("data-value",data.toOrganization.id);
                        toOrganization.attr("data-text",data.toOrganization.name);
                        toOrganization.find('.ui-select-text').html(data.toOrganization.name).css('color', '#000')
                    }
                    if(data.fromOrganization !=null){
                        var toOrganization = $("#startOrg")
                        toOrganization.attr("data-value",data.fromOrganization.id);
                        toOrganization.attr("data-text",data.fromOrganization.name);
                        toOrganization.find('.ui-select-text').html(data.fromOrganization.name).css('color', '#000')
                    }

                    GetGrid5() //初始化费用明细
                    var $JGGRID = $("#gridTable5");
                    $JGGRID.jqGrid("clearGridData"); //清空数据
                    $JGGRID.setGridHeight(0)
                    if(data.templateLedgers != null){
                        for(i=0;i<data.templateLedgers.length;i++){
                            var ledgerdetail = data.templateLedgers[i];
                            //$JGGRID.setGridHeight($JGGRID.getGridParam("height") + 28 * ledgerdetail.length)
                            $JGGRID.addRowData(getUUID(),ledgerdetail,"first");
                            $("#yue").val(ledgerdetail.yuE)
                            $("#zfy").val(ledgerdetail.zfy)
                            $("#zthf").val(ledgerdetail.zthf)
                            $("#zgxyf").val(ledgerdetail.zgxyf)
                            $("#zshf").val(ledgerdetail.zshf)
                            $("#zqtfy").val(ledgerdetail.zqtfy)
                            $("#xianjie").val(ledgerdetail.nowPay)
                            $("#huifu").val(ledgerdetail.backPay)
                            $("#yuejie").val(ledgerdetail.monthPay)
                            $JGGRID.setGridHeight("auto");
                        }
                    }
                    //初始化经由站
                    var berthStand =  data.berthStand
                    if(berthStand.length>0){
                        for(i = 0; i <berthStand.length ; i++){
                            addOrg(berthStand[i])
                        }
                    }
                }
            });
        } else {
            GetGrid5() //初始化费用明细
            initFeeType();
            $("#feeType").ComboBoxSetValue(0);
            $("#shipmentMethod").ComboBoxSetValue(0);
            $("#operationPattern").ComboBoxSetValue(0);
            $("#startOrg").ComboBoxSetValue('${orgId.id}')

        }
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

        $('.profile-content').height($(window).height() - 20);
        //resize重设(表格、树形)宽高
        $(window).resize(function (e) {
            window.setTimeout(function () {
                $('.profile-content').height($(window).height() - 20);
            }, 200);
            e.stopPropagation();
        });
    }


    function initFeeType(){
        $.ajax({
            url: "/feetype/getModelFeeType.action",
            data: {id:"2"},
            async:false,
            type: "post",
            dataType: "json",
            success: function (data) {
                var $JGGRID = $JGGRID = $("#gridTable5");
                $JGGRID.addRowData(getUUID(),data,"first");
                $JGGRID.setGridHeight("auto");
            },
        });
    }



    /**
     * 保存单据
     * */
    function savaTemplate() {
        $.removeFromMessage($("#form1"));
        if (!$('#form1').Validform()) {
            return false;
        }
        //var postData = $("#form1").GetWebControls(keyValue);
        var postData = {
            id:$("#id").val(),
            code:$("#code").val(),
            name:$("#name").val(),
            status:$("#status").val(),
            tan:$("#tan").val(),
            operationPattern:$("#operationPattern").attr('data-value'),
            carrierType:$("#carrierType").attr('data-value'),
            shipmentMethod:$("#shipmentMethod").attr('data-value'),
            feeType:$("#feeType").attr('data-value'),
            liense:$("#vehicleHeadName").val(),
            outDriver:$("#driverName").val(),
            outIphpne:$("#driverTel").val(),
            description:$("description").val(),
        }
        if( $("#carrier").val() != ""){
            postData['carrier']={
                id: $("#carrier").val(),
               // name:$("#carrierName").val()
            }
        }
        if( $("#vehicle").val() != ""){
            postData['vehicle']={
                id:$("#vehicle").val(),
               // code:$("#vehicleName").val()
            }
        }

        if( $("#vehicleHead").val() != ""){
            postData['vehicleHead']={
                id: $("#vehicleHead").val(),
               // code:$("#vehicleHeadName").val()
            }
        }
        if( $("#driver").val() != ""){
            postData['driver']={
                id: $("#driver").val(),
               // name:$("#driverName").val()
            }
        }
        if($("#fromOrganization").attr('data-value') !=""){
            postData['fromOrganization']={
                id:$("#startOrg").attr('data-value')

            }
        }
        if($("#toOrganization").attr('data-value') !=""){
            postData['toOrganization']={
                id:$("#endOrg").attr('data-value')
            }
        }
        //处理经由站
        var ids =""
        $("[jyz='jyz']").each(function(){
            var id = $(this).attr('data-value')
            if(id == null || id == "" ){
                alert("经由站不能为空");
            }
            ids +=id+",";
        })
        ids = ids.substring(0,ids.lastIndexOf(","))
        postData['orgIds']=ids;

        //处理台账
        var jggirdData2 = $('#gridTable5').jqGrid("getRowData");
        var LedgerDetails = new Array(); //台账明细
        var countAmount =0;
        var countInput = 0;
        for(i=0;i<jggirdData2.length;i++){
            var feeTypeId;
            var leddetail = jggirdData2[i]
//            countAmount=countAmount+parseFloat(leddetail.amount)
//            countInput=countInput+parseFloat(leddetail.input)
            for(var j in feeTypeData){
                if(feeTypeData[j] ==leddetail['feeType.name']){
                    feeTypeId=j
                }
            }

            for(var k in carrierData){
                if(carrierData[k] ==leddetail['carrier.name']){
                    carrierId=k
                }
            }

            var LedgerDetail = {
                id:leddetail.id,
                feeType : {
                    id:feeTypeId
                },
                carrier:{
                    id:carrierId
                },
                amount:leddetail.amount,
                taxRate:leddetail.taxRate,
                input:leddetail.input,
                outcome:leddetail.outcome,
                settlementMethod:leddetail.settlementMethod,
                payMethod:leddetail.payMethod,
                oilPrepaid:leddetail.oilPrepaid,
                cashAdvances:leddetail.cashAdvances,
                description:leddetail.description,
            }
            LedgerDetails.push(LedgerDetail)
        }

        postData['templateLedgers'] = LedgerDetails;
        console.log(postData)
        var params = {str:JSON.stringify(postData)};
        var url ="template/saveTemplate.action";

        $.SaveForm({
            url: url,
            param:params ,
            loading: "正在保存数据...",
            success: function (data) {
                if (data.type == "validator") {
                    $('#form1').ValidformResule(data.obj);//后台验证数据
                } else if (data.type) {
                    isCreate = false;
                    $.currentIframe().$("#gridTable").trigger("reloadGrid");
                    dialogClose();//关闭窗口
                } else {
                    dialogAlert(data.obj, -1);
                }
            }
        })

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


                //处理台账
                var jggirdData2 = $('#gridTable5').jqGrid("getRowData");
                var LedgerDetails = new Array(); //台账明细

                for(i=0;i<jggirdData2.length;i++){
                    var feeTypeId;
                    var leddetail = jggirdData2[i]
                    for(var j in feeTypeData){
                        if(feeTypeData[j] ==leddetail['feeType.name']){
                            feeTypeId=j
                        }
                    }
                    var LedgerDetail = {
                        id:leddetail.id,
                        feeType : {
                            id:feeTypeId,
                            name:leddetail['feeType.name']
                        },
                        carrier:{
                            id:resule.id,
                            name:resule.name
                        },
                        amount:leddetail.amount,
                        taxRate:leddetail.taxRate,
                        input:leddetail.input,
                        outcome:leddetail.outcome,
                        settlementMethod:leddetail.settlementMethod,
                        payMethod:leddetail.payMethod,
                       /* oilPrepaid:leddetail.oilPrepaid,
                        cashAdvances:leddetail.cashAdvances,*/
                        description:leddetail.description,
                    }
                    LedgerDetails.push(LedgerDetail)
                }

                var $JGGRID = $("#gridTable5");
                $JGGRID.jqGrid("clearGridData"); //清空数据
                $JGGRID.setGridHeight(0);
                for(i=0;i<LedgerDetails.length;i++){
                    var ledgerdetail2 = LedgerDetails[i];
                    $JGGRID.addRowData(getUUID(),ledgerdetail2,"first");
                    $JGGRID.setGridHeight("auto");
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
            url: 'jsp/VehicleHead/VehicleHeadIndex.jsp?status=1&shipmentSign=1',
            width: "1050px",
            height: "450px",
            callBack: function (iframeId) {
                var resule = top.frames[iframeId].getVehicleHead();
                $.SetForm({
                    url: "/vehicleHead/getVehicleHeadInfo.action",
                    param: {id:resule },
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
                            $("#vehicleHeadName").val(data.vehicleHead.code);
                        }
                    }
                });
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


    function GetGrid5() {
        function isInteger(obj) {
            reg =/^[-\+]?\d+(\.\d+)?$/;
            if (!reg.test(obj)) {
                return false;
            } else {
                return true;
            }
        }
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable5');
        var numberValidator = function(val, nm){
            var boolean = isInteger(val)
            if(boolean){
                return [true,parseFloat(val)];
            }
            return  [false,"请输入正确数字"];
        }
        $gridTable.jqGrid({
            datatype: "json",
            height: 0,
            autowidth: true,
            cellEdit:true,
            cellsubmit:"clientArray",
            colModel: [
                { label: "主键", name: "id", index: "id", hidden: true },
                { label: "主键", name: "feeType.id", index: "id", hidden: true },
                { label: "主键", name: "carrier.id", index: "id", hidden: true },
                { label: "承运商", name: "carrier.name",  width: 150,resizable:false,editable:true,edittype:'select', align: "center",editoptions: {value: carrierData}},
                { label: "费用名称", name: "feeType.name",  width: 90,resizable:false,editable:true,edittype:'select', align: "center",editoptions: {value: feeTypeData}},
                { label: "应付金额", name: "amount",  index: "amount", resizable:false, width: 100, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "税率", name: "taxRate",  width: 50,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.TaxRate}},
                { label: "税金", name: "input", index: "input",resizable:false,  width: 80, align: "center"},
                { label: "成本", name: "outcome", index: "outcome",resizable:false,  width: 80, align: "center"},
                { label: "结算方式", name: "settlementMethod",  width: 80,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.Clearing}},
                { label: "支付方式", name: "payMethod",  width: 100,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.PayMethod}},
                /*{ label: "预付油卡", name: "oilPrepaid",  index: "target", resizable:false, width: 80, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "预付现金", name: "cashAdvances",  index: "target", resizable:false, width: 80, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "现结", name: "nowPay",  index: "target", resizable:false, width: 60, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "回付", name: "backPay",  index: "target", resizable:false, width: 60, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "月结", name: "monthPay",  index: "target", resizable:false, width: 60, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},*/
                { label: "备注", name: "description", resizable:false, index: "description", width: 150,edittype: "text", align: "center" ,editable:true },
                { label: '<button type="button" onclick="addJgGirdNullData2()" class="btn btn-success btn-xs">添加费用</button>',   sortable: false, width: 80, align: "center",
                    formatter: function (cellvalue, options, rowObject) {

                        return '<button type="button" onclick="deleteJgGirdNullData2($(this))" class="btn btn-danger btn-xs">删除费用</button>'
                    }}
            ],
            pager: false,
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            footerrow: true,
            caption: "费用信息",
            afterSaveCell:function(rowid, cellname, value, iRow, iCol){
                //计算税率
                var rowData = $(this).getRowData(rowid)
                var taxRate = parseFloat(rowData.amount / (1 + parseFloat(rowData.taxRate)) * parseFloat(rowData.taxRate));
                var taxRate =taxRate.toFixed(${SystemConfig.inputRoundNumber}) ;
                rowData.input = taxRate;
                rowData.outcome =rowData.amount - rowData.input;
                $(this).setRowData(rowid,rowData)
                feeTypeTotal($(this))
                //计算合计


            },
            gridComplete: function () {
                var number = $(this).getCol("amount", false, "sum");
                var input = $(this).getCol("input", false, "sum");
                var outcome = $(this).getCol("outcome", false, "sum");

                var oilPrepaid = $(this).getCol("oilPrepaid", false, "sum");
                var cashAdvances = $(this).getCol("cashAdvances", false, "sum");
                //合计
                $(this).footerData("set", {
                    "feeType.name": "合计：",
                    "amount":  number,
                    "input":  input,
                    "outcome": outcome,
                    "oilPrepaid":oilPrepaid,
                    "cashAdvances": cashAdvances,
                    // "amount": "金额:" + number,
                    // "input": "税金 :" + input,
                    // "outcome": "成本 :" + outcome,
                    // "oilPrepaid":"油卡:" + oilPrepaid,
                    // "cashAdvances":"现金:" + cashAdvances,
                });
            },
        });
    }
    /**
     * 费用合计
     */
    function feeTypeTotal(JGGIRD){
        var amount = JGGIRD.getCol("amount", false, "sum");
        var input = JGGIRD.getCol("input", false, "sum");
        var outcome = JGGIRD.getCol("outcome", false, "sum");
        var oilPrepaid = JGGIRD.getCol("oilPrepaid", false, "sum");
        var cashAdvances = JGGIRD.getCol("cashAdvances", false, "sum");
        //合计
        JGGIRD.footerData("set", {
            "feeType.name": "合计：",
            "amount": "金额:" + amount,
            "input": "税金:" + input,
            "outcome": "成本:" + outcome,
            "oilPrepaid":"油卡:" + oilPrepaid,
            "cashAdvances":"现金:" + cashAdvances,
        });
    }
    function deleteJgGirdNullData2 (data){
        var $JGGRID = $("#gridTable5");
        data.parent().parent().remove();
        feeTypeTotal($JGGRID);
        $JGGRID.setGridHeight("auto");
    }
    function addJgGirdNullData2 (){
        var model={
            id:null,
            carrier:{
                id: $("#carrier").val(),
                name:$("#carrierName").val()
            },
            name:null,
            taxRate:0.1,
            settlementMethod:"月结",
            payMethod:"银行",
            description:null,
        }
        var $JGGRID = $("#gridTable5")
//            $JGGRID.jqGrid("addRowData",null,"first");
        $JGGRID.addRowData(getUUID(),model,"first");
        $JGGRID.setGridHeight("auto");
    }
    function getFeeType(){
        $.ajax({
            url: "/feetype/getFeeType.action",
            data: {id:"2.1"},
            async:false,
            type: "post",
            dataType: "json",
            success: function (data) {
                feeTypeData =data;
            },
        });

    }

    function getCarrierData(){
        $.ajax({
            url: "/carrier/getCarrier.action",
            async:false,
            type: "post",
            dataType: "json",
            success: function (data) {
                carrierData = data;
            }
        });
    }

    var is = 0;
    var uuidc
    function   addOrg(berthStand){
        if(is >3){
            alert("经由站过多，中国没那么大")
            return
        }
        var uuid = getUUID();

        html ='<th class="formTitle"><font face="宋体">*</font>经由站</th>'
        html +='<td class="formValue">'
        html +='<div isvalid="yes" checkexpession="NotNull" id="'+uuid+'" jyz="jyz" type="select" class="ui-select"></div>'
        html +='</td>'
        $("#vis").before(html)
        if(is ==1 || is ==4){
            uuidc = getUUID();
            var vs = $("#ttrr").after('<tr  id="'+uuidc+'"></tr>')
            $("#" + uuidc).append($("#vis"));
            $("#" + uuidc).append($("#viss"));

        }
        var jys = $("#" + uuid)
        jys.ComboBox({ //运输方式
            description: "=你选择站点=",
            height: "200px",
            data:orgList
        });

        if(berthStand !=null){
            jys.attr("data-value",berthStand.organization.id);
            jys.attr("data-text",berthStand.organization.name);
            jys.find('.ui-select-text').html(berthStand.organization.name).css('color', '#000')
        }
        is++;

    }
    function delOrg(self){
        $("[jyz='jyz']").each(function(){
            $(this).parent().prev().remove()
            $(this).parent().remove()
        })
        var startOrg = $("#startOrg").parent()
        startOrg.after($("#viss"));
        startOrg.after($("#vis"));

        $("#" + uuidc).remove()
        is=0;
    }

    function getOrgList(){
        $.ajax({
            url: "/shipment/getOrg.action",
            async:false,
            type: "post",
            dataType: "json",
            success: function (data) {
                orgList = data;
            }
        });
    }

    function getOrgToList(aaa){
        var ww = null;
        var yzms = $("#operationPattern").attr('data-value');
        if(yzms =='' || yzms =='undefined'){
            ww = aaa;
        }else{
            ww = yzms;
        }
        console.log(ww)
        $.ajax({
            url: "/shipment/getOrgww.action",
            data:{"aaa":ww},
            async:false,
            type: "post",
            dataType: "json",
            success: function (data) {
                console.log(data);
                orgtoList = data;
            }
        });
    }


</script>
<div class="ui-layout" id="layout" style="height: 100%; width: 100%;">
    <div class="ui-layout-center">
        <div class="center-Panel">
            <div class="profile-content" style="background: #fff;">
                <div id="ShipmentInfo" class="flag">
                    <form id="form1">
                        <table class="form" style="margin-top: 20px;">
                            <input id="id" name="id" type="hidden" value=""/>
                            <input id="status" name="status" type="hidden" value=""/>
                            <input id="carrier" name="carrier.id" type="hidden" value=""/>
                            <input id="vehicle" name="vehicle.id" type="hidden" value=""/>
                            <input id="line" name="line.id" type="hidden" value=""/>
                            <tr>
                                <td class="formTitle">模板名称<font face="宋体">*</font></td>
                                <td class="formValue">
                                    <input id="name"   type="text" class="form-control"  onKeyUp="pinyinQuery('name','code')" isvalid="yes" checkexpession="NotNull"  />
                                </td>
                                <td class="formTitle">模板代码<font face="宋体">*</font></td>
                                <td class="formValue">
                                    <input id="code" disabled = "disabled"  type="text" class="form-control"  />
                                </td>

                                <th class="formTitle">运输协议号</th>
                                <td class="formValue">
                                    <input id="tan"  type="text" class="form-control" maxlength="50"/>
                                </td>
                            </tr>
                            <tr>
                                <th class="formTitle">运作模式<font face="宋体">*</font></th>
                                <td class="formValue">
                                    <div id="operationPattern" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                                        <ul>
                                        </ul>
                                    </div>
                                </td>
                                <th class="formTitle">承运商</th>
                                <td class="formValue">
                                    <input id="carrierName"  onclick="selectCarrier()"   type="text"  class="form-control" />
                                    <span id="carrierNameSpan" class="input-button" onclick="selectCarrier()" title="请选择承运商" >.......</span>
                                </td>
                                <th class="formTitle">承运商类型</th>
                                <td class="formValue">
                                    <div id="carrierType" disabled="disabled" name="carrierType" type="select" class="ui-select"
                                    ></div>
                                </td>
                            </tr>
                            <tr>
                                <th class="formTitle">指定车型<font face="宋体">*</font></th>
                                <td class="formValue">
                                    <input id="vehicleName" onclick="selectVehicle($(this));" placeholder="指定派车单车型"  isvalid="yes" readonly  checkexpession="NotNull" type="text" class="form-control"/>
                                    <span class="input-button" ForderBy = "1" onclick="selectVehicle($(this))" title="请选择车型" >.......</span>
                                </td>
                                <th class="formTitle">运输方式</th>
                                <td class="formValue">
                                    <div id="shipmentMethod" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                                        <ul>
                                        </ul>
                                    </div>
                                </td>
                                <th class="formTitle">付款方式</th>
                                <td class="formValue">
                                    <div id="feeType" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull"><ul> </ul> </div>
                                </td>
                            </tr>
                            <tr >
                                <th class="formTitle">车牌号<font face="宋体">*</font></th>
                                <td class="formValue">
                                    <input id="vehicleHead" autocomplete="off" name="vehicleHead.id" type="hidden" value=""/>
                                    <input id="vehicleHeadName" autocomplete="off"   type="text" class="form-control" isvalid="yes" checkexpession="NotNull" />
                                    <span  id="onclick1" class="input-button" onclick="getVehicleHead()" title="车头" >.......</span>
                                </td>
                                <th class="formTitle">司机<font face="宋体">*</font></th>
                                <td class="formValue">
                                    <input id="driver" autocomplete="off" name="driver.id" type="hidden" value=""/>
                                    <input id="driverName" autocomplete="off"   type="text" isvalid="yes" checkexpession="NotNull"  class="form-control" />
                                    <span  id="onclick2" class="input-button" onclick="getDriver()" title="司机" >.......</span>
                                </td>
                                <td class="formTitle">司机电话<font face="宋体">*</font></td>
                                <td class="formValue">
                                    <input id="driverTel" autocomplete="off"   type="text" class="form-control" isvalid="yes" checkexpession="NotNull" />
                                </td>
                            </tr>

                            <tr id="ttrr">
                                <th class="formTitle"><span style="margin-right: 5px"><i onclick="addOrg()" class="fa fa-plus-square-o" ></i></span><span style="margin-right: 5px"><i onclick="delOrg($(this))" class="fa fa-minus-square-o" ></i></span><font face="宋体">*</font>启运站</th>
                                <td class="formValue">
                                    <div id="startOrg"   name="carrierType" isvalid="yes" checkexpession="NotNull" type="select" class="ui-select"></div>
                                </td>
                                <th class="formTitle" id = 'vis'><font face="宋体">*</font>目的站</th>
                                <td class="formValue" id = 'viss'>
                                    <div  id="endOrg" name="carrierType" isvalid="yes" checkexpession="NotNull" type="select" class="ui-select"></div>
                                </td>
                            </tr>

                            <tr id="descriptionss">
                                <th class="formTitle">备注</th>
                                <td class="formValue">
                                    <textarea id="description" type="text" style="width: 700px;" class="form-control"></textarea>
                                </td>
                            </tr>
                            <%--<td>
                                <hr style="color: #0a2b1d" width="900px">
                            </td>--%>
                            <tr >
                                <td class="formValue" colspan="6">
                                    <div class="gridPanel">
                                        <table id="gridTable5"></table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <div id="bottomField" class="shipmentmanage">
                            <a id="savaTemplate" class="btn btn-success" onclick="savaTemplate()">保存模板</a>
                        </div>
                    </form>
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
    .ui-jqgrid tr.jqgrow td{
        border-width: 0.05px;border-right-style: dashed ;border-right-color: #bbc0d0;font-weight: normal;overflow: hidden;white-space: pre;line-height:25px;height: 25px;padding: 0 5px 0 5px;

    }
</style>
<%--高德导航--%>
<link href="/Content/styles/jet-gd.css" rel="stylesheet"/>
<%--<script src="/Content/scripts/utils/jet-gdutil.js?v=1.3&key=49df3dbb93cc593e8cceedfe8f8be185"></script>--%>
<script src="https://webapi.amap.com/maps?v=1.3&key=49df3dbb93cc593e8cceedfe8f8be185"></script>
<script src="/Content/scripts/utils/jet-gd.js"></script>
</body>
</html>