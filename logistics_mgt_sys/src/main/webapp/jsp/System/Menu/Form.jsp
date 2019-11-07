<%--
  Created by IntelliJ IDEA.
  User: nidaye
  Date: 2017/3/10
  Time: 9:27
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
    <title>额</title>
    <!--框架必需start-->
    <script src="/Content/scripts/jquery/jquery-1.10.2.min.js"></script>
    <link href="/Content/styles/font-awesome.min.css" rel="stylesheet" />
    <link href="/Content/scripts/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!--框架必需end-->
    <!--bootstrap组件start-->
    <link href="/Content/scripts/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="/Content/scripts/bootstrap/bootstrap.extension.css" rel="stylesheet" />
    <script src="/Content/scripts/bootstrap/bootstrap.min.js"></script>
    <!--bootstrap组件end-->

    <script src="/Content/scripts/plugins/datepicker/WdatePicker.js"></script>
    <link href="/Content/scripts/plugins/tree/tree.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/datetime/pikaday.css" rel="stylesheet"/>
    <link href="/Content/scripts/plugins/wizard/wizard.css" rel="stylesheet"/>
    <link href="/Content/styles/jet-ui.css" rel="stylesheet"/>


    <script src="/Content/scripts/plugins/tree/tree.js"></script>
    <script src="/Content/scripts/plugins/validator/validator.js"></script>
    <script src="/Content/scripts/plugins/wizard/wizard.js"></script>
    <script src="/Content/scripts/plugins/datepicker/DatePicker.js"></script>
    <script src="/Content/scripts/utils/jet-ui.js"></script>
    <script src="/Content/scripts/utils/jet-form.js"></script>
    <script src="/Content/scripts/plugins/dialog/dialog.js"></script>

</head>
<body>
<form id="form1">
    <!--jqgrid表格组件start-->
    <link href="/Content/scripts/plugins/jqgrid/jqgrid.css" rel="stylesheet" />
    <script src="/Content/scripts/plugins/jqgrid/grid.locale-cn.js"></script>
    <script src="/Content/scripts/plugins/jqgrid/jqgrid.min.js"></script>
    <!--表格组件end-->
    <script type="text/javascript">
        var keyValue = request('keyValue');
        var parentId = request('parentId');
        $(function () {
            initialPage();
            buttonOperation();
        })
        //初始化页面
        function initialPage() {
            //加载导向
            $('#wizard').wizard().on('change', function (e, data) {
                var $finish = $("#btn_finish");
                var $next = $("#btn_next");
                if (data.direction == "next") {
                    if (data.step == 2) {
                        $finish.removeAttr('disabled');
                        $next.attr('disabled', 'disabled');
                    } else {
                        $finish.attr('disabled', 'disabled');
                    }
                } else {
                    $finish.attr('disabled', 'disabled');
                    $next.removeAttr('disabled');
                }
            });
            initControl();
        }
        //初始化控件
        function initControl() {
            //目标
            $("#target").ComboBox({
                description: "==请选择==",
                height: "200px"
            });
          //  上级
            $("#menu").ComboBoxTree({
                url: "/menu/getMenuTree.action",
                description: "==请选择==",
                height: "195px",
                allowSearch: true
            });
            //获取表单
            if (!!keyValue) {
                $.SetForm({
                    url: "/menu/selectBean.action",
                    param: {tableName:"JC_SYS_MENU", id: keyValue },
                    success: function (data) {
                        $("#form1").SetWebControls(data);
                        $("#menu").ComboBoxTreeSetValue(data.menu.id);
                    }
                });

            }
            else {
                $("#ParentId").ComboBoxTreeSetValue(parentId);
            }
        }
        //选取图标
        function SelectIcon() {
            dialogOpen({
                id: "img",
                title: '选取图标',
                url: 'jsp/System/Menu/Icon.jsp?ControlId=img',
                width: "1000px",
                height: "600px",
                btn: false
            })
        }
        //保存表单
        function AcceptClick() {
            if (!$('#form1').Validform()) {
                return false;
            }
            var postData = $("#form1").GetWebControls(keyValue);
            if(postData["menu.id"]){
                postData["menu"] = {id:postData["menu.id"]}
            }else {
                postData["menu"] = {id:"root"}
            }
            $.SaveForm({
//                url: "menu/saveMenu.action",
//                param: postData,
                url: "menu/saveBean.action",
                param: { tableName:"JC_SYS_MENU", obj:JSON.stringify(postData)},
                loading: "正在保存数据...",
                success: function (data) {
                    if (data.type == "validator") {
                        $('#form1').ValidformResule(data.obj);//后台验证数据
                    }else if (data.type){
                        $.currentIframe().$("#gridTable").trigger("reloadGrid");
                        $.currentIframe().GetTree();
                        dialogMsg(data.obj, 1);
                        dialogClose();//关闭窗口
                    }else{
                        dialogAlert(data.obj, -1);
                        dialogClose();
                    }
                }
            })
        }

        //按钮操作（上一步、下一步、完成、关闭）
        function buttonOperation() {
            var $finish = $("#btn_finish");
            //如果是菜单，开启 上一步、下一步
            //完成提交保存
            $finish.click(function (){
                AcceptClick();
            })
        }

    </script>
    <div class="widget-body">
        <div id="wizard" class="wizard" data-target="#wizard-steps" style="border-left: none; border-top: none; border-right: none;">
            <ul class="steps">
                <li data-target="#step-1" class="active"><span class="step">1</span>添加菜单<span class="chevron"></span></li>
            </ul>
        </div>
        <div class="step-content" id="wizard-steps" style="border-left: none; border-bottom: none; border-right: none;">
            <div class="step-pane active" id="step-1" style="margin-left: 0px; margin-top: 15px; margin-right: 30px;">
                <input id="id" name="id" type="hidden" value="" />
                <table class="form">
                    <tr>
                        <th class="formTitle">编码<font face="宋体">*</font></th>
                        <td class="formValue">
                            <input id="code" name="code" type="text" class="form-control" placeholder="请输入编码" isvalid="yes" checkexpession="NotNull" />
                        </td>
                        <th class="formTitle">名称<font face="宋体">*</font></th>
                        <td class="formValue">
                            <input id="name" type="text" name="name" class="form-control" placeholder="请输入名称" isvalid="yes" checkexpession="NotNull" />
                        </td>
                    </tr>
                    <tr>
                        <th class="formTitle">上级<font face="宋体">*</font></th>
                        <td class="formValue">
                            <div id="menu" name="menu.id" type="selectTree"  class="ui-select">
                            </div>
                        </td>
                        <th class="formTitle">图标</th>
                        <td class="formValue">
                            <input id="img" type="text" name="img" class="form-control" />
                            <span class="input-button" onclick="SelectIcon()" title="选取图标">...</span>
                        </td>
                    </tr>
                    <tr>
                        <th class="formTitle">目标<font face="宋体">*</font></th>
                        <td class="formValue">
                            <div id="target"  name = "target" type="select" class="ui-select" isvalid="yes" checkexpession="NotNull">
                                <ul>
                                    <li data-value="expand">expand</li>
                                    <li data-value="iframe">iframe</li>
                                </ul>
                            </div>
                        </td>
                        <th class="formTitle">排序<font face="宋体">*</font></th>
                        <td class="formValue">
                            <input id="orderBy" name="orderBy" type="text" class="form-control" isvalid="yes" checkexpession="Num" />
                        </td>
                    </tr>
                    <tr>
                        <th class="formTitle">URL<font face="宋体">*</font></th>
                        <td class="formValue" colspan="3">
                            <input id="url" name="url" type="text" class="form-control" isvalid="yes" checkexpession="NotNull"/>
                        </td>
                    </tr>
                    <tr>
                        <th class="formTitle" valign="top" style="padding-top: 4px;">描述
                        </th>
                        <td class="formValue" colspan="3">
                            <textarea id="description" name="description" class="form-control" style="height: 70px;"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="form-button" id="wizard-actions">
        <a id="btn_finish" class="btn btn-success">完成</a>
    </div>
</form>
</body>
</html>
