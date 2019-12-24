package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.widget.GridView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.Gson;
import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.EthAccount;
import com.nyzc.gdm.currencyratio.Bean.RegistError;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.asset;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.HttpUrl;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;
import com.nyzc.gdm.currencyratio.View.ReminderBrainkeyDailog;
import com.nyzc.gdm.currencyratio.uipacakage.Adapter.BrainkeyAdapter;
import com.nyzc.gdm.currencyratio.uipacakage.Adapter.BrainkeyAnotherAdapter;
import com.nyzc.gdm.currencyratio.uipacakage.interFace.BrainkeyDownListen;
import com.nyzc.gdm.currencyratio.uipacakage.interFace.BrainkeyUpListen;
import com.zhy.http.okhttp.OkHttpUtils;
import com.zhy.http.okhttp.callback.StringCallback;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import butterknife.BindView;
import okhttp3.Call;

public class CheckBrainkeyActivity extends BaseActivity implements BrainkeyUpListen, BrainkeyDownListen {


    @BindView(R.id.custom_title)
    CustomTitleBar customTitle;
    @BindView(R.id.tv_save)
    TextView tvSave;
    @BindView(R.id.tv_save_reminding)
    TextView tvSaveReminding;
    @BindView(R.id.gridview_brainkey)
    GridView gridviewBrainkey;
    @BindView(R.id.gridview_another_brainkey)
    GridView gridviewAnotherBrainkey;
    @BindView(R.id.tv_brainkey)
    TextView tv_brainkey;
    List<String> list = new ArrayList<>();
    BrainkeyAdapter brainkeyAdapter;
    BrainkeyAnotherAdapter brainkeyAnotherAdapter;
    List<String> listUpBrainkey = new ArrayList<>();
    List<String> listDownBrainkey = new ArrayList<>();
    BrainkeyDownListen brainkeyDownListen;
    BrainkeyUpListen brainkeyUpListen;
    ReminderBrainkeyDailog reminderBrainkeyDailog;

    @Override
    public int getLayoutId() {
        return R.layout.activity_check_brainkey;
    }


    public static void start(Context context) {
        Intent starter = new Intent(context, CheckBrainkeyActivity.class);
        context.startActivity(starter);
    }

    StringBuffer stringBuffer;

    /**
     * 核对助记词  核对成功后 调用链接区块链接口和绑定eth接口
     */
    @Override
    protected void init() {
        try {
            brainkeyDownListen = this;
            brainkeyUpListen = this;
            reminderBrainkeyDailog = new ReminderBrainkeyDailog(getString(R.string.TakeAscreenshot), getString(R.string.RemindBriank), CheckBrainkeyActivity.this);
            reminderBrainkeyDailog.show(getSupportFragmentManager(), "dialog");
            customTitle.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
                @Override
                public void onLeftClick() {
                    finish();
                }

                @Override
                public void onRightClick() {
                }
            });
            list = BrainkeyToList(MyApp.localWalletUser.getLocalBrainKey());
            brainkeyAdapter = new BrainkeyAdapter(list, CheckBrainkeyActivity.this);
            gridviewBrainkey.setAdapter(brainkeyAdapter);
        } catch (Exception e) {
            showInfoDialog(e.getMessage());
        }
        tv_brainkey.setOnClickListener(view -> {
            try {
                if (listUpBrainkey.size() != 16) {
                    if (tv_brainkey.getText().toString().equals("下一步") || tv_brainkey.getText().toString().equals("Next")) {
                        tvSaveReminding.setText(getString(R.string.PleaseclicBraink));
                        brainkeyAdapter.setData(listUpBrainkey);
                        listDownBrainkey = list;
                        Collections.shuffle(listDownBrainkey);
                        brainkeyAnotherAdapter = new BrainkeyAnotherAdapter(listDownBrainkey, CheckBrainkeyActivity.this);
                        gridviewAnotherBrainkey.setAdapter(brainkeyAnotherAdapter);
                        gridviewAnotherBrainkey.setVisibility(View.VISIBLE);
                        tv_brainkey.setText(getString(R.string.Confirm));
                    } else {
                        Toast.makeText(CheckBrainkeyActivity.this, getString(R.string.checkBraink), Toast.LENGTH_SHORT).show();
                    }
                } else {
                    stringBuffer = new StringBuffer();
                    for (int i = 0; i < listUpBrainkey.size(); i++) {
                        if (stringBuffer.length() > 0) {//该步即不会第一位有逗号，也防止最后一位拼接逗号！
                            stringBuffer.append(" ");
                        }
                        stringBuffer.append(listUpBrainkey.get(i));
                    }
                    if (String.valueOf(stringBuffer).equals(MyApp.localWalletUser.getLocalBrainKey())) {
                        showLoadingDialog();
                        if (HttpUrl.connect_Graphenej.equals("")) {
                            dismissLoadingDialog();
                            showInfoDialog(getString(R.string.Addresserror));
                        } else {
                            // 上链
                            CreateGraphenej();
                        }

                    } else {
                        reminderBrainkeyDailog = new ReminderBrainkeyDailog(getString(R.string.BackupFailure), getString(R.string.checkBraink), CheckBrainkeyActivity.this);
                        reminderBrainkeyDailog.show(getSupportFragmentManager(), "dialog");
                    }

                }
            } catch (Exception e) {
                showInfoDialog(e.getMessage());
            }
        });
        gridviewBrainkey.setClickable(false);
        gridviewBrainkey.setPressed(false);
        gridviewBrainkey.setEnabled(false);
        gridviewBrainkey.setOnItemClickListener((adapterView, view, i, l) -> {
            isChange = true;
            if (brainkeyUpListen != null) {
                brainkeyUpListen.changeUpBrainkey(listUpBrainkey.get(i), i);
            }
        });
        gridviewAnotherBrainkey.setOnItemClickListener((adapterView, view, i, l) -> {
            gridviewBrainkey.setClickable(true);
            gridviewBrainkey.setPressed(true);
            gridviewBrainkey.setEnabled(true);
            if (brainkeyDownListen != null) {
                brainkeyDownListen.changeDownBrainkey(listDownBrainkey.get(i), i);
            }
        });
    }

    private List<String> BrainkeyToList(String strs) {
        String str[] = strs.split(" ");
        for (int i = 0; i < str.length; i++) {
            list.add(str[i]);
        }
        return list;

    }

    boolean isChange = false;


    @Override
    public void changeDownBrainkey(String brainkey, int i) {
        try {
            if (isChange) {
                listDownBrainkey.add(brainkey);
                brainkeyAnotherAdapter.setData(listDownBrainkey);
            } else {
                listDownBrainkey.remove(i);
                brainkeyAnotherAdapter.setData(listDownBrainkey);
                brainkeyUpListen.changeUpBrainkey(brainkey, i);
                if (listDownBrainkey.size() == 0) {
                    isChange = true;
                }
            }
        } catch (Exception e) {
            showInfoDialog(e.getMessage());
        }


    }

    @Override
    public void changeUpBrainkey(String brainkey, int i) {
        try {
            if (isChange) {
                String get_brainkey = listUpBrainkey.get(i);
                listUpBrainkey.remove(i);
                brainkeyAdapter.setData(listUpBrainkey);
                brainkeyDownListen.changeDownBrainkey(get_brainkey, i);
                isChange = false;
            } else {
                listUpBrainkey.add(brainkey);
                brainkeyAdapter.setData(listUpBrainkey);
            }
        } catch (Exception e) {
            showInfoDialog(e.getMessage());
        }

    }

    String result;
    String loaclSeerAmount, localUsdtAmount, localPFCAmount;
    account_object accountObject;
    String ErrorResult = "";


    /**
     * 链接区块链
     */
    private void CreateGraphenej() {

        new Thread(() -> {
            try {
                final String json = new Gson().toJson(MyApp.accountGraphenejBean);
                HttpPost httpPost = new HttpPost(HttpUrl.connect_Graphenej);
                httpPost.setHeader("Content-Type", "application/json");
                httpPost.setEntity(new StringEntity(json));
                HttpResponse resp = new DefaultHttpClient().execute(httpPost);
                HttpEntity entity = resp.getEntity();
                result = EntityUtils.toString(entity, "UTF-8");
                int status = resp.getStatusLine().getStatusCode();
                switch (status) {
                    case 500:
                        List<asset> list = null;
                        try {
                            accountObject = BitsharesWalletWraper.getInstance().get_account_object(MyApp.localWalletUser.getLocalName());
                            list = BitsharesWalletWraper.getInstance().list_account_balance(accountObject.id, false);
                            for (int i = 0; i < list.size(); i++) {
                                switch (list.get(i).asset_id.get_userId()) {
//                                    SEER
                                    case "1.3.0":
                                        loaclSeerAmount = NumerUtil.getSeerBigDecimal(String.valueOf(list.get(i).amount));
                                        MyApp.localWalletUser.setAmoutSeerMoney(loaclSeerAmount);
                                        break;
//                                    USDT
                                    case "1.3.5":
                                        localUsdtAmount = NumerUtil.getUsdtBigDecimal(String.valueOf(list.get(i).amount));
                                        MyApp.localWalletUser.setAmountUsdtMoney(localUsdtAmount);
                                        break;
//                                    PFC
                                    case "1.3.2":
                                        localPFCAmount = NumerUtil.getUsdtBigDecimal(String.valueOf(list.get(i).amount));
                                        MyApp.localWalletUser.setAmountPFCMoney(localPFCAmount);
                                        break;
                                }
                            }
                            if (HttpUrl.queryEth.equals("")) {
                                dismissLoadingDialog();
                                showInfoDialog(getString(R.string.Addresserror));
                            } else {
                                BindEth(accountObject.getId().get_userId(), accountObject.getName());
                            }
                        } catch (NetworkStatusException e) {
                            e.printStackTrace();
                        }
                        break;
                    default:
                        Log.e("regist", result.toString());
                        RegistError error = new Gson().fromJson(result, RegistError.class);
                        if (error.getError().getRemote_ip() != null) {
                            ErrorResult = getString(R.string.fiveminutes);
                        } else {
                            if (error.getError().getBase() != null) {
                                ErrorResult = error.getError().getBase().get(0).toString();
                            } else {
                                ErrorResult = result.toString();
                            }
                        }
                        Message msg = new Message();
                        msg.arg1 = 0;
                        handler.sendMessage(msg);
                        break;
                }

            } catch (IOException e) {
                dismissLoadingDialog();
                showInfoDialog(e.getMessage());
            }
        }).start();
    }

    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            dismissLoadingDialog();
            if (msg.arg1 == 1) {
                reminderBrainkeyDailog = new ReminderBrainkeyDailog(getString(R.string.BackupDone), getString(R.string.RemoveBraink), CheckBrainkeyActivity.this);
                reminderBrainkeyDailog.show(getSupportFragmentManager(), "dialog");
            } else {
                showInfoDialog(ErrorResult);
            }

        }
    };

    /**
     * 绑定ETH接口
     * @param seerid
     * @param seername
     */

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
