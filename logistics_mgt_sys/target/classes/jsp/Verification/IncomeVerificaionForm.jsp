<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/9/30
  Time: 8:53
  To change this template use File | Settings | File Templates.
  其他单价表
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <title>收入核销</title>
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>

    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet" />
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/plugins/jquery.md5.js"></script>
    <script src="/Content/scripts/utils/jet-pinyin.js"></script>
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
<body>
<form id="form1">

    <script>
        var keyValue = request('id');
        var money = request('money');
        var yjhxMoney = request('hxmoney');
        var whxMoney =request('whxMoney');
        $(function () {
            GetGrid();
            $("#zmoney").val(money);
            $("#yhxmoney").val(yjhxMoney);
            $("#whxmoney").val(whxMoney);
        })
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return ;
            }

            var postData ={
                id: $("#id").val(),
                zmoney:$("#zmoney").val(),
                yhxmoney:$("#yhxmoney").val(),
                hxmoney:$("#hxmoney").val(),
                whxmoney:$("#whxmoney").val(),
                "verificationZb.id":keyValue,
             //   vid:keyValue
            }
            $.SaveForm({
                url: "/verification/saveVerification.action",
                param:postData,
                loading: "正在保存数据...",
                success: function (data) {
                        $("#yhxmoney").val(data.yhxmoney);
                        $("#whxmoney").val(data.whxmoney);
                    $("#hxmoney").val(null);
                       // $('#form1').ValidformResule(data.obj);//后台验证数据
                       $("#gridTable").trigger("reloadGrid");
                        dialogMsg("成功", 1);
                        //dialogClose();//关闭窗口
                       // reload();
                }
            })
        }
        function btn_edit(){
            var id = $("#gridTable").jqGridRowValue("a.id");
            if (checkedRow(id)){
                $.SetForm({
                    url: "/verification/selectBean.action",
                    param: {tableName:"JC_VERIFICATION_RECORD",id: id },
                    success: function (data) {
                        $("#form1").SetWebControls(data);
                    }
                });
            }
        }

        function GetGrid() {
            var url="/verification/getVerificationRecordList.action?id="+keyValue;
            var selectedRowIndex = 0;
            var $gridTable = $('#gridTable');
            $gridTable.jqGrid({
                url: url,
                datatype: "json",
                height: $(window).height() - 210,
                autowidth: true,
                colModel: [
                    {label: '主键', name: 'a.id', hidden: true},
                    {label: '总金额', name: 'a.zmoney', width: 150, align: 'center'},
                    {label: '已核销金额', name: 'a.zmoney', width: 150, align: 'center'},
                    {label: '核销金额', name: 'a.hxmoney', width: 100, align: 'center'},
                    {label: '未核销金额', name: 'a.whxmoney', width: 100, align: 'center'},
                    {label: '核销人', name: 'a.operator', width: 100, align: 'center'},
                    {label: '核销时间', name: 'a.hxTime', width: 100, align: 'center',
                        formatter:function(cellvalue, options, row){
                            if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                                return "";
                            }
                            return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                        }},
                    {label: '核销状态', name: 'a.hxtype', width: 100, align: 'center',
                        formatter:function(cellvalue, options, row){
                            return top.clientdataItem.HXZT['' + cellvalue + '']
                        }
                    },
                    {label: '备注', name: 'description', width: 80, align: 'center'},
                    {label: '创建人', name: 'create_Name', width: 120,align: 'center'},
                    {label: '创建时间', name: 'create_Time',type:"date", width: 150,align: 'center',
                        formatter:function(cellvalue, options, row){
                            if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                                return "";
                            }
                            return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                        }},
                    {label: '修改人', name: 'modify_Name', width: 120,align: 'center'},
                    {label: '修改时间', name: 'modify_Time',type:"date", width: 150,align: 'center',
                        formatter:function(cellvalue, options, row){
                            if(cellvalue == null || cellvalue == undefined || cellvalue ==""){
                                return "";
                            }
                            return new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss")
                        }},
                ],
                viewrecords: true,
                rowNum: 30,
                rowList: [30, 50, 100],
                pager: "#gridPager",
                rownumbers: true,
                shrinkToFit: false,
                gridview: true,
                multiselect: true,//复选框
                multiboxonly: true,
                onSelectRow: function () {
                    selectedRowIndex = $("#" + this.id).getGridParam('selrow');
                },
                gridComplete: function () {
                    $("#" + this.id).setSelection(selectedRowIndex, false);
                },
//                ondblClickRow:function(a,b,c){
//                    btn_edit(  $gridTable.getCell(a,"id"))
//                },

            });
            //$gridTable.authorizeColModel()
            //初始化查询条件
            initJGGridselectView($gridTable);
        }
        function jisuan(){
           var hxmoney = Number($("#hxmoney").val());
           var whxmoney = Number($("#whxmoney").val());
            var yhxmoney = Number($("#yhxmoney").val());
            if(yhxmoney-money >0){
                alert("已核销金额不能大于总金额");
            }else if(hxmoney<0){
                alert("核销金额不能是负数");
            }else if(whxmoney==0) {
                alert("已经核销完毕，不能再次核销");
            }else if(hxmoney-whxmoney>0){
                alert("核销金额不能大于未核销金额");
            }else{
                $("#yhxmoney").val(Number(yhxmoney)+Number(money)-(money-hxmoney));
                $("#whxmoney").val(money-(Number(yhxmoney)+Number(money)-(money-hxmoney)));
           }
        }

    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <div class="tab-content" style="padding-top: 15px;">
            <table class="form">
                <input id="id" name="id" type="hidden" value="" />
                <tr>
                    <td class="formTitle">总金额<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="zmoney" disabled="disabled" name="zmoney" type="text"  class="form-control" />
                    </td>
                    <th class="formTitle">已核销金额<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="yhxmoney" name="yhxmoney" disabled="disabled" class="form-control"></input>
                    </td>
                    <th class="formTitle">未核销金额<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="whxmoney" name="whxmoney"  disabled="disabled" class="form-control" type="text"></input>
                    </td>
                </tr>
                <tr>
                    <th class="formTitle">核销金额<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="hxmoney" name="hxmoney" autocomplete="off" onchange="jisuan();" class="form-control" isvalid="yes" checkexpession="NotNull"></input>
                    </td>
                </tr>
                <tr>
                    <th class="formTitle">备注</th>
                    <td class="formValue">
                        <textarea id="description" type="text" style="width: 500px;height: 40px" class="form-control"></textarea>
                        <%--<input id="description" type="text" style="width: 500px;height: 50px" class="form-control" />--%>
                    </td>
                </tr>
            </table>
            <div id="ExpandInfo" class="tab-pane ">
                <div class="app_layout app_preview" style="border-top: 1px solid #ccc;" id="frmpreview"></div>
            </div>
            <a id="btn_add" class="btn btn-primary" onclick="AcceptClick()"><i class="fa fa-floppy-o"></i>&nbsp;保存</a>
            <a id="btn_reload" class="btn btn-primary" onclick="reload()"><i class="fa fa-edit"></i>&nbsp;刷新</a>
        </div>
    </div>
</form>
<div class="gridPanel">
    <table id="gridTable"></table>
    <%--<div id="gridPager"></div>--%>
</div>
</body>
</html>
