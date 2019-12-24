package com.nyzc.gdm.currencyratio.View;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.DialogFragment;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.R;


public class ReminderDeleteWalletDailog extends DialogFragment {

    //点击发表，内容不为空时的回调
    public ConfirmWalletListen confirmWalletListen;


    public interface ConfirmWalletListen {
        void delete(boolean isdelete);
    }

    private ProgressDialog progressDialog;
    private Dialog dialog;
    private EditText inputDlg;
    private int numconut = 300;
    private String tag = null;
    private TextView tv_delelte_confirm, tv_delete_cancel;
    private Context context;

    public ReminderDeleteWalletDailog() {
    }


    @SuppressLint("ValidFragment")
    public ReminderDeleteWalletDailog(Context context, ConfirmWalletListen confirmWalletListen) {
        this.confirmWalletListen = confirmWalletListen;
        this.context = context;
    }


    public Dialog onCreateDialog(Bundle savedInstanceState) {
        // 使用不带Theme的构造器, 获得的dialog边框距离屏幕仍有几毫米的缝隙。
        dialog = new Dialog(getActivity(), R.style.RemindDialog);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE); // 设置Content前设定
//        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);
        View contentview = View.inflate(getActivity(), R.layout.item_remind_delete_layout, null);
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
        tv_delelte_confirm = contentview.findViewById(R.id.tv_delelte_confirm);
        tv_delete_cancel = contentview.findViewById(R.id.tv_delete_cancel);

        tv_delelte_confirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                confirmWalletListen.delete(true);
                dialog.dismiss();
            }
        });
        tv_delete_cancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
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


}
