<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/3/10
  Time: 9:27
  订单表单
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
    <title>订单表单</title>
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
    <%--打印及插件--%>
    <script src="/Content/lodopPrint/LodopFuncs.js"></script>
    <object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
    </object>
</head>
<body>


<form id="form1" style="height: 1000px;width: 1000px;">

    <script>
        var feeTypeData;//费用变量存储
        var keyValue = request('keyValue');
        var prescoId = request('prescoId');
        var source = request('source'); //如果是异常单prescoId
        $(function () {
            initControl();
            changeCostomerType();
            changeIsBack();
        })
        //初始化控件
        function initControl() {
            getFeeType();//初始化费用类型
            //入库区域zoneStoreroom
            $("#zoneStoreroom").ComboBox({ //客户类型
                description: "=请选择入库区域=",
                height: "200px",
                url: '/zoneStoreroom/getZoneStoreroomMap.action',
                defaultOne:true
            });
            $("#toOrganization").ComboBox({ //目的网点
                description: "=请选择目的网点=",
                height: "200px",
                url: '/org/getOrgTree.action',
                //defaultOne:true
            });
            $("#costomerType").ComboBox({ //客户类型
                description: "=请选择客户类型=",
                height: "200px",
                data: top.clientdataItem.CustomerType
            });
            $("#handoverType").ComboBox({ //交付方式
                description: "=请选择交付方式=",
                height: "200px",
                data: top.clientdataItem.HandoverType,
                defaultVaue:'0'
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
            $("#isBilling").ComboRadio({ //是否开票
                data: top.clientdataItem.CommIsNot,
                defaultVaue: '1'
            });
            $("#isBack").ComboRadio({ //是否回单
                data: top.clientdataItem.CommIsNot,
                defaultVaue: '0'
            });
            $("#transportPro").ComboBox({ //运输性质
                description: "=请选择运输性质=",
                height: "200px",
                data: top.clientdataItem.TransportPro
            });
            $("#shipmentMethod").ComboBox({ //运输性质
                description: "=请选择运输方式=",
                height: "200px",
                data: top.clientdataItem.TransportMenth
            });
            $("#jsType").ComboRadio({
                data: top.clientdataItem.JSFS
            })

//            //起运站
//            $("#organization").ComboBoxTree({
//                url: "/org/getOrgTree.action",
//                description: "==请选择==",
//                height: "200px",
//            });
//            //目的站
//            $("#organization1").ComboBoxTree({
//                url: "/org/getOrgTree.action",
//                description: "==请选择==",
//                height: "200px",
//            });


            getMapDataFroIdAddress("faddress", "fLtl","fdetailedAddress");
            getMapDataFroIdAddress("Saddress", "sLtl","sdetailedAddress");
            //获取表单
            initComplete(); //初始化下拉插件
            if (!!keyValue) {
               getOrdera();
            }else {
                GetGrid(); //初始化货品明细
                GetGrid2();//初始化费用
                initFeeType() //初始化费用
                showDate("time"); //初始化时间
                $("#transportPro").ComboBoxSetValue(0);
                $("#feeType").ComboBoxSetValue(1);
                $("#costomerType").ComboBoxSetValue(1);
                //$("#shipmentMethod").ComboBoxSetValue(0);
                //$("#taxRate").ComboBoxSetValue('0.11');
                addJgGirdNullData();
                buttonStatus() //初始化按钮
            }
        }
        /**编辑初始化*/
        function getOrdera(){
            $.SetForm({
                url: "/transportorder/getOrder.action",
                param: {id: keyValue},
                success: function (data) {
                        $("#id").val(data.id), //处理单头
                        $("#code").val(data.code),
                        $("#status").val(data.status),
                        $("#description").val(data.description)
                        $("#relatebill1").val(data.relatebill1),
                        $("#relatebill2").val(data.relatebill2),
                        $("#time").val(data.time),
                        $("#price").val(data.price);
                        $("#isTake").val(data.isTake);
                    $("input:radio[name='jsType'][value='"+data.jsType+"']").attr("checked","checked")
                        $("#feeType").ComboBoxSetValue(data.feeType),
                        $("#costomerType").ComboBoxSetValue(data.costomerType),//客户类型
                        $("#handoverType").ComboBoxSetValue(data.handoverType);//交付方式
                        if(data.customer != null){
                            $("#costomer").val(data.customer.id);
                            $("#costomerName").val(data.customer.name)
                        };
                        $("#costomerName1").val(data.costomerName);
                    if(data.zoneStoreroom != null){
                        $("#zoneStoreroom").ComboBoxSetValue(data.zoneStoreroom.id);
                    };
                    if(data.startZone != null){
                        $("#startZone").val(data.startZone.id);
                        $("#startZoneName").val(data.startZone.zone.name);
                    };
                    if(data.toOrganization != null){
                        $("#toOrganization").ComboBoxSetValue(data.toOrganization.id);
                       // $("#toOrganizationName").val(data.toOrganization.name);
                    };
                    if(data.endZone != null){
                        $("#endZone").val(data.endZone.id);
                        $("#endZoneName").val(data.endZone.zone.name)
                    };
                        $("#transportPro").ComboBoxSetValue(data.transportPro),
                        $("#loadingMethod").val(data.loadingMethod),
                        //$("#shipmentMethod").ComboBoxSetValue(data.shipmentMethod),
                        $("#salePersion").val(data.salePersion),

                        $("input:radio[name='isBack'][value='"+data.isBack+"']").attr("checked","checked")
                        $("#backNumber").val(data.backNumber),
                            $("#planLeaveTime").val(data.planLeaveTime),
                            $("#planArriveTime").val(data.planArriveTime)
                        /*$("input:radio[name='isBilling'][value='"+data.isBilling+"']").attr("checked","checked")*/
                            //处理收发货方
                          var receivingParties=data.orderReceivingParties;//读取所有的收发货方数据
                          var Frece = new Array();
                          var Srece = new Array();
                          for(i=0;i<receivingParties.length;i++){
                              var receiving = receivingParties[i];
                              if(receiving.type == 0){//如果是发货方
                                  Frece.push(receiving)
                              }
                              if(receiving.type == 1){//如果是收货方
                                  Srece.push(receiving)
                              }
                          }

                    receivingPartiesUtil(Frece,"ForderBy") //处理发货方
                    receivingPartiesUtil(Srece,"SorderBy") //处理收货方
                    //收发货方处理工具
                    function receivingPartiesUtil(arrary,key){
                      for(i=0;i<arrary.length;i++) {
                            var s = arrary[i];
                            var number = i +1
                            var em = $("["+key+"='"+number+"']");
                            if(em.length == 0){
                                if(key == "ForderBy"){
                                    addFHF(null,i);
                                }
                                if(key == "SorderBy"){
                                    SaddFHF(null,i);
                                }
                            }
                          var em = $("["+key+"='"+number+"']");
                          em.each(function(){
                              if ($(this).attr("name") == "orderBy"){
                                  $(this).val(s.orderBy);
                              }
                              if ($(this).attr("name") == "type"){
                                  $(this).val(s.type);
                              }
                              if ($(this).attr("name") == "id"){
                                  $(this).val(s.id);
                              }
                              if(key == "ForderBy"){
                                  if ($(this).attr("name") == "selectName"){
                                      $(this).val(s.name)
                                  }
                              }else{
                                  if ($(this).attr("name") == "shdanwei"){
                                      $(this).val(s.name)
                                  }
                              }


                              if ($(this).attr("name") == "contactperson"){
                                  $(this).val(s.contactperson);
                              }
                              if ($(this).attr("name") == "iphone"){
                                  $(this).val(s.iphone);
                              }
                              if ($(this).attr("name") == "address"){
                                  $(this).val(s.address);
                              }
                              if ($(this).attr("name") == "ltl"){
                                  $(this).val(s.ltl);
                              }
                              if ($(this).attr("name") == "detailedAddress"){
                                  $(this).val(s.detailedAddress);
                              }
                          })
                      }
                    }
                        //处理货品信息
                    GetGrid(); //初始化货品明细
                    var $JGGRID = $("#gridTable");
                    $JGGRID.jqGrid("clearGridData"); //清空数据
                    $JGGRID.setGridHeight(0)
                    if(data.orderProducts != null){
                        $JGGRID.addRowData(getUUID(),data.orderProducts,"first");
                    }
                    $JGGRID.setGridHeight("auto")
                    //处理台账
                    GetGrid2();//初始化费用
                    var $JGGRID = $("#gridTable2");
                    $JGGRID.jqGrid("clearGridData"); //清空数据
                    $JGGRID.setGridHeight(0);
                    if(data.ledgerDetails != null){
                        $JGGRID.addRowData(getUUID(),data.ledgerDetails,"first");
                    }
                    $JGGRID.setGridHeight("auto")

                }
            });
            buttonStatus()//按钮初始化
            orderLock() //编辑锁死
        }



        /**
         * 添加货品明细空数据
         */

        function addJgGirdNullData (){
            if(source){
                alert("不能新添货品")
                return
            }
            var model={
                id:null,
                name:null,
                number:1,
                weight:0,
                volume:0,
                value:0,
                description:null,
            }
            var $JGGRID = $("#gridTable")


            $JGGRID.addRowData(getUUID(),model,"first");
            $JGGRID.setGridHeight("auto")
        }
        function addJgGirdNullData2 (){
            var model={
                id:null,
                name:null,
                taxRate:0.09, //默认税率
                settlementMethod:"月结",
                collectMethod:"银行",
                description:null,

            }
            var $JGGRID = $("#gridTable2")


//            $JGGRID.jqGrid("addRowData",null,"first");
            $JGGRID.addRowData(getUUID(),model,"first");
            $JGGRID.setGridHeight("auto")
        }
        /**
         * 删除货品明细空数据
         */
        function deleteJgGirdNullData (data){
           var $JGGRID = $("#gridTable");
            data.parent().parent().remove();

            productTotal($JGGRID)
            $JGGRID.setGridHeight("auto")
        }
        function deleteJgGirdNullData2 (data){
            var $JGGRID = $("#gridTable2");
            data.parent().parent().remove();

            feeTypeTotal($JGGRID)
            $JGGRID.setGridHeight("auto")
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
                "amount": "金额:" + amount,
                "input": "税金:" + input,
                "income": "收入:" + income
            });
        }
        function getOrder(){
            var order ={ //处理单头信息
                id:$("#id").val(),
                code:$("#code").val(),
                status:$("#status").val(),
                relatebill1:$("#relatebill1").val(),
                relatebill2:$("#relatebill2").val(),
                time:$("#time").val(),
                feeType:$("#feeType").attr('data-value'),
                costomerType:$("#costomerType").attr('data-value'),
                customer:{id :$("#costomer").val()},    //合同客户
                costomerName:$("#costomerName1").val(), //零散客户名称
                handoverType: $("#handoverType").attr('data-value'),//交付方式
//               zoneStoreroom:$("#zoneStoreroom").attr('data-value'), //入库区域
                zoneStoreroom:{id:$("#zoneStoreroom").attr('data-value')}, //入库区域
                startZone:{id :$("#startZone").val()}, //出发运点
                toOrganization:{id :$("#toOrganization").attr('data-value')}, //目的网点
                // toOrganization:$("#toOrganization").attr('data-value'),
                endZone:{id :$("#endZone").val()}, //目的运点
                price:$("#price").val(),//单价
                jsType:$('input:radio[name="jsType"]:checked').val(),
                transportPro:$("#transportPro").attr('data-value'),  //运输性质
                //loadingMethod:$("#loadingMethod").val(),
                // shipmentMethod:$("#shipmentMethod").attr('data-value'),
                salePersion:$("#salePersion").val(),  //销售负责人
                isBack:$('input:radio[name="isBack"]:checked').val(), //是否回单
                backNumber:$("#backNumber").val(),  //回单份数
                planLeaveTime:$("#planLeaveTime").val(),
                planArriveTime:$("#planArriveTime").val(),
                isTake:$("#isTake").val(),
                // isBilling:$('input:radio[name="isBilling"]:checked').val(),
                //plan:{id :$("#plan").val()},
                //escription:$("#description").val()
            }
            //备注如果为空，不赋值
            if($("#description").val()!=null && $("#description").val()!=""){
                var aa = $("#description").val();
                   aa = JSON.stringify(aa);
                order['description']=aa;
            }

            if(prescoId !=null && prescoId !=""){
                order['presco']={id:prescoId}
            }
            var list = new Array();
            //处理收发货方
            var listForder = $("[ForderBy]")
            var number = listForder.length / 10 //循环次数
            for(i = 1;i<=number;i++){
                var em = $("[ForderBy='"+i+"']");
                var obj ={}
                em.each(function(){
                    obj['orderBy'] = i;
                    obj['type'] = 0;
                    if ($(this).attr("name") == "id"){
                        obj['id'] = $(this).val();
                    }

                    if ($(this).attr("name") == "selectName"){
                        obj['name'] = $(this).val();
                        var aa = $("#costomerType").attr('data-value');
                        if(aa == 0){
                            $("#costomerName1").val($(this).val());
                        }
                    }

                    if ($(this).attr("name") == "contactperson"){
                        obj['contactperson'] = $(this).val();
                    }
                    if ($(this).attr("name") == "iphone"){
                        obj['iphone'] = $(this).val();
                    }
                    if ($(this).attr("name") == "address"){
                        obj['address'] = $(this).val();
                    }
                    if ($(this).attr("name") == "ltl"){
                        obj['ltl'] = $(this).val();
                    }
                    if ($(this).attr("name") == "detailedAddress"){
                        obj['detailedAddress'] = $(this).val();
                    }
                })
                list.push(obj)
            }
            var listSorder = $("[SorderBy]")
            var number = listSorder.length / 10 //循环次数
            for(i = 1;i<=number;i++){
                var em = $("[SorderBy='"+i+"']");
                var obj ={}
                em.each(function(){
                    obj['orderBy'] = i;
                    obj['type'] = 1;
                    if ($(this).attr("name") == "id"){
                        obj['id'] = $(this).val();
                    }

                    if ($(this).attr("name") == "shdanwei"){
                        obj['name'] = $(this).val();
                    }

                    if ($(this).attr("name") == "contactperson"){
                        obj['contactperson'] = $(this).val();
                    }
                    if ($(this).attr("name") == "iphone"){
                        obj['iphone'] = $(this).val();
                    }
                    if ($(this).attr("name") == "address"){
                        obj['address'] = $(this).val();
                    }
                    if ($(this).attr("name") == "ltl"){
                        obj['ltl'] = $(this).val();
                    }
                    if ($(this).attr("name") == "detailedAddress"){
                        obj['detailedAddress'] = $(this).val();
                    }
                })
                list.push(obj)
            }
            order['orderReceivingParties'] = list
            //处理货品明细
            var jggirdData = $('#gridTable').jqGrid("getRowData");
            order['orderProducts'] = jggirdData;
            //处理费用类型
            var jggirdData2 = $('#gridTable2').jqGrid("getRowData");
            // var ledgers = new Array(); //台账
            var LedgerDetails = new Array(); //台账
            //  var countAmount =0;
            // var countInput = 0;
            for(i=0;i<jggirdData2.length;i++){
                var feeTypeId;
                var leddetail = jggirdData2[i]
                //countAmount=countAmount+parseFloat(leddetail.amount)
                //countInput=countInput+parseFloat(leddetail.input)
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
                    income:leddetail.income,
                    settlementMethod:leddetail.settlementMethod,
                    collectMethod:leddetail.collectMethod,
                    nowPay:leddetail.nowPay,
                    arrivePay:leddetail.arrivePay,
                    backPay:leddetail.backPay,
                    monthPay:leddetail.monthPay,
                    yf_youka:leddetail.yf_youka,
                    yajin:leddetail.yajin,
                    description:leddetail.description
                }
                LedgerDetails.push(LedgerDetail)
            }


            /*   var ledger = {
                   amount:countAmount,
                   taxRate:0,
                   input:countInput,
                   type:0,
                   cost:0
               }*/
            order['LedgerDetails'] = LedgerDetails;
            // ledgers.push(ledger)
            // order['ledgers'] = ledgers
            return order
        }



        //保存订单
        function AcceptClick() {
            $.removeFromMessage($('#form1'))
            if (!$('#form1').Validform()) {
                return false;
            }
            var order = getOrder()
            var orderData = {order:JSON.stringify(order)};

            var url = "/transportorder/saveOrder.action"
            if($('#order_sava').text() == "确认修改"){ //异常提交地址
                url =  "/transportorder/saveAbnormalOrder.action";
                orderData["text"]= $("#abnormal").val()
            }
            $.SaveForm({
                url: url,
                param:orderData ,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    } else if (data.type) {
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        keyValue =data.obj.id
                        getOrder();
                        dialogMsg("保存成功", 1);
                        if(source ){
                            dialogClose();//关闭窗口
                        }
                    } else {
                        dialogAlert(data.obj, -1);
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
                height: 0,
                autowidth: false,
                width:1100,
                cellEdit:true,
                cellsubmit:"clientArray",
                colModel: [
                    { label: "主键", name: "id", index: "id", hidden: true },
                    { label: "主键", name: "feeType.id", index: "id", hidden: true },
                    { label: "费用名称", name: "feeType.name", width: 150,resizable:false,editable:true,edittype:'select', align: "center",editoptions: {value: feeTypeData}},
                    { label: "应收金额", name: "amount", index: "target", resizable:false, width: 100, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "税率", name: "taxRate",  width: 80,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.TaxRate}},
                    { label: "税金", name: "input", index: "input",resizable:false,  width: 100, align: "center"},
                    { label: "收入", name: "income", index: "income",resizable:false,  width: 100, align: "center"},
                    { label: "结算方式", name: "settlementMethod",  width: 100,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.SettlementMethod}},
                    { label: "收款方式", name: "collectMethod",  width: 100,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.CollectMethod}},
                    /*{ label: "预收油卡", name: "yf_youka", index: "yf_youka", resizable:false, width: 60, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "押金", name: "yajin", index: "yajin", resizable:false, width: 60, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "现付金额", name: "nowPay", index: "nowPay", resizable:false, width: 70, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "到付金额", name: "arrivePay", index: "arrivePay", resizable:false, width: 70, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "回付金额", name: "backPay", index: "backPay", resizable:false, width: 70, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "月结金额", name: "monthPay", index: "monthPay", resizable:false, width: 80, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},}*/
                    { label: "备注信息", name: "description", resizable:false, index: "description", width: 150,edittype: "text", align: "center" ,editable:true },
                    { label: '<button type="button" onclick="addJgGirdNullData2()" class="btn btn-success btn-xs">添加费用</button>',   sortable: false, width: 100, align: "center",
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
                    var rowData = $(this).getRowData(rowid);
                    var taxRate = parseFloat(rowData.amount / (1 + parseFloat(rowData.taxRate)) * parseFloat(rowData.taxRate));
                    var taxRate =taxRate.toFixed(${SystemConfig.inputRoundNumber}) ;
                    rowData.input = taxRate;
                    rowData.income = rowData.amount - rowData.input;
                    //计算合计
                    var aa = $("#feeType").attr('data-value');//结算方式
                    if(cellname == 'amount'){
                        if(aa == 0){//月结
                           var monthPay = rowData.amount;
                           rowData.monthPay = monthPay;
                           rowData.nowPay = 0.00;
                            rowData.arrivePay =0.00;
                            rowData.backPay = 0.00;
                        }
                        if(aa == 1){//现结
                            var nowPay = rowData.amount;
                            rowData.nowPay = nowPay;
                            rowData.monthPay = 0.00;
                            rowData.arrivePay =0.00;
                            rowData.backPay = 0.00;
                        }
                        if(aa == 2 ){//到付
                            var arrivePay = rowData.amount;
                            rowData.arrivePay = arrivePay;
                            rowData.nowPay = 0.00;
                            rowData.monthPay = 0.00;
                            rowData.backPay = 0.00;
                        }
                        if(aa == 3){//回付
                            var backPay = rowData.amount;
                            rowData.backPay = backPay;
                            rowData.arrivePay = 0.00;
                            rowData.nowPay = 0.00;
                            rowData.monthPay = 0.00;
                        }
                    }
                    $(this).setRowData(rowid,rowData)
                    feeTypeTotal($(this))
                },
                gridComplete: function () {
                    var amount = $(this).getCol("amount", false, "sum");
                    var input = $(this).getCol("input", false, "sum");
                      input = input.toFixed(3);
                    var income = $(this).getCol("income", false, "sum");
                      income =income.toFixed(3);
                    var backPay = $(this).getCol("backPay", false, "sum");
                    var arrivePay = $(this).getCol("arrivePay", false, "sum");
                    var nowPay = $(this).getCol("nowPay", false, "sum");
                    var monthPay = $(this).getCol("monthPay", false, "sum");
                    //合计
                    $(this).footerData("set", {
                        "feeType.name": "合计：",
                        "amount": "总金额:" + amount,
                        "input": "税金 :" + input,
                        "income": "收入 :" + income,
                        "backPay": "回付 :" + backPay,
                        "arrivePay": "到付 :" + arrivePay,
                        "nowPay": "现付 :" + nowPay,
                        "monthPay": "月结 :" + monthPay,
                    });
                },
            });
        }



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
                if(val == null || val =="" || val == undefined){
                    return [true,parseFloat(0)]
                }
                var boolean = isInteger(val)
                if(boolean){
                    return [true,parseFloat(val)];
                }
                return  [false,"请输入正确数字"];
            }
            $gridTable.jqGrid({
//                url: "",
                datatype: "json",
                height: 0,
                autowidth: false,
                width:1100,
                cellEdit:true,
                cellsubmit:"clientArray",
                colModel: [
                    { label: "主键", name: "id", index: "id", hidden: true },
                    { label: "品名", name: "name",  width: 200,resizable:false, align: "center",editable:true},
                    { label: "包装", name: "unit", width: 100,resizable:false,editable:true,edittype:'select', align: "center",editoptions: {value: top.clientdataItem.Baozhuang}},
                    { label: "数量", name: "number",  index: "target", resizable:false, width: 100, align: "center",edittype: "text",editable:true ,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "重量", name: "weight", index: "url",resizable:false,  width: 100, align: "center" ,edittype: "text",editable:true ,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "体积", name: "volume", index: "orderBy",resizable:false,  width: 100, align: "center" ,edittype: "text",editable:true ,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "计重", name: "jzWeight", index: "orderBy",resizable:false,  width: 100, align: "center" ,edittype: "text",editable:true ,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "货值", name: "value", index: "description",resizable:false,  width: 100, align: "center" ,edittype: "text",editable:true,editrules: { required: true, custom:true, custom_func: numberValidator}, },
                    { label: "备注信息", name: "description", resizable:false, index: "description", width: 150,edittype: "text", align: "center" ,editable:true },
                    { label: '<button type="button" onclick="addJgGirdNullData()" class="btn btn-success btn-xs">添加货品</button>',   sortable: false, width: 100, align: "center",
                        formatter: function (cellvalue, options, rowObject) {
                            if(source ){
                                return '不可修改'
                            }
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
                    //计算计重
                    var rowData = $(this).getRowData(rowid);
                    var jzWeight = parseFloat(rowData.volume /3);
                    var jzWeight =jzWeight.toFixed(${SystemConfig.inputRoundNumber});
                    var weight = parseFloat(rowData.weight);
                    var volume = parseFloat(rowData.volume);
                    if(weight>=jzWeight){
                        rowData.jzWeight = weight;
                    }else{
                        rowData.jzWeight =jzWeight;
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
                        "jzWeight":"计重"+jzWeight
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
                "jzWeight":"计重"+jzWeight
            });
        }

        function changeCostomerType(){
            var value = $("#costomerType").attr('data-value');
            if(value == 0){ //如果零散客户，客户名称自己输入
                $("#hetongShow").hide();
                $("#lingsanShow").show();

            }else{ //如果合同客户，客户名称不可编辑，从项目管理中选择
                $("#hetongShow").show();
                $("#lingsanShow").hide();

            }
        }
        function changeIsBack(){//改变回单录入
            var value = $('input:radio[name="isBack"]:checked').val();
            if(value == 0){
                $("#backNumber").attr('disabled',true);
            }else{
                $("#backNumber").removeAttr('disabled');
            }
        }

        /**
         *计算规则
         */
        function ruleRun(){
            if(!$("#ruleName").val()){
                alert("没有规则，不能计算")
                return
            }
            var order = getOrder()
            var orderData = JSON.stringify(order);
            $.SaveForm({
                loading: "正在计算数据...",
                url: "/rule/runRule.action",
                param: {code: $("#ruleName").val(),obj:orderData},
                success: function (data) {
                    if(data.result){
                        alert("计算成功")
                        var $JGGRID = $("#gridTable2");
                        $JGGRID.jqGrid("clearGridData"); //清空数据
                        for (var i = 0; i <data.obj.length ; i++) {
                            var model={
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
                            $JGGRID.addRowData(getUUID(),model,"first")
                        }
                        $JGGRID.setGridHeight("auto")


                        // console.log(data.obj)
                        // console.log(feeTypeData)

                    }else {
                        alert(data.obj)
                    }
                }
            })
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
                    if(data.length != 0){
                        var $JGGRID  = $("#gridTable2");
                        data[0].taxRate=0.09;
                        $JGGRID.addRowData(getUUID(),data,"first");
                        $JGGRID.setGridHeight("auto");
                    }

                },
            });

        }

        /**
         * 计划选择
         */
        function selectPlan(){
            dialogOpen({
                id: "PlanFrom",
                title: '计划选择',
                url: 'jsp/PlanOrder/JcPlanIndex.jsp?status=1',
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getPlan();
                    top.frames[iframeId].dialogClose();//关闭窗口
                    $("#plan").val(resule.id);
                    $("#planName").val(resule.name);
                }
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
                    $("#shdanwei").val(resule.shdanwei);
                    $("#shaddress").val(resule.shaddress);
                    $("#shiphone").val(resule.shiphone);
                    $("#shltl").val(resule.shltl);
                    $("#shcontactperson").val(resule.shcontactperson);
                    $("#shdetailedAddress").val(resule.shdetailedAddress);
                    $("#costomer").val(resule.id);
                    $("#costomerName").val(resule.name);
                    if($("#salePersion").val() == null ||  $("#salePersion").val() == ""){
                        $("#salePersion").val(resule.salePersion);
                    }
                    var em = $("[ForderBy='1']");
                    em.each(function() {
                        if ($(this).attr("name") == "selectName") {
                            $(this).val(resule.name)
                        }
                        if ($(this).attr("name") == "contactperson") {
                            $(this).val(resule.contactperson)
                        }
                        if ($(this).attr("name") == "iphone") {
                            $(this).val(resule.iphone)
                        }
                        if ($(this).attr("name") == "address") {
                            $(this).val(resule.address)
                        }
                        if ($(this).attr("name") == "ltl") {
                            $(this).val(resule.ltl)
                        }
                        if ($(this).attr("name") == "detailedAddress") {
                            $(this).val(resule.detailedAddress)
                        }
                    })

                    var status = resule.settlementType
                    for(var i in top.clientdataItem.Clearing){
                        if(top.clientdataItem.Clearing[i] ==status){
                            status=i
                        }
                    }
                    $("#feeType").ComboBoxSetValue(status);
                    if(resule['rule.code']){
                        $("#ruleName").val(resule['rule.code'] )
                    }


                  // getProjectManagement(resule.id);
                }
            });
        }

        /**
         * 出发运点
         */
        function selectStartZone(){
            var orgId='${orgId.id}';
            dialogOpen({
                id: "startZoneFrom",
                title: '出发运点',
                url: 'jsp/AdjustAccounts/ServerZoneIndex.jsp?orgId='+orgId,
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getServerZone();
                    top.frames[iframeId].dialogClose();//关闭窗口
                    $("#startZone").val(resule.id);
                    $("#startZoneName").val(resule.name);
                }
            });
        }

        /**
         * 目的网点
         */
//        function selectOrg(){
//            dialogOpen({
//                id: "orgeFrom",
//                title: '目的网点',
//                url: 'jsp/BaseData/Organization/Index.jsp?status=1',
//                width: "1050px",
//                height: "450px",
//                callBack: function (iframeId) {
//                    var resule = top.frames[iframeId].getOrg();
//                    top.frames[iframeId].dialogClose();//关闭窗口
//                    $("#toOrganization").val(resule.id);
//                    $("#toOrganizationName").val(resule.name);
//                }
//            });
//        }

        /**
         * 目的运点
         */
        function selectEndZone(){
            var orgId=$("#toOrganization").attr('data-value');
            dialogOpen({
                id: "startZoneFrom",
                title: '目的运点',
                url: 'jsp/AdjustAccounts/ServerZoneIndex.jsp?orgId='+orgId,
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getServerZone();
                    top.frames[iframeId].dialogClose();//关闭窗口
                    $("#endZone").val(resule.id);
                    $("#endZoneName").val(resule.name);
                }
            });
        }

        /*
        * 选择起运点
        * */
        function selectPoint(value,FHFnumber) {
            dialogOpen({
                id: "ZoneList",
                title: '运点列表',
                url: '/jsp/BaseData/Zone/Index.jsp?status=1',
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getZone();
                    top.frames[iframeId].dialogClose();//关闭窗口
                    if(value==1){
                        $("#startPoint"+FHFnumber).val(resule.id);
                        $("#startPointName"+FHFnumber).val(resule.name);
                    }else{
                        $("#endPoint"+FHFnumber).val(resule.id);
                        $("#endPointName"+FHFnumber).val(resule.name);
                    }

                }
            });
        }


        //打开收发货方 arg 0 是发货方 1是收货方
        function openReceivingParty(self){
           var windo = dialogOpen({
                id: "CustomerFrom",
                title: '收发货方选择',
                url: 'jsp/ReceivingParty/ReceivingPartyIndex.jsp?status=1',
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getReceivingParty();
                    top.frames[iframeId].dialogClose();//关闭窗口
                    var s = self.attr("ForderBy");
                    if(s != null && s != undefined){ //如果是发货方
                        var FHC = $("[ForderBy="+s+"]")
                        FHC.each(function(){
                             if ($(this).attr("name") == "selectName"){
                                $(this).val(resule.name)
                                 var aa = $("#costomerType").attr('data-value');
                                 if(aa == 0){
                                     $("#costomerName1").val(resule.name);
                                 }
                            }
                            if ($(this).attr("name") == "zoneId"){
                                $(this).val(resule['zone.id'])
                            }
                            if ($(this).attr("name") == "zone"){
                                $(this).val(resule['zone.name'])
                            }
                            if ($(this).attr("name") == "contactperson"){
                                $(this).val(resule.contactperson)
                            }
                            if ($(this).attr("name") == "iphone"){
                                $(this).val(resule.iphone)
                            }
                            if ($(this).attr("name") == "address"){
                                $(this).val(resule.address)
                            }
                            if ($(this).attr("name") == "ltl"){
                                $(this).val(resule.ltl)
                            }
                            if ($(this).attr("name") == "detailedAddress"){
                                $(this).val(resule.detailedAddress)
                            }
                        })
                    }
                    var s = self.attr("SorderBy");
                    if(s != null && s != undefined){ //如果是发货方
                        var FHC = $("[SorderBy="+s+"]")
                        FHC.each(function(){
                            if ($(this).attr("name") == "shdanwei"){
                                $(this).val(resule.name)
                            }
                            if ($(this).attr("name") == "zoneId"){
                                $(this).val(resule['zone.id'])
                            }
                            if ($(this).attr("name") == "zone"){
                                $(this).val(resule['zone.name'])
                            }
                           /* if ($(this).attr("name") == "zone"){
                                $(this).ComboBoxTreeSetValue(resule['zone.id'])
                            }*/
                            if ($(this).attr("name") == "contactperson"){
                                $(this).val(resule.contactperson)
                            }
                            if ($(this).attr("name") == "iphone"){
                                $(this).val(resule.iphone)
                            }
                            if ($(this).attr("name") == "address"){
                                $(this).val(resule.address)
                            }
                            if ($(this).attr("name") == "ltl"){
                                $(this).val(resule.ltl)
                            }
                            if ($(this).attr("name") == "detailedAddress"){
                                $(this).val(resule.detailedAddress)
                            }
                        })
                    }
                }
            });
            top.frames["CustomerFrom"].ondblclick=function (){
            }

        }
        function buttonStatus(){
            if(source ){
                $('#order_confirm').hide()
                $('#order_sava').show()
                $('#order_sava').text("确认修改");
                //添加异常框
                $('#price').attr('disabled', 'disabled');
                $('#jsType').attr('disabled', 'disabled');
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
        function initComplete() {
            var listForder = $("[ForderBy]")
            var number = listForder.length / 8 //循环次数
            for (i = 1; i <= number; i++) {
                var em = $("[ForderBy='" + i + "']");
                var obj = {}
                em.each(function () {
                    if ($(this).attr("name") == "name") {
                        initAutoComplete($(this),listForder,"<input type='text' name='selectName' ForderBy = '1'>");
                    }
                });
            }
            var listForder = $("[SorderBy]")
            var number = listForder.length / 8 //循环次数
            for (i = 1; i <= number; i++) {
                var em = $("[SorderBy='" + i + "']");
                var obj = {}
                em.each(function () {
                    if ($(this).attr("name") == "name") {
                        initAutoComplete($(this),listForder,"<input type='text' name='selectName' SorderBy = '1'>");
                    }
                });
            }
        }
        //初始化个控件
        function initAutoComplete(inputObjct,ForderBy,SF) {
            var taur =  inputObjct.tautocomplete({
                width: "1000px",
                columns: ['单位名称', '负责人', '联系电话', '地址', '经纬度','详细地址'],
                data: function () {
                    var sdata = null;
                    $.SetForm({
                        url: "transportorder/queryRP.action",
                        param: { name: taur.searchdata()},
                        success: function (data) {
                            sdata= data;
                        }
                    });
                    return sdata
                },
                onchange: function () {
                    data = taur.forData();
                    ForderBy.each(function(){
                        if ($(this).attr("name") == "name"){
                            $(this).val(data.name)
                        }
                        if ($(this).attr("name") == "contactperson"){
                            $(this).val(data.contactperson)
                        }
                        if ($(this).attr("name") == "iphone"){
                            $(this).val(data.iphone)
                        }
                        if ($(this).attr("name") == "address"){
                            $(this).val(data.address)
                        }
                        if ($(this).attr("name") == "ltl"){
                            $(this).val(data.ltl)
                        }
                        if ($(this).attr("name") == "detailedAddress"){
                            $(this).val(data.detailedAddress)
                        }
                    })
                }
            },null,SF);
        }
        function closeOrder(){
        }
        function selectReceivers(e) {
            var url = '/jsp/CommPlug/GdMap.jsp';
            var ltl = $("#fLtl").val();
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
                    $("#fLtl").val(data.latitude)
                    $("#address").val(data.address)
                    $("#fdetailedAddress").val(data.detailedAddress)
                    top.frames[iframeId].dialogClose();//关闭窗口
                }
            });
        }
        function selectReceivers2(e) {
            var url = '/jsp/CommPlug/GdMap.jsp';
            var ltl = $("#sLtl").val();
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
                    $("#sLtl").val(data.latitude)
                    $("#Saddress").val(data.address)
                    $("#sdetailedAddress").val(data.detailedAddress)
                    top.frames[iframeId].dialogClose();//关闭窗口
                }
            });
        }
        var LODOP; //声明为全局变
        //打印标签
        function printOrderBq(){
            var status = $("#status").val()
//            if(status == 0 || status == 1 ||status ==  '' ||status == undefined || status == null){
//                alert("只能打印订单状态是确认以后的单据")
//                return
//            }
            dialogOpen({
                id: "PrintTag",
                title: '标签打印',
                url: 'jsp/TransportOrder/PrintTag.jsp?id='+keyValue,
                width: "350px",
                height: "350px",
                callBack: function (iframeId) {
                    var obj = top.frames[iframeId].AcceptClick();
                }
            });
        }


//打印信封
        function printOrderXF(){
            var status = $("#status").val()
//            if(status == 0 || status == 1 ||status ==  '' ||status == undefined || status == null){
//                alert("只能打印订单状态是确认以后的单据")
//                return
//            }
            $.SetForm({
                url: "/transportorder/getOrderPrint.action",
                param: {id: keyValue},
                success: function (data) {
                    LODOP=getLodop();
                    LODOP.PRINT_INITA(0,0,1230,1200,"信封打印");
                    LODOP.SET_PRINT_PAGESIZE(1,2300,1600,"B5");
                    LODOP.SET_PRINT_MODE("PRINT_NOCOLLATE",1);
                    LODOP.ADD_PRINT_TEXT(354,19,181,50,data.FHF.name);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(354,201,312,50,data.SHF.address);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(353,511,180,50,data.SHF.iphone);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(422,40,159,49,data.relatebill1);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(423,334,101,49,data.productNmae);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(426,592,131,49,data.number);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(487,119,108,36,data.backNumber);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(482,308,438,46,data.description);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.PREVIEW();
                   // LODOP.PRINT_DESIGN();
                }
            })
        }
// 打印面单
        function printOrder(){
            var status = $("#status").val()
//            if(status == 0 || status == 1 ||status ==  '' ||status == undefined || status == null){
//                alert("只能打印订单状态是确认以后的单据")
//                return
//            }
            CreateOneFormPage();
             LODOP.PREVIEW();
           // LODOP.PRINT_DESIGN();
        }
        function CreateOneFormPage(){
            $.SetForm({
                url: "/transportorder/getOrderPrint.action",
                param: {id: keyValue},
                success: function (data) {
                    LODOP=getLodop();
                    LODOP.PRINT_INITA(0,0,1230,1200,"面单打印");
                    LODOP.SET_PRINT_PAGESIZE(1,2310.0,1270.0,"B5")
                    LODOP.SET_PRINT_MODE("PRINT_NOCOLLATE",1);
                    LODOP.ADD_PRINT_TEXT(36,487,89,30,data.endZone);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",13);
                    LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(36,378,89,30,data.startZone);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",13);
                    LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(43,39,64,27,data.transportPro);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",15);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(46,141,41,22,data.timeYear);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.ADD_PRINT_TEXT(46,180,30,22,data.timeMonht);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.ADD_PRINT_TEXT(46,206,26,22,data.timeDay);
                    LODOP.ADD_PRINT_TEXT(47,295,38,20,data.planArriveTimeYear);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.ADD_PRINT_TEXT(47,329,25,20,data.planArriveTimeMonht);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.ADD_PRINT_TEXT(47,353,28,20,data.planArriveTimeDay);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.ADD_PRINT_TEXT(95,66,78,25,data.FHF.contactperson);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(97,207,139,25,data.FHF.iphone);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",13);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(157,47,241,36,data.FHF.address);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(126,47,243,25,data.FHF.name);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(102,424,78,25,data.SHF.contactperson);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",13);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(157,399,230,36,data.SHF.address);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",13);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(262,60,70,22,data.number);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(127,401,227,25,data.SHF.name);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(237,60,70,22,data.productNmae);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(103,564,139,25,data.SHF.iphone);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",13);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(285,60,64,22,data.weight);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(309,60,69,22,data.volume);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(342,52,70,22,data.value);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(387,36,100,30,data.unit);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(237,145,49,22,data.zongji);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(262,145,53,22,data.提货费);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(287,146,51,22,data.卸货费);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(311,145,50,22,data.保价费);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(340,189,100,22,data.代收货款手续费);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(373,193,100,22,data.zongji);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(400,168,170,27,data.zongjiDZ);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(235,225,52,22,data.包装费);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(286,225,61,22,data.进仓费);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(261,225,58,22,data.送货费);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(310,225,80,22,data.送货上楼费);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(402,339,100,31,data.handoverType);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",13);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(328,429,100,40,data.create_Name);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",15);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(259,451,74,22,data.daishou);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(342,321,78,22,data.zmonthPay);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(235,323,68,22,data.znowPay);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(271,321,68,22,data.zarrivePay);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(305,321,72,22,data.zbackPay);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(235,454,72,22,data.backNumber);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(240,539,120,62,data.description);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    if(data.znowPay != 0){
                        LODOP.ADD_PRINT_TEXT(234,280,22,20,"√");
                    }
                    if(data.zarrivePay != 0){
                        LODOP.ADD_PRINT_TEXT(268,280,21,20,"√");
                    }
                    if(data.zbackPay != 0){
                        LODOP.ADD_PRINT_TEXT(305,281,20,20,"√");
                    }
                    if(data.zmonthPay != 0){
                        LODOP.ADD_PRINT_TEXT(341,282,21,20,"√");
                    }

                    if(data.backNumber != 0){
                        LODOP.ADD_PRINT_TEXT(237,396,23,20,"√");
                    }

                    if(data.daishou != 0 ){
                        LODOP.ADD_PRINT_TEXT(260,397,21,20,"√");
                    }
                }
            })
        };
        //计算台账费用
        function jisuanyunfei() {
            if(!source ){ //如果是异常修改，则不生效
            var dj = $("#price").val();
            var jsfs = $('input:radio[name="jsType"]:checked').val();
            if(jsfs == null || jsfs ==undefined || dj ==null || dj ==""){
                return
            }

            var hp = $('#gridTable').getRowData();
            var je = $('#gridTable2').getRowData();
            var zvolume =0.0;
            var zweight =0.0;
            var znumber =0.0;
            for(var i=0;i<hp.length;i++){
                var hpmx=hp[i]; //货品明细
                zvolume += hpmx.volume;
                zweight += hpmx.weight;
                znumber += hpmx.number;
            }
            var feeTypeIndex; //索引
            var jiesuan = $("#feeType").attr('data-value');
            var panding = false;
            var amount = 0.0;
             for(var i=0;i<je.length;i++){//循环取出运费
                var jemx = je[i];
                if(jemx['feeType.id'] =='402881b4665bdc8601665c7d29730014'){
                    feeTypeIndex = i;
                    panding = true;
                    break;
                }
            }
            if(panding){
                $('#gridTable2').clearGridData();
                if(jsfs == 0){//按重量计费
                    amount =zweight * dj;
                    amount = amount.toFixed(3);
                    je[feeTypeIndex].amount = amount;
                  var tax =  je[feeTypeIndex].taxRate;
                    var input= amount/(1+tax)*tax;
                    je[feeTypeIndex].input = input.toFixed(3);
                    je[feeTypeIndex].income = (amount-input).toFixed(3);
                      if(jiesuan == 0){//月结
                          je[feeTypeIndex].monthPay = amount;
                          je[feeTypeIndex].nowPay = 0.00;
                          je[feeTypeIndex].arrivePay =0.00;
                          je[feeTypeIndex].backPay = 0.00;
                         }
                      if(jiesuan == 1){//现结
                    je[feeTypeIndex].nowPay = amount;
                    je[feeTypeIndex].monthPay = 0.00;
                    je[feeTypeIndex].arrivePay =0.00;
                    je[feeTypeIndex].backPay = 0.00;
                        }
                      if(jiesuan == 2 ){//到付
                    je[feeTypeIndex].arrivePay = amount;
                    je[feeTypeIndex].nowPay = 0.00;
                    je[feeTypeIndex].monthPay = 0.00;
                    je[feeTypeIndex].backPay = 0.00;
                       }
                    if(jiesuan == 3){//回付
                    je[feeTypeIndex].backPay = amount;
                    je[feeTypeIndex].arrivePay = 0.00;
                    je[feeTypeIndex].nowPay = 0.00;
                    je[feeTypeIndex].monthPay = 0.00;
                       }
                }else if(jsfs == 1){//按件数计费
                    amount =znumber * dj;
                    amount = amount.toFixed(3);
                    je[feeTypeIndex].amount = amount;
                    var tax =  je[feeTypeIndex].taxRate;
                    var input= amount/(1+tax)*tax;
                    je[feeTypeIndex].input = input.toFixed(3);
                    je[feeTypeIndex].income = (amount-input).toFixed(3);
                    if(jiesuan == 0){//月结
                        je[feeTypeIndex].monthPay = amount;
                        je[feeTypeIndex].nowPay = 0.00;
                        je[feeTypeIndex].arrivePay =0.00;
                        je[feeTypeIndex].backPay = 0.00;
                    }
                    if(jiesuan == 1){//现结
                        je[feeTypeIndex].nowPay = amount;
                        je[feeTypeIndex].monthPay = 0.00;
                        je[feeTypeIndex].arrivePay =0.00;
                        je[feeTypeIndex].backPay = 0.00;
                    }
                    if(jiesuan == 2 ){//到付
                        je[feeTypeIndex].arrivePay = amount;
                        je[feeTypeIndex].nowPay = 0.00;
                        je[feeTypeIndex].monthPay = 0.00;
                        je[feeTypeIndex].backPay = 0.00;
                    }
                    if(jiesuan == 3){//回付
                        je[feeTypeIndex].backPay = amount;
                        je[feeTypeIndex].arrivePay = 0.00;
                        je[feeTypeIndex].nowPay = 0.00;
                        je[feeTypeIndex].monthPay = 0.00;
                    }
                }else if(jsfs == 2){//按体积计费
                    amount =zvolume * dj;
                    amount = amount.toFixed(3);
                    je[feeTypeIndex].amount = amount;
                    var tax =  je[feeTypeIndex].taxRate;
                    var input= amount/(1+tax)*tax;
                    je[feeTypeIndex].input = input.toFixed(3);
                    je[feeTypeIndex].income = (amount-input).toFixed(3);
                    if(jiesuan == 0){//月结
                        je[feeTypeIndex].monthPay = amount;
                        je[feeTypeIndex].nowPay = 0.00;
                        je[feeTypeIndex].arrivePay =0.00;
                        je[feeTypeIndex].backPay = 0.00;
                    }
                    if(jiesuan == 1){//现结
                        je[feeTypeIndex].nowPay = amount;
                        je[feeTypeIndex].monthPay = 0.00;
                        je[feeTypeIndex].arrivePay =0.00;
                        je[feeTypeIndex].backPay = 0.00;
                    }
                    if(jiesuan == 2 ){//到付
                        je[feeTypeIndex].arrivePay = amount;
                        je[feeTypeIndex].nowPay = 0.00;
                        je[feeTypeIndex].monthPay = 0.00;
                        je[feeTypeIndex].backPay = 0.00;
                    }
                    if(jiesuan == 3){//回付
                        je[feeTypeIndex].backPay = amount;
                        je[feeTypeIndex].arrivePay = 0.00;
                        je[feeTypeIndex].nowPay = 0.00;
                        je[feeTypeIndex].monthPay = 0.00;
                    }
                }
                $('#gridTable2').addRowData(getUUID(),je,"first");
            }
            }
        }
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <div class="tab-content" style="padding-top: 15px;width: 1160px">
            <table class="form">
                <H4 id =  "ystitle" style="text-align:center">运输订单管理</H4>
                <hr style="margin:10px;height:3px;border:none;border-top:1px double #008080;" />
                <input id="id" name="id" autocomplete="off"  type="hidden" />
                <input id="loadingMethod" autocomplete="off" name="loadingMethod" type="hidden" value="1"/>
                <input id="status" autocomplete="off" name="status" type="hidden" />
                <input id="plan" autocomplete="off" name="plan" type="hidden" />
                <input id="isTake" autocomplete="off" name="isTake" type="hidden" />
                <tr>
                    <td class="formTitle">订单号</td>
                    <td class="formValue">
                        <input id="code" type="" autocomplete="off" class="form-control" disabled = "disabled"  placeholder="系统自动生成" readonly="readonly"  />
                    </td>
                    <td class="formTitle">发货单号<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="relatebill1" autocomplete="off"  type="text" class="form-control" isvalid="yes"  checkexpession="NotNull" />
                    </td>
                    <td class="formTitle">客户单号</td>
                    <td class="formValue">
                        <input id="relatebill2" autocomplete="off"  type="text" class="form-control"/>
                    </td>
                    <td class="formTitle">开单日期<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="time" type="text"  placeholder="请选择订单时间"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                    </td>

                </tr>
                <tr>
                    <td class="formTitle">客户类型<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="costomerType" type="select" onchange="changeCostomerType()" class="ui-select" isvalid="yes" checkexpession="NotNull">
                            <ul>
                            </ul>
                        </div>
                    </td>
                    <td class="formTitle">客户名称</td>
                    <td class="formValue" id="hetongShow">
                        <input id="costomer" autocomplete="off"  type="hidden" class="form-control" value=""/>
                        <input id="costomerName" autocomplete="off" onclick="selectCustomer()" readonly type="text"  class="form-control" />
                        <span class="input-button" onclick="selectCustomer()" title="请选择合同" >.......</span>
                    </td>
                    <td id="lingsanShow">
                        <input id="costomerName1" autocomplete="off" type="text"  class="form-control" />
                    </td>
                   <%-- <td class="formTitle">项目名称</td>
                    <td class="formValue">
                        <div id="projectManagement" type="select" class="ui-select" disabled = "disabled"  isvalid="no" checkexpession="NotNull"><ul> </ul> </div>
                    </td>--%>
                    <td class="formTitle">交付方式<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="handoverType" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                            <ul>
                            </ul>
                        </div>
                    </td>
                    <td class="formTitle"><font face="宋体">*</font>入库区域</td>
                    <td class="formValue">
                        <div id="zoneStoreroom" type="select" class="ui-select"  isvalid="yes" checkexpession="NotNull">
                            <ul>
                            </ul>
                        </div>
                    </td>

                </tr>
                <tr>
                    <td class="formTitle">出发运点<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="startZone" autocomplete="off" type="hidden" class="form-control" value=""/>
                        <input id="startZoneName" autocomplete="off" onclick="selectStartZone()" readonly type="text"  class="form-control" isvalid="yes" checkexpession="NotNull"  />
                        <span class="input-button" onclick="selectStartZone()" title="请选择出发运点" >.......</span>
                    </td>
                    <td class="formTitle">目的网点<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="toOrganization" type="select" class="ui-select" type="hidden" class="form-control" value=""/>
                        <%--<input id="toOrganizationName" autocomplete="off" onclick="selectOrg()" readonly type="text"  class="form-control" isvalid="yes" checkexpession="NotNull" />--%>
                        <%--<span class="input-button" onclick="selectOrg()" title="请选择目的网点" >.......</span>--%>
                    </td>
                    <td class="formTitle">目的运点<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="endZone" autocomplete="off" type="hidden" class="form-control" value=""/>
                        <input id="endZoneName" autocomplete="off" onclick="selectEndZone()" readonly type="text"  class="form-control" isvalid="yes" checkexpession="NotNull" />
                        <span class="input-button" onclick="selectEndZone()" title="请选择目的运点" >.......</span>
                    </td>
                    <td class="formTitle">结算方式<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="feeType" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull"></div>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">要求发运时间</td>
                    <td class="formValue">
                        <input id="planLeaveTime" autocomplete="off"  type="text" readonly="readonly" class="form-control input-wdatepicker"  onfocus="WdatePicker()"/>
                    </td>
                    <td class="formTitle">要求运抵时间</td>
                    <td class="formValue">
                        <input id="planArriveTime" autocomplete="off"  type="text"  readonly="readonly" class="form-control input-wdatepicker"   onfocus="WdatePicker()"/>
                    </td>


                    <td class="formTitle">发运时间</td>
                    <td class="formValue">
                        <input id="factArriveTime" autocomplete="off"  type="text" class="form-control" disabled />
                    </td>
                    <td class="formTitle">运抵时间</td>
                    <td class="formValue">
                        <input id="factLeaveTime" autocomplete="off"  type="text" class="form-control" disabled/>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">销售负责人<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="salePersion" autocomplete="off" type="text"  class="form-control" isvalid="yes"  checkexpession="NotNull" />
                    </td>
                    <td class="formTitle">运输性质<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="transportPro" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                        </div>
                    </td>
                    <td class="formTitle">是否回单</td>
                    <td class="formValue">
                        <div id="isBack" name = "isBack" class="radio" onchange="changeIsBack()"  type="radio"/>
                    </td>
                    <td class="formTitle">回单份数</td>
                    <td class="formValue">
                        <input id="backNumber" autocomplete="off" type="text" value="0" disabled = "disabled"  class="form-control"
                               isvalid="yes"  checkexpession="IsInterOrNull"/>
                    </td>
                </tr>

                <td colspan="8">
                <hr style="margin:3px;height:3px;border:none;border-top:1px double #008080"  />
                 </td>
                    <div id = "FHF" >
                    <tr>
                        <td class="formTitle"></span>发货单位<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input name="id"  autocomplete="off" ForderBy = "1" type="hidden" />
                            <input name="type"  autocomplete="off" ForderBy = "1" value = "0" type="hidden" />
                            <input name = "name" id = "fname"  autocomplete="off" ForderBy = "1" class="form-control" placeholder="请输入或选择发货方单位" />
                            <span class="input-button" ForderBy = "1" onclick="openReceivingParty($(this))" title="请选择发货方" >.......</span>
                        </td>
                        <td class="formTitle">发货人<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input ForderBy = "1" autocomplete="off" id="fcontactperson" name = "contactperson" type="text" class="form-control" placeholder="请输入发货人" isvalid="yes"
                                   checkexpession="NotNull"/>
                        </td>
                        <td class="formTitle">联系电话<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input ForderBy = "1" autocomplete="off" id="fiphone" name = "iphone" type="text" class="form-control" placeholder="请输入联系电话" isvalid="yes"
                                   checkexpession="NotNull"/>
                        </td>

                    </tr>
                    <tr>
                        <td class="formTitle">发货地址<font face="宋体">*</font></td>
                        <td class="formValue" >
                            <input ForderBy = "1" id = "faddress" name="address" autocomplete="off"  type="text"   class="form-control" placeholder="请输入发货地址" isvalid="yes"
                                   checkexpession="NotNull"> </input>
                            <span class="input-button" ForderBy = "1" onclick="selectReceivers()" title="选择地址" ><i class="fa fa-map-pin"></i></span>
                        </td>
                        <td class="formTitle">经纬度<font face="宋体">*</font></td>
                        <td class="formValue" >
                            <input ForderBy = "1"  id="fLtl" name="ltl"  type="" class="form-control"  placeholder="经纬度为空" isvalid="yes"
                                   checkexpession="NotNull"> </input>
                        </td>
                        <td class="formTitle">详细地址<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input ForderBy = "1" style="width: 450px" id="fdetailedAddress" name="detailedAddress"  type="" class="form-control"   placeholder="经纬度为空" isvalid="yes"
                                   checkexpession="NotNull"> </input>
                        </td>
                    </tr>
                    <tr id="FHGML"></tr>
                </div>
                <td colspan="8">
                    <hr style="margin:3px;height:3px;border:none;border-top:1px double #008080"  />
                </td>
                <div id = "SHF">
                    <tr>
                        <td class="formTitle">收货单位<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input name="id" autocomplete="off" SorderBy = "1" type="hidden" />
                            <input name="type" autocomplete="off" SorderBy = "1" value = "0" type="hidden" />
                            <input  id = "shdanwei" name = "shdanwei"  autocomplete="off"  SorderBy = "1" type="text" class="form-control" placeholder="请输入或选择收货方单位"/>
                            <span class="input-button" SorderBy = "1" onclick="openReceivingParty($(this))" title="请选择发货方" >.......</span>
                        </td>
                        <td class="formTitle">收货人<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input SorderBy = "1" id="shcontactperson" autocomplete="off" name =  "contactperson" type="text" class="form-control" placeholder="请输入收货人" isvalid="yes"
                                   checkexpession="NotNull"/>
                        </td>
                        <td class="formTitle">联系电话<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input SorderBy = "1" id = "shiphone" autocomplete="off" name = "iphone" type="text" class="form-control" placeholder="请输入联系电话" isvalid="yes"
                                   checkexpession="NotNull"/>
                        </td>

                    </tr>
                    <tr>
                        <td class="formTitle">收货地址<font face="宋体">*</font></td>
                        <td class="formValue" >
                            <input SorderBy = "1" id = "shaddress" name="address" autocomplete="off" type="text"   class="form-control" placeholder="请输入发货地址" isvalid="yes"
                                   checkexpession="NotNull"> </input>
                            <span class="input-button" SorderBy = "1" onclick="selectReceivers2()" title="选择地址" ><i class="fa fa-map-pin"></i></span>
                        </td>
                        <td class="formTitle">经纬度<font face="宋体">*</font></td>
                        <td class="formValue">
                        <input SorderBy = "1" id="shltl"  name="ltl"  type="" class="form-control"   placeholder="经纬度为空" isvalid="yes"
                               checkexpession="NotNull"> </input>
                    </td>
                        <td class="formTitle">详细地址<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input SorderBy = "1" style="width: 450px" id="shdetailedAddress" name="detailedAddress"  type="" class="form-control"   placeholder="经纬度为空" isvalid="yes"
                                   checkexpession="NotNull"> </input>
                        </td>
                    </tr>
                    <tr id="SFHGML"></tr>
                </div>
                <td colspan="8">
                    <hr style="margin:3px;height:3px;border:none;border-top:1px double #008080"  />
                </td>
                <tr >
                    <td class="formValue" colspan="8">
                        <table id="gridTable"></table>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">单价</td>
                    <td class="formValue">
                        <input id="price" value="0" onchange="jisuanyunfei()" autocomplete="off" type="text"  class="form-control" />
                    </td>
                    <td class="formTitle"></td>
                    <td class="formValue">
                        <div id="jsType" onchange="jisuanyunfei()" type="radio" class="radio"></div>
                    </td>
                    <td class="formTitle">规则名称</td>
                    <td class="formValue">
                        <input id="ruleName"  readonly autocomplete="off" type="text"  class="form-control" />
                    </td>
                    <td class="formValue">
                    <a id="ossrder_sava" class="btn btn-success" onclick="ruleRun()">计算规则</a>
                    </td>
                </tr>
                <td colspan="8">
                    <hr style="margin:3px;height:3px;border:none;border-top:1px double #008080"  />
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
                        <textarea id="description" class="form-control" ></textarea>
                    </td>
             </tr>

            </table>
            <div id="bottomField" class="ordermanage">
                <%--<a id="replace" class="btn btn-default" onclick="closeOrder()">关闭</a>--%>
                <a id="order_sava" class="btn btn-success" onclick="AcceptClick()">预存订单</a>
                <a id="order_confirm" class="btn btn-warning" onclick="confirm();">确认订单</a>
                <a id="order_print" class="btn btn-default" onclick="printOrder()">打印单据</a>
                <a id="order_printBQ" class="btn btn-default" onclick="printOrderBq()">打印标签</a>
                <a id="order_printXF" class="btn btn-default" onclick="printOrderXF()">打印信封</a>
                <script>$('.ordermanage').authorizeButton()</script>
            </div>
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
    /*adfjio*/
    /*表格虚线*/
    .ui-jqgrid tr.jqgrow td{
        border-width: 0.05px;border-right-style: dashed ;border-right-color: #bbc0d0;font-weight: normal;overflow: hidden;white-space: pre;line-height:25px;height: 25px;padding: 0 5px 0 5px;

    }
</style>
</body>
</html>