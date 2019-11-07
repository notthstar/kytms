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
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>

<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>签收管理</title>
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
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/grid.locale-cn.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.js"></script>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-report.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-bill.css" rel="stylesheet"/>
</head>
<body>
<form id="form1">
    <script>
        var keyValue = request('keyValue');
        $(function () {
            GetGrid()
                $("#id").val(keyValue);
                $.SetForm({
                    url: "/shipmentback/selectBean.action",
                    param: {tableName: "JC_SHIPMENT_BACK", id: keyValue},
                    success: function (data) {
                        $("#id").val(data.id);
                        $("#shipmentCode").val(data.shipment.code);
                        $("#backNumber").val(data.backNumber);
                        $("#description").val(data.description);
                    }
                });

        })
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData =$("#form1").GetWebControls(keyValue);
            $.SaveForm({
                url: "/shipmentback/sing.action",
                param: postData,
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
                        dialogClose();//关闭窗口
                    }
                }
            })
        }
        function GetGrid() {
            var selectedRowIndex = 0;
            var $gridTable = $('#gridTable1');
            $gridTable.jqGrid({
                url: "/shipmentback/getShipmentBackDetail.action?id="+keyValue,
                datatype: "json",
                height: $(window).height() - 290,
                colModel: [
                    {label: '主键', name: 'id', hidden: true},
                    {label: '运单号', name: 'shipmentBack.shipment.code', width: 170, align: 'center'},
                    {label: '订单日期', name: 'led.order.time', width: 150, align: 'center'},
                    {label: '回单份数', name: 'backNumber', width: 150, align: 'center'},
                    {label: '签收份数', name: 'singNumber', width: 150, align: 'center'},
                    {label: '分段订单号', name: 'led.code', width: 170, align: 'center'},
                    {label: '订单号', name: 'led.order.code', width: 170, align: 'center'},
                ],
                pager: false,
                rownumbers: true,
                shrinkToFit: false,
                gridview: true,
                footerrow: true,
                multiselect: true,//复选框

                caption: "回单明细",
                onSelectRow: function () {
                    selectedRowIndex = $("#" + this.id).getGridParam('selrow');
                },
                gridComplete: function () {
                    $("#" + this.id).setSelection(selectedRowIndex, false);
                }
            });
        }
        function btn_Sing(){
            var keyValue = $("#gridTable1").jqGridRowValue("id");
            if (checkedRow(keyValue)) {
                dialogOpen({
                    id: "回单签收",
                    title: '回单签收',
                    url: 'jsp/ShipmentBack/SingFrom.jsp?keyValue=' + keyValue,
                    width: "330px",
                    height: "300px",
                    callBack: function (iframeId) {
                        top.frames[iframeId].AcceptClick($("#gridTable1"));
                    }
                });
            }
        }
        function btn_SingAll(){
            $.SaveForm({
                url: "/shipmentback/singAll.action",
                param: {id:$("#id").val()},
                loading: "正在提交数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    }else if (data.type){
                        if(data.result){
                            $("#gridTable1").trigger("reloadGrid");
                            $.currentIframe().$("#gridTable").trigger("reloadGrid");

                            dialogMsg(data.obj, 1);
                        }else {
                            dialogAlert(data.obj, -1);
                        }

                    }else{
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }
    </script>
    <div style="margin-top: 10px;margin-right: 40px">
            <table class="form">
                <input id="id" name="id" type="hidden" value="" />
                <tr>
                    <td class="formTitle">运单号</td>
                    <td class="formValue">
                        <input id="shipmentCode"  name = "name" class="form-control" disabled = "disabled" />
                    </td>
                    <th class="formTitle">回单份数</th>
                    <td class="formValue">
                        <input id="backNumber" type="text"  class="form-control" disabled = "disabled"/>
                    </td>
               </tr>
                <tr>
                    <th class="formTitle">备注</th>
                    <td class="formValue" >
                        <textarea id="description" type="text" style="width: 440px;height: 50px" class="form-control"></textarea>
                    </td>

                </tr>

            </table>

    </div>

</form>
<table>
    <a id="plan-add" style="margin-left: 5px;" class="btn btn-default" onclick="btn_Sing()"><i class="fa fa-check"></i>&nbsp;签收</a>
    <a id="plan-del" style="margin-left: 5px;text-align:center" class="btn btn-default" onclick="btn_SingAll()"><i class="fa fa-chevron-up"></i>&nbsp;全部签收</a>
</table>
<div class="gridPanel" style="margin-top: 15px">
    <table id="gridTable1"></table>
</div>
</body>
</html>