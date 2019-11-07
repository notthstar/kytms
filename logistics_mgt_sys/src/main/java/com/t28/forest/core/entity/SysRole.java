package com.t28.forest.core.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * @author xyf
 * @since 2019-11-07
 */
@TableName("jc_sys_role")
public class SysRole implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "ID", type = IdType.INPUT)
    private String id;

    @TableField("CODE")
    private String code;

    @TableField("CREATE_NAME")
    private String createName;

    @TableField("CREATE_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date createTime;

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
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date modifyTime;

    @TableField("NAME")
    private String name;

    @TableField("STATUS")
    private Integer status;


    public String getId() {
        return id;
    }

    public SysRole setId(String id) {
        this.id = id;
        return this;
    }

    public String getCode() {
        return code;
    }

    public SysRole setCode(String code) {
        this.code = code;
        return this;
    }

    public String getCreateName() {
        return createName;
    }

    public SysRole setCreateName(String createName) {
        this.createName = createName;
        return this;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getDescription() {
        return description;
    }

    public SysRole setDescription(String description) {
        this.description = description;
        return this;
    }

    public String getField1() {
        return field1;
    }

    public SysRole setField1(String field1) {
        this.field1 = field1;
        return this;
    }

    public String getField2() {
        return field2;
    }

    public SysRole setField2(String field2) {
        this.field2 = field2;
        return this;
    }

    public String getField3() {
        return field3;
    }

    public SysRole setField3(String field3) {
        this.field3 = field3;
        return this;
    }

    public String getModifyName() {
        return modifyName;
    }

    public SysRole setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public String getName() {
        return name;
    }

    public SysRole setName(String name) {
        this.name = name;
        return this;
    }

    public Integer getStatus() {
        return status;
    }

    public SysRole setStatus(Integer status) {
        this.status = status;
        return this;
    }

    @Override
    public String toString() {
        return "SysRole{" +
        "id=" + id +
        ", code=" + code +
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
        "}";
    }
}
