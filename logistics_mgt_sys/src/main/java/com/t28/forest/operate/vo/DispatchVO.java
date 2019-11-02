package com.t28.forest.operate.vo;

import java.util.Date;

/**
 * @author XiangYuFeng
 * @description 派车单页面展示对象
 * @create 2019/11/1
 * @since 1.0.0
 */
public class DispatchVO {
    /**
     * 唯一标识
     */
    private String id;
    /**
     * 当前状态
     */
    private Integer status;
    /**
     * 单号
     */
    private String code;
    /**
     * 计划时间
     */
    private Date dateBill;
    /**
     * 件数
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
     * 提派信息
     */
    private String toSendInfo;
    /**
     * 承运类型
     */
    private Integer carrierType;
    /**
     * 承运商名称
     */
    private String name;
    /**
     * 承运商是否超时
     */
    private Integer isOverdueCarrier;
    /**
     * 车型
     */
    private String vCode1;
    /**
     * 车牌号
     */
    private String vehicleHead;
    /**
     * 司机姓名
     */
    private String driver;
    /**
     * 司机电话
     */
    private String driverIphone;
    /**
     * 重炮比
     */
    private String rebubbleRatio;
    /**
     * 代收代付
     */
    private Double agent;
    /**
     * 结算方式
     */
    private Integer accountType;
    /**
     * 实际出发时间
     */
    private Date planStartTime;
    /**
     * 实际结束时间
     */
    private Date planEndTime;
    /**
     * 实际出发点击时间
     */
    private Date planCilckStartTime;
    /**
     * 实际结束点击时间
     */
    private Date planCilckEndTime;
    /**
     * 是否有异常
     */
    private Integer isAbnormail;
    /**
     * 创建人
     */
    private String createName;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 修改人
     */
    private String modifyName;
    /**
     * 修改时间
     */
    private Date modifyTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getDateBill() {
        return dateBill;
    }

    public void setDateBill(Date dateBill) {
        this.dateBill = dateBill;
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

    public String getToSendInfo() {
        return toSendInfo;
    }

    public void setToSendInfo(String toSendInfo) {
        this.toSendInfo = toSendInfo;
    }

    public Integer getCarrierType() {
        return carrierType;
    }

    public void setCarrierType(Integer carrierType) {
        this.carrierType = carrierType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getIsOverdueCarrier() {
        return isOverdueCarrier;
    }

    public void setIsOverdueCarrier(Integer isOverdueCarrier) {
        this.isOverdueCarrier = isOverdueCarrier;
    }

    public String getvCode1() {
        return vCode1;
    }

    public void setvCode1(String vCode1) {
        this.vCode1 = vCode1;
    }

    public String getVehicleHead() {
        return vehicleHead;
    }

    public void setVehicleHead(String vehicleHead) {
        this.vehicleHead = vehicleHead;
    }

    public String getDriver() {
        return driver;
    }

    public void setDriver(String driver) {
        this.driver = driver;
    }

    public String getDriverIphone() {
        return driverIphone;
    }

    public void setDriverIphone(String driverIphone) {
        this.driverIphone = driverIphone;
    }

    public String getRebubbleRatio() {
        return rebubbleRatio;
    }

    public void setRebubbleRatio(String rebubbleRatio) {
        this.rebubbleRatio = rebubbleRatio;
    }

    public Double getAgent() {
        return agent;
    }

    public void setAgent(Double agent) {
        this.agent = agent;
    }

    public Integer getAccountType() {
        return accountType;
    }

    public void setAccountType(Integer accountType) {
        this.accountType = accountType;
    }

    public Date getPlanStartTime() {
        return planStartTime;
    }

    public void setPlanStartTime(Date planStartTime) {
        this.planStartTime = planStartTime;
    }

    public Date getPlanEndTime() {
        return planEndTime;
    }

    public void setPlanEndTime(Date planEndTime) {
        this.planEndTime = planEndTime;
    }

    public Date getPlanCilckStartTime() {
        return planCilckStartTime;
    }

    public void setPlanCilckStartTime(Date planCilckStartTime) {
        this.planCilckStartTime = planCilckStartTime;
    }

    public Date getPlanCilckEndTime() {
        return planCilckEndTime;
    }

    public void setPlanCilckEndTime(Date planCilckEndTime) {
        this.planCilckEndTime = planCilckEndTime;
    }

    public Integer getIsAbnormail() {
        return isAbnormail;
    }

    public void setIsAbnormail(Integer isAbnormail) {
        this.isAbnormail = isAbnormail;
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
        return "DispatchVO{" +
                "id='" + id + '\'' +
                ", status=" + status +
                ", code='" + code + '\'' +
                ", dateBill=" + dateBill +
                ", number=" + number +
                ", weight=" + weight +
                ", volume=" + volume +
                ", toSendInfo='" + toSendInfo + '\'' +
                ", carrierType=" + carrierType +
                ", name='" + name + '\'' +
                ", isOverdueCarrier=" + isOverdueCarrier +
                ", vCode1='" + vCode1 + '\'' +
                ", vehicleHead='" + vehicleHead + '\'' +
                ", driver='" + driver + '\'' +
                ", driverIphone='" + driverIphone + '\'' +
                ", rebubbleRatio='" + rebubbleRatio + '\'' +
                ", agent=" + agent +
                ", accountType=" + accountType +
                ", planStartTime=" + planStartTime +
                ", planEndTime=" + planEndTime +
                ", planCilckStartTime=" + planCilckStartTime +
                ", planCilckEndTime=" + planCilckEndTime +
                ", isAbnormail=" + isAbnormail +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", modifyName='" + modifyName + '\'' +
                ", modifyTime=" + modifyTime +
                '}';
    }
}