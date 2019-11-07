<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2018/1/4
  Time: 15:57
  To change this template use File | Settings | File Templates.
  高德地图，拖拽选址
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html lang="zh-CN">
<head>
    <base href="<%=basePath%>">
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

    <script src="https://webapi.amap.com/maps?v=1.4.8&key=49df3dbb93cc593e8cceedfe8f8be185&callback=init"></script>
    <script src="//webapi.amap.com/ui/1.0/main.js?v=1.0.11"></script>
    <link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css"/>
    <base href="//webapi.amap.com/ui/1.0/ui/misc/PositionPicker/examples/" />
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>拖拽选址</title>
    <style>
        html, body, #container {
            height: 100%;
            width: 100%;
        }

        .custom-input-card{
            width: 18rem;
        }

        .custom-input-card .btn:last-child{
            margin-left: 1rem;
        }

        .content-window-card{
            position: relative;
            width: 23rem;
            padding: 0.75rem 0 0 1.25rem;
            box-shadow: none;
            bottom: 0;
            left: 0;
        }

        .content-window-card p{
            height: 2rem;
        }
        .input-cards {
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border-radius: .25rem;
            width: 36rem;
            border-width: 0;
            border-radius: 0.4rem;
            box-shadow: 0 2px 6px 0 rgba(114, 124, 245, .5);
            position: fixed;
            bottom: 17rem;
            right: 60rem;
            -ms-flex: 1 1 auto;
            flex: 1 1 auto;
            padding: 0.75rem 1.25rem;
        }
    </style>
</head>

<body>
<div id="shipment" name=""></div>

<div id="container" class="map" tabindex="0"></div>
<div class="input-card custom-input-card">
    <h4 id = "dait" shipmentId>请选择配载的派车单</h4>
    <div class="input-item">
        <input type="button" class="btn" value="选择单据" onClick="openSingle()"/>
        <input style="margin-left: 24px" id = "openDetail" type="button" class="btn" value="显示明细" onClick="openDetail()"/>
        <input style="margin-left: 24px"  id = "closeDetail" hidden type="button" class="btn" value="关闭明细" onClick="closeDetail()"/>
    </div>
</div>
<div id = "detailWindow" class="input-cards custom-input-cards">




</div>
<div id = "ti" class="info">

</div>

<!-- UI组件库 1.0 -->

<script type="text/javascript">
    $("#closeDetail").hide()
    $("#detailWindow").hide()
    var tis=0
    var tin=0
    var tiw=0
    var tiv=0
    var pis=0
    var pin=0
    var piw=0
    var piv=0
    var map;
    var myMap=new Map();
    //获取当前的经纬度并转换
    var ltl = "${orgId.latitude}";
    var words = ltl.split(",")
    ltl = [parseFloat(words[0]),parseFloat(words[1])]
    var mapData; //配载数据
    initData(); //初始化数据
    initMap();

    //获取所有装货数据


function initTpData(){



    var tiData ="提货  单据数量："+tis +" 总数量:"+tin + " 总重量:"+tiw + " 总体积:"+tiv+"-----"
    tiData +="派送  单据数量："+pis +" 总数量:"+pin + " 总重量:"+piw + " 总体积:"+piv
    $("#ti").text(tiData)

}


function initMap(){

    window.init = function(){
         map = new AMap.Map('container', {
                resizeEnable: true,
                center:ltl,
                zoom: 12,
        })
        AMapUI.loadUI(['overlay/SimpleMarker'], function(SimpleMarker) {

            new SimpleMarker({
                //前景文字
                iconLabel: '总部',
                //图标主题
                iconTheme: 'fresh',
                //背景图标样式
                iconStyle: 'salmon',
                //...其他Marker选项...，不包括content
                map: map,
                position: ltl,
//                label: {
//                    content: "你大爷的",
//                    offset: new AMap.Pixel(33, 7)
//                }
            });

          for(i=0;i<mapData.length;i++){
              var data = mapData[i];
              if(data.type == 0){//提货
                  //计算总数据
                  tis++
                  tin+=data.number
                  tiw+=data.weight
                  tiv+=data.volume
                  var mk =new SimpleMarker({
                      //前景文字
                      iconLabel: '提货',
                      //图标主题
                      iconTheme: 'fresh',
                      //背景图标样式
                      iconStyle: 'gray',
                      //...其他Marker选项...，不包括content
                      map: map,
                      position: data.ltl,
                label: {
                    content: "客户名称："+data.name +" 数量:"+data.number + " 重量:"+data.weight + " 体积:"+data.volume + ' <a id="'+data.id+'" n="'+data.number+'" w="'+data.weight+'" v="'+data.volume+'"   t="'+data.type+'" onclick="openZh($(this))" style="color:blue">装货</a>',
                    offset: new AMap.Pixel(33, 7)
                }
                  });
                  myMap.set(data.id,mk)
              }else { //送货
                  var mk = new SimpleMarker({
                      //前景文字
                      iconLabel: '送货',
                      //图标主题
                      iconTheme: 'fresh',
                      //背景图标样式
                      iconStyle: 'darkgreen',
                      //...其他Marker选项...，不包括content
                      map: map,
                      position: data.ltl,
                      label: {
                          content: "客户名称："+data.name +" 数量:"+data.number + " 重量:"+data.weight + " 体积:"+data.volume + ' <a id="'+data.id+'" n="'+data.number+'" w="'+data.weight+'" v="'+data.volume+'"   t="'+data.type+'" onclick="openZh($(this))" style="color:blue">装货</a>',
                          offset: new AMap.Pixel(33, 7)
                      }
                  });
                  myMap.set(data.id,mk)
              }
          }
        });
    }
}
    function initData(){
        tis = 0;
        pis =0;
        $.ajax({
            url: "/single/getMapData.action",
            async:false,
            type: "post",
            dataType: "json",
            success: function (data) {
                mapData = data
            },
        });
        //获取派车单数据
        for(i=0;i<mapData.length;i++){
            var data = mapData[i];
            if(data.type == 0){//提货
                //计算总数据
                tis++
                tin+=data.number
                tiw+=data.weight
                tiv+=data.volume
            }else { //送货
                pis++
                pin+=data.number
                piw+=data.weight
                piv+=data.volume
            }
        }
        initTpData(); // 初始化提派头数据
    }
    function openSingle(){
        dialogOpen({
            id: "singleFrom",
            title: '派车单选择',
            url: 'jsp/Single/SingleIndex.jsp?status=status',
            width: "1550px",
            height: "450px",
            callBack: function (iframeId) {
                var resule = top.frames[iframeId].getSinele();
                updateTitle(resule)
                top.frames[iframeId].dialogClose();//关闭窗口

            }
        });
    }
    function updateTitle(id){
        $.SetForm({
            url: "/single/selectBean.action",
            param: {tableName:"JC_SINGLE",id: id },
            success: function (data) {
                var n = data.number==undefined?0:data.number;
                var w=data.weight==undefined?0:data.weight;
                var v=data.volume==undefined?0:data.volume;
                var datas = "当前车辆:"+data.vehicleHead +"          派车单号: "+ data.code+" 数量:"+n + " 重量:"+w + " 体积:"+v
                $("#dait").text(datas)
                $("#shipment").attr("name",data.id)
            }
        });
    }
    function openZh(data){
        var shipmentId =  $("#shipment").attr("name")
        if(shipmentId == null || shipmentId == "" || shipmentId == undefined){
            alert("请选择派车单")
            return
        }
        var obj = {
            shipment:shipmentId,
            id : data.attr("id"),
            number : data.attr("n"),
            weight : data.attr("w"),
            volume : data.attr("v"),
            type : data.attr("t"),
        }
        dialogOpen({
            id: "single2From",
            title: '装载选择',
            url: 'jsp/Single/ZZ.jsp?shipment='+shipmentId+"&id="+obj.id+"&number="+obj.number+"&weight="+obj.weight+"&volume="+obj.volume+"&type="+obj.type,
            width: "710px",
            height: "240px",
            callBack: function (iframeId) {
                var sule = top.frames[iframeId].AcceptClick();
                initData();
                //更新标记
                var mk =myMap.get(sule.id)
                updateMk(sule.id,mk)

                updateDetail(shipmentId)

                top.frames[iframeId].dialogClose();//关闭窗口
                updateTitle(shipmentId)
            }
        });

    }
    /**
     * 更新点标记
     * @param id
     * @param mk
     */
    function updateMk(id,mk){
        $.ajax({
            url: "/single/getMk.action",
            type: "post",
            dataType: "json",
            data:{id:id},
            success: function (data) {
                if(data.result){
                    var customer
                    if(data.customer == null){
                        customer = "零散"
                    }else {
                        customer = data.customer.name
                    }
                    mk.setLabel({
                        content: "客户名称："+customer +" 数量:"+data.obj.number + " 重量:"+data.obj.weight + " 体积:"+data.obj.volume + ' <a id="'+data.obj.id+'" n="'+data.obj.number+'" w="'+data.obj.weight+'" v="'+data.obj.volume+'"   t="'+data.obj.type+'" onclick="openZh($(this))" style="color:blue">装货</a>',
                        offset: new AMap.Pixel(33, 7)
                    })
                    mk.show();
                }else {
                    mk.hide( )
                }
            },
        });
    }
    /**
     * 关闭明细
     */
    function closeDetail(){
        $("#closeDetail").hide()
        $("#openDetail").show()
        $("#detailWindow").hide()
    }
    /**
     * 打开明细
     */
    function openDetail(){
        var shipmentId =  $("#shipment").attr("name")
        if(shipmentId == null || shipmentId == "" || shipmentId == undefined){
            alert("请选择派车单")
            return
        }
        $("#openDetail").hide()
        $("#closeDetail").show()
        $("#detailWindow").show()

        updateDetail(shipmentId)

    }
    /**
     * 更新明细
     * @param shipmentId
     */
    function updateDetail(shipmentId){
        $("#detailWindow").empty(); //清空元素
        $.ajax({
            url: "/single/getStowage.action",
            type: "post",
            dataType: "json",
            data:{id:shipmentId},
            success: function (data) {

                if(data == null){
                    return
                }
                var html = "";
                for(i=0;i<data.length;i++){
                    var s = data[i];
                    html+='<p id = "'+s[0]+'">类型:'+top.clientdataItem.TPType['' + s[1] + '']+' 单号:'+s[3]+' 数量：'+s[6]+' 重量：'+s[7]+' 体积:'+s[8]+'<a style="margin-left: 5px;color:blue" name = "'+s[0]+'"   t = "'+s[1]+'" onclick="delOrder($(this))" onClick="closeDetail()">卸载</a></p>'
                }
                $("#detailWindow").html(html)
            },
        });
    }
    function delOrder(a){
        var shipmentId = $("#shipment").attr("name");
        var rowData = new Array()
        var ledId = a.attr("name")
        var mk =myMap.get(ledId)
        obj={
            id:ledId,
            typeValue: a.attr("t")
        }
        rowData.push(obj)
        $.SetForm({
            url: "/single/delOrder.action",
            param: {id:shipmentId, data: JSON.stringify(rowData) },
            success: function (data) {
                updateDetail(shipmentId)
                initData();
                updateMk(ledId,mk)
                updateTitle(shipmentId)
                dialogMsg("移除配载成功", 1);
            }
        });
        }
</script>
</body>

</html>