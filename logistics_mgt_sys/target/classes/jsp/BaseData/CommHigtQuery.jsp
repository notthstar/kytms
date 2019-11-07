<%--
  Created by IntelliJ IDEA.
  User: 陈小龙
  Date: 2018-1-10
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>

<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>高级查询基础页面</title>
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet" />
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
</head>
<body>
<form id="form12">

    <script>
        var keyValue = request('keyValue');
        var html =localStorage["name"];
        $(function () {
            initControl();
            //初始化数据字典选项
            initDD()
            //初始化查询调价
            initSelectWhere();
        })

        function initSelectWhere(){
            $("[VI]").each(function(){
                $(this).ComboBox({
                    description: "选择条件",
                    height: "200px",
                    data: top.clientdataItem.selectWhere
                });
                $(this).ComboBoxSetValue('=')
            })

        }
        function initDD(){
            $("[DD]").each(function(){
                var title = $(this).attr("DD")
                if(title == null || title == undefined){
                    console.log("请管理员配置数据字典");
                    return
                }
                var  tt = title.substring(0,3);
                if(tt == null || tt == undefined){
                    console.log("数据子点错误");
                    return
                }
                var value = title.substring(3,title.length)
                if (value == null || value == undefined){
                    console.log("数据字典配置错误");
                    return
                }
                $(this).ComboBox({
                    description: "=请选择查询值=",
                    height: "200px",
                    data: top.clientdataItem[value]
                });

            })
        }
        //初始化控件
        function initControl() {
            $("#form").append(html);
        }
        //保存表单
        function AcceptClick() {
            var sql = " 1=1 ";
            $("[whereValue]").each(function(){
                var self =$(this)
                if(self.attr("DD")){
                    if(self.attr('data-value')){
                        sql+=" and " +  self.attr("whereValue") +" = '"+ self.attr('data-value')+"'";
                        return
                    }
                }else if(self.attr("selectType") == "date"){
                    var start = self.find("[indexType=start]").val();
                    var end = self.find("[indexType=end]").val();
                    if(start != null && end != null && start!= "" && end != ""){
                        sql+= " and "+self.attr("whereValue")+"  between '"+start+"' and '"+end+"'"
                    }
                    return
                }else{
                    if(self.val()){
                        var where = $("[whereName='"+self.attr("whereValue")+"']")
                        var sign = where.attr('data-value');
                        if(sign == "%"){ //模糊查询
                            sql+=" and " + self.attr("whereValue") +" like '%"+ self.val()+"%'";
                            return
                        }else if(sign == ","){
                            var str = self.val();
                            var en =str.split(",");
                            var instr = "";
                            for(i=0;i<en.length;i++){
                                instr +="'"+en[i]+"',"
                            }
                            var instr = instr.substring(0,instr.length -1)
                            sql+=" and " + self.attr("whereValue") +" in ("+ instr+")";
                            return
                        }else{
                            var where = $("[whereName='"+self.attr("whereValue")+"']")
                            sql+=" and " + self.attr("whereValue") +" " +sign+" '"+ self.val()+"'";
                            return
                        }
                    }
                }
            });
            sql += " and 1 "
            return sql;
        }
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
            <table id ="form"  class="form">

            </table>
    </div>
</form>
</body>
</html>