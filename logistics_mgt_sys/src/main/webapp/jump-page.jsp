<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2019/11/9
  Time: 9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>跳转</title>
    <script src="/Content/frame/js/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="/Content/frame/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <script src="/Content/frame/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
<div class="container">
    <div class="col col-md-12">
        <table class="table table-bordered">
            <tr>
                <td><a href="/jsp/Shipment/ShipmentIndex.jsp">运单管理</a></td>
            </tr>
            <tr>
                <td><a href="/jsp/Single/SingleIndex.jsp">派车单</a></td>
            </tr>
            <tr>
                <td><a href="/jsp/ShipmentTrack/Index.jsp">运单跟踪</a></td>
            </tr>
            <tr>
                <td><a href="/jsp/RoadVehicles/vehicleArriveIndex.jsp">车辆到站</a></td>
            </tr>
            <tr>
                <td><a href="/jsp/RoadVehicles/vehicleArriveInfo.jsp">到货车辆记录</a></td>
            </tr>
            <tr>
                <td><a href="/jsp/RoadVehicles/goodsArrive.jsp">货物到站</a></td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
