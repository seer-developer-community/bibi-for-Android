package com.nyzc.gdm.currencyratio.BiBiPacakage;

import com.google.common.primitives.UnsignedInteger;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.global_config_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.fc.io.base_encoder;
import com.nyzc.gdm.currencyratio.BiBiPacakage.fc.io.raw_type;


import java.io.Serializable;
import java.lang.reflect.Type;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import static com.nyzc.gdm.currencyratio.BiBiPacakage.config.GRAPHENE_BLOCKCHAIN_PRECISION;

public class operations implements Serializable{
    public static final int ID_TRANSER_OPERATION = 0;
    public static final int ID_CREATE_LIMIT_ORDER_OPERATION = 1;
    public static final int ID_CANCEL_LMMIT_ORDER_OPERATION = 2;
    public static final int ID_UPDATE_LMMIT_ORDER_OPERATION = 3;
    public static final int ID_FILL_LMMIT_ORDER_OPERATION = 4;
    public static final int ID_CREATE_ACCOUNT_OPERATION = 5;
    public static final int ID_SEER_ROOM_PAETICIPATE_OPERATION = 50;
    public static operation_id_map operations_map = new operation_id_map();

    public static class operation_id_map implements Serializable{
        private HashMap<Integer, Type> mHashId2Operation = new HashMap<>();
        private HashMap<Integer, Type> mHashId2OperationFee = new HashMap<>();

        public operation_id_map() {

            mHashId2Operation.put(ID_TRANSER_OPERATION, transfer_operation.class);
            mHashId2Operation.put(ID_SEER_ROOM_PAETICIPATE_OPERATION, forecast_operation.class);
//            mHashId2Operation.put(ID_CREATE_LIMIT_ORDER_OPERATION, limit_order_create_operation.class);
//            mHashId2Operation.put(ID_CANCEL_LMMIT_ORDER_OPERATION, limit_order_cancel_operation.class);
//            mHashId2Operation.put(ID_UPDATE_LMMIT_ORDER_OPERATION, call_order_update_operation.class);
//            mHashId2Operation.put(ID_FILL_LMMIT_ORDER_OPERATION, fill_order_operation.class);
//            mHashId2Operation.put(ID_CREATE_ACCOUNT_OPERATION, account_create_operation.class);

            mHashId2OperationFee.put(ID_TRANSER_OPERATION, transfer_operation.fee_parameters_type.class);
//            mHashId2OperationFee.put(ID_CREATE_LIMIT_ORDER_OPERATION, limit_order_create_operation.fee_parameters_type.class);
//            mHashId2OperationFee.put(ID_CANCEL_LMMIT_ORDER_OPERATION, limit_order_cancel_operation.fee_parameters_type.class);
//            mHashId2OperationFee.put(ID_UPDATE_LMMIT_ORDER_OPERATION, call_order_update_operation.fee_parameters_type.class);
//            mHashId2OperationFee.put(ID_FILL_LMMIT_ORDER_OPERATION, fill_order_operation.fee_parameters_type.class);
//            mHashId2OperationFee.put(ID_CREATE_ACCOUNT_OPERATION, account_create_operation.fee_parameters_type.class);
            mHashId2OperationFee.put(ID_SEER_ROOM_PAETICIPATE_OPERATION, forecast_operation.fee_parameters_type.class);
        }

        public Type getOperationObjectById(int nId) {
            return mHashId2Operation.get(nId);
        }

        public Type getOperationFeeObjectById(int nId) {
            return mHashId2OperationFee.get(nId);
        }
    }

    public static class operation_type implements Serializable{
        public int nOperationType;
        public Object operationContent;

        public static class operation_type_deserializer implements JsonDeserializer<operation_type> {
            @Override
            public operation_type deserialize(JsonElement json,
                                              Type typeOfT,
                                              JsonDeserializationContext context) throws JsonParseException {
                operation_type operationType = new operation_type();
                JsonArray jsonArray = json.getAsJsonArray();

                operationType.nOperationType = jsonArray.get(0).getAsInt();
                Type type = operations_map.getOperationObjectById(operationType.nOperationType);


                if (type != null) {
                    operationType.operationContent = context.deserialize(jsonArray.get(1), type);
                } else {
                    operationType.operationContent = context.deserialize(jsonArray.get(1), Object.class);
                }

                return operationType;
            }
        }

        public static class operation_type_serializer implements JsonSerializer<operation_type>  {

            @Override
            public JsonElement serialize(operation_type src, Type typeOfSrc, JsonSerializationContext context) {
                JsonArray jsonArray = new JsonArray();
                jsonArray.add(src.nOperationType);
                Type type = operations_map.getOperationObjectById(src.nOperationType);

                assert (type != null);
                jsonArray.add(context.serialize(src.operationContent, type));

                return jsonArray;
            }
        }
    }

    ;

    public interface base_operation {
        List<authority> get_required_authorities();

        List<object_id<account_object>> get_required_active_authorities();

        List<object_id<account_object>> get_required_owner_authorities();

        void write_to_encoder(base_encoder baseEncoder);

        long calculate_fee(Object objectFeeParameter);

        void set_fee(asset fee);

        object_id<account_object> fee_payer();

        List<object_id<account_object>> get_account_id_list();

        List<object_id<asset_object>> get_asset_id_list();
    }


    public static class forecast_operation implements base_operation,Serializable {

        public static class fee_parameters_type implements Serializable{
            long fee = 50 * GRAPHENE_BLOCKCHAIN_PRECISION;
            long price_per_kbyte = 10 * GRAPHENE_BLOCKCHAIN_PRECISION; // only required for large memos.
        }

        public asset fee;
        public object_id<account_object> issuer;
        public object_id<RoomObject> room;
        public int type;
        public List<Integer> input = new ArrayList<>();
        public List<Set<Integer>> input1 = new ArrayList<>();
        public List<List<Integer>> input2 = new ArrayList<>();
        public long amount;
//        public Set<types.void_t> extensions;

        @Override
        public List<authority> get_required_authorities() {
            return new ArrayList<>();
        }

        @Override
        public List<object_id<account_object>> get_required_active_authorities() {
            List<object_id<account_object>> activeList = new ArrayList<>();
            activeList.add(fee_payer());
            return activeList;
        }

        @Override
        public List<object_id<account_object>> get_required_owner_authorities() {
            return new ArrayList<>();
        }

        @Override
        public void write_to_encoder(base_encoder baseEncoder) {
            raw_type rawObject = new raw_type();
            baseEncoder.write(rawObject.get_byte_array(fee.amount));
            rawObject.pack(baseEncoder, UnsignedInteger.fromIntBits(fee.asset_id.get_instance()));
            rawObject.pack(baseEncoder, UnsignedInteger.fromIntBits(issuer.get_instance()));
            rawObject.pack(baseEncoder, UnsignedInteger.fromIntBits(room.get_instance()));
            rawObject.packType(baseEncoder, type);
            rawObject.pack(baseEncoder,UnsignedInteger.fromIntBits(input.size()));
            rawObject.packInput(baseEncoder, UnsignedInteger.fromIntBits(input.size()), input);
            rawObject.pack(baseEncoder,UnsignedInteger.fromIntBits(input1.size()));
            rawObject.packInput1(baseEncoder, UnsignedInteger.fromIntBits(input1.size()), input1);
            rawObject.pack(baseEncoder,UnsignedInteger.fromIntBits(input2.size()));
            rawObject.packInput2(baseEncoder, UnsignedInteger.fromIntBits(input2.size()), input2);
            baseEncoder.write(rawObject.get_byte_array(amount));

        }


        @Override
        public long calculate_fee(Object objectFeeParameter) {
            assert (fee_parameters_type.class.isInstance(objectFeeParameter));
            fee_parameters_type feeParametersType = (fee_parameters_type) objectFeeParameter;
            return feeParametersType.fee;
        }

        @Override
        public void set_fee(asset assetFee) {
            fee = assetFee;
        }

        @Override
        public object_id<account_object> fee_payer() {
            return issuer;
        }

        @Override
        public List<object_id<account_object>> get_account_id_list() {
            List<object_id<account_object>> listAccountId = new ArrayList<>();
            listAccountId.add(issuer);
            return listAccountId;
        }

        @Override
        public List<object_id<asset_object>> get_asset_id_list() {
            List<object_id<asset_object>> listAssetId = new ArrayList<>();
            listAssetId.add(fee.asset_id);
            return listAssetId;
        }

//        public long calculate_fee(fee_parameters_type feeParametersType) {
//            long lFee = feeParametersType.fee;
//            if (memo != null) {
//                // 计算数据价格
//                Gson gson = global_config_object.getInstance().getGsonBuilder().create();
//                BigInteger nSize = BigInteger.valueOf(gson.toJson(memo).length());
//                BigInteger nPrice = BigInteger.valueOf(feeParametersType.price_per_kbyte);
//                BigInteger nKbyte = BigInteger.valueOf(1024);
//                BigInteger nAmount = nPrice.multiply(nSize).divide(nKbyte);
//
//                lFee += nAmount.longValue();
//            }
//
//            return 0;
//        }
    }

    public static class transfer_operation implements base_operation ,Serializable{
        public static class fee_parameters_type {
            long fee = 20 * GRAPHENE_BLOCKCHAIN_PRECISION;
            long price_per_kbyte = 10 * GRAPHENE_BLOCKCHAIN_PRECISION; /// only required for large memos.
        }

        ;

        public asset fee;
        public object_id<account_object> from;
        public object_id<account_object> to;
        public asset amount;
        public memo_data memo;
        //public extensions_type   extensions;
        public Set<types.void_t> extensions;

        @Override
        public List<authority> get_required_authorities() {
            return new ArrayList<>();
        }

        @Override
        public List<object_id<account_object>> get_required_active_authorities() {
            List<object_id<account_object>> activeList = new ArrayList<>();
            activeList.add(fee_payer());
            return activeList;
        }

        @Override
        public List<object_id<account_object>> get_required_owner_authorities() {
            return new ArrayList<>();
        }

        @Override
        public void write_to_encoder(base_encoder baseEncoder) {
            raw_type rawObject = new raw_type();
            baseEncoder.write(rawObject.get_byte_array(fee.amount));
            //baseEncoder.write(rawObject.get_byte_array(fee.asset_id.get_instance()));
            rawObject.pack(baseEncoder, UnsignedInteger.fromIntBits(fee.asset_id.get_instance()));
            //baseEncoder.write(rawObject.get_byte_array(from.get_instance()));
            rawObject.pack(baseEncoder, UnsignedInteger.fromIntBits(from.get_instance()));
            //baseEncoder.write(rawObject.get_byte_array(to.get_instance()));
            rawObject.pack(baseEncoder, UnsignedInteger.fromIntBits(to.get_instance()));
            baseEncoder.write(rawObject.get_byte_array(amount.amount));
            //baseEncoder.write(rawObject.get_byte_array(amount.asset_id.get_instance()));
            rawObject.pack(baseEncoder, UnsignedInteger.fromIntBits(amount.asset_id.get_instance()));
            baseEncoder.write(rawObject.get_byte(memo != null));
            if (memo != null) {
                baseEncoder.write(memo.from.key_data);
                baseEncoder.write(memo.to.key_data);
                baseEncoder.write(rawObject.get_byte_array(memo.nonce));
                byte[] byteMessage = memo.message.array();
                rawObject.pack(baseEncoder, UnsignedInteger.fromIntBits(byteMessage.length));
                baseEncoder.write(byteMessage);
            }
            //baseEncoder.write(rawObject.get_byte_array(extensions.size()));
            rawObject.pack(baseEncoder, UnsignedInteger.fromIntBits(extensions.size()));

        }

        @Override
        public long calculate_fee(Object objectFeeParameter) {
            assert (fee_parameters_type.class.isInstance(objectFeeParameter));
            fee_parameters_type feeParametersType = (fee_parameters_type) objectFeeParameter;

            return calculate_fee(feeParametersType);
        }

        @Override
        public void set_fee(asset assetFee) {
            fee = assetFee;
        }

        @Override
        public object_id<account_object> fee_payer() {
            return from;
        }

        @Override
        public List<object_id<account_object>> get_account_id_list() {
            List<object_id<account_object>> listAccountId = new ArrayList<>();
            listAccountId.add(from);
            listAccountId.add(to);
            return listAccountId;
        }

        @Override
        public List<object_id<asset_object>> get_asset_id_list() {
            List<object_id<asset_object>> listAssetId = new ArrayList<>();
            listAssetId.add(amount.asset_id);
            return listAssetId;
        }

        public long calculate_fee(fee_parameters_type feeParametersType) {
            long lFee = feeParametersType.fee;
            if (memo != null) {
                // 计算数据价格
                Gson gson = global_config_object.getInstance().getGsonBuilder().create();
                BigInteger nSize = BigInteger.valueOf(gson.toJson(memo).length());
                BigInteger nPrice = BigInteger.valueOf(feeParametersType.price_per_kbyte);
                BigInteger nKbyte = BigInteger.valueOf(1024);
                BigInteger nAmount = nPrice.multiply(nSize).divide(nKbyte);

                lFee += nAmount.longValue();
            }

            return lFee;
        }
    }





}
