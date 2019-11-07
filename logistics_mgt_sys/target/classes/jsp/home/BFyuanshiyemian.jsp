<%--
  Created by IntelliJ IDEA.
  User: nidaye
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
            LoadInterfaceVisit();
            LoadDepartmentApp();
            InitialImage();
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
        function InitialImage(){
            $.ajax({
                url:"/notice/getNoticeListTree.action",
                type:"post",
                dataType:"json",
                data:null,
                success:function(data) {
                    var mediahtml1="";
                    var mediahtml2="";
                    var count1 =0;
                    var count2 =0;
                    for (var i = 0; i < data.length; i++) {
                        if(data[i].type==1){
                            if(count1>=5){
                                continue;
                            }
                            mediahtml1+= ' <div style="line-height: 39px; border-bottom: 1px solid #ccc;">'+
                                '  <a href="#" style="text-decoration: none;"  onclick="show(\''+data[i].id+'\')" >['+top.clientdataItem.NoticeType['' + data[i].type + '']+']&nbsp;&nbsp;&nbsp;'+data[i].name+'</a>\n' +
                                '  <label style="float: right">'+data[i].time+'</label>\n' +
                                ' </div>';

                            count1++;

                        }else if (data[i].type==0){
                            if(count2>=5){
                                continue;
                            }

                            mediahtml2+= ' <div style="line-height: 39px; border-bottom: 1px solid #ccc;">'+
                                '  <a href="#" style="text-decoration: none;"  onclick="show(\''+data[i].id+'\')" >['+top.clientdataItem.NoticeType['' + data[i].type + '']+']&nbsp;&nbsp;&nbsp;'+data[i].name+'</a>\n' +
                                '  <label style="float: right">'+data[i].time+'</label>\n' +
                                ' </div>';

                            count2++;
                        }

                    }

                    $('#notice1').after(mediahtml1);
                    $('#notice2').after(mediahtml2);
                },
                error:function(){
                    alert("发生异常，请重试！");
                }
            });
        }

        function  show(keyValue) {
            //alert(keyValue)
            dialogOpen({
                id: "From",
                title: '通告信息',
                url: '/jsp/System/Notice/NoticeForm.jsp?keyValue='+ keyValue,
                width: "800px",
                height: "525px"
            });
        }

        //访问流量图表
        function LoadInterfaceVisit() {
            var chart = new Highcharts.Chart({
                chart: {
                    renderTo: 'piecontainer',
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    defaultSeriesType: 'pie'
                },
                title: {
                    text: ''
                },
                exporting: {
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                tooltip: {
                    formatter: function () {
                        return '<b>' + this.point.name + '</b>: ' + this.percentage.toFixed(2) + ' %';
                    }
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true, //点击切换
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            formatter: function () {
                                return '<b>' + this.point.name + '</b>: ' + this.percentage.toFixed(2) + ' %';
                            }
                        },
                        showInLegend: true
                    }
                },
                //series:abc()
                series: [{
                    data:abc()
                    //   data:([["沈阳",100],["长春",100]])
                }]
            });
        }
        function abc(){
            var returndata = null;
            $.ajax({
                url: "/vehicleHead/getOrgVelList.action",
                type:"post",
                async:false,
                dataType : 'JSON',
                success:function(data) {
                    returndata = data;
                }
            })
            return returndata;
        }
        //部门应用图表
        function LoadDepartmentApp() {
            $('#container').highcharts({
                chart: {
                    type: 'spline'
                },
                title: {
                    text: ''
                },
                xAxis: {
                    categories:yuefen()
                    //categories: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
                },
                yAxis: {
                    title: {
                        text: '运费'
                    },
                    labels: {
                        formatter: function () {
                            return this.value + '元'
                        }
                    }
                },
                exporting: {
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                tooltip: {
                    crosshairs: true,
                    shared: true
                },
                plotOptions: {
                    spline: {
                        marker: {
                            radius: 4,
                            lineColor: '#666666',
                            lineWidth: 1
                        }
                    }
                },
                series: [{
                    name: '收入',
                    marker: {
                        symbol: 'square'
                    },
                    data:shouru()
                    //data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 23.3, 18.3, 13.9, 9.6, 1]

                }, {
                    name: '成本',
                    marker: {
                        symbol: 'diamond'
                    },
                    data:chengben()
                    // data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
                }]
            });

        }
        function shouru(){
            var shouru = null;
            $.ajax({
                url: "/orderledger/getAmoutMouth.action",
                type:"post",
                async:false,
                dataType : 'JSON',
                success:function(data) {
                    shouru = data;
                }
            })
            return shouru;
        }
        function chengben() {
            var chengben = null;
            $.ajax({
                url: "/shipmentLedger/getCBAmoutMouth.action",
                type:"post",
                async:false,
                dataType : 'JSON',
                success:function(data) {
                    chengben = data;
                }
            })
            return chengben;
        }
        function yuefen(){
            var yuefen = null;
            $.ajax({
                url: "/shipmentLedger/getMouth.action",
                type:"post",
                async:false,
                dataType : 'JSON',
                success:function(data) {
                    yuefen = data;
                }
            })
            return yuefen;
        }
        //跳转到指定模块菜单
        function OpenNav(Navid) {
            top.$("#nav").find('a#' + Navid).trigger("click");
        }
        $("document").ready(function (){
            var returndata = null;
            $.ajax({
                url: "/transportorder/selectCont.action",
                type:"post",
                async:false,
                dataType : 'JSON',
                success:function(data) {
                    //document.getElementById('ddsl').innerHTML= data;
                    $("#ddsl").text(data);
                }
            })
        })
        $("document").ready(function (){
            var returndata = null;
            $.ajax({
                url: "/vehicleHead/selectCont.action",
                type:"post",
                async:false,
                dataType : 'JSON',
                success:function(data) {
                    //document.getElementById('ddsl').innerHTML= data;
                    $("#xzcl").text(data);
                }
            })
        })
        $("document").ready(function (){
            var returndata = null;
            $.ajax({
                url: "/orderledger/selectCont.action",
                type:"post",
                async:false,
                dataType : 'JSON',
                success:function(data) {
                    //document.getElementById('ddsl').innerHTML= data;
                    $("#xsze").text(data);
                }
            })
        })
        $("document").ready(function (){
            var returndata = null;
            $.ajax({
                url: "/orderledger/selectLR.action",
                type:"post",
                async:false,
                dataType : 'JSON',
                success:function(data) {
                    //document.getElementById('ddsl').innerHTML= data;
                    $("#lrze").text(data);
                }
            })
        })
    </script>
</head>
<body>
<div class="border" id="desktop" style="margin: 10px 10px 0 10px; background: #fff; overflow: auto;">
    <div class="portal-panel">
        <div class="row">
            <div class="portal-panel-title">
                <i class="fa fa-balance-scale"></i>&nbsp;&nbsp;统计指标
            </div>
            <div class="portal-panel-content" style="margin-top: 15px; overflow: hidden;">
                <div class="row">
                    <div style="width: 20%; position: relative; float: left;">
                        <div class="task-stat" style="background-color: #578ebe;">
                            <div class="visual">
                                <i class="fa fa-pie-chart"></i>
                            </div>
                            <div class="details">
                                <div id="ddsl" class="number"></div>
                                <div class="desc">订单数量</div>
                            </div>
                            <a class="more" style="background-color: #4884b8;" href="javascript:;" onclick="OpenNav('66f6301c-1789-4525-a7d2-2b83272aafa6')">查看更多 <i class="fa fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>
                    <div style="width: 20%; position: relative; float: left;">
                        <div class="task-stat" style="background-color: #e35b5a;">
                            <div class="visual">
                                <i class="fa fa-bar-chart-o"></i>
                            </div>
                            <div class="details">
                                <div id="" class="number">
                                    266
                                </div>
                                <div class="desc">
                                    即将到站
                                </div>
                            </div>
                            <a class="more" style="background-color: #e04a49;" href="javascript:;" onclick="OpenNav('1d3797f6-5cd2-41bc-b769-27f2513d61a9')">查看更多 <i class="fa fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>
                    <div style="width: 20%; position: relative; float: left;">
                        <div class="task-stat" style="background-color: #44b6ae;">
                            <div class="visual">
                                <i class="fa fa-windows"></i>
                            </div>
                            <div class="details">
                                <div id="xzcl" class="number"></div>
                                <div class="desc">
                                    闲置车辆
                                </div>
                            </div>
                            <a class="more" style="background-color: #3ea7a0;" href="javascript:;" onclick="OpenNav('b352f049-4331-4b19-ac22-e379cb30bd55')">查看更多 <i class="fa fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>
                    <div style="width: 20%; position: relative; float: left;">
                        <div class="task-stat" style="background-color: #8775a7;">
                            <div class="visual">
                                <i class="fa fa-globe"></i>
                            </div>
                            <div class="details">
                                <div id="xsze" class="number"></div>
                                <div class="desc">
                                    销售总额
                                </div>
                            </div>
                            <a class="more" style="background-color: #7c699f;" href="javascript:;">查看更多 <i class="fa fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>
                    <div style="width: 20%; position: relative; float: left;">
                        <div class="task-stat" style="background-color: #3598dc;">
                            <div class="visual">
                                <i class="fa fa-globe"></i>
                            </div>
                            <div class="details">
                                <div id="lrze" class="number"></div>
                                <div class="desc">
                                    利润总额
                                </div>
                            </div>
                            <a class="more" style="background-color: #258fd7;" href="javascript:;">查看更多 <i class="fa fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="overflow: hidden; margin-bottom: 10px;">
            <div style="width: 45%; float: left;">
                <div class="portal-panel-title">
                    <i class="fa fa-coffee"></i>&nbsp;&nbsp;最新动态（Top 5）
                </div>
                <div id="notice1" class="portal-panel-content" style="overflow: hidden; padding-top: 20px; padding-left: 30px; padding-right: 50px;">

                </div>
            </div>
            <div style="width: 45%; float: right;">
                <div class="portal-panel-title">
                    <i class="fa fa-bullhorn"></i>&nbsp;&nbsp;系统公告（Top 5）
                </div>
                <div id="notice2" class="portal-panel-content" style="overflow: hidden; padding-top: 20px; padding-left: 30px; padding-right: 50px;">

                </div>
            </div>
        </div>
        <div class="row" style="overflow: hidden; height: 460px;">
            <div style="width: 50%; float: left;">
                <div id ="abc" class="portal-panel-title">
                    <i class="fa fa-bar-chart"></i>&nbsp;&nbsp;公司车辆占比
                </div>
                <div class="portal-panel-content" style="margin-top: 10px; overflow: hidden;">
                    <div id="piecontainer">
                    </div>
                </div>
            </div>
            <div style="width: 50%; float: left;">
                <div class="portal-panel-title">
                    <i class="fa fa-bar-chart"></i>&nbsp;&nbsp;本年收入成本浮动表
                </div>
                <div class="portal-panel-content" style="margin-top: 10px; overflow: hidden;">
                    <div id="container"></div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
