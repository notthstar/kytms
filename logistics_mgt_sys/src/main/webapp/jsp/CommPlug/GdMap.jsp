<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2018/1/4
  Time: 15:57
  To change this template use File | Settings | File Templates.
  高德地图，拖拽选址
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
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
    <base href="//webapi.amap.com/ui/1.0/ui/misc/PositionPicker/examples/" />
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>拖拽选址</title>
    <style>
        html,
        body {
            height: 100%;
            margin: 0;
            width: 100%;
            padding: 0;
            overflow: hidden;
            font-size: 13px;
        }

        .map {
            height: 100%;
            width: 75%;
            float: left;
        }

        #right {
            color: #444;
            background-color: #f8f8f8;
            width: 25%;
            float: left;
            height: 100%;
        }

        #start,
        #stop,
        #right input {
            margin: 4px;
            margin-left: 15px;
        }

        .title {
            width: 100%;
            background-color: #dadada
        }

        button {
            border: solid 1px;
            margin-left: 15px;
            background-color: #dadafa;
        }

        .c {
            font-weight: 600;
            padding-left: 15px;
            padding-top: 4px;
        }

        #lnglat,
        #address,
        #nearestJunction,
        #nearestRoad,
        #nearestPOI,
        .title {
            padding-left: 15px;
        }
    </style>
</head>

<body>
<div id="container" class="map" tabindex="0"></div>
<div id='right'>
    <div>
        <button id='start'>开始选点</button>
        <button id='stop'>关闭选点</button>
    </div>
    <div>
        <div class='title'>选址结果</div>
        <div class='c'>经纬度:</div>
        <div id='lnglat'></div>
        <div class='c'>地址:</div>
        <div id='address'></div>
    </div>
</div>
<script type="text/javascript" src='//webapi.amap.com/maps?v=1.4.3&key=49df3dbb93cc593e8cceedfe8f8be185&plugin=AMap.ToolBar'></script>
<!-- UI组件库 1.0 -->
<script src="//webapi.amap.com/ui/1.0/main.js?v=1.0.11"></script>
<script type="text/javascript">
    var ltl = request('ltl');
    var ls = null

    if(ltl !=null && ltl !=""){
        var words = ltl.split(",")
        ls = [parseFloat(words[0]),parseFloat(words[1])]
    }

    AMapUI.loadUI(['misc/PositionPicker'], function(PositionPicker) {
        var map
        if(ls != null){
            map = new AMap.Map('container', {
                center:ls,
                zoom: 11,
                scrollWheel: false
            })
        }else{
            map = new AMap.Map('container', {
                zoom: 13,
                scrollWheel: false
            })
        }

        var positionPicker = new PositionPicker({
            mode: 'dragMap',
            map: map
        });
        positionPicker.setMode('dragMarker')
        positionPicker.on('success', function(positionResult) {
            document.getElementById('lnglat').innerHTML = positionResult.position;
            document.getElementById('address').innerHTML = positionResult.address;

        });
        positionPicker.on('fail', function(positionResult) {
            document.getElementById('lnglat').innerHTML = ' ';
            document.getElementById('address').innerHTML = ' ';
        });

        var startButton = document.getElementById('start');
        var stopButton = document.getElementById('stop');
        AMap.event.addDomListener(startButton, 'click', function() {
            positionPicker.start(map.getBounds().getSouthWest())
        })
        AMap.event.addDomListener(stopButton, 'click', function() {
            positionPicker.stop();
        })
        positionPicker.start();
        map.panBy(0, 1);

        map.addControl(new AMap.ToolBar({
            liteStyle: true
        }))
    });
    function AcceptClickToReceivers() {
       var s = {
           address:document.getElementById('address').innerText,
           latitude:document.getElementById('lnglat').innerText
       }
       return s;
    }
</script>
</body>

</html>