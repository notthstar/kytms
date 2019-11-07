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
    <title>数据表维护</title>
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
    <script src="/Content/scripts/utils/jet-uuid.js"></script>
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/grid.locale-cn.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.js"></script>
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-report.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-bill.css" rel="stylesheet"/>
    <%--<script type="text/javascript" src="./js/xlsx.core.min.js"></script>--%>
</head>
<body>
<form id="form1">

    <script>
        var keyValue = request('keyValue');
        var columns = new Array()
        $(function () {
                $.SetForm({
                    url: "/ruletable/getColumns.action",
                    param: {tableName:keyValue},
                    async:false,
                    success: function (data) {
                        for (var i = 0; i <data.length ; i++) {
                            var d = data[i]
                            columns.push({label: d.COLUMN_NAME,editable:true, name: d.COLUMN_NAME,width: 200, align: 'center'})

                        }
                        columns.push( {label:'<button type="button" onclick="addColumn()" class="btn btn-success btn-xs">添加数据</button>',sortable:false, name: 'COLUMN_NAME', width: 100, align: 'center',
                            formatter: function (cellvalue, options, rowObject) {
                                // return '<span onclick=\"delColumn(\'' +cellvalue+'\')\" class=\"label label-info\" style=\"cursor: pointer;\">删除数据 </span>';
                                return '<button type="button" onclick="delColumn($(this))" class="btn btn-danger btn-xs">删除数据</button>'
                            }})
                        columns.push( {label: '备注',name: 'des', width: 150, align: 'center'})
                    }
                });
            GetGrid()
            })

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

      function AcceptClick() {
          var jggirdData2 = $('#gridTable').jqGrid("getRowData");
          $.SaveForm({
              url: "/ruletable/saveTableData.action",
              param:{tableName:keyValue,data:JSON.stringify(jggirdData2)} ,
              loading: "正在保存数据...",
              success: function (data) {
                  if (data.type == "validator") {
                      $('#form1').ValidformResule(data.obj);//后台验证数据
                  } else if (data.result) {
                      dialogMsg("保存成功", 1);
                          dialogClose();//关闭窗口
                  } else {
                      dialogAlert(data.obj, -1);
                  }
              }
          })
      }



        function addColumn(){
            var $JGGRID = $('#gridTable')
//            $JGGRID.jqGrid("addRowData",null,"first");
            $JGGRID.addRowData(getUUID(),{

            },"first");
            $JGGRID.setGridHeight("auto");
        }
        function delColumn(data){
            var $JGGRID = $('#gridTable')
            data.parent().parent().remove();
        }
        function GetGrid() {
            var selectedRowIndex = 0;
            var $gridTable = $('#gridTable');
            $gridTable.jqGrid({
                url: "/ruletable/getTableData.action?tableName="+keyValue,
                datatype: "json",
                height: $(window).height() - 136.5,
                autowidth: true,
                cellEdit:true,
                cellurl: "/ruletable/saveColumn.action?tableName="+keyValue,
                colModel:columns,
                pager: false,
                rowNum: "1000",
                viewrecords: true,
                rownumbers: true,
                shrinkToFit: false,
                gridview: true,
                sortable:false,
                onSelectRow: function () {
                    selectedRowIndex = $("#" + this.id).getGridParam('selrow');
                },

            });
            //初始化查询页面

        }
        function dj_inport() {
            keyValue = escape(keyValue);
            dialogOpen({
                id: "导入单价",
                title: '导入单价',
                url: '/jsp/RuleTable/RuleTableInport.jsp?keyValue='+keyValue,
                width: "550px",
                height: "550px",
                btn:[],
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });

        }
        function tableToExcel(){
            //要导出的json数据
            $.ajax({
                url: 'ruletable/getColumns.action',
                type: "post",
                dataType: "json",
                data: {tableName: keyValue},
                success: function (data) {
                    var str='';
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        str += d.COLUMN_NAME + ',';
                    }
                    str += '\n';
                        var datass = $('#gridTable').getRowData();
                        for (var i = 0; i < datass.length ; i++) {
                            delete  datass[i].COLUMN_NAME;
                            for (var item in datass[i]) {
                                str +=   datass[i][item] + ',';
                            }
                            str+='\n';
                        }
                        var uri = 'data:text/csv;charset=utf-8,\ufeff' + encodeURIComponent(str);
                        //通过创建a标签实现
                        var link = document.createElement("a");
                        link.href = uri;
                        //对下载的文件命名
                    var myDate = new Date();
                    var mytime=myDate.getMinutes();   //获取当前时间
                    var name = mytime + "DJB.csv";
                        link.download =name;
                            //"单价表.csv";
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link);
                    }
            })

        }
    </script>
    <div class="gridPanel">
        <table id="gridTable"></table>
        <div class="btn-group" style=" padding-right: 150px;" >
            <a id="dj_inport"   class="btn btn-default" onclick="dj_inport()">导入数据</a>
            <a id="dj_outport"  class="btn btn-default" onclick="tableToExcel()">导出数据</a>
            <a id="dj-replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
        </div>
    </div>
</form>
</body>
</html>