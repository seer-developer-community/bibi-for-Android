package com.nyzc.gdm.currencyratio.View;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.DialogFragment;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.Gson;
import com.nyzc.gdm.currencyratio.Base.AppLocalWalletUser;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.EthAccount;
import com.nyzc.gdm.currencyratio.Bean.FileSave;
import com.nyzc.gdm.currencyratio.MainActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.HttpUrl;
import com.nyzc.gdm.currencyratio.uipacakage.CheckBrainkeyActivity;
import com.nyzc.gdm.currencyratio.uipacakage.CreateWalletActivity;
import com.nyzc.gdm.currencyratio.uipacakage.ImportWalletActivity;
import com.zhy.http.okhttp.OkHttpUtils;
import com.zhy.http.okhttp.callback.StringCallback;

import org.greenrobot.eventbus.EventBus;

import okhttp3.Call;


public class ReminderBrainkeyDailog extends DialogFragment {

    //点击发表，内容不为空时的回调
    public SendBackListener sendBackListener;

    public interface SendBackListener {
        void sendBack(String inputText);
    }

    private ProgressDialog progressDialog;
    private String tvTopReminder, tvRemindottom;

    private Dialog dialog;
    private EditText inputDlg;
    private int numconut = 300;
    private String tag = null;
    private TextView tv_top_reminder, tv_remind_bottom, tv_brainkey_confirm;
    private Context context;

    public ReminderBrainkeyDailog() {
    }


    @SuppressLint("ValidFragment")
    public ReminderBrainkeyDailog(String tv_top_reminders, String tv_remind_bottoms, Context context) {
        //提示文字
        this.tvTopReminder = tv_top_reminders;
        this.tvRemindottom = tv_remind_bottoms;
        this.context = context;

    }


    public Dialog onCreateDialog(Bundle savedInstanceState) {
        // 使用不带Theme的构造器, 获得的dialog边框距离屏幕仍有几毫米的缝隙。
        dialog = new Dialog(getActivity(), R.style.RemindDialog);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE); // 设置Content前设定
//        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);
        View contentview = View.inflate(getActivity(), R.layout.item_remind_brainkey_layout, null);
        dialog.setContentView(contentview);
        dialog.setCanceledOnTouchOutside(false); // 外部点击取消
        // 设置宽度为屏宽, 靠近屏幕底部。
        Window window = dialog.getWindow();
        WindowManager.LayoutParams lp = window.getAttributes();
        lp.gravity = Gravity.BOTTOM; // 紧贴底部
        lp.alpha = 1;
        lp.dimAmount = 0.5f;
        lp.width = WindowManager.LayoutParams.MATCH_PARENT; // 宽度持平
        window.setAttributes(lp);
        window.addFlags(WindowManager.LayoutParams.FLAG_DIM_BEHIND);
        tv_top_reminder = contentview.findViewById(R.id.tv_top_reminder);
        tv_remind_bottom = contentview.findViewById(R.id.tv_remind_bottom);
        tv_brainkey_confirm = contentview.findViewById(R.id.tv_brainkey_confirm);
        tv_top_reminder.setText(tvTopReminder);
        tv_remind_bottom.setText(tvRemindottom);
        tv_brainkey_confirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
                if (tv_top_reminder.getText().toString().equals("备份成功") || tv_top_reminder.getText().toString().equals("Backup Done")) {

                    FileSave.write(MyApp.context, MyApp.localWalletUser, "localwallet");
                    MyApp.localWalletUser = (AppLocalWalletUser) FileSave.read(MyApp.context, "localwallet");
                    EventBus.getDefault().post("name");
                    Intent intent = new Intent(context, MainActivity.class);
                    intent.putExtra("lanchMode", 1);
                    startActivity(intent);
                }
            }
        });

        final Handler hanler = new Handler();
        dialog.setOnDismissListener(new DialogInterface.OnDismissListener() {
            public InputMethodManager mInputMethodManager;

            @Override
            public void onDismiss(DialogInterface dialog) {
                hanler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
//                        hideSoftkeyboard();
                    }
                }, 200);

            }
        });
        return dialog;
    }


    public void hideProgressdialog() {
        progressDialog.cancel();
    }


    public void hideSoftkeyboard() {
        try {
            ((InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE))
                    .hideSoftInputFromWindow(getActivity().getCurrentFocus().getWindowToken(),
                            InputMethodManager.HIDE_NOT_ALWAYS);
        } catch (NullPointerException e) {

        }
    }


}
