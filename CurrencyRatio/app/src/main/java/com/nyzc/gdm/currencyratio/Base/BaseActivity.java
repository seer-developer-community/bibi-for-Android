package com.nyzc.gdm.currencyratio.Base;

import android.content.DialogInterface;
import android.content.IntentFilter;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.drawable.ColorDrawable;
import android.net.ConnectivityManager;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.view.KeyEvent;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.nyzc.gdm.currencyratio.Bean.OrderListBean;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.ActivityUtil;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;
import com.nyzc.gdm.currencyratio.Utils.StatusBarUtil;
import com.nyzc.gdm.currencyratio.uipacakage.CreateWalletActivity;

import java.util.List;

import butterknife.ButterKnife;
import butterknife.Unbinder;

public abstract class BaseActivity extends AppCompatActivity implements NetBroadcastReceiver.NetChangeListener {

    public static NetBroadcastReceiver.NetChangeListener netEvent;// 网络状态改变监听事件
    NetBroadcastReceiver myReceiver;
    private Unbinder bind;
    private String langauage;


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //设置布局内容
        setContentView(getLayoutId());
        //初始化黄油刀控件绑定框架
        bind = ButterKnife.bind(this);
        StatusBarUtil.setColor(this, getResources().getColor(R.color.comment_titlebar));
        IntentFilter filter = new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION);
        myReceiver = new NetBroadcastReceiver();
        this.registerReceiver(myReceiver, filter);
        // 隐藏标题栏
        if (getSupportActionBar() != null)
            getSupportActionBar().hide();

        // 添加到Activity工具类
        ActivityUtil.getInstance().addActivity(this);
        // 初始化netEvent
        netEvent = this;

        // 执行初始化方法
        init();
    }


    private AlertDialog alertDialog;

    public void showLoadingDialog() {
        alertDialog = new AlertDialog.Builder(this).create();
        alertDialog.getWindow().setBackgroundDrawable(new ColorDrawable());
        alertDialog.setCancelable(false);
        alertDialog.setOnKeyListener(new DialogInterface.OnKeyListener() {
            @Override
            public boolean onKey(DialogInterface dialog, int keyCode, KeyEvent event) {
                if (keyCode == KeyEvent.KEYCODE_SEARCH || keyCode == KeyEvent.KEYCODE_BACK)
                    return true;
                return false;
            }
        });
        alertDialog.show();
        alertDialog.setContentView(R.layout.loading_alert);
        alertDialog.setCanceledOnTouchOutside(false);
    }

    public void showInfoDialog(String info) {
        alertDialog = new AlertDialog.Builder(this).create();
        alertDialog.getWindow().setBackgroundDrawable(new ColorDrawable());
        alertDialog.setCancelable(true);
        alertDialog.setOnKeyListener(new DialogInterface.OnKeyListener() {
            @Override
            public boolean onKey(DialogInterface dialog, int keyCode, KeyEvent event) {
                if (keyCode == KeyEvent.KEYCODE_SEARCH || keyCode == KeyEvent.KEYCODE_BACK)
                    return true;
                return false;
            }
        });
        alertDialog.show();
        View view = View.inflate(BaseActivity.this, R.layout.info_alert, null);
        alertDialog.setContentView(view);
        TextView tvInfo = view.findViewById(R.id.tv_infos_remind);
        TextView tv_confirm = view.findViewById(R.id.tv_confirm);
        if (info != null || !info.equals("")) {
            tvInfo.setText(info);
        }
        tv_confirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (null != alertDialog && alertDialog.isShowing()) {
                    if(newWork){
                        alertDialog.dismiss();
                        alertDialog=null;
                    }

                }
            }
        });
        alertDialog.setCanceledOnTouchOutside(false);
    }

    public void showRegisDialog() {
        alertDialog = new AlertDialog.Builder(this).create();
        alertDialog.getWindow().setBackgroundDrawable(new ColorDrawable());
        alertDialog.setCancelable(false);
        alertDialog.setOnKeyListener(new DialogInterface.OnKeyListener() {
            @Override
            public boolean onKey(DialogInterface dialog, int keyCode, KeyEvent event) {
                if (keyCode == KeyEvent.KEYCODE_SEARCH || keyCode == KeyEvent.KEYCODE_BACK)
                    return true;
                return false;
            }
        });
        alertDialog.show();
        View view = View.inflate(BaseActivity.this, R.layout.regist_alert, null);
        alertDialog.setContentView(view);
        RelativeLayout relativeLayout = view.findViewById(R.id.rela_regis);
        ImageView dismss = view.findViewById(R.id.dismiss);
        ImageView at_once_regis = view.findViewById(R.id.at_once_regis);
        langauage = CacheUtils.getString(this, "langauage", "");
        if (langauage.equals("zh")) {
            relativeLayout.setBackground(getResources().getDrawable(R.mipmap.regis_gift));
            at_once_regis.setImageDrawable(getResources().getDrawable(R.mipmap.onceregis));
        } else {
            relativeLayout.setBackground(getResources().getDrawable(R.mipmap.en_regis_gift));
            at_once_regis.setImageDrawable(getResources().getDrawable(R.mipmap.regist_now));
        }
        at_once_regis.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                alertDialog.dismiss();
                CreateWalletActivity.start(BaseActivity.this);

            }
        });
        dismss.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (null != alertDialog && alertDialog.isShowing()) {

                    alertDialog.dismiss();
                }
            }
        });
        alertDialog.setCanceledOnTouchOutside(false);
    }


    public void dismissLoadingDialog() {
        if (null != alertDialog && alertDialog.isShowing()) {
            alertDialog.dismiss();
        }
    }


    /**
     * 设置布局layout
     *
     * @return
     */
    public abstract int getLayoutId();

    // 抽象 - 初始化方法，可以对数据进行初始化
    protected abstract void init();

    @Override
    protected void onResume() {
        super.onResume();
        Resources resources = this.getResources();
        Configuration configuration = resources.getConfiguration();
        configuration.fontScale = 1;
        resources.updateConfiguration(configuration, resources.getDisplayMetrics());
    }

    @Override
    protected void onDestroy() {
        // Activity销毁时，提示系统回收
        // System.gc();
        netEvent = null;
        unregisterReceiver(myReceiver);
        // 移除Activity
        ActivityUtil.getInstance().removeActivity(this);

        if (null != alertDialog && alertDialog.isShowing()) {
            alertDialog.dismiss();
        }

        super.onDestroy();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        // 点击手机上的返回键，返回上一层
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            // 移除Activity
            ActivityUtil.getInstance().removeActivity(this);
            this.finish();
        }
        return super.onKeyDown(keyCode, event);
    }
    boolean newWork;

    /**
     * 网络状态改变时间监听
     *
     * @param netWorkState true有网络，false无网络
     */
    @Override
    public void onNetChange(boolean netWorkState) {
        newWork=netWorkState;
        if (!newWork) {
            Toast.makeText(this, getString(R.string.network), Toast.LENGTH_SHORT).show();
//            showInfoDialog(getString(R.string.network));
        }
    }
}
