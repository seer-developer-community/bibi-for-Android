package com.nyzc.gdm.currencyratio.Bean;

import java.util.List;

public class ImpotWallet {


    /**
     * id : 1
     * jsonrpc : 2.0
     * result : [["1.2.18218","1.2.18218"]]
     */

    private int id;
    private String jsonrpc;
    private List<List<String>> result;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getJsonrpc() {
        return jsonrpc;
    }

    public void setJsonrpc(String jsonrpc) {
        this.jsonrpc = jsonrpc;
    }

    public List<List<String>> getResult() {
        return result;
    }

    public void setResult(List<List<String>> result) {
        this.result = result;
    }
}
