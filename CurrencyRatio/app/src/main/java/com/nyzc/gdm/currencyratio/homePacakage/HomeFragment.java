package com.nyzc.gdm.currencyratio.homePacakage;

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.widget.SwipeRefreshLayout;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.nyzc.gdm.currencyratio.Base.BaseFragment;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.GetHouseBean;
import com.nyzc.gdm.currencyratio.Bean.OrderListBean;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.RoomObject;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;
import com.nyzc.gdm.currencyratio.Utils.DateUtil;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;
import com.nyzc.gdm.currencyratio.uipacakage.Adapter.ForestListAdapter;
import com.nyzc.gdm.currencyratio.View.MyListView;
import com.nyzc.gdm.currencyratio.uipacakage.SplashActivity;
import com.zhouwei.mzbanner.MZBannerView;
import com.zhouwei.mzbanner.holder.MZHolderCreator;
import com.zhouwei.mzbanner.holder.MZViewHolder;

import org.json.JSONObject;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import butterknife.BindView;

public class HomeFragment extends BaseFragment implements View.OnClickListener {

    ForestListAdapter forestListAdapter;
    private static List<Bitmap> listImg = new ArrayList<>();
    @BindView(R.id.recommend_forecast_list)
    MyListView recommend_forecast_list;
    @BindView(R.id.home_banner_view)
    MZBannerView mzBannerView;
    @BindView(R.id.swipeLayout)
    SwipeRefreshLayout refreshLayout;
    @BindView(R.id.tv_lastest_forecast)
    TextView tv_lastest_forecast;
    @BindView(R.id.tv_hot_forecast)
    TextView tv_hot_forecast;
    @BindView(R.id.tv_topic)
    TextView tv_topic;
    @BindView(R.id.tv_hot)
    TextView tv_hot;
    @BindView(R.id.tv_sport)
    TextView tv_sport;
    @BindView(R.id.no_data)
    TextView noData;
    @BindView(R.id.iv_banner_data)
    ImageView iv_banner_data;
    RoomObject roomObject;
    static List<RoomObject> roomObjectList = new ArrayList<>();
    static List<RoomObject> roomObjectListBanner = new ArrayList<>();
    static List<RoomObject> roomObjectList1 = new ArrayList<>();
    static List<RoomObject> roomObjectList2 = new ArrayList<>();
    static List<RoomObject> roomObjectList3 = new ArrayList<>();
    public static List<GetHouseBean> getHouseBean = new ArrayList<>();

    public static HomeFragment newInstance() {
        Bundle args = new Bundle();
        HomeFragment fragment = new HomeFragment();
        fragment.setArguments(args);
        return fragment;
    }

    /**
     * 轮播图的数量根据roomObjectListBanner的数量
     *
     * @return
     */
    private List<Bitmap> initImageList() {
        Bitmap bitmap = null;
        for (int i = 0; i < roomObjectListBanner.size(); i++) {
            switch (i) {
                case 0:
                    bitmap = BitmapFactory.decodeResource(this.getContext().getResources(), R.mipmap.banner_one);
                    break;
                case 1:
                    bitmap = BitmapFactory.decodeResource(this.getContext().getResources(), R.mipmap.banner_two);
                    break;
                case 2:
                    bitmap = BitmapFactory.decodeResource(this.getContext().getResources(), R.mipmap.banner_three);
                    break;
            }
            listImg.add(bitmap);
        }
        return listImg;
    }

    @Override
    protected int getLayoutId() {
        return R.layout.home_fragment_layout;
    }

    static String langauage;

    @Override
    protected void initView(View view, Bundle savedInstanceState) {
        langauage = CacheUtils.getString(mActivity, "langauage", "");
        tv_lastest_forecast.setOnClickListener(this);
        tv_hot_forecast.setOnClickListener(this);
        tv_hot.setOnClickListener(this);
        tv_sport.setOnClickListener(this);
        tv_topic.setOnClickListener(this);
        refreshLayout.setColorSchemeColors(Color.rgb(47, 223, 189));
        recommend_forecast_list.setFocusable(false);
        forestListAdapter = new ForestListAdapter(mActivity);
        recommend_forecast_list.setAdapter(forestListAdapter);
        refreshLayout.setOnRefreshListener(() -> {
            if (roomObjectList.size() != 0) {
                roomObjectList.clear();
            }
            if (roomObjectListBanner.size() != 0) {
                roomObjectListBanner.clear();
            }
            if (roomObjectList1.size() != 0) {
                roomObjectList1.clear();
            }
            if (roomObjectList2.size() != 0) {
                roomObjectList2.clear();
            }
            if (roomObjectList3.size() != 0) {
                roomObjectList3.clear();
            }
            if (listImg.size() != 0) {
                listImg.clear();
            }
            list1.clear();
            list2.clear();
            list3.clear();
            forestListAdapter.notifyDataSetChanged();
            initData();
            refreshLayout.setRefreshing(false);
        });
        recommend_forecast_list.setOnItemClickListener((adapterView, view1, i, l) -> ForeCastActivity.start(mActivity, roomObjectList.get(i)));
        mzBannerView.setBannerPageClickListener((view12, i) -> ForeCastActivity.start(mActivity, roomObjectListBanner.get(i)));
    }

    String stopTime;

    final List<String> list1 = new ArrayList<>();
    final List<String> list2 = new ArrayList<>();
    final List<String> list3 = new ArrayList<>();

    /**
     * 1：取三个平台下各自第一条和第二条作为推荐列表和轮播列表  超过截至时间的直接帅选掉。
     * 2：切换多语言时需要清空列表数据，防止重复加载。
     */
    @Override
    protected void initData() {
        showLoadingDialog();
        new Thread(() -> {
            try {
                if (!langauage.equals("")) {
                    roomObjectList1.clear();
                    roomObjectList2.clear();
                    roomObjectList3.clear();
                    roomObjectList.clear();
                    roomObjectListBanner.clear();
                    listImg.clear();
                    forestListAdapter.notifyDataSetChanged();
                }
                if (langauage.equals("zh")) {
                    list1.add("1.14.3");
                    list2.add("1.14.5");
                    list3.add("1.14.4");
                } else {
                    list1.add("1.14.7");
                    list2.add("1.14.8");
                    list3.add("1.14.9");
                }
                getHomeList(list1);
                getHomeList(list2);
                getHomeList(list3);
                if (roomObjectList1.size() != 0) {
                    Collections.reverse(roomObjectList1);
                    for (int i = 0; i < roomObjectList1.size(); i++) {
                        switch (i) {
                            case 0:
                                roomObjectList.add(roomObjectList1.get(0));
                                break;
                            case 1:
                                roomObjectListBanner.add(roomObjectList1.get(1));
                                break;
                        }
                    }
                }
                if (roomObjectList2.size() != 0) {
                    Collections.reverse(roomObjectList2);
                    for (int i = 0; i < roomObjectList2.size(); i++) {
                        switch (i) {
                            case 0:
                                roomObjectList.add(roomObjectList2.get(0));
                                break;
                            case 1:
                                roomObjectListBanner.add(roomObjectList2.get(1));
                                break;
                        }
                    }
                }
                if (roomObjectList3.size() != 0) {
                    Collections.reverse(roomObjectList3);
                    for (int i = 0; i < roomObjectList3.size(); i++) {
                        switch (i) {
                            case 0:
                                roomObjectList.add(roomObjectList3.get(0));
                                break;
                            case 1:
                                roomObjectListBanner.add(roomObjectList3.get(1));
                                break;
                        }
                    }
                }
                handler.sendMessage(new Message());
            } catch (Exception e) {
                Log.e("HOmeFragment", e.getMessage());
            }
        }).start();

    }

    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            if (roomObjectList.size() != 0) {
                forestListAdapter.setData(roomObjectList);
                noData.setVisibility(View.GONE);
                recommend_forecast_list.setVisibility(View.VISIBLE);
                forestListAdapter.notifyDataSetChanged();


            } else {
                noData.setVisibility(View.VISIBLE);
                recommend_forecast_list.setVisibility(View.GONE);
            }
            setBanner();
            dismissLoadingDialog();
        }
    };

    /**
     * 获取每个平台下的房间数量
     *
     * @param houseList
     */
    private void getHomeList(List<String> houseList) {
        if (BitsharesWalletWraper.getInstance().build_connect() == 0) {
            getList(houseList);

        }
    }

    private void getList(List<String> houseList) {
        switch (houseList.get(0)) {
            case "1.14.3":
                getHousess(houseList);
                break;
            case "1.14.4":
                getHousess(houseList);
                break;
            case "1.14.5":
                getHousess(houseList);
                break;
            case "1.14.7":
                getHousess(houseList);
                break;
            case "1.14.8":
                getHousess(houseList);
                break;
            case "1.14.9":
                getHousess(houseList);
                break;

        }

    }

    private void getHousess(List<String> listRoomId) {
        try {
            //获取首页房间列表Id
            getHouseBean = BitsharesWalletWraper.getInstance().getHouse(listRoomId);
            for (int i = 0; i < getHouseBean.size(); i++) {
                for (int j = 0; j < getHouseBean.get(i).getRooms().size(); j++) {
                    //获取房间的ID
                    String roomId = getHouseBean.get(i).getRooms().get(j);
                    //获取房间的Detail
                    roomObject = BitsharesWalletWraper.getInstance().getSeerRoom(roomId);
                    switch (listRoomId.get(0)) {
                        case "1.14.3":
                            if (roomObject != null) {
                                stopTime = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 8);
                                if (NumerUtil.getStopTime(stopTime)) {
                                    roomObjectList1.add(roomObject);
                                }
                            }
                            break;
                        case "1.14.5":
                            if (roomObject != null) {
                                stopTime = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 8);
                                if (NumerUtil.getStopTime(stopTime)) {
                                    roomObjectList2.add(roomObject);
                                }
                            }
                            break;
                        case "1.14.4":
                            if (roomObject != null) {
                                stopTime = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 8);
                                if (NumerUtil.getStopTime(stopTime)) {
                                    roomObjectList3.add(roomObject);
                                }
                            }
                            break;
                        case "1.14.7":
                            if (roomObject != null) {
                                stopTime = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 0);
                                if (NumerUtil.getGMTStopTime(stopTime)) {
                                    roomObjectList1.add(roomObject);
                                }
                            }
                            break;
                        case "1.14.8":
                            if (roomObject != null) {
                                stopTime = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 0);
                                if (NumerUtil.getGMTStopTime(stopTime)) {
                                    roomObjectList2.add(roomObject);
                                }
                            }
                            break;
                        case "1.14.9":
                            if (roomObject != null) {
                                stopTime = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 0);
                                if (NumerUtil.getGMTStopTime(stopTime)) {
                                    roomObjectList3.add(roomObject);
                                }
                            }
                            break;
                    }
                }
            }
        } catch (NetworkStatusException e) {
            Log.e("HomeFragment", e.getMessage());
        }
    }





    private void setBanner() {
        try {
            listImg = initImageList();
            if (listImg.size() != 0) {
                mzBannerView.setVisibility(View.VISIBLE);
                iv_banner_data.setVisibility(View.GONE);
                mzBannerView.setPages(listImg, (MZHolderCreator<BannerViewHolder>) () -> new BannerViewHolder());
                mzBannerView.start();
            } else {
                iv_banner_data.setVisibility(View.VISIBLE);
                mzBannerView.setVisibility(View.GONE);
            }
        } catch (Exception e) {
        }

    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.tv_sport:
                ForecastNewsActivity.start(mActivity, "5");
                break;
            case R.id.tv_hot:
                ForecastNewsActivity.start(mActivity, "4");
                break;
            case R.id.tv_topic:
                ForecastNewsActivity.start(mActivity, "3");
                break;
            case R.id.tv_hot_forecast:
                ForecastNewsActivity.start(mActivity, "2");
                break;
            case R.id.tv_lastest_forecast:
                ForecastNewsActivity.start(mActivity, "1");
                break;

        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        mzBannerView.pause();
    }

    @Override
    public void setData(List<List<Object>> list) {

    }

    public static class BannerViewHolder implements MZViewHolder<Bitmap> {
        private ImageView mImageView;
        private TextView tv_des;
        private TextView tv_stop_time;

        @Override
        public View createView(Context context) {
            // 返回页面布局
            View view = LayoutInflater.from(context).inflate(R.layout.banner_item, null);
            mImageView = view.findViewById(R.id.iv_banner);
            tv_des = view.findViewById(R.id.tv_des);
            tv_stop_time = view.findViewById(R.id.tv_stop_time);
            return view;
        }

        @Override
        public void onBind(Context context, int i, Bitmap url) {
            try {
                Glide.with(context).load(url).into(mImageView);
                if (roomObjectListBanner.get(i).getDescription() != null) {
                    if (langauage.equals("zh")) {
                        tv_stop_time.setText(context.getString(R.string.Deadline) + DateUtil.addDateMinut(roomObjectListBanner.get(i).getOption().getStop().replace("T", " "), 8));
                    } else {
                        tv_stop_time.setText(context.getString(R.string.Deadline) + DateUtil.addDateMinut(roomObjectListBanner.get(i).getOption().getStop().replace("T", " "), 0) + " GMT");
                    }
                    tv_des.setText(roomObjectListBanner.get(i).getDescription());
                }
            } catch (Exception e) {
                Log.e("HomeFragment", e.getMessage());
            }
        }

    }

}
