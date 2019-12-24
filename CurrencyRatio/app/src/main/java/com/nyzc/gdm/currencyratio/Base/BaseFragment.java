package com.nyzc.gdm.currencyratio.Base;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.OrderPacakage.OrderFragment;
import com.nyzc.gdm.currencyratio.R;

import butterknife.ButterKnife;
import butterknife.Unbinder;

/**
 * Created by ZJL
 * on 2018/6/21 0021.
 */

public abstract class BaseFragment extends Fragment implements NetBroadcastReceiver.OrderInterFace{
    protected Activity mActivity;
    protected Context context;
    private Unbinder bind;
    public static NetBroadcastReceiver.OrderInterFace orderInterFace;
    /**
     * 获得全局的，防止使用getActivity()为空
     *
     * @param context
     */
    @Override
    public void onAttach(Activity context) {
        super.onAttach(context);
        this.mActivity = (Activity) context;
        this.context = context;
        orderInterFace=this;
    }


    View view;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container
            , Bundle savedInstanceState) {
        if (view == null) {
            view = LayoutInflater.from(mActivity)
                    .inflate(getLayoutId(), container, false);
            bind = ButterKnife.bind(this, view);
            initView(view, savedInstanceState);
        } else {
            ViewGroup group = (ViewGroup) view.getParent();
            if (group != null) {
                group.removeView(view);
            }
        }
        return view;
    }

    private AlertDialog alertDialog;

    public void showLoadingDialog() {
        alertDialog = new AlertDialog.Builder(mActivity).create();
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
        alertDialog = new AlertDialog.Builder(mActivity).create();
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
        View view = View.inflate(mActivity, R.layout.info_alert, null);
        alertDialog.setContentView(view);
        TextView tvInfo = view.findViewById(R.id.tv_infos_remind);
        TextView tv_confirm = view.findViewById(R.id.tv_confirm);
        if (info != null || !info.equals("")) {
            tvInfo.setText(info);
        }
        tv_confirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                alertDialog.dismiss();
            }
        });
        alertDialog.setCanceledOnTouchOutside(false);
    }

    public void dismissLoadingDialog() {
        if (null != alertDialog && alertDialog.isShowing()) {
            alertDialog.dismiss();
        }
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        initData();
    }

    /**
     * 该抽象方法就是 onCreateView中需要的layoutID
     *
     * @return
     */
    protected abstract int getLayoutId();

    /**
     * 该抽象方法就是 初始化view
     *
     * @param view
     * @param savedInstanceState
     */
    protected abstract void initView(View view, Bundle savedInstanceState);

    /**
     * 执行数据的加载
     */
    protected abstract void initData();

    @Override
    public void onDestroyView() {
        super.onDestroyView();
//        bind.unbind();
    }
}
