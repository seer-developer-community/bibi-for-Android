package com.nyzc.gdm.currencyratio.homePacakage.Adapter;

import android.content.Context;
import android.support.constraint.ConstraintLayout;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.homePacakage.ForeCastActivity;
import com.nyzc.gdm.currencyratio.homePacakage.ForecastNewsActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.uipacakage.Adapter.ForestListAdapter;
import com.nyzc.gdm.currencyratio.View.MyListView;
import com.zhouwei.mzbanner.MZBannerView;
import com.zhouwei.mzbanner.holder.MZHolderCreator;
import com.zhouwei.mzbanner.holder.MZViewHolder;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import cy.agorise.graphenej.Bean.RoomBean;

public class HomeAdapter extends RecyclerView.Adapter {

    //轮播
    private static final int TYPE_BANNEER = 0;
    //预测
    private static final int TYPE_FOREACAST = 1;
    //推荐预测
    private static final int TYPE_RECOMMEND_FOREACAST = 2;

    private Context context;
    private List<String> listImg = new ArrayList<>();
    private ForestListAdapter forestListAdapter;

    public HomeAdapter(Context context) {
        this.context = context;
        listImg = initImageList();

    }


    List<RoomBean> roomBeanList = new ArrayList<>();

    public void setDataForcastList(List<RoomBean> list) {
        this.roomBeanList = list;
//        forestListAdapter.setData(roomBeanList);
//        notifyDataSetChanged();
    }

    private List<String> initImageList() {
        listImg.add("http://120.27.122.189:30000/unique/main_page/20180325_02.jpg");
        listImg.add("http://120.27.122.189:30000/unique/main_page/20180325_03.jpg");
        listImg.add("http://120.27.122.189:30000/unique/main_page/2019yilunfuxi.jpg");
        return listImg;
    }


    public int getSpanSize(int pos) {
        int viewType = getItemViewType(pos);
        switch (viewType) {
            case TYPE_BANNEER:
                return 3;
            case TYPE_FOREACAST:
                return 3;
            case TYPE_RECOMMEND_FOREACAST:
                return 3;

        }
        return 0;
    }

    @Override
    public int getItemViewType(int position) {
        switch (position) {
            case 0:
                return TYPE_BANNEER;
            case 1:
                return TYPE_FOREACAST;
            case 2:
                return TYPE_RECOMMEND_FOREACAST;
            default:
                return TYPE_BANNEER;

        }
    }

    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view;
        switch (viewType) {
            case TYPE_BANNEER:
                view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_banner_layout, null);
                return new HomeBannerViewHolder(view);
            case TYPE_FOREACAST:
                view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_forecast, null);
                return new HomeForecastViewhoder(view);
            case TYPE_RECOMMEND_FOREACAST:
                view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_recommend_list_layout, null);
                return new HomeRecommendForecastViewhoder(view);
        }
        return null;
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
        if (holder instanceof HomeBannerViewHolder) {
            HomeBannerViewHolder homeBannerViewHolder = (HomeBannerViewHolder) holder;
            // 设置数据
            homeBannerViewHolder.home_banner_view.setPages(listImg, new MZHolderCreator<BannerViewHolder>() {
                @Override
                public BannerViewHolder createViewHolder() {
                    return new BannerViewHolder();
                }
            });
            homeBannerViewHolder.home_banner_view.start();
        }
        if (holder instanceof HomeForecastViewhoder) {
//            HomeForecastViewhoder homeForecastViewhoder = (HomeForecastViewhoder) holder;
//            homeForecastViewhoder.tv_lastest_forecast.setOnClickListener(new View.OnClickListener() {
//                @Override
//                public void onClick(View view) {
//                    ForecastNewsActivity.start(MyApp.context);
//                }
//            });
//            homeForecastViewhoder.tv_resut.setOnClickListener(new View.OnClickListener() {
//                @Override
//                public void onClick(View view) {
//                    ForecastNewsActivity.start(MyApp.context);
//                }
//            });
//            homeForecastViewhoder.tv_hot_forecast.setOnClickListener(new View.OnClickListener() {
//                @Override
//                public void onClick(View view) {
////                    ForeCastActivity.start(MyApp.context);
//                }
//            });

        }
        if (holder instanceof HomeRecommendForecastViewhoder) {
            HomeRecommendForecastViewhoder recommendForecastViewhoder = (HomeRecommendForecastViewhoder) holder;
            recommendForecastViewhoder.recommend_forecast_list.setFocusable(false);
            forestListAdapter = new ForestListAdapter(context);
            recommendForecastViewhoder.recommend_forecast_list.setAdapter(forestListAdapter);

        }
    }

    @Override
    public int getItemCount() {
        return 3;
    }

    static class HomeBannerViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.home_banner_view)
        MZBannerView home_banner_view;

        public HomeBannerViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }
    }

    static class HomeForecastViewhoder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_lastest_forecast)
        TextView tv_lastest_forecast;
        @BindView(R.id.tv_hot_forecast)
        TextView tv_hot_forecast;
        @BindView(R.id.tv_topic)
        TextView tv_topic;
        @BindView(R.id.tv_resut)
        TextView tv_resut;
        @BindView(R.id.tv_other)
        TextView tv_other;

        public HomeForecastViewhoder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }
    }

    static class HomeRecommendForecastViewhoder extends RecyclerView.ViewHolder {

        @BindView(R.id.recommend_forecast_list)
        MyListView recommend_forecast_list;

        public HomeRecommendForecastViewhoder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }
    }

    public static class BannerViewHolder implements MZViewHolder<String> {
        private ImageView mImageView;

        @Override
        public View createView(Context context) {
            // 返回页面布局
            View view = LayoutInflater.from(context).inflate(R.layout.banner_item, null);
            mImageView = view.findViewById(R.id.iv_banner);
            return view;
        }

        @Override
        public void onBind(Context context, int i, String url) {
            Glide.with(context).load(url).into(mImageView);

        }

    }

}
