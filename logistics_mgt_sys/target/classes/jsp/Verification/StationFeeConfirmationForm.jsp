<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/15
  Time: 14:12
  To change this template use File | Settings | File Templates.
  添加场站费用
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
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet" />
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <!--bootstrap组件end-->

    <%--   <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>--%>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker_loong.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>


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
        var instanceId = "";
        var formId = "";
        $(function () {
            //燃油种类下拉框
            $("#oilType").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.OilType
            });
            //来源下拉框
            $("#source").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.Source
            });
            //组织机构
            $("#organization").ComboBoxTree({
                url: "/org/getOrgTree.action",
                description: "==请选择==",
                height: "200px",
            });
            //使用组织机构
            $("#organization1").ComboBoxTree({
                url: "/org/getOrgTree.action",
                description: "==请选择==",
                height: "200px",
            });
            initControl();
        })

        //初始化控件
        function initControl() {
            //加载自定义表单
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "/verification/selectBean.action",
                    param: { tableName:"JC_VEHICLE_HEAD",id: keyValue },
                    success: function (data) {
                        //格式化日期
                        data.buyTime=data.buyTime.substr(0,10);
                        $("#form1").SetWebControls(data);
//                        $("#jcRegistration").ComboBoxSetValue(data.jcRegistration.id);
                        $("#organization").ComboBoxSetValue(data.organization.id);
                        if(data.organization1 != null){
                            $("#organization1").ComboBoxSetValue(data.organization1.id);
                        }

                        $("#price").val(data.price);


                    }
                });
            }

        }
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            //给日期加上时分秒，不然后台校验过不去
            var aa=$("#buyTime").val()+" 00:00:00";
            $("#buyTime").val(aa);

            var postData = $("#form1").GetWebControls(keyValue);
            //postData= $("#organization").ComboBoxSetValue(data.organization.id);
            // postData["organization"] = $('div:selected[name="organization.id"]:selected').val();
            //postData["jcRegistration"] = $('div:selected[name="jcRegistration.id"]:selected').val();
            $.SaveForm({
                url: "/vehicleHead/saveVehicleHead.action",
                param: postData,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                        //格式化日期
                        var buyTime=$("#buyTime").val().substr(0,10);
                        $("#buyTime").val(buyTime);
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

    </script>
    <div id="111" style="margin-left: 10px; margin-right: 10px;">
        <table class="form">
            <input id="id" name="id" type="hidden" value="" />
            <tr>
                <td class="formTitle">发起站<font face="宋体">*</font></td>
                <td class="formValue">
                    <div id="organization" name="organization.id" type="selectTree" class="ui-select" maxlength="20"/>
                </td>
                <th class="formTitle">目的站<font face="宋体">*</font></th>
                <td class="formValue">
                    <div id="organization1" name="organization.id" type="selectTree" class="ui-select" maxlength="20"/>
                </td>
                <th class="formTitle">费用名称</th>
                <td class="formValue">
                    <div id="source" name="source" type="select" class="ui-select"></div>
                </td>
            </tr>
            <tr>
                <th class="formTitle">金额</th>
                <td class="formValue">
                    <input  id="jcRegistration" name="jcRegistration.id" type="text"  class="form-control"  maxlength="10"/>
                </td>
                <th class="formTitle">原因</th>
                <td class="formValue">
                    <input id="or1" name="organization.id" type="text" class="form-control" maxlength="20"/>
                </td>
                <th class="formTitle">承担人</th>
                <td class="formValue">
                    <input id="org1" name="organization1.id" type="text" class="form-control" maxlength="20"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle" valign="top" style="padding-top: 4px;">备注
                </th>
                <td class="formValue" colspan="5">
                    <textarea id="description" class="form-control" style="height: 50px;"></textarea>
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>
