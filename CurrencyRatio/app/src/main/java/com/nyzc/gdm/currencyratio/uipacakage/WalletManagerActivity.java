package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.FileSave;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;
import com.nyzc.gdm.currencyratio.View.RemindInputBrainkeyDialog;
import com.nyzc.gdm.currencyratio.View.ReminderDeleteWalletDailog;

import butterknife.BindView;

public class WalletManagerActivity extends BaseActivity {


    @BindView(R.id.custom_title)
    CustomTitleBar customTitle;
    @BindView(R.id.tv_set_pwd)
    TextView tvSetPwd;
    @BindView(R.id.tv_set_delete)
    TextView tvSetDelete;
    ReminderDeleteWalletDailog reminderDeleteWalletDailog;

    @Override
    public int getLayoutId() {
        return R.layout.activity_wallet_manager;
    }

    public static void start(Context context) {
        Intent starter = new Intent(context, WalletManagerActivity.class);
        context.startActivity(starter);
    }

    RemindInputBrainkeyDialog dialog;

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
        /**
         * 删除钱包
         */
        tvSetDelete.setOnClickListener(view -> {
            reminderDeleteWalletDailog = new ReminderDeleteWalletDailog(WalletManagerActivity.this, isdelete -> {
                if (isdelete) {
                    boolean isDelete = FileSave.deleteFile(WalletManagerActivity.this, "localwallet");
                    if (isDelete) {
                        MyApp.localWalletUser = null;
                        StartMainActvity.start(WalletManagerActivity.this);
                        finish();
                    } else {
                        FileSave.deleteFile(WalletManagerActivity.this, "localwallet");
                    }
                }
            });
            reminderDeleteWalletDailog.show(getSupportFragmentManager(), "dialog");


        });
        /**
         * 修改密码
         */
        tvSetPwd.setOnClickListener(view -> SetPwdActivity.start(WalletManagerActivity.this));
    }


}
