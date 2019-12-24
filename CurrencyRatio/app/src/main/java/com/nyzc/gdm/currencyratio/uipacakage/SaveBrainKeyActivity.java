package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Context;
import android.content.Intent;
import android.support.constraint.ConstraintLayout;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.nyzc.gdm.currencyratio.Base.AppLocalWalletUser;
import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.KeyBoardUtils;
import com.nyzc.gdm.currencyratio.View.RemindInputBrainkeyDialog;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;

import butterknife.BindView;

public class SaveBrainKeyActivity extends BaseActivity {


    @BindView(R.id.custom_title)
    CustomTitleBar customTitle;
    @BindView(R.id.constrain_save_brankey)
    ConstraintLayout constrainSaveBrankey;
    @BindView(R.id.tv_sava_brainkey_warning)
    TextView tvSavaBrainkeyWarning;
    @BindView(R.id.tv_save_brainkey)
    TextView tvSaveBrainkey;
    RemindInputBrainkeyDialog dialog;
    AppLocalWalletUser localWalletUser;

    @Override
    public int getLayoutId() {
        return R.layout.activity_save_brain_key;
    }

    public static void start(Context context, AppLocalWalletUser localWalletUser) {
        Intent starter = new Intent(context, SaveBrainKeyActivity.class);
        starter.putExtra("localWalletUser", localWalletUser);
        context.startActivity(starter);
    }

    @Override
    protected void init() {
        localWalletUser = (AppLocalWalletUser) getIntent().getSerializableExtra("localWalletUser");
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
         * 备份助记词
         */
        tvSaveBrainkey.setOnClickListener(view -> {
            String walletPwd= String.valueOf(R.string.walletPwd);
            dialog = new RemindInputBrainkeyDialog(walletPwd, inputText -> {
                if (localWalletUser != null) {
                    dialog.dismiss();
//                            Toast.makeText(SaveBrainKeyActivity.this, "备份成功", Toast.LENGTH_SHORT).show();
                    KeyBoardUtils.hideSoftKeyboard(SaveBrainKeyActivity.this);
                    CheckBrainkeyActivity.start(SaveBrainKeyActivity.this);
                }

            });
            dialog.show(getSupportFragmentManager(), "dialog");
        });
    }


}
