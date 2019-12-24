package com.nyzc.gdm.currencyratio.OrderPacakage;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.nyzc.gdm.currencyratio.Base.AppLocalWalletUser;
import com.nyzc.gdm.currencyratio.Base.BaseFragment;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Base.NetBroadcastReceiver;
import com.nyzc.gdm.currencyratio.Bean.FileSave;
import com.nyzc.gdm.currencyratio.Bean.OrderListBean;
import com.nyzc.gdm.currencyratio.Bean.UserOrderInfo;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.RoomObject;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.OrderPacakage.Adapter.WaitAccountAdapter;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.AssetTypeUtil;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;
import com.nyzc.gdm.currencyratio.Utils.DateUtil;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;
import com.nyzc.gdm.currencyratio.View.BottomScrollView;
import com.nyzc.gdm.currencyratio.View.MyListView;
import com.nyzc.gdm.currencyratio.homePacakage.ForeCastActivity;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;

import java.lang.reflect.Type;
import java.util.List;

import butterknife.BindView;

public class OrderFragment extends BaseFragment implements View.OnClickListener, NetBroadcastReceiver.OrderInterFace {
    @BindView(R.id.scrollViewOrder)
    BottomScrollView mScrollView;
    MyListView main_MyListView;
    TextView tv_order;
    TextView tv_win;
    TextView tv_winRate;
    TextView tv_total_order_income;
    RelativeLayout rela_btn_seer;
    RelativeLayout rela_bth_usdt;
    LinearLayout order_working;
    LinearLayout order_wait;
    LinearLayout order_finised;
    TextView view_tv_bth_tab_usdt;
    TextView view_tv_seer_tab;
    View view_order_working;
    View view_order_wait;
    View view_order_finised;
    RelativeLayout rela_bth_pfc;
    TextView view_tv_bth_tab_pfc;
    ImageView iv_order_recorder;
    account_object accountObject;
    int onginPage =1000;

    public static OrderFragment newInstance() {
        Bundle args = new Bundle();
        OrderFragment fragment = new OrderFragment();
        fragment.setArguments(args);
        return fragment;
    }


    @Override
    protected int getLayoutId() {
        return R.layout.order_fragment_layout;
    }

    String CurryName;
    UserOrderInfo userOrderInfo;
    int asset_type = 0;
    WaitAccountAdapter waitAccountAdapter;

    @Override
    protected void initView(View view, Bundle savedInstanceState) {
        main_MyListView = view.findViewById(R.id.main_MyListView);
        tv_order = view.findViewById(R.id.tv_order);
        tv_win = view.findViewById(R.id.tv_win);
        tv_winRate = view.findViewById(R.id.tv_winRate);
        tv_total_order_income = view.findViewById(R.id.tv_total_order_income);
        rela_btn_seer = view.findViewById(R.id.rela_btn_seer);
        rela_bth_usdt = view.findViewById(R.id.rela_bth_usdt);
        order_working = view.findViewById(R.id.order_working);
        order_wait = view.findViewById(R.id.order_wait);
        order_finised = view.findViewById(R.id.order_finised);
        view_tv_bth_tab_usdt = view.findViewById(R.id.tv_bth_tab_usdt);
        view_tv_seer_tab = view.findViewById(R.id.tv_seer_tab);
        view_order_working = view.findViewById(R.id.view_order_working);
        view_order_wait = view.findViewById(R.id.view_order_wait);
        view_order_finised = view.findViewById(R.id.view_order_finised);
        rela_bth_pfc = view.findViewById(R.id.rela_bth_pfc);
        view_tv_bth_tab_pfc = view.findViewById(R.id.tv_bth_tab_usdt_pfc);
        iv_order_recorder = view.findViewById(R.id.iv_order_recorder);
        main_MyListView.setFocusable(false);
        main_MyListView.setFocusableInTouchMode(false);
        EventBus.getDefault().register(this);
        rela_btn_seer.setOnClickListener(this);
        rela_bth_usdt.setOnClickListener(this);
        order_working.setOnClickListener(this);
        order_finised.setOnClickListener(this);
        order_wait.setOnClickListener(this);
        rela_bth_pfc.setOnClickListener(this);
        langauage = CacheUtils.getString(mActivity, "langauage", "");
    }


    @Override
    protected void initData() {
        waitAccountAdapter = new WaitAccountAdapter(mActivity);
        main_MyListView.setAdapter(waitAccountAdapter);
        MyApp.localWalletUser = (AppLocalWalletUser) FileSave.read(context, "localwallet");
        if (MyApp.localWalletUser != null) {
            CurryName = MyApp.localWalletUser.getLocalName();
            getAcountObject();
            getRefreshData();
        }
        main_MyListView.setOnItemClickListener((adapterView, view, i, l) -> {
            try {
                MyApp.refreshOrder = true;
                ForeCastActivity.resultStart(mActivity, list.get(i).getRoom());
            } catch (Exception e) {
                Toast.makeText(mActivity, e.getMessage() + "", Toast.LENGTH_SHORT).show();
            }
        });
    }


    @Override
    public void onDestroyView() {
        super.onDestroyView();
        EventBus.getDefault().unregister(this);
    }

    private void getRefreshData() {
        try {
            showLoadingDialog();
            userOrderInfo = BitsharesWalletWraper.getInstance().getUserOrder(accountObject.id.get_userId());
            status = 1;
            switch (MyApp.assetOrder) {
                case "1.3.0":
                    asset_type = 0;
                    getViewSelect(0);
                    getViewSelect(2);
                    getUserAssetInfo(asset_type);
                    getOrderList(accountObject.id.get_userId(), AssetTypeUtil.seerAsset, status, onginPage);
                    break;
                case "1.3.2":
                    asset_type = 2;
                    getViewSelect(5);
                    getViewSelect(2);
                    getUserAssetInfo(asset_type);
                    getOrderList(accountObject.id.get_userId(), AssetTypeUtil.pfcAsset, status, onginPage);
                    break;
                case "1.3.5":
                    asset_type = 1;
                    getUserAssetInfo(asset_type);
                    getViewSelect(1);
                    getViewSelect(2);
                    getOrderList(accountObject.id.get_userId(), AssetTypeUtil.usdtAsset, status, onginPage);
                    break;
            }
        } catch (NetworkStatusException e) {
            e.printStackTrace();
        }
    }


    /**
     * getOrderWork这个方法是从投注成功后点击查看历史 刷新数据的方法
     * MyApp.refreshOrder为true时是从订单列表点进去 投注成功后的 标识
     *
     * @param info
     */
    @Subscribe
    public void getOrderWork(String info) {
        try {
            if (info.equals("refreshOrder")) {
                if (MyApp.refreshOrder) {
                    if (MyApp.isChangeOrder == 1) {
                        getClearData();
                        getRefreshData();
                        MyApp.isChangeOrder = 0;
                        MyApp.refreshOrder = false;
                    }
                }
            }
        } catch (Exception e) {
//            showInfoDialog(e.getMessage());
        }
    }

    boolean isChangeUser;

    @Override
    public void onHiddenChanged(boolean hidden) {
        super.onHiddenChanged(hidden);
        if (!hidden) {
            if (!CurryName.equals(MyApp.localWalletUser.getLocalName())) {
                CurryName = MyApp.localWalletUser.getLocalName();
                status = 1;
//                isChangeUser = true;
                getClearData();
                getAcountObject();
                getRefreshData();
            } else {
                if (!MyApp.refreshOrder) {
                    if (MyApp.isChangeOrder == 1) {
                        getClearData();
                        getRefreshData();
                        MyApp.isChangeOrder = 0;
                    }
                }
            }
        }
    }

    private void getClearData() {
        waitAccountAdapter.clearData();
        waitAccountAdapter.notifyDataSetChanged();
        main_MyListView.requestLayout();
    }

    String joinTime;
    String langauage;
    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.arg1) {
                case 1:
                    waitAccountAdapter.setData(list);
                    waitAccountAdapter.notifyDataSetChanged();
                    main_MyListView.setVisibility(View.VISIBLE);
                    iv_order_recorder.setVisibility(View.GONE);
                    break;
                case 2:
                    if (langauage.equals("zh")) {
                        iv_order_recorder.setImageResource(R.mipmap.icon_order_recorder);
                    } else {
                        iv_order_recorder.setImageResource(R.mipmap.en_no_recorder);
                    }
                    iv_order_recorder.setVisibility(View.VISIBLE);
                    main_MyListView.setVisibility(View.GONE);
                    break;
            }
            dismissLoadingDialog();

        }
    };

    List<List<Object>> orderList;

    private void getOrderList(String userId, String assetId, int status, int limit) {
        new Thread(() -> {
            try {
                orderList = BitsharesWalletWraper.getInstance().getSeerRoomRecordes(userId, assetId, status, "2678400", "2030-04-18T15:26:44", limit, orderInterFace);
                getData(orderList);
            } catch (NetworkStatusException e) {
            }
        }).start();
    }


    String winRate;
    int winNum;
    int orderNum;

    private void getUserAssetInfo(int assets_type) {
        orderNum = 0;
        winNum = 0;
        winRate = "0";
        tv_order.setText("0");
        tv_win.setText("0");
        tv_total_order_income.setText("0.00");
        tv_winRate.setText("0" + "%");
        switch (assets_type) {
            case 0:
                getAssetInfo(AssetTypeUtil.seerAsset);
                break;
            case 1:
                getAssetInfo(AssetTypeUtil.usdtAsset);
                break;
            case 2:
                getAssetInfo(AssetTypeUtil.pfcAsset);
                break;
        }
    }

    private void getAssetInfo(String assetId) {
        mActivity.runOnUiThread(() -> {
            for (int i = 0; i < userOrderInfo.getCount_total().size(); i++) {
                if (userOrderInfo.getCount_total().get(i).get(0).equals(assetId)) {
                    orderNum = Integer.parseInt(userOrderInfo.getCount_total().get(i).get(1));
                    tv_order.setText(orderNum + "");
                }
            }
            for (int i = 0; i < userOrderInfo.getCount_wins().size(); i++) {
                if (userOrderInfo.getCount_wins().get(i).get(0).equals(assetId)) {
                    winNum = Integer.parseInt(userOrderInfo.getCount_wins().get(i).get(1));
                    tv_win.setText(userOrderInfo.getCount_wins().get(i).get(1) + "");
                }
            }
            for (int i = 0; i < userOrderInfo.getShare_wins().size(); i++) {
                if (userOrderInfo.getShare_wins().get(i).get(0).equals(assetId)) {
                    switch (assetId) {
                        case "1.3.0":
                            tv_total_order_income.setText(NumerUtil.getSeerBigDecimal(String.valueOf(userOrderInfo.getShare_wins().get(i).get(1))) + "SEER");
                            break;
                        case "1.3.5":
                            tv_total_order_income.setText(NumerUtil.getUsdtBigDecimal(String.valueOf(userOrderInfo.getShare_wins().get(i).get(1))) + "USDT");
                            break;
                        case "1.3.2":
                            tv_total_order_income.setText(NumerUtil.getPFCBigDecimal(String.valueOf(userOrderInfo.getShare_wins().get(i).get(1))) + "PFC");
                            break;
                    }

                }
            }
            if (orderNum != 0) {
                winRate = NumerUtil.getOrderRate(winNum, orderNum);
                tv_winRate.setText(winRate + "%");
            }
        });
    }


    private void getAcountObject() {
        try {
            accountObject = BitsharesWalletWraper.getInstance().get_account_object(MyApp.localWalletUser.getLocalName());
        } catch (NetworkStatusException e) {
//            showInfoDialog(e.getMessage());
        }
    }

    int status = 1;

    //status = 1   进行中
    //status = 2   待结算
    //status = 4   已结束
    //status = 7   进行中+待结算+已结束
    @Override
    public void onClick(View view) {
        getClearData();
        showLoadingDialog();
        switch (view.getId()) {
            //SEER资产
            case R.id.rela_btn_seer:
                status = 1;
                asset_type = 0;
                getViewSelect(0);
                getViewSelect(2);
                getUserAssetInfo(asset_type);
                getOrderList(accountObject.id.get_userId(), AssetTypeUtil.seerAsset, status, onginPage);
                break;
            //USDT资产
            case R.id.rela_bth_usdt:
                asset_type = 1;
                status = 1;
                getViewSelect(1);
                getViewSelect(2);
                getUserAssetInfo(asset_type);
                getOrderList(accountObject.id.get_userId(), AssetTypeUtil.usdtAsset, status, onginPage);
                break;
            //pfc资产
            case R.id.rela_bth_pfc:
                asset_type = 2;
                status = 1;
                getViewSelect(5);
                getViewSelect(2);
                getUserAssetInfo(asset_type);
                getOrderList(accountObject.id.get_userId(), AssetTypeUtil.pfcAsset, status, onginPage);
                break;
            //进行中
            case R.id.order_working:
                status = 1;
                getViewSelect(2);
                getSelectOrderList(asset_type, status, onginPage);
                break;
            //结算中
            case R.id.order_wait:
                status = 2;
                getViewSelect(3);
                getSelectOrderList(asset_type, status, onginPage);
                break;
            //已结算
            case R.id.order_finised:
                status = 4;
                getViewSelect(4);
                getSelectOrderList(asset_type, status, onginPage);
                break;

        }
    }

    private void getSelectOrderList(int asset_type, int status, int page) {
        switch (asset_type) {
            case 0:
                getOrderList(accountObject.id.get_userId(), AssetTypeUtil.seerAsset, status, page);
                break;
            case 1:
                getOrderList(accountObject.id.get_userId(), AssetTypeUtil.usdtAsset, status, page);
                break;
            case 2:
                getOrderList(accountObject.id.get_userId(), AssetTypeUtil.pfcAsset, status, page);
                break;
        }

    }

    private void getViewSelect(int select) {
        switch (select) {
            case 0:
                view_tv_bth_tab_usdt.setVisibility(View.INVISIBLE);
                view_tv_bth_tab_pfc.setVisibility(View.INVISIBLE);
                view_tv_seer_tab.setVisibility(View.VISIBLE);
                break;
            case 1:
                view_tv_bth_tab_pfc.setVisibility(View.INVISIBLE);
                view_tv_bth_tab_usdt.setVisibility(View.VISIBLE);
                view_tv_seer_tab.setVisibility(View.INVISIBLE);
                break;
            case 2:
                view_order_working.setVisibility(View.VISIBLE);
                view_order_wait.setVisibility(View.INVISIBLE);
                view_order_finised.setVisibility(View.INVISIBLE);
                break;
            case 3:
                view_order_working.setVisibility(View.INVISIBLE);
                view_order_wait.setVisibility(View.VISIBLE);
                view_order_finised.setVisibility(View.INVISIBLE);
                break;
            case 4:
                view_order_working.setVisibility(View.INVISIBLE);
                view_order_wait.setVisibility(View.INVISIBLE);
                view_order_finised.setVisibility(View.VISIBLE);
                break;
            case 5:
                view_tv_bth_tab_pfc.setVisibility(View.VISIBLE);
                view_tv_bth_tab_usdt.setVisibility(View.INVISIBLE);
                view_tv_seer_tab.setVisibility(View.INVISIBLE);
                break;
        }
    }

    List<OrderListBean> list;

    @Override
    public void setData(List<List<Object>> orderListBean) {
//        getData(orderListBean);
    }

    private void getData(List<List<Object>> orderListBeans) {
        switch (orderListBeans.size()) {
            case 0:
                Message msg2 = new Message();
                msg2.arg1 = 2;
                handler.sendMessage(msg2);
                break;
            default:
                list = (List<OrderListBean>) orderListBeans.get(0).get(1);
                String jsonString = new Gson().toJson(list);
                Type type = new TypeToken<List<OrderListBean>>() {
                }.getType();
                list = new Gson().fromJson(jsonString, type);
                try {
                    if (list.size() != 0) {
                        for (int i = 0; i < list.size(); i++) {
                            String roomId = list.get(i).getRoom();
                            int selectOption = list.get(i).getInput();
                            RoomObject  roomObject = BitsharesWalletWraper.getInstance().getSeerRoom(roomId);
                            String select_option = roomObject.getRunning_option().getSelection_description().get(selectOption);
                            String roomDes = roomObject.getDescription();
                            int roomType = roomObject.getRoom_type();
                            list.get(i).setRoomSelect(select_option);
                            list.get(i).setRoomType(roomType);
                            list.get(i).setRoomTitle(roomDes);
                            if (langauage.equals("zh")) {
                                joinTime = DateUtil.addDateMinut(list.get(i).getWhen().replace("T", " "), 8);
                                list.get(i).setWhen(joinTime);
                            } else {
                                joinTime = DateUtil.addDateMinut(list.get(i).getWhen(), 0);
                                joinTime = joinTime + " GMT";
                                list.get(i).setWhen(joinTime);
                            }
                        }
                        Message msg = new Message();
                        msg.arg1 = 1;
                        handler.sendMessage(msg);
                    } else {
                        Message msg3 = new Message();
                        msg3.arg1 = 2;
                        handler.sendMessage(msg3);
                    }
                } catch (NetworkStatusException e) {
                    e.printStackTrace();
                }
                break;

        }
    }


}
