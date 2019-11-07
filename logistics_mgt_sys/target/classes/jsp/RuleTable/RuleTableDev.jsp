<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2017/12/04
  Time: 21:27
  收发货方表单
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
    <title>规则</title>
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet"/>
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>

    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/grid.locale-cn.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.js"></script>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-report.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-bill.css" rel="stylesheet"/>
</head>
<body>
<form id="form1">

    <script>
        var keyValue = request('keyValue');
        $(function () {
            GetGrid()
            //c初始化代码编辑器

                // if (!!keyValue) {
                //     $.SetForm({
                //         url: "/rule/selectBean.action",
                //         param: {tableName: "JC_RULE", id: keyValue},
                //         success: function (data) {
                //
                //         }
                //     });
                // }




        })
        //保存表单
        function addColumn(){
            $.SetForm({
                        url: "/ruletable/addColumn.action",
                        param: {tableName: keyValue},
                        success: function (data) {

                        }
                    });
        }
        function delColumn(columnName){
            $.SetForm({
                url: "/ruletable/delColumn.action",
                param: {tableName: keyValue,columnName:columnName},
                success: function (data) {
                    $("#gridTable").trigger("reloadGrid");
                }
            });
        }
        function GetGrid() {
            var selectedRowIndex = 0;
            var $gridTable = $('#gridTable');
            $gridTable.jqGrid({
                url: "/ruletable/getColumns.action?tableName="+keyValue,
                datatype: "json",
                height: $(window).height() - 136.5,
                autowidth: true,
                cellurl:"/ruletable/saveColumn.action?tableName="+keyValue,
                cellEdit:true,
                colModel: [
                    {label: '主键', name: 'COLUMN_NAME', hidden: true},
                    {label: '字段名称',selectDefault:true,editable:true, name: 'COLUMN_NAME',width: 300, align: 'center'},
                    {label:'<button type="button" onclick="addColumn()" class="btn btn-success btn-xs">添加字段</button>', name: 'COLUMN_NAME', width: 100, align: 'center',
                        formatter: function (cellvalue, options, rowObject) {
                            return '<span onclick=\"delColumn(\'' +cellvalue+'\')\" class=\"label label-info\" style=\"cursor: pointer;\">删除字段 </span>';
                        }},
                    {label: '备注',name: 'TABLE_COMMENT', width: 150, align: 'center'},
                ],
                pager: false,
                rowNum: "1000",
                viewrecords: true,
                rownumbers: true,
                shrinkToFit: false,
                gridview: true,
                onSelectRow: function () {
                    selectedRowIndex = $("#" + this.id).getGridParam('selrow');
                },
                gridComplete: function () {
                    $("#" + this.id).setSelection(selectedRowIndex, false);
                },

            });
            //初始化查询页面

        }
    </script>
    <div class="gridPanel">
        <table id="gridTable"></table>
    </div>
</form>
</body>
</html>