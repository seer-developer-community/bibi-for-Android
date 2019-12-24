package com.nyzc.gdm.currencyratio.homePacakage.Adapter;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.BiBiPacakage.RoomObject;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.DoubleUtil;
import com.nyzc.gdm.currencyratio.Utils.FileUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ForecastProgressAdapter extends BaseAdapter {

    private Context context;
    private List<String> listProgress = new ArrayList<>();
    private RoomObject roomBean;
    Double lmsrRunningTotal = 0.0;

    public ForecastProgressAdapter(Context context) {
        this.context = context;
    }

    public void setData(RoomObject roomBean) {
        try {
            this.roomBean = roomBean;
            this.listProgress = roomBean.getRunning_option().getSelection_description();
            //0 代表pvd 1代表pvp 2代表advanced
            switch (roomBean.getRoom_type()) {
                case 0:
                    if (roomBean.getRunning_option().getLmsr_running() != null) {
                        for (int i = 0; i < roomBean.getRunning_option().getLmsr_running().getItems().size(); i++) {
                            lmsrRunningTotal += roomBean.getRunning_option().getLmsr_running().getItems().get(i);
                        }
                    }
                    break;

            }
            notifyDataSetChanged();
        } catch (Exception e) {
            Log.e("Excepetion", e.getMessage());
        }
    }

    @Override
    public int getCount() {
        if (listProgress.size() == 0) {
            return 0;
        }
        return listProgress.size();
    }

    @Override
    public Object getItem(int i) {
        return listProgress.get(i);
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder viewHolder;
        if (view == null) {
            view = LayoutInflater.from(context).inflate(R.layout.item_forcast_progress_layout, null);
            viewHolder = new ViewHolder(view);
            view.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) view.getTag();
        }
        try {
            viewHolder.spForcastProgress.setMax(100);
            double total_participate = 0;
            double progress = 0;
            if (roomBean.getRunning_option().getPvp_running() != null) {
                total_participate = roomBean.getRunning_option().getPvp_running().getTotal_participate().get(i);
            } else {
                if (roomBean.getRunning_option().getLmsr_running() != null) {
                    total_participate = roomBean.getRunning_option().getLmsr_running().getItems().get(i);
                } else {
                    total_participate = roomBean.getRunning_option().getAdvanced_running().getTotal_participate().get(i).get(0);
                }
            }
            viewHolder.tvForcastDetail.setText(FileUtils.replaceBlank(listProgress.get(i)));
            if (roomBean.getRunning_option().getLmsr_running() != null) {
                if (lmsrRunningTotal > 0) {
                    progress = (total_participate / lmsrRunningTotal);
                }
            } else {
                double total_shares = roomBean.getRunning_option().getTotal_shares();
                if (total_shares > 0) {
                    progress = (total_participate / total_shares);
                }
            }
            String percent = DoubleUtil.doubolePercent(DoubleUtil.savedouble(progress));
            if (!percent.equals("NaN")) {
                viewHolder.tv_rate_select.setText(percent + "");
            } else {
                viewHolder.tv_rate_select.setText(0 + "");
            }

            if (total_participate != 0) {
                int doubleProress = (int) (Double.parseDouble(DoubleUtil.savedouble(progress)) * 100);
                viewHolder.spForcastProgress.setProgress(doubleProress);
            } else {
                viewHolder.spForcastProgress.setProgress(0);
            }
        } catch (Exception e) {
            Log.e("Excepetion", e.getMessage());
        }

        return view;
    }




    static class ViewHolder {
        @BindView(R.id.tv_forcast_detail)
        TextView tvForcastDetail;
        @BindView(R.id.sp_forcast_progress)
        ProgressBar spForcastProgress;
        @BindView(R.id.tv_rate_select)
        TextView tv_rate_select;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
