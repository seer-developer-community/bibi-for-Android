package com.nyzc.gdm.currencyratio.uipacakage.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.BiBiPacakage.RoomObject;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;
import com.nyzc.gdm.currencyratio.Utils.DateUtil;
import com.nyzc.gdm.currencyratio.Utils.FileUtils;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;


public class ForestListAdapter extends BaseAdapter {
    String langauage;
    private Context context;
    private List<RoomObject> list = new ArrayList<>();
    DecimalFormat decimalFormat = new DecimalFormat("###################.###########");
    String stopTime;

    public ForestListAdapter(Context context) {
        this.context = context;

    }

    public void setData(List<RoomObject> lists) {
        this.list = lists;
        notifyDataSetChanged();
    }

    @Override
    public int getCount() {
        if (list.size() == 0) {
            return 0;
        }
        return list.size();
    }

    @Override
    public Object getItem(int i) {
        return list.get(i);
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder viewHolder;
        if (view == null) {
            view = LayoutInflater.from(context).inflate(R.layout.item_list_forecast_layout, null);
            viewHolder = new ViewHolder(view);
            view.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) view.getTag();
        }
        switch (list.get(i).getRoom_type()) {
            case 0:
                viewHolder.tv_room_type.setText(context.getString(R.string.transactionPrediction));
                break;
            case 1:
                viewHolder.tv_room_type.setText(context.getString(R.string.prizePoolprediction));
                break;
            case 2:
                viewHolder.tv_room_type.setText(context.getString(R.string.fixedodds));
                break;
        }
        viewHolder.tvIfnos.setText(FileUtils.replaceBlank(list.get(i).getDescription()));
        langauage = CacheUtils.getString(context, "langauage", "");
        if (langauage.equals("zh")) {
            stopTime = DateUtil.addDateMinut(list.get(i).getOption().getStop().replace("T", " "), 8);
            viewHolder.tvTime.setText(context.getString(R.string.Deadline) + stopTime);
        } else {
            stopTime = DateUtil.addDateMinut(list.get(i).getOption().getStop().replace("T", " "), 0);
            viewHolder.tvTime.setText(context.getString(R.string.Deadline) + stopTime + " GMT");
        }
        if (list.get(i).getRunning_option().getSelection_description().size() != 0) {
            int des_num = list.get(i).getRunning_option().getSelection_description().size();
            switch (des_num) {
                case 1:
                    viewHolder.tv_selection_one.setText(list.get(i).getRunning_option().getSelection_description().get(0));
                    viewHolder.tv_selection_two.setVisibility(View.GONE);
                    viewHolder.tv_selection_three.setVisibility(View.GONE);
                    break;
                case 2:
                    viewHolder.tv_selection_one.setText(list.get(i).getRunning_option().getSelection_description().get(0));
                    viewHolder.tv_selection_two.setText(list.get(i).getRunning_option().getSelection_description().get(1));
                    viewHolder.tv_selection_three.setVisibility(View.GONE);
                    viewHolder.tv_selection_two.setVisibility(View.VISIBLE);
                    break;
                case 3:
                    viewHolder.tv_selection_one.setText(list.get(i).getRunning_option().getSelection_description().get(0));
                    viewHolder.tv_selection_two.setText(list.get(i).getRunning_option().getSelection_description().get(1));
                    viewHolder.tv_selection_three.setText(list.get(i).getRunning_option().getSelection_description().get(2));
                    viewHolder.tv_selection_two.setVisibility(View.VISIBLE);
                    viewHolder.tv_selection_three.setVisibility(View.VISIBLE);
                    break;
                default:
                    viewHolder.tv_selection_one.setText(list.get(i).getRunning_option().getSelection_description().get(0));
                    viewHolder.tv_selection_two.setText(list.get(i).getRunning_option().getSelection_description().get(1));
                    viewHolder.tv_selection_three.setText(context.getString(R.string.more));
                    viewHolder.tv_selection_two.setVisibility(View.VISIBLE);
                    viewHolder.tv_selection_three.setVisibility(View.VISIBLE);
                    break;
            }
        }
        String seerTotal;
        String usdtTotal;
        String pfcTotal;
        viewHolder.tvNum.setText(decimalFormat.format(list.get(i).getRunning_option().getTotal_player_count()) + "");
        switch (list.get(i).getOption().getAccept_asset()) {
            case "1.3.0":
                viewHolder.tv_asset_type.setText("SEER");
                seerTotal = NumerUtil.getSeerBigDecimal(String.valueOf(list.get(i).getRunning_option().getTotal_shares()));
                viewHolder.tvPfc.setText(seerTotal);
                break;
            case "1.3.5":
                viewHolder.tv_asset_type.setText("USDT");
                usdtTotal = NumerUtil.getUsdtBigDecimal(String.valueOf(list.get(i).getRunning_option().getTotal_shares()));
                viewHolder.tvPfc.setText(usdtTotal);
                break;
            case "1.3.2":
                viewHolder.tv_asset_type.setText("PFC");
                pfcTotal = NumerUtil.getPFCBigDecimal(String.valueOf(list.get(i).getRunning_option().getTotal_shares()));
                viewHolder.tvPfc.setText(pfcTotal);
                break;

        }

        return view;

    }

    static class ViewHolder {
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.rela_tv_time)
        RelativeLayout relaTvTime;
        @BindView(R.id.tv_ifnos)
        TextView tvIfnos;
        @BindView(R.id.ll_weight)
        LinearLayout llWeight;
        @BindView(R.id.tv_pfc)
        TextView tvPfc;
        @BindView(R.id.tv_num)
        TextView tvNum;
        @BindView(R.id.tv_asset_type)
        TextView tv_asset_type;
        @BindView(R.id.rela_time)
        RelativeLayout relaTime;
        @BindView(R.id.iv_collect)
        ImageView iv_collect;
        @BindView(R.id.tv_selection_one)
        TextView tv_selection_one;
        @BindView(R.id.tv_selection_two)
        TextView tv_selection_two;
        @BindView(R.id.tv_selection_three)
        TextView tv_selection_three;
        @BindView(R.id.tv_room_type)
        TextView tv_room_type;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
