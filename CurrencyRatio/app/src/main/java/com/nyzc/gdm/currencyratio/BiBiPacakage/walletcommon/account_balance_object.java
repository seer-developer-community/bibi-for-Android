package com.nyzc.gdm.currencyratio.BiBiPacakage.walletcommon;


import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.asset_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.object_id;

/**
 * Created by lorne on 01/11/2017.
 */

public class account_balance_object {
    public object_id id;
    public object_id<account_object> owner;
    public object_id<asset_object> asset_type;
    public long balance;
}
