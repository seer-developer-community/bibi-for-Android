package com.nyzc.gdm.currencyratio.homePacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Message;
import android.widget.TextView;

import com.google.gson.Gson;
import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.ErrorMessage;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.RoomObject;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.signed_transaction;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;
import com.nyzc.gdm.currencyratio.Utils.DateUtil;
import com.nyzc.gdm.currencyratio.Utils.FileUtils;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;
import com.nyzc.gdm.currencyratio.homePacakage.Adapter.ForecastProgressAdapter;
import com.nyzc.gdm.currencyratio.homePacakage.Adapter.ForecastbottomAdapter;
import com.nyzc.gdm.currencyratio.homePacakage.interFace.ForcaseListen;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.uipacakage.ForcastResultActivity;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;
import com.nyzc.gdm.currencyratio.View.MyListView;
import com.nyzc.gdm.currencyratio.View.RemindInputForcastDialog;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


import butterknife.BindView;


public class ForeCastActivity extends BaseActivity implements ForcaseListen {

    @BindView(R.id.tv_stop_time)
    TextView tvStopTime;
    @BindView(R.id.tv_type_room)
    TextView tv_type_room;
    @BindView(R.id.tv_pfc)
    TextView tvPfc;
    @BindView(R.id.tv_tongji)
    TextView tvTongji;
    @BindView(R.id.tv_num)
    TextView tvNum;
    @BindView(R.id.forecast_list_lv)
    MyListView forecastListLv;
    @BindView(R.id.lv_forecast_bottom)
    MyListView lvForecastBottom;
    @BindView(R.id.custom_title)
    CustomTitleBar customTitleBar;
    @BindView(R.id.lv_trade_list)
    MyListView lv_trade_list;
    ForecastProgressAdapter mAdapter;
    ForecastbottomAdapter mForeCastAdapter;
    RoomObject roomBean;
    @BindView(R.id.tv_trade_recoder)
    TextView tv_trade_recoder;
    @BindView(R.id.tv_forecast_content)
    TextView tv_forecast_content;
    String roomId, endRoomId;
    String miuNum;
    String maxNum;

    /**
     * 从首页列表进入到房间信息 直接传房间roomBeans信息
     *
     * @param context
     * @param roomBeans
     */
    public static void start(Context context, RoomObject roomBeans) {
        Intent starter = new Intent(context, ForeCastActivity.class);
        starter.putExtra("RoomBean", roomBeans);
        context.startActivity(starter);
    }

    /**
     * 从其他列表进入到房间信息 直接传房间id
     */
    public static void resultStart(Context context, String endRoomId) {
        Intent starter = new Intent(context, ForeCastActivity.class);
        starter.putExtra("endRoomId", endRoomId);
        context.startActivity(starter);
    }

    @Override
    public int getLayoutId() {
        return R.layout.activity_fore_cast;
    }

    RemindInputForcastDialog remindInputForcastDialog;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String langauage;

    /**
     * 初始化房间信息
     */
    @Override
    protected void init() {
        try {
            showLoadingDialog();
            langauage = CacheUtils.getString(this, "langauage", "");
            customTitleBar.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
                @Override
                public void onLeftClick() {
                    finish();
                }

                @Override
                public void onRightClick() {
                }
            });
            endRoomId = getIntent().getStringExtra("endRoomId");
            if (endRoomId == null) {
                roomBean = (RoomObject) getIntent().getSerializableExtra("RoomBean");
                roomId = roomBean.getId().get_userId();
                try {
                    roomBean = BitsharesWalletWraper.getInstance().getSeerRoom(roomId);
                } catch (NetworkStatusException e) {
                    e.printStackTrace();
                }
            } else {
                try {
                    roomBean = BitsharesWalletWraper.getInstance().getSeerRoom(endRoomId);
                    roomId = roomBean.getId().get_userId();
                } catch (NetworkStatusException e) {
                    e.printStackTrace();
                }
            }
            miuNum = NumerUtil.getSeerBigDecimal(String.valueOf(roomBean.getOption().getMinimum()));
            maxNum = NumerUtil.getSeerBigDecimal(String.valueOf(roomBean.getOption().getMaximum()));
            mAdapter = new ForecastProgressAdapter(ForeCastActivity.this);
            forecastListLv.setAdapter(mAdapter);
            mForeCastAdapter = new ForecastbottomAdapter(ForeCastActivity.this);
            lvForecastBottom.setAdapter(mForeCastAdapter);
            setData();
        } catch (Exception e) {
            showInfoDialog(e.getMessage());
        }
    }


    String assetType;
    String stopTime;
    boolean isForcast = true;
    DecimalFormat decimalFormat = new DecimalFormat("###################.###########");

    private void setData() {
        try {
            new Handler().postDelayed(() -> {
                if (roomBean.getOption().getStop() != null) {
                    if (langauage.equals("zh")) {
                        stopTime = DateUtil.addDateMinut(roomBean.getOption().getStop().replace("T", " "), 8);
                        tvStopTime.setText(getString(R.string.Deadline) + stopTime);
                    } else {
                        stopTime = DateUtil.addDateMinut(roomBean.getOption().getStop().replace("T", " "), 0);
                        tvStopTime.setText(getString(R.string.Deadline) + stopTime + " GMT");
                    }
                    try {
                        if (langauage.equals("zh")) {
                            Date d = new Date();
                            Date dt1 = sdf.parse(stopTime);
                            if (d.getTime() > dt1.getTime()) {
                                isForcast = false;
                            }
                        } else {
                            Date d = new Date();
                            String GTM = DateUtil.downDateMinut(sdf.format(d), 8);
                            d = sdf.parse(GTM);
                            Date dt1 = sdf.parse(stopTime);
                            if (d.getTime() > dt1.getTime()) {
                                isForcast = false;

                            }
                        }

                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                }
                switch (roomBean.getRoom_type()) {
                    case 0:
                        tv_type_room.setText(getString(R.string.transactionPrediction));
                        break;
                    case 1:
                        tv_type_room.setText(getString(R.string.prizePoolprediction));
                        break;
                    case 2:
                        tv_type_room.setText(getString(R.string.fixedodds));
                        break;
                }
                if (roomBean.getDescription() != null) {
                    tv_forecast_content.setText(FileUtils.replaceBlank(roomBean.getDescription()).replace("          ", ""));
                }

                if (roomBean.getRunning_option().getTotal_player_count() != -1) {
                    tvNum.setText(decimalFormat.format(roomBean.getRunning_option().getTotal_player_count()) + "");
                }
                assetType = roomBean.getOption().getAccept_asset();
                switch (assetType) {
                    case "1.3.0":
                        tvTongji.setText("SEER");
                        if (roomBean.getRunning_option().getTotal_shares() != -1) {
                            tvPfc.setText(NumerUtil.getSeerBigDecimal(String.valueOf(roomBean.getRunning_option().getTotal_shares())));
                        }
                        break;
                    case "1.3.5":
                        tvTongji.setText("USDT");
                        if (roomBean.getRunning_option().getTotal_shares() != -1) {
                            tvPfc.setText(NumerUtil.getUsdtBigDecimal(String.valueOf(roomBean.getRunning_option().getTotal_shares())));
                        }
                        break;
                    case "1.3.2":
                        tvTongji.setText("PFC");
                        if (roomBean.getRunning_option().getTotal_shares() != -1) {
                            tvPfc.setText(NumerUtil.getPFCBigDecimal(String.valueOf(roomBean.getRunning_option().getTotal_shares())));
                        }
                        break;
                }
                if (roomBean != null) {
                    mAdapter.setData(roomBean);
                    mForeCastAdapter.setData(roomBean, isForcast);
                }
                dismissLoadingDialog();
            }, 1000);
        } catch (Exception e) {
            showInfoDialog(e.getMessage());
        }

    }

    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            {
                switch (msg.arg1) {
                    case 0:
                        remindInputForcastDialog.dismiss();
                        dismissLoadingDialog();
                        ForcastResultActivity.start(ForeCastActivity.this, roomBean, roomPositon, pridictString.toString());
                        finish();
                        break;
                    case 1:
                        dismissLoadingDialog();
                        ErrorMessage errorMessage = new Gson().fromJson(networkStatusException.getMessage(), ErrorMessage.class);
                        if (errorMessage.getMessage() != null) {
                            if (errorMessage.getMessage().indexOf("need_pay") != -1) {
                                showInfoDialog(getString(R.string.selljudege));
                            }
                        } else {
                            showInfoDialog(networkStatusException.getMessage());
                        }
                        break;
                }

            }
        }
    };
    /**
     * 房间投注
     *
     * @param position
     * @param roomObject
     */
    int roomPositon;
    String pridictString;
    NetworkStatusException networkStatusException;

    @Override
    public void forcastListen(final int position, RoomObject roomObject) {
        remindInputForcastDialog = new RemindInputForcastDialog(position, roomBean, inputText -> {
            if (inputText.toString() != null) {
                pridictString = inputText.toString();
                int nRet = BitsharesWalletWraper.getInstance().build_connect();
                if (nRet == 0) {
                    showLoadingDialog();
                    if (MyApp.localWalletUser != null) {
                        new Thread(() -> {
                            try {
                                signed_transaction signedTransaction = BitsharesWalletWraper.getInstance().forecastTransfer(MyApp.localWalletUser.getLocalName(), 0, roomId, pridictString, position, assetType);
                                if (signedTransaction != null) {
                                    roomPositon = position;
                                    Message message = new Message();
                                    message.arg1 = 0;
                                    handler.sendMessage(message);
                                }
                            } catch (NetworkStatusException e) {
                                networkStatusException = e;
                                Message message = new Message();
                                message.arg1 = 1;
                                handler.sendMessage(message);

                            }
                        }).start();


                    }
                }
            }
        });
        remindInputForcastDialog.show(getSupportFragmentManager(), "dialog");
    }
}
