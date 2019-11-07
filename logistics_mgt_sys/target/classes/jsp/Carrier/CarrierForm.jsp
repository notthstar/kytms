<%--
  Created by IntelliJ IDEA.
  User: 陈小龙
  Date: 2018-1-15
  Time: 15:15
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
        var instanceId = "";
        var formId = "";
        $(function () {
            $("#carrierType").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.CarrierType
            });
            //指定组织机构
            $("#zdOrganization").ComboBoxTree({
                url: "/org/getOrgTree.action",
                description: "==请选择==",
                height: "200px",
            });
            $("#rule").ComboBoxTree({
                url: "rule/getRuleTree.action",
                description: "==请选择规则==",
                height: "200px",
                allowSearch:true
            });
           // getMapData();
            initControl();
            showOrg();
            getMapDataFroIdAddress("address","latitude","");
        })

        //初始化控件
        function initControl() {
            //加载自定义表单
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "/carrier/selectBean.action",
                    param: { tableName:"JC_CARRIER",id: keyValue },
                    success: function (data) {
                        if(data.zdOrganization!=undefined){
                            //组织机构赋值
                            $("#zdOrganization").ComboBoxTreeSetValue(data.zdOrganization.id);
                        }
                        if(data.rule != null){
                            $("#rule").ComboBoxTreeSetValue(data.rule.id);
                            // $("#rule").val(data.rule.id);
                        }
                        //格式化日期
                        data.startTime=data.startTime.substr(0,10);
                        data.endTime=data.endTime.substr(0,10);
                        data.zdOrganization=null
                        $("#form1").SetWebControls(data);
                        //初始化合同到期天数
                        costDays();
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
            var aa=$("#startTime").val()+" 00:00:00";
            var bb=$("#endTime").val()+" 00:00:00";
            $("#startTime").val(aa);
            $("#endTime").val(bb);
            var postData = $("#form1").GetWebControls(keyValue);

            $.SaveForm({
                url: "/carrier/saveCarrier.action",
                param: postData,

                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                        //格式化日期
                        formatDay();
                    }else if (data.type){
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        dialogMsg(data.obj, 1);
                        dialogClose();//关闭窗口
                    }else{
                        dialogAlert(data.obj, -1);
                    }
                },
            })
            //格式化日期
            formatDay();
        }

        //打开地图
//        function selectReceivers(e) {
//            var url = '/jsp/CommPlug/GdMap.jsp';
//            var ltl = $("#FH_ltl").val();
//            if( ltl != null && ltl != undefined && ltl != ""){
//                url+="?ltl="+ltl
//            }
//            dialogOpen({
//                id: "GdMap",
//                title: '地图选择',
//                url: '/jsp/CommPlug/GdMap.jsp',
//                width: "900px",
//                height: "650px",
//                callBack: function (iframeId) {
//                    var data = top.frames[iframeId].AcceptClickToReceivers();
//                    $("#ltl").val(data.latitude)
//                    $("#address").val(data.address)
//                    top.frames[iframeId].dialogClose();//关闭窗口
//                }
//            });
//        }

        //日期格式化
        function Format(now,mask) {
            var d = now;
            var zeroize = function (value, length)
            {
                if (!length) length = 2;
                value = String(value);
                for (var i = 0, zeros = ''; i < (length - value.length); i++)
                {
                    zeros += '0';
                }
                return zeros + value;
            };

            return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function ($0)
            {
                switch ($0)
                {
                    case 'd': return d.getDate();
                    case 'dd': return zeroize(d.getDate());
                    case 'ddd': return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][d.getDay()];
                    case 'dddd': return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
                    case 'M': return d.getMonth() + 1;
                    case 'MM': return zeroize(d.getMonth() + 1);
                    case 'MMM': return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
                    case 'MMMM': return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
                    case 'yy': return String(d.getFullYear()).substr(2);
                    case 'yyyy': return d.getFullYear();
                    case 'h': return d.getHours() % 12 || 12;
                    case 'hh': return zeroize(d.getHours() % 12 || 12);
                    case 'H': return d.getHours();
                    case 'HH': return zeroize(d.getHours());
                    case 'm': return d.getMinutes();
                    case 'mm': return zeroize(d.getMinutes());
                    case 's': return d.getSeconds();
                    case 'ss': return zeroize(d.getSeconds());
                    case 'l': return zeroize(d.getMilliseconds(), 3);
                    case 'L': var m = d.getMilliseconds();
                        if (m > 99) m = Math.round(m / 10);
                        return zeroize(m);
                    case 'tt': return d.getHours() < 12 ? 'am' : 'pm';
                    case 'TT': return d.getHours() < 12 ? 'AM' : 'PM';
                    case 'Z': return d.toUTCString().match(/[A-Z]+$/);
                    // Return quoted strings with the surrounding quotes removed
                    default: return $0.substr(1, $0.length - 2);
                }
            });
        };

        //计算日期差
        function costDays() {
            var dqrq=new Date();
            var htjsrq=new Date($("#endTime").val());
            dqrq=Format(dqrq,"yyyy-MM-dd");
            htjsrq=Format(htjsrq,"yyyy-MM-dd");
            var time= new Date(htjsrq).getTime()-new Date(dqrq).getTime();
            var days=parseInt(time/(1000 * 60 * 60 * 24));
            if(days<0){
                days=0;
            }
            $("#dqts").val(days);
        }

        //根据承运商类型控制指定组织机构
        function showOrg() {
            var carrierType=$("#carrierType").text();
            if($.trim(carrierType)=="内部"){
                $("#zdOrganization").attr("disabled",false);
            }else{
                $("#zdOrganization").attr("disabled",true);
            }
        }
        //格式化日期
        function formatDay() {
            var st=$("#startTime").val().substr(0,10);
            var et=$("#endTime").val().substr(0,10);
            $("#startTime").val(st);
            $("#endTime").val(et);
        }
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <table class="form">
            <input id="id" name="id" type="hidden" value="" />
            <tr>
                <td class="formTitle">承运商名称<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="name" type="text" class="form-control" laceholder="请输入承运商名称"
                           isvalid="yes" checkexpession="NotNull"/></td>
                <td class="formTitle">承运商代码<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="code" type="text" class="form-control" laceholder="请输入承运商代码"
                           isvalid="yes" checkexpession="NotNull"/></td>
            </tr>
            <tr>
                <td class="formTitle">承运商类型<font face="宋体">*</font></td>
                <td class="formValue">
                    <div id="carrierType" name="carrierType" type="select" class="ui-select"
                         isvalid="yes" checkexpession="NotNull"  onchange="showOrg()"></div>
                </td>
                <td class="formTitle">指定组织机构</td>
                <td class="formValue">
                    <div id="zdOrganization" name="zdOrganization.id" type="select" class="ui-select"></div>
                </td>
            </tr>
            <tr>

                <td class="formTitle">合同开始时间<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="startTime"  type="text" class="form-control input-wdatepicker" readonly
                           isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker_loong()"/>
                </td>

                <td class="formTitle">合同结束时间<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="endTime"  type="text" class="form-control input-wdatepicker" readonly
                           isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker_loong()" onchange="costDays()"/>
                </td>
            </tr>
            <tr>

                <td class="formTitle">账期（天）</td>
                <td class="formValue">
                    <input id="paymentDays"  type="text" class="form-control"  maxlength="10"
                           isvalid="yes"  checkexpession="IsInterOrNull"/></td>
                <td class="formTitle">合同到期天数</td>
                <td class="formValue">
                    <input id="dqts"  type="number" class="form-control"  readonly/></td>

            </tr>
            <tr>
                <%--<td class="formTitle">联系地址<font face="宋体">*</font></td>--%>
                <%--<td class="formValue">--%>
                    <%--<input id="address" autocomplete="off" type="text" class="form-control" maxlength="125" laceholder="请输入或选择地址"--%>
                           <%--isvalid="yes" checkexpession="NotNull"  />--%>
                    <%--<span class="input-button" onclick="selectReceivers()" title="选择地址" >....</span></td>--%>
                <td class="formTitle">承运商电话</td>
                <td class="formValue">
                    <input id="iphone" type="text" class="form-control"
                           isvalid="yes"  checkexpession="MobileOrPhoneOrNull"/>
                </td>
                    <td class="formTitle">绑定规则</td>
                    <td class="formValue">
                        <div id="rule" name="rule.id" type="selectTree"  class="ui-select"></div>
                    </td>
            </tr>
            <tr>
                <td class="formTitle">负责人</td>
                <td class="formValue">
                    <input id="principal" type="text" class="form-control" />
                </td>
                <td class="formTitle">负责人电话</td>
                <td class="formValue">
                    <input id="principalIphone" type="text" class="form-control"
                           isvalid="yes"  checkexpession="MobileOrPhoneOrNull"/>
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

