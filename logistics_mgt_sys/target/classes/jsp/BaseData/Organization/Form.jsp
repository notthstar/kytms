<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/4/7
  Time: 12:54
  组织机构表单
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
    <title>组织机构表单</title>
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
    <link href="/Content/styles/jet-gd.css" rel="stylesheet"/>
    <%--高德导航--%>
    <link href="/Content/styles/jet-gd.css" rel="stylesheet"/>
    <%--<script src="/Content/scripts/utils/jet-gdutil.js?v=1.3&key=49df3dbb93cc593e8cceedfe8f8be185"></script>--%>
    <script src="https://webapi.amap.com/maps?v=1.3&key=49df3dbb93cc593e8cceedfe8f8be185"></script>
    <script src="/Content/scripts/utils/jet-gd.js"></script>
</head>
<body>
<form id="form1">
    <script>
        var keyValue = request('keyValue');

        //getMapDataFroId("address","latitude");

        $(function () {
            $("#isOverdueCarrier").ComboRadio({
                data: top.clientdataItem.CommIsNot,
                defaultVaue: '1'
            });
            $("#isOverdueContract").ComboRadio({
                data: top.clientdataItem.CommIsNot,
                defaultVaue: '1'
            });
            $("#level").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.CityLevel
            });
            $("#type").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.OrgType
            });
            $("#organizationl").ComboBoxTree({
                url: "/org/getTree.action?tableName=JC_SYS_ORGANIZATION&id=root",
                description: "==最高层级==",
                height: "200px",
            });
            if (!!keyValue) {
                $.SetForm({
                    url: "/org/selectBean.action",
                    param: {tableName:"JC_SYS_ORGANIZATION", id: keyValue },
                    success: function (data) {
                       $("#form1").SetWebControls(data);
                      $("#organizationl").ComboBoxTreeSetValue(data.organizationl.id);
                    }
                });
            }
            getMapDataFroIdAddress("address","latitude","");
        })
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData = $("#form1").GetWebControls(keyValue);
            if(postData["organizationl"]){
                postData["organizationl"] = {id:postData["organizationl"]}
            }else {
                postData["organizationl"] = {id:"root"}
            }
                $.SaveForm({
                url: "org/saveOrg.action",
                param: { tableName:"JC_SYS_ORGANIZATION", obj:JSON.stringify(postData)},
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    } else if (data.type) {
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        $.currentIframe().GetTree();
                        dialogMsg(data.obj, 1);
                        dialogClose();//关闭窗口
                    } else {
                        dialogAlert(data.obj, -1);
                        dialogClose();
                    }
                }
            })
        }
        function selectReceivers(e) {
            var url = '/jsp/CommPlug/GdMap.jsp';
            var ltl = $("#FH_ltl").val();
            if( ltl != null && ltl != undefined && ltl != ""){
                url+="?ltl="+ltl
            }
            dialogOpen({
                id: "GdMap",
                title: '地图选择',
                url: url,
                width: "900px",
                height: "650px",
                callBack: function (iframeId) {
                    var data = top.frames[iframeId].AcceptClickToReceivers();
                    $("#latitude").val(data.latitude)
                    $("#address").val(data.address)
                    top.frames[iframeId].dialogClose();//关闭窗口
                }
            });
        }

    </script>
    <div style="margin-top: 20px; margin-right: 30px;">

        <table class="form">
            <input id="id" name="id" type="hidden" value=""/>
            <tr>
                <th class="formTitle">机构名称<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="name" type="text" onkeyup="pinyinQuery('name','code')" class="form-control"  maxlength="20" isvalid="yes" checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">机构代码<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="code" type="text" class="form-control" isvalid="yes" maxlength="50" checkexpession="NotNull"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">上级机构<font face="宋体">*</font></th>
                <td class="formValue">
                    <div id="organizationl" name="organizationl" type="selectTree"  class="ui-select">
                    </div>
                </td>
            </tr>
            <tr>
                <th class="formTitle">类型<font face="宋体">*</font></th>
                <td class="formValue">
                    <div id="type" name="type" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull"></div>
                </td>
            </tr>
            <tr>
                <th class="formTitle">详细地址<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="address" autocomplete="off" type="text" class="form-control" maxlength="125" isvalid="yes" checkexpession="NotNull"  />
                    <span class="input-button" onclick="selectReceivers()" title="选择地址" >....</span>
                </td>
            </tr>
            <tr>
                <th class="formTitle">经纬度<font face="宋体">*</font></th>
                <td class="formValue">
                    <input id="latitude" type="text" class="form-control" isvalid="yes" checkexpession="NotNull" disabled=true/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">负责人</th>
                <td class="formValue">
                    <input id="principal" type="text" maxlength="25" class="form-control"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle">行政等级<font face="宋体">*</font></th>
                <td class="formValue">
                    <div id="level" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                        <ul>
                        </ul>
                    </div>
                </td>
            </tr>
            <tr>
                <th class="formTitle">备注</th>
                <td class="formValue">
                    <input id="description" type="text" maxlength="100" class="form-control"/>
                </td>
            </tr>
            <tr>
                <th class="formTitle" style="left: 30px">是否能使用合同</th>
                <td class="formValue" style="left: 100px">
                    <div id="isOverdueContract" class="radio" type="radio">
                    </div>
                </td>
            </tr>
            <tr>
                <th class="formTitle" style="left: 30px">是否能使用超期承运商</th>
                <td class="formValue" style="left: 100px">
                    <div id="isOverdueCarrier" class="radio" type="radio">
                    </div>
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>
