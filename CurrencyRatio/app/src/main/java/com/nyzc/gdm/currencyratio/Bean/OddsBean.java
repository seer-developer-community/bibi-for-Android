package com.nyzc.gdm.currencyratio.Bean;

import java.io.Serializable;

public class OddsBean implements Serializable {

    private String odds;
    private boolean isSelect;
    private boolean isForeCast;

    public String getOdds() {
        return odds;
    }

    public void setOdds(String odds) {
        this.odds = odds;
    }

    public boolean isSelect() {
        return isSelect;
    }

    public void setSelect(boolean select) {
        isSelect = select;
    }

    public boolean isForeCast() {
        return isForeCast;
    }

    public void setForeCast(boolean foreCast) {
        isForeCast = foreCast;
    }

    @Override
    public String toString() {
        return "OddsBean{" +
                "odds='" + odds + '\'' +
                ", isSelect=" + isSelect +
                ", isForeCast=" + isForeCast +
                '}';
    }
}
