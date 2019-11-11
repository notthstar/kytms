/**
 * @description
 * @author lcy
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.verification.vo;

import java.util.Date;

public class VerificationVo {
    private String id;
    private String organizatilName;
    private String shipmentLiense;
    private String carrierName;
    private String shipmentOutDriver;
    private String shipmentCode;
    private String hxStatus;
    private Date shipmentTime;
    private String shipmentRelatebill;
    private String zmoney;
    private String hxmoney;
    private String whxmoney;
    private String zinput;
    private String hxcount;
    private String tzsource;
    private String organizatilName2;
    private String organizatilName3;
    private String description;
    private String createName;
    private Date createTime;
    private String modifyName;
    private Date modifyTime;
    private String shipmentId;

    @Override
    public String toString() {
        return "VerificationVo{" +
                "id='" + id + '\'' +
                ", organizatilName='" + organizatilName + '\'' +
                ", shipmentLiense='" + shipmentLiense + '\'' +
                ", carrierName='" + carrierName + '\'' +
                ", shipmentOutDriver='" + shipmentOutDriver + '\'' +
                ", shipmentCode='" + shipmentCode + '\'' +
                ", hxStatus='" + hxStatus + '\'' +
                ", shipmentTime=" + shipmentTime +
                ", shipmentRelatebill='" + shipmentRelatebill + '\'' +
                ", zmoney='" + zmoney + '\'' +
                ", hxmoney='" + hxmoney + '\'' +
                ", whxmoney='" + whxmoney + '\'' +
                ", zinput='" + zinput + '\'' +
                ", hxcount='" + hxcount + '\'' +
                ", tzsource='" + tzsource + '\'' +
                ", organizatilName2='" + organizatilName2 + '\'' +
                ", organizatilName3='" + organizatilName3 + '\'' +
                ", description='" + description + '\'' +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", modifyName='" + modifyName + '\'' +
                ", modifyTime=" + modifyTime +
                ", shipmentId='" + shipmentId + '\'' +
                '}';
    }

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

    public String getShipmentLiense() {
        return shipmentLiense;
    }

    public void setShipmentLiense(String shipmentLiense) {
        this.shipmentLiense = shipmentLiense;
    }

    public String getCarrierName() {
        return carrierName;
    }

    public void setCarrierName(String carrierName) {
        this.carrierName = carrierName;
    }

    public String getShipmentOutDriver() {
        return shipmentOutDriver;
    }

    public void setShipmentOutDriver(String shipmentOutDriver) {
        this.shipmentOutDriver = shipmentOutDriver;
    }

    public String getShipmentCode() {
        return shipmentCode;
    }

    public void setShipmentCode(String shipmentCode) {
        this.shipmentCode = shipmentCode;
    }

    public String getHxStatus() {
        return hxStatus;
    }

    public void setHxStatus(String hxStatus) {
        this.hxStatus = hxStatus;
    }

    public Date getShipmentTime() {
        return shipmentTime;
    }

    public void setShipmentTime(Date shipmentTime) {
        this.shipmentTime = shipmentTime;
    }

    public String getShipmentRelatebill() {
        return shipmentRelatebill;
    }

    public void setShipmentRelatebill(String shipmentRelatebill) {
        this.shipmentRelatebill = shipmentRelatebill;
    }

    public String getZmoney() {
        return zmoney;
    }

    public void setZmoney(String zmoney) {
        this.zmoney = zmoney;
    }

    public String getHxmoney() {
        return hxmoney;
    }

    public void setHxmoney(String hxmoney) {
        this.hxmoney = hxmoney;
    }

    public String getWhxmoney() {
        return whxmoney;
    }

    public void setWhxmoney(String whxmoney) {
        this.whxmoney = whxmoney;
    }

    public String getZinput() {
        return zinput;
    }

    public void setZinput(String zinput) {
        this.zinput = zinput;
    }

    public String getHxcount() {
        return hxcount;
    }

    public void setHxcount(String hxcount) {
        this.hxcount = hxcount;
    }

    public String getTzsource() {
        return tzsource;
    }

    public void setTzsource(String tzsource) {
        this.tzsource = tzsource;
    }

    public String getOrganizatilName2() {
        return organizatilName2;
    }

    public void setOrganizatilName2(String organizatilName2) {
        this.organizatilName2 = organizatilName2;
    }

    public String getOrganizatilName3() {
        return organizatilName3;
    }

    public void setOrganizatilName3(String organizatilName3) {
        this.organizatilName3 = organizatilName3;
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

    public String getShipmentId() {
        return shipmentId;
    }

    public void setShipmentId(String shipmentId) {
        this.shipmentId = shipmentId;
    }
}
