<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/4/7
  Time: 12:54
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
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet"/>
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <!--bootstrap组件end-->

    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/utils/jet-pinyin.js"></script>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/wizard/wizard.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/dialog/dialog.js"></script>
</head>
<body>
<form id="form1">
    <script>
        var keyValue = request('keyValue');
        var idd = request('idd');
        $(function () {
            var url= null;
            $("#zone").ComboBoxTree({
            url: "/zone/getZoneTree.action",
            description: "==请选择==",
            height: "170px",
            });
            if(idd != null && idd != ""){
                $.SetForm({
                    url: "zone/selectBean.action",
                    param: {tableName:"JC_ZONE",id:idd},
                    success: function (data) {
                        $("#zone").ComboBoxTreeSetLoadValue(data.id,data.name);
                        $("#cityCode").val(data.cityCode);
                    }
                });
            }
            $("#level").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.CityLevel
            });
            if (!!keyValue) {
                $.SetForm({
                    url: "zone/selectBean.action",
                    param: {tableName:"JC_ZONE",id:keyValue},
                    success: function (data) {
                        $("#form1").SetWebControls(data);
                        $("#zone").ComboBoxTreeSetLoadValue(data.zone.id,data.zone.name);
                    }
                });
            } else {

            }
            //获取表单
        })
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData = $("#form1").GetWebControls(keyValue);
            postData["zone.id"] =$("#zone").attr('data-value')
            delete postData.zone;
            $.SaveForm({
                url: "zone/saveZone.action",
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
                    }
                }
            })
        }
        function pinyinQuery(input,out){
            var str = document.getElementById(input).value.trim();
            if(str == ""){
                document.getElementById(out).value=""
                return;
            }
            var arrRslt = makePy(str);
            //循环将值到下拉框
            var option = null;
            document.getElementById(out).value="";//清空下拉框
            var first = document.getElementById(out);
            for(var j=0;j<arrRslt.length;j++){
                document.getElementById(out).value=arrRslt[j];//清空下拉框
            }
        }
    </script>
    <div style="margin-top: 20px; margin-right: 30px;">

        <table class="form">
            <input id="id" name="id" type="hidden" value=""/>
            <tr>
                <th class="formTitle">区域名称<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="name" type="text" onkeyup="pinyinQuery('name','code')"   class="form-control" isvalid="yes" checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">区域编码<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="code" type="text" class="form-control" isvalid="yes" checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">城市编码<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="cityCode" type="text" class="form-control" isvalid="yes" checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">等级<font face="宋体">*</font></th>
                <td class="formValue">
                    <div id="level" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                        <ul>
                        </ul>
                    </div>
                </td>
            </tr>
            <tr>
                <th class="formTitle">上级机构<font face="宋体">*</font></th>
                <td class="formValue">
                    <div id="zone" name="zone" type="selectTree" class="ui-select" isvalid="yes" checkexpession="NotNull"></div>
                </td>
            </tr>
            <tr>
                <th class="formTitle">经纬度</th>
                <td class="formValue">
                    <input id="latitude" type="text" class="form-control" />
                </td>
            </tr>
            <tr>
                <th class="formTitle">备注</th>
                <td class="formValue">
                    <input id="description" type="text" class="form-control" />
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>
