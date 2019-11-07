<%--
  Created by IntelliJ IDEA.
  User: 孙德增
  Date: 2018/5/24
  Time: 9:08
  To change this template use File | Settings | File Templates.
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
    <title>费用结算</title>
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
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
</head>
<body>
<form id="form1">

    <script>
        $(function () {
            initControl();

        })
        //初始化控件

        function initControl() {
            $("#abc").hide();
            $("#projectManagement").ComboBoxTree({ //项目名称
                height: "200px",
                url:'/projectManagement/getProjectManagementNew.action',
                description: "==请选择=="
            });
            $("#type").ComboBox({ //项目名称
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.JSLX
            });
        }
        function queryReport(){
            var start;
            var end;
            var type=$("#type").text();
            var prmt =$("#projectManagement").text();
                //获取开始时间和结束时间
                //var xmmc =$("#projectManagement").text();
                if (type == "按发运日期") {
                    start = $("#beginTime").val().substring(0, 10);
                    end = $("#endTime").val().substring(0, 10);
                    var rpg = "项目按发运日期预结算报表组.rpg"; //报表名称
                    var getUrl = "reportJsp/showReportGroup.jsp"//报表请求URL地址
                    var url = getUrl + "?rpg=" + rpg + "&arg1=" + prmt+ "&arg2=" + start + "&arg3=" + end//按发运日期结算
                    if(type.trim() != "==请选择==" && prmt.trim() != "==请选择=="){
                        dialogOpen({
                            id: "anxiangmufayunriqiyujesuan",
                            title: '按项目发运日期预结算',
                            url: url,
                            width: "1200px",
                            height: "1000px",
                            btn: ['确认预结算', '取消'],
                            callBack: function (iframeId) {
                                prmt = prmt.trim();
                                start = $("#beginTime").val();
                                end = $("#endTime").val();
                                yjsb(prmt, type, start, end);
                            }
                        });
                    }else{
                        alert("请填写下面信息")
                    }
                }else{
                    var rpg = "按项目预结算报表组.rpg"; //报表名称
                    var getUrl = "reportJsp/showReportGroup.jsp"//报表请求URL地址
                    var url = getUrl + "?rpg=" + rpg +"&arg1=" + prmt//全结算
            if(type.trim() != "==请选择==" && prmt.trim() != "==请选择=="){
                dialogOpen({
                    id: "anxiangmuyuquanjiesuan",
                    title: '按项目预全结算表',
                    url: url,
                    width: "1200px",
                    height: "1000px",
                    btn: ['确认预结算', '取消'],
                    callBack: function (iframeId) {
                        prmt = prmt.trim();
                        ysqjs(prmt, type);

                    }
                });
            }else{
                alert("请填写下面信息")
            }
                }
        }
        function ycshi(type) {
            if($("#type").text() =="全结算"){
                $("#abc").hide();
            }else{
                $("#abc").show();
            }
        }
        function yjsb(prmt,type,start,end){
            $.ajax({
                url: "/settlement/updateSta.action?prmt="+prmt+"&type="+type+"&start="+start+"&end="+end,
                type:"post",
                async:false,
                dataType : 'JSON',
                loading: "正在保存数据...",
                success:function(data) {
                    dialogAlert(data)
                    dialogClose();
                    window.close();
                }
            })
        }
        function ysqjs(prmt,type){
            $.ajax({
                url: "/settlement/updateSta1.action?prmt="+prmt+"&type="+type,
                type:"post",
                async:false,
                dataType : 'JSON',
                loading: "正在保存数据...",
                success:function(data) {
                   dialogAlert(data)
                    dialogClose();
                    window.close();
                }
            })
        }
        //保存表单
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#BaseInfo" data-toggle="tab">费用结算</a></li>
            <div class="btn-group"style="padding-left: 500px"  >
                <a id="lr-replace"  class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
                <a id="lr-add"  class="btn btn-default" onclick="queryReport()"><i class="fa fa-plus"></i>&nbsp;预结算</a>
            </div>
        </ul>

        <div class="tab-content" style="padding-top: 15px;">
            <table class="form" id = ysshtz>
                <input id="id" name="id" type="hidden" value=""/>
                <tr>
                    <th class="formTitle" style="color: crimson" >注:1.全结算：当前平台没有结算的，全部结算不分日期。2.按发运日期结算</th>
                </tr>
                <tr>
                    <th class="formTitle">项目名称<font face="宋体">*</font></th>
                    <td class="formValue">
                    <div id="projectManagement" type="selectTree" class="ui-select" isvalid="yes"  checkexpession="NotNull"/>
                    </td>
                    <th class="formTitle">结算方式<font face="宋体">*</font></th>
                    <td class="formValue">
                        <div id="type" onchange="ycshi(type)" type="selectTree" class="ui-select" isvalid="yes"  checkexpession="NotNull"/>
                    </td>
                </tr>
                    <tr id="abc">
                    <th class="formTitle">开始时间</th>
                    <td class="formValue">
                        <input id="beginTime" type="text"   readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                    </td>
                    <th class="formTitle">结束时间</th>
                    <td class="formValue">
                        <input id="endTime" type="text"     readonly="readonly"  class="form-control input-wdatepicker" isvalid="yes"  checkexpession="NotNull"  onfocus="WdatePicker()"/>
                    </td>
                </tr>

            </table>

        </div>

    </div>
</form>
</body>
</html>