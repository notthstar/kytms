package com.t28.forest.operate.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author XiangYuFeng
 * @description 货物到站右侧详细信息页面展示对象
 * @create 2019/11/2
 * @since 1.0.0
 */
public class CargoStationDetailedVO {
    /**
     * 唯一ID标识
     */
    private String id;
    /**
     * 组织机构
     */
    private String name;
    /**
     * 订单号
     */
    private String code;
    /**
     * 订单时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date time;
    /**
     * 客户订单号
     */
    private String relateBill;
    /**
     * 客户类型
     */
    private Integer costomerType;
    /**
     * 客户名称
     */
    private String costomerName;
    /**
     * 订单状态
     */
    private Integer status;
    /**
     * 货名
     */
    private String ledName;
    /**
     * 数量
     */
    private Integer number;
    /**
     * 重量
     */
    private Double weight;
    /**
     * 体积
     */
    private Double volume;
    /**
     *是否超时
     */
    private Integer costomerIsExceed;
    /**
     * 目的网点
     */
    private String organName;
    /**
     * 销售负责人
     */
    private String salePersion;
    /**
     * 运输性质
     */
    private Integer transportPro;
    /**
     *是否回单
     */
    private Integer isBack;
    /**
     * 回单份数
     */
    private Integer backNumber;
    /**
     * 实际发运日期
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date factLeaveTime;
    /**
     * 实际抵运日期
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date factArriveTime;
    /**
     * 备注
     */
    private String description;
    /**
     * 创建人
     */
    private String createName;
    /**
     * 创建日期
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date createTime;
    /**
     * 修改人
     */
    private String modifyName;
    /**
     * 修改日期
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date modifyTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getRelateBill() {
        return relateBill;
    }

    public void setRelateBill(String relateBill) {
        this.relateBill = relateBill;
    }

    public Integer getCostomerType() {
        return costomerType;
    }

    public void setCostomerType(Integer costomerType) {
        this.costomerType = costomerType;
    }

    public String getCostomerName() {
        return costomerName;
    }

    public void setCostomerName(String costomerName) {
        this.costomerName = costomerName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getLedName() {
        return ledName;
    }

    public void setLedName(String ledName) {
        this.ledName = ledName;
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

    public Integer getCostomerIsExceed() {
        return costomerIsExceed;
    }

    public void setCostomerIsExceed(Integer costomerIsExceed) {
        this.costomerIsExceed = costomerIsExceed;
    }

    public String getOrganName() {
        return organName;
    }

    public void setOrganName(String organName) {
        this.organName = organName;
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

    public Date getFactLeaveTime() {
        return factLeaveTime;
    }

    public void setFactLeaveTime(Date factLeaveTime) {
        this.factLeaveTime = factLeaveTime;
    }

    public Date getFactArriveTime() {
        return factArriveTime;
    }

    public void setFactArriveTime(Date factArriveTime) {
        this.factArriveTime = factArriveTime;
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
        return "CargoStationDetailedVO{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", code='" + code + '\'' +
                ", time=" + time +
                ", relateBill='" + relateBill + '\'' +
                ", costomerType=" + costomerType +
                ", costomerName='" + costomerName + '\'' +
                ", status=" + status +
                ", ledName='" + ledName + '\'' +
                ", number=" + number +
                ", weight=" + weight +
                ", volume=" + volume +
                ", costomerIsExceed=" + costomerIsExceed +
                ", organName='" + organName + '\'' +
                ", salePersion='" + salePersion + '\'' +
                ", transportPro=" + transportPro +
                ", isBack=" + isBack +
                ", backNumber=" + backNumber +
                ", factLeaveTime=" + factLeaveTime +
                ", factArriveTime=" + factArriveTime +
                ", description='" + description + '\'' +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", modifyName='" + modifyName + '\'' +
                ", modifyTime=" + modifyTime +
                '}';
    }
}