<%--
  Created by IntelliJ IDEA.
  User: cxl
  Date: 2018-10-29
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>

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
    <!--框架必需start-->
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
</head>
<body>
<form id="form1">

    <script>
        var feeTypeData;//费用变量存储
        var keyValue = request('keyValue');
        var confirmStatus=request('confirmStatus');
        $(function () {
            getFeeType();//初始化费用类型
            //组织机构
            $("#receiveOrganization").ComboBoxTree({
                url: "/org/getOrgTree.action",
                description: "==请选择==",
                height: "200px",
            });

            $("#feeSign").ComboBox({ //交付方式
                description: "=请选择交付方式=",
                height: "200px",
                data: top.clientdataItem.FeeSign,
                defaultVaue:'0'
            });
            initControl();
        })

        //初始化控件
        function initControl() {
            //加载自定义表单
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "/feeSeed/getFeeSeed.action",
                    param: {id: keyValue},
                    success: function (data) {
                        console.log(data)
                        $("#id").val(data.id);
                        $("#code").val(data.code);
                        if(data.receiveOrganization != null){
                            $("#receiveOrganization").ComboBoxSetValue(data.receiveOrganization.id);
                        };
                        if(data.startOrganization != null){
                            $("#startOrganization").val(data.startOrganization.name);
                        }
                        $("#feeSign").ComboBoxSetValue(data.feeSign);
                        $("#time").val(data.time);
                        $("#description").val(data.description);
                        GetGrid();//初始化费用
                        var $JGGRID = $("#gridTable2");
                        $JGGRID.jqGrid("clearGridData"); //清空数据
                        $JGGRID.setGridHeight(0);
                        if(data.ledgerDetails != null){
                            $JGGRID.setGridHeight($JGGRID.getGridParam("height") + 28 * data.ledgerDetails.length)
                            $JGGRID.addRowData(getUUID(),data.ledgerDetails,"first");
                        }

                    }
                });
            }else{
                GetGrid();
                initFeeType() //初始化费用
            }


        }


        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            if(confirmStatus=="已确认"){
                dialogMsg("此费用已经确认，不能修改", 1);
                return false;
            }
            var feeSeed={
                id:$("#id").val(),
                code:$("#code").val(),
                receiveOrganization:{id :$("#receiveOrganization").attr('data-value')},
                feeSign: $("#feeSign").attr('data-value'),
                time:$("#time").val()
            }
            //备注如果为空，不赋值
            if($("#description").val()!=null && $("#description").val()!=""){
                feeSeed['description']=$("#description").val();
            }
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
                    input:leddetail.input
                }
                LedgerDetails.push(LedgerDetail)
            }
            feeSeed['LedgerDetails'] = LedgerDetails;
            var feeSeedData = {feeSeed:JSON.stringify(feeSeed)};

            $.SaveForm({
                url: "/feeSeed/saveFeeSeed.action",
                param: feeSeedData,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    }else if (data.type){
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        dialogMsg(data.obj, 1);
                        dialogClose();//关闭窗口
                    }else{
                        dialogAlert(data.obj, -1);
                    }
                }
            })
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
                    $JGGRID.setGridHeight($JGGRID.getGridParam("height") + 28 * data.length)
                    $JGGRID.addRowData(getUUID(),data,"first");
                },
            });

        }
        function addJgGirdNullData2 (){
            var model={
                id:null,
                name:null,
                taxRate:0.1, //默认税率
                description:null,

            }
            var $JGGRID = $("#gridTable2")
            $JGGRID.setGridHeight($JGGRID.getGridParam("height") + 28)
//            $JGGRID.jqGrid("addRowData",null,"first");
            $JGGRID.addRowData(getUUID(),model,"first");
        }

        function deleteJgGirdNullData2 (data){
            var $JGGRID = $("#gridTable");
            data.parent().parent().remove();
            $JGGRID .setGridHeight($JGGRID.getGridParam("height") - 28)
            productTotal($JGGRID)
        }

        /**
         * 费用合计
         */
        function feeTypeTotal(JGGRID){
            var amount = JGGRID .getCol("amount", false, "sum");
            var input = JGGRID .getCol("input", false, "sum");
            //合计
            JGGRID .footerData("set", {
                "feeType.name": "合计：",
                "amount": "金额:" + amount,
                "input": "税率:" + input,
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
                width:800,
                cellEdit:true,
                cellsubmit:"clientArray",
                colModel: [
                    { label: "主键", name: "id", index: "id", hidden: true },
                    { label: "主键", name: "feeType.id", index: "id", hidden: true },
                    { label: "费用名称", name: "feeType.name", width: 180,resizable:false,editable:true,edittype:'select', align: "center",editoptions: {value: feeTypeData}},
                    { label: "金额", name: "amount", index: "target", resizable:false, width: 100, align: "center",edittype: "text" ,editable:true,editrules: { required: true, custom:true, custom_func: numberValidator},},
                    { label: "税率", name: "taxRate",  width: 100,resizable:false, align: "center",editable:true,edittype:'select', editoptions: {value: top.clientdataItem.TaxRate}},
                    { label: "税金", name: "input", index: "url",resizable:false,  width: 100, align: "center"},
                    { label: "备注信息", name: "description", resizable:false, index: "description", width: 150,edittype: "text", align: "center" ,editable:true },
                    { label: '<button type="button" onclick="addJgGirdNullData2()" class="btn btn-success btn-xs">添加费用</button>',   sortable: false, width: 100, align: "center",
                        formatter: function (cellvalue, options, rowObject) {
                            /*if(source ){
                                return '不可删除修改费用'
                            }*/
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
                    $(this).setRowData(rowid,rowData)

                    //计算合计
                    feeTypeTotal($(this))

                },
                gridComplete: function () {
                    var number = $(this).getCol("amount", false, "sum");
                    var weight = $(this).getCol("input", false, "sum");
                    //合计
                    $(this).footerData("set", {
                        "feeType.name": "合计：",
                        "amount": "金额:" + number,
                        "input": "税金 :" + weight,
                    });
                },
            });
        }

    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
            <table class="form">
                <input id="id" name="id" type="hidden" value="" />
                <tr>
                    <th class="formTitle">发起机构</th>
                    <td class="formValue">
                        <input id="startOrganization" type="text" class="form-control" disabled placeholder="当前机构。。。" />
                    </td>
                    <th class="formTitle">接收机构<font face="宋体">*</font></th>
                    <td class="formValue">
                        <div id="receiveOrganization" name="receiveOrganization.id" type="selectTree" class="ui-select" maxlength="20"/>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">费用编号</td>
                    <td class="formValue">
                        <input id="code" type="" class="form-control" disabled = "disabled"  placeholder="系统自动生成" readonly="readonly"  />
                    </td>
                    <td class="formTitle">费用标识<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="feeSign" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">发生时间</td>
                    <td class="formValue">
                        <input id="time"  type="text" readonly="readonly" class="form-control input-wdatepicker"  onfocus="WdatePicker()"/>
                    </td>
                </tr>

                <tr>
                    <th class="formTitle" valign="top" style="padding-top: 4px;">备注
                    </th>
                    <td class="formValue" colspan="3">
                        <textarea id="description" class="form-control" style="height: 50px;"></textarea>
                    </td>
                </tr>
                <tr >
                    <td class="formValue" colspan="4">
                        <table id="gridTable2"></table>
                    </td>
                </tr>
            </table>
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