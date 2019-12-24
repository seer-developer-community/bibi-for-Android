package com.nyzc.gdm.currencyratio.accountPacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.google.gson.Gson;
import com.nyzc.gdm.currencyratio.Base.AppLocalWalletUser;
import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.EthAccount;
import com.nyzc.gdm.currencyratio.Bean.FileSave;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;
import com.nyzc.gdm.currencyratio.Utils.HttpUrl;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;
import com.nyzc.gdm.currencyratio.View.ReminderBrainkeyDailog;
import com.nyzc.gdm.currencyratio.uipacakage.CheckBrainkeyActivity;
import com.zhy.http.okhttp.OkHttpUtils;
import com.zhy.http.okhttp.callback.StringCallback;

import butterknife.BindView;
import butterknife.ButterKnife;
import okhttp3.Call;

public class RechargeActivity extends BaseActivity {
    @BindView(R.id.custom_title)
    CustomTitleBar custom_title;
    @BindView(R.id.btn_eth)
    TextView btn_eth;
    account_object AccountObject = null;
    String assetId;
    @BindView(R.id.chongzhi)
    TextView chongzhi;
    @BindView(R.id.chongzhi_er)
    TextView chongzhiEr;
    @BindView(R.id.chongzhi_tex_er)
    TextView chongzhiTexEr;
    @BindView(R.id.chongzhibiao)
    TextView chongzhibiao;
    @BindView(R.id.chongzhisan)
    TextView chongzhisan;
    @BindView(R.id.bindingETH)
    Button bindingETH;

    //    private String pfc = "将您在交易所或以太钱包的PFC自动兑换至主网（币比）钱包。系统已自动为您的账号分配了一个ETH地址。将交易所或以太钱包中的PFC Token转入该地址，Seer主网（币比）帐号即可自动获得等额PFC，第一次建议小额转账先试一下.";
//    private String pfc_en = "Exchange your PFC from the exchange or wallet to the main network wallet automatically.Omni-pfc USES the BTC network and the system has automatically assigned a BTC address to your account.Transfer the PFC from the exchange or wallet to this address, and the Seer main network (bitcoin) account will automatically get the same amount of PFC.For the first time, it is recommended to try small amount transfer first.";
//    private String usdt = "将您在交易所或钱包的USDT自动兑换至主网（币比）钱包。Omni-USDT使用BTC网络，系统已自动为您的账号分配了一个BTC地址。将交易所或钱包中的USDT转入该地址，Seer主网（币比）帐号即可自动获得等额USDT，第一次建议小额转账先试一下。";
//    private String usdt_en = "Exchange your USDT from the exchange or wallet to the main network wallet automatically.Omni-usdt USES the BTC network and the system has automatically assigned a BTC address to your account.Transfer the USDT from the exchange or wallet to this address, and the Seer main network (bitcoin) account will automatically get the same amount of USDT.For the first time, it is recommended to try small amount transfer first.";
    private String langauage;
    private String string;
    private String eth_request_address;

    private String omni_address;
    private account_object accountObject;


    @Override
    public int getLayoutId() {
        return R.layout.activity_recharge;
    }


    public static void start(Context context, String assetId) {
        Intent starter = new Intent(context, RechargeActivity.class);
        starter.putExtra("assetId", assetId);
        context.startActivity(starter);
    }


    @Override
    protected void init() {
//        CacheUtils.putString(LangauageManagerActivity.this, "langauage", "en");

        langauage = CacheUtils.getString(this, "langauage", "zh");
        custom_title.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
            @Override
            public void onLeftClick() {
                finish();
            }

            @Override
            public void onRightClick() {

            }
        });
        MyApp.localWalletUser = (AppLocalWalletUser) FileSave.read(RechargeActivity.this, "localwallet");
        assetId = getIntent().getStringExtra("assetId");
        string = btn_eth.getText().toString();

        try {
            if (MyApp.localWalletUser != null) {
                AccountObject = BitsharesWalletWraper.getInstance().get_account_object(MyApp.localWalletUser.getLocalName());
                if (HttpUrl.queryEth.equals("")) {
                    btn_eth.setText(getString(R.string.searchFail));
                } else {
                    switch (assetId) {
//                        SEER
                        case "1.3.0":
                            QueryEthAddress(AccountObject.getId().get_userId());
                            chongzhiEr.setVisibility(View.VISIBLE);
                            chongzhiTexEr.setVisibility(View.VISIBLE);
                            break;
//                        USDT
                        case "1.3.5":
                            QueryUSDTEthAddress(AccountObject.getId().get_userId());
                            chongzhibiao.setText(getString(R.string.pfcbiao_usdt));
                            chongzhisan.setText(R.string.gong);
                            chongzhi.setText(R.string.ustd);
//                        PFC
                        case "1.3.2":
                            QueryEthAddress(AccountObject.getId().get_userId());
                            chongzhisan.setText(R.string.gong);
                            chongzhibiao.setText(R.string.pfcbiao);
                            chongzhi.setText(R.string.pfc);
                    }

                }

            }

        } catch (
                NetworkStatusException e)

        {
            e.printStackTrace();
        }





    }



    private void QueryUSDTEthAddress(String userId) {
        OkHttpUtils.get().url(HttpUrl.queryUsdtAddress)
                .addParams("seer_account_id", userId)
                .build()
                .execute(new StringCallback() {


                    @Override
                    public void onError(Call call, Exception e, int id) {
                        Log.e("onError", e.getMessage());
                    }

                    @Override
                    public void onResponse(String response, int id) {
                        EthAccount ethAccount = new Gson().fromJson(response.toString(), EthAccount.class);
                        if (ethAccount.getMsg().equals("ok") || ethAccount.getCode() == 0) {
                            if (ethAccount.getData().getOmni_address() != null) {
                                omni_address = ethAccount.getData().getOmni_address();

                                btn_eth.setText(omni_address);
                                bindingETH.setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        try {
                                            accountObject = BitsharesWalletWraper.getInstance().get_account_object(MyApp.localWalletUser.getLocalName());
                                            if (TextUtils.isEmpty(omni_address)){
                                                BindEth( accountObject.getId().get_userId(), accountObject.getName());
                                            }else{
                                                return;
                                            }
                                        } catch (NetworkStatusException e) {
                                            e.printStackTrace();
                                        }

                                    }
                                });
                            }
                        } else {
                            btn_eth.setText(getString(R.string.searchFail));
                        }

                    }
                });
    }


    /**
     * 查询ETH地址
     *
     * @param id
     */
    ReminderBrainkeyDailog reminderBrainkeyDailog;
    String ErrorResult = "";
    String result;

    private void QueryEthAddress(String id) {
        OkHttpUtils.get().url(HttpUrl.queryEth)
                .addParams("seer_account_id", id)
                .build()
                .execute(new StringCallback() {
                    @Override
                    public void onError(Call call, Exception e, int id) {
                        Log.e("onError", e.getMessage());
                    }

                    @Override
                    public void onResponse(String response, int id) {
                        EthAccount ethAccount = new Gson().fromJson(response.toString(), EthAccount.class);
                        if (ethAccount.getMsg().equals("ok") || ethAccount.getCode() == 0) {
                            if (ethAccount.getData().getEth_address() != null) {
                                btn_eth.setText(ethAccount.getData().getEth_address());
                            }
                        } else {
                            btn_eth.setText(getString(R.string.searchFail));
                        }

                    }
                });
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // TODO: add setContentView(...) invocation
        ButterKnife.bind(this);
    }

    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            dismissLoadingDialog();
            if (msg.arg1 == 1) {
                reminderBrainkeyDailog = new ReminderBrainkeyDailog(getString(R.string.BackupDone), getString(R.string.RemoveBraink), RechargeActivity.this);
                reminderBrainkeyDailog.show(getSupportFragmentManager(), "dialog");
            } else {
                showInfoDialog(ErrorResult);
            }

        }
    };

    private void BindEth(String seerid, String seername) {
        try {
            OkHttpUtils.post().url(HttpUrl.bindEth)
                    .addParams("seer_account_id", seerid)
                    .addParams("seer_account_name", seername)
                    .build()
                    .execute(new StringCallback() {
                        @Override
                        public void onError(Call call, Exception e, int id) {
                            dismissLoadingDialog();
                            showInfoDialog(e.getMessage());
                        }

                        @Override
                        public void onResponse(String response, int id) {
                            EthAccount ethAccount = new Gson().fromJson(response.toString(), EthAccount.class);
                            switch (ethAccount.getCode()) {
                                case 0:
                                    BindUSDT(seerid, seername);
                                    eth_request_address = ethAccount.getData().getEth_address();
                                    btn_eth.post(new Runnable() {
                                        @Override
                                        public void run() {
                                            btn_eth.setText(eth_request_address);
                                            Log.e("=======",btn_eth.toString());
                                        }
                                    });
                                    break;
                                case 2002:
                                    Message msg1 = new Message();
                                    msg1.arg1 = 0;
                                    handler.sendMessage(msg1);
                                    ErrorResult = getString(R.string.Bindingexsites);
                                    break;
                                default:
                                    result = response;
                                    Message msg2 = new Message();
                                    msg2.arg1 = 0;
                                    handler.sendMessage(msg2);
                                    ErrorResult = result.toString();
                                    break;
                            }
                        }
                    });
        } catch (Exception e) {
            showInfoDialog(e.getMessage());
        }


    }

    private void BindUSDT(String usdtId, String usdtName) {
        try {
            OkHttpUtils.post().url(HttpUrl.bindUsdtAddress)
                    .addParams("seer_account_id", usdtId)
                    .addParams("seer_account_name", usdtName)
                    .build()
                    .execute(new StringCallback() {
                        @Override
                        public void onError(Call call, Exception e, int id) {
                            dismissLoadingDialog();
                            showInfoDialog(e.getMessage());
                        }

                        @Override
                        public void onResponse(String response, int id) {
                            EthAccount ethAccount = new Gson().fromJson(response.toString(), EthAccount.class);
                            switch (ethAccount.getCode()) {
                                case 0:
                                    Log.e("sdfhasjfda", ethAccount.getData().getOmni_address().toString());
                                    Message msg = new Message();
                                    msg.arg1 = 1;
                                    handler.sendMessage(msg);
                                    break;
                                case 9001:
                                    Message msg1 = new Message();
                                    msg1.arg1 = 0;
                                    handler.sendMessage(msg1);
                                    ErrorResult = getString(R.string.Bindingexsites);
                                    break;
                                default:
                                    result = response;
                                    Message msg2 = new Message();
                                    msg2.arg1 = 0;
                                    handler.sendMessage(msg2);
                                    ErrorResult = result.toString();
                                    break;
                            }
                        }
                    });
        } catch (Exception e) {
            showInfoDialog(e.getMessage());
        }
    }
}
