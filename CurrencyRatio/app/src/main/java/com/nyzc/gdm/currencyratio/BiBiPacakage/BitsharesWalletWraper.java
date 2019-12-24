package com.nyzc.gdm.currencyratio.BiBiPacakage;

import com.google.common.collect.Sets;
import com.nyzc.gdm.currencyratio.Base.NetBroadcastReceiver;
import com.nyzc.gdm.currencyratio.Bean.BlockRoomHeader;
import com.nyzc.gdm.currencyratio.Bean.GetHouseBean;
import com.nyzc.gdm.currencyratio.Bean.UserOrderInfo;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.block_header;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.global_property_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.signed_transaction;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.BiBiPacakage.market.MarketTicker;
import com.nyzc.gdm.currencyratio.BiBiPacakage.market.MarketTrade;
import com.nyzc.gdm.currencyratio.BiBiPacakage.walletcommon.full_account_object;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

public class BitsharesWalletWraper {
    public interface BitsharesDataObserver {
        void onDisconnect();

        void onMarketFillUpdate(object_id<asset_object> base, object_id<asset_object> quote);

        void onAccountChanged();
    }

    private static BitsharesWalletWraper bitsharesWalletWraper = new BitsharesWalletWraper();
    private wallet_api mWalletApi;
    private Map<object_id<account_object>, account_object> mMapAccountId2Object = new ConcurrentHashMap<>();
    private Map<object_id<account_object>, List<asset>> mMapAccountId2Asset = new ConcurrentHashMap<>();
    private Map<object_id<account_object>, List<operation_history_object>> mMapAccountId2History = new ConcurrentHashMap<>();
    private Map<object_id<asset_object>, asset_object> mMapAssetId2Object = new ConcurrentHashMap<>();
    private Set<BitsharesDataObserver> msetDataObserver;

    private String mstrWalletFilePath;

    private int mnStatus = STATUS_INVALID;

    private static final int STATUS_INVALID = -1;
    private static final int STATUS_INITIALIZED = 0;

    private BitsharesWalletWraper() {
//        mstrWalletFilePath = BitsharesApplication.getInstance().getFilesDir().getPath();
//        mstrWalletFilePath += "/wallet.json";
        msetDataObserver = Sets.newConcurrentHashSet();
        initializeWalletapi();
    }

    public static BitsharesWalletWraper getInstance() {
        return bitsharesWalletWraper;
    }

    public void registerDataObserver(BitsharesDataObserver observer) {
        msetDataObserver.add(observer);
    }

    public void unregisterDataObserver(BitsharesDataObserver observer) {
        msetDataObserver.remove(observer);
    }

    private void initializeWalletapi() {
        mWalletApi = new wallet_api(new websocket_api.BitsharesNoticeListener() {
            @Override
            public void onNoticeMessage(BitsharesNoticeMessage message) {

                if (message.listFillOrder != null) {
                    // market发生变化，需要进行对应的数据更新，查看里面对应的id，然后进行数据更新
                    for (operations.operation_type operationType : message.listFillOrder) {
                        if (operationType.nOperationType == operations.ID_FILL_LMMIT_ORDER_OPERATION) {
                            for (BitsharesDataObserver observer : msetDataObserver) {
//                                    operations.fill_order_operation operation = (operations.fill_order_operation)operationType.operationContent;
//                                    observer.onMarketFillUpdate(operation.pays.asset_id, operation.receives.asset_id);
                            }
                        }
                    }
                } else if (message.bAccountChanged) {
                    for (BitsharesDataObserver observer : msetDataObserver) {
                        observer.onAccountChanged();
                    }
                }
            }

            @Override
            public void onDisconnect() {
                for (BitsharesDataObserver observer : msetDataObserver) {
                    observer.onDisconnect();
                }
            }
        });
    }

    public void reset() {
        mWalletApi.reset();
        initializeWalletapi();
        mMapAccountId2Object.clear();
        ;
        mMapAccountId2Asset.clear();
        ;
        mMapAccountId2History.clear();
        mMapAssetId2Object.clear();
        ;
        msetDataObserver.clear();
        ;

//        File file = new File(mstrWalletFilePath);
//        file.delete();

        mnStatus = STATUS_INVALID;
    }

    public account_object get_account() {
        List<account_object> listAccount = mWalletApi.list_my_accounts();
        if (listAccount == null || listAccount.isEmpty()) {
            return null;
        }

        return listAccount.get(0);
    }


    public synchronized int build_connect() {
        if (mnStatus == STATUS_INITIALIZED) {
            return 0;
        }

        int nRet = mWalletApi.initialize();
        if (nRet != 0) {
            return nRet;
        }

        mnStatus = STATUS_INITIALIZED;
        return 0;
    }


    public List<account_object> list_my_accounts() {
        return mWalletApi.list_my_accounts();
    }


    public Map<object_id<asset_object>, asset_object> get_assets(List<object_id<asset_object>> listAssetObjectId) throws NetworkStatusException {
        Map<object_id<asset_object>, asset_object> mapId2Object = new HashMap<>();

        List<object_id<asset_object>> listRequestId = new ArrayList<>();
        for (object_id<asset_object> objectId : listAssetObjectId) {
            asset_object assetObject = mMapAssetId2Object.get(objectId);
            if (assetObject != null) {
                mapId2Object.put(objectId, assetObject);
            } else {
                listRequestId.add(objectId);
            }
        }

        if (listRequestId.isEmpty() == false) {
            List<asset_object> listAssetObject = mWalletApi.get_assets(listRequestId);
            for (asset_object assetObject : listAssetObject) {
                mapId2Object.put(assetObject.id, assetObject);
                mMapAssetId2Object.put(assetObject.id, assetObject);
            }
        }

        return mapId2Object;
    }

    public asset_object lookup_asset_symbols(String strAssetSymbol) throws NetworkStatusException {
        return mWalletApi.lookup_asset_symbols(strAssetSymbol);
    }

    public List<operation_history_object> get_account_history(object_id<account_object> accountObjectId,
                                                              object_id<operation_history_object> startId,
                                                              int nLimit) throws NetworkStatusException {
        List<operation_history_object> listHistoryObject =
                mWalletApi.get_account_history(accountObjectId, startId, nLimit);
        return listHistoryObject;
    }

    public List<asset> list_account_balance(object_id<account_object> accountObjectId,
                                            boolean bRefresh) throws NetworkStatusException {
        List<asset> listAsset = mMapAccountId2Asset.get(accountObjectId);
        if (bRefresh || listAsset == null) {
            listAsset = mWalletApi.list_account_balance(accountObjectId);
            mMapAccountId2Asset.put(accountObjectId, listAsset);
        }

        return listAsset;
    }

    public Map<object_id<account_object>, account_object> get_accounts(List<object_id<account_object>> listAccountObjectId) throws NetworkStatusException {
        Map<object_id<account_object>, account_object> mapId2Object = new HashMap<>();

        List<object_id<account_object>> listRequestId = new ArrayList<>();
        for (object_id<account_object> objectId : listAccountObjectId) {
            account_object accountObject = mMapAccountId2Object.get(objectId);
            if (accountObject != null) {
                mapId2Object.put(objectId, accountObject);
            } else {
                listRequestId.add(objectId);
            }
        }

        if (listRequestId.isEmpty() == false) {
            List<account_object> listAccountObject = mWalletApi.get_accounts(listRequestId);
            for (account_object accountObject : listAccountObject) {
                mapId2Object.put(accountObject.id, accountObject);
                mMapAccountId2Object.put(accountObject.id, accountObject);
            }
        }

        return mapId2Object;
    }

    public block_header get_block_header(int nBlockNumber) throws NetworkStatusException {
        return mWalletApi.get_block_header(nBlockNumber);
    }

    public BlockRoomHeader get_block(int nBlockNumber) throws NetworkStatusException {
        return mWalletApi.get_block(nBlockNumber);
    }

    public signed_transaction transfer(String strFrom,
                                       String strTo,
                                       String strAmount,
                                       String strAssetSymbol,
                                       String strMemo) throws NetworkStatusException {
        signed_transaction signedTransaction = mWalletApi.transfer(
                strFrom,
                strTo,
                strAmount,
                strAssetSymbol,
                strMemo
        );
        return signedTransaction;
    }

    //1.2.16371  1.15.560
    public signed_transaction forecastTransfer(String issuer, int roomType, String roomId, String strAmount, int roomPosition, String assetType) throws NetworkStatusException {

        signed_transaction signedTransaction = mWalletApi.forecast_transfer(issuer, roomType, roomId, strAmount, assetType, roomPosition);
        return signedTransaction;
    }

    public List<MarketTrade> get_trade_history(String base, String quote, Date start, Date end, int limit)
            throws NetworkStatusException {
        return mWalletApi.get_trade_history(base, quote, start, end, limit);
    }

    public MarketTicker get_ticker(String base, String quote) throws NetworkStatusException {
        return mWalletApi.get_ticker(base, quote);
    }


//    public asset calculate_sell_fee(asset_object assetToSell, asset_object assetToReceive,
//                                    double rate, double amount,
//                                    global_property_object globalPropertyObject) {
//        return mWalletApi.calculate_sell_fee(assetToSell, assetToReceive, rate, amount,
//                globalPropertyObject);
//    }


    public RoomObject getSeerRoom(String roomId) throws NetworkStatusException {
        RoomObject roomObject = mWalletApi.getRoom(roomId);
        if (roomObject == null) {
            return null;
        }
        return roomObject;
    }


    public List<List<Object>> getSeerRoomRecordes(String roomId, String asset_id, int status, String startTime, String stopTime, int limit, NetBroadcastReceiver.OrderInterFace orderInterFace) throws NetworkStatusException {
        List<List<Object>> orderListBeanList = mWalletApi.get_room_records(roomId, asset_id, status, startTime, stopTime, limit);
        if (orderListBeanList == null) {
            return null;
        } else {
            if (orderInterFace != null) {
                orderInterFace.setData(orderListBeanList);
            }
            return orderListBeanList;
        }

    }


    public List<GetHouseBean> getHouse(List<String> list) throws NetworkStatusException {
        List<GetHouseBean> getHouseBean = mWalletApi.getHouseBean(list);
        if (getHouseBean != null) {
            return getHouseBean;
        } else {
            return null;
        }
    }

    public List<asset> get_required_fees(operations.operation_type operation, String assetId) throws NetworkStatusException {

        List<asset> assets = mWalletApi.get_required_fees(operation, assetId);
        return assets;
    }

    public UserOrderInfo getUserOrder(String userID) throws NetworkStatusException {
        UserOrderInfo userInfoOrder = mWalletApi.getUserInfoOrder(userID);
        if (userInfoOrder != null) {
            return userInfoOrder;
        } else {
            return null;
        }

    }

    public account_object get_account_object(String strAccount) throws NetworkStatusException {
        return mWalletApi.get_account(strAccount);
    }

    public asset transfer_calculate_fee(String strAmount,
                                        String strAssetSymbol,
                                        String strMemo) throws NetworkStatusException {
        return mWalletApi.transfer_calculate_fee(strAmount, strAssetSymbol, strMemo);
    }

//    public String get_plain_text_message(memo_data memoData) {
//        return mWalletApi.decrypt_memo_message(memoData);
//    }

    public List<full_account_object> get_full_accounts(List<String> names, boolean subscribe)
            throws NetworkStatusException {
        return mWalletApi.get_full_accounts(names, subscribe);
    }


    public global_property_object get_global_properties() throws NetworkStatusException {
        return mWalletApi.get_global_properties();
    }


    public int set_subscribe_callback() {
        try {
            mWalletApi.set_subscribe_callback();
        } catch (NetworkStatusException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
