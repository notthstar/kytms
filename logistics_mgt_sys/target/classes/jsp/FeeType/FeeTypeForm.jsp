<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/4/7
  Time: 12:54
  费用类型管理表单
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
    <link href="/Content/scripts/utils/hsCheck/hsCheckData.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/utils/jet-pinyin.js"></script>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/wizard/wizard.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/utils/hsCheck/hsCheckData.js"></script>
    <script src="/Content/scripts/plugins/dialog/dialog.js"></script>
</head>
<body>
<form id="form1">
    <script>
        var keyValue = request('keyValue');

        //单选
        $(function () {
            $("input[sa='sa']").each(function(){
                $(this).click(function(){
                    if($(this).is(":checked")){
                        var we= $(this)
                        $("input[sa='sa']").each(function(){
                            if($(this).attr('id')!=we.attr('id')){
                                $(this).removeAttr("checked")
                            }

                        });
                    }

                });
            });

            $("#isCount").ComboRadio({
                data: top.clientdataItem.CommIsNot,
                defaultVaue: '0'
            });
            $("#defaultCreate").ComboRadio({
                data: top.clientdataItem.CommIsNot,
                defaultVaue: '1'
            });
            $("#cost").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.CostIdentification
            });
//            $("#organization").ComboRadio({
//                url: "/org/getOrgTree.action",
//                description: "==请选择==",
//                height: "200px",
//            });
            //获取所有组织机构的数据
            var orgData = null;
            $.SetForm({
                url: "/org/getOrgForJsonArray.action",
                success: function (data) {
                    orgData = data;
                }
            });

            if (!!keyValue) {
                $.SetForm({
                    url: "/feetype/selectBean.action",
                    param: {tableName:"JC_FEE_TYPE", id: keyValue },
                    success: function (data) {
                        //$("#organizations").attr('data-value');
                       $("#form1").SetWebControls(data);
                        $('#organizations').hsCheckData({
                            isShowCheckBox: true, //默认为false
                            data: orgData,
                            defText:data.orgName
                        });
                    }
                });
            } else {
                $('#organizations').hsCheckData({
                    isShowCheckBox: true, //默认为false
                    data: orgData,
                });
            }
            //获取表单
        })
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
           var data = $("#form1").GetWebControls(keyValue);

            var orsId = $("#organizations").attr("data-id");
            var orsName = $("#organizations").text();
            data["orgId"] = orsId
            data["orgName"] = orsName
                $.SaveForm({
                url: "feetype/saveFeeType.action",
                param: data,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    } else if (data.type) {
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        dialogMsg(data.obj, 1);
                        dialogClose();//关闭窗口
                    } else {
                        dialogAlert(data.obj, -1);
                        dialogClose();
                    }
                }
            })
        }
//        function selectorg(){
//            dialogOpen({
//                id: "organizations",
//                title: '组织机构',
//                url: 'jsp/BaseData/Organization/SelectIndex.jsp',
//                width: "450px",
//                height: "450px",
//                btn: ['确认','关闭'],
//                callBack: function (iframeId) {
//                  var resule = top.frames[iframeId].getOrg();
//                    top.frames[iframeId].dialogClose();//关闭窗口
//                    $("#org").val(resule.id);
////                    $("#plan").val(resule.id);
//                }
//            });
//        }


    </script>
    <div style="margin-top: 20px; margin-right: 30px;">
        <table class="form">
            <input id="id" name="id" type="hidden" value=""/>
            <tr>
                <th class="formTitle">费用名称<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="name" type="name" onkeyup="pinyinQuery('name','code')" class="form-control"  maxlength="25" isvalid="yes" checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">费用代码<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="code" type="code" class="form-control" isvalid="yes" maxlength="50" checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">收入成本标识</th>
                <td class="formValue">
                    <div id="cost" name="cost" type="select" class="ui-select" ></div>
                </td>
            </tr>
            <tr>
                <th class="formTitle">是否代收代付</th>
                <td class="formValue">
                    <div id="isCount" class="radio" type="radio">
                    </div>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<th class="formTitle">是否默认生成</th>--%>
                <%--<td class="formValue">--%>
                    <%--&lt;%&ndash;<input id="org" type="text" readonly onclick="selectorg()" class="form-control" placeholder="你选择组织机构" />&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<span class="input-button" onclick="selectorg()" title="" >.......</span>&ndash;%&gt;--%>
                    <%--<input id="organization" class="radio" type="radio">--%>
                    <%--</input>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <td class="formTitle">加入模块:</td>
                <td class="formValue">
                    <div class="checkbox user-select">
                        <label>
                            <input id="transportOrder" sa="sa" type="checkbox"/>
                            订单
                        </label>
                        <label>
                            <input id="shipmentModule" sa="sa" type="checkbox"/>
                            运单
                        </label>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="formTitle">默认生成机构:</td>
                <td class="formValue">
                    <div id="organizations"> </div>
                </td>
            </tr>
            <tr>
                <th class="formTitle">备注</th>
                <td class="formValue">
                    <input id="description" type="text" maxlength="100" class="form-control"/>
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>