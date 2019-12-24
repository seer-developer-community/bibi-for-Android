package com.nyzc.gdm.currencyratio.accountPacakage;

import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;

import butterknife.BindView;

public class AddAccountAddressActivity extends BaseActivity {

    @BindView(R.id.custom_title)
    CustomTitleBar custom_title;

    public static void start(Context context) {
        Intent starter = new Intent(context, AddAccountAddressActivity.class);
        context.startActivity(starter);
    }

    @Override
    public int getLayoutId() {
        return R.layout.activity_add_account_address;
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
    }
}
