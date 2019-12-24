package com.nyzc.gdm.currencyratio.Base;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.util.Log;

import com.nyzc.gdm.currencyratio.Bean.OrderListBean;
import com.nyzc.gdm.currencyratio.Utils.NetworkUtil;

import java.util.List;


/**
 * Created by ZJL
 * on 2018/6/21 0021.
 */

public class NetBroadcastReceiver extends BroadcastReceiver {
    boolean netWorkState;
    @Override
    public void onReceive(Context context, Intent intent) {
        // 如果相等的话就说明网络状态发生了变化
        if (ConnectivityManager.CONNECTIVITY_ACTION.equals(intent.getAction())) {
             netWorkState = NetworkUtil.isNetworkConnected(context);
            // 接口回调传过去状态的类型
            if (BaseActivity.netEvent != null)
                BaseActivity.netEvent.onNetChange(netWorkState);
        }else{
            Log.e("netError",netWorkState+"");
        }
    }

    // 网络状态变化接口
    public interface NetChangeListener {
        void onNetChange(boolean netWorkState);
    }

    public interface OrderInterFace {
        void setData(List<List<Object>> list);
    }

}
