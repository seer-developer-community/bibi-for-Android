package com.nyzc.gdm.currencyratio.Utils;

public class HttpUrl {

    //正式节点(区块链)
//    public static final String Base_Url = "ws://39.105.189.224/ws";
//    public static final String Base_Url = "ws://1.3.206.78.97:8002";
    //   ws://api1.seerchain.org


    public static final String Base_Url = "ws://api2.seerchain.org/ws";

    //水龙头 注册地址 faucet.seerchain.org    测试  http://www.websocketest.com/
    public static final String connect_Graphenej = "http://f2.seerchain.org/api/v1/accounts";

//        public static final String connect_Graphenej = "https://www.seerapi.com/api/v1/accounts";


    //SEER,PFC 绑定ETH
    public static final String bindEth = "https://www.seerapi.com/api/v1/seer_eth/bind";
    //SEER,PFC查询Eth地址
    public static final String queryEth = "https://www.seerapi.com/api/v1/seer_eth/query";
    //USDT 绑定地址
    public static final String bindUsdtAddress = "https://www.seerapi.com/api/v1/seer_omni/bind";
    //USDT 查询地址
    public static final String queryUsdtAddress = "https://www.seerapi.com/api/v1/seer_omni/query";

    public static final String BanBenGengXin = "https://www.seer.best/index.php?id=226";
}