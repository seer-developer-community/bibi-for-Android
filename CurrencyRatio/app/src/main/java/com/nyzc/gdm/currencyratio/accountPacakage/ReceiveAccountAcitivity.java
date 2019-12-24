package com.nyzc.gdm.currencyratio.accountPacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ReceiveAccountAcitivity extends BaseActivity {


    @BindView(R.id.custom_title)
    CustomTitleBar customTitle;
    @BindView(R.id.tv_create_wallet_name)
    TextView tvCreateWalletName;
    @BindView(R.id.edit_input_wallet_name)
    EditText editInputWalletName;
    @BindView(R.id.rela_wallet_name)
    RelativeLayout relaWalletName;
    @BindView(R.id.view1)
    View view1;
    @BindView(R.id.tv_create_addres)
    TextView tvCreateAddres;
    @BindView(R.id.edit_input_wallet_)
    EditText editInputWallet;
    @BindView(R.id.rela_create_wallet)
    RelativeLayout relaCreateWallet;
    @BindView(R.id.tv_copy_wallet)
    TextView tvCopyWallet;

    @Override
    public int getLayoutId() {
        return R.layout.activity_receive_account_acitivity;
    }

    public static void start(Context context) {
        Intent starter = new Intent(context, ReceiveAccountAcitivity.class);
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
    }


}
