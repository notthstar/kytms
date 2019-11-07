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
                $("#id").val(keyValue);
            $("#backType").ComboBox({ //回单类型
                description: "=请选择回单方式=",
                height: "200px",
                data: top.clientdataItem.BackType
            });
            $("#expressName").ComboBox({ //快递类型
                description: "=请选择快递公司=",
                height: "200px",
                data: top.clientdataItem.Exppexx_type
            });
                $.SetForm({
                    url: "/shipmentback/selectBean.action",
                    param: {tableName: "JC_SHIPMENT_BACK", id: keyValue},
                    success: function (data) {
                        $("#shipmentCode").val(data.shipment.code);
                        $("#expressName").ComboBoxSetValue(data.expressName);
                        $("#expressCode").val(data.expressCode);
                        $("#backType").ComboBoxSetValue(data.backType);
                        $("#backTime").val(data.backTime);
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
                url: "/shipmentback/back.action",
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
    </script>
    <div style="margin-top: 50px;margin-right: 40px">
            <table class="form">
                <input id="id" name="id" type="hidden" value="" />
                <tr>
                    <th class="formTitle">回单时间<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="backTime" type="text"  placeholder="请选择回单时间"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">运单号<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="shipmentCode"  name = "name" class="form-control" disabled = "disabled" />
                    </td>
                    <th class="formTitle">回单方式<font face="宋体">*</font></th>
                    <td class="formValue">
                        <div  id="backType" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull"><ul> </ul> </div>
                    </td>
               </tr>
                <tr>
                    <th class="formTitle">快递名称</th>
                    <td class="formValue">
                        <div id="expressName" type="select" class="ui-select" ><ul> </ul> </div>
                    </td>
                    <th class="formTitle">快递单号<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="expressCode" type="text"  class="form-control"  />
                    </td>
                </tr>
            </table>
    </div>
</form>
</body>
</html>