package com.t28.forest.core.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * @author xyf
 * @since 2019-11-03
 */
public class ShipmentTrack implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "ID", type = IdType.INPUT)
    private String id;

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

    @TableField("EVENT")
    private String event;

    @TableField("PERSON")
    private String person;

    @TableField("TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date time;

    @TableField("TYPE")
    private Integer type;

    @TableField("JC_SHIPMENT_ID")
    private String jcShipmentId;


    public String getId() {
        return id;
    }

    public ShipmentTrack setId(String id) {
        this.id = id;
        return this;
    }

    public String getCreateName() {
        return createName;
    }

    public ShipmentTrack setCreateName(String createName) {
        this.createName = createName;
        return this;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public ShipmentTrack setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public ShipmentTrack setDescription(String description) {
        this.description = description;
        return this;
    }

    public String getField1() {
        return field1;
    }

    public ShipmentTrack setField1(String field1) {
        this.field1 = field1;
        return this;
    }

    public String getField2() {
        return field2;
    }

    public ShipmentTrack setField2(String field2) {
        this.field2 = field2;
        return this;
    }

    public String getField3() {
        return field3;
    }

    public ShipmentTrack setField3(String field3) {
        this.field3 = field3;
        return this;
    }

    public String getModifyName() {
        return modifyName;
    }

    public ShipmentTrack setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public ShipmentTrack setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
        return this;
    }

    public String getName() {
        return name;
    }

    public ShipmentTrack setName(String name) {
        this.name = name;
        return this;
    }

    public Integer getStatus() {
        return status;
    }

    public ShipmentTrack setStatus(Integer status) {
        this.status = status;
        return this;
    }

    public String getEvent() {
        return event;
    }

    public ShipmentTrack setEvent(String event) {
        this.event = event;
        return this;
    }

    public String getPerson() {
        return person;
    }

    public ShipmentTrack setPerson(String person) {
        this.person = person;
        return this;
    }

    public Date getTime() {
        return time;
    }

    public ShipmentTrack setTime(Date time) {
        this.time = time;
        return this;
    }

    public Integer getType() {
        return type;
    }

    public ShipmentTrack setType(Integer type) {
        this.type = type;
        return this;
    }

    public String getJcShipmentId() {
        return jcShipmentId;
    }

    public ShipmentTrack setJcShipmentId(String jcShipmentId) {
        this.jcShipmentId = jcShipmentId;
        return this;
    }

    @Override
    public String toString() {
        return "ShipmentTrack{" +
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
        ", event=" + event +
        ", person=" + person +
        ", time=" + time +
        ", type=" + type +
        ", jcShipmentId=" + jcShipmentId +
        "}";
    }
}
