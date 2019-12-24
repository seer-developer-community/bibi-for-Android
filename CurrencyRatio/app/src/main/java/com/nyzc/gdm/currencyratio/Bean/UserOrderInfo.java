package com.nyzc.gdm.currencyratio.Bean;

import java.io.Serializable;
import java.util.List;

public class UserOrderInfo implements Serializable {


    private List<List<String>> rooms;
    private List<List<String>> count_total;
    private List<List<String>> share_total;
    private List<List<String>> count_wins;
    private List<List<String>> share_wins;
    private List<?> count_back;
    private List<?> share_back;

    public List<List<String>> getRooms() {
        return rooms;
    }

    public void setRooms(List<List<String>> rooms) {
        this.rooms = rooms;
    }

    public List<List<String>> getCount_total() {
        return count_total;
    }

    public void setCount_total(List<List<String>> count_total) {
        this.count_total = count_total;
    }

    public List<List<String>> getShare_total() {
        return share_total;
    }

    public void setShare_total(List<List<String>> share_total) {
        this.share_total = share_total;
    }

    public List<List<String>> getCount_wins() {
        return count_wins;
    }

    public void setCount_wins(List<List<String>> count_wins) {
        this.count_wins = count_wins;
    }

    public List<List<String>> getShare_wins() {
        return share_wins;
    }

    public void setShare_wins(List<List<String>> share_wins) {
        this.share_wins = share_wins;
    }

    public List<?> getCount_back() {
        return count_back;
    }

    public void setCount_back(List<?> count_back) {
        this.count_back = count_back;
    }

    public List<?> getShare_back() {
        return share_back;
    }

    public void setShare_back(List<?> share_back) {
        this.share_back = share_back;
    }
}
