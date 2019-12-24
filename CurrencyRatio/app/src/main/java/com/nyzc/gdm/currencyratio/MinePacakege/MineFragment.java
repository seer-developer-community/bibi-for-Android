package com.nyzc.gdm.currencyratio.MinePacakege;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.constraint.ConstraintLayout;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.Gson;
import com.neovisionaries.ws.client.WebSocket;
import com.neovisionaries.ws.client.WebSocketException;
import com.nyzc.gdm.currencyratio.Base.AppLocalWalletUser;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Base.BaseFragment;
import com.nyzc.gdm.currencyratio.Bean.EthAccount;
import com.nyzc.gdm.currencyratio.Bean.FileSave;
import com.nyzc.gdm.currencyratio.Bean.OrderListBean;
import com.nyzc.gdm.currencyratio.Bean.Result;
import com.nyzc.gdm.currencyratio.Bean.ResultBean;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.asset;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.uipacakage.Callus;
import com.nyzc.gdm.currencyratio.uipacakage.ImportWalletActivity;
import com.nyzc.gdm.currencyratio.uipacakage.SetActivity;
import com.nyzc.gdm.currencyratio.uipacakage.StartMainActvity;
import com.nyzc.gdm.currencyratio.uipacakage.WalletManagerActivity;
import com.nyzc.gdm.currencyratio.Utils.HttpUrl;
import com.zhy.http.okhttp.OkHttpUtils;
import com.zhy.http.okhttp.callback.StringCallback;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import butterknife.BindView;
import cy.agorise.graphenej.api.GetAccounts;
import cy.agorise.graphenej.interfaces.ResultJson;
import de.hdodenhof.circleimageview.CircleImageView;
import okhttp3.Call;

public class MineFragment extends BaseFragment implements View.OnClickListener {


    @BindView(R.id.tv_mine)
    TextView tvMine;
    @BindView(R.id.tv_create_wallet)
    TextView tvCreateWallet;
    @BindView(R.id.constrain_main_mine)
    ConstraintLayout constrainMainMine;
    @BindView(R.id.tv_wallet_manager)
    TextView tvWalletManager;
    @BindView(R.id.tv_my_collect)
    TextView tvMyCollect;
    @BindView(R.id.tv_my_invite)
    TextView tvMyInvite;
    @BindView(R.id.tv_call_us)
    TextView tvCallUs;
    @BindView(R.id.tv_my_set)
    TextView tvMySet;
    @BindView(R.id.circle_iv_avatar)
    CircleImageView circle_iv_avatar;


    public static MineFragment newInstance() {
        Bundle args = new Bundle();
        MineFragment fragment = new MineFragment();
        fragment.setArguments(args);
        return fragment;
    }


    @Override
    protected int getLayoutId() {
        return R.layout.mine_fragment_layout;
    }

    /**
     * 更新用户名
     */
    @Override
    public void onResume() {
        super.onResume();
        try {
            MyApp.localWalletUser = (AppLocalWalletUser) FileSave.read(mActivity, "localwallet");
            if (MyApp.localWalletUser != null) {
                tvWalletManager.setVisibility(View.VISIBLE);
                circle_iv_avatar.setEnabled(false);
                tvCreateWallet.setText(MyApp.localWalletUser.getLocalName());
            } else {
                circle_iv_avatar.setEnabled(true);
                tvCreateWallet.setText(getString(R.string.CreateWallet));
                tvWalletManager.setVisibility(View.GONE);
            }
        } catch (Exception e) {
            showInfoDialog(e.getMessage());
        }
    }


    @Override
    protected void initView(View view, Bundle savedInstanceState) {
        circle_iv_avatar.setOnClickListener(this);
        tvWalletManager.setOnClickListener(this);
        tvMyCollect.setOnClickListener(this);
        tvMyInvite.setOnClickListener(this);
        tvCallUs.setOnClickListener(this);
        tvMySet.setOnClickListener(this);
        MyApp.localWalletUser = (AppLocalWalletUser) FileSave.read(mActivity, "localwallet");
        if (MyApp.localWalletUser != null) {
            tvCreateWallet.setText(MyApp.localWalletUser.getLocalName());
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
    }

    @Override
    protected void initData() {

    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.circle_iv_avatar:
                StartMainActvity.start(mActivity);
                break;
            case R.id.tv_wallet_manager:
                WalletManagerActivity.start(mActivity);
                break;
            case R.id.tv_my_collect:
//                BindEth();
                break;
            case R.id.tv_my_invite:
//                QueryEthAddress();
                break;
            case R.id.tv_call_us:
                startActivity(new Intent(mActivity, Callus.class));
                break;
            case R.id.tv_my_set:
                SetActivity.start(mActivity);
                break;
        }
    }




    @Override
    public void setData(List<List<Object>> list) {

    }
}
