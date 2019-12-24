package com.nyzc.gdm.currencyratio.Bean;

import com.google.gson.internal.LinkedTreeMap;

import java.io.Serializable;

public class OrderListBean implements Serializable {


    /**
     * id : 2.18.38848
     * player : 1.2.16559
     * room : 1.15.1234
     * input : 1
     * asset_id : 1.3.0
     * block_num : 9534089
     * when : 2019-04-17T06:06:03
     * amount : 500000
     * paid : 500000
     * sequence : 24
     * reward : 0
     * settle_time : 1970-01-01T00:00:00
     * result : 0
     */

    private String id;
    private String player;
    private String room;
    private int input;
    private String asset_id;
    private int block_num;
    private String when;
    private int amount;
    private int paid;
    private int sequence;
    private int reward;
    private String settle_time;
    private int result;
    private String roomTitle;
    private String roomSelect;
    private int roomType;

    public int getRoomType() {
        return roomType;
    }

    public void setRoomType(int roomType) {
        this.roomType = roomType;
    }

    public String getRoomSelect() {
        return roomSelect;
    }

    public void setRoomSelect(String roomSelect) {
        this.roomSelect = roomSelect;
    }

    public String getRoomTitle() {
        return roomTitle;
    }

    public void setRoomTitle(String roomTitle) {
        this.roomTitle = roomTitle;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPlayer() {
        return player;
    }

    public void setPlayer(String player) {
        this.player = player;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }

    public int getInput() {
        return input;
    }

    public void setInput(int input) {
        this.input = input;
    }

    public String getAsset_id() {
        return asset_id;
    }

    public void setAsset_id(String asset_id) {
        this.asset_id = asset_id;
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

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public int getPaid() {
        return paid;
    }

    public void setPaid(int paid) {
        this.paid = paid;
    }

    public int getSequence() {
        return sequence;
    }

    public void setSequence(int sequence) {
        this.sequence = sequence;
    }

    public int getReward() {
        return reward;
    }

    public void setReward(int reward) {
        this.reward = reward;
    }

    public String getSettle_time() {
        return settle_time;
    }

    public void setSettle_time(String settle_time) {
        this.settle_time = settle_time;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }

    @Override
    public String toString() {
        return "OrderListBean{" +
                "id='" + id + '\'' +
                ", player='" + player + '\'' +
                ", room='" + room + '\'' +
                ", input=" + input +
                ", asset_id='" + asset_id + '\'' +
                ", block_num=" + block_num +
                ", when='" + when + '\'' +
                ", amount=" + amount +
                ", paid=" + paid +
                ", sequence=" + sequence +
                ", reward=" + reward +
                ", settle_time='" + settle_time + '\'' +
                ", result=" + result +
                ", roomTitle='" + roomTitle + '\'' +
                ", roomSelect='" + roomSelect + '\'' +
                ", roomType=" + roomType +
                '}';
    }
}
