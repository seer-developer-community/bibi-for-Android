package com.nyzc.gdm.currencyratio.accountPacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.Editable;
import android.text.InputFilter;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
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
import butterknife.ButterKnife;
import cy.agorise.graphenej.operations.TransferOperation;

public class TransferAccountActivity extends BaseActivity {

    @BindView(R.id.rela_add_account_addres)
    RelativeLayout rela_add_account_addres;
    @BindView(R.id.custom_title)
    CustomTitleBar custom_title;
    @BindView(R.id.tv_remind_money)
    TextView tv_remind_money;
    @BindView(R.id.edit_input_transfer_address_user)
    EditText edit_input_transfer_address_user;
    @BindView(R.id.edit_input_wallet_ammount)
    EditText edit_input_wallet_ammount;
    @BindView(R.id.tv_trans_wallet)
    TextView tv_trans_wallet;
    @BindView(R.id.tv_service_bee)
    TextView tv_service_bee;

    String user_name, user_ammount;
    String assetId;
    @BindView(R.id.tv_create_wallet_pwd_again)
    TextView tvCreateWalletPwdAgain;
    @BindView(R.id.ll_trans)
    LinearLayout llTrans;
    @BindView(R.id.view)
    View view;
    @BindView(R.id.tv_transfer_money)
    TextView tvTransferMoney;
    @BindView(R.id.rela_account_moenry)
    RelativeLayout relaAccountMoenry;
    @BindView(R.id.tv_trans_charge)
    TextView tvTransCharge;
    @BindView(R.id.tv_remind_remain)
    TextView tvRemindRemain;
    @BindView(R.id.tans_rela_wallet)
    RelativeLayout tansRelaWallet;
    @BindView(R.id.beizhu_tv)
    EditText beizhuTv;
    @BindView(R.id.shouxufei_tv)
    TextView shouxufeiTv;
    @BindView(R.id.beizhu_shouxufei)
    TextView beizhu_shouxufei;
    @BindView(R.id.tv_beizhu)
    TextView tv_beizhu;
    @BindView(R.id.inputSize)
    TextView inputSize;

    public static void start(Context context, String assetId) {
        Intent starter = new Intent(context, TransferAccountActivity.class);
        starter.putExtra("assetId", assetId);
        context.startActivity(starter);
    }

    account_object AccountObject = null;

    @Override
    public int getLayoutId() {
        return R.layout.activity_transfer_account;
    }

    /**
     * 转账
     */
    double assetFee;
    String inputContent;

    @Override
    protected void init() {
        assetId = getIntent().getStringExtra("assetId");
        tv_beizhu.setText(getString(R.string.beizhui));
        beizhu_shouxufei.setText(getString(R.string.beizhushouxufei));
        beizhuTv.setHint(getString(R.string.currencashinput));
        shouxufeiTv.setText(getString(R.string.currenshouxufei));
        switch (assetId) {
            case "1.3.0":
                assetFee = AssetTypeUtil.seerTrasFee;
                tv_service_bee.setText(assetFee + "SEER");
                tv_remind_money.setText(0 + "SEER");
                break;
            case "1.3.5":
                assetFee = AssetTypeUtil.usdtTransFee;
                tv_service_bee.setText(assetFee + "USDT");
                tv_remind_money.setText(0 + "USDT");
                break;
            case "1.3.2":
                assetFee = AssetTypeUtil.pfcTransFee;
                tv_service_bee.setText(assetFee + " PFC");
                tv_remind_money.setText(0 + "PFC");
                break;
        }
        custom_title.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
            @Override
            public void onLeftClick() {
                TranstionRecorderActivity.start(TransferAccountActivity.this, assetId);
                finish();
            }

            @Override
            public void onRightClick() {

            }
        });
        tv_trans_wallet.setOnClickListener(view -> {
            user_name = edit_input_transfer_address_user.getText().toString().trim();
            user_ammount = edit_input_wallet_ammount.getText().toString().trim();
            inputContent = beizhuTv.getText().toString().trim();
            if (user_name == null || user_name.equals("")) {
                Toast.makeText(TransferAccountActivity.this, getString(R.string.PleaseEnterUsername), Toast.LENGTH_SHORT).show();
                return;
            }
            if (user_ammount == null || user_ammount.equals("")) {
                Toast.makeText(TransferAccountActivity.this, getString(R.string.checkamount), Toast.LENGTH_SHORT).show();
                return;
            } else {
                if (Double.parseDouble(user_ammount) <= 0) {
                    Toast.makeText(TransferAccountActivity.this, getString(R.string.Transferamount), Toast.LENGTH_SHORT).show();
                    return;
                }
            }
            if (Double.parseDouble(user_ammount) > amountRemind || Double.parseDouble(user_ammount) + assetFee > amountRemind) {
                Toast.makeText(TransferAccountActivity.this, getString(R.string.BalanceIsNoEnough), Toast.LENGTH_SHORT).show();
                return;
            }
//            if (TextUtils.isEmpty(trim)) {
//                Toast.makeText(TransferAccountActivity.this, getString(R.string.currencashinput), Toast.LENGTH_SHORT).show();
//                return;
//            }

            showLoadingDialog();
            if (MyApp.localWalletUser != null) {
                new Thread(() -> {
                    account_object accountObject = null;
                    try {
                        accountObject = BitsharesWalletWraper.getInstance().get_account_object(user_name);
                    } catch (NetworkStatusException e) {
                        showInfoDialog(e.getMessage());
                    }
                    if (accountObject != null) {
                        if (accountObject.name.equals(MyApp.localWalletUser.getLocalName())) {
                            dismissLoadingDialog();
                            KeyBoardUtils.hideSoftKeyboard(TransferAccountActivity.this);
                            showInfoDialog(getString(R.string.cantoneself));
                            return;
                        }
                        signed_transaction signedTransaction = null;
                        try {
                            if (inputContent.length() > 0) {
                                signedTransaction = BitsharesWalletWraper.getInstance().transfer(MyApp.localWalletUser.getLocalName(), user_name, String.valueOf(user_ammount), assetId, inputContent);
                            } else {
                                signedTransaction = BitsharesWalletWraper.getInstance().transfer(MyApp.localWalletUser.getLocalName(), user_name, String.valueOf(user_ammount), assetId, "");
                            }
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

                    } else {
                        Message message = new Message();
                        message.arg1 = 2;
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
                    Toast.makeText(TransferAccountActivity.this, getString(R.string.Successfultransfer), Toast.LENGTH_SHORT).show();
                    KeyBoardUtils.hindSoftKeyBoard(TransferAccountActivity.this);
                    break;
                case 1:
                    dismissLoadingDialog();
                    Toast.makeText(TransferAccountActivity.this, "余额不足", Toast.LENGTH_SHORT).show();
//                    showInfoDialog(exception.getMessage());
                    break;
                case 2:
                    dismissLoadingDialog();
                    KeyBoardUtils.hideSoftKeyboard(TransferAccountActivity.this);
                    showInfoDialog(getString(R.string.user));
                    break;
            }
        }

    };

    String amount;

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            TranstionRecorderActivity.start(TransferAccountActivity.this, assetId);
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
//                        SEER
                        case "1.3.0":
//                            assetFee = AssetTypeUtil.SEERBEIZHU;
                            amount = NumerUtil.getSeerBigDecimal(String.valueOf(list.get(i).amount));
                            amountRemind = Double.parseDouble(amount);
                            tv_remind_money.setText(amount + "SEER");
                            MyApp.localWalletUser.setAmoutSeerMoney(amount);
                            break;
//                            USDT
                        case "1.3.5":
//                            assetFee = AssetTypeUtil.USDTBEIZHU;
                            amount = NumerUtil.getUsdtBigDecimal(String.valueOf(list.get(i).amount));
                            amountRemind = Double.parseDouble(amount);
                            tv_remind_money.setText(amount + "USDT");
                            MyApp.localWalletUser.setAmountUsdtMoney(amount);
                            break;
//                            PFC
                        case "1.3.2":
//                            assetFee = AssetTypeUtil.PFCBEIZHU;
                            amount = NumerUtil.getPFCBigDecimal(String.valueOf(list.get(i).amount));
                            amountRemind = Double.parseDouble(amount);
                            tv_remind_money.setText(amount + "PFC");
                            MyApp.localWalletUser.setAmountPFCMoney(amount);
                            break;
                    }
                }
            }
        } catch (NetworkStatusException e) {
            showInfoDialog(e.getMessage());
        }

    }

    Double amountRemind;

    @Override
    protected void onResume() {
        super.onResume();
        if (BitsharesWalletWraper.getInstance().build_connect() == 0) {
            getData();

        }
    }


}
