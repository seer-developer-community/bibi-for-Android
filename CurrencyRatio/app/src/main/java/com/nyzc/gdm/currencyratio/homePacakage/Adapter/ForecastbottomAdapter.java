package com.nyzc.gdm.currencyratio.homePacakage.Adapter;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.PointerIcon;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.Base.AppLocalWalletUser;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.FileSave;
import com.nyzc.gdm.currencyratio.Bean.OddsBean;
import com.nyzc.gdm.currencyratio.BiBiPacakage.RoomObject;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.homePacakage.interFace.ForcaseListen;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.uipacakage.StartMainActvity;
import com.nyzc.gdm.currencyratio.Utils.DoubleUtil;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ForecastbottomAdapter extends BaseAdapter {

    private Context context;
    private List<OddsBean> list = new ArrayList<>();
    private List<String> listOdds = new ArrayList<>();
    private RoomObject roomBean;
    OddsBean oddsBean;
    ForcaseListen forcaseListen;
    boolean isForcast;

    public ForecastbottomAdapter(Context context) {
        this.context = context;
        forcaseListen = (ForcaseListen) context;
    }

    public void setData(RoomObject roomBean, boolean isForacast) {
        try {
            this.isForcast = isForacast;
            oddsBean = new OddsBean();
            this.roomBean = roomBean;
            this.listOdds = roomBean.getRunning_option().getSelection_description();
            for (int i = 0; i < listOdds.size(); i++) {
                oddsBean.setOdds(listOdds.get(i));
                oddsBean.setForeCast(false);
                oddsBean.setSelect(false);
                list.add(oddsBean);
            }
            notifyDataSetChanged();
        }catch (Exception e){
            Log.e("Exception",e.getMessage());
        }

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
    public View getView(final int i, View view, ViewGroup viewGroup) {
        final ViewHolder viewHolder;
        String Odds = null;
        if (view == null) {
            view = LayoutInflater.from(context).inflate(R.layout.item_forcast_bottom_layout, null);
            viewHolder = new ViewHolder(view);
            view.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) view.getTag();
        }
//        try {
            double total_participate = 0;
            double odd = 0;
            if (roomBean.getRunning_option().getPvp_running() != null) {
                viewHolder.ivOdds.setVisibility(View.VISIBLE);
                viewHolder.tvOdds.setVisibility(View.VISIBLE);
                total_participate = roomBean.getRunning_option().getPvp_running().getTotal_participate().get(i);
                double total_shares = roomBean.getRunning_option().getTotal_shares();
                if (total_participate > 0) {
                    odd = total_shares / total_participate;
                    Odds = DoubleUtil.savedouble(odd);
                }
            } else {
                if (roomBean.getRunning_option().getAdvanced() != null) {
                    viewHolder.tvOdds.setVisibility(View.VISIBLE);
                    viewHolder.ivOdds.setVisibility(View.VISIBLE);
                    double awards = roomBean.getRunning_option().getAdvanced().getAwards().get(i);
                    odd = awards / 10000;
                    Odds = DoubleUtil.savedouble(odd);
                } else {
                    viewHolder.ivOdds.setVisibility(View.GONE);
                    viewHolder.tvOdds.setVisibility(View.GONE);
                }
            }
            if (odd > 0.0) {
                viewHolder.tv_odds_name.setText(listOdds.get(i));
                viewHolder.tvOdds.setText("(x" + Odds + ")");
            } else {
                viewHolder.tv_odds_name.setText(listOdds.get(i));
                viewHolder.tvOdds.setText("(x" + 0 + ")");
            }
            if (roomBean.getStatus().equals("finished")) {
                viewHolder.tvOddsContent.setText(context.getString(R.string.finalOdds));
                if (i == roomBean.getRunning_option().getFinal_result().get(0)) {
                    viewHolder.tv_odds_name.setTextColor(context.getResources().getColor(R.color.comment_titlebar));
                    viewHolder.tvOdds.setTextColor(context.getResources().getColor(R.color.comment_titlebar));
                    viewHolder.tv_end.setVisibility(View.VISIBLE);
                } else {
                    viewHolder.tv_end.setVisibility(View.INVISIBLE);
                    viewHolder.tv_odds_name.setTextColor(context.getResources().getColor(R.color.tab_tv_color));
                    viewHolder.tvOdds.setTextColor(context.getResources().getColor(R.color.tab_tv_color));
                }
                viewHolder.tv_forecast.setVisibility(View.INVISIBLE);
            } else {
                viewHolder.tv_odds_name.setTextColor(context.getResources().getColor(R.color.tab_tv_color));
                viewHolder.tvOdds.setTextColor(context.getResources().getColor(R.color.tab_tv_color));
                viewHolder.tv_end.setVisibility(View.INVISIBLE);
                if (isForcast) {
                    viewHolder.tv_forecast.setText(context.getString(R.string.prediction));
                    viewHolder.tv_forecast.setEnabled(true);
                    viewHolder.tv_forecast.setVisibility(View.VISIBLE);
                } else {
                    viewHolder.tv_forecast.setText(context.getString(R.string.Cutoff));
                    viewHolder.tv_forecast.setEnabled(false);
                    viewHolder.tv_forecast.setVisibility(View.VISIBLE);
                }
                switch (roomBean.getRoom_type()) {
                    case 1:
                        viewHolder.tvOddsContent.setText(context.getString(R.string.pvpOdds));
                        break;
                    case 2:
                        viewHolder.tvOddsContent.setText(context.getString(R.string.advancedOdds));
                        break;
                }
            }
//        }catch (Exception e){
//
//        }

        viewHolder.ivOdds.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                int position = i;
                if (list.get(position).isSelect()) {
                    viewHolder.tvOddsContent.setVisibility(View.INVISIBLE);
                    list.get(position).setSelect(false);
                } else {
                    viewHolder.tvOddsContent.setVisibility(View.VISIBLE);
                    list.get(position).setSelect(true);
                }
            }
        });
        viewHolder.tv_forecast.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                int position = i;
                MyApp.localWalletUser = (AppLocalWalletUser) FileSave.read(context, "localwallet");
                if (MyApp.localWalletUser == null) {
                    StartMainActvity.start(context);
                } else {
                    if (forcaseListen != null) {
                        forcaseListen.forcastListen(position, roomBean);
                    }
                }


            }
        });
        return view;
    }


    static class ViewHolder {
        @BindView(R.id.tv_odds)
        TextView tvOdds;
        @BindView(R.id.iv_odds)
        ImageView ivOdds;
        @BindView(R.id.tv_odds_content)
        TextView tvOddsContent;
        @BindView(R.id.tv_forecast)
        TextView tv_forecast;
        @BindView(R.id.tv_end)
        TextView tv_end;
        @BindView(R.id.tv_odds_name)
        TextView tv_odds_name;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
