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
                $.SetForm({
                    url: "/shipmentback/selectBean.action",
                    param: {tableName: "JC_SHIPMENT_BACK_DETAIL", id: keyValue},
                    success: function (data) {
                        $("#time").val(data.time);
                        $("#backNumber").val(data.backNumber);
                        $("#singNumber").val(data.singNumber);
                    }
                });

        })
        //保存表单
        function AcceptClick(s) {
            if (!$('#form1').Validform()) {
                return false;
            }
            if($("#backNumber").val()<$("#singNumber").val()){

                dialogAlert("签收数量不能大于回单数量", -1);
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
                        if(data.result){
                            s.trigger("reloadGrid");
                            dialogMsg(data.obj, 1);
                        }else {
                            dialogAlert(data.obj, -1);
                        }
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
                    <th class="formTitle">签收时间<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="time" type="text"  placeholder="请选择回单时间"    class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">回单份数</td>
                    <td class="formValue">
                        <input id="backNumber"  class="form-control" readonly="readonly"  disabled = "disabled" />
                    </td>
               </tr>
                <tr>
                    <th class="formTitle">签收分数<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="singNumber" type="number"  class="form-control" isvalid="yes"  checkexpession="NotNull" />
                    </td>
                </tr>
            </table>
    </div>
</form>
</body>
</html>