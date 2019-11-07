<%--
  Created by IntelliJ IDEA.
  User: sdz
  Date: 2017/3/4
  Time: 12:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragrma","no-cache");
    response.setDateHeader("Expires",0);
%>
<!DOCTYPE html>
<html>
<head>
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>我的桌面</title>
    <!--框架必需start-->
    <link href="/Content/styles/jet-ui.css" rel="stylesheet" />
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <%--@System.Web.Optimization.Styles.Render("~/Content/styles/learun-ui.css")--%>
    <%--@System.Web.Optimization.Scripts.Render("~/Content/scripts/utils/js")--%>
    <!--框架必需end-->
    <!--第三方统计图start-->
    <script src="/Content/scripts/plugins/highcharts/highcharts.js"></script>
    <script src="/Content/scripts/plugins/highcharts/highcharts-more.js"></script>
    <script src="/Content/scripts/plugins/highcharts/modules/exporting.js"></script>
    <!--第三方统计图end-->
    <script>
        $(function () {
            InitialPage();
//            InitialImage();
        })
        //初始化
        function InitialPage() {
            $('#desktop').height($(window).height() - 22);
            $(window).resize(function (e) {
                window.setTimeout(function () {
                    $('#desktop').height($(window).height() - 22);
                }, 200);
                e.stopPropagation();
            });
        }
        //初始化消息
//        function InitialImage(){
//            $.ajax({
//                url:"/notice/getNoticeListTree.action",
//                type:"post",
//                dataType:"json",
//                data:null,
//                success:function(data) {
//                    var mediahtml1="";
//                    var mediahtml2="";
//                    var count1 =0;
//                    var count2 =0;
//                    for (var i = 0; i < data.length; i++) {
//                        if(data[i].type==1){
//                            if(count1>=5){
//                                continue;
//                            }
//                            mediahtml1+= ' <div style="line-height: 39px; border-bottom: 1px solid #ccc;">'+
//                                '  <a href="#" style="text-decoration: none;"  onclick="show(\''+data[i].id+'\')" >['+top.clientdataItem.NoticeType['' + data[i].type + '']+']&nbsp;&nbsp;&nbsp;'+data[i].name+'</a>\n' +
//                                '  <label style="float: right">'+data[i].time+'</label>\n' +
//                                ' </div>';
//
//                            count1++;
//
//                        }else if (data[i].type==0){
//                            if(count2>=5){
//                                continue;
//                            }
//
//                            mediahtml2+= ' <div style="line-height: 39px; border-bottom: 1px solid #ccc;">'+
//                                '  <a href="#" style="text-decoration: none;"  onclick="show(\''+data[i].id+'\')" >['+top.clientdataItem.NoticeType['' + data[i].type + '']+']&nbsp;&nbsp;&nbsp;'+data[i].name+'</a>\n' +
//                                '  <label style="float: right">'+data[i].time+'</label>\n' +
//                                ' </div>';
//
//                            count2++;
//                        }
//
//                    }
//
//                    $('#notice1').after(mediahtml1);
//                    $('#notice2').after(mediahtml2);
//                },
//                error:function(){
//                    alert("发生异常，请重试！");
//                }
//            });
//        }


        //预录单
        function Presco() {
            top.tablist.newTab({
                id: "Presco",
                title: "预录单",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"/jsp/Presco/PrescoIndex.jsp"
            })
        };
        //开单
        function TransportOrder() {
            top.tablist.newTab({
                id: "TransportOrder",
                title: "开单",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"/jsp/TransportOrder/OrderIndex.jsp"

            })
        };
        //派车单
        function Dispatch() {
            top.tablist.newTab({
                id: "DispatchForm",
                title: "派车单",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"/jsp/Single/SingleIndex.jsp"
            })
        };
        //入库
        function OnRepertory() {
            top.tablist.newTab({
                id: "OnRepertory",
                title: "入库",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"/jsp/OnRepertory/OnHand.jsp"

            })
        };
        //运单
        function Shipment() {
            top.tablist.newTab({
                id: "Shipment",
                title: "运单",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"/jsp/Shipment/ShipmentIndex.jsp"
            })
        };
        //在途跟踪
        function ShipmentTrack() {
            top.tablist.newTab({
                id: "ShipmentTrack",
                title: "在途跟踪",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"/jsp/ShipmentTrack/Index.jsp"
            })
        };
        //车辆到站
        function roadVehicles() {
            top.tablist.newTab({
                id: "roadVehicles",
                title: "车辆到站",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"/jsp/RoadVehicles/vehicleArriveIndex.jsp"
            })
        };
        //货物到站
        function ArrivalVehicle() {
            top.tablist.newTab({
                id: "ArrivalVehicle",
                title: "货物到站",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"/jsp/RoadVehicles/goodsArrive.jsp"
            })
        };
        //到库
        function OnRepertory1() {
            top.tablist.newTab({
                id: "OnRepertory",
                title: "到库",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"\t/jsp/OnRepertory/OnHand.jsp"
            })
        };
        //中转单
        function Transfer() {
            top.tablist.newTab({
                id: "Transfer",
                title: "中转单",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"/jsp/Transfer/TransferIndex.jsp"
            })
        };
        //签收登记
        function ShipmentBack() {
            top.tablist.newTab({
                id: "ShipmentBack",
                title: "签收登记",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"/jsp/ShipmentBack/Index.jsp"
            })
        };
        //回单管理
        function OrderBack() {
            top.tablist.newTab({
                id: "OrderBack",
                title: "订单回单",
                closed: true,
                icon: "fa fa fa-user",
                url: top.contentPath+"/jsp/OrderBack/Index.jsp"
            })
        };


    </script>
</head>
<body>
<div class="border" id="desktop" style="margin: 10px 10px 0 10px; background: #fff; overflow: auto;">
    <div class="portal-panel">
        <div class="row">
            <div class="portal-panel-title">
                <i class="fa fa-balance-scale"></i>&nbsp;&nbsp;操作流程图
            </div>
            <div class="portal-panel-content" style="margin-top: 15px;">
                <div id="my_div" style="background:url(liuchengtu.jpg); width:1100px;height:505px;" />
                <a><img align="left" style="margin-left: 250px;margin-top: 0px" src="kehu.jpg"></a>
                <a onclick="Presco()"><img align="left" style="margin-left: -135px;margin-top: 60px" src="yuludan.jpg"></a>
                <a onclick="TransportOrder()"><img align="left" style="margin-left: 0px;margin-top: 60px" src="shoulikaidan.jpg"></a>
                <a onclick="Dispatch()"><img align="left" style="margin-left: -200px;margin-top: 175px" src="paichedan.jpg"></a>
                <a onclick="OnRepertory()"><img align="left" style="margin-left: -60px;margin-top: 172px" src="fahuokucun.jpg"></a>
                <a onclick="Shipment()"><img align="left" style="margin-left: -60px;margin-top: 280px" src="yundanpeizai.jpg"></a>
                <a onclick="ShipmentTrack()"><img align="left" style="margin-left: -60px;margin-top: 380px" src="zaitugenzong.jpg"></a>
                <a onclick="roadVehicles()"><img align="left" style="margin-left: 35px;margin-top: 380px" src="cheliangdaozhan.jpg"></a>
                <a onclick="ArrivalVehicle()"><img align="left" style="margin-left: 40px;margin-top: 380px" src="huowudaozhan.jpg"></a>
                <a onclick="OnRepertory1()"><img align="left" style="margin-left: 40px;margin-top: 380px" src="daohuokucun.jpg"></a>
                <a ><img align="left" style="margin-left: 70px;margin-top: 440px" src="kehutihuo.jpg"></a>
                <a onclick="Dispatch()"><img align="left" style="margin-left: -60px;margin-top: 370px" src="songhuoshangmen.jpg"></a>
                <a onclick="Transfer()"><img align="left" style="margin-left: -60px;margin-top: 290px" src="zhongzhuandan.jpg"></a>
                <a onclick="ShipmentBack()"><img align="left" style="margin-left: 65px;margin-top: 370px" src="qianshoudengji.jpg"></a>
                <a onclick="OrderBack()"><img align="left" style="margin-left: -55px;margin-top: 155px" src="huidan.jpg"></a>
                <a onclick="Shipment()"><img align="left" style="margin-left: -415px;margin-top: 155px" src="waizhuandan.jpg"></a>
                <a onclick="ShipmentTrack()"><img align="left" style="margin-left: -185px;margin-top: 155px" src="zaitugenzong.jpg"></a>

            </div>
            <style>
                #my_div{width:1100px;height:505px;overflow:hidden;float:left}
            </style>
        </div>
    </div>
</div>
</div>
</body>
</html>
