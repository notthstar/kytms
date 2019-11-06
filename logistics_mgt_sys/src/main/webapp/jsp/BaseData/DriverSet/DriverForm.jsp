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
    <title>司机管理表单</title>
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
    <script src="/Content/scripts/utils/jet-card.js"></script>
</head>
<body>
<form id="form1">
    <script>
        var keyValue = request('keyValue');
        //初始化
        $(function () {
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "/driver/selectBean.action",
                    param: {tableName: "JC_DRIVER", id: keyValue},
                    success: function (data) {
                        $("#form1").SetWebControls(data);
                        //车头赋值
                        if(data.vehicleHead!=null){
                            // $("#vehicleHead").ComboBoxTreeSetValue(data.vehicleHead.id);
                            $("#vehicleHead").val(data.vehicleHead.id);
                            $("#vehicleHeadName").val(data.vehicleHead.code);
                           // data.vehicleHead=null;
                        }

                    }
                });
            }
        })

        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData =$("#form1").GetWebControls(keyValue);
            postData["vehicleHead.id"]=$("#vehicleHead").val();

           // postData["sex"] = $('input:radio[name="sex"]:checked').val();
            $.SaveForm({
                url: "/driver/saveDriverBean.action",
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

        function getVehicleHead (self){
            dialogOpen({
                id: "VehicleFrom",
                title: '车头选择',
                url: 'jsp/VehicleHead/VehicleHeadIndex.jsp?status=1',
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getVehicleHead();
                    $.SetForm({
                        url: "/vehicleHead/getVehicleHeadInfo.action",
                        param: {id:resule },
                        success: function (data) {
                            if(data.vehicleHead != null && data.vehicleHead != undefined){
                                $("#vehicleHead").val(data.vehicleHead.id);
                                $("#vehicleHeadName").val(data.vehicleHead.code);
                            }
                        }
                    });
                    top.frames[iframeId].dialogClose();//关闭窗口
                }
            });
        }
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <div class="tab-content" style="padding-top: 15px;">
            <table class="form">
                <input id="id" name="id" type="hidden" value="" />
                <input id="status" name="status" type="hidden" value="" />
                <tr>
                    <th class="formTitle">司机姓名<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="name" type="text" onKeyUp="pinyinQuery('name','code')"  class="form-control" placeholder="司机姓名" isvalid="yes" checkexpession="NotNull" />
                    </td>
                    <th class="formTitle">司机代码<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="code" type="text" class="form-control" placeholder="司机代码" isvalid="yes" checkexpession="NotNull" />
                    </td>
                </tr>
                <tr>
                    <th class="formTitle">身份证</th>
                    <td class="formValue">
                        <input id="card" type="text"  class="form-control" />
                    </td>

                    <th class="formTitle">基本工资</th>
                    <td class="formValue">
                        <input id="baseWages" type="text" class="form-control"/>
                    </td>

                </tr>
                <tr>
                    <th class="formTitle">领取驾驶证日期</th>
                    <td class="formValue">
                        <input id="dri" type="text"    class="form-control input-wdatepicker"    onfocus="WdatePicker()"/>
                    </td>
                    <th class="formTitle">手机号<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="iphone1" type="text" class="form-control" isvalid="yes"  checkexpession="MobileOrPhoneOrNull" />

                </tr>

                <tr>
                    <th class="formTitle">备注</th>
                    <td class="formValue">
                        <textarea id="description" type="text" style="width: 630px;height: 50px" class="form-control"></textarea>
                        <%--<input id="description" type="text" style="width: 500px;height: 50px" class="form-control" />--%>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</form>
</body>
</html>