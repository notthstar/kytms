<%--
  Created by IntelliJ IDEA.
  User: chenxiaolong
  Date: 2018/9/17
  Time: 18:25
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
    <title>费用调整</title>
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet" />
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
</head>
<body>
<script>
    var keyValue = request('keyValue');
    //初始化控件
    $(function () {

        //获取费用总计
        $.SetForm({
            url: "/single/getFeeTypeCount.action",
            param: {id: keyValue },
            success: function (data) {
                $("#ycost").val(data.amount)
                $("#ytaxes").val(data.input)
                var yrate = data.amount/(data.amount-data.input).toFixed(${SystemConfig.inputRoundNumber})
                yrate =yrate.toFixed(${SystemConfig.inputRoundNumber})
                $("#yrate").val(yrate)
                $("#hrate").ComboBox({ //税率
                    description: "=请选择税率=",
                    height: "200px",
                    data: top.clientdataItem.TaxRate
                });
                $("#hrate").ComboBoxSetValue('0.10');
                $("#crate").ComboBox({ //税率
                    description: "=请选择税率=",
                    height: "200px",
                    data: top.clientdataItem.TaxRate
                });
                $("#crate").ComboBoxSetValue('0.10');
            }
        });




    })



    function bgFeetype(){
        var cost = $("#hcost").val()
        var rate = Number($("#hrate").attr('data-value'));
        var taxRate = cost / (1+rate) * rate

        taxRate = taxRate.toFixed(${SystemConfig.inputRoundNumber})

        $("#htaxes").val(taxRate)
        //差额计算
        var ycost = cost - $("#ycost").val();
        $("#ccost").val(ycost)

        var crate = Number($("#crate").attr('data-value'));
        var ctaxRate = ycost / (1+crate) * crate

        ctaxRate = ctaxRate.toFixed(${SystemConfig.inputRoundNumber})

        $("#ctaxes").val(ctaxRate)
    }
    function ceFeetype(){
        var ccost = $("#ccost").val()
        var crate = Number($("#crate").attr('data-value'));
        var ctaxRate = ccost / (1+crate) * crate

        ctaxRate = ctaxRate.toFixed(${SystemConfig.inputRoundNumber})

        $("#ctaxes").val(ctaxRate)
        //调整后计算
        var hcost = Number(ccost) + Number($("#ycost").val());
        $("#hcost").val(hcost)

        var hrate = Number($("#hrate").attr('data-value'));
        var hctaxRate = hcost / (1+hrate) * hrate

        hctaxRate = hctaxRate.toFixed(${SystemConfig.inputRoundNumber})

        $("#htaxes").val(hctaxRate)
    }
    //保存表单
    function AcceptClick(jggrid) {
            return obj={
            cost: $("#ccost").val(),
            crate:$("#crate").attr('data-value'),
            taxes: $("#ctaxes").val(),
        }
    }
</script>
<table class="form">
    <tr>
        <th class="formTitle" style="font-weight: bolder"><font face="宋体">*</font>原车费</th>
        <td class="formValue">
            <input id="ycost"  class="form-control"  disabled="disabled"  type="number" value="0"/>
        </td>
        <th class="formTitle" style="font-weight: bolder">原税率</th>
        <td class="formValue">
            <input id="yrate"   class="form-control" type="number" disabled="disabled" type="text" value="0"/>
        </td>
        <th class="formTitle" style="font-weight: bolder">原税金</th>
        <td class="formValue">
            <input id="ytaxes"   class="form-control" type="number" disabled="disabled" type="text" value="0"/>
        </td>
    </tr>
    <tr>
        <th class="formTitle" style="font-weight: bolder"><font face="宋体">*</font>变更后车费</th>
        <td class="formValue">
            <input id="hcost" type="number"  class="form-control"  onchange="bgFeetype()"  value="0"/>
        </td>
        <th class="formTitle" style="font-weight: bolder">变更后税率</th>
        <td class="formValue">
            <div id="hrate"  type="select" class="ui-select" onchange="bgFeetype()" >
                <ul>
                </ul>
            </div>
        </td>
        <th class="formTitle" style="font-weight: bolder">变更后税金</th>
        <td class="formValue">
            <input id="htaxes"   class="form-control" type="number" disabled="disabled" type="text" value="0"/>
        </td>

    </tr>
    <tr>
        <th class="formTitle" style="font-weight: bolder"><font face="宋体">*</font>差额车费</th>
        <td class="formValue">
            <input id="ccost" onchange="ceFeetype()" class="form-control" type="number" value="0"/>
        </td>
        <th class="formTitle" style="font-weight: bolder">差额税率</th>
        <td class="formValue">
            <div id="crate" onchange="ceFeetype()" type="select" class="ui-select">
                <ul>
                </ul>
            </div>
        </td>
        <th class="formTitle" style="font-weight: bolder">差额税金</th>
        <td class="formValue">
            <input id="ctaxes"   class="form-control" type="number" disabled="disabled" type="text" value="0"/>
        </td>
    </tr>
</table>
</body>
</html>
