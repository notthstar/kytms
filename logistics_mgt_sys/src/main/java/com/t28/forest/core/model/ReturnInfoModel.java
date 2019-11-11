package com.t28.forest.core.model;

/**
 * @author XiangYuFeng
 * @description 返回信息模型
 * @create 2019/11/9
 * @since 1.0.0
 */
public class ReturnInfoModel {
    /**
     * 数据
     */
    private Object data;
    /**
     * 信息
     */
    private String msg;
    /**
     * 是否请求成功
     */
    private Boolean success;

    public ReturnInfoModel(String msg, Boolean success) {
        this.data = null;
        this.msg = msg;
        this.success = success;
    }

    public ReturnInfoModel(Object data, String msg, Boolean success) {
        this.data = data;
        this.msg = msg;
        this.success = success;
    }

    public ReturnInfoModel(Object data) {
        this.data = data;
        this.msg = "请求成功";
        this.success = true;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Boolean getSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
    }
}