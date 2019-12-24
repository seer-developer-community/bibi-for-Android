package com.nyzc.gdm.currencyratio;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.IntegerRes;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.Gson;
import com.nyzc.gdm.currencyratio.Base.AppLocalWalletUser;
import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.ApkVersionInfo;
import com.nyzc.gdm.currencyratio.Bean.FileSave;
import com.nyzc.gdm.currencyratio.MinePacakege.MineFragment;
import com.nyzc.gdm.currencyratio.OrderPacakage.OrderFragment;
import com.nyzc.gdm.currencyratio.Utils.ActivityUtil;
import com.nyzc.gdm.currencyratio.Utils.HttpUrl;
import com.nyzc.gdm.currencyratio.accountPacakage.AccountFragment;
import com.nyzc.gdm.currencyratio.homePacakage.HomeFragment;
import com.nyzc.gdm.currencyratio.uipacakage.StartMainActvity;

import org.greenrobot.eventbus.EventBus;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.http.RequestParams;
import org.xutils.x;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;

public class MainActivity extends BaseActivity implements View.OnClickListener {
    FragmentManager fm;
    @BindView(R.id.iv_home)
    ImageView ivHome;
    @BindView(R.id.tv_home)
    TextView tvHome;
    @BindView(R.id.ll_home)
    LinearLayout llHome;
    @BindView(R.id.iv_dingdan)
    ImageView ivDingdan;
    @BindView(R.id.tv_dingdan)
    TextView tvDingdan;
    @BindView(R.id.ll_dingdan)
    LinearLayout llDingdan;
    @BindView(R.id.iv_seer_account)
    ImageView ivSeerAccount;
    @BindView(R.id.tv_seer_accoun)
    TextView tvSeerAccoun;
    @BindView(R.id.ll_account)
    LinearLayout llAccount;
    @BindView(R.id.iv_my)
    ImageView ivMy;
    @BindView(R.id.tv_my)
    TextView tvMy;
    @BindView(R.id.ll_my)
    LinearLayout llMy;
    private List<Fragment> fragments = new ArrayList<>();
    Fragment homeFragment, orderFragment, accountFragment, myFragment;
    private Fragment mContent;
    private String[] tags = new String[]{"HomeFragment", "OrderFragment", "AccountFragment", "MyFragment"};
    FrameLayout main_activity_contentContainer;
    int lanchMode;

    protected static final int UPDATE_APK = 1;
    protected static final int ERROR_URL = 2;
    protected static final int ERROR_IO = 3;
    protected static final int ERROR_JSON_PARSER = 4;
    private ApkVersionInfo.ResultBean mInfo;
    private Handler mHandler = new Handler(new Handler.Callback() {
        // /mnt/sdcard
        private final String APK_SAVE_PATH = Environment
                .getExternalStorageDirectory().getAbsolutePath() + "/new.apk";

        @Override
        public boolean handleMessage(Message msg) {

            switch (msg.what) {
                case UPDATE_APK:
                    showDiaLogAndUpdate();
                    break;

                case ERROR_IO:
                    Toast.makeText(MainActivity.this, "服务端读取异常", Toast.LENGTH_SHORT).show();
                    break;

                case ERROR_URL:
                    Toast.makeText(MainActivity.this, "url异常", Toast.LENGTH_SHORT).show();
                    break;

                case ERROR_JSON_PARSER:
                    Toast.makeText(MainActivity.this, "解析异常", Toast.LENGTH_SHORT).show();
                    break;
            }

            return true;
        }

        // showDialog
        private void showDiaLogAndUpdate() {
            AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
            builder.setTitle("提示").setMessage(mInfo.getAndroidReleaseNotesCn());
            builder.setPositiveButton("立即更新", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    // 点确定之后开始下载新版本apk,并且替换安装
                    RequestParams rp = new RequestParams(mInfo.getAndroidUpdataurl());

                    rp.setAutoResume(true);// 是否支持断点续传下载
                    rp.setSaveFilePath(APK_SAVE_PATH);// 设置文件下载后的保存路径
                    x.http()
                            .get(rp,
                                    new org.xutils.common.Callback.CommonCallback<File>() {

                                        @Override
                                        public void onCancelled(
                                                CancelledException arg0) {
                                            Log.i("TAG", "下载取消");
                                        }

                                        @Override
                                        public void onError(Throwable arg0,
                                                            boolean arg1) {
                                            Log.i("TAG", "下载失败");
                                        }

                                        @Override
                                        public void onFinished() {
                                            Log.i("TAG", "执行完了");
                                        }

                                        @Override
                                        public void onSuccess(File file) {
                                            // 下载成功 替换安装apk
                                            Intent intent = new Intent(
                                                    Intent.ACTION_VIEW);
                                            intent.setDataAndType(
                                                    Uri.fromFile(file),
                                                    "application/vnd.android.package-archive");
                                            intent.addCategory(Intent.CATEGORY_DEFAULT);
                                            startActivityForResult(intent, 0);
                                        }
                                    });

                }
            });
            builder.setCancelable(false);
            builder.create().show();
        }
    });



    // apk版本更新操作
    private void checkVersionUpdate() {
        new Thread() {
            public void run() {
                long startTime = System.currentTimeMillis();
                Message msg = Message.obtain();
                try {
                    mInfo = getVersionInfo();
                    String str = mInfo.getAndroidVersion();  //  102
                    String strI = str.replace(".", "");
                    if (getVersionCode() < Integer.valueOf(strI)) {
                        msg.what = UPDATE_APK;
                    }
                } catch (MalformedURLException e) {
                    msg.what = ERROR_URL;
                    e.printStackTrace();
                } catch (IOException e) {
                    msg.what = ERROR_IO;
                    e.printStackTrace();
                } catch (JSONException e) {
                    msg.what = ERROR_JSON_PARSER;
                    e.printStackTrace();
                } finally {
                    long endTime = System.currentTimeMillis();
                    if (endTime - startTime < 4000) {
                        try {
                            Thread.sleep(4000 - (endTime - startTime));
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                    mHandler.sendMessage(msg);
                }
            }

            ;
        }.start();
    }

    // 获取服务端apk版本号
    private ApkVersionInfo.ResultBean getVersionInfo() throws MalformedURLException,
            IOException, JSONException {
        String url = HttpUrl.BanBenGengXin;
        URL appInfoUrl = new URL(url);
        HttpURLConnection conn = (HttpURLConnection) appInfoUrl
                .openConnection();
        conn.setConnectTimeout(5000);
        conn.setReadTimeout(10000);
        conn.setRequestMethod("GET");

        conn.connect();

        if (conn.getResponseCode() == 200) {
            InputStream is = conn.getInputStream();
            byte[] buffer = new byte[1024];
            ByteArrayOutputStream bos = new ByteArrayOutputStream();

            int num = 0;
            while ((num = is.read(buffer)) != -1) {
                bos.write(buffer, 0, num);
            }

            // TODO  服务端数据解析 完之后赋值给 ApkVersionInfo
            ApkVersionInfo.ResultBean info = new ApkVersionInfo.ResultBean();
            String str = new String(bos.toByteArray(), "UTF-8");
            Log.e("uiqwieqew", str);

            Gson gson = new Gson();
            ApkVersionInfo apkVersionInfo = gson.fromJson(str, ApkVersionInfo.class);
            List<ApkVersionInfo.ResultBean> result1 = apkVersionInfo.getResult();
            for (int i = 0; i < result1.size(); i++) {
                ApkVersionInfo.ResultBean resultBean = result1.get(i);
                String androidVersion = resultBean.getAndroidVersion();
                if (androidVersion != null) {
                    info.setAndroidVersion(androidVersion);

                }
                String androidReleaseNotesCn = resultBean.getAndroidReleaseNotesCn();
                if (androidReleaseNotesCn != null) {
                    info.setAndroidReleaseNotesCn(androidReleaseNotesCn);
                }
                String androidReleaseNotesEn = resultBean.getAndroidReleaseNotesEn();
                if (androidReleaseNotesCn != null) {
                    info.setAndroidReleaseNotesEn(androidReleaseNotesEn);
                }
                String androidIsforce = resultBean.getAndroidIsforce();
                if (androidIsforce != null) {
                    info.setAndroidIsforce(androidIsforce);
                }

                String androidUpdataurl = resultBean.getAndroidUpdataurl();
                if (androidUpdataurl != null) {
                    info.setAndroidUpdataurl(androidUpdataurl);
                    Log.e("adsadssad", androidUpdataurl);
                }


            }

            bos.close();
            is.close();
            conn.disconnect();
            return info;
        }
        return null;
    }

    // 获取客户端apk版本号
    private int getVersionCode() {
        PackageManager manger = getPackageManager();
        int versionCode = 0;
        try {
            PackageInfo info = manger.getPackageInfo(getPackageName(), 0);
            String versionName = info.versionName;
            String str = versionName.replace(".", "");
            versionCode = Integer.parseInt(str);
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return versionCode;
    }


    /**
     * MainActivity是singleTask启动方式
     * 所以从其他页面跳转时需要标识，在onNewIntent方法中更新数据
     *
     * @param intent
     */
    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);

        lanchMode = intent.getIntExtra("lanchMode", -1);
        switch (lanchMode) {
            case 0:
                getSelectTab(0);
                switchFragment(mContent, fragments.get(0), 0);
                break;
            case 1:
                getSelectTab(3);
                switchFragment(mContent, fragments.get(3), 3);
                break;
            case 2:
                getSelectTab(1);
                switchFragment(mContent, fragments.get(1), 1);
                break;
            default:
                getSelectTab(0);
                switchFragment(mContent, fragments.get(0), 0);
                break;

        }

    }

    @Override
    public int getLayoutId() {
        return R.layout.activity_main;
    }

    @Override
    protected void init() {
        checkVersionUpdate();
        main_activity_contentContainer = findViewById(R.id.main_activity_frameLayout);
        llHome.setOnClickListener(this);
        llDingdan.setOnClickListener(this);
        llAccount.setOnClickListener(this);
        llMy.setOnClickListener(this);
        MyApp.localWalletUser = (AppLocalWalletUser) FileSave.read(MainActivity.this, "localwallet");
        if (MyApp.localWalletUser == null) {
            showRegisDialog();
        }
        initFragment();
    }

    private void selectTab(int position) {
        if (position == 0) {
            switchFragment(mContent, fragments.get(position), position);
        } else {
            MyApp.localWalletUser = (AppLocalWalletUser) FileSave.read(MainActivity.this, "localwallet");
            if (MyApp.localWalletUser == null) {
                StartMainActvity.start(MainActivity.this);
            } else {
                switchFragment(mContent, fragments.get(position), position);
            }
        }
    }

    public void switchFragment(Fragment from, Fragment to, int position) {
        if (mContent != to) {
            mContent = to;
            FragmentTransaction transaction = fm.beginTransaction();
            if (!to.isAdded()) { // 先判断是否被add过
                transaction.hide(from)
                        .add(R.id.main_activity_frameLayout, to, tags[position]).commitAllowingStateLoss(); // 隐藏当前的fragment，add下一个到Activity中
            } else {
                transaction.hide(from).show(to).commitAllowingStateLoss(); // 隐藏当前的fragment，显示下一个
            }
        }
    }

    /**
     * 初始化fragment
     */
    private void initFragment() {
        fm = getSupportFragmentManager();
        homeFragment = HomeFragment.newInstance();
        orderFragment = OrderFragment.newInstance();
        accountFragment = AccountFragment.newInstance();
        myFragment = MineFragment.newInstance();
        fragments.add(0, homeFragment);
        fragments.add(1, orderFragment);
        fragments.add(2, accountFragment);
        fragments.add(3, myFragment);
        mContent = homeFragment;
        getSelectTab(0);
        FragmentTransaction ft = fm.beginTransaction();
        ft.add(R.id.main_activity_frameLayout, mContent);
        ft.commitAllowingStateLoss();
    }


    private long exitTime = 0;

    /**
     * 设置返回按钮的监听事件
     * 监听返回键，点击两次退出程序
     *
     * @param keyCode
     * @param event
     * @return
     */
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK && event.getAction() == KeyEvent.ACTION_DOWN) {
            if ((System.currentTimeMillis() - exitTime) > 5000) {
                Toast.makeText(getApplicationContext(), "再按一次退出程序", Toast.LENGTH_LONG).show();
                exitTime = System.currentTimeMillis();
            } else {
                EventBus.getDefault().post("finish");
                ActivityUtil.getInstance().exitSystem();
            }
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }


    @Override
    public void onClick(View view) {
        MyApp.localWalletUser = (AppLocalWalletUser) FileSave.read(MainActivity.this, "localwallet");
        switch (view.getId()) {
            case R.id.ll_home:
                getSelectTab(0);
                selectTab(0);
                break;
            case R.id.ll_dingdan:
                if (MyApp.localWalletUser != null) {
                    getSelectTab(1);
                }
                selectTab(1);
                break;
            case R.id.ll_account:
                if (MyApp.localWalletUser != null) {
                    getSelectTab(2);
                }
                selectTab(2);
                break;
            case R.id.ll_my:
                if (MyApp.localWalletUser != null) {
                    getSelectTab(3);
                }
                selectTab(3);
                break;
        }
    }

    private void getSelectTab(int tab) {
        switch (tab) {
            case 0:
                ivHome.setSelected(true);
                ivDingdan.setSelected(false);
                ivSeerAccount.setSelected(false);
                ivMy.setSelected(false);
                break;
            case 1:
                ivDingdan.setSelected(true);
                ivSeerAccount.setSelected(false);
                ivMy.setSelected(false);
                ivHome.setSelected(false);
                break;
            case 2:
                ivSeerAccount.setSelected(true);
                ivMy.setSelected(false);
                ivHome.setSelected(false);
                ivDingdan.setSelected(false);
                break;
            case 3:
                ivMy.setSelected(true);
                ivHome.setSelected(false);
                ivDingdan.setSelected(false);
                ivSeerAccount.setSelected(false);
                break;
        }

    }
}
