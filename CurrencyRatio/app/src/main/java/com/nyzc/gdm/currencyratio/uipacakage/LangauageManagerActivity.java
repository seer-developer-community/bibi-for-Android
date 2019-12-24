package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.util.DisplayMetrics;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.MainActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;

import java.util.Locale;

public class LangauageManagerActivity extends BaseActivity implements View.OnClickListener {

//      中英切换
    CustomTitleBar customTitle;
    RelativeLayout rela_tv_English_lageuage, rela_tv_Chinese_us;
    ImageView iv_engilish, iv_chinese;

    @Override
    public int getLayoutId() {
        return R.layout.activity_langauage_manager;
    }

    public static void start(Context context) {
        Intent starter = new Intent(context, LangauageManagerActivity.class);
        context.startActivity(starter);
    }

    @Override
    protected void init() {
        iv_engilish = findViewById(R.id.iv_engilish);
        iv_chinese = findViewById(R.id.iv_chinese);
        rela_tv_English_lageuage = findViewById(R.id.rela_tv_English_lageuage);
        rela_tv_Chinese_us = findViewById(R.id.rela_tv_Chinese_us);
        customTitle = findViewById(R.id.custom_title);
        rela_tv_English_lageuage.setOnClickListener(this);
        rela_tv_Chinese_us.setOnClickListener(this);
        customTitle.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
            @Override
            public void onLeftClick() {
                finish();
            }

            @Override
            public void onRightClick() {
            }
        });
        String langauage = CacheUtils.getString(LangauageManagerActivity.this, "langauage", "");
        switch (langauage) {
            case "":
                rela_tv_English_lageuage.setEnabled(true);
                rela_tv_Chinese_us.setEnabled(false);
                iv_chinese.setVisibility(View.VISIBLE);
                iv_engilish.setVisibility(View.INVISIBLE);
                break;
            case "en":
                rela_tv_English_lageuage.setEnabled(false);
                rela_tv_Chinese_us.setEnabled(true);
                iv_chinese.setVisibility(View.INVISIBLE);
                iv_engilish.setVisibility(View.VISIBLE);
                break;
            case "zh":
                rela_tv_English_lageuage.setEnabled(true);
                rela_tv_Chinese_us.setEnabled(false);
                iv_chinese.setVisibility(View.VISIBLE);
                iv_engilish.setVisibility(View.INVISIBLE);
                break;
        }

    }

    /**
     * 切换中文或者英文
     * @param view
     */

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            //英文
            case R.id.rela_tv_English_lageuage:
                iv_chinese.setVisibility(View.INVISIBLE);
                iv_engilish.setVisibility(View.VISIBLE);
                CacheUtils.putString(LangauageManagerActivity.this, "langauage", "en");
                Intent intent = new Intent(LangauageManagerActivity.this, SplashActivity.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
                startActivity(intent);

                break;
            //中文
            case R.id.rela_tv_Chinese_us:
                iv_chinese.setVisibility(View.VISIBLE);
                iv_engilish.setVisibility(View.INVISIBLE);
                CacheUtils.putString(LangauageManagerActivity.this, "langauage", "zh");
                Intent intent2 = new Intent(LangauageManagerActivity.this, SplashActivity.class);
                intent2.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
                startActivity(intent2);
                break;
        }
    }


}
