<%--
  Created by IntelliJ IDEA.
  User: cxl
  Date: 2018-1-5
  Time: 11:42
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
    <script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.10&key=49df3dbb93cc593e8cceedfe8f8be185"></script>
    <script src="/Content/scripts/utils/jet-gd.js"></script>
</head>
<body>
<form id="form1">

    <script>
        var keyValue = request('keyValue');
        $(function () {
            InitialPage();
            initControl();
            sybds();
            getMapDataFroIdAddress("address", "ltl","detailedAddress");
            getMapDataFroIdAddress("shaddress", "shltl","shdetailedAddress");
        });
        function  InitialPage() {
            $("#settlementType").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.Clearing
            });
            $("#jcRegistration").ComboBoxTree({
                url: "/jcRegistration/getJcRegistrationTree.action",
                description: "==请选择==",
                height: "200px",
            });
            $("#zone").ComboBoxTree({
                url: "zone/getCity.action",
                description: "==请选择城市==",
                height: "200px",
                allowSearch:true
            });
            $("#sftb").ComboRadio({
                data: top.clientdataItem.CommIsNot,
                defaultVaue: '0'
            });
            $("#rule").ComboBoxTree({
                url: "rule/getRuleTree.action",
                description: "==请选择规则==",
                height: "200px",
                allowSearch:true
            });
        }

        //初始化控件
        function initControl() {
            //加载自定义表单
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "/customer/selectBean.action",
                    param: { tableName:"JC_CUSTOMER",id: keyValue },
                    success: function (data) {
                        if(data.zone!=null){
                            //城市下拉树赋值
                            $("#zone").ComboBoxTreeSetValue(data.zone.id);
                        }
                        //注册公司赋值
                        $("#jcRegistration").ComboBoxTreeSetValue(data.jcRegistration.id);
                        if(data.rule != null){
                            $("#rule").ComboBoxTreeSetValue(data.rule.id);
                            // $("#rule").val(data.rule.id);
                        }
                      //  $("input:radio[name='sftb'][value='"+data.sftb+"']").attr("checked","checked");
                        //不加这个就报错，鬼知道为啥
                        data.zone=null;
                      //  data.rule =null;
                        //格式化日期
                        data.startTime=data.startTime.substr(0,10);
                        data.endTime=data.endTime.substr(0,10);
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
        //    console.log($("#rule").val())
          //  postData["rule.id"] = $("#rule").val();
            $.SaveForm({
                url: "/customer/saveCustomer.action",
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
                }
            })
            //格式化日期
            formatDay();
        }

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
        
        //格式化日期
        function formatDay() {
            var st=$("#startTime").val().substr(0,10);
            var et=$("#endTime").val().substr(0,10);
            $("#startTime").val(st);
            $("#endTime").val(et);
        }
        function sybds(){
            var aa =  $('input:radio[name="sftb"]:checked').val();
            if(aa == 0){
                $("#ss_fxmId").attr('disabled','disabled');
                $("#ss_fxmName").attr('disabled','disabled');
                $("#haha").hide();
            }else{
                $("#ss_fxmId").removeAttr('disabled','disabled');
                $("#ss_fxmName").removeAttr('disabled','disabled');
                $("#haha").show();
            }
        }
        function getRulec() {
            dialogOpen({
                id: "RuleFrom",
                title: '规则选择',
                url: 'jsp/Rule/RuleIndex.jsp?status=1',
                width: "1050px",
                height: "450px",
                callBack: function (iframeId) {
                    var resule = top.frames[iframeId].getRulett();
                    $("#rule").val(resule.id);
                    $("#ruleName").val(resule.code);
                    top.frames[iframeId].dialogClose();//关闭窗口
                }
            });

        }


    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
            <table class="form">
                <input id="id" name="id" type="hidden" value="" />
                <tr>
                    <td class="formTitle">所属注册公司<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="jcRegistration" name="jcRegistration.id" type="selectTree"  class="ui-select"
                             isvalid="yes" checkexpession="NotNull">
                        </div>
                    </td>
                    <td class="formTitle">绑定规则<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="rule" name="rule.id" type="selectTree"  class="ui-select"></div>
                        <%--<input id="rule" autocomplete="off" name="rule.id" type="hidden" value=""/>--%>
                        <%--<input id="ruleName"  autocomplete="off" onclick="getRulec()"  type="text" class="form-control"  />--%>
                        <%--<span  id="onclick1" class="input-button" onclick="getRulec()" title="规则" >.......</span>--%>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">客户名称<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="name" autocomplete="off" type="text" class="form-control" laceholder="请输入客户名称"
                               isvalid="yes" checkexpession="NotNull"/>
                    </td>
                    <td class="formTitle">合同编号<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="code" autocomplete="off" type="text" class="form-control" laceholder="请输入合同编号"
                               isvalid="yes" checkexpession="NotNull"/>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">销售负责人</td>
                    <td class="formValue">
                        <input id="salePersion" autocomplete="off" type="text" class="form-control" maxlength="10"/>
                    </td>
                    <td class="formTitle">结算方式<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="settlementType" name="settlementType" type="select" class="ui-select"
                             isvalid="yes" autocomplete="off" checkexpession="NotNull"></div>
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
                        <input id="paymentDays"  type="text" class="form-control" maxlength="5"
                               isvalid="yes"  checkexpession="IsInterOrNull"/></td>
                    <td class="formTitle">合同到期天数</td>
                    <td class="formValue">
                        <input id="dqts"  type="number" class="form-control"  readonly/></td>

                </tr>
                <tr>

                    <td class="formTitle">城市<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="zone" name = "zone.id" type="select" class="ui-select" laceholder="请选择城市"
                             isvalid="yes"  checkexpession="NotNull" >
                            <ul></ul>
                        </div>
                    </td>
                    <td class="formTitle">发货联系人<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="contactperson" autocomplete="off"  isvalid="yes" checkexpession="NotNull" type="text" class="form-control" maxlength="10"/></td>

                </tr>
                <tr>

                    <td class="formTitle">发货客户地址<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="address"  autocomplete="off" type="text" class="form-control" maxlength="125" laceholder="请输入或选择地址"
                               isvalid="yes" checkexpession="NotNull" onchange='getlal()' />
                        <span class="input-button" onclick="selectReceivers()" title="选择地址" >....</span>
                    </td>
                    <td class="formTitle">发货经纬度<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="ltl" type="text" class="form-control"
                               isvalid="yes" autocomplete="off" checkexpession="NotNull" disabled=true /></td>
                </tr>
                <tr>
                    <td class="formTitle">详细地址<font face="宋体">*</font></td>
                    <td class="formValue" colspan="3">
                        <input id="detailedAddress" type="text" class="form-control"
                               isvalid="yes" autocomplete="off" checkexpession="NotNull" /></td>
                </tr>
                <tr>

                <td class="formTitle">客户电话<font face="宋体">*</font></td>
                <td class="formValue">
                    <input id="iphone"  type="text" class="form-control"  laceholder="请输入电话"
                           isvalid="yes" autocomplete="off" checkexpession="MobileOrPhone"/></td>
                <td class="formTitle">EMAL</td>
                <td class="formValue">
                    <input id="email" autocomplete="off" type="text" class="form-control"
                           isvalid="yes"  checkexpession="EmailOrNull"/></td>

            </tr>
           <tr> <td class="formTitle">--------------------------------------------------------------------------------------------------------------------------------------------</td></tr>
                <tr>
                    <td class="formTitle">收货联系人</td>
                    <td class="formValue">
                        <input id="shcontactperson" autocomplete="off"  type="text" class="form-control" maxlength="10"/></td>
                    <td class="formTitle">收货单位</td>
                    <td class="formValue">
                        <input id="shdanwei" autocomplete="off"   type="text" class="form-control" maxlength="10"/></td>
                </tr>
                <tr>

                    <td class="formTitle">收货客户地址</td>
                    <td class="formValue">
                        <input id="shaddress"  autocomplete="off" type="text" class="form-control" maxlength="125" laceholder="请输入或选择地址"
                                onchange='getlal()' />
                        <span class="input-button" onclick="selectReceivers()" title="选择地址" >....</span>
                    </td>
                    <td class="formTitle">收货经纬度</td>
                    <td class="formValue">
                        <input id="shltl" type="text" class="form-control"
                                autocomplete="off"  disabled=true /></td>
                </tr>
                <tr>
                    <td class="formTitle">收货人电话</td>
                    <td class="formValue">
                        <input id="shiphone"  type="text" class="form-control"  laceholder="请输入电话"
                               autocomplete="off" /></td>
                </tr>
                <tr>
                    <td class="formTitle">收货详细地址</td>
                    <td class="formValue" colspan="3">
                        <input id="shdetailedAddress" type="text" class="form-control"
                                autocomplete="off"  /></td>
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