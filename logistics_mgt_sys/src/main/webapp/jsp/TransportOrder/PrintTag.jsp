
<%--
  Created by IntelliJ IDEA.
  User:孙德增
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
    <%--打印及插件--%>
    <script src="/Content/lodopPrint/LodopFuncs.js"></script>
    <object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
    </object>
</head>
<body>
    <script>
        var datas = null
        var id = request('id');
        var LODOP;
        //初始化控件
        $(function () {
            $.SetForm({
                url: "/transportorder/getOrderPrint.action",
                param: {id: id},
                async:false,
                success: function (data) {
                    $("#start").val(1)
                    $("#number").val(data.number)
                    $("#end").val(data.number)
                    datas = data;
                }
            })
        });
        //保存表单
        function AcceptClick(win) {


            var start = $("#start").val()
            var end = $("#end").val()
            if(start <1){
                alert("初始数量不能小于0");
            }
            if(datas == null){
                alert("出错");
            }
            LODOP=getLodop();
            LODOP.PRINT_INITA(-1,-1,400,250,"标签打印");
            LODOP.SET_PRINT_MODE("PRINT_NOCOLLATE",1);
            for (i = start; i <= end; i++) {
                LODOP.NewPage();
            LODOP.SET_PRINT_PAGESIZE(1,800.0,500.0,"B5")
            LODOP.ADD_PRINT_TEXT(28,7,100,20,datas.timeYear + "-"+datas.timeMonht + "-"+datas.timeDay);
            LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
            LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
            LODOP.SET_PRINT_STYLEA(0,"Bold",1);
            LODOP.ADD_PRINT_TEXT(28,123,100,20,datas.transportPro);
            LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
            LODOP.SET_PRINT_STYLEA(0,"Bold",1);
            LODOP.ADD_PRINT_TEXT(67,14,100,25,datas.startZone);
            LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
            LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
            LODOP.SET_PRINT_STYLEA(0,"Bold",1);
            LODOP.ADD_PRINT_TEXT(52,111,54,34,"→");
            LODOP.SET_PRINT_STYLEA(0,"FontSize",34);
            LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
            LODOP.SET_PRINT_STYLEA(0,"Bold",1);
            LODOP.ADD_PRINT_TEXT(66,166,100,25,datas.endZone);
            LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
            LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
            LODOP.SET_PRINT_STYLEA(0,"Bold",1);
            LODOP.ADD_PRINT_TEXT(97,11,173,40,"单号："+datas.relatebill1);
            LODOP.SET_PRINT_STYLEA(0,"FontSize",17);
            LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
            LODOP.SET_PRINT_STYLEA(0,"Bold",1);
            LODOP.ADD_PRINT_TEXT(139,150,130,30,"件数 "+datas.number+"-"+i);
            LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
            LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
            LODOP.SET_PRINT_STYLEA(0,"Bold",1);
            LODOP.ADD_PRINT_TEXT(139,5,133,30,"收货人："+datas.SHF.contactperson);
            LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
            LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
            LODOP.SET_PRINT_STYLEA(0,"Bold",1);

            }
            LODOP.PREVIEW();
          // LODOP.PRINT_DESIGN();
            dialogClose()

        }
    </script>
            <table class="form">
                <tr >
                    <th  class="formTitle" style="padding-top: 60px">总数量<font face="宋体"></font></th>
                    <td class="formValue" style="padding-top: 60px">
                        <input id="number" disabled type="number"   value="0"  class="form-control"/>
                    </td>
                </tr>
                <tr >
                    <th class="formTitle">初始数量<font face="宋体"></font></th>
                    <td class="formValue" >
                        <input id="start" type="number"   value="1"  class="form-control"/>
                    </td>
                </tr>
                <tr >
                    <th  class="formTitle">结束数量<font face="宋体"></font></th>
                    <td class="formValue" >
                        <input id="end" type="number"   value="0"  class="form-control"/>
                    </td>
                </tr>

            </table>
</body>
</html>