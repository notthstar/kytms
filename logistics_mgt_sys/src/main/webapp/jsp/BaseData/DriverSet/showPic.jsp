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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <link rel="stylesheet" href="/Content/scripts/driver/css/styles.css" />
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
</head>
<script type="text/javascript">
    var driverId=request("driverId");

    $(function () {
        $.SaveForm({
            url: "/driverupload/showCredentials.action?driverId="+driverId,
            param:null,
            success: function (data) {
                var ul=document.getElementById('showPic');
                //console.log(data)
                $.each(data, function(index,item){
                   var li=document.createElement("li");
                   li.setAttribute('class','item falldown');
                   ul.appendChild(li);
                   var figure=document.createElement("figure");
                   li.appendChild(figure);
                   var div=document.createElement("div");
                   div.setAttribute('class','view');
                    figure.appendChild(div);
                    var img = document.createElement("img");
                    img.setAttribute("id", item.id);
                    img.src="/images/driverUpload/"+item.newName;
                    //img.alt=item.oldName;
                    div.appendChild(img);
                    var figcaption=document.createElement("figcaption");
                    figure.appendChild(figcaption);
                    var p=document.createElement("p");
                    figcaption.appendChild(p);
                    var span=document.createElement("span");
                    //span.setAttribute('text',item.oldName);
                    //span.innerText(item.oldName)
                    span.innerHTML=item.oldName;
                    p.appendChild(span);

                });
            }
        })
    });
</script>
<body>
<div class="demo-wrapper">
    <h1></h1>
    <ul class="portfolio-items" id="showPic">
        <%--<li class="item">
            <figure>
                <div class="view"> <img src="/Content/images/a3.png" /> </div>
                <figcaption>
                    <p><span>By Vlad Gerasimov</span></p>
                </figcaption>
            </figure>
            <div class="date"> 2008</div>
        </li>--%>
    </ul>
</div>
</body>
<script src="/Content/scripts/driver/js/modernizr-1.5.min.js"></script>
<script src="/Content/scripts/driver/js/jquery.mousewheel.js"></script>
<script src="/Content/scripts/driver/js/scripts.js"></script>
</html>
