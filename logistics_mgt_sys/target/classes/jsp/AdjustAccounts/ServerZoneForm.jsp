<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/28
  Time: 18:28
  To change this template use File | Settings | File Templates.
  服务区域表单
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
        var orgId= request("orgId");
        $(function () {
//            //组织机构
//            $("#organization").ComboBoxTree({
//                url: "/org/getOrgTree.action",
//                description: "==请选择==",
//                height: "200px",
//
//            });
            //获取所有
            $("#zone").ComboBoxTree({
                url: "/zone/getAll.action",
                description: "==请选择==",
                height: "200px",
                allowSearch:true
            });
            //服务类型下拉框
            $("#type").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.serviceType
            });
            //取价方式下拉框
            $("#priceType").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.priceType
            });
            $("#minMoney").val(0);
            initControl();
            if(orgId != null && orgId !=""){
                $("#organization").val(orgId);
            }

        })

        //初始化控件
        function initControl() {
            //加载自定义表单
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "/serverZone/selectBean.action",
                    param: { tableName:"JC_SERVER_ZONE",id: keyValue },
                    success: function (data) {
                        $("#form1").SetWebControls(data);
                        $("#organization").ComboBoxSetValue(data.organization.id);
                        //$("#zone").ComboBoxTreeSetLoadValue(data.zone.id,data.zone.name);
                       $("#zone").ComboBoxSetValue(data.zone.id);
//                        $("#zone").ComboBoxTreeSetValue(data.zone.id);
//                        $("#zone").val(data.zone.id);
                    }
                });
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
            //postData["jcRegistration"] = $('div:selected[name="jcRegistration.id"]:selected').val();

            if(orgId != null && orgId !=""){
                postData["organization.id"] = orgId;
            }else{
                postData["organization.id"] = '${orgId.id}';
            }
           // console.log(postData)
            $.SaveForm({
                url: "/serverZone/saveServerZone.action",
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
        function abc(type) {
            if($("#type").text() =="派送"){
                 $("#priceType").ComboBoxSetValue(0);
            }else{
                $("#priceType").ComboBoxSetValue(1);
            }
        }

    </script>
    <div id="111" style="margin-left: 10px; margin-right: 10px;">
        <table class="form">
            <input id="id" name="id" type="hidden" value="" />
            <tr>
                <td class="formTitle">组织机构</td>
                <td class="formValue">
                    <div id="organization" disabled="disabled" name="organization.id" type="select" class="ui-select" ></div>
                </td>
                <ul></ul>
                <td class="formTitle">目的运点<font face="宋体">*</font></td>
                <td class="formValue">
                    <div id="zone" name="zone.id" type="select" class="ui-select"  isvalid="yes" checkexpession="NotNull"/>
                </td>
                <td class="formTitle">服务类型<font face="宋体">*</font></td>
                <td class="formValue">
                    <div id="type" name="type" type="select" class="ui-select"
                         isvalid="yes" checkexpession="NotNull"></div>
                </td>
            </tr>
            <tr>
                <td class="formTitle">公里数</td>
                <td class="formValue">
                    <input id="mileage" name="mileage" type="text" class="form-control"></input>
                </td>
                <td class="formTitle">最低收费<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="minMoney" autocomplete="off" name="minMoney" type="text" class="form-control" isvalid="yes" checkexpession="NotNull"></input>
                </td>
            </tr>
            <tr>
                <td class="formTitle">吨单价</td>
                <td class="formValue">
                    <input id="weightPrices" autocomplete="off" name="weightPrices" type="text" class="form-control"></input>
                </td>
                <td class="formTitle">方单价</td>
                <td class="formValue">
                    <input id="volumePrices" name="volumePrices" type="text" class="form-control"></input>
                </td>
                <td class="formTitle">送货费</td>
                <td class="formValue">
                    <input id="songhf" name="songhf" type="text" class="form-control"></input>
                </td>

            </tr>
            <tr>
                <td class="formTitle" valign="top" style="padding-top: 4px;">备注</td>
                <td class="formValue" colspan="5">
                    <textarea id="description" class="form-control" style="height: 50px;"></textarea>
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>