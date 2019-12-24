package cy.agorise.graphenej.api;

import android.util.Log;

import com.google.gson.Gson;
import com.neovisionaries.ws.client.WebSocket;
import com.neovisionaries.ws.client.WebSocketFrame;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cy.agorise.graphenej.Bean.RoomBean;
import cy.agorise.graphenej.Bean.RoomIDParamBean;
import cy.agorise.graphenej.interfaces.HouseListJson;
import cy.agorise.graphenej.interfaces.ResultJson;
import cy.agorise.graphenej.interfaces.WitnessResponseListener;

public class GetHouseList extends BaseGrapheneHandler {

    List<Object> listId = new ArrayList<>();
    private WitnessResponseListener mListener;
    private boolean mOneTime;
    private String roomId;
    ResultJson resultJson;
    RoomIDParamBean roomIDParamBean;

   HouseListJson houseListJson;
    public GetHouseList(String roomId, boolean oneTime, WitnessResponseListener listener, HouseListJson houseListJson) {
        super(listener);
        this.roomId = roomId;
        this.mListener = listener;
        this.mOneTime = oneTime;
        this.resultJson = resultJson;
        roomIDParamBean=new RoomIDParamBean();
        this.houseListJson=houseListJson;
//        Log.e("roomData", jsonHouses);
    }

    @Override
    public void onConnected(WebSocket websocket, Map<String, List<String>> headers) throws Exception {
        listId.add(roomId);
        listId.add(0);
        listId.add(100);
        roomIDParamBean.setParams(listId);
        roomIDParamBean.setMethod("get_seer_room");
        String roomIDJson = new Gson().toJson(roomIDParamBean);
        websocket.sendText(roomIDJson);
    }

    @Override
    public void onTextFrame(WebSocket websocket, WebSocketFrame frame) throws Exception {
        String response = frame.getPayloadText();
        if (response != null) {
            Log.e("aaaa", response.toString());
            houseListJson.OnHouseListJson(response);
        }else{
            houseListJson.OnHouseListJson(null);
        }
        if (mOneTime) {
            websocket.disconnect();
        }
    }
}
