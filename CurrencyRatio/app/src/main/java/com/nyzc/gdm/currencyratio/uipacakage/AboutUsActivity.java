package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;

import butterknife.BindView;

public class AboutUsActivity extends BaseActivity {

    @BindView(R.id.custom_title)
    CustomTitleBar custom_title;
    @BindView(R.id.tv_use_service)
    TextView tv_use_service;
    @BindView(R.id.tv_about_us_sercet)
    TextView tv_about_us_sercet;

    public static void start(Context context) {
        Intent starter = new Intent(context, AboutUsActivity.class);
        context.startActivity(starter);
    }


    @Override
    public int getLayoutId() {
        return R.layout.activity_about_us;
    }

    @Override
    protected void init() {
        custom_title.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
            @Override
            public void onLeftClick() {
                finish();
            }

            @Override
            public void onRightClick() {

            }
        });
        tv_use_service.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                ServiceActivity.start(AboutUsActivity.this, 1);
            }
        });
        tv_about_us_sercet.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                ServiceActivity.start(AboutUsActivity.this, 0);
            }
        });
    }
}
