package com.nyzc.gdm.currencyratio.View;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.constraint.ConstraintLayout;
import android.support.v4.app.DialogFragment;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.RoomObject;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.asset;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.AssetTypeUtil;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;
import com.nyzc.gdm.currencyratio.accountPacakage.RechargeActivity;

import java.math.BigDecimal;
import java.util.List;

import butterknife.BindView;


public class RemindInputForcastDialog extends DialogFragment {

    //点击发表，内容不为空时的回调
    public SendBackListener sendBackListener;

    public interface SendBackListener {
        void sendBack(String inputText);
    }

    private String texthint;
    private Dialog dialog;
    private EditText inputDlg, edi_input_forcast_money;
    private TextView tv_service_bee;
    private TextView tv_pwd_service_bee;
    private ImageView iv_back, iv_back_forcast_amount, iv_back_pvd;
    private TextView tv_pwd_input_remind, tv_pwd_remind_money, tv_foracat_limit, tv_how_get_seer, tv_pvd_buy, tv_pvd_sell, tv_pay_seer_money;
    TextView user_select;
    private ConstraintLayout constrain_check_forcast_amount, constrain_check_brainkey_pwd;
    String amount;
    String mix, max;
    RoomObject roomBean;
    RelativeLayout rela_pvd;
    int positionIndex;
    String assetType;

    public RemindInputForcastDialog() {
    }


    @SuppressLint("ValidFragment")
    public RemindInputForcastDialog(int position, RoomObject roomBean, SendBackListener sendBackListener) {//提示文字
        this.sendBackListener = sendBackListener;
        this.roomBean = roomBean;
        this.assetType = roomBean.getOption().getAccept_asset();
        this.positionIndex = position;
        this.texthint = roomBean.getRunning_option().getSelection_description().get(positionIndex) + "";
        switch (assetType) {
            case "1.3.0":
                this.mix = NumerUtil.getSeerBigDecimal(String.valueOf(roomBean.getOption().getMinimum()));
                this.max = NumerUtil.getSeerBigDecimal(String.valueOf(roomBean.getOption().getMaximum()));
                break;
            case "1.3.2":
                this.mix = NumerUtil.getPFCBigDecimal(String.valueOf(roomBean.getOption().getMinimum()));
                this.max = NumerUtil.getPFCBigDecimal(String.valueOf(roomBean.getOption().getMaximum()));
                break;
            case "1.3.5":
                this.mix = NumerUtil.getUsdtBigDecimal(String.valueOf(roomBean.getOption().getMinimum()));
                this.max = NumerUtil.getUsdtBigDecimal(String.valueOf(roomBean.getOption().getMaximum()));
                break;
        }
        if (assetType.equals(AssetTypeUtil.seerAsset)) {

        } else {

        }
        getData();
    }

    account_object AccountObject = null;


    double beforeBuy = 0.0;
    double selectBuy = 0.0;
    double money = 0.0;
    String pay;
    boolean isSell = false;
    int num = 0;

    /**
     * 房间投注需要注意账户余额+手续费是否>=投注金额
     *
     * @param savedInstanceState
     * @return
     */
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        // 使用不带Theme的构造器, 获得的dialog边框距离屏幕仍有几毫米的缝隙。
        dialog = new Dialog(getActivity(), R.style.BottomDialog);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE); // 设置Content前设定
//        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);
        View contentview = View.inflate(getActivity(), R.layout.forcast_dialog_layout, null);
        dialog.setContentView(contentview);
        dialog.setCanceledOnTouchOutside(false); // 外部点击取消
        // 设置宽度为屏宽, 靠近屏幕底部。
        Window window = dialog.getWindow();
        WindowManager.LayoutParams lp = window.getAttributes();
        lp.gravity = Gravity.BOTTOM; // 紧贴底部
        lp.alpha = 1;
        lp.dimAmount = 0.5f;
        lp.width = WindowManager.LayoutParams.MATCH_PARENT; // 宽度持平
        window.setAttributes(lp);
        window.addFlags(WindowManager.LayoutParams.FLAG_DIM_BEHIND);
        inputDlg = contentview.findViewById(R.id.edi_input_brainkey_pwd);
        final TextView tv_cofirm_forcast_amount = contentview.findViewById(R.id.tv_cofirm_forcast_amount);
        final TextView tv_send = contentview.findViewById(R.id.tv_cofirm_brainkey);
        tv_service_bee = contentview.findViewById(R.id.tv_service_bee);
        tv_pwd_service_bee = contentview.findViewById(R.id.tv_pwd_service_bee);
        user_select = contentview.findViewById(R.id.user_select);
        iv_back = contentview.findViewById(R.id.iv_back);
        rela_pvd = contentview.findViewById(R.id.rela_pvd);
        tv_pvd_buy = contentview.findViewById(R.id.tv_pvd_buy);
        tv_pvd_sell = contentview.findViewById(R.id.tv_pvd_sell);
        iv_back_pvd = contentview.findViewById(R.id.iv_back_pvd);
        tv_foracat_limit = contentview.findViewById(R.id.tv_foracat_limit);
        tv_pay_seer_money = contentview.findViewById(R.id.tv_pay_seer_money);
        tv_pwd_remind_money = contentview.findViewById(R.id.tv_pwd_remind_money);
        iv_back_forcast_amount = contentview.findViewById(R.id.iv_back_forcast_amount);
        edi_input_forcast_money = contentview.findViewById(R.id.edi_input_forcast_money);
        constrain_check_forcast_amount = contentview.findViewById(R.id.constrain_check_forcast_amount);
        constrain_check_brainkey_pwd = contentview.findViewById(R.id.constrain_check_brainkey_pwd);
        tv_pwd_input_remind = contentview.findViewById(R.id.tv_pwd_input_remind);
        tv_how_get_seer = contentview.findViewById(R.id.tv_how_get_seer);
        user_select.setText(texthint);
        switch (assetType) {
            case "1.3.0":
                tv_pwd_service_bee.setText(AssetTypeUtil.seerFee + " SEER");
                tv_foracat_limit.setText(getActivity().getString(R.string.TheRangofPredictionAmount) + mix + "-" + max + "SEER");
                if (MyApp.localWalletUser.getAmoutSeerMoney() != null) {
                    tv_pwd_remind_money.setText(MyApp.localWalletUser.getAmoutSeerMoney() + "SEER");
                } else {
                    tv_pwd_remind_money.setText(0 + "SEER");
                }
                break;
            case "1.3.5":
                tv_pwd_service_bee.setText(AssetTypeUtil.usdtFee + " USDT");
                tv_foracat_limit.setText(getActivity().getString(R.string.TheRangofPredictionAmount) + mix + "-" + max + "USDT");
                if (MyApp.localWalletUser.getAmountUsdtMoney() != null) {
                    tv_pwd_remind_money.setText(MyApp.localWalletUser.getAmountUsdtMoney() + "USDT");
                } else {
                    tv_pwd_remind_money.setText(0 + "USDT");
                }

                break;
            case "1.3.2":
                tv_pwd_service_bee.setText(AssetTypeUtil.pfcFee + " PFC");
                tv_foracat_limit.setText(getActivity().getString(R.string.TheRangofPredictionAmount) + mix + "-" + max + "PFC");
                if (MyApp.localWalletUser.getAmountPFCMoney() != null) {
                    tv_pwd_remind_money.setText(MyApp.localWalletUser.getAmountPFCMoney() + "PFC");
                } else {
                    tv_pwd_remind_money.setText(0 + "PFC");
                }

                break;
        }
        if (roomBean.getRoom_type() == 0) {
            iv_back_pvd.setVisibility(View.VISIBLE);
            iv_back_forcast_amount.setVisibility(View.INVISIBLE);
            rela_pvd.setVisibility(View.VISIBLE);
            edi_input_forcast_money.setHint(R.string.PleaseEnterAnumber);
        } else {
            iv_back_pvd.setVisibility(View.INVISIBLE);
            iv_back_forcast_amount.setVisibility(View.VISIBLE);
            edi_input_forcast_money.setHint(R.string.PleaseEnterAnumber);
            rela_pvd.setVisibility(View.GONE);
        }
        edi_input_forcast_money.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
            }

            @Override
            public void afterTextChanged(Editable editable) {
                try {
                    if (roomBean.getRoom_type() == 0) {
                        if (edi_input_forcast_money.getText().toString() != null && !edi_input_forcast_money.getText().toString().equals("")) {
                            if (edi_input_forcast_money.getText().toString().contains(".")) {
                            } else {
                                num = Integer.parseInt(edi_input_forcast_money.getText().toString());
                            }
                        }
                        /**
                         * 计算pvd玩法 购买和卖出份数大概需要多少seer.
                         */
                        if (roomBean.getRunning_option().getLmsr_running() != null) {
                            for (int g = 0; g < roomBean.getRunning_option().getLmsr_running().getItems().size(); g++) {
                                beforeBuy += Math.exp(roomBean.getRunning_option().getLmsr_running().getItems().get(g) / roomBean.getRunning_option().getLmsr().getL());
                            }
                            switch (assetType) {
                                case "1.3.5":
                                    getPVd(NumerUtil.commenUsdtFee);
                                    break;
                                default:
                                    getPVd(NumerUtil.commenSeerFee);
                                    break;
                            }

                            tv_pay_seer_money.setVisibility(View.VISIBLE);
                            if (Double.parseDouble(pay) < 0) {
                                pay = bigDecimal.toPlainString().replace("-", "");
                            }
                            amount = pay;
                            if (isSell) {
                                String sell = null;
                                switch (assetType) {
                                    case "1.3.0":
                                        sell = getActivity().getString(R.string.sellSeer);
                                        break;
                                    case "1.3.5":
                                        sell = getActivity().getString(R.string.sellUSdt);
                                        break;
                                    case "1.3.2":
                                        sell = getActivity().getString(R.string.sellPFC);
                                        break;
                                }
                                String sell1 = sell.replace("num", num + "");
                                String sell2 = sell1.replace("amount", amount + "");
//                                tv_pay_seer_money.setText("卖出" + num + "份" + "大概收入" + amount + "SEER");
                                tv_pay_seer_money.setText(sell2);
                            } else {
                                String buy = null;
                                switch (assetType) {
                                    case "1.3.0":
                                        buy = getActivity().getString(R.string.buySeer);
                                        break;
                                    case "1.3.5":
                                        buy = getActivity().getString(R.string.buyUSDT);
                                        break;
                                    case "1.3.2":
                                        buy = getActivity().getString(R.string.buyPFC);
                                        break;
                                }
                                String buy1 = buy.replace("num", num + "");
                                String buy2 = buy1.replace("amount", amount + "");
                                tv_pay_seer_money.setText(buy2);
                            }
                        }
                    } else {
                        tv_pay_seer_money.setVisibility(View.GONE);
                    }
                    beforeBuy = 0.0;
                    selectBuy = 0.0;
                    pay = "";
                    money = 0.0;
                } catch (Exception e) {
                    Log.e("Exception", e.getMessage());
                }

            }
        });
        tv_how_get_seer.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(MyApp.context, RechargeActivity.class));
            }
        });
        iv_back_pvd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
            }
        });
        tv_pvd_buy.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                isSell = false;
                edi_input_forcast_money.setText("");
                tv_pay_seer_money.setText(" ");
                tv_pvd_buy.setTextColor(MyApp.context.getResources().getColor(R.color.white));
                tv_pvd_buy.setBackground(MyApp.context.getResources().getDrawable(R.drawable.shape_pvd_buy));
                tv_pvd_sell.setBackground(null);
                tv_pvd_sell.setTextColor(MyApp.context.getResources().getColor(R.color.tab_tv_color));
            }
        });
        tv_pvd_sell.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                isSell = true;
                edi_input_forcast_money.setText("");
                tv_pay_seer_money.setText(" ");
                tv_pvd_buy.setTextColor(MyApp.context.getResources().getColor(R.color.tab_tv_color));
                tv_pvd_buy.setBackground(null);
                tv_pvd_sell.setBackground(MyApp.context.getResources().getDrawable(R.drawable.shape_pvd_buy));
                tv_pvd_sell.setTextColor(MyApp.context.getResources().getColor(R.color.white));
            }
        });

        tv_send.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    if (TextUtils.isEmpty(inputDlg.getText().toString())) {
                        Toast.makeText(getActivity(), getActivity().getString(R.string.inputContentEmpty), Toast.LENGTH_LONG).show();
                        return;
                    } else {
                        if (MyApp.localWalletUser.getLocalPwd().equals(inputDlg.getText().toString())) {
                            if (roomBean.getRoom_type() != 0) {
                                sendBackListener.sendBack(amount);
                            } else {
                                if (isSell) {
                                    sendBackListener.sendBack(String.valueOf(-num));
                                } else {
                                    sendBackListener.sendBack(String.valueOf(num));
                                }
                            }
                        } else {
                            tv_pwd_input_remind.setText(getActivity().getString(R.string.inputContentError));
                            tv_pwd_input_remind.setVisibility(View.VISIBLE);
                        }
                    }
                } catch (Exception e) {
                    Log.e("Excepetion", e.getMessage());
                }

            }
        });
        tv_cofirm_forcast_amount.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                try {
                    if (TextUtils.isEmpty(edi_input_forcast_money.getText().toString())) {
                        Toast.makeText(getActivity(), getActivity().getString(R.string.inputContentEmpty), Toast.LENGTH_LONG).show();
                        return;
                    } else {
                        if (roomBean.getRoom_type() != 0) {
                            amount = edi_input_forcast_money.getText().toString();
                            if (Double.parseDouble(amount) >= Double.parseDouble(mix) && Double.parseDouble(amount) <= Double.parseDouble(max)) {
                                switch (assetType) {
                                    case "1.3.0":
                                        if (MyApp.localWalletUser.getAmoutSeerMoney() != null) {
                                            if (Double.parseDouble(amount) + AssetTypeUtil.seerFee > Double.parseDouble(MyApp.localWalletUser.getAmoutSeerMoney())) {
                                                getNotMoney(1);
                                                return;
                                            }
                                        } else {
                                            getNotMoney(1);
                                            return;
                                        }

                                        break;
                                    case "1.3.5":
                                        if (MyApp.localWalletUser.getAmountUsdtMoney() != null) {
                                            if (Double.parseDouble(amount) + AssetTypeUtil.usdtFee > Double.parseDouble(MyApp.localWalletUser.getAmountUsdtMoney())) {
                                                getNotMoney(1);
                                                return;
                                            }
                                        } else {
                                            getNotMoney(1);
                                            return;
                                        }
                                        break;
                                    case "1.3.2":
                                        //0.00665
                                        if (MyApp.localWalletUser.getAmountPFCMoney() != null) {
                                            if (Double.parseDouble(amount) + AssetTypeUtil.pfcFee > Double.parseDouble(MyApp.localWalletUser.getAmountPFCMoney())) {
                                                getNotMoney(1);
                                                return;
                                            }
                                        } else {
                                            getNotMoney(1);
                                            return;
                                        }
                                        break;
                                }
                                getforcast();
                            } else {
                                getshowlimit();
                            }
                        } else {
                            if (num >= Double.parseDouble(mix) && num <= Double.parseDouble(max)) {
                                if (isSell == false) {
                                    switch (assetType) {
                                        case "1.3.0":
                                            if (MyApp.localWalletUser.getAmountUsdtMoney() != null) {
                                                if (Double.parseDouble(amount) + AssetTypeUtil.seerFee > Double.parseDouble(MyApp.localWalletUser.getAmoutSeerMoney())) {
                                                    getNotMoney(0);
                                                    return;
                                                }
                                            } else {
                                                getNotMoney(0);
                                                return;
                                            }

                                            break;
                                        case "1.3.5":
                                            if (MyApp.localWalletUser.getAmountUsdtMoney() != null) {
                                                if (Double.parseDouble(amount) + AssetTypeUtil.usdtFee > Double.parseDouble(MyApp.localWalletUser.getAmountUsdtMoney())) {
                                                    getNotMoney(0);
                                                    return;
                                                }
                                            } else {
                                                getNotMoney(0);
                                                return;
                                            }

                                            break;
                                        case "1.3.2":
                                            if (MyApp.localWalletUser.getAmountPFCMoney() != null) {
                                                if (Double.parseDouble(amount) + AssetTypeUtil.pfcFee > Double.parseDouble(MyApp.localWalletUser.getAmountPFCMoney())) {
                                                    getNotMoney(0);
                                                    return;
                                                }
                                            } else {
                                                getNotMoney(0);
                                                return;
                                            }

                                            break;
                                    }

                                }
                                getforcast();
                            } else {
                                getshowlimit();
                            }
                        }
                    }
                } catch (Exception e) {
                    Log.e("Exception", e.getMessage());
                }
            }
        });
        iv_back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
            }
        });
        iv_back_forcast_amount.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
            }
        });

        final Handler hanler = new Handler();
        dialog.setOnDismissListener(new DialogInterface.OnDismissListener() {
            public InputMethodManager mInputMethodManager;

            @Override
            public void onDismiss(DialogInterface dialog) {
                hanler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        hideSoftkeyboard();
                    }
                }, 200);

            }
        });
        return dialog;
    }

    private void getNotMoney(int type) {
        tv_service_bee.setText(getActivity().getString(R.string.BalanceIsNoEnough));
        tv_service_bee.setTextColor(MyApp.context.getResources().getColor(R.color.pwd_weak));
        if (type != 0) {
            tv_pwd_service_bee.setVisibility(View.INVISIBLE);
        }

    }

    BigDecimal bigDecimal;

    private void getPVd(String assetNum) {
        for (int j = 0; j < roomBean.getRunning_option().getLmsr_running().getItems().size(); j++) {
            if (j == positionIndex) {
                if (isSell) {
                    selectBuy += Math.exp(roomBean.getRunning_option().getLmsr_running().getItems().get(j) / roomBean.getRunning_option().getLmsr().getL() + (-num) * Integer.getInteger(assetNum) / roomBean.getRunning_option().getLmsr().getL());
                } else {
                    selectBuy += Math.exp(roomBean.getRunning_option().getLmsr_running().getItems().get(j) / roomBean.getRunning_option().getLmsr().getL() + (num) * Integer.getInteger(assetNum) / roomBean.getRunning_option().getLmsr().getL());
                }
            } else {
                selectBuy += Math.exp(roomBean.getRunning_option().getLmsr_running().getItems().get(j) / roomBean.getRunning_option().getLmsr().getL());
            }
        }
        money = (Math.log(selectBuy) - Math.log(beforeBuy)) * roomBean.getRunning_option().getLmsr().getL();
        bigDecimal = new BigDecimal(money).divide(new BigDecimal(assetNum)).stripTrailingZeros().setScale(5, BigDecimal.ROUND_DOWN);
        pay = bigDecimal.toPlainString();
    }

    private void getforcast() {
        tv_service_bee.setText(MyApp.context.getString(R.string.TransactionFee));
        tv_service_bee.setTextColor(MyApp.context.getResources().getColor(R.color.divider));
        tv_pwd_service_bee.setVisibility(View.VISIBLE);
        tv_service_bee.setVisibility(View.VISIBLE);
        constrain_check_forcast_amount.setVisibility(View.GONE);
        constrain_check_brainkey_pwd.setVisibility(View.VISIBLE);
        inputDlg.setFocusable(true);
        inputDlg.setFocusableInTouchMode(true);
        inputDlg.requestFocus();
        inputDlg.setCursorVisible(true);
    }

    private void getshowlimit() {
        tv_service_bee.setText(getActivity().getString(R.string.limitprediction));
        tv_service_bee.setTextColor(MyApp.context.getResources().getColor(R.color.pwd_weak));
        tv_pwd_service_bee.setVisibility(View.GONE);
        tv_service_bee.setVisibility(View.VISIBLE);
    }

    private void getData() {
        if (MyApp.localWalletUser != null) {
            try {
                String amountAsset;
                AccountObject = BitsharesWalletWraper.getInstance().get_account_object(MyApp.localWalletUser.getLocalName());
                List<asset> list = BitsharesWalletWraper.getInstance().list_account_balance(AccountObject.id, true);
                for (int i = 0; i < list.size(); i++) {
                    if (list.get(i).asset_id.get_userId().equals(assetType)) {
                        switch (assetType) {
                            case "1.3.0":
                                amountAsset = NumerUtil.getSeerBigDecimal(String.valueOf(list.get(i).amount));
                                MyApp.localWalletUser.setAmoutSeerMoney(amountAsset);
                                break;
                            case "1.3.5":
                                amountAsset = NumerUtil.getUsdtBigDecimal(String.valueOf(list.get(i).amount));
                                MyApp.localWalletUser.setAmountUsdtMoney(amountAsset);
                                break;
                            case "1.3.2":
                                amountAsset = NumerUtil.getSeerBigDecimal(String.valueOf(list.get(i).amount));
                                MyApp.localWalletUser.setAmountPFCMoney(amountAsset);
                                break;
                        }

                    }
                }

            } catch (NetworkStatusException e) {
                e.printStackTrace();
            }
        }
    }


    public void hideSoftkeyboard() {
        try {
            ((InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE))
                    .hideSoftInputFromWindow(getActivity().getCurrentFocus().getWindowToken(),
                            InputMethodManager.HIDE_NOT_ALWAYS);
        } catch (NullPointerException e) {
            e.getMessage();
        }
    }


}
