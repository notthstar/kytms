<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/3/10
  Time: 9:27
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
    <title>新增订单</title>
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
    <%--高德导航--%>
    <link href="/Content/styles/jet-gd.css" rel="stylesheet"/>
    <%--<script src="/Content/scripts/utils/jet-gdutil.js?v=1.3&key=49df3dbb93cc593e8cceedfe8f8be185"></script>--%>
    <script src="https://webapi.amap.com/maps?v=1.3&key=49df3dbb93cc593e8cceedfe8f8be185"></script>
    <script src="/Content/scripts/utils/jet-gd.js"></script>
</head>
<body>

<form id="form1" style="height: 1000px;width: 1000px;">

    <script>
        var keyValue = request('keyValue');
        var source = request('source'); //如果是异常单
        var instanceId = "";
        var formId = "";
        $(function () {
            initControl();
        })
        //初始化控件
        function initControl() {
            initFeeType();//初始化费用
            $("#costomerType").ComboBox({ //客户类型
                description: "=请选择客户类型=",
                height: "200px",
                data: top.clientdataItem.CustomerType
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

            $("#Qzone").ComboBoxTree({
                    url: "zone/getCity.action",
                    description: "==请选择城市==",
                    height: "200px",
                    allowSearch:true
              });
            $("#SQzone").ComboBoxTree({
                url: "zone/getCity.action",
                description: "==请选择城市==",
                height: "200px",
                allowSearch:true
            });
            getMapData();
            getMapDataFroId("Saddress");
            //获取表单

            if (!!keyValue) {
               getOrder();
            }else {
                GetGrid(); //初始化货品明细
                showDate("time"); //初始化时间
                $("#transportPro").ComboBoxSetValue(0);
                $("#feeType").ComboBoxSetValue(1);
                $("#costomerType").ComboBoxSetValue(0);
                $("#shipmentMethod").ComboBoxSetValue(0);
                //$("#taxRate").ComboBoxSetValue('0.11');
                addJgGirdNullData();
                buttonStatus() //初始化按钮
            }
        }
        /**编辑初始化*/
        function getOrder(){
            $.SetForm({
                url: "/transportorder/getOrder.action",
                param: {id: keyValue},
                success: function (data) {
                        $("#id").val(data.id), //处理单头
                        $("#code").val(data.code),
                        $("#status").val(data.status),
                        $("#relatebill1").val(data.relatebill1),
                        $("#orderMileage").val(data.orderMileage),
                        $("#time").val(data.time),
                        $("#feeType").ComboBoxSetValue(data.feeType),
                        $("#costomerType").ComboBoxSetValue(data.costomerType);
                            if(data.customer != null){
                                $("#costomer").val(data.customer.id);
                                $("#costomerName").val(data.customer.name)
                            };
                        if(data.projectManagement != null){
                            $("#projectManagement").ComboBox({ //项目名称
                                height: "200px",
                                url:'/projectManagement/getProjectManagement.action',
                                param:{id:data.customer.id},
                            });
                            $("#projectManagement").ComboBoxSetValue(data.projectManagement.id);
                        };
                        if(data.plan != null){
                            $("#plan").val(data.plan.id);
                            $("#planName").val(data.plan.name)
                        };
                        $("#transportPro").ComboBoxSetValue(data.transportPro),
                        $("#loadingMethod").val(data.loadingMethod),
                        $("#shipmentMethod").ComboBoxSetValue(data.shipmentMethod),
                        $("#salePersion").val(data.salePersion),
                        $("input:radio[name='isBack'][value='"+data.isBack+"']").attr("checked","checked")
                        $("#backNumber").val(data.backNumber),
                        $("input:radio[name='isBilling'][value='"+data.isBilling+"']").attr("checked","checked")
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
                    //收发伙房处理工具
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
                              if ($(this).attr("name") == "planLeaveTime"){
                                  $(this).val(s.planLeaveTime);
                              }
                              if ($(this).attr("name") == "factLeaveTime"){
                                  $(this).val(s.factLeaveTime);
                              }
                              if ($(this).attr("name") == "name"){
                                  $(this).val(s.name);
                              }
                              if ($(this).attr("name") == "zone"){
                                  $(this).ComboBoxSetValue(s.zone.id)
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
                          })
                      }
                    }
                        //处理货品信息
                    GetGrid(); //初始化货品明细
                    var $JGGRID = $("#gridTable");
                    $JGGRID.jqGrid("clearGridData"); //清空数据
                    $JGGRID.setGridHeight(0)
                    if(data.orderProducts != null){
                        $JGGRID.setGridHeight($JGGRID.getGridParam("height") + 28 * data.orderProducts.length)
                        $JGGRID.addRowData(getUUID(),data.orderProducts,"first");
                    }
                    //处理台账
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
                                buttonStatus() //初始化按钮
//                                var html ="";
//                                html += '<tr>'
//                                for(j=0;j<ledtdetail.length;j++){
//                                    var s = ledtdetail[j];
//                                    if(s == 6 || s==11 || s==16 || s==21){
//                                    html += '</tr>'
//                                        html += '<tr>'
//                                     }
//                                        html+= ' <td class="formTitle">'+s.feeType.name+'</td>'
//                                        html+= '<td class="formValue" >'
//                                        html+='<input id="'+s.feeType.id+'" value = '+s.amount+' name = "fee" type="number" onchange="sumFee()" isCount="'+s.feeType.isCount+'" STYLE="width: 120px;text-align:center"  value="0" class="form-control"/>'
//                                        html+= '</td>'
//                                }
//                                html += '</tr>'
//                                $("#feeTypeClass").prepend(html);
                            }

                        }

                    }


                }
            });
            orderLock() //编辑锁死
        }



        /**
         * 添加货品明细空数据
         */

        function addJgGirdNullData (){
            var model={
                id:null,
                name:null,
                number:0,
                weight:0,
                volume:0,
                value:0,
                description:null,

            }
            var $JGGRID = $("#gridTable")
            $JGGRID.setGridHeight($JGGRID.getGridParam("height") + 28)
//            $JGGRID.jqGrid("addRowData",null,"first");
            $JGGRID.addRowData(getUUID(),model,"first");
        }
        /**
         * 删除货品明细空数据
         */
        function deleteJgGirdNullData (data){
           var $JGGRID = $("#gridTable");
            data.parent().parent().remove();
            $JGGRID .setGridHeight($JGGRID.getGridParam("height") - 28)
        }
        //保存订单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var order ={ //处理单头信息
                id:$("#id").val(),
                code:$("#code").val(),
                status:$("#status").val(),
                relatebill1:$("#relatebill1").val(),
                orderMileage:$("#orderMileage").val(),
                time:$("#time").val(),
                feeType:$("#feeType").attr('data-value'),
                costomerType:$("#costomerType").attr('data-value'),

                customer:{id :$("#costomer").val()},
                projectManagement:{id :$("#projectManagement").attr('data-value')},
                transportPro:$("#transportPro").attr('data-value'),
                loadingMethod:$("#loadingMethod").val(),
                shipmentMethod:$("#shipmentMethod").attr('data-value'),
                salePersion:$("#salePersion").val(),
                isBack:$('input:radio[name="isBack"]:checked').val(),
                backNumber:$("#backNumber").val(),
                isBilling:$('input:radio[name="isBilling"]:checked').val(),
                plan:{id :$("#plan").val()}
            }

            var list = new Array();
            //处理收发货方
            var listForder = $("[ForderBy]")
            var number = listForder.length / 11 //循环次数
            for(i = 1;i<=number;i++){
                var em = $("[ForderBy='"+i+"']");
                var obj ={}
                    em.each(function(){
                      obj['orderBy'] = i;
                      obj['type'] = 0;
                     if ($(this).attr("name") == "id"){
                            obj['id'] = $(this).val();
                     }
                    if ($(this).attr("name") == "planLeaveTime"){
                        obj['planLeaveTime'] = $(this).val();
                     }
                    if ($(this).attr("name") == "factLeaveTime"){
                        obj['factLeaveTime'] = $(this).val();
                    }
                    if ($(this).attr("name") == "name"){
                        obj['name'] = $(this).val();
                    }
                    if ($(this).attr("name") == "zone"){
                        var value = $(this).attr('data-value');
                        if(value != null && value != "" && value != undefined){
                            obj['zone'] = {id:value}
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
                })
                list.push(obj)
            }
            var listSorder = $("[SorderBy]")
            var number = listSorder.length / 11 //循环次数
            for(i = 1;i<=number;i++){
                var em = $("[SorderBy='"+i+"']");
                var obj ={}
                em.each(function(){
                    obj['orderBy'] = i;
                    obj['type'] = 1;
                    if ($(this).attr("name") == "id"){
                        obj['id'] = $(this).val();
                    }
                    if ($(this).attr("name") == "planLeaveTime"){
                        obj['planLeaveTime'] = $(this).val();
                    }
                    if ($(this).attr("name") == "factLeaveTime"){
                        obj['factLeaveTime'] = $(this).val();
                    }
                    if ($(this).attr("name") == "name"){
                        obj['name'] = $(this).val();
                    }
                    if ($(this).attr("name") == "zone"){
                        var value = $(this).attr('data-value');
                        if(value != null && value != "" && value != undefined){
                            obj['zone'] = {id:value}
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
                })
                list.push(obj)
            }
            order['orderReceivingParties'] = list
            //处理货品明细
            var jggirdData = $('#gridTable').jqGrid("getRowData");
            order['orderProducts'] = jggirdData;
            //处理费用类型
            var ledgers = new Array(); //台账
            var LedgerDetails = new Array(); //台账
            var ledger = {
                amount:$("#amount").val(),
                taxRate:$('input:radio[name="taxRate"]:checked').val(),
                input:$("#input").val(),
                type:0,
                cost:0
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
            order['ledgers'] = ledgers
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
                        dialogClose();//关闭窗口
                    } else {
                        dialogAlert(data.obj, -1);
                    }
                }
            })
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
                height: 0,
                autowidth: true,
                cellEdit:true,
                cellsubmit:"clientArray",
                colModel: [
                    { label: "主键", name: "id", index: "id", hidden: true },
                    { label: "货品名称", name: "name",  width: 200,resizable:false, align: "center",editable:true},
                    { label: "单位", name: "unit",  width: 100,resizable:false, align: "center",editable:true},
                    { label: "数量", name: "number",  index: "target", resizable:false, width: 130, align: "center",edittype: "text",editable:true ,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "重量", name: "weight", index: "url",resizable:false,  width: 130, align: "center" ,edittype: "text",editable:true ,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "体积", name: "volume", index: "orderBy",resizable:false,  width: 130, align: "center" ,edittype: "text",editable:true ,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "货值", name: "value", index: "description",resizable:false,  width: 130, align: "center" ,edittype: "text",editable:true,editrules: { required: true, custom:true, custom_func: numberValidator}, },
                    { label: "备注信息", name: "description", resizable:false, index: "description", width: 200,edittype: "text", align: "center" ,editable:true },
                    { label: '<button type="button" onclick="addJgGirdNullData()" class="btn btn-success btn-xs">添加货品</button>',   sortable: false, width: 40, align: "center",
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
                afterSaveCell:function(){
                    var number = $(this).getCol("number", false, "sum");
                    var weight = $(this).getCol("weight", false, "sum");
                    var volume = $(this).getCol("volume", false, "sum");
                    var value = $(this).getCol("value", false, "sum");
                    //合计
                    $(this).footerData("set", {
                        "name": "合计：",
                        "number": "数量:" + number,
                        "weight": "重量:" + weight,
                        "volume": "体积:" + volume,
                        "value": "货值:" + value,
                    });
                },
                gridComplete: function () {
                    var number = $(this).getCol("number", false, "sum");
                    var weight = $(this).getCol("weight", false, "sum");
                    var volume = $(this).getCol("volume", false, "sum");
                    var value = $(this).getCol("value", false, "sum");
                    //合计
                    $(this).footerData("set", {
                        "name": "合计：",
                        "number": "数量:" + number,
                        "weight": "重量:" + weight,
                        "volume": "体积:" + volume,
                        "value": "货值:" + value,
                    });
                },
            });
        }


        function changeCostomerType(){ //合同客户和零散客户切换，所带来的数据变更合同客户，订单必须选择合同方
            var value = $("#costomerType").attr('data-value');
            if(value == 0){
                $("#costomerName").attr('disabled',true);
                $("#projectManagement").attr('disabled',true);
                $("#projectManagement").attr("isvalid","yes");
            }else{
                $("#costomerName").removeAttr('disabled');
                $("#projectManagement").attr("isvalid","no");
                $("#projectManagement").removeAttr('disabled');
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
        function getlal(address,self) { //发货
            var s = getNClnl(address,self);
            if (s) {
                return;
            }
        }
        function Sgetlal(address,self) { //s收货
            var s = getNClnl(address,self);
            if (s) {
                return;
            }
        }
        function getNClnl(address,self) {
            var address = address
            AMap.service('AMap.Geocoder', function (){//回调函数
                geocoder = new AMap.Geocoder({
                });
                geocoder.getLocation(address, function (status, result) {
                    if (status === 'complete' && result.info === 'OK') {
                        var add = result.geocodes[0].location.lng + ',' + result.geocodes[0].location.lat;
                        if (add == undefined) {
                            alert("地址查询失败")
                            return false;
                        } else {
                            self.parent().next().children().val(add);
                            return true;
                        }
                    } else {
                        ValidationMessage(self,"经纬度查询失败")
                        return false;
                    }
                });
            })
        }
        function deleteFHF(self){
            var s = self.parent().parent().parent();
            var b = s.next();
            s.remove();
            b.remove()
        }
        var FHFnumber=1;
        function addFHF(self,int){
            if(int){
                FHFnumber =int;
            }
            FHFnumber++;
            var html ='<tr>'
            html =html +'<td class="formTitle"><span style="margin-right: 5px"><i onclick="deleteFHF($(this))" class="fa fa-minus-square-o" ></i></span>发货单位<font face="宋体">*</font></td>'
            html =html +'<td class="formValue">'
            html =html +'<input ForderBy = "'+FHFnumber+'" name = "name" class="form-control" placeholder="请输入或选择发货方单位" isvalid="yes"'
            html =html +'checkexpession="NotNull"/>'
            html =html +'  <span class="input-button" ForderBy =  "'+FHFnumber+'" onclick="openReceivingParty($(this))" title="请选择合同" >.......</span>'
            html =html +'    </td>'
            html =html +'    <input ForderBy = "'+FHFnumber+'" name="id" type="hidden" />'
            html =html +'    <input ForderBy = "'+FHFnumber+'" name="type" value = "0" type="hidden" />'
            html =html +'    <td class="formTitle">起运城市<font face="宋体">*</font></td>'
            html =html +'    <td class="formValue">'
            html =html +'    <div ForderBy ="'+FHFnumber+'" id="Qzone" name = "zone"  type="select" class="ui-select" isvalid="yes"  checkexpession="NotNull">'
            html =html +'    <ul>'
            html =html +'    </ul>'
            html =html +'    </div>'
            html =html +'    </td>'
            html =html +'    <td class="formTitle">发货人<font face="宋体">*</font></td>'
            html =html +'    <td class="formValue">'
            html =html +'    <input ForderBy = "'+FHFnumber+'" name = "contactperson" type="text" class="form-control" placeholder="请输入发货人" isvalid="yes"'
            html =html +'checkexpession="NotNull"/>'
            html =html +'    </td>'
            html =html +'    <td class="formTitle">联系电话<font face="宋体">*</font></td>'
            html =html +'    <td class="formValue">'
            html =html +'    <input ForderBy = "'+FHFnumber+'" name = "iphone" type="text" class="form-control" placeholder="请输入联系电话" isvalid="yes"'
            html =html +'checkexpession="NotNull"/>'
            html =html +'    </td>'
            html =html +'    </tr>'
            html =html +'    <tr>'
            html =html +'    <td class="formTitle">发货地址<font face="宋体">*</font></td>'
            html =html +'    <td class="formValue" colspan="2">'
            html =html +'    <input ForderBy = "'+FHFnumber+'" id = "address" name="address"   onblur="getlal($(this).val(),$(this))" type="text"  STYLE="width: 340px" class="form-control" placeholder="请输入发货地址" isvalid="yes"'
            html =html +'checkexpession="NotNull"> </input>'
            html =html +'    </td>'
            html =html +'    <td class="formValue" colspan="1">'
            html =html +'    <input ForderBy = "'+FHFnumber+'" name="ltl" STYLE="width: 120px;margin-left: 71px" type="" class="form-control" disabled="disabled" placeholder="经纬度为空" isvalid="yes"'
            html =html +'checkexpession="NotNull"> </input>'
            html =html +'    </td>'
            html =html +'    <td class="formTitle">要求发运时间<font face="宋体">*</font></td>'
            html =html +'    <td class="formValue">'
            html =html +'    <input ForderBy = "'+FHFnumber+'" id="planLeaveTime" name="planLeaveTime" type="text"  readonly="readonly"   class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>'
            html =html +'    </td>'
            html =html +'    <td class="formTitle">实际发运时间</td>'
            html =html +'    <td class="formValue">'
            html =html +'    <input ForderBy = "'+FHFnumber+'" name = "factLeaveTime" type="text" class="form-control" disabled = "disabled"  placeholder="暂未发运……"  />'
            html =html +'    </td>'
            html =html +'    </tr>'
            $("#FHGML").before(html)
            //初始化信息
            var s = $("#FHGML").prev().find("[name='address']");
            var uuid =getUUID();
            s.attr('id',uuid);
            getMapDataFroId(uuid);

            var a =  $("#FHGML").prev().prev().find("[name='zone']");//初始化城市信息
                    a.ComboBoxTree({
            url: "zone/getCity.action",
            description: "==请选择城市==",
            height: "200px",
            allowSearch:true
        });
        }
        function SdeleteFHF(self){
            var s = self.parent().parent().parent();
            var b = s.next();
            s.remove();
            b.remove()
        }
        var SHFnumber =1;
        function SaddFHF(self,int){
                if(int){
                    FHFnumber =int;
                }
            SHFnumber++
            var html ='<tr>'
            html =html +'<td class="formTitle"><span style="margin-right: 5px"><i onclick="SdeleteFHF($(this))" class="fa fa-minus-square-o" ></i></span>收货单位<font face="宋体">*</font></td>'
            html =html +'<td class="formValue">'
            html =html +'    <input SorderBy =  "'+SHFnumber+'" name="id" type="hidden" />'
            html =html +'    <input SorderBy = "'+SHFnumber+'" name="type"  value = "1" type="hidden"/>'
            html =html +'<input SorderBy ="'+SHFnumber+'" name = "name" class="form-control" placeholder="请输入或选择收货方单位" isvalid="yes"'
            html =html +'checkexpession="NotNull"/>'
            html =html +'  <span class="input-button" SorderBy =  "'+SHFnumber+'" onclick="openReceivingParty($(this))" title="请选择合同" >.......</span>'
            html =html +'    </td>'
            html =html +'    <td  class="formTitle">目的城市<font face="宋体">*</font></td>'
            html =html +'    <td class="formValue">'
            html =html +'    <div SorderBy = "'+SHFnumber+'" id="SQzone" name = "zone"  type="select" class="ui-select" isvalid="yes"  checkexpession="NotNull">'
            html =html +'    <ul>'
            html =html +'    </ul>'
            html =html +'    </div>'
            html =html +'    </td>'
            html =html +'    <td class="formTitle">收货人<font face="宋体">*</font></td>'
            html =html +'    <td class="formValue">'
            html =html +'    <input SorderBy ="'+SHFnumber+'" name = "contactperson" type="text" class="form-control" placeholder="请输入收货人" isvalid="yes"'
            html =html +'checkexpession="NotNull"/>'
            html =html +'    </td>'
            html =html +'    <td class="formTitle">联系电话<font face="宋体">*</font></td>'
            html =html +'    <td class="formValue">'
            html =html +'    <input SorderBy = "'+SHFnumber+'" name = "iphone" type="text" class="form-control" placeholder="请输入联系电话" isvalid="yes"'
            html =html +'checkexpession="NotNull"/>'
            html =html +'    </td>'
            html =html +'    </tr>'
            html =html +'    <tr>'
            html =html +'    <td class="formTitle">收货地址<font face="宋体">*</font></td>'
            html =html +'    <td class="formValue" colspan="2">'
            html =html +'    <input SorderBy = "'+SHFnumber+'" id = "Saddress" name="address"   onblur="getlal($(this).val(),$(this))" type="text"  STYLE="width: 340px" class="form-control" placeholder="请输入发货地址" isvalid="yes"'
            html =html +'checkexpession="NotNull"> </input>'
            html =html +'    </td>'
            html =html +'    <td class="formValue" colspan="1">'
            html =html +'    <input SorderBy = "'+SHFnumber+'" name="ltl" STYLE="width: 120px;margin-left: 71px" type="" class="form-control" disabled="disabled" placeholder="经纬度为空" isvalid="yes"'
            html =html +'checkexpession="NotNull"> </input>'
            html =html +'    </td>'
            html =html +'    <td class="formTitle">要求运抵时间<font face="宋体">*</font></td>'
            html =html +'    <td class="formValue">'
            html =html +'    <input SorderBy = "'+SHFnumber+'"  name="planLeaveTime" id="planLeaveTime" type="text"  readonly="readonly"    class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>'
            html =html +'    </td>'
            html =html +'    <td class="formTitle">实际运抵时间</td>'
            html =html +'    <td class="formValue">'
            html =html +'    <input SorderBy = "'+SHFnumber+'" name = "factLeaveTime" type="text" class="form-control"  disabled = "disabled"  placeholder="暂未发运……"  />'
            html =html +'    </td>'
            html =html +'    </tr>'
            $("#SFHGML").before(html)
            //初始化信息
            var s = $("#SFHGML").prev().find("[name='address']");
            var uuid =getUUID();
            s.attr('id',uuid);
            getMapDataFroId(uuid);

            var a =  $("#SFHGML").prev().prev().find("[name='zone']");//初始化城市信息
            a.ComboBoxTree({
                url: "zone/getCity.action",
                description: "==请选择城市==",
                height: "200px",
                allowSearch:true
            });
        }
        function intyFeeTypeImpl(data){
            var html ="";
            countFeetype = data;
            html += '<tr>'
            for(i=1;i<=data.length;i++){
                var em = data[i-1];
                if(i == 6 || i==11 || i==16 || i==21 || i==26 || i==31){
                    html += '</tr>'
                    html += '<tr>'
                }
                html+= ' <td style="width:100px" class="formTitle" fee="1">'+em.name+"&nbsp "+'<span class="label label-success pull-right">(11%)</span></td>'
                html+= '<td  class="formValue" >'
                html+='<input id = "'+em.id+'"   name = "fee" type="number" onchange="sumFee()" isCount="'+em.isCount+'" STYLE="width: 120px;text-align:center"  value="0" class="form-control"></input>'
               html+=''
                html+= '</td>'
            }
            html += '</tr>'
            $("#feeTypeClass").prepend(html);
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
                    intyFeeTypeImpl(data);
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
                    $("#costomer").val(resule.id);
                    $("#costomerName").val(resule.name);
                    $("#salePersion").val(resule.salePersion);
                    var status = resule.settlementType
                    for(var i in top.clientdataItem.Clearing){
                        if(top.clientdataItem.Clearing[i] ==status){
                            status=i
                        }
                    }
                    $("#feeType").ComboBoxSetValue(status),

                    getProjectManagement(resule.id);
                }
            });
        }
        function getProjectManagement(id){
            $("#projectManagement").ComboBox({ //项目名称
                description: "=请选择项目=",
                height: "200px",
                url:'/projectManagement/getProjectManagement.action',
                param:{id:id}
            });
        }

        //打开收发货方 arg 0 是发货方 1是收货方
        function openReceivingParty(self){

            dialogOpen({
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
                             if ($(this).attr("name") == "name"){
                                $(this).val(resule.name)
                            }
                            if ($(this).attr("name") == "zone"){
                                $(this).ComboBoxTreeSetValue(resule['zone.id'])
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
                        })
                    }
                    var s = self.attr("SorderBy");
                    if(s != null && s != undefined){ //如果是发货方
                        var FHC = $("[SorderBy="+s+"]")
                        FHC.each(function(){
                            if ($(this).attr("name") == "name"){
                                $(this).val(resule.name)
                            }
                            if ($(this).attr("name") == "zone"){
                                $(this).ComboBoxTreeSetValue(resule['zone.id'])
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
                        })
                    }
                }
            });

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
        function closeOrder(){
        }
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <div class="tab-content" style="padding-top: 15px;width: 1160px">
            <table class="form">
                <H4 id =  "ystitle" style="text-align:center">运输订单管理</H4>
                <hr style="margin:10px;height:3px;border:none;border-top:1px double #008080;" />
                <input id="id" name="id"  type="hidden" />
                <input id="loadingMethod" name="loadingMethod" type="hidden" value="1"/>
                <input id="status" name="status" type="hidden" />
                <input id="plan" name="status" type="hidden" />
                <tr>
                    <td class="formTitle">订单号</td>
                    <td class="formValue">
                        <input id="code" type="" class="form-control" disabled = "disabled"  placeholder="系统自动生成" readonly="readonly"  />

                    </td>
                    <td class="formTitle">客户订单号</td>
                    <td class="formValue">
                        <input id="relatebill1"  type="text" class="form-control" maxlength="50"/>
                    </td>
                    <td class="formTitle">受理日期<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="time" type="text"  placeholder="请选择订单时间"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                    </td>

                    <td class="formTitle">订单公里数</td>
                    <td class="formValue">
                        <input id="orderMileage" value = "0" type="text" class="form-control"
                               isvalid="yes"  checkexpession="IsPositiveOrNull"/>
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
                    <td class="formValue">
                        <input id="costomer"  type="hidden" value=""/>
                        <input id="costomerName" onclick="selectCustomer()" readonly type="text" disabled = "disabled" class="form-control" placeholder="合同客户必须选择客户"/>
                        <span class="input-button" onclick="selectCustomer()" title="请选择合同" >.......</span>
                    </td>
                    <td class="formTitle">项目名称</td>
                    <td class="formValue">
                        <div id="projectManagement" type="select" class="ui-select" disabled = "disabled"  isvalid="no" checkexpession="NotNull"><ul> </ul> </div>
                    </td>
                    <td class="formTitle">结算方式<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="feeType" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull"><ul> </ul> </div>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">是否回单</td>
                    <td class="formValue">
                        <div id="isBack" name = "isBack" class="radio" onchange="changeIsBack()"  type="radio"/>
                    </td>
                    <td class="formTitle">回单份数</td>
                    <td class="formValue">
                        <input id="backNumber" type="text" value="0" disabled = "disabled"  class="form-control"
                               isvalid="yes"  checkexpession="IsInterOrNull"/>
                    </td>
                    <td class="formTitle">执行计划</td>
                    <td class="formValue">
                        <input id="planName" type="text" readonly onclick="selectPlan()" class="form-control" placeholder="你选择订单计划" />
                        <span class="input-button" onclick="selectPlan()" title="请选择合同" >.......</span>
                    </td>
                    <td class="formTitle">运输性质<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="transportPro" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">销售负责人</td>
                    <td class="formValue">
                        <input id="salePersion" type="text"  class="form-control" />
                    </td>
                    <td class="formTitle">运输方式</td>
                    <td class="formValue">
                        <div id="shipmentMethod" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                            <ul>
                            </ul>
                        </div>
                    </td>
                    <td class="formTitle">是否开票</td>
                    <td class="formValue">
                        <div id="isBilling" name="isBilling" class="radio" type="radio">
                        </div>
                    </td>
                </tr>
                <td colspan="8">
                <hr style="margin:3px;height:3px;border:none;border-top:1px double #008080"  />
                 </td>
                    <div id = "FHF">
                    <tr>

                        <td class="formTitle"><span style="margin-right: 5px"><i onclick="addFHF($(this))" class="fa fa-plus-square-o" ></i></span>发货单位<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input name="id" ForderBy = "1" type="hidden" />
                            <input name="type" ForderBy = "1" value = "0" type="hidden" />
                            <input name = "name"  ForderBy = "1" class="form-control" placeholder="请输入或选择发货方单位" isvalid="yes"
                                   checkexpession="NotNull"/>
                            <span class="input-button" ForderBy = "1" onclick="openReceivingParty($(this))" title="请选择发货方" >.......</span>
                        </td>
                        <td class="formTitle">起运城市<font face="宋体">*</font></td>
                        <td class="formValue">
                            <div id="Qzone" ForderBy = "1" name =  "zone" type="select" class="ui-select" isvalid="yes"  checkexpession="NotNull">
                                <ul>
                                </ul>
                            </div>
                        </td>
                        <td class="formTitle">发货人<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input ForderBy = "1" name = "contactperson" type="text" class="form-control" placeholder="请输入发货人" isvalid="yes"
                                   checkexpession="NotNull"/>
                        </td>
                        <td class="formTitle">联系电话<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input ForderBy = "1" name = "iphone" type="text" class="form-control" placeholder="请输入联系电话" isvalid="yes"
                                   checkexpession="NotNull"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="formTitle">发货地址<font face="宋体">*</font></td>
                        <td class="formValue" colspan="2">
                            <input ForderBy = "1" id = "address" name="address"  onblur='getlal($(this).val(),$(this))' type="text"  STYLE="width: 340px" class="form-control" placeholder="请输入发货地址" isvalid="yes"
                                   checkexpession="NotNull"> </input>
                        </td>
                        <td class="formValue" colspan="1">
                            <input ForderBy = "1" name="ltl" STYLE="width: 120px;margin-left: 71px" type="" class="form-control" disabled="disabled" placeholder="经纬度为空" isvalid="yes"
                                   checkexpession="NotNull"> </input>
                        </td>
                        <td class="formTitle">要求发运时间<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input ForderBy = "1" id="planLeaveTime" name="planLeaveTime" type="text"  readonly="readonly"   class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                        </td>
                        <td class="formTitle">实际发运时间</td>
                        <td class="formValue">
                            <input ForderBy = "1" name = "factLeaveTime" type="text" class="form-control" disabled = "disabled"  placeholder="暂未发运……"  />
                        </td>
                    </tr>
                    <tr id="FHGML"></tr>
                </div>
                <td colspan="8">
                    <hr style="margin:3px;height:3px;border:none;border-top:1px double #008080"  />
                </td>
                <div id = "SHF">
                    <tr>
                        <td class="formTitle"><span style="margin-right: 5px"><i onclick="SaddFHF($(this))" class="fa fa-plus-square-o" ></i></span>收货单位<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input name="id" SorderBy = "1" type="hidden" />
                            <input name="type" SorderBy = "1" value = "0" type="hidden" />
                            <input name = "name"  SorderBy = "1" class="form-control" placeholder="请输入或选择收货方单位" isvalid="yes"
                                   checkexpession="NotNull"/>
                            <span class="input-button" SorderBy = "1" onclick="openReceivingParty($(this))" title="请选择发货方" >.......</span>
                        </td>
                        <td class="formTitle">目的城市<font face="宋体">*</font></td>
                        <td class="formValue">
                            <div id="SQzone" SorderBy = "1" name = "zone" type="select" class="ui-select" isvalid="yes"  checkexpession="NotNull">
                                <ul>
                                </ul>
                            </div>
                        </td>
                        <td class="formTitle">收货人<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input SorderBy = "1" name =  "contactperson" type="text" class="form-control" placeholder="请输入收货人" isvalid="yes"
                                   checkexpession="NotNull"/>
                        </td>
                        <td class="formTitle">联系电话<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input SorderBy = "1" name = "iphone" type="text" class="form-control" placeholder="请输入联系电话" isvalid="yes"
                                   checkexpession="NotNull"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="formTitle">收货地址<font face="宋体">*</font></td>
                        <td class="formValue" colspan="2">
                            <input SorderBy = "1" id = "Saddress" name="address"  onblur='Sgetlal($(this).val(),$(this))' type="text"  STYLE="width: 340px" class="form-control" placeholder="请输入发货地址" isvalid="yes"
                                   checkexpession="NotNull"> </input>
                        </td>
                        <td class="formValue" colspan="1">
                            <input SorderBy = "1" name="ltl" STYLE="width: 120px;margin-left: 71px" type="" class="form-control" disabled="disabled" placeholder="经纬度为空" isvalid="yes"
                                   checkexpession="NotNull"> </input>
                        </td>
                        <td class="formTitle">要求运抵时间<font face="宋体">*</font></td>
                        <td class="formValue">
                            <input SorderBy = "1" name="planLeaveTime" id="SplanLeaveTime" type="text"  readonly="readonly"   class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                        </td>
                        <td class="formTitle">实际运抵时间</td>
                        <td class="formValue">

                            <input  SorderBy = "1" name =  "factLeaveTime" type="text" class="form-control" disabled = "disabled"  placeholder="暂未发运……"  />
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
                <td colspan="8">
                    <hr style="margin:3px;height:3px;border:none;border-top:1px double #008080"  />
                </td>
                <%--<tr >--%>
                    <%--<td class="formValue" colspan="8">--%>
                        <%--<table id="gridTable2"></table>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            </table>

            <table class="form">
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
</style>
</body>
</html>