<%--
  Created by IntelliJ IDEA.
  User: 陈小龙
  Date: 2018-1-15
  Time: 15:15
  承运商设置
  To change this template use File | Settings | File Templates.
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
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>承运商设置</title>
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
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
    <style>
        body {
            margin: 10px;
            margin-bottom: 0px;
        }
    </style>
</head>
<body>

<script>
    var status = request('status');
    $(function () {
        //按钮权限控制
        $('.toolbar').authorizeButton();
        InitialPage();
        GetGrid();
        initHigtQuery($("#btn_HigtSearch"),$('#gridTable'));
    });
    function Format(now,mask)
    {
        var d = now;
        var zeroize = function (value, length)
        {
            if (!length) length = 2;
            value = String(value);
            for (var i = 0, zeros = ''; i < (length - value.length); i++)
            {
                zeros += '0';
            }
            return zeros + value;
        };

        return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function ($0)
        {
            switch ($0)
            {
                case 'd': return d.getDate();
                case 'dd': return zeroize(d.getDate());
                case 'ddd': return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][d.getDay()];
                case 'dddd': return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
                case 'M': return d.getMonth() + 1;
                case 'MM': return zeroize(d.getMonth() + 1);
                case 'MMM': return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
                case 'MMMM': return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
                case 'yy': return String(d.getFullYear()).substr(2);
                case 'yyyy': return d.getFullYear();
                case 'h': return d.getHours() % 12 || 12;
                case 'hh': return zeroize(d.getHours() % 12 || 12);
                case 'H': return d.getHours();
                case 'HH': return zeroize(d.getHours());
                case 'm': return d.getMinutes();
                case 'mm': return zeroize(d.getMinutes());
                case 's': return d.getSeconds();
                case 'ss': return zeroize(d.getSeconds());
                case 'l': return zeroize(d.getMilliseconds(), 3);
                case 'L': var m = d.getMilliseconds();
                    if (m > 99) m = Math.round(m / 10);
                    return zeroize(m);
                case 'tt': return d.getHours() < 12 ? 'am' : 'pm';
                case 'TT': return d.getHours() < 12 ? 'AM' : 'PM';
                case 'Z': return d.toUTCString().match(/[A-Z]+$/);
                // Return quoted strings with the surrounding quotes removed
                default: return $0.substr(1, $0.length - 2);
            }
        });
    };
    //初始化页面
    function InitialPage() {
        //resize重设(表格、树形)宽高
        $(window).resize(function (e) {
            window.setTimeout(function () {
                $('#gridTable').setGridWidth(($('.gridPanel').width()));
                $("#gridTable").setGridHeight($(window).height() - 136.5);
            }, 200);
            e.stopPropagation();
        });
    }
    function getCarrier(){
        var id = $("#gridTable").jqGridRowValue("id");
        if (checkedIds(id)) {
            return $("#gridTable").jqGrid('getRowData', id);
        }
    }
    //加载表格
    function GetGrid() {
        var url="/carrier/getCarrierList.action"
        if(status != null && status != undefined && status != ""){
            url+= "?status="+status
        }
        var selectedRowIndex = 0;
        var $gridTable = $('#gridTable');
        $gridTable.jqGrid({
            url:url,
            datatype: "json",
            height: $(window).height() - 136.5,
            autowidth: true,
            colModel: [
                {label: '主键', name: 'id', hidden: true},
                {label: '数据状态', name: 'status', width: 80,align: 'center',frozen:true,type:"DD&CommDataStatus",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CommDataStatus['' + cellvalue + '']
                    }},
                {label: '组织机构', name: 'organization.name', width: 150, align: 'center'},
                {label: '承运商名称',selectDefault:true, name: 'name', width: 150, align: 'center'},
                {label: '承运商代码', name: 'code', width: 150, align: 'center'},
                {label: '规则', name: 'rule.code', width: 150, align: 'center'},
                {label: '承运商类型', name: 'carrierType', width: 80, align: 'center',type:"DD&CarrierType",
                    formatter: function (cellvalue, options, rowObject) {
                        return top.clientdataItem.CarrierType['' + cellvalue + '']
                    }
                },
                {label: '指定组织机构', name: 'zdOrganization.name', width: 150, align: 'center'},
                {label: '合同开始时间', name: 'startTime', width: 100,align: 'center', type:"date",
                    formatter: function (cellvalue, options, rowObject) {
                        return cellvalue.substr(0,10)
                    }},
                {label: '合同结束时间', name: 'endTime', width: 100,align: 'center', type:"date",
                    formatter: function (cellvalue, options, rowObject) {
                        return cellvalue.substr(0,10)
                    }
                },
                {label: '账期（天）', name: 'paymentDays', width: 100,align: 'center'},
                {label: '合同到期天数', name: 'dqts', width: 100,align: 'center',
                    formatter: function (cellvalue, options, rowObject) {
                        var dqrq=new Date();
                        var htjsrq=new Date(rowObject.endTime);
                        dqrq=Format(dqrq,"yyyy-MM-dd");
                        htjsrq=Format(htjsrq,"yyyy-MM-dd");
                        var time= new Date(htjsrq).getTime()-new Date(dqrq).getTime();
                        var days=parseInt(time/(1000 * 60 * 60 * 24));
                        if(days<0){
                            days=0;
                        }
                        return days}
                },
                {label: '承运商电话', name: 'iphone', width: 100,align: 'center'},
                {label: '负责人', name: 'principal', width: 100,align: 'center'},
                {label: '负责人电话', name: 'principalIphone', width: 200,align: 'center'},
                {label: '联系地址', name: 'address', width: 150,align: 'center'},

                {label: '创建人', name: 'create_Name', width: 120,align: 'center'},
                {label: '创建时间', name: 'create_Time', width: 150,align: 'center'},
                {label: '修改人', name: 'modify_Name', width: 120,align: 'center'},
                {label: '修改时间', name: 'modify_Time', width: 150,align: 'center'},
                {label: "备注", name: "description", width: 200, align: "center"}
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
//            ondblClickRow:function(a,b,c){
//                btn_edit(  $gridTable.getCell(a,"id"))
//            },

        });
        //初始化查询页面
        initJGGridselectView($gridTable);
    }
    function btn_add() {
        dialogOpen({
            id: "CarrierForm",
            title: '添加承运商',
            url: '/jsp/Carrier/CarrierForm.jsp',
            width: "750px",
            height: "550px",
            callBack: function (iframeId) {
                top.frames[iframeId].AcceptClick();
            }
        });
    };
    function btn_edit(id) {
        var keyValue = undefined;
        if(id == undefined){
            keyValue = $("#gridTable").jqGridRowValue("id");
        }else {
            keyValue = id
        }
        console.log(keyValue)
        if (checkedRow(keyValue)) {
            dialogOpen({
                id: "Form",
                title: '修改承运商',
                url: '/jsp/Carrier/CarrierForm.jsp?keyValue=' + keyValue,
                width: "750px",
                height: "550px",
                callBack: function (iframeId) {
                    top.frames[iframeId].AcceptClick();
                }
            });
        }
    }
    function btn_Update(status) {
        var  keyValue = $("#gridTable").jqGridRowValue("id");
        if (keyValue) {
            $.ConfirmAjax({
                msg: "注：您确定要修改承运商状态？",
                url: "/carrier/updateStatus.action",
                param: { tableName:"JC_CARRIER",status:status,id: keyValue },
                success: function (data) {
                    $("#gridTable").trigger("reloadGrid");
                    if (data.type) {
                        dialogMsg(data.obj, 1);
                    } else {
                        dialogAlert(data.obj, -1);
                    }
                }
            })
        }
    }
</script>
<div class="titlePanel">
    <div class="title-search">
        <table>
            <tr>
                <td>
                    <div   id="queryCondition" class="btn-group">
                        <a class="btn btn-default dropdown-text" data-value="code"
                           data-toggle="dropdown">选择条件</a>
                        <a class="btn btn-default dropdown-toggle" data-toggle="dropdown"><span
                                class="caret"></span></a>
                        <ul  id="queryLi" class="dropdown-menu">
                        </ul>
                    </div>
                </td>
                <td id="keyWord" style="padding-left: 2px;">
                    <input  id="txt_Keyword" type="text" class="form-control" placeholder="请输入要查询关键字" style="width: 200px;"/>
                </td>
                <td style="padding-left: 5px;">
                    <a id="btn_Search" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;查询</a>
                    <a id="btn_HigtSearch" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;高级查询</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="toolbar">
        <div class="btn-group">
            <a id="replace" class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
            <a id="carrier-add" class="btn btn-default" onclick="btn_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
            <a id="carrier-edit" class="btn btn-default" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
            <a id="carrier-more" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                <i class="fa fa-reorder"></i>&nbsp;更多<span class="caret"></span>
            </a>
            <ul class="dropdown-menu pull-right">
                <li id="carrier-disabled"><a onclick="btn_Update(0)"><i></i>&nbsp;停用</a></li>
                <li id="carrier-enabled"><a onclick="btn_Update(1)"><i></i>&nbsp;启用</a></li>
            </ul>
        </div>
        <%--        <div class="btn-group">
                    <a id="driver-authorize" class="btn btn-default" onclick="btn_authorize()"><i class="fa fa-gavel"></i>&nbsp;角色授权</a>
                    <a id="driver-dataAuthorize" class="btn btn-default" onclick="btn_dataAuthorize()"><i class="fa fa-gavel"></i>&nbsp;数据授权</a>
                </div>--%>
        <%--<script>$('.toolbar').authorizeButton()</script>--%>
    </div>
</div>
<div class="gridPanel">
    <table id="gridTable"></table>
    <div id="gridPager"></div>
</div>
</body>
</html>



