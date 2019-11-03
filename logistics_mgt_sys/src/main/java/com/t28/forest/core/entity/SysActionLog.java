package com.t28.forest.core.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * @author xyf
 * @since 2019-11-03
 */
public class SysActionLog implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "ID", type = IdType.INPUT)
    private String id;

    @TableField("CREATE_NAME")
    private String createName;

    @TableField("CREATE_TIME")
    private LocalDateTime createTime;

    @TableField("DESCRIPTION")
    private String description;

    @TableField("FIELD1")
    private String field1;

    @TableField("FIELD2")
    private String field2;

    @TableField("FIELD3")
    private String field3;

    @TableField("MODIFY_NAME")
    private String modifyName;

    @TableField("MODIFY_TIME")
    private LocalDateTime modifyTime;

    @TableField("NAME")
    private String name;

    @TableField("STATUS")
    private Integer status;

    private LocalDateTime time;

    @TableField("exeTime")
    private Long exeTime;

    private String url;

    @TableField("actionName")
    private String actionName;

    @TableField("methodName")
    private String methodName;


    public String getId() {
        return id;
    }

    public SysActionLog setId(String id) {
        this.id = id;
        return this;
    }

    public String getCreateName() {
        return createName;
    }

    public SysActionLog setCreateName(String createName) {
        this.createName = createName;
        return this;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public SysActionLog setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public SysActionLog setDescription(String description) {
        this.description = description;
        return this;
    }

    public String getField1() {
        return field1;
    }

    public SysActionLog setField1(String field1) {
        this.field1 = field1;
        return this;
    }

    public String getField2() {
        return field2;
    }

    public SysActionLog setField2(String field2) {
        this.field2 = field2;
        return this;
    }

    public String getField3() {
        return field3;
    }

    public SysActionLog setField3(String field3) {
        this.field3 = field3;
        return this;
    }

    public String getModifyName() {
        return modifyName;
    }

    public SysActionLog setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public LocalDateTime getModifyTime() {
        return modifyTime;
    }

    public SysActionLog setModifyTime(LocalDateTime modifyTime) {
        this.modifyTime = modifyTime;
        return this;
    }

    public String getName() {
        return name;
    }

    public SysActionLog setName(String name) {
        this.name = name;
        return this;
    }

    public Integer getStatus() {
        return status;
    }

    public SysActionLog setStatus(Integer status) {
        this.status = status;
        return this;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public SysActionLog setTime(LocalDateTime time) {
        this.time = time;
        return this;
    }

    public Long getExeTime() {
        return exeTime;
    }

    public SysActionLog setExeTime(Long exeTime) {
        this.exeTime = exeTime;
        return this;
    }

    public String getUrl() {
        return url;
    }

    public SysActionLog setUrl(String url) {
        this.url = url;
        return this;
    }

    public String getActionName() {
        return actionName;
    }

    public SysActionLog setActionName(String actionName) {
        this.actionName = actionName;
        return this;
    }

    public String getMethodName() {
        return methodName;
    }

    public SysActionLog setMethodName(String methodName) {
        this.methodName = methodName;
        return this;
    }

    @Override
    public String toString() {
        return "SysActionLog{" +
        "id=" + id +
        ", createName=" + createName +
        ", createTime=" + createTime +
        ", description=" + description +
        ", field1=" + field1 +
        ", field2=" + field2 +
        ", field3=" + field3 +
        ", modifyName=" + modifyName +
        ", modifyTime=" + modifyTime +
        ", name=" + name +
        ", status=" + status +
        ", time=" + time +
        ", exeTime=" + exeTime +
        ", url=" + url +
        ", actionName=" + actionName +
        ", methodName=" + methodName +
        "}";
    }
}
