package cy.agorise.graphenej.api;

import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.neovisionaries.ws.client.WebSocket;
import com.neovisionaries.ws.client.WebSocketFrame;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cy.agorise.graphenej.AccountOptions;
import cy.agorise.graphenej.Authority;
import cy.agorise.graphenej.Bean.RoomIDBean;
import cy.agorise.graphenej.Bean.RoomIDParamBean;
import cy.agorise.graphenej.Bean.RoomParamBean;
import cy.agorise.graphenej.interfaces.ResultJson;
import cy.agorise.graphenej.interfaces.WitnessResponseListener;
import cy.agorise.graphenej.models.AccountProperties;
import cy.agorise.graphenej.models.WitnessResponse;

public class GetHousePlatform extends BaseGrapheneHandler {

    private String roomid;

    private WitnessResponseListener mListener;
    private boolean mOneTime;
    private List<List<String>> list = new ArrayList<>();
    RoomParamBean roomParamBean;
    ResultJson resultJson;


    public GetHousePlatform(List<List<String>> roomIds, boolean oneTime, WitnessResponseListener listener, ResultJson resultJson) {
        super(listener);
        this.list = roomIds;
        this.mOneTime = oneTime;
        this.mListener = listener;
        this.resultJson = resultJson;
        roomParamBean = new RoomParamBean();

    }

    @Override
    public void onConnected(WebSocket websocket, Map<String, List<String>> headers) throws Exception {
        roomParamBean.setParams(list);
        roomParamBean.setMethod("get_houses");
        String json = new Gson().toJson(roomParamBean);
        Log.e("roomIDData", json);
        websocket.sendText(json);
    }


    @Override
    public void onTextFrame(WebSocket websocket, WebSocketFrame frame) throws Exception {

        String response = frame.getPayloadText();
        if (response != null) {
            resultJson.OnResuletJson(response.toString());

        }
//        GsonBuilder builder = new GsonBuilder();
//        Type GetAccountByAddressResponse = new TypeToken<WitnessResponse<List<AccountProperties>>>() {
//        }.getType();
//        builder.registerTypeAdapter(Authority.class, new Authority.AuthorityDeserializer());
//        builder.registerTypeAdapter(AccountOptions.class, new AccountOptions.AccountOptionsDeserializer());
//        WitnessResponse<List<AccountProperties>> witnessResponse = builder.create().fromJson(response, GetAccountByAddressResponse);
//        if (witnessResponse.error != null) {
//            this.mListener.onError(witnessResponse.error);
//        } else {
//            this.mListener.onSuccess(witnessResponse);
//        }
        if (mOneTime) {
            websocket.disconnect();
        }
    }
}
