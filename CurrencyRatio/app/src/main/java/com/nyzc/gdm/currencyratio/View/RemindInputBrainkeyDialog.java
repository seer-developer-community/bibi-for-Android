package com.nyzc.gdm.currencyratio.View;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.DialogFragment;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.R;


public class RemindInputBrainkeyDialog extends DialogFragment {

    //点击发表，内容不为空时的回调
    public SendBackListener sendBackListener;

    public interface SendBackListener {
        void sendBack(String inputText);
    }

    private ProgressDialog progressDialog;
    private String texthint;

    private Dialog dialog;
    private EditText inputDlg;
    private int numconut = 300;
    private String tag = null;
    private TextView tv_pwd_input_remind;
    private ImageView iv_back;

    public RemindInputBrainkeyDialog() {
    }


    @SuppressLint("ValidFragment")
    public RemindInputBrainkeyDialog(String texthint, SendBackListener sendBackListener) {//提示文字
        this.texthint = texthint;
        this.sendBackListener = sendBackListener;

    }


    public Dialog onCreateDialog(Bundle savedInstanceState) {
        // 使用不带Theme的构造器, 获得的dialog边框距离屏幕仍有几毫米的缝隙。
        dialog = new Dialog(getActivity(), R.style.BottomDialog);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE); // 设置Content前设定
//        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);
        View contentview = View.inflate(getActivity(), R.layout.comment_dialog_layout, null);
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
        inputDlg = contentview.findViewById(R.id.edi_input_brainkey_pwd);
        inputDlg.setHint(getString(R.string.walletPwd));
        final TextView tv_send = contentview.findViewById(R.id.tv_cofirm_brainkey);
        tv_pwd_input_remind = contentview.findViewById(R.id.tv_pwd_input_remind);
        iv_back = contentview.findViewById(R.id.iv_back);
        tv_send.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (TextUtils.isEmpty(inputDlg.getText().toString())) {
                    Toast.makeText(getActivity(), getString(R.string.inputContentEmpty), Toast.LENGTH_LONG).show();
                    return;
                } else {
                    if (MyApp.localWalletUser != null) {
                        if (inputDlg.getText().toString().equals(MyApp.localWalletUser.getLocalPwd())) {
                            sendBackListener.sendBack(inputDlg.getText().toString());
                        } else {
                            tv_pwd_input_remind.setVisibility(View.VISIBLE);
                        }
                    } else {
                        tv_pwd_input_remind.setText(getString(R.string.inputContentError));
                        tv_pwd_input_remind.setVisibility(View.VISIBLE);
                    }


                }
            }
        });
        iv_back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
            }
        });
        inputDlg.setFocusable(true);
        inputDlg.setFocusableInTouchMode(true);
        inputDlg.requestFocus();
        final Handler hanler = new Handler();
        dialog.setOnDismissListener(new DialogInterface.OnDismissListener() {
            public InputMethodManager mInputMethodManager;

            @Override
            public void onDismiss(DialogInterface dialog) {
                hanler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        hideSoftkeyboard();
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
