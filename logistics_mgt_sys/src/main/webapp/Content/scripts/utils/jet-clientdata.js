$(function () {
    $.getclientdata();
})
var clientdataItem = [];
var clientorganizeData = [];
var clientdepartmentData = [];
var clientpostData = [];
var clientroleData = [];
var clientuserGroup = [];
var clientuserData = [];
var authorizeMenuData = [];
var authorizeButtonData = [];
var authorizeColumnData = [];
$.getclientdata = function () {
    $.ajax({
        url: contentPath + "login/initData.action",
        type: "post",
        dataType: "json",
        async: false,
        success: function (data) {
            clientdataItem = data.dataItem; //数据字典
            //clientorganizeData = data.organize; //组织机构
            //clientdepartmentData = data.department; //不知道
            //clientpostData = data.post;
            //clientroleData = data.role; //角色
            //clientuserGroup = data.userGroup; //用户组
            //clientuserData = data.user; //用户
            authorizeMenuData = data.authorizeMenu; //菜单
            authorizeButtonData = data.authorizeButton; //按钮
            // authorizeColumnData = data.authorizeColumn; //行数据
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            dialogMsg(errorThrown, -1);
        }
    });
}