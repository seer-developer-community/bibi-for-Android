package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.webkit.WebView;

import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;

import butterknife.BindView;

public class ServiceActivity extends BaseActivity {

    @BindView(R.id.custom_title)
    CustomTitleBar custom_title;
    @BindView(R.id.webview)
    WebView webview;

    @Override
    public int getLayoutId() {
        return R.layout.activity_service;
    }

    int flag;

    public static void start(Context context, int flag) {
        Intent starter = new Intent(context, ServiceActivity.class);
        starter.putExtra("flag", flag);
        context.startActivity(starter);
    }

    @Override
    protected void init() {
        flag = getIntent().getIntExtra("flag", -1);
        custom_title.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
            @Override
            public void onLeftClick() {
                finish();
            }

            @Override
            public void onRightClick() {

            }
        });
        if (flag == 1) {
            custom_title.setTitle_text("用户协议");
            webview.loadUrl("file:///android_asset/user.html");
        } else {
            custom_title.setTitle_text("隐私协议");
            webview.loadUrl("file:///android_asset/secret.html");
        }

    }
}
