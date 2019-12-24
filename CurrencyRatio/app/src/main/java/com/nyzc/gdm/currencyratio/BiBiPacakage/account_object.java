package com.nyzc.gdm.currencyratio.BiBiPacakage;



import java.io.Serializable;
import java.util.List;

public class account_object implements Serializable{
    public object_id<account_object> id;
    public String membership_expiration_date;
    public String registrar;
    public String referrer;
    public String lifetime_referrer;
    public int network_fee_percentage;
    public int lifetime_referrer_fee_percentage;
    public int referrer_rewards_percentage;
    public String name;
    public authority owner;
    public authority active;
    public types.account_options options;
    public String statistics;
    public List<String> whitelisting_accounts;
    public List<String> whitelisted_accounts;
    public List<String> blacklisted_accounts;
    public List<String> blacklisting_accounts;
    public List<Object> owner_special_authority;
    public List<Object> active_special_authority;
    public Integer top_n_control_flags;

    public object_id<account_object> getId() {
        return id;
    }

    public void setId(object_id<account_object> id) {
        this.id = id;
    }

    public String getMembership_expiration_date() {
        return membership_expiration_date;
    }

    public void setMembership_expiration_date(String membership_expiration_date) {
        this.membership_expiration_date = membership_expiration_date;
    }

    public String getRegistrar() {
        return registrar;
    }

    public void setRegistrar(String registrar) {
        this.registrar = registrar;
    }

    public String getReferrer() {
        return referrer;
    }

    public void setReferrer(String referrer) {
        this.referrer = referrer;
    }

    public String getLifetime_referrer() {
        return lifetime_referrer;
    }

    public void setLifetime_referrer(String lifetime_referrer) {
        this.lifetime_referrer = lifetime_referrer;
    }

    public int getNetwork_fee_percentage() {
        return network_fee_percentage;
    }

    public void setNetwork_fee_percentage(int network_fee_percentage) {
        this.network_fee_percentage = network_fee_percentage;
    }

    public int getLifetime_referrer_fee_percentage() {
        return lifetime_referrer_fee_percentage;
    }

    public void setLifetime_referrer_fee_percentage(int lifetime_referrer_fee_percentage) {
        this.lifetime_referrer_fee_percentage = lifetime_referrer_fee_percentage;
    }

    public int getReferrer_rewards_percentage() {
        return referrer_rewards_percentage;
    }

    public void setReferrer_rewards_percentage(int referrer_rewards_percentage) {
        this.referrer_rewards_percentage = referrer_rewards_percentage;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public authority getOwner() {
        return owner;
    }

    public void setOwner(authority owner) {
        this.owner = owner;
    }

    public authority getActive() {
        return active;
    }

    public void setActive(authority active) {
        this.active = active;
    }

    public types.account_options getOptions() {
        return options;
    }

    public void setOptions(types.account_options options) {
        this.options = options;
    }

    public String getStatistics() {
        return statistics;
    }

    public void setStatistics(String statistics) {
        this.statistics = statistics;
    }

    public List<String> getWhitelisting_accounts() {
        return whitelisting_accounts;
    }

    public void setWhitelisting_accounts(List<String> whitelisting_accounts) {
        this.whitelisting_accounts = whitelisting_accounts;
    }

    public List<String> getWhitelisted_accounts() {
        return whitelisted_accounts;
    }

    public void setWhitelisted_accounts(List<String> whitelisted_accounts) {
        this.whitelisted_accounts = whitelisted_accounts;
    }

    public List<String> getBlacklisted_accounts() {
        return blacklisted_accounts;
    }

    public void setBlacklisted_accounts(List<String> blacklisted_accounts) {
        this.blacklisted_accounts = blacklisted_accounts;
    }

    public List<String> getBlacklisting_accounts() {
        return blacklisting_accounts;
    }

    public void setBlacklisting_accounts(List<String> blacklisting_accounts) {
        this.blacklisting_accounts = blacklisting_accounts;
    }

    public List<Object> getOwner_special_authority() {
        return owner_special_authority;
    }

    public void setOwner_special_authority(List<Object> owner_special_authority) {
        this.owner_special_authority = owner_special_authority;
    }

    public List<Object> getActive_special_authority() {
        return active_special_authority;
    }

    public void setActive_special_authority(List<Object> active_special_authority) {
        this.active_special_authority = active_special_authority;
    }

    public Integer getTop_n_control_flags() {
        return top_n_control_flags;
    }

    public void setTop_n_control_flags(Integer top_n_control_flags) {
        this.top_n_control_flags = top_n_control_flags;
    }

    @Override
    public String toString() {
        return "account_object{" +
                "id=" + id +
                ", membership_expiration_date='" + membership_expiration_date + '\'' +
                ", registrar='" + registrar + '\'' +
                ", referrer='" + referrer + '\'' +
                ", lifetime_referrer='" + lifetime_referrer + '\'' +
                ", network_fee_percentage=" + network_fee_percentage +
                ", lifetime_referrer_fee_percentage=" + lifetime_referrer_fee_percentage +
                ", referrer_rewards_percentage=" + referrer_rewards_percentage +
                ", name='" + name + '\'' +
                ", owner=" + owner +
                ", active=" + active +
                ", options=" + options +
                ", statistics='" + statistics + '\'' +
                ", whitelisting_accounts=" + whitelisting_accounts +
                ", whitelisted_accounts=" + whitelisted_accounts +
                ", blacklisted_accounts=" + blacklisted_accounts +
                ", blacklisting_accounts=" + blacklisting_accounts +
                ", owner_special_authority=" + owner_special_authority +
                ", active_special_authority=" + active_special_authority +
                ", top_n_control_flags=" + top_n_control_flags +
                '}';
    }
}
