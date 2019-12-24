package com.nyzc.gdm.currencyratio.accountPacakage.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.Bean.WaitAccountBean;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;
import com.nyzc.gdm.currencyratio.Utils.DateUtil;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;

import butterknife.BindView;
import butterknife.ButterKnife;

public class TranstionRecorderAdapters extends BaseAdapter {

    Context context;
    WaitAccountBean list;
    String amount;
    String fee;
    String asset;
    String langauage;
    String usdtFee;
    String seerFee;
    String pfcFee;

    public TranstionRecorderAdapters(Context context, WaitAccountBean waitAccountBean, String assetType) {
        this.context = context;
        this.list = waitAccountBean;
        this.asset = assetType;
    }

    public void getClearData() {
        list.getListData().clear();
        notifyDataSetChanged();
    }

    @Override

    public int getCount() {
        return list.getListData().size();
    }

    @Override
    public Object getItem(int i) {
        return list.getListData().get(i);
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder viewHolder;
        if (view == null) {
            view = LayoutInflater.from(context).inflate(R.layout.item_transtion_recorder_layout, null);
            viewHolder = new ViewHolder(view);
            view.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) view.getTag();
        }

        if (list.getListData().size() != 0) {
            for (int g = 0; g < list.getListData().size(); g++) {
                langauage = CacheUtils.getString(context, "langauage", "");
                if (langauage.equals("zh")) {
                    viewHolder.transTime.setText(DateUtil.addDateMinut(list.getListData().get(i).replace("T", " "), 8));
                } else {
                    viewHolder.transTime.setText(DateUtil.addDateMinut(list.getListData().get(i).replace("T", " "), 0) + " GMT");
                }
                viewHolder.transAccount.setText(list.getListUserTo().get(i).getName());
                amount = String.valueOf(list.getTransationBeanList().get(i).amount.amount);
                fee = String.valueOf(list.getTransationBeanList().get(i).fee.amount);
                switch (asset) {
                    case "1.3.0":
                        seerFee = NumerUtil.getSeerBigDecimal(fee);
                        viewHolder.transFee.setText(context.getString(R.string.TransactionFee) + seerFee);
                        break;
                    case "1.3.5":
                        usdtFee = NumerUtil.getUsdtBigDecimal(fee);
                        viewHolder.transFee.setText(context.getString(R.string.TransactionFee) + usdtFee);
                        break;
                    case "1.3.2":
                        pfcFee = NumerUtil.getPFCBigDecimal(fee);
                        viewHolder.transFee.setText(context.getString(R.string.TransactionFee) + pfcFee);
                        break;
                }
                if (list.getListUserTo().get(i).isOneSelf()) {
                    viewHolder.transMoney.setTextColor(context.getResources().getColor(R.color.pwd_strong));
                    viewHolder.trans_money_top.setTextColor(context.getResources().getColor(R.color.pwd_strong));
                    viewHolder.transFee.setText(context.getString(R.string.TransactionFee) + "0");
                    switch (asset) {
                        case "1.3.0":
                            viewHolder.transMoney.setText(context.getString(R.string.TransactionAmount) + "+ " + NumerUtil.getSeerBigDecimal(amount));
                            viewHolder.trans_money_top.setText("+ " + NumerUtil.getSeerBigDecimal(amount));
                            break;
                        case "1.3.5":
                            viewHolder.transMoney.setText(context.getString(R.string.TransactionAmount) + "+ " + NumerUtil.getUsdtBigDecimal(amount));
                            viewHolder.trans_money_top.setText("+ " + NumerUtil.getUsdtBigDecimal(amount));
                            break;
                        case "1.3.2":
                            viewHolder.transMoney.setText(context.getString(R.string.TransactionAmount) + "+ " + NumerUtil.getPFCBigDecimal(amount));
                            viewHolder.trans_money_top.setText("+ " + NumerUtil.getPFCBigDecimal(amount));
                            break;

                    }

                } else {
                    viewHolder.transMoney.setTextColor(context.getResources().getColor(R.color.pwd_weak));
                    viewHolder.trans_money_top.setTextColor(context.getResources().getColor(R.color.pwd_weak));
                    switch (asset) {
                        case "1.3.0":
                            viewHolder.transMoney.setText(context.getString(R.string.TransactionAmount) + "- " + NumerUtil.getSeerBigDecimal(amount));
                            viewHolder.trans_money_top.setText("- " + NumerUtil.getBigDecimalAdd(NumerUtil.getSeerBigDecimal(amount), seerFee));
                            break;
                        case "1.3.5":
                            viewHolder.transMoney.setText(context.getString(R.string.TransactionAmount) + "- " + NumerUtil.getUsdtBigDecimal(amount));
                            viewHolder.trans_money_top.setText("- " + NumerUtil.getBigUsdtDecimalAdd(NumerUtil.getUsdtBigDecimal(amount), usdtFee));
                            break;
                        case "1.3.2":
                            viewHolder.transMoney.setText(context.getString(R.string.TransactionAmount) + "- " + NumerUtil.getPFCBigDecimal(amount));
                            viewHolder.trans_money_top.setText("- " + NumerUtil.getBigUsdtDecimalAdd(NumerUtil.getPFCBigDecimal(amount), pfcFee));
                            break;
                    }

                }
            }
        }

        return view;
    }


    static class ViewHolder {
        @BindView(R.id.trans_time)
        TextView transTime;
        @BindView(R.id.trans_type)
        TextView transType;
        @BindView(R.id.trans_account)
        TextView transAccount;
        @BindView(R.id.trans_money)
        TextView transMoney;
        @BindView(R.id.trans_fee)
        TextView transFee;
        @BindView(R.id.trans_money_top)
        TextView trans_money_top;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}


