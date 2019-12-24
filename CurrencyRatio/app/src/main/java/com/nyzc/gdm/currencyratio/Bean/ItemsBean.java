package com.nyzc.gdm.currencyratio.Bean;

public class ItemsBean {

    /**
     * block_num : 283652
     * when : 2019-04-01T08:39:15
     * amount : 900
     * paid : 1000
     * sequence : 0
     */

    private int block_num;
    private String when;
    private double amount;
    private double paid;
    private int sequence;
    private String des;
    private String select_option;
    private int roomType;
    private double prizeAmount;
    private double prizePvpAmount;
    private String roomId;

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public double getPrizePvpAmount() {
        return prizePvpAmount;
    }

    public void setPrizePvpAmount(double prizePvpAmount) {
        this.prizePvpAmount = prizePvpAmount;
    }

    public double getPrizeAmount() {
        return prizeAmount;
    }

    public void setPrizeAmount(double prizeAmount) {
        this.prizeAmount = prizeAmount;
    }

    public int getRoomType() {
        return roomType;
    }

    public void setRoomType(int roomType) {
        this.roomType = roomType;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getSelect_option() {
        return select_option;
    }

    public void setSelect_option(String select_option) {
        this.select_option = select_option;
    }

    public int getBlock_num() {
        return block_num;
    }

    public void setBlock_num(int block_num) {
        this.block_num = block_num;
    }

    public String getWhen() {
        return when;
    }

    public void setWhen(String when) {
        this.when = when;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public double getPaid() {
        return paid;
    }

    public void setPaid(double paid) {
        this.paid = paid;
    }

    public int getSequence() {
        return sequence;
    }

    public void setSequence(int sequence) {
        this.sequence = sequence;
    }

    @Override
    public String toString() {
        return "ItemsBean{" +
                "block_num=" + block_num +
                ", when='" + when + '\'' +
                ", amount=" + amount +
                ", paid=" + paid +
                ", sequence=" + sequence +
                ", des='" + des + '\'' +
                ", select_option='" + select_option + '\'' +
                '}';
    }
}
