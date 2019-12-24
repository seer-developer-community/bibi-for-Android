package com.nyzc.gdm.currencyratio.accountPacakage;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.constraint.ConstraintLayout;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;


import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.OrderListBean;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.asset;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.Base.BaseFragment;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.AssetTypeUtil;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;

import java.math.BigDecimal;
import java.util.List;

import butterknife.BindView;

public class AccountFragment extends BaseFragment {

    TextView tv_seer_account_asset;
    TextView tv_usdt_account_asset;
    TextView tv_pfc_account_asset;
    ConstraintLayout asset_list_item_background;
    ConstraintLayout asset_usdt_list_item_background;
    ConstraintLayout asset_pfc_list_item_background;


    public static AccountFragment newInstance() {
        Bundle args = new Bundle();
        AccountFragment fragment = new AccountFragment();
        fragment.setArguments(args);
        return fragment;
    }

    account_object AccountObject = null;


    @Override
    protected int getLayoutId() {
        return R.layout.item_asset_list_layout;
    }

    @Override
    protected void initView(View view, Bundle savedInstanceState) {
        asset_list_item_background = view.findViewById(R.id.asset_list_item_background);
        tv_seer_account_asset = view.findViewById(R.id.tv_seer_account_asset);
        tv_usdt_account_asset = view.findViewById(R.id.tv_usdt_account_asset);
        tv_pfc_account_asset = view.findViewById(R.id.tv_pfc_account_asset);
        asset_pfc_list_item_background = view.findViewById(R.id.asset_pfc_list_item_background);
        asset_usdt_list_item_background = view.findViewById(R.id.asset_usdt_list_item_background);
        asset_list_item_background.setOnClickListener(view1 -> TranstionRecorderActivity.start(mActivity, AssetTypeUtil.seerAsset));
        asset_usdt_list_item_background.setOnClickListener(view12 -> TranstionRecorderActivity.start(mActivity, AssetTypeUtil.usdtAsset));
        asset_pfc_list_item_background.setOnClickListener(view13 -> TranstionRecorderActivity.start(mActivity, AssetTypeUtil.pfcAsset));
    }

    @Override
    public void onResume() {
        super.onResume();
        if (MyApp.localWalletUser != null) {
            getData();
        }

    }

    @Override
    public void onHiddenChanged(boolean hidden) {
        super.onHiddenChanged(hidden);
        if (!hidden) {

        }
    }

    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            tv_seer_account_asset.setText("0");
            tv_usdt_account_asset.setText("0");
            tv_pfc_account_asset.setText("0");
            for (int i = 0; i < list.size(); i++) {
                switch (list.get(i).asset_id.get_userId()) {
                    case "1.3.0":
                        amount = String.valueOf(list.get(i).amount);
                        String seerAmount = NumerUtil.getSeerBigDecimal(amount);
                        tv_seer_account_asset.setText(seerAmount);
                        MyApp.localWalletUser.setAmoutSeerMoney(seerAmount);
                        break;
                    case "1.3.5":
                        amount = String.valueOf(list.get(i).amount);
                        String usdtAmount = NumerUtil.getUsdtBigDecimal(amount);
                        tv_usdt_account_asset.setText(usdtAmount);
                        MyApp.localWalletUser.setAmountUsdtMoney(usdtAmount);
                        break;
                    case "1.3.2":
                        amount = String.valueOf(list.get(i).amount);
                        String pfcAmount = NumerUtil.getPFCBigDecimal(amount);
                        tv_pfc_account_asset.setText(pfcAmount);
                        MyApp.localWalletUser.setAmountPFCMoney(pfcAmount);
                        break;

                }
            }

        }
    };

    /**
     * 获取账户余额
     */
    String amount = null;
    List<asset> list;

    private void getData() {
        new Thread(() -> {
            try {
                AccountObject = BitsharesWalletWraper.getInstance().get_account_object(MyApp.localWalletUser.getLocalName());
                list = BitsharesWalletWraper.getInstance().list_account_balance(AccountObject.id, true);
                handler.sendMessage(new Message());
            } catch (NetworkStatusException e) {
            }
        }).start();

    }
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == 2) {
            getData();
        }
    }

    @Override
    protected void initData() {
        getData();
    }



    @Override
    public void setData(List<List<Object>> list) {

    }
}
