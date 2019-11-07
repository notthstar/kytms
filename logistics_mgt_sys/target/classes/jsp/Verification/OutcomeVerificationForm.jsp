<%--
  Created by IntelliJ IDEA.
  User: sundezeng
  Date: 2018/12/17
  Time: 14:33
  To change this template use File | Settings | File Templates.
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
    <title>成本核销</title>
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

    <%--打印及插件--%>
    <script src="/Content/lodopPrint/LodopFuncs.js"></script>
    <object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
    </object>
</head>
<body>
<form id="form1">

    <script>
        var keyValue = request('id');
        var money = request('money');
        var yjhxMoney = request('hxmoney');
        var whxMoney =request('whxMoney');
        var shipid = request('shipid');
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

        var LODOP;
        function btn_print(){
            var id = $('#gridTable').jqGridRowValue('a.id');
            if(id == null || id == undefined || id ==""){
                dialogAlert('请选择要打印的报销数据', -1);
                return
            }else {
                CreateOneFormPage(id);
            }
            LODOP.PREVIEW();
            //LODOP.PRINT_DESIGN();
        }
        function CreateOneFormPage(id){
            $.SetForm({
                url: "/verification/getAccountPrint.action",
                param: {id:id,shipid: shipid},
                success: function (data) {
                    console.log(data)
                    LODOP=getLodop();

                    LODOP.PRINT_INITA(0,0,1230,1200,"打印报销单");
                    LODOP.SET_PRINT_PAGESIZE(1,2110,1260,"B5");
                    LODOP.SET_PRINT_MODE("PRINT_NOCOLLATE",1);
                    LODOP.ADD_PRINT_TEXT(80,22,108,25,"沪广专线部");
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",14);
                    LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
                    LODOP.ADD_PRINT_TEXT(88,319,48,25,data.year);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",13);
                    LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
                    LODOP.ADD_PRINT_TEXT(88,375,30,25,data.month);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",13);
                    LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
                    LODOP.ADD_PRINT_TEXT(88,411,30,25,data.date);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",13);
                    LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
                    LODOP.ADD_PRINT_TEXT(194,34,70,25,"运单号：");
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
                    LODOP.ADD_PRINT_TEXT(194,110,164,25,data.code);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
                    LODOP.ADD_PRINT_TEXT(224,34,70,25,"车牌号：");
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
                    LODOP.ADD_PRINT_TEXT(224,110,105,25,data.chepaihao);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
                    LODOP.ADD_PRINT_TEXT(165,368,100,30,data.amount);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",22);
                    LODOP.ADD_PRINT_TEXT(361,368,100,30,data.amount);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",22);
                    LODOP.ADD_PRINT_TEXT(361,154,117,30,data.dx);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",15);
                    LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
                    LODOP.SET_PRINT_STYLEA(0,"Bold",1);
                    LODOP.ADD_PRINT_TEXT(167,89,25,25,"发");
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
                    LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
                    LODOP.ADD_PRINT_TEXT(167,162,43,25,"现款");
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",11);
                    LODOP.ADD_PRINT_TEXT(167,34,49,25,data.from);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.ADD_PRINT_TEXT(167,118,41,25,data.to);
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
                    LODOP.ADD_PRINT_TEXT(366,349,20,30,"¥");
                    LODOP.SET_PRINT_STYLEA(0,"FontSize",20);
                    LODOP.SET_PRINT_STYLEA(0,"Alignment",2);




                }
            })
        };




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
            <a id="out_add" class="btn btn-primary" onclick="AcceptClick()"><i class="fa fa-floppy-o"></i>&nbsp;保存</a>
            <a id="out_print" class="btn btn-primary" onclick="btn_print()"><i class="fa fa-edit"></i>&nbsp;打印报销单</a>
            <a id="btn_reload" class="btn btn-primary" onclick="reload()"><i class="fa fa-edit"></i>&nbsp;刷新</a>
            <script>$('.toolbar').authorizeButton()</script>
        </div>
    </div>
</form>
<div class="gridPanel">
    <table id="gridTable"></table>
    <%--<div id="gridPager"></div>--%>
</div>
</body>
</html>

