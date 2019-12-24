package com.nyzc.gdm.currencyratio.Bean;

import java.io.Serializable;

public class UserOrderBean implements Serializable{
    private String id;
    private String roomTitle;
    private String roomSelect;
    private String roomSelectAmount;
    private String joinRoomTime;
    private String reward;
    private double selectFinalResult;
    private int roomType;
    private double pvdBuySell;
    private double advancedOdds;
    private String pvdAmount;
    private String stopTime;
    private String status;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStopTime() {
        return stopTime;
    }

    public void setStopTime(String stopTime) {
        this.stopTime = stopTime;
    }

    public String getPvdAmount() {
        return pvdAmount;
    }

    public void setPvdAmount(String pvdAmount) {
        this.pvdAmount = pvdAmount;
    }

    public double getAdvancedOdds() {
        return advancedOdds;
    }

    public void setAdvancedOdds(double advancedOdds) {
        this.advancedOdds = advancedOdds;
    }

    public double getPvdBuySell() {
        return pvdBuySell;
    }

    public void setPvdBuySell(double pvdBuySell) {
        this.pvdBuySell = pvdBuySell;
    }

    public int getRoomType() {
        return roomType;
    }

    public void setRoomType(int roomType) {
        this.roomType = roomType;
    }

    public double getSelectFinalResult() {
        return selectFinalResult;
    }

    public void setSelectFinalResult(double selectFinalResult) {
        this.selectFinalResult = selectFinalResult;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getReward() {
        return reward;
    }

    public void setReward(String reward) {
        this.reward = reward;
    }

    public String getRoomTitle() {
        return roomTitle;
    }

    public void setRoomTitle(String roomTitle) {
        this.roomTitle = roomTitle;
    }

    public String getRoomSelect() {
        return roomSelect;
    }

    public void setRoomSelect(String roomSelect) {
        this.roomSelect = roomSelect;
    }

    public String getRoomSelectAmount() {
        return roomSelectAmount;
    }

    public void setRoomSelectAmount(String roomSelectAmount) {
        this.roomSelectAmount = roomSelectAmount;
    }

    public String getJoinRoomTime() {
        return joinRoomTime;
    }

    public void setJoinRoomTime(String joinRoomTime) {
        this.joinRoomTime = joinRoomTime;
    }

    @Override
    public String toString() {
        return "UserOrderBean{" +
                "id='" + id + '\'' +
                ", roomTitle='" + roomTitle + '\'' +
                ", roomSelect='" + roomSelect + '\'' +
                ", roomSelectAmount='" + roomSelectAmount + '\'' +
                ", joinRoomTime='" + joinRoomTime + '\'' +
                ", reward='" + reward + '\'' +
                ", selectFinalResult=" + selectFinalResult +
                ", roomType=" + roomType +
                ", pvdBuySell=" + pvdBuySell +
                ", advancedOdds=" + advancedOdds +
                ", pvdAmount='" + pvdAmount + '\'' +
                ", stopTime='" + stopTime + '\'' +
                '}';
    }
}
