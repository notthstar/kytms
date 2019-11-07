
<%--
  Created by IntelliJ IDEA.
  User:孙德增
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
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
    <script src="/Content/scripts/utils/jet-pinyin.js"></script>
</head>
<body>
    <script>
        var shipment = request('shipment');
        var id = request('id');
        var number = request('number');
        var weight = request('weight');
        var volume = request('volume');
        var type = request('type');
        //初始化控件
        $(function () {
            $("#number").val(number)
            $("#weight").val(weight)
            $("#volume").val(volume)
        });
        //保存表单
        function AcceptClick(win) {
            var rowData = new Array();
            var obj={
                id:id,
                number:$("#number").val(),
                weight:$("#weight").val(),
                volume:$("#volume").val(),
                typeValue:type,
                value:0,
            }
            rowData.push(obj)
            $.SetForm({
                url: "/single/addOrder.action",
                param: {id: shipment, data: JSON.stringify(rowData)},
                success: function (data) {
                    if (data.result){
                        dialogMsg("配载成功", 1);
                    }else {
                        dialogAlert(data.obj, -1);
                    }
                }
            });
        return obj

        }
    </script>
            <table class="form">
                <tr >
                    <th style="padding-top: 60px;" class="formTitle">数量<font face="宋体"></font></th>
                    <td class="formValue" style="padding-top: 60px">
                        <input id="number" type="number"   value="0"  class="form-control"/>
                    </td>
                    <th style="padding-top: 60px;" class="formTitle">重量<font face="宋体"></font></th>
                    <td class="formValue" style="padding-top: 60px">
                        <input id="weight" type="number"  value="0"   class="form-control"/>
                    </td>
                    <th style="padding-top: 60px;" class="formTitle">体积<font face="宋体"></font></th>
                    <td class="formValue" style="padding-top: 60px">
                        <input id="volume" type="number"  value="0"   class="form-control"/>
                    </td>
                </tr>
            </table>
</body>
</html>