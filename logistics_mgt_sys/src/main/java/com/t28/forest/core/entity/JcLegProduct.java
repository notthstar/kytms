/**
 * @description
 * @author HF
 * @create 2019/10/29
 * @since 1.0.0
 */
package com.t28.forest.core.entity;

import java.util.Date;

public class JcLegProduct {

    private String id;
    private String createName;
    private Date createTime;
    private String description;
    private String field1;
    private String field2;
    private String field3;
    private String modifyName;
    private Date modifyTime;
    private String name;
    private Integer status;
    private Integer number;
    private String unit;
    private Double value;
    private Double volume;
    private Double weight;
    private String jcLedId;
    private Double jzWeight;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateName() {
        return createName;
    }

    public void setCreateName(String createName) {
        this.createName = createName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getField1() {
        return field1;
    }

    public void setField1(String field1) {
        this.field1 = field1;
    }

    public String getField2() {
        return field2;
    }

    public void setField2(String field2) {
        this.field2 = field2;
    }

    public String getField3() {
        return field3;
    }

    public void setField3(String field3) {
        this.field3 = field3;
    }

    public String getModifyName() {
        return modifyName;
    }

    public void setModifyName(String modifyName) {
        this.modifyName = modifyName;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Double getValue() {
        return value;
    }

    public void setValue(Double value) {
        this.value = value;
    }

    public Double getVolume() {
        return volume;
    }

    public void setVolume(Double volume) {
        this.volume = volume;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public String getJcLedId() {
        return jcLedId;
    }

    public void setJcLedId(String jcLedId) {
        this.jcLedId = jcLedId;
    }

    public Double getJzWeight() {
        return jzWeight;
    }

    public void setJzWeight(Double jzWeight) {
        this.jzWeight = jzWeight;
    }

    @Override
    public String toString() {
        return "JcLegProduct{" +
                "id='" + id + '\'' +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", description='" + description + '\'' +
                ", field1='" + field1 + '\'' +
                ", field2='" + field2 + '\'' +
                ", field3='" + field3 + '\'' +
                ", modifyName='" + modifyName + '\'' +
                ", modifyTime=" + modifyTime +
                ", name='" + name + '\'' +
                ", status=" + status +
                ", number=" + number +
                ", unit='" + unit + '\'' +
                ", value=" + value +
                ", volume=" + volume +
                ", weight=" + weight +
                ", jcLedId='" + jcLedId + '\'' +
                ", jzWeight=" + jzWeight +
                '}';
    }
}
