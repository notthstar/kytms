/**
 * @description
 * @author lcy
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.order.vo;

public class ServerZone {
        private String id;
        private String organizatilName;
        private String zoneName;
        private String serverType;
        private String serverMileage;
        private String minMoney;
        private String serverSong;
        private String serverWeight;
        private String serverVolume;
        private String createName;
        private String createTime;
        private String modifyName;
        private String modifyTime;
        private String status;

    @Override
    public String toString() {
        return "ServerZone{" +
                "id='" + id + '\'' +
                ", organizatilName='" + organizatilName + '\'' +
                ", zoneName='" + zoneName + '\'' +
                ", serverType='" + serverType + '\'' +
                ", serverMileage='" + serverMileage + '\'' +
                ", minMoney='" + minMoney + '\'' +
                ", serverSong='" + serverSong + '\'' +
                ", serverWeight='" + serverWeight + '\'' +
                ", serverVolume='" + serverVolume + '\'' +
                ", createName='" + createName + '\'' +
                ", createTime='" + createTime + '\'' +
                ", modifyName='" + modifyName + '\'' +
                ", modifyTime='" + modifyTime + '\'' +
                ", status='" + status + '\'' +
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

    public String getZoneName() {
        return zoneName;
    }

    public void setZoneName(String zoneName) {
        this.zoneName = zoneName;
    }

    public String getServerType() {
        return serverType;
    }

    public void setServerType(String serverType) {
        this.serverType = serverType;
    }

    public String getServerMileage() {
        return serverMileage;
    }

    public void setServerMileage(String serverMileage) {
        this.serverMileage = serverMileage;
    }

    public String getMinMoney() {
        return minMoney;
    }

    public void setMinMoney(String minMoney) {
        this.minMoney = minMoney;
    }

    public String getServerSong() {
        return serverSong;
    }

    public void setServerSong(String serverSong) {
        this.serverSong = serverSong;
    }

    public String getServerWeight() {
        return serverWeight;
    }

    public void setServerWeight(String serverWeight) {
        this.serverWeight = serverWeight;
    }

    public String getServerVolume() {
        return serverVolume;
    }

    public void setServerVolume(String serverVolume) {
        this.serverVolume = serverVolume;
    }

    public String getCreateName() {
        return createName;
    }

    public void setCreateName(String createName) {
        this.createName = createName;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getModifyName() {
        return modifyName;
    }

    public void setModifyName(String modifyName) {
        this.modifyName = modifyName;
    }

    public String getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(String modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
