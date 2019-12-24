package com.nyzc.gdm.currencyratio.Bean;

import com.nyzc.gdm.currencyratio.BiBiPacakage.operations;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ZJL
 * on 2018/7/21 0021.
 */

public class WaitAccountBean implements Serializable {
    List<operations.transfer_operation> transationBeanList;
    List<String> listData=new ArrayList<>();
    List<TransferBean> listUserTo=new ArrayList<>();

    public List<TransferBean> getListUserTo() {
        return listUserTo;
    }

    public void setListUserTo(List<TransferBean> listUserTo) {
        this.listUserTo = listUserTo;
    }

    public List<operations.transfer_operation> getTransationBeanList() {
        return transationBeanList;
    }

    public void setTransationBeanList(List<operations.transfer_operation> transationBeanList) {
        this.transationBeanList = transationBeanList;
    }

    public List<String> getListData() {
        return listData;
    }

    public void setListData(List<String> listData) {
        this.listData = listData;
    }

    @Override
    public String toString() {
        return "WaitAccountBean{" +
                "transationBeanList=" + transationBeanList +
                ", listData=" + listData +
                ", listUserTo=" + listUserTo +
                '}';
    }
}
