<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/5
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>

<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>提派单表单</title>
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet" />
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
    <script src="/Content/scripts/utils/jet-pinyin.js"></script>
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
</head>
<body>


    <script>
        var keyValue = request('keyValue');
        var am = request('abnormal'); //是否有异常
        $(function () {
            initControl();
            GetGrid();
            buttonInit();
            changecarrierType()
            initAmButton()
        })

        //初始化控件
        function initControl() {
            $("#carrierType").ComboBox({ //承运类型
                description: "=请选择客户类型=",
                height: "200px",
                data: top.clientdataItem.Cytp
            });

            $("#rate").ComboBox({ //税率
                description: "=请选择税率=",
                height: "200px",
                data: top.clientdataItem.TaxRate
            });
            $("#accountType").ComboBox({ //选择结算方式
                description: "=请选择算方式=",
                height: "200px",
                data: top.clientdataItem.Clearing
            });
            //初始化数据
            $("#carrierType").ComboBoxSetValue(0);
            $("#rate").ComboBoxSetValue('0.00');
            $("#accountType").ComboBoxSetValue(0);

            showDate("dateBilling"); //初始化时间


            //加载自定义表单
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "/single/selectBean.action",
                    param: {tableName:"JC_SINGLE",id: keyValue },
                    success: function (data) {
                        $("#form1").SetWebControls(data);
                        $("#vehicle").val(data.vehicle.id);
                        $("#vehicleName").val(data.vehicle.code);
                        if(data.carrier){
                            $("#carrier").val(data.carrier.id);
                            $("#carrierName").val(data.carrier.name);

                        }
                        InitFeetype(data.ledgerDetails)

                    }
                });
            }

        }
     /*** 初始化费用
      *
      * */
        function InitFeetype(ledgerDetails){
            if(ledgerDetails!=null ||ledgerDetails != undefined){
                var countAmount = 0;
                var input = 0;
                for(i=0;i<ledgerDetails.length;i++){
                    var d = ledgerDetails[i];
                    if(d.feeType.id == '4028f08166809ebd016680aa2e1f0001'){
                        $("#cost").val(d.amount);
                    }
                    if(d.feeType.id == '402881a76729f9fd01672af53af20036'){
                        $("#cost2").val(d.amount);
                    }
                    if(d.feeType.id == '402881a76729f9fd01672af5760d003a'){
                        $("#cost3").val(d.amount);
                    }
                    if(d.feeType.id == '402881a76729f9fd01672af62f790047'){
                        $("#cost4").val(d.amount);
                    }
                    countAmount += d.amount
                    input += d.input
                }
                //设置总费用
                $("#CountCost").val(countAmount)
                $("#CountTaxes").val(input)
                $("#taxes").val(input)
                $("#rate").ComboBoxSetValue(ledgerDetails[0].taxRate);
            }
        }

        //保存表单
        function save(em) {

            if (!$('#form1').Validform()) {
                return false;
            }
            var postData = $("#form1").GetWebControls(keyValue);

            var LedgerDetails = new Array(); //台账
                var LedgerDetail = {
                    feeType : {
                        id:'4028f08166809ebd016680aa2e1f0001' //提派成本
                    },
                    amount:$('#cost').val(),
                    taxRate:$('#rate').attr('data-value'),
                    cost:0,
                    type:5
                }
            var LedgerDetail2 = {
                feeType : {
                    id:'402881a76729f9fd01672af53af20036' //提派上楼费
                },
                amount:$('#cost2').val(),
                taxRate:$('#rate').attr('data-value'),
                cost:0,
                type:5
            }
            var LedgerDetail3 = {
                feeType : {
                    id:'402881a76729f9fd01672af5760d003a' //提派装卸
                },
                amount:$('#cost3').val(),
                taxRate:$('#rate').attr('data-value'),
                cost:0,
                type:5
            }
            var LedgerDetail4 = {
                feeType : {
                    id:'402881a76729f9fd01672af62f790047' //提派其他
                },
                amount:$('#cost4').val(),
                taxRate:$('#rate').attr('data-value'),
                cost:0,
                type:5
            }
            LedgerDetails.push(LedgerDetail)
            LedgerDetails.push(LedgerDetail2)
            LedgerDetails.push(LedgerDetail3)
            LedgerDetails.push(LedgerDetail4)
            postData['LedgerDetails'] = LedgerDetails;
            postData['vehicle']={id:$("#vehicle").val()} ;
            if($("#carrier").val() != null && $("#carrier").val() != undefined && $("#carrier").val() !=""){
                postData['carrier']= {id:$("#carrier").val()};
            }
            var url =  "/single/saveSingle.action"
            var po =  {sing:JSON.stringify(postData)}
            if(am == 1){ //说明是异常修改
                if($('#abnormal').val() == null|| $('#abnormal').val() == undefined || $('#abnormal').val() =="" ){
                    alert("必须填写异常原因")
                    return
                }
                url =  "/single/saveSingleAbnormal.action"
                po ={sing:JSON.stringify(postData),abnormal:$('#abnormal').val()}
            }
            $.SaveForm({
                url: url,
                param:po,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据

                    }else if (data.result){
                        $("#form1").SetWebControls(data.obj);
                        $("#id").val(data.obj.id);
                        keyValue =data.obj.id;
                            $("#vehicle").val(data.obj.vehicle.id);
                        $("#vehicleName").val(data.obj.vehicle.code);
                        if(data.obj.carrier != null && data.obj.carrier != undefined){
                            $("#carrier").val(data.obj.carrier.id);
                            $("#carrierName").val(data.obj.carrier.name);
                        }
                        buttonInit();
                //        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        dialogMsg("保存成功", 1);
                    }else{
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }
        /**
         * 车型选择
         * @param self
         */
        function getVehicle (self){
            dialogOpen({
                id: "vehicleNameFrom",
                title: '车型选择',
                url: '/jsp/vehicle/VehicleIndex.jsp?status=1',
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
         * 承运商选择
         * @param self
         */
        function getCarrier (self){
            dialogOpen({
                id: "carrierFrom",
                title: '承运商选择',
                url: 'jsp/Carrier/CarrierIndex.jsp?status=1',
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getCarrier();
                    top.frames[iframeId].dialogClose();//关闭窗口
                    $("#carrier").val(resule.id)
                    $("#carrierName").val(resule.name)
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
                title: '车辆选择',
                url: 'jsp/VehicleHead/VehicleHeadIndex.jsp?status=1',
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getVehicleHead ();
                    $("#vehicleHead ").val(resule.code);
                    top.frames[iframeId].dialogClose();//关闭窗口
                }
            });
        }


         /* 司机选择
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
                    $("#driver").val(resule.name);
                    $("#driverIphone").val(resule.iphone1)
                    top.frames[iframeId].dialogClose();//关闭窗口
                }
            });
        }
        function GetGrid() {
            var url="/single/SingleDetail.action?id=" +keyValue;
            var selectedRowIndex = 0;
            var $gridTable = $('#gridTable');
            $gridTable.jqGrid({
                url: url,
                datatype: "json",
                height: $(window).height() - 310,
                autowidth: true,
                colModel: [
                    {label: '主键', name: 'id', hidden: true},
                    {label: '类型', name: 'type', width: 80, align: 'center',
                        formatter: function (cellvalue, options, rowObject) {
                            return top.clientdataItem.TPType['' + cellvalue + '']
                        }},
                    {label: '单号', name: 'code', width: 230, align: 'center'},
                    {label: '时间', name: 'time', width: 150, align: 'center',
                        formatter:function(cellvalue, options, row){
                            if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                                return "";
                            }
                            return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                        }},
                    {label: '件数', name: 'number', width: 80, align: 'center'},
                    {label: '重量', name: 'weght', width: 80, align: 'center'},
                    {label: '体积', name: 'volume', width: 80, align: 'center'},
                    {label: '代收货款', name: 'height', width: 80, align: 'center'},
                    {label: '备注', name: 'height', width: 80, align: 'center'},
                    {label: '创建人', name: 'create_Name', width: 120,align: 'center'},
                    {label: '创建时间', name: 'create_Time',type:"date", width: 150,align: 'center'},
                    {label: '修改人', name: 'modify_Name', width: 120,align: 'center'},
                    {label: '修改时间', name: 'modify_Time',type:"date", width: 150,align: 'center'},
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
                ondblClickRow:function(a,b,c){
                    btn_edit(  $gridTable.getCell(a,"id"))
                },

            });
            //$gridTable.authorizeColModel()
            //初始化查询条件
            initJGGridselectView($gridTable);
        }
        /**
         * 按钮控制
         */
        function buttonInit(){
           var status =  $("#status").val();
           //保存按钮
            if(status == 0 || status == 1|| status ==2){
                $("#saveSingle").show();
            }else {
                $("#saveSingle").hide();
            }
            //配载按钮||
            if(status==2 || status == 1){
                $("#singleOrder").show();
            }else {
                $("#singleOrder").hide();
            }



        }
        function initAmButton(){
            var status =  $("#status").val();
            var boo  = (status == 0 || status == 1 || status ==2)
            if(!boo){
                $("#single_amButton").show();
                $('#sm').show()
                $("#rate").attr("disabled","disabled")
                $("#trimFeetype").show()



            }else {
                $("#single_amButton").hide();
                $('#sm').hide()
                $("#trimFeetype").hide()
            }
        }
        function changecarrierType(){
           var value =  $("#carrierType").attr('data-value');
           if(value == 1) {
               $("#carrierName").attr("disabled","disabled")
           }else {
               $("#carrierName").removeAttr("disabled")
           }
        }
        function countRate(){
            var cost =Number($("#cost").val())+Number($("#cost2").val())+Number($("#cost3").val())+Number($("#cost4").val());
            var rate = Number($("#rate").attr('data-value'));
            var taxRate = cost / (1+rate) * rate

            taxRate = taxRate.toFixed(${SystemConfig.inputRoundNumber})
            $("#taxes").val(taxRate)

        }
        function loading(){

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
                content: top.contentPath + 'jsp/Single/SingleFormPZ.jsp?keyValue='+$("#id").val(),
                cancel: function () {
                    $("#gridTable").trigger("reloadGrid");
                    return true;
                }
            });
        }

    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <div class="tab-content" style="padding-top: 15px;">
            <form id="form1">
            <table class="form">
                <input id="volume" name="volume" type="hidden" value="" />
                <input id="reBubbleRatio" name="ReBubbleRatio" type="hidden" value="" />
                <input id="weight" name="weight" type="hidden" value="" />
                <input id="number" name="number" type="hidden" value="" />
                <input id="toSendInfo" name="toSendInfo" type="hidden" value="" />
                <input id="planStartTime" name="planStartTime" type="hidden" value="" />
                <input id="planEndTime" name="planEndTime" type="hidden" value="" />
                <input id="planCilckStartTime" name="planCilckStartTime" type="hidden" value="" />
                <input id="planCilckEndTime" name="planCilckEndTime" type="hidden" value="" />
                <input id="status"  name="status"  type="hidden" value="0" />
                <input id="id" name="id"  type="hidden" />
                <input id="isOverdueCarrier" name="isOverdueCarrier"  type="hidden"  />
                <input id="isAbnormail" name="isAbnormail" value="0"  type="hidden"  />
                <tr>
                    <td class="formTitle">单号</td>
                    <td class="formValue">
                        <input id="code" type="text"  class="form-control" placeholder="单号" disabled="disabled" />
                    </td>
                    <th class="formTitle">计划日期<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="dateBilling"  type="text" class="form-control input-wdatepicker" readonly isvalid="yes"
                               checkexpession="NotNull" onfocus="WdatePicker()"/>
                    </td>
                    <th class="formTitle">车型<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="vehicle" name="vehicle.id" type="hidden" value=""/>
                        <input id="vehicleName"  onclick="getVehicle()" isvalid="yes" checkexpession="NotNull"  type="text" readonly class="form-control" />
                        <span class="input-button" onclick="getVehicle()" title="车型选择" >.......</span>
                    </td>
                    <th class="formTitle">承运类型<font face="宋体">*</font></th>
                    <td class="formValue">
                        <div id="carrierType" type="select" onchange="changecarrierType()" class="ui-select" isvalid="yes" checkexpession="NotNull">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th class="formTitle">承运商</th>
                    <td class="formValue">
                        <input id="carrier" name="carrier.id" type="hidden" value=""/>
                        <input id="carrierName"  onclick="getCarrier()"   type="text" readonly class="form-control" />
                        <span class="input-button" onclick="getCarrier()" title="承运商" >.......</span>
                    </td>
                    <th class="formTitle">车牌号<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="vehicleHead"  autocomplete="off"   type="text" isvalid="yes" checkexpession="NotNull" class="form-control" />
                        <span class="input-button" onclick="getVehicleHead()" title="司机选择" >.......</span>
                    </td>
                    <th class="formTitle">司机<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="driver"    type="text"  autocomplete="off"  class="form-control" isvalid="yes" checkexpession="NotNull" />
                        <span class="input-button"  onclick="getDriver()" title="司机选择" >.......</span>
                    </td>
                    <th class="formTitle">司机电话<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="driverIphone" autocomplete="off"  class="form-control" isvalid="yes" checkexpession="NotNull"/>
                    </td>
                </tr>
                <tr>
                    <th class="formTitle">结算方式<font face="宋体">*</font></th>
                    <td class="formValue">
                        <div id="accountType" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                            <ul>
                            </ul>
                        </div>
                    </td>
                    <th class="formTitle" style="font-weight: bolder">总车费</th>
                    <td class="formValue">
                        <input id="CountCost" class="form-control" disabled="disabled" type="number" value="0"/>
                    </td>
                    <th class="formTitle" style="font-weight: bolder">总税金</th>
                    <td class="formValue">
                        <input id="CountTaxes"   class="form-control" type="number" disabled="disabled" type="text" value="0"/>
                    </td>
                    <th class="formTitle">代收货款共计</th>
                    <td class="formValue">
                        <input id="agent" type="text" class="form-control" disabled />
                    </td>
                </tr>
                <tr>
                    <th class="formTitle" style="font-weight: bolder"><font face="宋体">*</font>车费</th>
                    <td class="formValue">
                        <input id="cost" onchange="countRate()" class="form-control" type="number" value="0" isvalid="yes" checkexpession="NotNull"/>
                    </td>
                    <th class="formTitle" style="font-weight: bolder">上楼费</th>
                    <td class="formValue">
                        <input id="cost2" onchange="countRate()" class="form-control" type="number" value="0" isvalid="yes" checkexpession="NotNull"/>
                    </td>
                    <th class="formTitle" style="font-weight: bolder">装卸费</th>
                    <td class="formValue">
                        <input id="cost3" onchange="countRate()" class="form-control" type="number" value="0" isvalid="yes" checkexpession="NotNull"/>
                    </td>
                    <th class="formTitle" style="font-weight: bolder">其他费用</th>
                    <td class="formValue">
                        <input id="cost4" onchange="countRate()" class="form-control" type="number" value="0" isvalid="yes" checkexpession="NotNull"/>
                    </td>
                </tr>
                <tr>
                    <th class="formTitle" style="font-weight: bolder">税率</th>
                    <td class="formValue">
                        <div id="rate" onchange="countRate()" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                            <ul>
                            </ul>
                        </div>
                    </td>
                    <th class="formTitle" style="font-weight: bolder">税金</th>
                    <td class="formValue">
                        <input id="taxes"   class="form-control" type="number" disabled="disabled" type="text" value="0"/>
                    </td>
                </tr>
                <tr id="feetype"></tr>
                <tr>
                    <th class="formTitle">备注</th>
                    <td class="formValue">
                        <textarea id="description" type="text" style="width: 1000px;height: 40px" class="form-control"></textarea>
                        <%--<input id="description" type="text" style="width: 500px;height: 50px" class="form-control" />--%>
                    </td>
                </tr>
                <tr id="sm">
                    <th class="formTitle" ><font face="宋体">*</font>异常原因</th>
                    <td class="formValue">
                        <textarea id="abnormal"  type="text" style="width: 1000px;height: 40px" class="form-control"></textarea>
                        <%--<input id="description" type="text" style="width: 500px;height: 50px" class="form-control" />--%>
                    </td>
                </tr>
            </table>
            <div id="ExpandInfo" class="tab-pane ">
                <div class="app_layout app_preview" style="border-top: 1px solid #ccc;" id="frmpreview"></div>
            </div>
            </form>
        </div>
    </div>

<div class="titlePanel">
    <table>
        <tr>
            <td style="padding-left: 500px;">
                <a  id="saveSingle" onclick="save()" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;保存</a>
                <a  id="single_amButton" onclick="save(1)"  class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;异常保存</a>
                <a  id="singleOrder" onclick="loading()" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;配载</a>
            </td>
        </tr>
    </table>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
</div>
</body>
</html>