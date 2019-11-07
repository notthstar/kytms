<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2017/12/04
  Time: 21:27
  收发货方表单
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
    <title>收发货方表单</title>
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
    <%--高德导航--%>
    <link href="/Content/styles/jet-gd.css" rel="stylesheet"/>
    <%--<script src="/Content/scripts/utils/jet-gdutil.js?v=1.3&key=49df3dbb93cc593e8cceedfe8f8be185"></script>--%>
    <script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.10&key=49df3dbb93cc593e8cceedfe8f8be185"></script>
    <script src="/Content/scripts/utils/jet-gd.js"></script>
</head>
<body>
<form id="form1">

    <script>
        var keyValue = request('keyValue');
        $(function () {
            getMapDataFroId("address", "ltl");
            if (!!keyValue) {
                $.SetForm({
                    url: "/receivingParty/selectBean.action",
                    param: {tableName: "JC_RECEIVINGPARTY", id: keyValue},
                    success: function (data) {
                       // $("#zone").ComboBoxTreeSetValue(data.zone.id);
                        $("#form1").SetWebControls(data);
                    }
                });
            }else{

            }
        })
        function selectReceivers(e) {
            dialogOpen({
                id: "GdMap",
                title: '地图选择',
                url: '/jsp/CommPlug/GdMap.jsp',
                width: "900px",
                height: "650px",
                callBack: function (iframeId) {
                    var data = top.frames[iframeId].AcceptClickToReceivers();
                    $("#ltl").val(data.latitude)
                    $("#address").val(data.address)
                    top.frames[iframeId].dialogClose();//关闭窗口
                }
            });
        }
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData =$("#form1").GetWebControls(keyValue);
            $.SaveForm({
                url: "/receivingParty/saveReceivingParty.action",
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

        function getReceivingParty(){
            var id = $("#gridTable").jqGridRowValue("id");
            if (checkedIds(id)) {
                return $("#gridTable").jqGrid('getRowData', id);
            }
        }
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
            <table class="form">
                <input id="id" name="id" type="hidden" value="" />
                <tr>
                    <td class="formTitle">客户名称<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="name" type="text" autocomplete="off" class="form-control" placeholder="客户名称" isvalid="yes" checkexpession="NotNull" />
                    </td>
                    <th class="formTitle">联系人<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="contactperson" autocomplete="off"  type="text"  class="form-control" placeholder="联系人" isvalid="yes"  checkexpession="NotNull"  />
                    </td>
               </tr>
                   <tr>

                       <th class="formTitle">电话<font face="宋体">*</font></th>
                       <td class="formValue">
                           <input id="iphone" autocomplete="off"  type="text" class="form-control" isvalid="yes" checkexpession="NotNull"  />
                       </td>
                   </tr>
                <tr>
                    <th class="formTitle">地址<font face="宋体">*</font></th>
                    <td class="formValue" colspan="2">
                        <input id = "address" autocomplete="off" name="address"   type="text"  STYLE="width: 290px" class="form-control" placeholder="请输入发货地址" isvalid="yes"
                               checkexpession="NotNull"> </input>
                        <span class="input-button" onclick="selectReceivers()" title="选择地址" >....</span>
                    </td>
                    <td class="formValue" colspan="1">
                        <input id="ltl" autocomplete="off"  name="ltl" STYLE="width: 150px;margin-left: 11px" type="" class="form-control" disabled="disabled" placeholder="经纬度为空" isvalid="yes"  checkexpession="NotNull"  > </input>
                    </td>
                </tr>
                <tr>
                    <th class="formTitle">详细地址</th>
                    <td class="formValue" colspan="2">
                        <input id = "detailedAddress" autocomplete="off" name="detailedAddress"   type="text"  STYLE="width: 290px" class="form-control" placeholder="请输入发货地址" isvalid="yes" checkexpession="NotNull"> </input>
                    </td>
                </tr>
                <tr>
                    <th class="formTitle">备注</th>
                    <td class="formValue">
                        <textarea id="description" type="text" style="width: 480px;height: 50px" class="form-control"></textarea>
                        <%--<input id="description" type="text" style="width: 500px;height: 50px" class="form-control" />--%>
                    </td>
                </tr>
            </table>
    </div>
</form>
</body>
</html>