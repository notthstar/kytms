<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/10/29
  Time: 9:08
  To change this template use File | Settings | File Templates.
  货物到站
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
    <title>货物到站</title>
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
</head>
<body>
<form id="form1">

    <script>
        var keyValue = request('keyValue');
//        $(function () {
////            $("#organization").ComboBoxTree({
////                url:"org/getOrgTree.action",
////                description: "==请选择==",
////                height: "200px",
////                allowSearch:true
////            });
//            initControl();
//        })

//        //初始化控件
//        function initControl() {
//            //加载自定义表单
//            //获取表单
//            if (!!keyValue) {
//                $.SetForm({
//                    url: "/vehicleArrive/selectBean.action",
//                    param: { tableName:"JC_VEHICLE_ARRIVE",id: keyValue },
//                    success: function (data) {
//                        $("#form1").SetWebControls(data);
////                        $("#organization").ComboBoxSetValue(data.organization.id);
//                    }
//                });
//            }
//        }
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            //var postData = $("#form1").GetWebControls(keyValue);
           // var postData={
              var  arriveTime=$("#arriveTime").val();
       //     }

            $.SaveForm({
                url: "/orderArrive/saveOrderArrive1.action",
                param: {ids:keyValue,date:arriveTime},
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type){
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        $.currentIframe().$("#gridTable1").trigger("reloadGrid");
                        dialogMsg(data.obj, 1);
                        dialogClose();//关闭窗口
                    }else{
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }

    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <table class="form">
            <input id="id" name="id" type="hidden" value="" />
            <tr>
                <td class="formTitle">时间<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="arriveTime" type="text"  placeholder="请选择时间"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle" valign="top" style="padding-top: 4px;">备注
                </th>
                <td class="formValue" >
                    <textarea id="description" class="form-control" style="height: 50px;"></textarea>
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>