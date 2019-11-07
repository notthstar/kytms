<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/01/09 0004
  Time: 下午 7:23
  运单在途
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>

<html >
<head>
    <base href="<%=basePath%>">
    <meta name="viewport" content="width=device-width"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>运单在途</title>
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <link href="/Content/styles/jet-chainCSS2.css" rel="stylesheet"/>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
</head>
<body>

<script>
    var keyValue = request('keyValue');
    var type=request('type');
    $(function () {
        InitialPage();
    });
    //初始化页面
    function InitialPage() {
        //初始化单头信息

        $.SetForm({
            url: "/shipment/getAddressInfo.action",
            param: {id: keyValue },
            success: function (data) {
               var html = "";
                var numberBoole=true;
               for(i=0;i<data.length;i++){
                   var em = data[i];
                   var startTime="";
                   var endTime = "";
                   var id=em[0];
                   var address ="联系人:"+em[5]+"&nbsp&nbsp&nbsp;电话:"+em[6]+"&nbsp&nbsp&nbsp;城市:"+em[4]+"&nbsp&nbsp&nbsp;地址:"+em[7];
                   var name =em[3];
                   var ico =""
                   var button="";
                   var dibu = ""

                   if(i < data.length-1){
                       dibu ='<div class="line pull-in"></div>'
                   }
                   if(em[1]==0){//如果是发货方
                       startTime = "要求发运时间:"+new Date(em[8] ).format("yyyy-MM-dd hh:mm:ss")
                       ico= "fa fa-circle fa-stack-2x text-success";
                       if(em[9] == null || em[9] == undefined || em[9] ==""){
                           endTime = "实际发运时间:未发运"
                           if(numberBoole){
                           button='<button name="buttons" onclick="selectData($(this))" id="'+id+'" class="label bg-success" style="height: 23px;width: 50px">发运</button>'
                           numberBoole=false
                           }
                       }else {
                           endTime ="实际发运时间:"+new Date(em[9] ).format("yyyy-MM-dd hh:mm:ss")
                       }
                   }else { //那就是收货方了
                       startTime = "要求运抵时间:"+new Date(em[8] ).format("yyyy-MM-dd hh:mm:ss")
                       ico= "fa fa-circle fa-stack-2x text-danger";
                       if(em[9] == null || em[9] == undefined || em[9] ==""){
                           endTime = "实际运抵时间:未运抵"
                           if(numberBoole) {
                               button = '<button name="buttons" onclick="selectData($(this))" id="' + id + '" class="label bg-success" style="height: 23px;width: 50px">运抵</button>'
                               numberBoole = false
                           }
                       }else {
                           endTime ="实际运抵时间:"+new Date(em[9] ).format("yyyy-MM-dd hh:mm:ss")
                       }
                   }


                   html+='<article class="media">'
                   html+='<div class="pull-left thumb-small"><span class="fa-stack fa-lg">'
                   html+='<i class="'+ico+'"></i>'
                   html+='<i class="fa fa-flag fa-stack-1x text-white"></i> </span></div>'
                   html+='<div class="media-body">'
                   html+='<div class="pull-right media-mini text-center text-muted">'
                   html+='<strong class="h6">'+startTime+'</strong><br>'
                   html+='<strong class="h6">'+endTime+'</strong><br>'
                   html+='</div>'
                   html+='<a class="h4">'+name+'</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
                   html+=button;
                   html+='<small  class="block">'+address
                   html+='</small>'
                   html+='</div>'
                   html+='</article>'
                   html+=dibu

               }
               $("#ssm").before(html)
               }
        });
      /*  $.SetForm({
            url: "/shipment/selectDispatchFomShipmentBean.action",
            param: {id: keyValue },
            success: function (data) {
               // $("#title").text("在途维护方:"+top.clientdataItem.DispatchSpecifyOrg[data.obj.specifyOrg]);
                if(!data.isTrue){
                    $("button[name='buttons']").remove()
                }

            }
        });*/


    }

    function selectData(self){
        var sb = self.attr("id");
        if (checkedRow(sb)) {
            dialogOpen({
                id: "selectDate",
                title: '时间选择',
                url: '/jsp/Shipment/SelectDate.jsp?keyValue=' + sb+"&shipment="+keyValue,
                width: "310px",
                height: "240px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick(location);
                }
            });
        }

    }
//    <article class="media">
//        <div class="pull-left thumb-small"><span class="fa-stack fa-lg"> <i
//    class="fa fa-circle fa-stack-2x text-danger"></i> <i
//    class="fa fa-file fa-stack-1x text-white"></i> </span></div>
//        <div class="media-body">
//        <div class="pull-right media-mini text-center text-muted"><strong class="h4">17</strong><br>
//        <small class="label bg-light">feb</small>
//        </div>
//        <a href="#" class="h4">Bootstrap documents</a>
//    <small class="block">There are a few easy ways to quickly get started with Bootstrap, each one
//    appealing to a different skill level and use case. Read through to see what suits your
//    particular needs.
//    </small>
//    </div>
//    </article>
</script>
    <section class="panel">
        <header id="title" class="panel-heading"><span class="label bg-info pull-right"></span></header>
        <section id="ssm" class="panel-body">
        </section>
    </section>
</body>
</html>
