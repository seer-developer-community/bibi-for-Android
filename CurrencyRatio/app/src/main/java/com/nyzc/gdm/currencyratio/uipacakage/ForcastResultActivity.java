package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;
import com.google.gson.reflect.TypeToken;
import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.BlockRoomHeader;
import com.nyzc.gdm.currencyratio.Bean.GetHouseBean;
import com.nyzc.gdm.currencyratio.Bean.UserOrderBean;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.RoomObject;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.asset;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.MainActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;
import com.nyzc.gdm.currencyratio.Utils.DateUtil;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;
import com.nyzc.gdm.currencyratio.homePacakage.ForeCastActivity;

import org.greenrobot.eventbus.EventBus;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ForcastResultActivity extends BaseActivity {


    @BindView(R.id.tv_forcast_success)
    TextView tvForcastSuccess;
    @BindView(R.id.tv_forcast_detail)
    TextView tvForcastDetail;
    @BindView(R.id.tv_forcast_select)
    TextView tvForcastSelect;
    @BindView(R.id.tv_forcast_amount)
    TextView tvForcastAmount;
    @BindView(R.id.rela_forcast_info)
    RelativeLayout relaForcastInfo;
    @BindView(R.id.tv_forcast_stop_time)
    TextView tvForcastStopTime;
    @BindView(R.id.tv_forcast_success_detail)
    RelativeLayout tvForcastSuccessDetail;
    @BindView(R.id.tv_see_recorder)
    TextView tvSeeRecorder;
    @BindView(R.id.tv_continue_forcast)
    TextView tvContinueForcast;
    @BindView(R.id.rela_forcast_success)
    RelativeLayout relaForcastSuccess;

    @Override
    public int getLayoutId() {
        return R.layout.forcast_result_layout;
    }

    RoomObject roomObject;
    String amountSEER;
    int selectRoom;
    String assetType;

    public static void start(Context context, RoomObject roomObject, int select, String amountSEER) {
        Intent starter = new Intent(context, ForcastResultActivity.class);
        starter.putExtra("roomObject", roomObject);
        starter.putExtra("select", select);
        starter.putExtra("amountSEER", amountSEER);
        context.startActivity(starter);
    }

    String forcastStoptime;
    String langauage;

    /**
     * 房间投注成功后的页面
     */
    @Override
    protected void init() {
        try {
            langauage = CacheUtils.getString(this, "langauage", "");
            amountSEER = getIntent().getStringExtra("amountSEER");
            roomObject = (RoomObject) getIntent().getSerializableExtra("roomObject");
            selectRoom = getIntent().getIntExtra("select", -1);
            relaForcastSuccess.setVisibility(View.VISIBLE);
            tvForcastDetail.setText(roomObject.getDescription());
            tvForcastSelect.setText(roomObject.getRunning_option().getSelection_description().get(selectRoom));
            assetType = roomObject.getOption().getAccept_asset();
            if (roomObject.getRoom_type() == 0) {
                tvForcastAmount.setText(amountSEER + getString(R.string.share));
            } else {
                switch (assetType) {
                    case "1.3.0":
                        MyApp.assetOrder="1.3.0";
                        tvForcastAmount.setText(amountSEER + "SEER");
                        break;
                    case "1.3.5":
                        MyApp.assetOrder="1.3.5";
                        tvForcastAmount.setText(amountSEER + "USDT");
                        break;
                    case "1.3.2":
                        MyApp.assetOrder="1.3.2";
                        tvForcastAmount.setText(amountSEER + "PFC");
                        break;
                }
            }
            if (langauage.equals("zh")) {
                forcastStoptime = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 8);
                tvForcastStopTime.setText(getString(R.string.Deadline) + forcastStoptime);
            } else {
                forcastStoptime = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 0);
                tvForcastStopTime.setText(getString(R.string.Deadline) + forcastStoptime + " GMT");
            }

            /**
             * isChangerOrder=1 代表投注成功后 要到订单页面刷新数据的标识。
             */
            MyApp.isChangeOrder = 1;
            getData();
        } catch (Exception e) {
            showInfoDialog(e.getMessage());
        }

        /**
         * 查看记录 跳入订单页面
         * EventBus发送post(refreshOrder)和isChangerOrder=1是刷新订单标识
         */
        tvSeeRecorder.setOnClickListener(view -> {
            EventBus.getDefault().post("refreshOrder");
            Intent intent = new Intent(ForcastResultActivity.this, MainActivity.class);
            intent.putExtra("lanchMode", 2);
            startActivity(intent);
            finish();
        });

        /**
         *  继续预测进入房间信息后及时刷新数据
         */
        tvContinueForcast.setOnClickListener(view -> {
            MyApp.isChangeOrder = 1;
            ForeCastActivity.start(ForcastResultActivity.this, roomObject);
            finish();
        });

    }

    account_object AccountObject = null;
    String amount;

    /**
     * 投注成功后及时刷新余额
     */
    private void getData() {
        if (MyApp.localWalletUser != null) {
            try {
                AccountObject = BitsharesWalletWraper.getInstance().get_account_object(MyApp.localWalletUser.getLocalName());
                List<asset> list = BitsharesWalletWraper.getInstance().list_account_balance(AccountObject.id, true);
                for (int i = 0; i < list.size(); i++) {
                    if(list.get(i).asset_id.get_userId().equals(assetType)){
                       switch (assetType){
                           case "1.3.0":
                               amount = NumerUtil.getSeerBigDecimal(String.valueOf(list.get(i).amount));
                               MyApp.localWalletUser.setAmoutSeerMoney(amount);
                               break;
                           case "1.3.5":
                               amount = NumerUtil.getUsdtBigDecimal(String.valueOf(list.get(i).amount));
                               MyApp.localWalletUser.setAmountUsdtMoney(amount);
                               break;
                           case "1.3.2":
                               amount = NumerUtil.getSeerBigDecimal(String.valueOf(list.get(i).amount));
                               MyApp.localWalletUser.setAmountUsdtMoney(amount);
                               break;
                       }
                    }
                }
            } catch (NetworkStatusException e) {
                e.printStackTrace();
            }
        }
    }

}
