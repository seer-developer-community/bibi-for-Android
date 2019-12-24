package com.nyzc.gdm.currencyratio.OrderPacakage.Adapter;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.nyzc.gdm.currencyratio.Bean.ItemsBean;
import com.nyzc.gdm.currencyratio.Bean.OrderListBean;
import com.nyzc.gdm.currencyratio.Bean.UserOrderBean;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;

import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class WaitAccountAdapter extends BaseAdapter {


    private List<OrderListBean> userOrderBeanList = new ArrayList<>();
    private Context context;
    String paid = null;
    String paidShare = null;
    String income = null;
    String pay = null;
    String reward = null;
    String Seer = "SEER";
    String Usdt = "USDT";
    String Pfc = "PFC";

    public WaitAccountAdapter(Context context) {
        this.context = context;
    }

    public void setData(List<OrderListBean> userOrderBeanLists) {
        this.userOrderBeanList.addAll(userOrderBeanLists);
        notifyDataSetChanged();

    }

    @Override
    public int getCount() {
        if (userOrderBeanList.size() == 0) {
            return 0;
        }
        return userOrderBeanList.size();
    }

    public List<OrderListBean> getData() {
        return userOrderBeanList;
    }

    public void clearData() {
        userOrderBeanList.clear();
        notifyDataSetChanged();
    }

    @Override
    public Object getItem(int i) {
        return userOrderBeanList.get(i);
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder viewHolder;
        if (view == null) {
            view = LayoutInflater.from(context).inflate(R.layout.item_wait_account_layout, null);
            viewHolder = new ViewHolder(view);
            view.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) view.getTag();
        }
        if (userOrderBeanList.get(i).getRoomTitle() != null) {
            viewHolder.tvWaitAccountTitle.setText(userOrderBeanList.get(i).getRoomTitle());
        }
        if (userOrderBeanList.get(i).getWhen() != null) {
            viewHolder.tvJoinTime.setText(context.getString(R.string.ParticipationTime) + userOrderBeanList.get(i).getWhen());
        }
        if (userOrderBeanList.get(i).getRoomSelect() != null) {
            viewHolder.tvWaitSelectAmount.setText(userOrderBeanList.get(i).getRoomSelect());
        }
        if (userOrderBeanList.get(i).getRoomSelect() != null && userOrderBeanList.get(i).getPaid() != -1) {
            switch (userOrderBeanList.get(i).getAsset_id()) {
                case "1.3.0":
                    paid = NumerUtil.getSeerBigDecimal(String.valueOf(userOrderBeanList.get(i).getPaid()));
                    paidShare = NumerUtil.getSeerBigDecimal(String.valueOf(userOrderBeanList.get(i).getAmount()));
                    break;
                case "1.3.5":
                    paidShare = NumerUtil.getUsdtBigDecimal(String.valueOf(userOrderBeanList.get(i).getAmount()));
                    paid = NumerUtil.getUsdtBigDecimal(String.valueOf(userOrderBeanList.get(i).getPaid()));
                    break;
                case "1.3.2":
                    paidShare = NumerUtil.getPFCBigDecimal(String.valueOf(userOrderBeanList.get(i).getAmount()));
                    paid = NumerUtil.getPFCBigDecimal(String.valueOf(userOrderBeanList.get(i).getPaid()));
                    break;
            }

            if (userOrderBeanList.get(i).getRoomType() != 0) {
                viewHolder.tv_pvd_sell_buy.setVisibility(View.GONE);
                switch (userOrderBeanList.get(i).getRoomType()) {
                    case 1:
                        switch (userOrderBeanList.get(i).getAsset_id()) {
                            case "1.3.0":
                                viewHolder.tv_amount.setText(paid + Seer);
                                break;
                            case "1.3.5":
                                viewHolder.tv_amount.setText(paid + Usdt);
                                break;
                            case "1.3.2":
                                viewHolder.tv_amount.setText(paid + Pfc);
                                break;
                        }
                        break;
                    case 2:
                        double advancedOdds = userOrderBeanList.get(i).getAmount() / userOrderBeanList.get(i).getPaid();
                        switch (userOrderBeanList.get(i).getAsset_id()) {
                            case "1.3.0":
                                viewHolder.tv_amount.setText(paid + Seer + "(X" + advancedOdds + ")");
                                break;
                            case "1.3.5":
                                viewHolder.tv_amount.setText(paid + Usdt + "(X" + advancedOdds + ")");
                                break;
                            case "1.3.2":
                                viewHolder.tv_amount.setText(paid + Pfc + "(X" + advancedOdds + ")");
                                break;
                        }
                        break;
                }
            } else {
                viewHolder.tv_pvd_sell_buy.setVisibility(View.VISIBLE);
                viewHolder.tv_amount.setText(paidShare + context.getString(R.string.share));
                if (userOrderBeanList.get(i).getPaid() > 0.0) {
                    switch (userOrderBeanList.get(i).getAsset_id()) {
                        case "1.3.0":
                            pay = NumerUtil.getSeerBigDecimal(String.valueOf(userOrderBeanList.get(i).getPaid()));
                            viewHolder.tv_pvd_sell_buy.setText(context.getString(R.string.pay) + " " + pay + Seer);
                            break;
                        case "1.3.5":
                            pay = NumerUtil.getUsdtBigDecimal(String.valueOf(userOrderBeanList.get(i).getPaid()));
                            viewHolder.tv_pvd_sell_buy.setText(context.getString(R.string.pay) + " " + pay + Usdt);
                            break;
                        case "1.3.2":
                            pay = NumerUtil.getPFCBigDecimal(String.valueOf(userOrderBeanList.get(i).getPaid()));
                            viewHolder.tv_pvd_sell_buy.setText(context.getString(R.string.pay) + " " + pay + Pfc);
                            break;
                    }

                    viewHolder.tv_pvd_sell_buy.setTextColor(context.getResources().getColor(R.color.pwd_weak));
                } else {
                    switch (userOrderBeanList.get(i).getAsset_id()) {
                        case "1.3.0":
                            income = NumerUtil.getSeerBigDecimal(String.valueOf(userOrderBeanList.get(i).getPaid()));
                            viewHolder.tv_pvd_sell_buy.setText(context.getString(R.string.income) + " " + String.valueOf(income.replace("-", "") + Seer));
                            break;
                        case "1.3.5":
                            income = NumerUtil.getUsdtBigDecimal(String.valueOf(userOrderBeanList.get(i).getPaid()));
                            viewHolder.tv_pvd_sell_buy.setText(context.getString(R.string.income) + " " + String.valueOf(income.replace("-", "") + Usdt));
                            break;
                        case "1.3.2":
                            income = NumerUtil.getPFCBigDecimal(String.valueOf(userOrderBeanList.get(i).getPaid()));
                            viewHolder.tv_pvd_sell_buy.setText(context.getString(R.string.income) + " " + String.valueOf(income.replace("-", "") + Pfc));
                            break;
                    }
                    viewHolder.tv_pvd_sell_buy.setTextColor(context.getResources().getColor(R.color.pwd_strong));

                }
            }
        }
        // 0 未开将 1 未中奖 2中奖 3 放弃
        switch (userOrderBeanList.get(i).getResult()) {
            //未开奖
            case 0:
                viewHolder.tv_wait_raward_amount.setVisibility(View.GONE);
                break;
            //未中奖
            case 1:
                viewHolder.tv_wait_raward_amount.setVisibility(View.VISIBLE);
                viewHolder.tv_wait_raward_amount.setText(context.getString(R.string.noprize));
                viewHolder.tv_wait_raward_amount.setTextColor(context.getResources().getColor(R.color.pwd_weak));
                break;
            //中奖
            case 2:
                viewHolder.tv_wait_raward_amount.setVisibility(View.VISIBLE);
                viewHolder.tv_wait_raward_amount.setTextColor(context.getResources().getColor(R.color.pwd_strong));
                switch (userOrderBeanList.get(i).getAsset_id()) {
                    case "1.3.0":
                        reward = NumerUtil.getSeerBigDecimal(String.valueOf(userOrderBeanList.get(i).getReward()));
                        break;
                    case "1.3.2":
                        reward = NumerUtil.getPFCBigDecimal(String.valueOf(userOrderBeanList.get(i).getReward()));
                        break;
                    case "1.3.5":
                        reward = NumerUtil.getUsdtBigDecimal(String.valueOf(userOrderBeanList.get(i).getReward()));
                        break;
                }
                viewHolder.tv_wait_raward_amount.setText("+" + reward);
                break;
            // 放弃
            case 3:
                viewHolder.tv_wait_raward_amount.setVisibility(View.VISIBLE);
                viewHolder.tv_wait_raward_amount.setText(context.getString(R.string.noprize));
                viewHolder.tv_wait_raward_amount.setTextColor(context.getResources().getColor(R.color.pwd_weak));
                break;
        }

        return view;
    }


    static class ViewHolder {
        @BindView(R.id.tv_wait_account_title)
        TextView tvWaitAccountTitle;
        @BindView(R.id.tv_wait_select_amount)
        TextView tvWaitSelectAmount;
        @BindView(R.id.tv_join_time)
        TextView tvJoinTime;
        @BindView(R.id.tv_wait_raward_amount)
        TextView tv_wait_raward_amount;
        @BindView(R.id.tv_pvd_sell_buy)
        TextView tv_pvd_sell_buy;
        @BindView(R.id.tv_amount)
        TextView tv_amount;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
