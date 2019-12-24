package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.gson.Gson;
import com.neovisionaries.ws.client.WebSocket;
import com.neovisionaries.ws.client.WebSocketException;
import com.neovisionaries.ws.client.WebSocketFactory;
import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.Bean.ResultBean;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.HttpUrl;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.net.ssl.SSLContext;

import butterknife.BindView;
import butterknife.ButterKnife;
import cy.agorise.graphenej.api.GetAccounts;
import cy.agorise.graphenej.interfaces.ResultJson;
import cy.agorise.graphenej.interfaces.WitnessResponseListener;
import cy.agorise.graphenej.models.BaseResponse;
import cy.agorise.graphenej.models.WitnessResponse;
import cy.agorise.graphenej.test.NaiveSSLContext;

public class StartMainActvity extends BaseActivity {


    @BindView(R.id.custom_title)
    CustomTitleBar customTitle;
    @BindView(R.id.iv_logo)
    ImageView ivLogo;
    @BindView(R.id.tv_block_chain)
    TextView tvBlockChain;
    @BindView(R.id.tv_create_wallet)
    TextView tvCreateWallet;
    @BindView(R.id.tv_import_wallet)
    TextView tvImportWallet;

    public static void start(Context context) {
        Intent starter = new Intent(context, StartMainActvity.class);
        context.startActivity(starter);
    }

    @Override
    public int getLayoutId() {
        return R.layout.activity_start_main_actvity;
    }


    /**
     * 选择创建钱包还是导入钱包
     */
    @Override
    protected void init() {
        customTitle.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
            @Override
            public void onLeftClick() {
                finish();
            }

            @Override
            public void onRightClick() {

            }
        });
        tvCreateWallet.setOnClickListener(view -> CreateWalletActivity.start(StartMainActvity.this));
        tvImportWallet.setOnClickListener(view -> ImportWalletActivity.start(StartMainActvity.this));


    }


    @Override
    public void onNetChange(boolean netWorkState) {
        super.onNetChange(netWorkState);

    }


}
