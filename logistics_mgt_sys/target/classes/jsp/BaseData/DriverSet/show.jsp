<%--
  辽宁捷畅物流有限公司 -信息技术中心
  创建人: 陈小龙
  创建日期: 2018/7/20
  名称：
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
    <meta name="viewport" content="width=device-width"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Title</title>
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/Content/scripts/plugins/layout/jquery.layout.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jqgrid/grid.locale-cn.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.js"></script>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <style type="text/css">

        html {

            overflow: hidden;

        }



        body {

            margin: 0px;

            padding: 0px;

            background: #000;

            position: absolute;

            width: 100%;

            height: 100%;

            cursor: crosshair;

        }



        #diapoContainer {

            position: absolute;

            left: 10%;

            top: 10%;

            width: 80%;

            height: 80%;

            background: #222;

            overflow: hidden;

        }



        .imgDC {

            position: absolute;

            cursor: pointer;

            border: #000 solid 2px;

            filter: alpha(opacity=90);

            opacity: 0.9;

            visibility: hidden;

        }



        .spaDC {

            position: absolute;

            filter: alpha(opacity=20);

            opacity: 0.2;

            background: #000;

            visibility: hidden;

        }



        .imgsrc {

            position: absolute;

            width: 120px;

            height: 67px;

            visibility: hidden;

            margin: 4%;

        }



        #bkgcaption {

            position: absolute;

            bottom: 0px;

            left: 0px;

            width: 100%;

            height: 6%;

            background:#1a1a1a;

        }

        #caption {

            position: absolute;

            font-family: arial, helvetica, verdana, sans-serif;

            white-space: nowrap;

            color: #fff;

            bottom: 0px;

            width: 100%;

            left: -10000px;

            text-align: center;

        }



    </style>
    <script type="text/javascript">

        var xm;

        var ym;



        /* ==== onmousemove event ==== */

        document.onmousemove = function(e){

            if(window.event) e=window.event;

            xm = (e.x || e.clientX);

            ym = (e.y || e.clientY);

        }



        /* ==== window resize ==== */

        function resize() {

            if(diapo)diapo.resize();

        }

        onresize = resize;



        /* ==== opacity ==== */

        setOpacity = function(o, alpha){

            if(o.filters)o.filters.alpha.opacity = alpha * 100; else o.style.opacity = alpha;

        }





        ////////////////////////////////////////////////////////////////////////////////////////////

        /* ===== encapsulate script ==== */

        diapo = {

            O : [],

            DC : 0,

            img : 0,

            txt : 0,

            N : 0,

            xm : 0,

            ym : 0,

            nx : 0,

            ny : 0,

            nw : 0,

            nh : 0,

            rs : 0,

            rsB : 0,

            zo : 0,

            tx_pos : 0,

            tx_var : 0,

            tx_target : 0,



            /////// script parameters ////////

            attraction : 2,

            acceleration : .9,

            dampening : .1,

            zoomOver : 2,

            zoomClick : 6,

            transparency : .8,

            font_size: 18,

            //////////////////////////////////



            /* ==== diapo resize ==== */

            resize : function(){

                with(this){

                    nx = DC.offsetLeft;

                    ny = DC.offsetTop;

                    nw = DC.offsetWidth;

                    nh = DC.offsetHeight;

                    txt.style.fontSize = Math.round(nh / font_size) + "px";

                    if(Math.abs(rs-rsB)<100) for(var i=0; i<N; i++) O[i].resize();

                    rsB = rs;

                }

            },



            /* ==== create diapo ==== */

            CDiapo : function(o){

                /* ==== init variables ==== */

                this.o        = o;

                this.x_pos    = this.y_pos    = 0;

                this.x_origin = this.y_origin = 0;

                this.x_var    = this.y_var    = 0;

                this.x_target = this.y_target = 0;

                this.w_pos    = this.h_pos    = 0;

                this.w_origin = this.h_origin = 0;

                this.w_var    = this.h_var    = 0;

                this.w_target = this.h_target = 0;

                this.over     = false;

                this.click    = false;



                /* ==== create shadow ==== */

                this.spa = document.createElement("span");

                this.spa.className = "spaDC";

                diapo.DC.appendChild(this.spa);



                /* ==== create thumbnail image ==== */

                this.img = document.createElement("img");

                this.img.className = "imgDC";

                this.img.src = o.src;

                this.img.O = this;

                diapo.DC.appendChild(this.img);

                setOpacity(this.img, diapo.transparency);



                /* ==== mouse events ==== */

                this.img.onselectstart = new Function("return false;");

                this.img.ondrag = new Function("return false;");

                this.img.onmouseover = function(){

                    diapo.tx_target=0;

                    diapo.txt.innerHTML=this.O.o.alt;

                    this.O.over=true;

                    setOpacity(this,this.O.click?diapo.transparency:1);

                }

                this.img.onmouseout = function(){

                    diapo.tx_target=-diapo.nw;

                    this.O.over=false;

                    setOpacity(this,diapo.transparency);

                }

                this.img.onclick = function() {

                    if(!this.O.click){

                        if(diapo.zo && diapo.zo != this) diapo.zo.onclick();

                        this.O.click = true;

                        this.O.x_origin = (diapo.nw - (this.O.w_origin * diapo.zoomClick)) / 2;

                        this.O.y_origin = (diapo.nh - (this.O.h_origin * diapo.zoomClick)) / 2;

                        diapo.zo = this;

                        setOpacity(this,diapo.transparency);

                    } else {

                        this.O.click = false;

                        this.O.over = false;

                        this.O.resize();

                        diapo.zo = 0;

                    }

                }



                /* ==== rearrange thumbnails based on "imgsrc" images position ==== */

                this.resize = function (){

                    with (this) {

                        x_origin = o.offsetLeft;

                        y_origin = o.offsetTop;

                        w_origin = o.offsetWidth;

                        h_origin = o.offsetHeight;

                    }

                }



                /* ==== animation function ==== */

                this.position = function (){

                    with (this) {

                        /* ==== set target position ==== */

                        w_target = w_origin;

                        h_target = h_origin;

                        if(over){

                            /* ==== mouse over ==== */

                            w_target = w_origin * diapo.zoomOver;

                            h_target = h_origin * diapo.zoomOver;

                            x_target = diapo.xm - w_pos / 2 - (diapo.xm - (x_origin + w_pos / 2)) / (diapo.attraction*(click?10:1));

                            y_target = diapo.ym - h_pos / 2 - (diapo.ym - (y_origin + h_pos / 2)) / (diapo.attraction*(click?10:1));

                        } else {

                            /* ==== mouse out ==== */

                            x_target = x_origin;

                            y_target = y_origin;

                        }

                        if(click){

                            /* ==== clicked ==== */

                            w_target = w_origin * diapo.zoomClick;

                            h_target = h_origin * diapo.zoomClick;

                        }



                        /* ==== magic spring equations ==== */

                        x_pos += x_var = x_var * diapo.acceleration + (x_target - x_pos) * diapo.dampening;

                        y_pos += y_var = y_var * diapo.acceleration + (y_target - y_pos) * diapo.dampening;

                        w_pos += w_var = w_var * (diapo.acceleration * .5) + (w_target - w_pos) * (diapo.dampening * .5);

                        h_pos += h_var = h_var * (diapo.acceleration * .5) + (h_target - h_pos) * (diapo.dampening * .5);

                        diapo.rs += (Math.abs(x_var) + Math.abs(y_var));



                        /* ==== html animation ==== */

                        with(img.style){

                            left   = Math.round(x_pos) + "px";

                            top    = Math.round(y_pos) + "px";

                            width  = Math.round(Math.max(0, w_pos)) + "px";

                            height = Math.round(Math.max(0, h_pos)) + "px";

                            zIndex = Math.round(w_pos);

                        }

                        with(spa.style){

                            left   = Math.round(x_pos + w_pos * .1) + "px";

                            top    = Math.round(y_pos + h_pos * .1) + "px";

                            width  = Math.round(Math.max(0, w_pos * 1.1)) + "px";

                            height = Math.round(Math.max(0, h_pos * 1.1)) + "px";

                            zIndex = Math.round(w_pos);

                        }

                    }

                }

            },



            /* ==== main loop ==== */

            run : function(){

                diapo.xm = xm - diapo.nx;

                diapo.ym = ym - diapo.ny;

                /* ==== caption anim ==== */

                diapo.tx_pos += diapo.tx_var = diapo.tx_var * .9 + (diapo.tx_target - diapo.tx_pos) * .02;

                diapo.txt.style.left = Math.round(diapo.tx_pos) + "px";

                /* ==== images anim ==== */

                for(var i in diapo.O) diapo.O[i].position();

                /* ==== loop ==== */

                setTimeout("diapo.run();", 16);

            },



            /* ==== load images ==== */

            images_load : function(){

                // ===== loop until all images are loaded =====

                var M = 0;

                for(var i=0; i<diapo.N; i++) {

                    if(diapo.img[i].complete) {

                        diapo.img[i].style.position = "relative";

                        diapo.O[i].img.style.visibility = "visible";

                        diapo.O[i].spa.style.visibility = "visible";

                        M++;

                    }

                    resize();

                }

                if(M<diapo.N) setTimeout("diapo.images_load();", 128);

            },



            /* ==== init script ==== */

            init : function() {

                diapo.DC = document.getElementById("diapoContainer");

                diapo.img = diapo.DC.getElementsByTagName("img");

                diapo.txt = document.getElementById("caption");

                diapo.N = diapo.img.length;

                for(i=0; i<diapo.N; i++) diapo.O.push(new diapo.CDiapo(diapo.img[i]));

                diapo.resize();

                diapo.tx_pos = -diapo.nw;

                diapo.tx_target = -diapo.nw;

                diapo.images_load();

                diapo.run();

            }

        }



    </script>
</head>
<body>
<div id="diapoContainer">
    <img class="imgsrc" src="/Content/images/conspiracy_21.jpg" alt="Reconsider your Existence">

    <img class="imgsrc" src="/Content/images/conspiracy_22.jpg" alt="Something Needs to be Discovered">

    <%-- <img class="imgsrc" src="/Content/images/conspiracy_24.jpg" alt="They Said Very Little">

     <img class="imgsrc" src="/Content/images/conspiracy_26.jpg" alt="Only in Your Mind">

     <img class="imgsrc" src="/Content/images/conspiracy_32.jpg" alt="The Power of Imagination">

     <img class="imgsrc" src="/Content/images/conspiracy_29.jpg" alt="Objectivity is Impossible">

     <img class="imgsrc" src="/Content/images/conspiracy_31.jpg" alt="Cleaning Up Operation">

     <img class="imgsrc" src="/Content/images/conspiracy_17.jpg" alt="Arbitrary Contents">--%>

    <div id="bkgcaption"></div>

    <div id="caption"></div>
</div>
<script type="text/javascript">
    var driverId=request("driverId");

    $(function () {
        $.SaveForm({
            url: "/driverupload/showCredentials.action?driverId="+driverId,
            param:null,
            success: function (data) {
                var div=document.getElementById('diapoContainer');
                $.each(data, function(index,item){
                    var img = document.createElement("img");
                    img.setAttribute("id", item.id);
                   // img.src ="/WEB-INF/driverUpload"+item.oldName;
                    img.src="/images/driverUpload/"+item.newName;
                   // alert(img.src)
                    img.alt=item.oldName;
                    img.setAttribute('class','imgsrc');
                    div.appendChild(img);
                });
            }
        })
    });

    /* ==== start script ==== */

    function dom_onload() {

        if(document.getElementById("diapoContainer")) diapo.init(); else setTimeout("dom_onload();", 128);

    }

    dom_onload();

</script>
</body>

</html>
