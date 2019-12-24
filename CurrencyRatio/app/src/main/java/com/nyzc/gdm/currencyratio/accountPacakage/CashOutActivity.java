package com.nyzc.gdm.currencyratio.accountPacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Message;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.asset;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.signed_transaction;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.AssetTypeUtil;
import com.nyzc.gdm.currencyratio.Utils.KeyBoardUtils;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;

import java.util.List;

import butterknife.BindView;

public class CashOutActivity extends BaseActivity {


    @BindView(R.id.custom_title)
    CustomTitleBar customTitleBar;
    @BindView(R.id.edit_input_cash_address)
    EditText ediCashAddress;
    @BindView(R.id.edit_input_cash_ammount)
    EditText ediCashAmount;
    @BindView(R.id.tv_service_bee)
    TextView tvServiceBee;
    @BindView(R.id.tv_remind_money)
    TextView tvRemindMoney;
    @BindView(R.id.tv_cash)
    TextView tvCash;
    String assetId;
    double assetFee;
    @BindView(R.id.tv_expect_arrived)
    TextView tv_expect_arrived;
    public static void start(Context context, String assetId) {
        Intent starter = new Intent(context, CashOutActivity.class);
        starter.putExtra("assetId", assetId);
        context.startActivity(starter);
    }

    @Override
    public int getLayoutId() {
        return R.layout.activity_cash_out;
    }

    String assetEth;
    String gate;
    Double feeTotal;
    @Override
    protected void init() {
        customTitleBar.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
            @Override
            public void onLeftClick() {
                TranstionRecorderActivity.start(CashOutActivity.this, assetId);
                finish();
            }

            @Override
            public void onRightClick() {

            }
        });
        assetId = getIntent().getStringExtra("assetId");
        switch (assetId) {
//            seer
            case "1.3.0":
                gate="gateway";
                assetEth = AssetTypeUtil.seerEth;
                assetFee = AssetTypeUtil.seerAssetcashfee;
                tvServiceBee.setText(assetFee + "SEER");
                tvRemindMoney.setText(0 + "SEER");
                break;
//                usdt
            case "1.3.5":
                gate="usdt-gateway";
                assetEth = AssetTypeUtil.usdtEth;
                assetFee = AssetTypeUtil.usdtAssetcashfee;
                tvServiceBee.setText(assetFee + "USDT");
                tvRemindMoney.setText(0 + "USDT");
                break;
//                pfc
            case "1.3.2":
                gate="gateway";
                assetEth = AssetTypeUtil.pfcEth;
                assetFee = AssetTypeUtil.pfcAssetcashfee;
                tvServiceBee.setText(assetFee + " PFC");
                tvRemindMoney.setText(0 + "PFC");
                break;
        }
        ediCashAmount.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void afterTextChanged(Editable editable) {
                String expectAmount = ediCashAmount.getText().toString();
                if(expectAmount!=null&&!expectAmount.equals("")){
                    switch (assetId) {
//                        seer
                        case "1.3.0":
                            feeTotal=AssetTypeUtil.seerCashFee+AssetTypeUtil.seerAssetcashfee;
                            if (Double.parseDouble(expectAmount) > feeTotal) {
                                expectAmount = NumerUtil.getExcepetAmount(expectAmount, String.valueOf(feeTotal));
                                tv_expect_arrived.setText("预计到账" + expectAmount + "seer");
                            } else {
                                tv_expect_arrived.setText("预计到账0 Seer");
                            }

                            break;
//                            pfc
                        case "1.3.2":
                            feeTotal=AssetTypeUtil.pfcCashFee+AssetTypeUtil.pfcAssetcashfee;
                            if (Double.parseDouble(expectAmount) > feeTotal) {
                                expectAmount = NumerUtil.getExcepetAmount(expectAmount, String.valueOf(feeTotal));
                                tv_expect_arrived.setText("预计到账" + expectAmount + "pfc");
                            } else {
                                tv_expect_arrived.setText("预计到账0 Pfc");
                            }
                            break;
//                            usdt
                        case "1.3.5":
                            feeTotal=AssetTypeUtil.usdtCashFee+AssetTypeUtil.usdtAssetcashfee;
                            if (Double.parseDouble(expectAmount) > feeTotal) {
                                expectAmount = NumerUtil.getExcepetAmount(expectAmount, String.valueOf(feeTotal));
                                tv_expect_arrived.setText("预计到账" + expectAmount + "usdt");
                            } else {
                                tv_expect_arrived.setText("预计到账0 Usdt");
                            }
                            break;
                    }
                }
            }
        });
//        提现的点击事件
        tvCash.setOnClickListener(view -> {
            amountCash = ediCashAmount.getText().toString().trim();
            addressCash = ediCashAddress.getText().toString().trim();
            if (TextUtils.isEmpty(addressCash)) {
                Toast.makeText(CashOutActivity.this, getString(R.string.PleaseEnterCashAddress), Toast.LENGTH_SHORT).show();
                return;
            }
            if (TextUtils.isEmpty(amountCash)) {
                Toast.makeText(CashOutActivity.this, getString(R.string.PleaseEnterCashAmount), Toast.LENGTH_SHORT).show();
                return;
            }
            if(Double.parseDouble(amountCash)<feeTotal){
                Toast.makeText(CashOutActivity.this, "提现金额需大于手续费", Toast.LENGTH_SHORT).show();
                return;
            }
            if ( Double.parseDouble(amountCash) + feeTotal > amountRemind) {
                Toast.makeText(CashOutActivity.this, getString(R.string.BalanceIsNoEnough), Toast.LENGTH_SHORT).show();
                return;
            }
            showLoadingDialog();
            if (MyApp.localWalletUser != null) {
                new Thread(() -> {
                    signed_transaction signedTransaction = null;
                    try {
                        signedTransaction = BitsharesWalletWraper.getInstance().transfer(MyApp.localWalletUser.getLocalName(), gate, String.valueOf(amountCash), assetId, assetEth + addressCash);
                        if (signedTransaction != null) {
                            Message message = new Message();
                            message.arg1 = 0;
                            handler.sendMessage(message);
                        }
                    } catch (NetworkStatusException e) {
                        exception = e;
                        Message message = new Message();
                        message.arg1 = 1;
                        handler.sendMessage(message);
                    }

                }).start();
            }
        });
    }
    NetworkStatusException exception;
    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.arg1) {
                case 0:
                    getData();
                    dismissLoadingDialog();
                    Toast.makeText(CashOutActivity.this, getString(R.string.Successfultransfer), Toast.LENGTH_SHORT).show();
                    KeyBoardUtils.hindSoftKeyBoard(CashOutActivity.this);
                    break;
                case 1:
                    dismissLoadingDialog();
                    showInfoDialog(exception.getMessage());
                    break;

            }
        }
    };
    String addressCash;
    String amountCash;
    account_object AccountObject = null;
    String amount;
    Double amountRemind;

    @Override
    protected void onResume() {
        super.onResume();
        if (BitsharesWalletWraper.getInstance().build_connect() == 0) {
            getData();

        }
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            TranstionRecorderActivity.start(CashOutActivity.this, assetId);
            finish();
            return false;
        }
        return super.onKeyDown(keyCode, event);
    }
    private void getData() {
        try {
            AccountObject = BitsharesWalletWraper.getInstance().get_account_object(MyApp.localWalletUser.getLocalName());
            List<asset> list = BitsharesWalletWraper.getInstance().list_account_balance(AccountObject.id, true);
            for (int i = 0; i < list.size(); i++) {
                if (list.get(i).asset_id.get_userId().equals(assetId)) {
                    switch (assetId) {
                        case "1.3.0":
                            amount = NumerUtil.getSeerBigDecimal(String.valueOf(list.get(i).amount));
                            amountRemind = Double.parseDouble(NumerUtil.getSeerBigDecimal(String.valueOf(list.get(i).amount)));
                            tvRemindMoney.setText(amount + "SEER");
                            MyApp.localWalletUser.setAmoutSeerMoney(amount);
                            break;
                        case "1.3.5":
                            amount = NumerUtil.getUsdtBigDecimal(String.valueOf(list.get(i).amount));
                            amountRemind = Double.parseDouble(amount);
                            tvRemindMoney.setText(amount + "USDT");
                            MyApp.localWalletUser.setAmountUsdtMoney(amount);
                            break;
                        case "1.3.2":
                            amount = NumerUtil.getPFCBigDecimal(String.valueOf(list.get(i).amount));
                            amountRemind = Double.parseDouble(amount);
                            tvRemindMoney.setText(amount + "PFC");
                            MyApp.localWalletUser.setAmountPFCMoney(amount);
                            break;
                    }
                }
            }
        } catch (NetworkStatusException e) {
            showInfoDialog(e.getMessage());
        }

    }
}
