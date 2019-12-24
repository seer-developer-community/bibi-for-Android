package com.nyzc.gdm.currencyratio.BiBiPacakage;

import android.text.TextUtils;
import android.util.Log;

import com.google.common.primitives.UnsignedInteger;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.BlockRoomHeader;
import com.nyzc.gdm.currencyratio.Bean.GetHouseBean;
import com.nyzc.gdm.currencyratio.Bean.OrderListBean;
import com.nyzc.gdm.currencyratio.Bean.UserOrderInfo;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.block_header;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.dynamic_global_property_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.fee_schedule;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.global_property_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.price;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.signed_transaction;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.BiBiPacakage.fc.crypto.aes;
import com.nyzc.gdm.currencyratio.BiBiPacakage.fc.crypto.sha256_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.fc.crypto.sha512_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.fc.io.base_encoder;
import com.nyzc.gdm.currencyratio.BiBiPacakage.fc.io.datastream_encoder;
import com.nyzc.gdm.currencyratio.BiBiPacakage.fc.io.datastream_size_encoder;
import com.nyzc.gdm.currencyratio.BiBiPacakage.fc.io.raw_type;
import com.nyzc.gdm.currencyratio.BiBiPacakage.market.MarketTicker;
import com.nyzc.gdm.currencyratio.BiBiPacakage.market.MarketTrade;
import com.nyzc.gdm.currencyratio.BiBiPacakage.walletcommon.full_account_object;


import org.spongycastle.crypto.digests.SHA256Digest;
import org.spongycastle.crypto.digests.SHA512Digest;

import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class wallet_api {
    class wallet_object {
        sha256_object chain_id;
        List<account_object> my_accounts = new ArrayList<>();
        ByteBuffer cipher_keys;
        HashMap<object_id<account_object>, List<types.public_key_type>> extra_keys = new HashMap<>();
        String ws_server = "";
        String ws_user = "";
        String ws_password = "";

        public void update_account(account_object accountObject) {
            boolean bUpdated = false;
            for (int i = 0; i < my_accounts.size(); ++i) {
                if (my_accounts.get(i).id == accountObject.id) {
                    my_accounts.remove(i);
                    my_accounts.add(accountObject);
                    bUpdated = true;
                    break;
                }
            }

            if (bUpdated == false) {
                my_accounts.add(accountObject);
            }
        }
    }

    private websocket_api mWebsocketApi;
    private wallet_object mWalletObject;
    private boolean mbLogin = false;
    private HashMap<types.public_key_type, types.private_key_type> mHashMapPub2Priv = new HashMap<>();
    private sha512_object mCheckSum = new sha512_object();

    static class plain_keys {
        Map<types.public_key_type, String> keys;
        sha512_object checksum;

        public void write_to_encoder(base_encoder encoder) {
            raw_type rawType = new raw_type();

            rawType.pack(encoder, UnsignedInteger.fromIntBits(keys.size()));
            for (Map.Entry<types.public_key_type, String> entry : keys.entrySet()) {
                encoder.write(entry.getKey().key_data);

                byte[] byteValue = entry.getValue().getBytes();
                rawType.pack(encoder, UnsignedInteger.fromIntBits(byteValue.length));
                encoder.write(byteValue);
            }
            encoder.write(checksum.hash);
        }

        public static plain_keys from_input_stream(InputStream inputStream) {
            plain_keys keysResult = new plain_keys();
            keysResult.keys = new HashMap<>();
            keysResult.checksum = new sha512_object();

            raw_type rawType = new raw_type();
            UnsignedInteger size = rawType.unpack(inputStream);
            try {
                for (int i = 0; i < size.longValue(); ++i) {
                    types.public_key_type publicKeyType = new types.public_key_type();
                    inputStream.read(publicKeyType.key_data);

                    UnsignedInteger strSize = rawType.unpack(inputStream);
                    byte[] byteBuffer = new byte[strSize.intValue()];
                    inputStream.read(byteBuffer);

                    String strPrivateKey = new String(byteBuffer);

                    keysResult.keys.put(publicKeyType, strPrivateKey);
                }

                inputStream.read(keysResult.checksum.hash);
            } catch (IOException e) {
                e.printStackTrace();
            }

            return keysResult;
        }


    }

    public wallet_api(websocket_api.BitsharesNoticeListener listener) {
        mWebsocketApi = new websocket_api(listener);
    }

    public int initialize() {
        int nRet = mWebsocketApi.connect();
        if (nRet == 0) {
            sha256_object sha256Object = null;
            try {
                sha256Object = mWebsocketApi.get_chain_id();
                if (mWalletObject == null) {
                    mWalletObject = new wallet_object();
                    mWalletObject.chain_id = sha256Object;
                } else if (mWalletObject.chain_id != null &&
                        mWalletObject.chain_id.equals(sha256Object) == false) {
                    nRet = -1;
                }
            } catch (NetworkStatusException e) {
                e.printStackTrace();
                nRet = -1;
            }
        }
        return nRet;
    }

    public int reset() {
        mWebsocketApi.close();

        mWalletObject = null;
        mbLogin = false;
        mHashMapPub2Priv.clear();
        ;
        mCheckSum = new sha512_object();

        return 0;
    }


    private void encrypt_keys() {
        plain_keys data = new plain_keys();
        data.keys = new HashMap<>();
        for (Map.Entry<types.public_key_type, types.private_key_type> entry : mHashMapPub2Priv.entrySet()) {
            data.keys.put(entry.getKey(), entry.getValue().toString());
        }
        data.checksum = mCheckSum;
        datastream_size_encoder sizeEncoder = new datastream_size_encoder();
        data.write_to_encoder(sizeEncoder);
        datastream_encoder encoder = new datastream_encoder(sizeEncoder.getSize());
        data.write_to_encoder(encoder);

        byte[] byteKey = new byte[32];
        System.arraycopy(mCheckSum.hash, 0, byteKey, 0, byteKey.length);
        byte[] ivBytes = new byte[16];
        System.arraycopy(mCheckSum.hash, 32, ivBytes, 0, ivBytes.length);

        ByteBuffer byteResult = aes.encrypt(byteKey, ivBytes, encoder.getData());
        mWalletObject.cipher_keys = byteResult;

        return;

    }


    public List<account_object> list_my_accounts() {
        List<account_object> accountObjectList = new ArrayList<>();
        if (mWalletObject != null) {
            accountObjectList.addAll(mWalletObject.my_accounts);
        }
        return accountObjectList;
    }

    public account_object get_account(String strAccountNameOrId) throws NetworkStatusException {
        // 判定这类型
        object_id<account_object> accountObjectId = object_id.create_from_string(strAccountNameOrId);

        List<account_object> listAccountObject = null;
        if (accountObjectId == null) {
            listAccountObject = lookup_account_names(strAccountNameOrId);
        } else {
            List<object_id<account_object>> listAccountObjectId = new ArrayList<>();
            listAccountObjectId.add(accountObjectId);
            listAccountObject = mWebsocketApi.get_accounts(listAccountObjectId);
        }
        if (listAccountObject.isEmpty()) {
            return null;
        }
        return listAccountObject.get(0);
    }

    public RoomObject getRoom(String roomId) throws NetworkStatusException {
        RoomObject roomObject = null;
        object_id<RoomObject> roomObjectId = object_id.create_from_string(roomId);
        if (roomObjectId == null) {
            return null;
        } else {
            roomObject = mWebsocketApi.get_room(roomObjectId);
        }
        return roomObject;
    }

    public List<List<Object>>  get_room_records(String roomId, String asset_id, int status, String startTime,String stopTime, int limit) throws NetworkStatusException {
        List<List<Object>> list = new ArrayList<>();
        list = mWebsocketApi.get_room_records(roomId, asset_id, status, startTime,stopTime, limit);
        if (list != null) {
            return list;
        } else {
            return null;
        }

    }

    public List<GetHouseBean> getHouseBean(List<String> listHouseId) throws NetworkStatusException {
        List<GetHouseBean> getHouseBean = null;
        getHouseBean = mWebsocketApi.getHouseBean(listHouseId);
        if (getHouseBean == null) {
            return null;
        }
        return getHouseBean;
    }

    public UserOrderInfo getUserInfoOrder(String userID) throws NetworkStatusException {
        UserOrderInfo getUser = mWebsocketApi.getUserOrderInfo(userID);
        if (getUser != null) {
            return getUser;
        } else {
            return null;
        }

    }

    public List<account_object> get_accounts(List<object_id<account_object>> listAccountObjectId) throws NetworkStatusException {
        return mWebsocketApi.get_accounts(listAccountObjectId);
    }
//    public asset calculate_sell_fee(asset_object assetToSell, asset_object assetToReceive,
//                                    double rate, double amount,
//                                    global_property_object globalPropertyObject) {
//        return calculate_sell_asset_fee(Double.toString(amount), assetToSell,
//                Double.toString(rate * amount), assetToReceive, globalPropertyObject);
//    }


    public List<MarketTrade> get_trade_history(String base, String quote, Date start, Date end, int limit)
            throws NetworkStatusException {
        return mWebsocketApi.get_trade_history(base, quote, start, end, limit);
    }

    public List<account_object> lookup_account_names(String strAccountName) throws NetworkStatusException {
        return mWebsocketApi.lookup_account_names(strAccountName);
    }

    public List<asset> list_account_balance(object_id<account_object> accountId) throws NetworkStatusException {
        return mWebsocketApi.list_account_balances(accountId);
    }

    public List<operation_history_object> get_account_history(object_id<account_object> accountId,
                                                              object_id<operation_history_object> startId,
                                                              int nLimit) throws NetworkStatusException {
        return mWebsocketApi.get_account_history(accountId, startId, nLimit);
    }

    public List<asset_object> list_assets(String strLowerBound, int nLimit) throws NetworkStatusException {
        return mWebsocketApi.list_assets(strLowerBound, nLimit);
    }

    public List<asset_object> get_assets(List<object_id<asset_object>> listAssetObjectId) throws NetworkStatusException {
        return mWebsocketApi.get_assets(listAssetObjectId);
    }

    public block_header get_block_header(int nBlockNumber) throws NetworkStatusException {
        return mWebsocketApi.get_block_header(nBlockNumber);
    }

    public BlockRoomHeader get_block(int nBlockNumber) throws NetworkStatusException {
        return mWebsocketApi.get_block(nBlockNumber);
    }

    public asset_object lookup_asset_symbols(String strAssetSymbol) throws NetworkStatusException {
        return mWebsocketApi.lookup_asset_symbols(strAssetSymbol);
    }


    public asset transfer_calculate_fee(String strAmount,
                                        String strAssetSymbol,
                                        String strMemo) throws NetworkStatusException {
        object_id<asset_object> assetObjectId = object_id.create_from_string(strAssetSymbol);
        asset_object assetObject = null;
        if (assetObjectId == null) {
            assetObject = lookup_asset_symbols(strAssetSymbol);
        } else {
            List<object_id<asset_object>> listAssetObjectId = new ArrayList<>();
            listAssetObjectId.add(assetObjectId);
            assetObject = get_assets(listAssetObjectId).get(0);
        }

        operations.transfer_operation transferOperation = new operations.transfer_operation();
        transferOperation.from = new object_id<account_object>(accountObjectFrom.id.instance, account_object.class);//accountObjectFrom.id;
        transferOperation.to = new object_id<account_object>(accountObjectTo.id.instance, account_object.class);
        transferOperation.amount = assetObject.amount_from_string(strAmount);
        transferOperation.extensions = new HashSet<>();
        /*if (TextUtils.isEmpty(strMemo) == false) {

        }*/

        operations.operation_type operationType = new operations.operation_type();
        operationType.nOperationType = 0;
        operationType.operationContent = transferOperation;
        signed_transaction tx = new signed_transaction();
        tx.operations = new ArrayList<>();
        tx.operations.add(operationType);
        tx.extensions = new HashSet<>();
        set_operation_fees(tx, get_global_properties().parameters.current_fees);

        return transferOperation.fee;
    }

    account_object accountObjectFrom;
    account_object accountObjectTo;
    types.private_key_type privateKeyType;

    public signed_transaction transfer(String strFrom,
                                       String strTo,
                                       String strAmount,
                                       String strAssetSymbol,
                                       String strMemo) throws NetworkStatusException {
        object_id<asset_object> assetObjectId = object_id.create_from_string(strAssetSymbol);
        asset_object assetObject = null;
        if (assetObjectId == null) {
            assetObject = lookup_asset_symbols(strAssetSymbol);

        } else {
            List<object_id<asset_object>> listAssetObjectId = new ArrayList<>();
            listAssetObjectId.add(assetObjectId);
            assetObject = get_assets(listAssetObjectId).get(0);
        }
        accountObjectFrom = get_account(strFrom);
        accountObjectTo = get_account(strTo);
        if (accountObjectTo == null) {
            throw new NetworkStatusException("failed to get account object");
        }
        operations.transfer_operation transferOperation = new operations.transfer_operation();

        transferOperation.from = accountObjectFrom.id;
        transferOperation.to = accountObjectTo.id;
        transferOperation.amount = assetObject.amount_from_string(strAmount);
        transferOperation.extensions = new HashSet<>();

        if (TextUtils.isEmpty(strMemo) == false) {
            types.private_key_type privateKeyTypes = new types.private_key_type(MyApp.localWalletUser.getLocalActivePrivateKey());
            public_key publicKey = privateKeyTypes.getPrivateKey().get_public_key();
            types.public_key_type publicKeyType = new types.public_key_type(publicKey);
            mHashMapPub2Priv.put(publicKeyType, privateKeyTypes);
            privateKeyType = mHashMapPub2Priv.get(publicKeyType);
            transferOperation.memo = new memo_data();
            transferOperation.memo.from = accountObjectFrom.options.memo_key;
            transferOperation.memo.to = accountObjectTo.options.memo_key;
//            types.private_key_type privateKeyType = mHashMapPub2Priv.get(accountObjectFrom.options.memo_key);
            if (privateKeyType == null) {
                // // TODO: 07/09/2017 获取失败的问题
                throw new NetworkStatusException("failed to get private key");
            }
            transferOperation.memo.set_message(
                    privateKeyType.getPrivateKey(),
                    accountObjectTo.options.memo_key.getPublicKey(),
                    strMemo,
                    0
            );
            transferOperation.memo.get_message(
                    privateKeyType.getPrivateKey(),
                    accountObjectTo.options.memo_key.getPublicKey()
            );
        }
        operations.operation_type operationType = new operations.operation_type();
        operationType.nOperationType = operations.ID_TRANSER_OPERATION;
        operationType.operationContent = transferOperation;
        signed_transaction tx = new signed_transaction();
        tx.operations = new ArrayList<>();
        tx.operations.add(operationType);
        tx.extensions = new HashSet<>();
        List<asset> assetss = get_required_fees(operationType, strAssetSymbol);
        transferOperation.set_fee(assetss.get(0));
        return sign_transaction(tx);
    }

    public signed_transaction forecast_transfer(String issuer,
                                                int room_type,
                                                String room,
                                                String strAmount,
                                                String strAssetSymbol,
                                                int roompotion
    ) throws NetworkStatusException {
        object_id<asset_object> assetObjectId = object_id.create_from_string(strAssetSymbol);
        asset_object assetObject = null;
        if (assetObjectId == null) {
            assetObject = lookup_asset_symbols(strAssetSymbol);
        } else {
            List<object_id<asset_object>> listAssetObjectId = new ArrayList<>();
            listAssetObjectId.add(assetObjectId);
            assetObject = get_assets(listAssetObjectId).get(0);
        }
        RoomObject accountRoom = getRoom(room);
        account_object accountObjectFrom = get_account(issuer);
        operations.forecast_operation forcastOperation = new operations.forecast_operation();
        forcastOperation.issuer = accountObjectFrom.id;
        forcastOperation.amount = assetObject.amount_from_long(strAmount);
        forcastOperation.input.add(roompotion);
        forcastOperation.type = room_type;
        forcastOperation.room = accountRoom.id;
        operations.operation_type operationType = new operations.operation_type();
        operationType.nOperationType = operations.ID_SEER_ROOM_PAETICIPATE_OPERATION;
        operationType.operationContent = forcastOperation;
        signed_transaction tx = new signed_transaction();
        tx.operations = new ArrayList<>();
        tx.operations.add(operationType);
        tx.extensions = new HashSet<>();
//        set_operation_fees(tx, get_global_properties().parameters.current_fees);
        List<asset> assetss = get_required_fees(operationType, strAssetSymbol);
        forcastOperation.set_fee(assetss.get(0));
        return sign_transaction(tx);
    }

    public global_property_object get_global_properties() throws NetworkStatusException {
        return mWebsocketApi.get_global_properties();
    }

    public List<asset> get_required_fees(operations.operation_type operation, String assetId) throws NetworkStatusException {
        return mWebsocketApi.get_required_fees(operation, assetId);
    }

    public dynamic_global_property_object get_dynamic_global_properties() throws NetworkStatusException {
        return mWebsocketApi.get_dynamic_global_properties();
    }


    private signed_transaction sign_transaction(signed_transaction tx) throws NetworkStatusException {
        // // TODO: 07/09/2017 这里的set应出问题
        signed_transaction.required_authorities requiresAuthorities = tx.get_required_authorities();

        Set<object_id<account_object>> req_active_approvals = new HashSet<>();
        req_active_approvals.addAll(requiresAuthorities.active);

        Set<object_id<account_object>> req_owner_approvals = new HashSet<>();
        req_owner_approvals.addAll(requiresAuthorities.owner);

        for (authority authorityObject : requiresAuthorities.other) {
            for (object_id<account_object> accountObjectId : authorityObject.account_auths.keySet()) {
                req_active_approvals.add(accountObjectId);
            }
        }
        Set<object_id<account_object>> accountObjectAll = new HashSet<>();
        accountObjectAll.addAll(req_active_approvals);
        accountObjectAll.addAll(req_owner_approvals);

        List<object_id<account_object>> listAccountObjectId = new ArrayList<>();
        listAccountObjectId.addAll(accountObjectAll);

        List<account_object> listAccountObject = get_accounts(listAccountObjectId);
        HashMap<object_id<account_object>, account_object> hashMapIdToObject = new HashMap<>();

        for (account_object accountObject : listAccountObject) {
            hashMapIdToObject.put(accountObject.id, accountObject);
        }
        HashSet<types.public_key_type> approving_key_set = new HashSet<>();
        for (object_id<account_object> accountObjectId : req_active_approvals) {
            account_object accountObject = hashMapIdToObject.get(accountObjectId);
            approving_key_set.addAll(accountObject.active.get_keys());
        }
        for (object_id<account_object> accountObjectId : req_owner_approvals) {
            account_object accountObject = hashMapIdToObject.get(accountObjectId);
            approving_key_set.addAll(accountObject.owner.get_keys());
        }
        for (authority authorityObject : requiresAuthorities.other) {
            for (types.public_key_type publicKeyType : authorityObject.get_keys()) {
                approving_key_set.add(publicKeyType);
            }
        }
        // // TODO: 07/09/2017 被简化了
        dynamic_global_property_object dynamicGlobalPropertyObject = get_dynamic_global_properties();
//        tx.set_reference_block(dynamicGlobalPropertyObject.head_block_id);
        tx.set_reference_block(dynamicGlobalPropertyObject.head_block_id);
        Date dateObject = dynamicGlobalPropertyObject.time;
        Calendar calender = Calendar.getInstance();
        calender.setTime(dateObject);
        calender.add(Calendar.SECOND, 30);
        dateObject = calender.getTime();
        tx.set_expiration(dateObject);
        types.private_key_type privateKeyTypes = new types.private_key_type(MyApp.localWalletUser.getLocalActivePrivateKey());
        public_key publicKey = privateKeyTypes.getPrivateKey().get_public_key();
        types.public_key_type publicKeyType = new types.public_key_type(publicKey);
        mHashMapPub2Priv.put(publicKeyType, privateKeyTypes);
        privateKeyType = mHashMapPub2Priv.get(publicKeyType);
        if (privateKeyType != null) {
            tx.sign(privateKeyType, mWalletObject.chain_id);
        }
        // 发出tx，进行广播，这里也涉及到序列化
        int nRet = mWebsocketApi.broadcast_transaction(tx);
        if (nRet == 0) {
            return tx;
        } else {
            return null;
        }
    }


    private void set_operation_fees(signed_transaction tx, fee_schedule feeSchedule) {
        for (operations.operation_type operationType : tx.operations) {
            feeSchedule.set_fee(operationType, price.unit_price(new object_id<asset_object>(0, asset_object.class)));
        }
    }


    private private_key derive_private_key(String strWifKey, int nSeqNumber) {
        String strData = strWifKey + " " + nSeqNumber;
        byte[] bytesBuffer = strData.getBytes();
        SHA512Digest digest = new SHA512Digest();
        digest.update(bytesBuffer, 0, bytesBuffer.length);

        byte[] out = new byte[64];
        digest.doFinal(out, 0);

        SHA256Digest digest256 = new SHA256Digest();
        byte[] outSeed = new byte[32];
        digest256.update(out, 0, out.length);
        digest.doFinal(outSeed, 0);

        return new private_key(outSeed);
    }

    private int find_first_unused_derived_key_index(private_key privateKey) {
        int first_unused_index = 0;
        int number_of_consecutive_unused_keys = 0;

        String strWifKey = new types.private_key_type(privateKey).toString();
        for (int key_index = 0; ; ++key_index) {
            private_key derivedPrivateKey = derive_private_key(strWifKey, key_index);
            types.public_key_type publicKeyType = new types.public_key_type(derivedPrivateKey.get_public_key());

            if (mHashMapPub2Priv.containsKey(publicKeyType) == false) {
                if (number_of_consecutive_unused_keys != 0) {
                    ++number_of_consecutive_unused_keys;
                    if (number_of_consecutive_unused_keys > 5)
                        return first_unused_index;
                } else {
                    first_unused_index = key_index;
                    number_of_consecutive_unused_keys = 1;
                }
            } else {
                first_unused_index = 0;
                number_of_consecutive_unused_keys = 0;
            }
        }
    }


    public MarketTicker get_ticker(String base, String quote) throws NetworkStatusException {
        return mWebsocketApi.get_ticker(base, quote);
    }


    public List<full_account_object> get_full_accounts(List<String> names, boolean subscribe)
            throws NetworkStatusException {
        return mWebsocketApi.get_full_accounts(names, subscribe);
    }


//    public void subscribe_to_market(object_id<asset_object> a, object_id<asset_object> b) throws NetworkStatusException {
//        mWebsocketApi.subscribe_to_market(a, b);
//    }

    public void set_subscribe_callback() throws NetworkStatusException {
        mWebsocketApi.set_subscribe_callback();
    }


}
