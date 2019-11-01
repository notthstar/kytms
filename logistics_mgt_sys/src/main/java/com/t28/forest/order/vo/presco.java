/**
 * @description 计划单VO类
 * @author lcy
 * @create 2019/10/31
 * @since 1.0.0
 */
package com.t28.forest.order.vo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

import java.sql.Date;

public class presco {

    @TableId(value = "ID", type = IdType.AUTO)
    private String id;

    private String organizatilName;

    @TableField("STATUS")
    private Integer status;

    private String zoneName;

    @TableField("FH_NAME")
    private String fhName;

    @TableField("FH_ADDRESS")
    private String fhAddress;

    @TableField("WEIGHT")
    private Double weight;

    @TableField("NUMBER")
    private Integer number;

    @TableField("VOLUME")
    private Double volume;

    @TableField("FH_PERSON")
    private String fhPerson;

    @TableField("FH_IPHONE")
    private String fhIphone;

    @TableField("CODE")
    private String code;

    @TableField("COSTOMER_TPYE")
    private Integer costomerTpye;

    @TableField("RELATEBILL1")
    private String relatebill1;

    @TableField("DATE_ACCEPTED")
    private Date dateAccepted;

    @TableField("SH_NAME")
    private String shName;

    @TableField("SH_PERSON")
    private String shPerson;

    @TableField("SH_IPHONE")
    private String shIphone;

    @TableField("SH_ADDRESS")
    private String shAddress;

    @TableField("DESCRIPTION")
    private String description;

    @TableField("CREATE_NAME")
    private String createName;

    @TableField("CREATE_TIME")
    private Date createTime;

    @TableField("MODIFY_NAME")
    private String modifyName;

    @TableField("MODIFY_TIME")
    private Date modifyTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrganizatilName() {
        return organizatilName;
    }

    public void setOrganizatilName(String organizatilName) {
        this.organizatilName = organizatilName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getZoneName() {
        return zoneName;
    }

    public void setZoneName(String zoneName) {
        this.zoneName = zoneName;
    }

    public String getFhName() {
        return fhName;
    }

    public void setFhName(String fhName) {
        this.fhName = fhName;
    }

    public String getFhAddress() {
        return fhAddress;
    }

    public void setFhAddress(String fhAddress) {
        this.fhAddress = fhAddress;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Double getVolume() {
        return volume;
    }

    public void setVolume(Double volume) {
        this.volume = volume;
    }

    public String getFhPerson() {
        return fhPerson;
    }

    public void setFhPerson(String fhPerson) {
        this.fhPerson = fhPerson;
    }

    public String getFhIphone() {
        return fhIphone;
    }

    public void setFhIphone(String fhIphone) {
        this.fhIphone = fhIphone;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getCostomerTpye() {
        return costomerTpye;
    }

    public void setCostomerTpye(Integer costomerTpye) {
        this.costomerTpye = costomerTpye;
    }

    public String getRelatebill1() {
        return relatebill1;
    }

    public void setRelatebill1(String relatebill1) {
        this.relatebill1 = relatebill1;
    }

    public Date getDateAccepted() {
        return dateAccepted;
    }

    public void setDateAccepted(Date dateAccepted) {
        this.dateAccepted = dateAccepted;
    }

    public String getShName() {
        return shName;
    }

    public void setShName(String shName) {
        this.shName = shName;
    }

    public String getShPerson() {
        return shPerson;
    }

    public void setShPerson(String shPerson) {
        this.shPerson = shPerson;
    }

    public String getShIphone() {
        return shIphone;
    }

    public void setShIphone(String shIphone) {
        this.shIphone = shIphone;
    }

    public String getShAddress() {
        return shAddress;
    }

    public void setShAddress(String shAddress) {
        this.shAddress = shAddress;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    @Override
    public String toString() {
        return "presco{" +
                "id='" + id + '\'' +
                ", organizatilName='" + organizatilName + '\'' +
                ", status=" + status +
                ", zoneName='" + zoneName + '\'' +
                ", fhName='" + fhName + '\'' +
                ", fhAddress='" + fhAddress + '\'' +
                ", weight=" + weight +
                ", number=" + number +
                ", volume=" + volume +
                ", fhPerson='" + fhPerson + '\'' +
                ", fhIphone='" + fhIphone + '\'' +
                ", code='" + code + '\'' +
                ", costomerTpye=" + costomerTpye +
                ", relatebill1='" + relatebill1 + '\'' +
                ", dateAccepted=" + dateAccepted +
                ", shName='" + shName + '\'' +
                ", shPerson='" + shPerson + '\'' +
                ", shIphone='" + shIphone + '\'' +
                ", shAddress='" + shAddress + '\'' +
                ", description='" + description + '\'' +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", modifyName='" + modifyName + '\'' +
                ", modifyTime=" + modifyTime +
                '}';
    }
}
