package com.nyzc.gdm.currencyratio.Bean;

public class TransferBean {
    private String name;
    private boolean isOneSelf;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isOneSelf() {
        return isOneSelf;
    }

    public void setOneSelf(boolean oneSelf) {
        isOneSelf = oneSelf;
    }

    @Override
    public String toString() {
        return "TransferBean{" +
                "name='" + name + '\'' +
                ", isOneSelf=" + isOneSelf +
                '}';
    }
}
