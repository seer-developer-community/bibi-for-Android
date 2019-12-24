package com.nyzc.gdm.currencyratio.Base;

import java.io.Serializable;

public class AppLocalWalletUser implements Serializable{

    private String LocalName;
    private String LocalPwd;
    private String LocalBrainKey;
    private String LocalOwnerPublicKey;
    private String LocalOwnerPrivateKey;
    private String LocalActivePublicKey;
    private String LocalActivePrivateKey;
    private String amoutSeerMoney;
    private String amountUsdtMoney;
    private String amountPFCMoney;

    public String getAmountPFCMoney() {
        return amountPFCMoney;
    }

    public void setAmountPFCMoney(String amountPFCMoney) {
        this.amountPFCMoney = amountPFCMoney;
    }

    public String getAmoutSeerMoney() {
        return amoutSeerMoney;
    }

    public void setAmoutSeerMoney(String amoutSeerMoney) {
        this.amoutSeerMoney = amoutSeerMoney;
    }

    public String getAmountUsdtMoney() {
        return amountUsdtMoney;
    }

    public void setAmountUsdtMoney(String amountUsdtMoney) {
        this.amountUsdtMoney = amountUsdtMoney;
    }

    public String getLocalName() {
        return LocalName;
    }

    public void setLocalName(String localName) {
        LocalName = localName;
    }

    public String getLocalPwd() {
        return LocalPwd;
    }

    public void setLocalPwd(String localPwd) {
        LocalPwd = localPwd;
    }

    public String getLocalBrainKey() {
        return LocalBrainKey;
    }

    public void setLocalBrainKey(String localBrainKey) {
        LocalBrainKey = localBrainKey;
    }

    public String getLocalOwnerPublicKey() {
        return LocalOwnerPublicKey;
    }

    public void setLocalOwnerPublicKey(String localOwnerPublicKey) {
        LocalOwnerPublicKey = localOwnerPublicKey;
    }

    public String getLocalOwnerPrivateKey() {
        return LocalOwnerPrivateKey;
    }

    public void setLocalOwnerPrivateKey(String localOwnerPrivateKey) {
        LocalOwnerPrivateKey = localOwnerPrivateKey;
    }

    public String getLocalActivePublicKey() {
        return LocalActivePublicKey;
    }

    public void setLocalActivePublicKey(String localActivePublicKey) {
        LocalActivePublicKey = localActivePublicKey;
    }

    public String getLocalActivePrivateKey() {
        return LocalActivePrivateKey;
    }

    public void setLocalActivePrivateKey(String localActivePrivateKey) {
        LocalActivePrivateKey = localActivePrivateKey;
    }

    @Override
    public String toString() {
        return "AppLocalWalletUser{" +
                "LocalName='" + LocalName + '\'' +
                ", LocalPwd='" + LocalPwd + '\'' +
                ", LocalBrainKey='" + LocalBrainKey + '\'' +
                ", LocalOwnerPublicKey='" + LocalOwnerPublicKey + '\'' +
                ", LocalOwnerPrivateKey='" + LocalOwnerPrivateKey + '\'' +
                ", LocalActivePublicKey='" + LocalActivePublicKey + '\'' +
                ", LocalActivePrivateKey='" + LocalActivePrivateKey + '\'' +
                ", amoutSeerMoney='" + amoutSeerMoney + '\'' +
                ", amountUsdtMoney='" + amountUsdtMoney + '\'' +
                ", amountPFCMoney='" + amountPFCMoney + '\'' +
                '}';
    }
}
