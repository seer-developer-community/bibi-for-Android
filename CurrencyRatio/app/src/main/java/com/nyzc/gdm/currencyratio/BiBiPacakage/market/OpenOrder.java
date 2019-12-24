package com.nyzc.gdm.currencyratio.BiBiPacakage.market;


import com.nyzc.gdm.currencyratio.BiBiPacakage.asset_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.limit_order_object;

public class OpenOrder {
    public limit_order_object limitOrder;
    public asset_object base;
    public asset_object quote;
    public double price;
}
