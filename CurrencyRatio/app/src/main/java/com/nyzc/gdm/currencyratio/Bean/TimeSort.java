package com.nyzc.gdm.currencyratio.Bean;

public class TimeSort {

    String time;
    String roomId;
    Double totalShares;

    public Double getTotalShares() {
        return totalShares;
    }

    public void setTotalShares(Double totalShares) {
        this.totalShares = totalShares;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    @Override
    public String toString() {
        return "TimeSort{" +
                "time='" + time + '\'' +
                ", roomId='" + roomId + '\'' +
                ", totalShares=" + totalShares +
                '}';
    }
}
