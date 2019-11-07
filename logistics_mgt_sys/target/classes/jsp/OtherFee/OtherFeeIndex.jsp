<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/10
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
    <title>其他费用</title>
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
<form id="form1">

    <script>
        //车头ID
        var keyValue = request('keyValue');
        //车牌号CODE
        var dcode = request('code');

        $(function () {
            $("#vehicleHead").val(dcode);
            $("#type").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.CostIdentification
            });
            //税率
            $("#taxRate").ComboRadio({
                height: "200px",
                data: top.clientdataItem.TaxRate,
                defaultVaue:0
            });
//            $("#feetype").ComboBoxTree({
//                url: "/feetype/getDispFeeType.action",
//                description: "==请选择==",
//                height: "200px",
//
//            });
            InitialPage();
            GetGrid();
        })
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData ={
                id: $("#id").val(),
                 name:$("#name").val(),
                 zmoney:$("#zmoney").val(),
                csTime:$("#csTime").val(),
                operator:$("#operator").val(),
                type:$("#type").attr('data-value'),
                taxRate:$("input[name='taxRate']:checked").val(),
                input:$("#input").val()
            }

            $.SaveForm({
                url: "/otherFee/saveOtherFee.action",
                param:postData,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    }else if (data.type){
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        dialogMsg(data.obj, 1);
                        onclick=reload();
                    }else{
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }

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
        }
        //加载表格
        function GetGrid() {
            var selectedRowIndex = 0;
            var $gridTable = $('#gridTable');
            $gridTable.jqGrid({
                url: "/otherFee/getOtherFeeList.action?id=" + keyValue,
                datatype: "json",
                height: $(window).height() - 206.5,
                autowidth: true,
                colModel: [
                    {label: '主键', name: 'id', hidden: true},
                    {label: '费用名称', name: 'name', width: 150, align: 'center'},
                    {label: '使用时间', name: 'csTime',type:"date", width: 150, align: 'center'},
                    {label: '费用金额', name: 'zmoney', width: 150, align: 'center'},
                    {label: '收支类型', name: 'type', width: 70, align: 'center',
                        formatter: function (cellvalue, options, rowObject) {
                            return top.clientdataItem.CostIdentification['' + cellvalue + '']
                        }
                    },
                    {label: '使用人', name: 'operator', width: 150, align: 'center'},
                    {label: '税率', name: 'taxRate', width: 100,align: 'center',type:"DD&TaxRate"},
                    {label: '税金', name: 'input', width: 100,align: 'center'},
                    {label: "状态", name: "status",type:"DD&CommDataStatus", width: 50, align: "center",
                        formatter: function (cellvalue, options, rowObject) {
                            return top.clientdataItem.CommDataStatus['' + cellvalue + '']
                        }
                    },
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
                }
            });
            //$gridTable.authorizeColModel()
            //初始化查询条件
            initJGGridselectView($gridTable);
        }

        function btn_Update(status) {
            var  keyValue = $("#gridTable").jqGridRowValue("id");
            if (keyValue) {
                $.ConfirmAjax({
                    msg: "注：您确定要确认添加剂记录？",
                    url: "/carriageRepair/updateStatus.action",
                    param: { tableName:"JC_CARRIAGE_REPAIR",status:status,id: keyValue },
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

        function btn_edit() {
            var keyValue = $("#gridTable").jqGridRowValue("id");
            $.SetForm({
                url: "/otherFee/selectBean.action",
                param: {tableName:"JC_OTHER_FEE", id: keyValue },
                success: function (data) {
                    if(data.status != 0){
                        $("#form1").SetWebControls(data);
                        $("#id").val(data.id),
                        $("#zmoney").val(data.zmoney),
                            $("#csTime").val(data.csTime),
                           $("#operator").val(data.operator),
                            $("#type").val(data.type),
                           $("#taxRate").val(data.taxRate),
                           $("#input").val(data.input)
                    }else {
                        alert("已经确认的数据不允许修改");
                    }
                }
            });
        }

        function shuijin(money,taxRate,input) {
            var taxRate = $("input[name='taxRate']:checked").val();
            var amount = document.getElementById("zmoney").value;
            console.log(taxRate)
            if (taxRate == "") {
                document.getElementById(input).value = 0
                return;
            }
            document.getElementById(input).value = parseFloat(amount)/(1 + parseFloat(taxRate))*parseFloat(taxRate);
        }

    </script>

    <div style="margin-left: 5px; margin-right: 5px;">
        <table class="form" >
            <input id="id" name="id" type="hidden" value="" />
            <tr>
                <th class="formTitle">费用说明<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="name"type="text" class="form-control"  isvalid="yes"  checkexpession="NotNull" />
                </td>
                <th class="formTitle">费用金额<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="zmoney" type="text" autocomplete="off" onchange = shuijin('taxRate','amount','input')  class="form-control" placeholder="费用金额" isvalid="yes" checkexpession="LenNum" />
                </td>
                <th class="formTitle">收支类型<font face="宋体">*</font></th>
                <td class="formValue">
                    <div id="type" type="select" autocomplete="off"   class="ui-select"  isvalid="yes" checkexpession="LenNum" />
                </td>
                <th class="formTitle">使用时间<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="csTime" type="text" autocomplete="off"   placeholder="使用时间"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">使用人<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="operator" type="text" autocomplete="off"   class="form-control" placeholder="经手人" isvalid="yes"  checkexpession="NotNull"  />
                </td>
                <th class="formTitle">税率<font face="宋体">*</font></th>
                <td class="formValue">
                    <div id="taxRate" name="taxRate" onchange = shuijin('taxRate','amount','input') class="radio" type="radio"></div>
                </td>
                <th class="formTitle">税金</th>
                <td class="formValue">
                    <input id="input" disabled="disabled" autocomplete="off"  type="text" class="form-control" maxlength="10"/>
                </td>
                <td>
                    <a id="trailer-replace11" class="btn btn-default" onclick="AcceptClick()"><i class="fa fa-plus"></i>&nbsp;保存</a>
                </td>
                <td>
                    <a id="trailer-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-plus"></i>&nbsp;编辑</a>
                </td>
            </tr>
        </table>

    </div>
    <div class="titlePanel">
        <div  class="title-search" style="padding-top: 12px">
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
                    </td>
                </tr>
            </table>
        </div>
        <div class="toolbar">
            <div class="btn-group" style="padding-top: 12px">
                <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>

                <a id="carriageRepair-disabled" class="btn btn-default" onclick="btn_Update(0)"><i class="fa fa-pencil-square-o"></i>&nbsp;确认</a>
            </div>
            <script>$('.toolbar').authorizeButton()</script>
        </div>
    </div>
    </div>

    <div class="gridPanel">
        <table id="gridTable"></table>
        <div id="gridPager"></div>
    </div>
</form>
</body>

</html>
