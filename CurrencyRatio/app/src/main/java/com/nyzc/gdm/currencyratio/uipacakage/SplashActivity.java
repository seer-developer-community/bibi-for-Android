package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.Base.AppLocalWalletUser;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.FileSave;
import com.nyzc.gdm.currencyratio.Bean.GetHouseBean;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.MainActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class SplashActivity extends AppCompatActivity {
    private AlertDialog alertDialog;
    String langauage;
    ImageView iv_splash_logo;
    ActionBar actionBar;

    /**
     * 启动页会提前预加载平台下的房间
     * 预加载之前需注意房间集合是否为空，防止重复加载
     *
     * @param savedInstanceState
     */
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EventBus.getDefault().register(this);
        actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.hide();
        }
        this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_splash);
        iv_splash_logo = findViewById(R.id.iv_splash_logo);
        langauage = CacheUtils.getString(SplashActivity.this, "langauage", "");
        switch (langauage) {
            case "zh":
                iv_splash_logo.setImageDrawable(getResources().getDrawable(R.mipmap.splash));
                switchLanguage("zh");
                break;
            default:
                iv_splash_logo.setImageDrawable(getResources().getDrawable(R.mipmap.start_en));
                switchLanguage("en");
                break;
        }
        new Handler().postDelayed(() -> {
                Intent intent = new Intent(SplashActivity.this, MainActivity.class);
                startActivity(intent);
        }, 2000);

    }

    @Subscribe
    public void finishSplash(String info) {
        if (info.equals("finish")) {
            finish();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBus.getDefault().unregister(this);
    }

    protected void switchLanguage(String language) {
        //设置应用语言类型
        Resources resources = getResources();
        Configuration config = resources.getConfiguration();
        DisplayMetrics dm = resources.getDisplayMetrics();
        if (language.equals("zh")) {
            config.locale = Locale.SIMPLIFIED_CHINESE;
            CacheUtils.putString(this, "langauage", "zh");
        } else {
            config.locale = Locale.ENGLISH;
            CacheUtils.putString(this, "langauage", "en");
        }
        resources.updateConfiguration(config, dm);

    }

    public void showInfoDialog(String info) {
        alertDialog = new AlertDialog.Builder(this).create();
        alertDialog.getWindow().setBackgroundDrawable(new ColorDrawable());
        alertDialog.setCancelable(false);
        alertDialog.setOnKeyListener((dialog, keyCode, event) -> {
            if (keyCode == KeyEvent.KEYCODE_SEARCH || keyCode == KeyEvent.KEYCODE_BACK)
                return true;
            return false;
        });
        alertDialog.show();
        View view = View.inflate(SplashActivity.this, R.layout.info_alert, null);
        alertDialog.setContentView(view);
        TextView tvInfo = view.findViewById(R.id.tv_infos_remind);
        TextView tv_confirm = view.findViewById(R.id.tv_confirm);
        if (info != null || !info.equals("")) {
            tvInfo.setText(info);
        }
        tv_confirm.setOnClickListener(view1 -> alertDialog.dismiss());
        alertDialog.setCanceledOnTouchOutside(false);
    }


}
