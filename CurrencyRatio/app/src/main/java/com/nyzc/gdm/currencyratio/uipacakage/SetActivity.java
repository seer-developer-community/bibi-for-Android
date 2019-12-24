package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;

import butterknife.BindView;
import butterknife.ButterKnife;

public class SetActivity extends BaseActivity {


    @BindView(R.id.custom_title)
    CustomTitleBar customTitle;
    @BindView(R.id.tv_set_lageuage)
    TextView tvSetLageuage;
    @BindView(R.id.tv_about_us)
    TextView tvAboutUs;

    @Override
    public int getLayoutId() {
        return R.layout.activity_set;
    }

    public static void start(Context context) {
        Intent starter = new Intent(context, SetActivity.class);
        context.startActivity(starter);
    }

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
        tvAboutUs.setOnClickListener(view -> AboutUsActivity.start(SetActivity.this));
        tvSetLageuage.setOnClickListener(view -> LangauageManagerActivity.start(SetActivity.this));
    }


}
