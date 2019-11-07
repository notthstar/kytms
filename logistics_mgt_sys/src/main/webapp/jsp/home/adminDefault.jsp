<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/3/4
  Time: 11:53
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
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <title>${SystemConfig.systemName}</title>
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <script src="/Content/scripts/plugins/cookie/jquery.cookie.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/dialog/dialog.js"></script>
    <script src="/Content/scripts/utils/jet-clientdata.js"></script>
    <script src="/Content/adminDefault/index.js"></script>
    <link href="/Content/adminDefault/css/index.css" rel="stylesheet" />
    <script>
        var getcontentPath ="http://"+window.location.host+"/";
        var contentPath = getcontentPath;
        $(function () {
            initialPage();
        });
        //初始化页面
        function initialPage() {
            $("#container").height($(window).height());
            $(window).resize(function (e) {
                $("#container").height($(window).height());
            });
            loadnav();//加载导航
            $(window).load(function () {
                window.setTimeout(function () {
                    $('#ajax-loader').fadeOut();
                }, 300);
            });
        }
        function  selectPlan () {
            dialogOpen({
                id: "get",
                title: '平台选择',
                url: 'jsp/home/PlanSelect.jsp',
                width: "450px",
                height: "350px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick(location);

                }
            });

        }
        function updataPassword(){
            dialogOpen({
                id: "get",
                title: '密码修改',
                url: 'jsp/home/PasswordUpdata.jsp',
                width: "450px",
                height: "200px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();

                }
            });
        }
        function res() {
            reload();
        }
//        function btdTms(){
//            $.ajax({
//                url: "/transportorder/tongbuTMS.action",
//                type:"post",
//                async:false,
//                dataType : 'JSON',
//                success:function(data) {
//                     if(data){
//                         dialogMsg("成功", 1);
//                     }
//                }
//            })
//        }
//        function settle(){
//            dialogOpen({
//                id: "Form",
//                title: '费用结算',
//                url: 'jsp/Settlement/FYSettle.jsp',
//                width: "750px",
//                height: "400px",
//                btn:[]
//            });
//        }
    </script>
</head>
<body style="overflow: hidden;">

<div id="ajax-loader" style="cursor: progress; position: fixed; top: -50%; left: -50%; width: 200%; height: 200%; background: #fff; z-index: 10000; overflow: hidden;">
    <img src="/Content/images/ajax-loader.gif" style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; margin: auto;" />
</div>
<div id="container">
    <div id="side">
        <ul id="nav"></ul>
    </div>
    <div id="main">
        <div id="main-hd">
            <div id="main-hd-title">
                <a>登陆机构:</a>
                <a>${sessionScope.orgId.name}</a>
            </div>
            <div style="float: right">
                <ul id="topnav">
                    <li class="list" onclick="res()">
                        <a>
                            <span><i class="fa fa-home"></i></span>
                            刷新页面
                        </a>
                    </li>
                    <%--<li class="list" onclick="btdTms()">--%>
                        <%--<a>--%>
                            <%--<span><i class="fa fa-apple"></i></span>--%>
                            <%--同步TMS--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <li class="list"  onclick="updataPassword()" >
                        <a>
                            <span><i class="fa fa-key" ></i></span>
                            密码修改
                        </a>
                    </li>
                    <li class="list" onclick="selectPlan()">
                        <a>
                            <span><i class="fa fa-exchange" ></i></span>
                            平台切换
                        </a>
                    </li>
                    <li class="list" onclick="IndexOut()">
                        <a>
                            <span><i class="fa fa-power-off"></i></span>
                            安全退出
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <div id="main-bd">
            <div id="tab_list_add">
            </div>
            <div class="contextmenu">
                <ul>
                    <li onclick="$.removeTab('reloadCurrent')">刷新当前</li>
                    <li onclick="$.removeTab('closeCurrent')">关闭当前</li>
                    <li onclick="$.removeTab('closeAll')">全部关闭</li>
                    <li onclick="$.removeTab('closeOther')">除此之外全部关闭</li>
                    <div class='m-split'></div>
                    <li>退出</li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!--载进度条start-->
<div id="loading_background" class="loading_background" style="display: none;"></div>
<div id="loading_manage">
    正在拼了命为您加载…
</div>
<!--载进度条end-->

</body>
</html>
