package com.nyzc.gdm.currencyratio.homePacakage;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.os.Handler;
import android.os.Message;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.View;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.GetHouseBean;
import com.nyzc.gdm.currencyratio.Bean.TimeSort;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.RoomObject;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;
import com.nyzc.gdm.currencyratio.Utils.DateUtil;
import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;
import com.nyzc.gdm.currencyratio.View.MyListView;
import com.nyzc.gdm.currencyratio.uipacakage.Adapter.ForestListAdapter;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import butterknife.BindView;

public class ForecastNewsActivity extends BaseActivity {

    @BindView(R.id.recycler_view)
    ListView mRecyclerView;
    @BindView(R.id.no_data)
    TextView no_data;
    @BindView(R.id.custom_title)
    CustomTitleBar customTitleBar;
    ForestListAdapter forestListAdapter;
    String roomid;
    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            if (roomObjectList.size() != 0) {
                no_data.setVisibility(View.GONE);
                mRecyclerView.setVisibility(View.VISIBLE);
                forestListAdapter.setData(roomObjectList);
                forestListAdapter.notifyDataSetChanged();
            } else {
                no_data.setVisibility(View.VISIBLE);
                mRecyclerView.setVisibility(View.GONE);
            }
            dismissLoadingDialog();
        }
    };

    @Override
    public int getLayoutId() {
        return R.layout.activity_forecast_news;
    }

    public static void start(Context context, String roomId) {
        Intent starter = new Intent(context, ForecastNewsActivity.class);
        starter.putExtra("roomIndex", roomId);
        context.startActivity(starter);
    }

    List<GetHouseBean> getHouseBean;
    RoomObject roomObject;
    List<RoomObject> roomObjectList = new ArrayList<>();
    List<TimeSort> timeList = new ArrayList<>();
    List<String> list = new ArrayList<>();
    String Time;
    public List<String> listRoom = new ArrayList<>();
    double totalShares;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    ;
    String stopTime;
    String langauage;

    /**
     * 1:代表最新预测下的数据
     * 2：代表热门预测下的数据 根据投注量 进行排序 剩下按照时间排序
     * 3：代表币圈下的数据
     * 4：代表热门事件的数据
     * 5：代表体育事件的数据
     */
    @Override
    protected void init() {
        showLoadingDialog();
        langauage = CacheUtils.getString(this, "langauage", "");
        roomid = getIntent().getStringExtra("roomIndex");
        customTitleBar.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
            @Override
            public void onLeftClick() {
                finish();
            }

            @Override
            public void onRightClick() {

            }
        });
        forestListAdapter = new ForestListAdapter(ForecastNewsActivity.this);
        mRecyclerView.setAdapter(forestListAdapter);
        mRecyclerView.setOnItemClickListener((adapterView, view, i, l) -> ForeCastActivity.start(ForecastNewsActivity.this, roomObjectList.get(i)));
        getSwitch(roomid);
        getdata();
    }

    private void getSwitch(String roomid) {
        switch (roomid) {
            case "1":
                customTitleBar.setTitle_text(getString(R.string.NewPredictions));
                if (langauage.equals("zh")) {
                    list.add("1.14.5");
                    list.add("1.14.4");
                    list.add("1.14.3");
                } else {
                    list.add("1.14.7");
                    list.add("1.14.8");
                    list.add("1.14.9");
                }

                break;
            case "2":
                customTitleBar.setTitle_text(getString(R.string.HotPredictions));
                if (langauage.equals("zh")) {
                    list.add("1.14.5");
                    list.add("1.14.4");
                    list.add("1.14.3");
                } else {
                    list.add("1.14.7");
                    list.add("1.14.8");
                    list.add("1.14.9");
                }
                break;
            case "3":
                customTitleBar.setTitle_text(getString(R.string.CryptoTopics));
                if (langauage.equals("zh")) {
                    list.add("1.14.5");
                } else {
                    list.add("1.14.8");
                }
                break;
            case "4":
                customTitleBar.setTitle_text(getString(R.string.HotEvent));
                if (langauage.equals("zh")) {
                    list.add("1.14.4");
                } else {
                    list.add("1.14.9");
                }

                break;
            case "5":
                customTitleBar.setTitle_text(getString(R.string.SportEvent));
                if (langauage.equals("zh")) {
                    list.add("1.14.3");
                } else {
                    list.add("1.14.7");
                }
                break;

        }
    }

    String total;


    private void getdata() {
        new Thread(() -> {
            try {
                if (BitsharesWalletWraper.getInstance().build_connect() == 0) {
                    if (roomid.equals("1") || roomid.equals("2")) {
                        getHouseBean = BitsharesWalletWraper.getInstance().getHouse(list);
                        for (int i = 0; i < getHouseBean.size(); i++) {
                            for (int j = 0; j < getHouseBean.get(i).getRooms().size(); j++) {
                                listRoom.add(getHouseBean.get(i).getRooms().get(j));
                            }
                        }
                    } else {
                        getHouseBean = BitsharesWalletWraper.getInstance().getHouse(list);
                        listRoom = getHouseBean.get(0).getRooms();
                    }
                    for (int j = 0; j < listRoom.size(); j++) {
                        String roomId = listRoom.get(j);
                        roomObject = BitsharesWalletWraper.getInstance().getSeerRoom(listRoom.get(j));
                        if (roomObject != null) {
                            if (roomid.equals("1")) {
                                if (langauage.equals("zh")) {
                                    Time = DateUtil.addDateMinut(roomObject.getOption().getStart().replace("T", " "), 8);
                                } else {
                                    Time = DateUtil.addDateMinut(roomObject.getOption().getStart().replace("T", " "), 0);
                                }
                                TimeSort timeSort = new TimeSort();
                                timeSort.setTime(Time);
                                timeSort.setRoomId(roomId);
                                timeList.add(timeSort);
                            } else if (roomid.equals("2")) {
                                totalShares = roomObject.getRunning_option().getTotal_shares();
                                switch (roomObject.getOption().getAccept_asset()) {
                                    case "1.3.0":
                                        total = NumerUtil.getSeerBigDecimal(String.valueOf(String.valueOf(totalShares)));
                                        break;
                                    case "1.3.5":
                                        total = NumerUtil.getUsdtBigDecimal(String.valueOf(String.valueOf(totalShares)));
                                        break;
                                    case "1.3.2":
                                        total = NumerUtil.getPFCBigDecimal(String.valueOf(String.valueOf(totalShares)));
                                        break;

                                }
                                TimeSort timeSort = new TimeSort();
                                timeSort.setTotalShares(Double.parseDouble(total));
                                timeSort.setRoomId(roomId);
                                timeList.add(timeSort);
                            } else {
                                if (langauage.equals("zh")) {
                                    Time = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 8);
                                } else {
                                    Time = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 0);
                                }
                                TimeSort timeSort = new TimeSort();
                                timeSort.setTime(Time);
                                timeSort.setRoomId(roomId);
                                timeList.add(timeSort);
                            }
                        }
                    }
                    if (roomid.equals("1")) {
                        ListTimeSort(timeList);
                    } else if (roomid.equals("2")) {
                        ListTotalSort(timeList);
                    } else {
                        ListTimeSort(timeList);
                    }
                    for (int g = 0; g < timeList.size(); g++) {
                        roomObject = BitsharesWalletWraper.getInstance().getSeerRoom(timeList.get(g).getRoomId());
                        if (langauage.equals("zh")) {
                            stopTime = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 8);
                        } else {
                            stopTime = DateUtil.addDateMinut(roomObject.getOption().getStop().replace("T", " "), 0);
                        }
                        try {
                            if (langauage.equals("zh")) {
                                Date d = new Date();
                                Date dt1 = sdf.parse(stopTime);
                                if (d.getTime() < dt1.getTime()) {
                                    roomObjectList.add(roomObject);
                                }
                            } else {
                                if (NumerUtil.getGMTStopTime(stopTime)) {
                                    roomObjectList.add(roomObject);
                                }
                            }

                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    }
                    handler.sendMessage(new Message());
                }
            } catch (NetworkStatusException e) {
                showInfoDialog(e.getMessage());
            }
        }).start();
    }

    /**
     * 根据时间进行排序
     *
     * @param list
     */
    private static void ListTimeSort(List<TimeSort> list) {
        Collections.sort(list, (s, t1) -> {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                Date dt1 = format.parse(s.getTime());
                Date dt2 = format.parse(t1.getTime());
                if (dt1.getTime() < dt2.getTime()) {
                    return 1;
                } else if (dt1.getTime() > dt2.getTime()) {
                    return -1;
                } else {
                    return 0;
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
            return 0;
        });
    }

    /**
     * 根据投注量进行排序
     *
     * @param list
     */
    private static void ListTotalSort(List<TimeSort> list) {
        Collections.sort(list, (s, t1) -> {
            try {
                if (s.getTotalShares() < t1.getTotalShares()) {
                    return 1;
                } else if (s.getTotalShares() > t1.getTotalShares()) {
                    return -1;
                } else {
                    return 0;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return 0;
        });
    }
}
