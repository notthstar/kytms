/**
 * @description
 * @author lcy
 * @create 2019/11/11
 * @since 1.0.0
 */
package com.t28.forest.order.controller;

public class controller {
    /**
     * 数据
     */
    private Object data;
    /**
     * 代码
     */
    private Integer code;
    /**
     * 信息
     */
    private String msg;
    /**
     * 是否请求成功
     */
    private Boolean isSuccess;

    public controller(Object data, Integer code, String msg, Boolean isSuccess) {
        this.data = data;
        this.code = code;
        this.msg = msg;
        this.isSuccess = isSuccess;
    }

    public controller(Object data) {
        this.data = data;
        this.code = 0;
        this.msg = "请求成功";
        this.isSuccess = true;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Boolean getSuccess() {
        return isSuccess;
    }

    public void setSuccess(Boolean success) {
        isSuccess = success;
    }
}
