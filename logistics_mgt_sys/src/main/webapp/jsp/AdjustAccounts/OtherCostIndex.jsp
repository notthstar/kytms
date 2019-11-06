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
    <title>提派单表单</title>
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

        $(function () {
            //组织机构
            $("#organization").ComboBoxTree({
                url: "/org/getOrgTree.action",
                description: "==请选择==",
                height: "200px",
            });
            //费用类型下拉框
            $("#fytype").ComboBox({
                description: "==请选择==",
                height: "200px",
                data: top.clientdataItem.fytype
            });
            //税率
            $("#taxRate").ComboRadio({
                height: "200px",
                data: top.clientdataItem.TaxRate,
                defaultVaue:'0.10'
            });
            GetGrid();
        })
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData ={
                id: $("#id").val(),
                "organization.id":$("#organization").attr("data-value"),
                fytype:$("#fytype").attr('data-value'),
                weightPrice:$("#weightPrice").val(),
                volumePrice:$("#volumePrice").val(),
                taxRate:$("input[name='taxRate']:checked").val()
            }
            $.SaveForm({
                url: "/otherCost/saveOtherCost.action",
                param:postData,
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    }else if (data.type){
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        dialogMsg(data.obj, 1);
                        //dialogClose();//关闭窗口
                        reload();
                    }else{
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }
        function btn_edit(){
            var keyValue = $("#gridTable").jqGridRowValue("id");
//            var organization=$("#gridTable").jqGridRowValue("organization");
//            var fytype=$("#gridTable").jqGridRowValue("fytype");
//            var weightPrice=$("#gridTable").jqGridRowValue("weightPrice");
//            var volumePrice=$("#gridTable").jqGridRowValue("volumePrice");
//            var taxRate=$("#gridTable").jqGridRowValue("taxRate");
            if (checkedRow(keyValue)) {
                $.SetForm({
                    url: "/otherCost/selectBean.action",
                    param: {tableName:"JC_OTHER_COST",id: keyValue },
                    success: function (data) {
                        $("#form1").SetWebControls(data);
                        $("#organization").ComboBoxSetValue(data.organization.id);
                    }
                });
            }
        }

        function GetGrid() {
            var url="/otherCost/getOtherCostList.action";
            var selectedRowIndex = 0;
            var $gridTable = $('#gridTable');
            $gridTable.jqGrid({
                url: url,
                datatype: "json",
                height: $(window).height() - 220,
                autowidth: true,
                colModel: [
                    {label: '主键', name: 'id', hidden: true},
                    {label: '组织机构', name: 'organization.name', width: 150, align: 'center'},
                    {label: '费用类型', name: 'fytype', width: 150, align: 'center',
                        formatter: function (cellvalue, options, rowObject) {
                            return top.clientdataItem.fytype['' + cellvalue + '']
                        }
                    },
                    {label: '吨单价', name: 'weightPrice', width: 100, align: 'center'},
                    {label: '方单价', name: 'volumePrice', width: 100, align: 'center'},
                    {label: '税率', name: 'taxRate', width: 150, align: 'center'},
                    {label: '备注', name: 'height', width: 80, align: 'center'},
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
    </script>
    <div style="margin-left: 10px; margin-right: 10px;">
        <div class="tab-content" style="padding-top: 15px;">
            <table class="form">
                <input id="id" name="id" type="hidden" value="" />
                <tr>
                    <td class="formTitle">组织机构<font face="宋体">*</font></td>
                    <td class="formValue">
                        <div id="organization" disabled="disabled" name="organization.id" type="select" class="ui-select"></div>
                    </td>
                    <th class="formTitle">费用类型<font face="宋体">*</font></th>
                    <td class="formValue">
                        <div id="fytype" name="fytype" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull"></div>
                    </td>
                </tr>
                <tr>
                    <td class="formTitle">吨单价<font face="宋体">*</font></td>
                    <td class="formValue">
                        <input id="weightPrice" name="weightPrice" type="text"  class="form-control" isvalid="yes" checkexpession="NotNull" />
                    </td>
                    <th class="formTitle">方单价<font face="宋体">*</font></th>
                    <td class="formValue">
                        <input id="volumePrice" name="volumePrice" class="form-control" isvalid="yes" checkexpession="NotNull"></input>
                    </td>
                    <th class="formTitle">税率<font face="宋体">*</font></th>
                    <td class="formValue">
                        <div id="taxRate" name="taxRate" class="radio" type="radio"></div>
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
            <a id="btn_edit" class="btn btn-primary" onclick="btn_edit()"><i class="fa fa-edit"></i>&nbsp;编辑</a>
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
