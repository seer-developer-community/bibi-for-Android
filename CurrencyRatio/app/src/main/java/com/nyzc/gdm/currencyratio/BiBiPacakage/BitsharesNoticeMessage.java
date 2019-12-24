package com.nyzc.gdm.currencyratio.BiBiPacakage;



import java.util.List;

/**
 * Created by lorne on 22/09/2017.
 */
public class BitsharesNoticeMessage {
    int nSubscriptionId;

    // market_notice
    List<operations.operation_type> listFillOrder;
    List<limit_order_object> listOrderObject;

    // account
    boolean bAccountChanged;
}
