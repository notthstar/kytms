<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/6
  Time: 9:27
  预录表单
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
    <title>预录表单</title>
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
    <%--下拉框插件--%>
    <script src="/Content/scripts/utils/tAutocomplete-master/tautocomplete.js"></script>
    <link href="/Content/scripts/utils/tAutocomplete-master/tautocomplete.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-report.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-bill.css" rel="stylesheet"/>
    <%--高德导航--%>
    <link href="/Content/styles/jet-gd.css" rel="stylesheet"/>
    <%--<script src="/Content/scripts/utils/jet-gdutil.js?v=1.3&key=49df3dbb93cc593e8cceedfe8f8be185"></script>--%>
    <script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.10&key=49df3dbb93cc593e8cceedfe8f8be185"></script>
    <script src="/Content/scripts/utils/jet-gd.js"></script>
</head>
<body>

<form id="form1">

    <script>
        var feeTypeData;//费用变量存储
        var keyValue = request('keyValue');
        var source = request('source'); //如果是异常单
        $(function () {
            initControl();
            changeCostomerType();
        })
        //初始化控件
        function initControl() {
            getFeeType();//初始化费用类型
            $("#costomerType").ComboBox({ //客户类型
                description: "=请选择客户类型=",
                height: "200px",
                data: top.clientdataItem.CustomerType
            });
            $("#handoverType").ComboBox({ //交付方式
                description: "=请选择交付方式=",
                height: "200px",
                data: top.clientdataItem.HandoverType
            });
            $("#feeType").ComboBox({ //结算方式
                description: "=请选择结算方式=",
                height: "200px",
                data: top.clientdataItem.Clearing
            });
            $("#taxRate").ComboRadio({ //税率
                data: top.clientdataItem.TaxRate,
                defaultVaue: '0.10'
            });

//            $("#serverZone").ComboBoxTree({ //提货区域
//                url: "/serverZone/getServerZoneTree.action",
//                description: "==请选择==",
//                height: "200px",
//                allowSearch:true
//            });
            getMapDataFroIdAddress("FH_address", "FH_ltl","FH_detailedAddress");
            getMapDataFroIdAddress("SH_address", "SH_ltl","SH_detailedAddress");

            //获取表单
           // initComplete(); //初始化下拉插件
            if (!!keyValue) {
                getPresco();
            }else {
                GetGrid(); //初始化货品明细
                GetGrid2();//初始化费用
               // initFeeType() //初始化费用
//                showDate("dateAccepted"); //初始化时间
//                $("#feeType").ComboBoxSetValue(1);
               $("#costomerType").ComboBoxSetValue(1);
                //$("#taxRate").ComboBoxSetValue('0.11');
                addJgGirdNullData();
                buttonStatus() //初始化按钮
            }
            showDate("dateAccepted");
        }
        //获取费用类型
        function getFeeType(){
            $.ajax({
                url: "/feetype/getFeeType.action",
                data: {id:"1.1"},
                async:false,
                type: "post",
                dataType: "json",
                success: function (data) {
                    feeTypeData =data;
                },
            });
        }
        function getlal(address,self) { //发货
            var s = getFHNClnl(address,self);
            if (s) {
                return;
            }
        }
        function Sgetlal(address,self) { //s收货
            var s = getSHNClnl(address,self);
            if (s) {
                return;
            }
        }
        /**编辑初始化*/
        function getPresco(){
            $.SetForm({
                url: "/presco/getPresco.action",
                param: {id: keyValue},
                success: function (data) {
                        $("#id").val(data.id), //处理单头
                        $("#code").val(data.code),
                        $("#status").val(data.status),
                        $("#relatebill1").val(data.relatebill1),
                        $("#pickMileage").val(data.pickMileage),
                        $("#dateAccepted").val(data.dateAccepted),
                        $("#feeType").ComboBoxSetValue(data.feeType),
                        $("#costomerType").ComboBoxSetValue(data.costomerType);
                        if(data.customer != null){
                        $("#costomer").val(data.customer.id);
                        $("#costomerName").val(data.customer.name)
                         }else{
                            $("#costomerNameLs").val(data.fH_name)
                        };
                        if(data.serverZone != null){
                            $("#serverZone").val(data.serverZone.id);
                            $("#serverZoneName").val(data.serverZone.zone.name);
                        }
                        $("#FH_name").val(data.fH_name);
                        $("#FH_person").val(data.fH_person);
                        $("#FH_iphone").val(data.fH_iphone);
                        $("#FH_address").val(data.fH_address);
                        $("#FH_ltl").val(data.fH_ltl);
                        $("#FH_detailedAddress").val(data.fH_detailedAddress);
                        $("#SH_name").val(data.sH_name);
                        $("#SH_person").val(data.sH_person);
                        $("#SH_iphone").val(data.sH_iphone);
                        $("#SH_address").val(data.sH_address);
                        $("#SH_ltl").val(data.sH_ltl);
                        $("#SH_detailedAddress").val(data.sH_detailedAddress);
                        $("#description").val(data.description);


                    //处理货品信息
                    GetGrid(); //初始化货品明细
                    var $JGGRID = $("#gridTable");
                    $JGGRID.jqGrid("clearGridData"); //清空数据
                    $JGGRID.setGridHeight(22)
                    if(data.prescoProducts != null){
                      // for(i=0;i<data.prescoProducts.length;i++){
                            //$JGGRID.setGridHeight($JGGRID.getGridParam("height") + 33 * data.prescoProducts.length)
                            $JGGRID.addRowData(getUUID(),data.prescoProducts,"first");
                        $JGGRID.setGridHeight("auto");
                       // }
                    }
                    //处理台账
                    GetGrid2();//初始化费用
                    var $JGGRID = $("#gridTable2");
                    $JGGRID.jqGrid("clearGridData"); //清空数据
                    $JGGRID.setGridHeight(55)
                    if(data.ledgerDetail != null){
                            $JGGRID.addRowData(getUUID(),data.ledgerDetail,"first");
                        $JGGRID.setGridHeight("auto");
                    }


                }
            });
            buttonStatus()//按钮初始化
            orderLock() //编辑锁死
        }



        /**
         * 添加货品明细空数据
         */

        function addJgGirdNullData (){
            var model={
                id:null,
                name:null,
                number:1,
                weight:0,
                volume:0,
                value:0,
                jzWeight:0,
                description:null,

            }
            var $JGGRID = $("#gridTable")
//            $JGGRID.jqGrid("addRowData",null,"first");
            $JGGRID.addRowData(getUUID(),model,"first");
            $JGGRID.setGridHeight("auto");
        }
        function addJgGirdNullData2 (){
            var model={
                id:null,
                name:null,
                taxRate:0.09, //默认税率
                description:null,

            }
            var $JGGRID = $("#gridTable2")
//            $JGGRID.jqGrid("addRowData",null,"first");
            $JGGRID.addRowData(getUUID(),model,"first");
            $JGGRID.setGridHeight("auto");
        }
        /**
         * 删除货品明细空数据
         */
        function deleteJgGirdNullData (data){
            var $JGGRID = $("#gridTable");
            data.parent().parent().remove();
            $JGGRID.setGridHeight("auto");
            productTotal($JGGRID);
        }
        function deleteJgGirdNullData2 (data){
            var $JGGRID = $("#gridTable2");
            data.parent().parent().remove();
            feeTypeTotal($JGGRID);
            $JGGRID.setGridHeight("auto");
        }
        /**
         * 费用合计
         */
        function feeTypeTotal(JGGRID){
            var amount = JGGRID .getCol("amount", false, "sum");
            var input = JGGRID .getCol("input", false, "sum");
            var income = JGGRID .getCol("income", false, "sum");
            //合计
            JGGRID .footerData("set", {
                "feeType.name": "合计：",
                "amount": "应收金额:" + amount,
                "input": "税率:" + input,
                "income": "收入:" + Math.round(income,4)
            });
        }
        //保存计划单
        function AcceptClick() {
            $.removeFromMessage($('#form1'))
            if (!$('#form1').Validform()) {
                return false;
            }
            var presco ={ //处理单头信息
                id:$("#id").val(),
                code:$("#code").val(),
                status:$("#status").val(),
                relatebill1:$("#relatebill1").val(),
                pickMileage:$("#pickMileage").val(),
                dateAccepted:$("#dateAccepted").val(),
                feeType:$("#feeType").attr('data-value'),
                costomerType:$("#costomerType").attr('data-value'),
                customer:{id :$("#costomer").val()}, //合同客户
                costomerNameLs:$("#FH_name").val(),
                serverZone:{id:$("#serverZone").val()},
                FH_name:$("#FH_name").val(),
                FH_person:$("#FH_person").val(),
                FH_iphone:$("#FH_iphone").val(),
                FH_address:$("#FH_address").val(),
                FH_ltl:$("#FH_ltl").val(),
                FH_detailedAddress:$("#FH_detailedAddress").val(),
                SH_name:$("#SH_name").val(),
                SH_person:$("#SH_person").val(),
                SH_iphone:$("#SH_iphone").val(),
                SH_address:$("#SH_address").val(),
                SH_ltl:$("#SH_ltl").val(),
                SH_detailedAddress:$("#SH_detailedAddress").val(),
            }
            //备注如果为空，不赋值
//            if($("#description").val()!=null && $("#description").val()!=""){
//                presco['description']=$("#description").val();
//            }

            //处理货品明细
            var jggirdData = $('#gridTable').jqGrid("getRowData");
            var PrescoProducts = new Array(); //货品信息
            //处理费用类型
            for(i=0;i<jggirdData.length;i++){
                var pps = jggirdData[i]
                var prescoProducts={
                    id:pps.id,
                    name:pps.name,
                    unit:pps.unit,
                    number:pps.number,
                    weight:pps.weight,
                    volume:pps.volume,
                    value:pps.value,
                    jzWeight:pps.jzWeight,
                    description:pps.description
                }
                    PrescoProducts.push(prescoProducts)
            }
            if(PrescoProducts.length>0){
                presco['prescoProducts'] = PrescoProducts;
            }else{

            }

            var jggirdData2 = $('#gridTable2').jqGrid("getRowData");
            var LedgerDetails = new Array(); //台账
            var countAmount =0;
            var countInput = 0;
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
                        id:feeTypeId
                    },
                    amount:leddetail.amount,
                    taxRate:leddetail.taxRate,
                    input:leddetail.input,
                    income:leddetail.income
                }
                LedgerDetails.push(LedgerDetail)
            }
            presco['ledgerDetail'] = LedgerDetails
            var prescoData = {presco:JSON.stringify(presco)};
            var url = "/presco/savePresco.action"
//            if($('#order_sava').text() == "确认修改"){ //异常提交地址
//                url =  "/transportorder/saveAbnormalOrder.action";
//                orderData["text"]= $("#abnormal").val()
//            }
            $.SaveForm({
                url: url,
                param:prescoData,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    } else if (data.type) {
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                    if(data.result){
                        dialogClose();//关闭窗口
                    }else{
                        dialogAlert(data.obj, -1);
                    }
                    } else {
                     //   dialogAlert(data.obj, -1);
                    }
                }
            })
        }
        function GetGrid2() {
            function isInteger(obj) {
                reg =/^[-\+]?\d+(\.\d+)?$/;
                if (!reg.test(obj)) {
                    return false;
                } else {
                    return true;
                }
            }
            var selectedRowIndex = 0;
            var $gridTable = $('#gridTable2');
            var numberValidator = function(val, nm){
                var boolean = isInteger(val)
                if(boolean){
                    return [true,parseFloat(val)];
                }
                return  [false,"请输入正确数字"];
            }
            $gridTable.jqGrid({
//                url: "",
                datatype: "json",
                height: 45,
                autowidth: false,
                width:1100,
                cellEdit:true,
                cellsubmit:"clientArray",
                colModel: [
                    { label: "主键", name: "id", index: "id", hidden: true },
                    { label: "主键", name: "feeType.id", index: "id", hidden: true },
                    { label: "费用名称", name: "feeType.name",  width: 200,resizable:false,editable:true,edittype:'select', align: "center",editoptions: {value: feeTypeData}},
                    { label: "税率", name: "taxRate",  width: 100,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.TaxRate}},
                    { label: "应收金额", name: "amount",  index: "target", resizable:false, width: 130, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "税金", name: "input", index: "url",resizable:false,  width: 130, align: "center"},
                    { label: "收入", name: "income",  index: "target", resizable:false, width: 130, align: "center",edittype: "text" ,editable:true},
                    { label: "备注信息", name: "description", resizable:false, index: "description", width: 150,edittype: "text", align: "center" ,editable:true },
                    { label: '<button type="button" onclick="addJgGirdNullData2()" class="btn btn-success btn-xs">添加费用</button>',   sortable: false, width: 40, align: "center",
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
                    rowData.income = rowData.amount - rowData.input
                    $(this).setRowData(rowid,rowData)

                    //计算合计
                    feeTypeTotal($(this))

                },
                gridComplete: function () {
                    var number = $(this).getCol("amount", false, "sum");
                    var weight = $(this).getCol("input", false, "sum");
                    var income = $(this).getCol("income", false, "sum");
                    //合计
                    $(this).footerData("set", {
                        "feeType.name": "合计：",
                        "amount": "应收金额:" + number,
                        "input": "税金 :" + weight,
                        "income": "收入 :" + income
                    });
                },
            });
        }

        function GetGrid() {
            function isInteger(obj) {
                reg =/^[-\+]?\d+(\.\d+)?$/;
                if (!reg.test(obj)) {
                    return false;
                } else {
                    return true;
                }
            }
            var selectedRowIndex = 0;
            var $gridTable = $('#gridTable');
            var numberValidator = function(val, nm){
                var boolean = isInteger(val)
                if(boolean){
                    return [true,parseFloat(val)];
                }
                return  [false,"请输入正确数字"];
            }
            $gridTable.jqGrid({
//                url: "",
                datatype: "json",
                height: 25,
                autowidth: false,
                width:1100,
                cellEdit:true,
                cellsubmit:"clientArray",
                colModel: [
                    { label: "主键", name: "id", index: "id", hidden: true },
                    { label: "品名", name: "name",  width: 200,resizable:false, align: "center",editable:true,isvalid:"yes",checkexpession:"NotNull"},
                    { label: "包装", name: "unit", width: 100,resizable:false,editable:true,edittype:'select', align: "center",editoptions: {value: top.clientdataItem.Baozhuang}},
                    { label: "数量", name: "number",  index: "target", resizable:false, width: 100, align: "center",edittype: "text",editable:true ,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "重量", name: "weight", index: "url",resizable:false,  width: 100, align: "center" ,edittype: "text",editable:true ,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "体积", name: "volume", index: "orderBy",resizable:false,  width: 100, align: "center" ,edittype: "text",editable:true ,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "计重", name: "jzWeight", index: "orderBy",resizable:false,  width: 100, align: "center" ,edittype: "text",editable:true ,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "货值", name: "value", index: "description",resizable:false,  width: 100, align: "center" ,edittype: "text",editable:true,editrules: { required: true, custom:true, custom_func: numberValidator}, },
                    { label: "备注信息", name: "description", resizable:false, index: "description", width: 150,edittype: "text", align: "center" ,editable:true },
                    { label: '<button type="button" onclick="addJgGirdNullData()" class="btn btn-success btn-xs">添加货品</button>',   sortable: false, width: 100, align: "center",
                        formatter: function (cellvalue, options, rowObject) {
                            return '<button type="button" onclick="deleteJgGirdNullData($(this))" class="btn btn-danger btn-xs">删除货品</button>'
                        }}
                ],
                pager: false,
                rownumbers: true,
                shrinkToFit: false,
                gridview: true,
                footerrow: true,
                caption: "货品明细",
                afterSaveCell:function(rowid){
                    var rowData = $(this).getRowData(rowid);
                    var jzWeight = parseFloat(rowData.volume /3);
                    var jzWeight =jzWeight.toFixed(${SystemConfig.inputRoundNumber});
                    var weight = parseFloat(rowData.weight);
                    var volume = parseFloat(rowData.volume);
                    if(weight>=jzWeight){
                        rowData.jzWeight = weight;
                    }else{
                        rowData.jzWeight =volume;
                    }
                    $(this).setRowData(rowid,rowData)
                    productTotal($(this))
                },
                gridComplete: function () {
                    var number = $(this).getCol("number", false, "sum");
                    var weight = $(this).getCol("weight", false, "sum");
                    var volume = $(this).getCol("volume", false, "sum");
                    var value = $(this).getCol("value", false, "sum");
                    var jzWeight = $(this).getCol("jzWeight", false, "sum");
                    //合计
                    $(this).footerData("set", {
                        "name": "合计：",
                        "number": "数量:" + number,
                        "weight": "重量:" + weight,
                        "volume": "体积:" + volume,
                        "value": "货值:" + value,
                        "jzWeight": "计重:" + jzWeight,
                    });
                },
            });
        }
        function productTotal(JGGIRD){
            var number = JGGIRD.getCol("number", false, "sum");
            var weight = JGGIRD.getCol("weight", false, "sum");
            var volume = JGGIRD.getCol("volume", false, "sum");
            var value = JGGIRD.getCol("value", false, "sum");
            var jzWeight = JGGIRD.getCol("jzWeight", false, "sum");
            //合计
            JGGIRD.footerData("set", {
                "name": "合计：",
                "number": "数量:" + number,
                "weight": "重量:" + weight,
                "volume": "体积:" + volume,
                "value": "货值:" + value,
                "jzWeight": "计重:" + jzWeight,
            });
        }

        function changeCostomerType(){
            var value = $("#costomerType").attr('data-value');
        if(value == 0){ //如果零散，客户名称自己输入
            $("#hetongShow").hide();
            $("#lingsanShow").show();
        }else{ //如果合同客户，客户名称不可编辑，从项目管理中选择
            $("#hetongShow").show();
            $("#lingsanShow").hide();
        }
        }
        function changeIsBack(){//改变回单录入
            var value = $('input:radio[name="isBack"]:checked').val()
            if(value == 0){
                $("#backNumber").attr('disabled',true);
            }else{
                $("#backNumber").removeAttr('disabled');
            }
        }


        /**
         * 初始化费用类型
         */
        function initFeeType(){
            $.ajax({
                url: "/feetype/getModelFeeType.action",
                data: {id:"1"},
                async:false,
                type: "post",
                dataType: "json",
                success: function (data) {
                    var $JGGRID = $JGGRID = $("#gridTable2");
                    $JGGRID.addRowData(getUUID(),data,"first");
                    $JGGRID.setGridHeight("auto")
                },
            });

        }

        /**
         * 客户选择接口
         */
        function selectCustomer(){
            if($("#costomerType").attr('data-value') == 0){
                return
            }
            dialogOpen({
                id: "CustomerFrom",
                title: '客户档案',
                url: '/jsp/Customer/CustomerIndex.jsp?status=1',
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getCustomer();
                    top.frames[iframeId].dialogClose();//关闭窗口
                    $("#costomer").val(resule.id);
                    $("#costomerName").val(resule.name);
                    $("#salePersion").val(resule.salePersion);
                    $("#FH_name").val(resule.name);
                    $("#FH_address").val(resule.address);
                    $("#FH_iphone").val(resule.iphone);
                    $("#FH_ltl").val(resule.ltl);
                    $("#FH_person").val(resule.contactperson);
                    $("#FH_detailedAddress").val(resule.detailedAddress);
                    $("#SH_name").val(resule.shdanwei);
                    $("#SH_address").val(resule.shaddress);
                    $("#SH_iphone").val(resule.shiphone);
                    $("#SH_ltl").val(resule.shltl);
                    $("#SH_person").val(resule.shcontactperson);
                    $("#SH_detailedAddress").val(resule.shdetailedAddress);
                    var status = resule.settlementType
                    for(var i in top.clientdataItem.Clearing){
                        if(top.clientdataItem.Clearing[i] ==status){
                            status=i
                        }
                    }
                    $("#feeType").ComboBoxSetValue(status);

                    // getProjectManagement(resule.id);
                }
            });
        }

        function selectZone(){
            var orgId='${orgId.id}';
            dialogOpen({
                id: "startZoneFrom",
                title: '提货区域',
                url: 'jsp/AdjustAccounts/ServerZoneIndex.jsp?type=0&orgId='+orgId,
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getServerZone();
                    top.frames[iframeId].dialogClose();//关闭窗口
                    $("#serverZone").val(resule.id);
                    $("#serverZoneName").val(resule.name);
                }
            });
        }
        function openFHReceivingParty(self){
            var windo = dialogOpen({
                id: "CustomerFrom",
                title: '收发货方选择',
                url: 'jsp/ReceivingParty/ReceivingPartyIndex.jsp?status=1',
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getReceivingParty();
                      $("#FH_name").val(resule.name);
                      $("#FH_address").val(resule.address);
                      $("#FH_iphone").val(resule.iphone);
                      $("#FH_ltl").val(resule.ltl);
                      $("#FH_person").val(resule.contactperson);
                      $("#FH_detailedAddress").val(resule.detailedAddress);
                    top.frames[iframeId].dialogClose();//关闭窗口
                    }
            })
        }
        function openSHReceivingParty(self){
            var windo = dialogOpen({
                id: "CustomerFrom",
                title: '收发货方选择',
                url: 'jsp/ReceivingParty/ReceivingPartyIndex.jsp?status=1',
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getReceivingParty();
                    $("#SH_name").val(resule.name);
                    $("#SH_address").val(resule.address);
                    $("#SH_iphone").val(resule.iphone);
                    $("#SH_ltl").val(resule.ltl);
                    $("#SH_person").val(resule.contactperson);
                    $("#SH_detailedAddress").val(resule.detailedAddress);
                    top.frames[iframeId].dialogClose();//关闭窗口
                }
            })
        }
        function buttonStatus(){
            if(source ){
                $('#order_confirm').hide()
                $('#order_sava').show()
                $('#order_sava').text("确认修改");
                //添加异常框
                var html='    <tr id="abnormals"><th class="formTitle" >异常原因<font face="宋体">*</font></th><td class="formValue" colspan="7"><textarea id="abnormal" isvalid="yes"  checkexpession="NotNull" class="form-control" ></textarea></td></tr>'
                $("#descriptionss").after(html)

            }else {
                $('#order_confirm').hide()
                $('#order_sava').hide()
                //处理确认按钮
                if($("#status").val() == ""){
                    $('#order_sava').show()
                }
                if($("#status").val() == 1){
                    $('#order_confirm').show();
                    $('#order_sava').show();
                }
            }
        }
        /**
         * 订单锁死
         */
        function orderLock(){

            var status = $('#status').val()
            if(status=='1' ||status==1 || status ==undefined ||status==null ||status=="" ||source){

            }else {
                $("#form1").find('.form-control,.ui-select,input').attr('disabled', 'disabled');
            }
        }
        /**
         * 按钮提交
         */
        function confirm(){
            $.removeFromMessage($('#form1'))
            if( $('#id').val() == null ||  $('#id').val() == "" || $('#id').val() == undefined){
                if($('#status').val()!=1){
                    dialogAlert("未保存订单不可以确认", -1);
                }

            }
            if (keyValue) {
                $.ConfirmAjax({
                    msg: "注：是否要确认订单？确认后订单不可更改",
                    url: "/transportorder/confirmOrder.action",
                    param: { id: $('#id').val() },
                    success: function (data) {
                        if (data.type) {
                            getOrder();
                            dialogMsg("确认成功", 1);
                        } else {
                            dialogAlert(data.obj, -1);
                        }
                    }
                })
            }
        }

        function selectReceivers(e) {
            var url = '/jsp/CommPlug/GdMap.jsp';
            var ltl = $("#FH_ltl").val();
            if( ltl != null && ltl != undefined && ltl != ""){
                url+="?ltl="+ltl
            }
            dialogOpen({
                id: "GdMap",
                title: '地图选择',
                url: url,
                width: "900px",
                height: "650px",
                callBack: function (iframeId) {
                    var data = top.frames[iframeId].AcceptClickToReceivers();
                    $("#FH_ltl").val(data.latitude)
                    $("#FH_address").val(data.address)
                    top.frames[iframeId].dialogClose();//关闭窗口
                }
            });
        }
        function selectReceivers2(e) {
            var url = '/jsp/CommPlug/GdMap.jsp';
            var ltl = $("#SH_ltl").val();
            if (ltl != null && ltl != undefined && ltl != "") {
                url += "?ltl=" + ltl
            }
            dialogOpen({
                id: "GdMap",
                title: '地图选择',
                url: url,
                width: "900px",
                height: "650px",
                callBack: function (iframeId) {
                    var data = top.frames[iframeId].AcceptClickToReceivers();
                    $("#SH_ltl").val(data.latitude)
                    $("#SH_address").val(data.address)
                    top.frames[iframeId].dialogClose();//关闭窗口
                }
            });
        }
        function fuzhi(){
          var aa = $("#costomerType").attr('data-value');
            var nn = $("#FH_name").val();
            if(aa == 0){
                $("#costomerNameLs").val(nn);
                }
        }
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <div class="tab-content" style="padding-top: 15px;width: 1160px">
            <table class="form">
                <hr style="margin:10px;height:3px;border:none;border-top:1px double #008080;" />
                <input id="id" name="id"  type="hidden" />
                <input id="loadingMethod" name="loadingMethod" type="hidden" value="1"/>
                <input id="status" name="status" type="hidden" />
                <input id="plan" name="status" type="hidden" />
                <tr>
                    <td class="formTitle">预录单号</td>
                    <td class="formValue">
                        <input id="code" type="" class="form-control" disabled = "disabled"  placeholder="系统自动生成" readonly="readonly"  />
                    </td>
                    <td class="formTitle">发货单号</td>
                    <td class="formValue">
                        <input id="relatebill1"  autocomplete="off" type="text" class="form-control" maxlength="50"/>
                    </td>
                    <td class="formTitle">受理日期<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="dateAccepted" type="text"  placeholder="请选择订单时间"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                    </td>

                    <td class="formTitle">提货公里数</td>
                    <td class="formValue">
                        <input id="pickMileage" value = "0" type="text" class="form-control"
                               isvalid="yes" autocomplete="off" checkexpession="IsPositiveOrNull"/>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">客户类型<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="costomerType" type="select" onchange="changeCostomerType()"  class="ui-select" isvalid="yes" checkexpession="NotNull">
                        </div>
                    </td>
                    <td class="formTitle">客户名称</td>
                    <td class="formValue" id="hetongShow">
                        <input id="costomer"  type="hidden" value=""/>
                        <input id="costomerName"  readonly="readonly"  type="text" onclick="selectCustomer()" class="form-control" />
                        <span class="input-button" onclick="selectCustomer()" title="请选择合同" >.......</span>
                    </td>
                    <td id="lingsanShow">
                        <input id="costomerNameLs" name="costomerNameLs"   type="text"  class="form-control" />
                    </td>
                    <th class="formTitle">提货区域<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="serverZone"  type="hidden" />
                        <input id="serverZoneName"  placeholder="请选择" autocomplete="off" onclick="selectZone()" readonly  type="text" isvalid="yes" checkexpession="NotNull"  class="form-control" />
                    </td>
                </tr>
                <!--装饰线-->
                <td colspan="8">
                    <hr style="margin:3px;height:3px;border:none;border-top:1px double #008080"  />
                </td>
                <div id = "FHF">
                    <tr>
                        <td class="formTitle"><span style="margin-right: 5px"></span>发货单位<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input id="FH_name" name = "FH_name" onchange="fuzhi()" autocomplete="off" class="form-control" placeholder="请输入或选择发货方单位" />
                            <span class="input-button"  onclick="openFHReceivingParty($(this))" title="请选择发货方" >.......</span>
                        </td>
                        <td class="formTitle">发货人<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input id="FH_person"  autocomplete="off" name = "FH_person" type="text" class="form-control" placeholder="请输入发货人" isvalid="yes"
                                   checkexpession="NotNull"/>
                        </td>
                        <td class="formTitle">联系电话<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input  id="FH_iphone" autocomplete="off" name = "FH_iphone" type="text" class="form-control" placeholder="请输入联系电话" isvalid="yes"
                                   checkexpession="NotNull"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="formTitle">发货地址<font face="宋体">*</font></td>
                        <td class="formValue" >
                            <input  id = "FH_address" autocomplete="off"  name="FH_address"   type="text"   class="form-control" placeholder="请输入发货地址" isvalid="yes"
                                   checkexpession="NotNull"> </input>
                            <span class="input-button" SorderBy = "1" onclick="selectReceivers()" title="选择地址" ><i class="fa fa-map-pin"></i></span>
                        </td>
                        <td class="formTitle">经纬度<font face="宋体">*</font></td>
                        <td class="formValue" >
                            <input  autocomplete="off" id="FH_ltl" name="FH_ltl"  type="" class="form-control"  placeholder="经纬度为空"> </input>
                        </td>
                        <td class="formTitle">详细地址<font face="宋体">*</font></td>
                        <td class="formValue" >
                            <input style="width: 450px" autocomplete="off" id="FH_detailedAddress" name="FH_detailedAddress"  type="" class="form-control" > </input>
                        </td>
                    </tr>
                </div>
                <!--装饰线-->
                <td colspan="8">
                    <hr style="margin:5px;height:5px;border:none;border-top:1px double #008080"  />
                </td>
                <div id = "SHF">
                    <tr>
                        <td class="formTitle"><span style="margin-right: 5px"></span>收货单位</td>
                        <td class="formValue">
                            <input id="SH_name" autocomplete="off" name = "SH_name" class="form-control" placeholder="请输入或选择收货方单位"/>
                            <span class="input-button"  onclick="openSHReceivingParty($(this))" title="请选择发货方" >.......</span>
                        </td>
                        <td class="formTitle">收货人</td>
                        <td class="formValue">
                            <input id="SH_person" autocomplete="off" name ="SH_person" type="text" class="form-control" placeholder="请输入收货人"/>
                        </td>
                        <td class="formTitle">联系电话</td>
                        <td class="formValue">
                            <input id="SH_iphone" autocomplete="off" name = "SH_iphone" type="text" class="form-control" placeholder="请输入联系电话" />
                        </td>

                    </tr>
                    <tr>
                        <td class="formTitle">收货地址</td>
                        <td class="formValue" >
                            <input  id = "SH_address" autocomplete="off" name="SH_address"  type="text"   class="form-control" placeholder="请输入发货地址"> </input>
                            <span class="input-button" onclick="selectReceivers2()" title="选择地址" ><i class="fa fa-map-pin"></i></span>
                        </td>
                        <td class="formTitle">经纬度<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input id="SH_ltl" autocomplete="off"  name="SH_ltl"  type="" class="form-control"   placeholder="经纬度为空"> </input>
                        </td>
                        <td class="formTitle">详细地址<font face="宋体">*</font></td>
                        <td class="formValue" >
                            <input style="width: 450px" autocomplete="off" id="SH_detailedAddress" name="SH_detailedAddress"  type="" class="form-control" > </input>
                        </td>
                    </tr>
                </div>
                <td colspan="8">
                    <hr style="margin:5px;height:5px;border:none;border-top:1px double #008080"  />
                </td>
                <tr >
                    <td class="formValue" colspan="8">
                        <table id="gridTable"></table>
                    </td>
                </tr>
                <td colspan="8">
                    <hr style="margin:5px;height:5px;border:none;border-top:1px double #008080"  />
                </td>
                <tr >
                    <td class="formValue" colspan="8">
                        <table id="gridTable2"></table>
                    </td>
                </tr>
            </table>
            <table class="form" id = "feeTypeClass">
                <tr id="descriptionss">
                    <th class="formTitle" >备注</th>
                    <td class="formValue" colspan="7">
                        <textarea id="description" autocomplete="off" class="form-control" ></textarea>
                    </td>
                </tr>

            </table>
            <%--<div id="bottomField" class="ordermanage">--%>
                <%--&lt;%&ndash;&lt;%&ndash;<a id="replace" class="btn btn-default" onclick="closeOrder()">关闭</a>&ndash;%&gt;&ndash;%&gt;--%>
                <%--&lt;%&ndash;<a id="order_sava" class="btn btn-success" onclick="AcceptClick()">yulu单</a>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<a id="order_confirm" class="btn btn-warning" onclick="confirm();">确认订单</a>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<a id="order_print" class="btn btn-default" onclick="printOrder()">打印单据</a>&ndash;%&gt;--%>
                <%--<script>$('.ordermanage').authorizeButton()</script>--%>
            <%--</div>--%>
        </div>
    </div>
</form>
<style>
    .ui-jqgrid tr.footrow-ltr {
        border-left: 0px !important;
        border-right: 0px !important;
        border-bottom: 0px !important;
        font-weight: 700;
    }
</style>
</body>
</html>