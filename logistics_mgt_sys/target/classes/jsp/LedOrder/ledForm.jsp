<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/12/12
  Time: 13:34
  To change this template use File | Settings | File Templates.
   //修改件重尺
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
</head>
<body>
<script>
    var keyValue = request('keyValue');
    var number = request('number');
    var weight = request('weight');
    var volume = request('volume');
    //初始化控件
    $(function () {
        if(number != null){
            $("#oldnumber").val(number);
            $("#newnumber").val(number);
        }else{
            $("#oldnumber").val(0);
        }
        if(weight != null){
            $("#oldweight").val(weight);
            $("#newweight").val(weight);
        }else{
            $("#oldweight").val(0);
        }
        if(volume != null){
            $("#oldvolume").val(volume);
            $("#newvolume").val(volume);
        }else{
            $("#oldvolume").val(0);
        }
    });
    //保存表单
    function AcceptClick() {
      var parm = {
          id:keyValue,
          oldnumber:number,
          oldweight:weight,
          oldvolume:volume,
          newnumber:$("#newnumber").val(),
          newweight:$("#newweight").val(),
          newvolume:$("#newvolume").val()
      }
        $.SaveFormAsync({
            url: "/transportorder/updateJZC.action",
            param:parm,
            loading: "正在保存数据...",
            success: function (data) {
                if(data.result){
                    $.currentIframe().$("#gridTable").trigger("reloadGrid");
                    dialogMsg('操作成功', 1);
                    dialogClose();//关闭窗口
                }else {
                    dialogMsg(data.obj, 0);
                }

//                        dialogMsg('操作成功', 1);
//                        win.reload();
//                        dialogClose();//关闭窗口
            }
        })
    }
</script>
<table class="form">
    <input id="id" name="id" type="hidden" value="" />
    <tr >
        <th style="padding-top: 60px;" class="formTitle">原数量<font face="宋体"></font></th>
        <td class="formValue" style="padding-top: 60px">
            <input id="oldnumber" type="text" disabled="disabled" readonly="readonly"  class="form-control"/>
        <th style="padding-top: 60px;" class="formTitle">原重量<font face="宋体"></font></th>
        <td class="formValue" style="padding-top: 60px">
            <input id="oldweight" type="text" disabled="disabled" readonly="readonly"  class="form-control"/>
        <th style="padding-top: 60px;" class="formTitle">原体积<font face="宋体"></font></th>
        <td class="formValue" style="padding-top: 60px">
            <input id="oldvolume" type="text" disabled="disabled" readonly="readonly"  class="form-control"/>
    </tr>
    <tr >
        <th style="padding-top: 60px;" class="formTitle">新数量<font face="宋体"></font></th>
        <td class="formValue" style="padding-top: 60px">
            <input id="newnumber" value="0" type="text"   class="form-control"/>
        <th style="padding-top: 60px;" class="formTitle">新重量<font face="宋体"></font></th>
        <td class="formValue" style="padding-top: 60px">
            <input id="newweight" value="0" type="text" class="form-control"/>
        <th style="padding-top: 60px;" class="formTitle">新体积<font face="宋体"></font></th>
        <td class="formValue" style="padding-top: 60px">
            <input id="newvolume" value="0" type="text" class="form-control"/>
    </tr>
</table>
</body>
</html>