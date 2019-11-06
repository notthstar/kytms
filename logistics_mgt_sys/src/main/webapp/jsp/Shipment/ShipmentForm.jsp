<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2017/12/04
  Time: 21:27
  运单表单
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
    var feeTypeData;//费用变量存储
    var carrierData ;//承运商变量存储
    var isCreate = true;
    var keyValue = request('keyValue');
    var source = request('source'); //异常单标识
    var osType = request('osType');
    var orgList =null;
    var orgtoList =null;

    // class=ddlGeneral
//    var spelData = '<span><select name="ddlGKs" onchange="delPl(this);" type="text" class="form-control"></span>'
    $(function () {
        getOrgList()
        InitialPage();
        InitControl();
        // changeLiense();
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
            defaultVaue: '0.09'
        });

        $("#carrierType").ComboBox({ //承运商类型
            description: "==请选择==",
            height: "200px",
            data: top.clientdataItem.CarrierType
        });
        $("#specifyOrg").ComboBox({ //运输方式
            description: "=派车单维护方=",
            height: "200px",
            data: top.clientdataItem.DispatchSpecifyOrg
        });
        $("#operationPattern").ComboBox({ //作业模式
            description: "=请选择运作模式=",
            height: "200px",
            data: top.clientdataItem.OperationPattern,
        });
        $("#specifyOrg").ComboBoxSetValue(0);
        if (!!keyValue) {
            isCreate = false;
            $.SetForm({
                url: "/shipment/getShipment.action",
                param: {tableName:"JC_SHIPMENT", id: keyValue },
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
                    if(data.ledgerDetails != null){
                        for(i=0;i<data.ledgerDetails.length;i++){
                            var ledgerdetail = data.ledgerDetails[i];
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
            initFeeType2();
            showDate("time"); //初始化时间
//            $("#transportPro").ComboBoxSetValue(0);
            $("#feeType").ComboBoxSetValue(0);
            $("#shipmentMethod").ComboBoxSetValue(0);
            $("#operationPattern").ComboBoxSetValue(0);
              // getOrgToList(0);
            $("#startOrg").ComboBoxSetValue('${orgId.id}')
        }
        ButtonPageInit(); //初始化按钮
    }

    function GetGrid9() {
        function isInteger(obj) {
            reg =/^[-\+]?\d+(\.\d+)?$/;
            if (!reg.test(obj)) {
                return false;
            } else {
                return true;
            }
        }
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable9');
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
            width: true,
            cellEdit:true,
            cellsubmit:"clientArray",
            colModel: [
                { label: "主键", name: "id", index: "id", hidden: true },
                { label: "主键", name: "feeType.id", index: "id", hidden: true },
                { label: "费用名称", name: "feeType.name",  width: 100,resizable:false,editable:true,edittype:'select', align: "center",editoptions: {value: feeTypeData}},
                { label: "税率", name: "taxRate",  width: 60,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.Logistics_Tax_Rate}},
                { label: "金额", name: "amount",  index: "target", resizable:false, width: 130, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "税金", name: "input", index: "url",resizable:false,  width: 100, align: "center"},
                { label: "预付油卡", name: "oilPrepaid",  index: "target", resizable:false, width: 80, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "预付现金", name: "cashAdvances",  index: "target", resizable:false, width: 80, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "现结", name: "cashAdvances",  index: "target", resizable:false, width: 80, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "回付", name: "cashAdvances",  index: "target", resizable:false, width: 80, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "月结", name: "cashAdvances",  index: "target", resizable:false, width: 80, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "备注信息", name: "description", resizable:false, index: "description", width: 80,edittype: "text", align: "center" ,editable:true },
                { label: '<button type="button" onclick="addJgGirdNullData3()" class="btn btn-success btn-xs">添加费用</button>',   sortable: false, width: 90, align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        return '<button type="button" onclick="deleteJgGirdNullData3($(this))" class="btn btn-danger btn-xs">删除费用</button>'
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
                $(this).setRowData(rowid,rowData)
                feeTypeTotal($(this))
                //计算合计


            },
            gridComplete: function () {
                var number = $(this).getCol("amount", false, "sum");
                var input = $(this).getCol("input", false, "sum");
                var oilPrepaid = $(this).getCol("oilPrepaid", false, "sum");
                var cashAdvances = $(this).getCol("cashAdvances", false, "sum");
                //合计
                $(this).footerData("set", {
                    "feeType.name": "合计：",
                    "amount": "金额:" + number,
                    "input": "税金 :" + input,
                    "oilPrepaid":"预付油卡"+oilPrepaid,
                    "cashAdvances":"预付现金"+cashAdvances
                });
            },
        });
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
        $(".profile-content").find('.flag').hide();
        $(".profile-content").find("#" + id).show();
       var aa = $("#operationPattern").attr('data-value');
        if(id == 'LoadingManager'){
             if( aa ==0){
                 ledInfoGirdFunction();//初始化配载信息
                 $("#ceshi").hide();
                 $("#ceshi1").hide();
                 $("#shipmentft").hide();
             }
             if(aa==1){
                 ledInfoGirdFunction1(); //外包信息
             }
        }
        if(id == 'addressInfo'){
            addressInfoGird(); //初始化地址信息
        }
        if(id == 'ShipmentTrackFrom'){//在途信息
            initShipmentTrack();
        }
        if(id =='TruckLoad'){
            TruckLoad();
        }
    }
    function initShipmentTrack(){
        if($("#id").val() == null || $("#id").val() == "" || $("#id").val() == undefined){
            return;
        }
        $.SetForm({
            url: "/shipmenttrack/getTrackforString.action",
            param:{id:$("#id").val()},
            success: function (data) {
                $("#ShipmentTrack").val(data.obj);
            }
        });
    }
    function initFeeType2(){
        $.ajax({
            url: "/feetype/getModelFeeType.action",
            data: {id:"2"},
            async:false,
            type: "post",
            dataType: "json",
            success: function (data) {
                var $JGGRID =  $("#gridTable5");
                $JGGRID.addRowData(getUUID(),data,"first");
                $JGGRID.setGridHeight("auto");
            },
        });
    }
    /**
     * 总计运费
     * @param self
     */

    function sumFee2(){
        var sum = 0;
        $("#feeTypeClass2").find("input[name='fee2']").each(function(e){
            var self =$(this);
            if(self.attr("isCount") == 1){
                var number = 0
                if(self.val() != null && self.val() != undefined && self.val() != ""){
                    sum +=parseFloat(self.val());
                }
            }
        })
        $("#amount2").val(sum.toFixed(${SystemConfig.moneyRoundNumber}))
        updateTaxRate2();
    }


    /**
     * 保存单据
     * */
    function saveShipment() {
        $.removeFromMessage($("#form1"));
        if (!$('#form1').Validform()) {
            return false;
        }
        var postData = {
            id:$("#id").val(),
            code:$("#code").val(),
            status:$("#status").val(),
            time:$("#time").val(),
            tan:$("#tan").val(),
            operationPattern:$("#operationPattern").attr('data-value'),
            carrierType:$("#carrierType").attr('data-value'),
            backNumber:$("#backNumber").val(),
            shipmentMethod:$("#shipmentMethod").attr('data-value'),
            planLeaveTime:$("#planLeaveTime").val(),
            requireArriveTime:$("#requireArriveTime").val(),
            feeType:$("#feeType").attr('data-value'),
            factLeaveTime:$("#factLeaveTime").val(),
            factArriveTime:$("#factArriveTime").val(),
            liense:$("#vehicleHeadName").val(),
            outDriver:$("#driverName").val().trim(),
            outIphpne:$("#driverTel").val().trim(),

        }
        if($("#description").val() != null){
            var aa = $("#description").val();
                  aa = JSON.stringify(aa);
                postData['description']=aa;
        }
        if( $("#carrier").val() != ""){
            postData['carrier']={
                id: $("#carrier").val(),
            }
        }
        if( $("#vehicle").val() != ""){
            postData['vehicle']={
                id:$("#vehicle").val(),
            }
        }

        if( $("#vehicleHead").val() != ""){
            postData['vehicleHead']={
                id: $("#vehicleHead").val(),
            }
        }
        if( $("#driver").val() != ""){
            postData['driver']={
                id: $("#driver").val(),
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
            var carrierId;
            var leddetail = jggirdData2[i]
            console.log(leddetail)
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
                nowPay:leddetail.nowPay,
                backPay:leddetail.backPay,
                monthPay:leddetail.monthPay,
                cashAdvances:leddetail.cashAdvances,
                description:leddetail.description,
            }
            LedgerDetails.push(LedgerDetail)
        }
//        var LedgerDetails = {
//            amount:countAmount,
//            taxRate:0,
//            input:countInput,
//            type:0,
//            cost:1
//        }
//        LedgerDetails['LedgerDetails'] = LedgerDetails;
//        LedgerDetails.push(LedgerDetails);
        postData['LedgerDetails'] = LedgerDetails;
        var params = {str:JSON.stringify(postData)};
        var url ="shipment/saveShipment.action";
        //异常修改提交地址
        if($('#saveShipment').text() == "确认修改"){
            url =  "/shipment/saveAbnormalShipment.action";
            params["text"]= $("#abnormal").val();
        }

        $.SaveForm({
            url: url,
            param:params ,
            loading: "正在保存数据...",
            success: function (data) {
                if (data.type == "validator") {
                    $('#form1').ValidformResule(data.obj);//后台验证数据
                } else if (data.result) {
                    $.currentIframe().$("#gridTable").trigger("reloadGrid");
                    //赋值
                    $('#code').val(data.obj.code);
                    $('#id').val(data.obj.id);
                    $('#status').val(data.obj.status);
                    //修改和隐藏
                    ButtonPageInit()//按钮控制
                    isCreate = false;

                    dialogMsg("保存成功", 1);
                    if(source){
                        dialogClose();//关闭窗口
                    }
                } else {
                    dialogAlert(data.obj, -1);
                }
            }
        })

    }
    /*地址信息加载*/
    function addressInfoGird(){
        var selectedRowIndex = 0;
        var $gridTable88 = $('#gridTableAddress');
        $gridTable88.jqGrid({
            url: "/shipment/getAddressInfo.action?id="+$('#id').val(),
            datatype: "json",
            height: $(window).height() -200,
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
            }
        });
    }
    /**
     * 页面和按钮初始化
     * */
    function ButtonPageInit(){
        if(source){
            $('#confirmShipment').hide();
            $('#saveShipment').show();
            $('#saveShipment').text("确认修改");
            $('#loadingShipyc').show();
            //$('#shipmentft').hide();
            $('#loadingShipment').hide();
            $('#saveDispatch').hide();
            $('#confirmDispatch').hide();
            $('#cancelconfirm').hide();

            //锁死派车单
            $("#form2").find('.form-control,.ui-select,input').attr('disabled', 'disabled');
            //添加异常框
            var html='    <tr id="abnormals"><th class="formTitle" >异常原因<font face="宋体">*</font></th><td class="formValue" colspan="7"><textarea id="abnormal" isvalid="yes"  checkexpession="NotNull" class="form-control" ></textarea></td></tr>'
            $("#descriptionss").after(html)

        }else{
            $('#saveShipment').hide();
            $('#confirmShipment').hide();
           // $('#shipmentft').hide();
            $('#loadingShipment').hide();
            $('#saveDispatch').hide();
            $('#confirmDispatch').hide();
            $('#cancelconfirm').hide();
            $('#loadingShipyc').hide();
            /* if(osType =='dispatch'){



             }*/
            if(osType =='shipment'){

                if( $("#status").val() == undefined || $("#status").val() == null || $("#status").val() == ""){ //如果运单是保存状态
                    $('#saveShipment').show();
                }
                if($("#status").val() == 1){
                    $('#confirmShipment').show();
                    $('#shipmentft').show();
                    $('#saveShipment').show();
                    $('#loadingShipment').show();
                    $('#TruckLoad2').show();
                }
                if($("#status").val() == 2){
                    $('#cancelconfirm').show();
                }
                //如果不是保存或未定义状态则锁死运单
                if(!($("#status").val() == undefined || $("#status").val() == null || $("#status").val() == ""||$("#status").val() == 1)){
                    $("#outDriver").attr('disabled',true);
                    $("#liense").attr('disabled',true);
                    $("#carrierName").attr('disabled',true);
                    $("#carrierNameSpan").removeAttr("onclick");
                    $("#vehicleHeadName").attr('disabled',true);
                    $("#driverName").attr('disabled',true);
                    $("#carriageName").attr('disabled',true);
                    $("#trailerName").attr('disabled',true);
                    $("#onclick1").removeAttr("onclick");
                    $("#onclick2").removeAttr("onclick");
                    $("#onclick3").removeAttr("onclick");
                    $("#onclick4").removeAttr("onclick");
                    $("#form1").find('.form-control,.ui-select,input').attr('disabled', 'disabled');
                }
                //锁死派车单
                //$("#form2").find('.form-control,.ui-select,input').attr('disabled', 'disabled');

            }
        }
    }



    /**
     * 加载货品明细
     */
    function ledInfoGirdFunction() {
        var selectedRowIndex = 0;
        var $gridTable1 = $('#gridTable2');
        $gridTable1.jqGrid({
            url: "/shipment/getStowage.action?id="+$('#id').val(),
            datatype: "json",
            height: $(window).height() - 200,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id',id:'a.id', hidden: true},
                {label: '分段订单号', name: 'code',type:'text',index:'a.code', width: 150, align: 'center'},
                // {label: '订单号', name: 'order.code',index:'order.code', width: 220, align: 'center'},
                {label: '客户订单号', name: 'relatebill1', index: 'a.relatebill1', width:75, align: 'center'},
                {label: '客户名称', name: 'customer.name',index: 'c.name', width: 150, align: 'center'},
                {label: '订单日期', name: 'time',index: 'a.time',type:'date', width:75, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '出发城市', name: 'fromCity',index:'sze.name', width: 60, align: 'center'},
                {label: '目的城市', name: 'toCity',index:'eze.name', width: 60, align: 'center'},
                {label: '收货人', name: 'shr',index:'shr', width: 60, align: 'center'},
                {label: '货名', name: 'huoming', width: 60, align: 'center',editable:true},
                {label: '总件数', name: 'number', width: 60, align: 'center',editable:true},
                {label: '总体积', name: 'volume', width: 60, align: 'center',editable:true},
                {label: '总重量', name: 'weight', width:60, align: 'center',editable:true},
                {label: '总货值', name: 'value', width: 60, align: 'center',editable:true},
                {label: '总费用', name: 'amount', width: 60, align: 'center',editable:true},
                {label: '状态', name: 'status', width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    }
                },
                {label: "备注", name: "description", width: 90, align: "center"},
                {label: '操作', name: 'code',type:'text',index:'a.code', width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                    if(rowObject[0] != null && rowObject[14] ==3){
                        if(!source){
                            return '<a onclick=\"btn_del(\'' + rowObject[0]+'\')\" class=\"label label-danger\" style=\"cursor: pointer;\">卸货</a>';
                        }else{
                            return ''
                        }

                    }else {
                        return ''
                    }
                    }},
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
                var amount =$(this).getCol("amount", false, "sum");
                //合计
                $(this).footerData("set", {
                    "code": "合计：",
                    "amount": amount.toFixed(2),
                    "number": number.toFixed(2),
                    "weight":  weight.toFixed(2),
                    "volume":  volume.toFixed(2),
                    "value":  value.toFixed(2),
                    // "amount": "总费用:" + amount.toFixed(2),
                    // "number": "数量:" + number.toFixed(2),
                    // "weight": "重量:" + weight.toFixed(2),
                    // "volume": "体积:" + volume.toFixed(2),
                    // "value": "货值:" + value.toFixed(2),
                    // "amount": "总费用:" + amount.toFixed(2),
                });
            },
        });
    }
    /**
     * 外包加载货品明细
     */
    function ledInfoGirdFunction1() {
        var selectedRowIndex = 0;
        var $gridTable1 = $('#gridTable7');
        $gridTable1.jqGrid({
            url: "/shipment/getWbStowage.action?id="+$('#id').val(),
            datatype: "json",
            height: $(window).height() - 400,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id',id:'a.id', hidden: true},
                {label: '分段订单号', name: 'code',type:'text',index:'a.code', width: 150, align: 'center'},
                {label: '客户订单号', name: 'relatebill1', index: 'a.relatebill1', width:75, align: 'center'},
                {label: '客户名称', name: 'customer.name',index: 'c.name', width: 150, align: 'center'},
                {label: '订单日期', name: 'time',index: 'a.time',type:'date', width:75, align: 'center',
                    formatter:function(cellvalue, options, row){
                        if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                            return "";
                        }
                        return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                    }},
                {label: '出发城市', name: 'fromCity',index:'sze.name', width: 60, align: 'center'},
                {label: '目的城市', name: 'toCity',index:'eze.name', width: 60, align: 'center'},
                {label: '收货人', name: 'shr',index:'shr', width: 60, align: 'center'},
                {label: '货名', name: 'huoming', width: 80, align: 'center'},
                {label: '总件数', name: 'number', width: 100, align: 'center'},
                {label: '总体积', name: 'volume', width: 100, align: 'center'},
                {label: '总重量', name: 'weight', width:100, align: 'center'},
                {label: '总货值', name: 'value', width: 100, align: 'center'},
                {label: '提货费', name: 'thAmount', width: 100, align: 'center',editable:true},
                {label: '干线运费', name: 'gxAmount', width: 100, align: 'center',editable:true},
                {label: '送货费', name: 'shAmount', width: 100, align: 'center',editable:true},
                {label: '其他费', name: 'qtAmount',index:'1',width: 100, align: 'center',editable:true},
                {label: '总成本', name: 'zcb',index:'1',width: 100, align: 'center'},
                {label: '总收入', name: 'amount',index:'amount', width: 100, align: 'center'},
                {label: '状态', name: 'status', width: 100, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.OrderStatus['' + cellvalue + '']
                    }
                },
                {label: "备注", name: "description", width: 90, align: "center"},
                {label: '操作', name: 'code',type:'text',index:'a.code', width: 80, align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        if(rowObject[0] != null && rowObject[18] ==3){
                            if(!source){
                                return '<a onclick=\"btn_del(\'' + rowObject[0]+'\')\" class=\"label label-danger\" style=\"cursor: pointer;\">卸货</a>';
                            }else{
                                return ''
                            }

                        }else {
                            return ''
                        }
                    }},
            ],
            pager: false,
            rownumbers: true,
            shrinkToFit: false,
            gridview: true,
            cellEdit:true,
            cellsubmit:"clientArray",
            multiselect: true,//复选框
            footerrow: true,
            afterSaveCell:function(rowid, cellname, value, iRow, iCol){

                //计算税率
                var rowData = $(this).getRowData(rowid)
                var thAmount = parseFloat(rowData.thAmount);
                var shAmount = parseFloat(rowData.shAmount);
                var gxAmount = parseFloat(rowData.gxAmount);
                var qtAmount = parseFloat(rowData.qtAmount);
                 zcb = thAmount+shAmount+gxAmount+qtAmount;
                var zcb =zcb.toFixed(2) ;
                rowData.zcb = zcb;
                $(this).setRowData(rowid,rowData);
                var xianjie =$("#xianjie").val();
                 $("#yuejie").val(zcb-xianjie);
                jisuanheji($(this))
                //计算合计

            },
            onSelectRow: function () {
                selectedRowIndex = $("#" + this.id).getGridParam('selrow');
            },
            gridComplete: function () {
                var number = $(this).getCol("number", false, "sum");
                var weight = $(this).getCol("weight", false, "sum");
                var volume = $(this).getCol("volume", false, "sum");
                var value = $(this).getCol("value", false, "sum");
                var amount =$(this).getCol("amount", false, "sum");
                var thAmount =$(this).getCol("thAmount", false, "sum");
                var gxAmount =$(this).getCol("gxAmount", false, "sum");
                var shAmount =$(this).getCol("shAmount", false, "sum");
                var qtAmount =$(this).getCol("qtAmount", false, "sum");
                var zcb =$(this).getCol("zcb", false, "sum");
                //合计
                $(this).footerData("set", {
                    "code": "合计：",
                    "number":  number.toFixed(2),
                    "weight": weight.toFixed(2),
                    "volume": volume.toFixed(2),
                    "value": value.toFixed(2),
                    "amount":  amount.toFixed(2),
                    "thAmount":  thAmount.toFixed(2),
                    "gxAmount":  gxAmount.toFixed(2),
                    "shAmount":  shAmount.toFixed(2),
                    "qtAmount": qtAmount.toFixed(2),
                    "zcb":  zcb.toFixed(2),
                    // "number": "数量:" + number.toFixed(2),
                    // "weight": "重量:" + weight.toFixed(2),
                    // "volume": "体积:" + volume.toFixed(2),
                    // "value": "货值:" + value.toFixed(2),
                    // "amount": "总费用:" + amount.toFixed(2),
                    // "thAmount": "总提货:" + thAmount.toFixed(2),
                    // "gxAmount": "总干线:" + gxAmount.toFixed(2),
                    // "shAmount": "总送货:" + shAmount.toFixed(2),
                    // "qtAmount": "总其他:" + qtAmount.toFixed(2),
                    // "zcb": "总其他:" + zcb.toFixed(2),
                });
            },
        });
    }
    /**
     * 费用合计
     */
    function jisuanheji(JGGIRD){
        var thAmount = JGGIRD.getCol("thAmount", false, "sum");
        var gxAmount = JGGIRD.getCol("gxAmount", false, "sum");
        var shAmount = JGGIRD.getCol("shAmount", false, "sum");
        var qtAmount = JGGIRD.getCol("qtAmount", false, "sum");
        var zcb = JGGIRD.getCol("zcb", false, "sum");
        //合计
        JGGIRD.footerData("set", {
            "feeType.name": "合计：",
            "thAmount": "提货:" + thAmount,
            "gxAmount": "干线:" + gxAmount,
            "shAmount":"送货:" + shAmount,
            "qtAmount":"其他:" + qtAmount,
            "zcb":"总额:" + zcb,

        });
        $("#zfy").val(zcb);
        $("#zthf").val(thAmount);
        $("#zgxyf").val(gxAmount);
        $("#zshf").val(shAmount);
        $("#zqtfy").val(qtAmount);
    }
    /**
     * 卸货
     */
    function btn_del(id){
        $.SetForm({
            url: "/shipment/delLed.action",
            param: {ledId:id, shipment: keyValue },
            success: function (data) {
                dialogMsg("移除配载成功", 1);
                $("#gridTable2").trigger("reloadGrid");
                $("#gridTable7").trigger("reloadGrid");
            }
        });
    }
    /**
     * 取消运单确认
     */
    function cancelShipment(){
        return false;//取消确认功能写的不对，暂时关闭，等待修改
        $.removeFromMessage($("#form1"));
        if ($('#status').val()!=2) {
            dialogAlert('运单数据没有确认，不能取消确认', -1);
            return
        }
        $.SetForm({
            url: "/shipment/cancelShipment.action",
            param: {id: $('#id').val() },
            success: function (data) {
                if (data.type == "validator") {
                    $('#form1').ValidformResule(data.obj);//后台验证数据
                } else if (data.type) {
                    $.currentIframe().$("#gridTable").trigger("reloadGrid");
                    $('#id').val(data.obj.id);
                    $('#status').val(data.obj.status);
                    //修改和隐藏
                    dialogMsg("取消确认成功", 1);
                    ButtonPageInit()

                } else {
                    dialogAlert(data.obj, -1);
                }
            }
        });
    }

    /**
     *确认运单单据
     */
    function confirmShipment(){
        $.removeFromMessage($("#form1"));

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
                    dialogMsg("确认成功", 1);
                    ButtonPageInit()

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
                $("#gridTable7").trigger("reloadGrid");
                $("#gridTableAddress").trigger("reloadGrid");
                return true;
            }
        });
    }
    function saveLedInfoyc() {
        if (!$('#id').val()) {
            dialogAlert('运单数据没有保存，不能添加明细', -1);
            return
        }
        var status =$('#status').val();
        if(status !=4 && status !=5){
            dialogAlert('异常配载只能装卸发运和运抵的单据', -1);
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
            content: top.contentPath + 'jsp/Shipment/YCloadingForm.jsp?keyValue=' + $('#id').val(),
            cancel: function () {
                $("#gridTable2").trigger("reloadGrid");
                $("#gridTable7").trigger("reloadGrid");
                $("#gridTableAddress").trigger("reloadGrid");
                return true;
            }
        });
    }
    /**
     * 承运商选择*/
    function selectCarrier(){
        dialogOpen({
            id: "CarrierFrom",
            title: '承运商选择',
            url: 'jsp/Carrier/CarrierIndex.jsp?status=1',
            width: "1050px",
            height: "450px",
            callBack: function (iframeId) {

                var resule = top.frames[iframeId].getCarrier();
                 $("#ruleName").val(resule["rule.code"])
                top.frames[iframeId].dialogClose();//关闭窗口
                $("#carrier").val(resule.id)
                $("#carrierName").val(resule.name)
                for(var i in top.clientdataItem.CarrierType){
                    if(top.clientdataItem.CarrierType[i] ==resule.carrierType){
                        $("#carrierType").ComboBoxSetValue(i);
                    }

                }
                //changeLiense();
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
                        /*oilPrepaid:leddetail.oilPrepaid,
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
     * 线路选择
     */
    function selectLine(){
        dialogOpen({
            id: "LineFrom",
            title: '线路选择',
            url: 'jsp/Line/LineIndex.jsp?status=1',
            width: "1050px",
            height: "450px",
            callBack: function (iframeId) {
                var resule = top.frames[iframeId].getLine();
                top.frames[iframeId].dialogClose();//关闭窗口
                $("#line").val(resule.id)
                $("#lineName").val(resule.name)
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
                 $("#vehicleHead").val(resule.id);
                 $("#vehicleHeadName").val(resule.code);
                 $("#driverName").val(resule.driver);
                 $("#driverTel").val(resule.iphone);
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
    /**
    * 台账明细
    */
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
                { label: "应付金额", name: "amount",  index: "amount", resizable:false, width: 80, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "税率", name: "taxRate",  width: 50,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.TaxRate}},
                { label: "税金", name: "input", index: "input",resizable:false,  width: 70, align: "center"},
                { label: "成本", name: "outcome", index: "outcome",resizable:false,  width: 80, align: "center"},
                { label: "结算方式", name: "settlementMethod",  width: 80,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.SettlementMethod}},
                { label: "支付方式", name: "payMethod",  width: 100,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.PayMethod}},
               /* { label: "预付油卡", name: "oilPrepaid",  index: "target", resizable:false, width: 60, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "预付现金", name: "cashAdvances",  index: "target", resizable:false, width: 60, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},*/
               /* { label: "现结", name: "nowPay",  index: "target", resizable:false, width: 60, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "回付", name: "backPay",  index: "target", resizable:false, width: 60, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                { label: "月结", name: "monthPay",  index: "target", resizable:false, width: 60, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},*/
                { label: "备注", name: "description", resizable:false, index: "description", width: 80,edittype: "text", align: "center" ,editable:true },
                { label: '<button type="button" onclick="addJgGirdNullData2()" class="btn btn-success btn-xs">添加费用</button>',   sortable: false, width: 80, align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        if(source ){
                            return '不可删除修改费用'
                        }
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
                    "amount":  "金额:" + number,
                    "input":  "税金:" +input,
                    "outcome":"成本:" +  outcome,
                   /* "oilPrepaid":oilPrepaid,
                    "cashAdvances": cashAdvances,*/
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
       /* var oilPrepaid = JGGIRD.getCol("oilPrepaid", false, "sum");
        var cashAdvances = JGGIRD.getCol("cashAdvances", false, "sum");*/
        //合计
        JGGIRD.footerData("set", {
            "feeType.name": "合计：",
            "amount": "金额:" + amount,
            "input": "税金:" + input,
            "outcome": "成本:" + outcome,
            /*"oilPrepaid":"油卡:" + oilPrepaid,
            "cashAdvances":"现金:" + cashAdvances,*/
        });
    }

    function deleteJgGirdNullData2 (data){
        var $JGGRID = $("#gridTable5");
        data.parent().parent().remove();
        feeTypeTotal($JGGRID);
        $JGGRID.setGridHeight("auto");
    }
    function deleteJgGirdNullData3 (data){
        var $JGGRID = $("#gridTable9");
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
    function addJgGirdNullData3(){
        var model={
            id:null,
            name:null,
            number:0,
            weight:0,
            volume:0,
            value:0,
            description:null,
        }
        var $JGGRID = $("#gridTable9")
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
            }
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

    //根据作业模式显示内部或外部车辆信息
//    function showInOrOut(){
//        var value = $("#operationPattern").attr('data-value');
//
//        if(value == 0){
//        //    $("#carrierName").removeAttr('readonly');
//            $("#carrierName").removeAttr('readonly');
//            $("#carrierName").attr('disabled',"disabled");
//            $("#carrierNameSpan").removeAttr("onclick");
//            $("#operationPatternInside").show();
//            $("#operationPatternInside2").show();
//            $("#operationPatternOut").hide();
////            $('#carrierName').html("");
////            $('#carrierNameSpan').html("");
////            $('#carrierType').html("");
////            $("#carrierName").empty();
////            $("#carrierNameSpan").empty();
//
//        }else{
//            $("#carrierName").removeAttr('disabled');
//            $("#carrierName").attr('readonly',"readonly");
//            $("#carrierNameSpan").attr("onclick","selectCarrier()");
//            $("#operationPatternOut").show();
//            $("#operationPatternInside").hide();
//            $("#operationPatternInside2").hide();
//
//        }
//    }



    /**
        * 选择运点
         * */

    function TruckLoad(){
        var selectedRowIndex = 0;
        var $gridTable1 = $('#gridTable4');
        $gridTable1.jqGrid({
            url: "/shipment/getStowage.action?id="+$('#id').val(),
            datatype: "json",
            height: $(window).height() - 200,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '订单号', name: 'code', width: 220, align: 'center'},
                {label: '订单日期', name: 'time', width: 150, align: 'center'},
                {label: '总件数', name: 'number', width: 80, align: 'center'},
                {label: '总体积', name: 'volume', width: 80, align: 'center'},
                {label: '总重量', name: 'weight', width: 80, align: 'center'},
                {label: '货损原因', name: 'customer.name', width: 130, align: 'center'},
                {label: '装卸人', name: 'order.code', width: 220, align: 'center'},
                {label: '装卸时间', name: 'relatebill1', width: 150, align: 'center'},
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
            }
        });
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
        $.ajax({
            url: "/shipment/getOrgww.action",
            data:{"aaa":ww},
            async:false,
            type: "post",
            dataType: "json",
            success: function (data) {
                orgtoList = data;
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
    function feiyongfentan(){
        var ids = $('#gridTable7').jqGrid("getRowData");
        var xianjie = $("#xianjie").val();
        var huifu = $("#huifu").val();
        var yuejie = $("#yuejie").val();
        var description1 =$("#description1").val();
        var postData={
            xianjie:xianjie,
            huifu:huifu,
            yuejie:yuejie,
            shipid:keyValue,
            description1:description1
        }
        var fyjh = new Array(); //费用集合
        for(i = 0;i<ids.length;i++){
            var leddd = ids[i];
            var jihe = {
                ledid:leddd.id,
                thAmount:leddd.thAmount,
                shAmount:leddd.shAmount,
                gxAmount:leddd.gxAmount,
                qtAmount:leddd.qtAmount,
                zcb:leddd.zcb
            }
            fyjh.push(jihe)
        }
        postData['fyjh'] = fyjh;
        var params = {str:JSON.stringify(postData)};
        var url ="shipment/saveFY.action";
        $.SaveForm({
            url: url,
            param:params ,
            loading: "正在保存数据...",
            success: function (data) {
                if (data.type == "validator") {
                    $('#form1').ValidformResule(data.obj);//后台验证数据
                } else if (data.result) {
                    $.currentIframe().$("#gridTable").trigger("reloadGrid");
                    dialogMsg("保存成功", 1);
                    if(source){
                        dialogClose();//关闭窗口
                    }
                } else {
                    dialogAlert(data.obj, -1);
                }
            }
        })
    }
    function  jisuanye() {
       var zfy = $("#zfy").val();
       var xianfu = $("#xianjie").val();
       var yue = zfy-xianfu;
       $("#yue").val(yue);
       $("#yuejie").val(yue);

    }
    /**
     *计算规则
     */
    function ruleRun(){
        if(!$("#ruleName").val()){
            alert("没有规则，不能计算")
            return
        }
        var order = {
            id:$("#id").val(),
            code:$("#code").val(),
            status:$("#status").val(),
            time:$("#time").val(),
            tan:$("#tan").val(),
            operationPattern:$("#operationPattern").attr('data-value'),
            carrierName:$("#carrierName").val(),
            carrierType:$("#carrierType").attr('data-value'),
            backNumber:$("#backNumber").val(),
            shipmentMethod:$("#shipmentMethod").attr('data-value'),
            planLeaveTime:$("#planLeaveTime").val(),
            requireArriveTime:$("#requireArriveTime").val(),
            feeType:$("#feeType").attr('data-value'),
            factLeaveTime:$("#factLeaveTime").val(),
            factArriveTime:$("#factArriveTime").val(),
            liense:$("#vehicleHeadName").val(),
            outDriver:$("#driverName").val().trim(),
            outIphpne:$("#driverTel").val().trim(),
            description:$("description").val(),
        }
        var orderData = JSON.stringify(order);
        console.log(orderData);
        $.SaveForm({
            loading: "正在计算数据...",
            url: "/rule/runRule.action",
            param: {code: $("#ruleName").val(),obj:orderData},
            success: function (data) {
                if(data.result){
                    var $JGGRID = $("#gridTable5");
                    $JGGRID.jqGrid("clearGridData"); //清空数据
                    for (var i = 0; i <data.obj.length ; i++) {
                        var model={
                            carrier:{
                                id:$("#carrier").val(),
                                name:$("#carrierName").val(),
                            },
                            feeType:{
                                id:data.obj[i][0],
                                name:data.obj[i][1],
                            },
                            amount:data.obj[i][2],
                            taxRate:data.obj[i][3], //默认税率
                            input:data.obj[i][4],
                            income:data.obj[i][5],
                            description:null,
                        }
                        console.log(model)
                        $JGGRID.addRowData(getUUID(),model,"first")
                    }
                    $JGGRID.setGridHeight("auto")
                    console.log(data.obj)
                    console.log(feeTypeData)
                    alert("计算成功")
                }else {
                    alert(data.obj)
                }
            }
        })
    }
</script>
<div class="ui-layout" id="layout" style="height: 100%; width: 100%;">
    <div class="ui-layout-west">
        <div class="west-Panel">
            <div class="profile-nav">
                <ul style="padding-top: 20px;">
                    <li id="ShipmentInfoLI" class="active" onclick="profileSwitch('ShipmentInfo')">运单信息</li>
                    <li onclick="profileSwitch('LoadingManager')">配载管理</li>
                    <li onclick="profileSwitch('addressInfo')">地址时效</li>
                    <li onclick="profileSwitch('ShipmentTrackFrom')">运单在途</li>
                    <li id="TruckLoad" onclick="profileSwitch('TruckLoad')">装车报告</li>
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
                            <tr>
                                <td class="formTitle">运单号</td>
                                <td class="formValue">
                                    <input id="code" disabled = "disabled" autocomplete="off"  type="text" class="form-control" placeholder="系统自动生成" />
                                </td>
                                <th class="formTitle">运单日期<font face="宋体">*</font></th>
                                <td class="formValue">
                                    <input id="time" type="text"  autocomplete="off" placeholder="请选择运单时间"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                                </td>
                                <th class="formTitle">运输协议号</th>
                                <td class="formValue">
                                    <input id="tan"  type="text" autocomplete="off" class="form-control" maxlength="50"/>
                                </td>
                            </tr>
                            <tr>
                                <th class="formTitle">运作模式<font face="宋体">*</font></th>
                                <td class="formValue">
                                    <div id="operationPattern"  type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                                    </div>
                                </td>
                                <th class="formTitle">承运商</th>
                                <td class="formValue">
                                    <input id="carrier" name="carrier.id" autocomplete="off" type="hidden" value=""/>
                                    <input id="carrierName"  autocomplete="off" onclick="selectCarrier()"   type="text"  class="form-control" />
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
                                    <input id="vehicle" autocomplete="off" name="vehicle.id" type="hidden" value=""/>
                                    <input id="vehicleName"  autocomplete="off" onclick="selectVehicle($(this));" placeholder="指定派车单车型"  isvalid="yes" readonly  checkexpession="NotNull" type="text" class="form-control"/>
                                    <span class="input-button" ForderBy = "1" onclick="selectVehicle($(this))" title="请选择车型" >.......</span>
                                </td>
                                <th class="formTitle">回单份数</th>
                                <td class="formValue">
                                    <input id="backNumber" autocomplete="off" value="0" disabled = "disabled" type="text" class="form-control"/>
                                </td>
                            </tr>
                            <tr>
                                <th class="formTitle">运输方式</th>
                                <td class="formValue">
                                    <div id="shipmentMethod" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                                        <ul>
                                        </ul>
                                    </div>
                                </td>
                                <th class="formTitle">要求发车日期</th>
                                <td class="formValue">
                                    <input id="planLeaveTime" autocomplete="off" type="text"  placeholder="请选择要求发车日期"   readonly="readonly"  class="form-control input-wdatepicker"   onfocus="WdatePicker()"/>
                                </td>
                                <th class="formTitle">要求到车日期</th>
                                <td class="formValue">
                                    <input id="requireArriveTime" autocomplete="off" type="text"  placeholder="请选择要求到车日期"   readonly="readonly"  class="form-control input-wdatepicker"   onfocus="WdatePicker()"/>
                                </td>
                            </tr>
                            <tr>
                                <th class="formTitle">付款方式</th>
                                <td class="formValue">
                                    <div id="feeType" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull"><ul> </ul> </div>
                                </td>
                                <th class="formTitle">实际发车日期</th>
                                <td class="formValue">
                                    <input id="factLeaveTime" autocomplete="off" type="text"  disabled = "disabled"  class="form-control"/>
                                </td>
                                <th class="formTitle">实际到车日期</th>
                                <td class="formValue">
                                    <input id="factArriveTime" autocomplete="off" type="text" disabled = "disabled"    class="form-control" />
                                </td>
                            </tr>
                            <%--</tr>&ndash;%&gt;--%>
                            <tr>
                                <td hidden>
                                    <input id="liense" hidden autocomplete="off"  type="text" class="form-control" />
                                    <input id="outDriver" hidden autocomplete="off"  type="text" class="form-control" />
                                    <input id="outIphpne" hidden autocomplete="off"  type="text" class="form-control" />
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
                            <td colspan="8"><hr style="margin:3px;height:3px;border:none;border-top:1px double #008080"  /></td>
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
                            <td colspan="8">
                                <hr style="margin:3px;height:3px;border:none;border-top:1px double #008080"  /></td>
                            <tr id="descriptionss">
                                <th class="formTitle">备注</th>
                                <td class="formValue">
                                    <textarea id="description" type="text"  style="width: 470px;" class="form-control"></textarea>
                                </td>
                                <th class="formTitle"></th>
                                <td class="formValue">
                                </td>
                                <td   class="formTitle"><a style="padding-top: 5px" id="ossrder_sava" class="btn btn-success" onclick="ruleRun()">计算规则</a></td>
                                <td class="formValue">
                                    <input id="ruleName"  readonly autocomplete="off" type="text"  class="form-control" />

                                </td>
                                <td class="formValue">

                                </td>
                            </tr>

                            <td>
                                <hr style="color: #0a2b1d" width="900px">
                            </td>
                            <tr >
                                <td class="formValue" colspan="6">
                                    <div class="gridPanel">
                                        <table id="gridTable5"></table>
                                    </div>
                                </td>
                            </tr>
                        <div id="bottomField" class="shipmentmanage">
                            <a id="saveShipment" class="btn btn-success" onclick="saveShipment()">保存单据</a>
                            <a id="confirmShipment" class="btn btn-warning" onclick="confirmShipment();">确认单据</a>
                            <a id="cancelconfirm" class="btn btn-warning" onclick="cancelShipment();">取消确认单据</a>
                            <a id="printShipment" class="btn btn-default" onclick="AcceptClick(2)">打印单据</a>
                            <script>$('.shipmentmanage').authorizeButton()</script>
                        </div>
                        </table>
                    </form>
                </div>
                <%--车辆配载--%>
                <div id="LoadingManager" class="flag" style="display: none;">
                    <div class="title">
                        配载信息
                    </div>
                    <div class="bills">
                    <form id="form2">
                        <table class="form" style="margin-top: 20px;">
                            <tr >
                                <td class="formValue" colspan="10">
                                    <div class="gridPanel">
                                        <table id="gridTable2"></table>
                                        <table id="gridTable7"></table>
                                    </div>
                                </td>
                            </tr>
                            <tr id ="ceshi">
                                <td class="formTitle">总费用</td>
                                <td class="formValue">
                                    <input id="zfy" disabled = "disabled" onchange="jisuanye()" autocomplete="off"  type="text" class="form-control"  />
                                </td>
                                <th class="formTitle">总提货费</th>
                                <td class="formValue">
                                    <input id="zthf" type="text"  autocomplete="off"   disabled="disabled"  class="form-control" />
                                </td>
                                <th class="formTitle">总干线运费</th>
                                <td class="formValue">
                                    <input id="zgxyf"  type="text" autocomplete="off" disabled="disabled"  class="form-control" maxlength="50"/>
                                </td>
                                <th class="formTitle">总送货费</th>
                                <td class="formValue">
                                    <input id="zshf"  type="text" autocomplete="off" disabled="disabled"  class="form-control" maxlength="50"/>
                                </td>
                                <th class="formTitle">总其他费用</th>
                                <td class="formValue">
                                    <input id="zqtfy"  type="text" autocomplete="off" disabled="disabled"  class="form-control" maxlength="50"/>
                                </td>
                            </tr>
                            <tr id ="ceshi1">
                                <td class="formTitle">余额</td>
                                <td class="formValue">
                                    <input id="yue" disabled = "disabled" autocomplete="off"  type="text" class="form-control" />
                                </td>
                                <th class="formTitle">现结</th>
                                <td class="formValue">
                                    <input id="xianjie"  type="text" onchange="jisuanye()" autocomplete="off" class="form-control" maxlength="50"/>
                                </td>
                                <th class="formTitle">回付</th>
                                <td class="formValue">
                                    <input id="huifu"  type="text" autocomplete="off" class="form-control" maxlength="50"/>
                                </td>
                                <th class="formTitle">月结</th>
                                <td class="formValue">
                                    <input id="yuejie"  type="text" autocomplete="off" class="form-control" maxlength="50"/>
                                </td>
                            </tr>
                            <tr id="descriptionss1">
                                <th class="formTitle">备注</th>
                                <td class="formValue">
                                    <textarea id="description1" type="text" style="width: 700px;" class="form-control"></textarea>
                                </td>
                            </tr>
                            <td>
                                <hr style="color: #0a2b1d" width="900px">
                            </td>

                            <div id="bottomField1" class="shipmentmanage">
                                <a id="saveShipment1" class="btn btn-success" onclick="saveShipment()">保存单据</a>
                                <script>$('.shipmentmanage').authorizeButton()</script>
                            </div>
                        </table>
                        <div id="bottomField4" class="loadingmanage">
                            <a id="shipmentft" class="btn btn-default" onclick="feiyongfentan()">保存</a>
                            <a id="loadingShipment" class="btn btn-default" onclick="saveLedInfo()">配载</a>
                            <a id="loadingShipyc" class="btn btn-default" onclick="saveLedInfoyc()">异常配载</a>
                            <script>$('.loadingmanage').authorizeButton()</script>
                        </div>
                    </form>
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
                <!--在途跟踪 -->
                <div id="ShipmentTrackFrom" class="flag" style="display: none;">
                    <div class="title">
                        在途跟踪
                    </div>
                    <table class="form" style="margin-top: 20px;">
                        <tr>
                            <td class="formValue">
                                <textarea id="ShipmentTrack" type="text" style="width: 850px;height: 400px"  disabled="disabled"  class="form-control"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
                <!-- 装车报告 -->
                    <div id="TruckLoad3" class="flag" style="display: none;">
                        <div class="title">
                            装车报告
                        </div>
                        <div class="bills">
                            <div class="gridPanel">
                                <table id="gridTable4"></table>
                            </div>
                        </div>
                        <div id="TruckLoad1" class="loadingmanage">
                            <a id="TruckLoad2" class="btn btn-default" onclick="saveLedInfo()">保存</a>
                            <script>$('.loadingmanage').authorizeButton()</script>
                        </div>
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