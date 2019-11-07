/**
 * AJAX提交操作，提交前执行提示；
 * @param options
 * @constructor
 */
$.AJAXAlert = function (options) {
    var defaults = {
        msg: "你确定要执行此操作吗？",
        loading: "正在执行此操作",
        url: "",
        param: [],
        type: "post",
        dataType: "json",
        success: null
    };
    var options = $.extend(defaults, options);
    dialogConfirm(options.msg, function (r) {
        if (r) {
            Loading(true, options.loading);
            window.setTimeout(function () {
                var postdata = options.param;
                if ($('[name=__RequestVerificationToken]').length > 0) {
                    postdata["__RequestVerificationToken"] = $('[name=__RequestVerificationToken]').val();
                }
                $.ajax({
                    url: options.url,
                    data: postdata,
                    type: options.type,
                    dataType: options.dataType,
                    success: function (data) {
                        options.success(data);
                        Loading(false);
                        if (options.close == true) {
                            dialogClose();
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("请求错误；请联系管理员");
                        Loading(false);
                    },
                });
            }, 500);
        }
    });
}
/**
 * SpringMVC 支持的JSON数据传输，更改请求头和自动格式化JSON数据
 * @param options
 * @constructor
 */
$.AJAXSubmit = function (options) {
    var defaults = {
        url: "",
        param: [],
        type: "post",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        loading: "正在处理数据...",
        success: null,
        close: true //成功后是否关闭窗口
    };
    var options = $.extend(defaults, options);
    Loading(true, options.loading);
    window.setTimeout(function () {
        $.ajax({
            url: options.url,
            data: JSON.stringify(options.param),
            contentType : options.contentType,
            type: options.type,
            dataType: options.dataType,
            success: function (data) {
                Loading(false);
                options.success(data); //回掉参数

                // if (options.close == true) {
                //      dialogClose(); //关闭窗口命令
                // }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                Loading(false);
                alert("请求错误；请联系管理员");
            },
        });
    }, 300);
}
/**
 * 普通提交，但是没办法支持LIST参数，他妈的SpringMVC要点脸不。。。。
 * @param options
 * @constructor
 */
$.SaveForm = function (options) {
    var defaults = {
        url: "",
        param: [],
        type: "post",
        dataType: "json",
        loading: "正在处理数据...",
        success: null,
        close: true
    };
    var options = $.extend(defaults, options);
    Loading(true, options.loading);
    window.setTimeout(function () {
        $.ajax({
            url: options.url,
            data: options.param,
            type: options.type,
            dataType: options.dataType,
            success: function (data) {
                Loading(false);
                options.success(data); //回掉参数
                // if (options.close == true) {
                //      dialogClose(); //关闭窗口命令
                // }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("请求错误；请联系管理员");
                Loading(false);
            },
        });
    }, 500);
}

$.SaveFormAsync = function (options) {
    var defaults = {
        url: "",
        param: [],
        type: "post",
        dataType: "json",
        loading: "正在处理数据...",
        success: null,
        close: true
    };
    var options = $.extend(defaults, options);
    Loading(true, options.loading);
    window.setTimeout(function () {
        $.ajax({
            url: options.url,
            data: options.param,
            type: options.type,
            dataType: options.dataType,
            async: false,
            success: function (data) {
                Loading(false);
                options.success(data); //回掉参数
                // if (options.close == true) {
                //      dialogClose(); //关闭窗口命令
                // }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("请求错误；请联系管理员");
                Loading(false);
            },
        });
    }, 500);
}
$.SetForm = function (options) {
    var defaults = {
        url: "",
        param: [],
        type: "post",
        dataType: "json",
        success: null,
        async:false
    };
    var options = $.extend(defaults, options);
    $.ajax({
        url: options.url,
        data: options.param,
        type: options.type,
        dataType: options.dataType,
        async: options.async,
        success: function (data) {
            if (data != null && data.type == "3") {
                dialogAlert(data.message, -1);
            } else {
                options.success(data);
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            dialogMsg(errorThrown, -1);
        }, beforeSend: function () {
            Loading(true);
        },
        complete: function () {
            Loading(false);
        }
    });
}
$.SetForm = function (options) {
    var defaults = {
        url: "",
        param: [],
        type: "post",
        dataType: "json",
        success: null,
        async:false
    };
    var options = $.extend(defaults, options);
    $.ajax({
        url: options.url,
        data: options.param,
        type: options.type,
        dataType: options.dataType,
        async: options.async,
        success: function (data) {
            if (data != null && data.type == "3") {
                dialogAlert(data.message, -1);
            } else {
                options.success(data);
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            dialogMsg(errorThrown, -1);
        }, beforeSend: function () {
            Loading(true);
        },
        complete: function () {
            Loading(false);
        }
    });
}
$.RemoveForm = function (options) {
    var defaults = {
        msg: "注：您确定要删除吗？该操作将无法恢复",
        loading: "正在删除数据...",
        url: "",
        param: [],
        type: "post",
        dataType: "json",
        success: null
    };
    var options = $.extend(defaults, options);
    dialogConfirm(options.msg, function (r) {
        if (r) {
            Loading(true, options.loading);
            window.setTimeout(function () {
                var postdata = options.param;
                if ($('[name=__RequestVerificationToken]').length > 0) {
                    postdata["__RequestVerificationToken"] = $('[name=__RequestVerificationToken]').val();
                }
                $.ajax({
                    url: options.url,
                    data: postdata,
                    type: options.type,
                    dataType: options.dataType,
                    success: function (data) {
                        options.success(data);
                        Loading(false);
                        if (options.close == true) {
                            dialogClose();
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("请求错误；请联系管理员");
                        Loading(false);
                    },
                });
            }, 500);
        }
    });
}
$.ConfirmAjax = function (options) {
    var defaults = {
        msg: "提示信息",
        loading: "正在处理数据...",
        url: "",
        param: [],
        type: "post",
        dataType: "json",
        success: null
    };
    var options = $.extend(defaults, options);
    dialogConfirm(options.msg, function (r) {
        if (r) {
            Loading(true, options.loading);
            window.setTimeout(function () {
                var postdata = options.param;
                if ($('[name=__RequestVerificationToken]').length > 0) {
                    postdata["__RequestVerificationToken"] = $('[name=__RequestVerificationToken]').val();
                }
                $.ajax({
                    url: options.url,
                    data: postdata,
                    type: options.type,
                    dataType: options.dataType,
                    success: function (data) {
                        Loading(false);
                        if (data.type == "3") {
                            dialogAlert(data.message, -1);
                        } else {
                            dialogMsg(data.message, 1);
                            options.success(data);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        Loading(false);
                        dialogMsg(errorThrown, -1);
                    },
                    beforeSend: function () {
                        Loading(true, options.loading);
                    },
                    complete: function () {
                        Loading(false);
                    }
                });
            }, 200);
        }
    });
}
$.ExistField = function (controlId, url, param) {
    var $control = $("#" + controlId);
    if (!$control.val()) {
        return false;
    }
    var data = {
        keyValue: request('keyValue')
    };
    data[controlId] = $control.val();
    var options = $.extend(data, param);
    $.ajax({
        url: url,
        data: options,
        type: "get",
        dataType: "text",
        async: false,
        success: function (data) {
            if (data.toLocaleLowerCase() == 'false') {
                ValidationMessage($control, '已存在,请重新输入');
                $control.attr('fieldexist', 'yes');
            } else {
                $control.attr('fieldexist', 'no');
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            dialogMsg(errorThrown, -1);
        }
    });
}
$.removeFromMessage=function(data){
    data.find('input,select,textarea,.ui-select').each(function (r) {
        removeMessage($(this))
    });

}

