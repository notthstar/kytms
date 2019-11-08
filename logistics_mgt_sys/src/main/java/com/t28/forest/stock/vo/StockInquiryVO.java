/**
 * @description 抽取类
 * @author HF
 * @create 2019/10/29
 * @since 1.0.0
 */
package com.t28.forest.stock.vo;

import java.util.Date;

public class StockInquiryVO {
    private String id;
    /**
     * 产品id
     */
    private String orderid;
    /**
     *
     */
    private String name;
    /**
     * 组织机构
     */

    private String code;
    /**
     * 分段订单号
     */
    private Date time;
    /**
     * 订单日期
     */
    private Integer relatebill1;
    /**
     * 客户订单号
     */
    private Integer costomerType;
    /**
     * 客户类型
     */
    private String customerName;
    /**
     * 客户名称
     */
    private Integer status;
    /**
     * 订单状态
     */
    private Integer costomerIsExceed;
    /**
     * 是否超期
     */
    private Integer transportPro;
    /**
     * 运输性质
     */
    private Integer isBack;
    /**
     * 是否回单
     */
    private Integer backNuber;
    /**
     * 回单份数
     */
    private String goodsName;
    /**
     * 货名
     */
    private Integer number;
    /**
     * 件数
     */
    private Double weight;
    /**
     * 重量
     */
    private Double volume;
    /**
     * 体积
     */
    private String salePersion;
    /**
     * 销售负责人
     */
    private String description;
    /**
     * 备注
     */
    private String createName;
    /**
     * 创建人
     */
    private Date createTime;
    /**
     * 创建时间
     */
    private String modeifyName;
    /**
     * 修改人
     */
    private Date modifyTime;
    /**
     *修改时间
     */
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public Integer getRelatebill1() {
        return relatebill1;
    }

    public void setRelatebill1(Integer relatebill1) {
        this.relatebill1 = relatebill1;
    }

    public Integer getCostomerType() {
        return costomerType;
    }

    public void setCostomerType(Integer costomerType) {
        this.costomerType = costomerType;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
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

    public Integer getBackNuber() {
        return backNuber;
    }

    public void setBackNuber(Integer backNuber) {
        this.backNuber = backNuber;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
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

    public String getSalePersion() {
        return salePersion;
    }

    public void setSalePersion(String salePersion) {
        this.salePersion = salePersion;
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

    public String getModeifyName() {
        return modeifyName;
    }

    public void setModeifyName(String modeifyName) {
        this.modeifyName = modeifyName;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    @Override
    public String toString() {
        return "StockInquiryVO{" +
                "id='" + id + '\'' +
                ", orderid='" + orderid + '\'' +
                ", name='" + name + '\'' +
                ", code='" + code + '\'' +
                ", time=" + time +
                ", relatebill1=" + relatebill1 +
                ", costomerType=" + costomerType +
                ", customerName='" + customerName + '\'' +
                ", status=" + status +
                ", costomerIsExceed=" + costomerIsExceed +
                ", transportPro=" + transportPro +
                ", isBack=" + isBack +
                ", backNuber=" + backNuber +
                ", goodsName='" + goodsName + '\'' +
                ", number=" + number +
                ", weight=" + weight +
                ", volume=" + volume +
                ", salePersion='" + salePersion + '\'' +
                ", description='" + description + '\'' +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", modeifyName='" + modeifyName + '\'' +
                ", modifyTime=" + modifyTime +
                '}';
    }
}
