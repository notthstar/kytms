/**
 * @description 分段订单
 * @author lcy
 * @create 2019/11/1
 * @since 1.0.0
 */
package com.t28.forest.order.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

import java.sql.Date;

public class Led {
    @TableId(value = "ID", type = IdType.AUTO)
    private String id;



    @TableField("CODE")
    private String code;

    @TableField("TIME")
    private Date time;

    @TableField("RELATEBILL1")
    private String relatebill1;

    @TableField("COSTOMER_TYPE")
    private Integer costomerType;

    @TableField("RELATEBILL2")
    private String relatebill2;

    private String ledreceiviName;

    @TableField("STATUS")
    private Integer status;

    @TableField("COSTOMER_IS_EXCEED")
    private Integer costomerIsExceed;

    @TableField("SALE_PERSION")
    private String salePersion;

    @TableField("TRANSPORT_PRO")
    private Integer transportPro;

    @TableField("IS_BACK")
    private Integer isBack;

    @TableField("BACK_NUMBER")
    private Integer backNumber;

    @TableField("NUMBER")
    private Integer number;

    @TableField("WEIGHT")
    private Double weight;

    @TableField("VOLUME")
    private Double volume;

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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getRelatebill1() {
        return relatebill1;
    }

    public void setRelatebill1(String relatebill1) {
        this.relatebill1 = relatebill1;
    }

    public Integer getCostomerType() {
        return costomerType;
    }

    public void setCostomerType(Integer costomerType) {
        this.costomerType = costomerType;
    }

    public String getRelatebill2() {
        return relatebill2;
    }

    public void setRelatebill2(String relatebill2) {
        this.relatebill2 = relatebill2;
    }

    public String getLedreceiviName() {
        return ledreceiviName;
    }

    public void setLedreceiviName(String ledreceiviName) {
        this.ledreceiviName = ledreceiviName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getCostomerIsExceed() {
        return costomerIsExceed;
    }

    public void setCostomerIsExceed(Integer costomerIsExceed) {
        this.costomerIsExceed = costomerIsExceed;
    }

    public String getSalePersion() {
        return salePersion;
    }

    public void setSalePersion(String salePersion) {
        this.salePersion = salePersion;
    }

    public Integer getTransportPro() {
        return transportPro;
    }

    public void setTransportPro(Integer transportPro) {
        this.transportPro = transportPro;
    }

    public Integer getIsBack() {
        return isBack;
    }

    public void setIsBack(Integer isBack) {
        this.isBack = isBack;
    }

    public Integer getBackNumber() {
        return backNumber;
    }

    public void setBackNumber(Integer backNumber) {
        this.backNumber = backNumber;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public Double getVolume() {
        return volume;
    }

    public void setVolume(Double volume) {
        this.volume = volume;
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
        return "Led{" +
                "id='" + id + '\'' +
                ", code='" + code + '\'' +
                ", time=" + time +
                ", relatebill1='" + relatebill1 + '\'' +
                ", costomerType=" + costomerType +
                ", relatebill2='" + relatebill2 + '\'' +
                ", ledreceiviName='" + ledreceiviName + '\'' +
                ", status=" + status +
                ", costomerIsExceed=" + costomerIsExceed +
                ", salePersion='" + salePersion + '\'' +
                ", transportPro=" + transportPro +
                ", isBack=" + isBack +
                ", backNumber=" + backNumber +
                ", number=" + number +
                ", weight=" + weight +
                ", volume=" + volume +
                ", description='" + description + '\'' +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", modifyName='" + modifyName + '\'' +
                ", modifyTime=" + modifyTime +
                '}';
    }
}
