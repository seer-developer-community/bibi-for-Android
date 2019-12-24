package com.nyzc.gdm.currencyratio.Bean;

import java.io.Serializable;

public class ResultBean implements Serializable {

    /**
     * lifetimeReferrerFeePercentage : 0
     * membershipExpirationDate : 0
     * networkFeePercentage : 0
     * referrerRewardsPercentage : 0
     * id : 1.2.13008
     */

    private double lifetimeReferrerFeePercentage;
    private double membershipExpirationDate;
    private double networkFeePercentage;
    private double referrerRewardsPercentage;
    private String id;

    public double getLifetimeReferrerFeePercentage() {
        return lifetimeReferrerFeePercentage;
    }

    public void setLifetimeReferrerFeePercentage(double lifetimeReferrerFeePercentage) {
        this.lifetimeReferrerFeePercentage = lifetimeReferrerFeePercentage;
    }

    public double getMembershipExpirationDate() {
        return membershipExpirationDate;
    }

    public void setMembershipExpirationDate(double membershipExpirationDate) {
        this.membershipExpirationDate = membershipExpirationDate;
    }

    public double getNetworkFeePercentage() {
        return networkFeePercentage;
    }

    public void setNetworkFeePercentage(double networkFeePercentage) {
        this.networkFeePercentage = networkFeePercentage;
    }

    public double getReferrerRewardsPercentage() {
        return referrerRewardsPercentage;
    }

    public void setReferrerRewardsPercentage(double referrerRewardsPercentage) {
        this.referrerRewardsPercentage = referrerRewardsPercentage;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "ResultBean{" +
                "lifetimeReferrerFeePercentage=" + lifetimeReferrerFeePercentage +
                ", membershipExpirationDate=" + membershipExpirationDate +
                ", networkFeePercentage=" + networkFeePercentage +
                ", referrerRewardsPercentage=" + referrerRewardsPercentage +
                ", id='" + id + '\'' +
                '}';
    }
}
