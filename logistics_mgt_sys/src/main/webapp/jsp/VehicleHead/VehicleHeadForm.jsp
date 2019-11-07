<%--
  Created by IntelliJ IDEA.
  User: 陈小龙
  Date: 2018-1-12
  Time: 16:02
  车头管理表单
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
    <script src="/Content/scripts/utils/tAutocomplete-master/jquery.select.js"></script>
</head>
<body>
<form id="form1">

    <script>
        var keyValue = request('keyValue');
        $(function () {
            //组织机构
            $("#organization").ComboBoxTree({
                url: "/org/getOrgTree.action",
                description: "==请选择==",
                height: "200px",
                defaultVaue:'${orgId.id}'
            });
            $("#driverss").ComboBoxTree({
                url: "/driver/getDriveTree.action",
                description: "==请选择==",
                height: "200px",
               // defaultVaue:'${orgId.id}'
            });
            // $.SetForm({
            //     url: "driver/getDrivea.action",
            //     param: { name: ''},
            //     success: function (data) {
            //         $.selectSuggest('drivers',data);
            //       //  $.selectSuggest('mudididian',data);
            //     }
            // });
            initControl();
        })

        //初始化控件
        function initControl() {
            //加载自定义表单
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "/vehicleHead/selectBean.action",
                    param: { tableName:"JC_VEHICLE_HEAD",id: keyValue },
                    success: function (data) {
                        console.log(data)
                        //格式化日期
                        $("#form1").SetWebControls(data);
                        $("#organization").ComboBoxSetValue(data.organization.id);
                        $("#driverss").ComboBoxSetValue(data.driverss.id);
                        // $("#price").val(data.price);
                    }
                });
            }else{
                $("#organization").ComboBoxSetValue('${orgId.id}');
            }

        }
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }

            var postData = $("#form1").GetWebControls(keyValue);

            //postData= $("#organization").ComboBoxSetValue(data.organization.id);
           // postData["organization"] = $('div:selected[name="organization.id"]:selected').val();
            //postData["drivers"] = $('div:selected[name="drivers.id"]:selected').val();
            $.SaveForm({
                url: "/vehicleHead/saveVehicleHead.action",
                param: postData,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                        //格式化日期
//                        var buyTime=$("#buyTime").val().substr(0,10);
//                        $("#buyTime").val(buyTime);
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
                <td class="formTitle">车牌号<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="code" type="text" class="form-control"/></td>
                </td>
                <th class="formTitle">所属机构</th>
                <td class="formValue">
                    <div id="organization" name="organization.id" type="selectTree" class="ui-select" maxlength="20"/>
                </td>
                <th class="formTitle">司机</th>
                <td class="formValue">
                    <div id="driverss" name="driverss.id" autocomplete="off" type="selectTree" class="ui-select" maxlength="20"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">手机号</th>
                <td class="formValue">
                    <input id="phone" type="text" class="form-control" maxlength="20"/>
                </td>
                <th class="formTitle">总质量(吨)</th>
                <td class="formValue">
                    <input id="totalMass" type="text" class="form-control" /></td>
                </td>
                <th class="formTitle">牵引总质量(吨)</th>
                <td class="formValue">
                    <input id="pullTotalMass" type="text" class="form-control" />
                </td>
            </tr>
            <tr>
                <th class="formTitle">车架号</th>
                <td class="formValue">
                    <input id="vin" type="text" class="form-control"/>
                </td>
                <th class="formTitle">尺寸</th>
                <td class="formValue">
                    <input id="size" type="text" class="form-control" maxlength="20"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle" valign="top" style="padding-top: 4px;">备注
                </th>
                <td class="formValue" colspan="3">
                    <textarea id="description" class="form-control" style="height: 50px;"></textarea>
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>