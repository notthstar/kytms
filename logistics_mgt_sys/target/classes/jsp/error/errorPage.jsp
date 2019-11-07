<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/3/3
  Time: 22:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>建议升级浏览器软件</title>
    <style type="text/css">
        body {
            background-color: #f5f5f5;
            font-family: 微软雅黑,宋体,Arial,Helvetica,Verdana,sans-serif;
        }

        .not-support-browser {
            background-color: #FFFFFF;
            border: 1px solid #CED0D3;
            border-radius: 5px;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            width: 650px;
            height: 400px;
            margin: 100px auto;
            padding: 0px;
        }

        .Learun-logo {
            background-color: #4A5B79;
            color: #FFFFFF;
            font-size: 18px;
            font-weight: bold;
            height: 50px;
            line-height: 50px;
        }

        .not-support-browser-contant {
            color: #666666;
            font-size: 18px;
            margin: 35px 25px;
            text-align: center;
        }


        .not-support-browser-contant ul {
            display: inline-block;
            list-style: none outside none;
            margin: 35px 80px;
            padding: 0px;
        }

        .not-support-browser-contant ul li {
            float: left;
            margin-left: 10px;
        }

        .not-support-browser-contant ul li a {
            text-decoration: none;
        }

        .not-support-browser-contant ul li img {
            width: 64px;
            height: 64px;
        }
    </style>
</head>
<body>
<!-- 内容区 -->
<div class="not-support-browser">
    <div class="Learun-logo">
        JET快速开发平台
    </div>
    <div class="not-support-browser-contant">
        <h1 style="font-size: 34px">错误页面
            <br /></h1>
        <p>  您的访问的页面不存在或权限不足；
        </p>
        <ul>
            <li>
                <a href="https://www.google.com/chrome?hl=en&brand=CHMI">
                    <img border="0" src="/Content/images/browselogo/chromelogo.png" alt="Chrome" /></a>
            </li>
            <li>
                <a href="http://www.mozilla.org/en-US/firefox/fx/">
                    <img border="0" src="/Content/images/browselogo/firefoxlogo.png" alt="Firefox" /></a>
            </li>
            <li>
                <a href="http://www.apple.com/safari/download/">
                    <img border="0" src="/Content/images/browselogo/safari_logo.png" alt="Safari" /></a>
            </li>
            <li>
                <a href="http://www.opera.com/products/">
                    <img border="0" src="/Content/images/browselogo/operalogo.png" alt="Opera" /></a>
            </li>
        </ul>
    </div>
</div>
</body>
</html>
