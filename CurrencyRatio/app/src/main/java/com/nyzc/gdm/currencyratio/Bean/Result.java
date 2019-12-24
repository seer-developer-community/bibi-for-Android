package com.nyzc.gdm.currencyratio.Bean;

import java.io.Serializable;
import java.util.List;

public class Result implements Serializable {


    /**
     * id : 0
     * jsonrpc : 2.0
     * result : [{"id":"1.2.13896","membership_expiration_date":"1970-01-01T00:00:00","registrar":"1.2.13","referrer":"1.2.13","lifetime_referrer":"1.2.13","network_fee_percentage":6000,"lifetime_referrer_fee_percentage":0,"referrer_rewards_percentage":0,"name":"zhaolei123","owner":{"weight_threshold":1,"account_auths":[],"key_auths":[["SEER8eb8m7Rvsmv3dm6tPzqo79kzYeX21UDS5DTj9kwHLmFHk9K29g",1]],"address_auths":[]},"active":{"weight_threshold":1,"account_auths":[],"key_auths":[["SEER6oQPeq3vztVHFN7F3swS6BXC9a9ey5y5jdUzLRbMgNLneaBJRe",1]],"address_auths":[]},"options":{"memo_key":"SEER6oQPeq3vztVHFN7F3swS6BXC9a9ey5y5jdUzLRbMgNLneaBJRe","voting_account":"1.2.5","num_committee":0,"num_authenticator":0,"num_supervisor":0,"votes":[],"extensions":[]},"statistics":"2.5.13896","whitelisting_accounts":[],"blacklisting_accounts":[],"whitelisted_accounts":[],"blacklisted_accounts":[],"owner_special_authority":[0,{}],"active_special_authority":[0,{}],"top_n_control_flags":0,"country":0,"status":0,"authentications":[]}]
     */

    private int id;
    private String jsonrpc;
    private List<ResultBean> result;

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

    public List<ResultBean> getResult() {
        return result;
    }

    public void setResult(List<ResultBean> result) {
        this.result = result;
    }

    public static class ResultBean {
        /**
         * id : 1.2.13896
         * membership_expiration_date : 1970-01-01T00:00:00
         * registrar : 1.2.13
         * referrer : 1.2.13
         * lifetime_referrer : 1.2.13
         * network_fee_percentage : 6000
         * lifetime_referrer_fee_percentage : 0
         * referrer_rewards_percentage : 0
         * name : zhaolei123
         * owner : {"weight_threshold":1,"account_auths":[],"key_auths":[["SEER8eb8m7Rvsmv3dm6tPzqo79kzYeX21UDS5DTj9kwHLmFHk9K29g",1]],"address_auths":[]}
         * active : {"weight_threshold":1,"account_auths":[],"key_auths":[["SEER6oQPeq3vztVHFN7F3swS6BXC9a9ey5y5jdUzLRbMgNLneaBJRe",1]],"address_auths":[]}
         * options : {"memo_key":"SEER6oQPeq3vztVHFN7F3swS6BXC9a9ey5y5jdUzLRbMgNLneaBJRe","voting_account":"1.2.5","num_committee":0,"num_authenticator":0,"num_supervisor":0,"votes":[],"extensions":[]}
         * statistics : 2.5.13896
         * whitelisting_accounts : []
         * blacklisting_accounts : []
         * whitelisted_accounts : []
         * blacklisted_accounts : []
         * owner_special_authority : [0,{}]
         * active_special_authority : [0,{}]
         * top_n_control_flags : 0
         * country : 0
         * status : 0
         * authentications : []
         */

        private String id;
        private String membership_expiration_date;
        private String registrar;
        private String referrer;
        private String lifetime_referrer;
        private int network_fee_percentage;
        private int lifetime_referrer_fee_percentage;
        private int referrer_rewards_percentage;
        private String name;
        private OwnerBean owner;
        private ActiveBean active;
        private OptionsBean options;
        private String statistics;
        private int top_n_control_flags;
        private int country;
        private int status;
        private List<?> whitelisting_accounts;
        private List<?> blacklisting_accounts;
        private List<?> whitelisted_accounts;
        private List<?> blacklisted_accounts;
//        private List<Integer> owner_special_authority;
//        private List<Integer> active_special_authority;
        private List<?> authentications;

        public String getId() {
            return id;
        }

        public void setId(String id) {
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

        public OwnerBean getOwner() {
            return owner;
        }

        public void setOwner(OwnerBean owner) {
            this.owner = owner;
        }

        public ActiveBean getActive() {
            return active;
        }

        public void setActive(ActiveBean active) {
            this.active = active;
        }

        public OptionsBean getOptions() {
            return options;
        }

        public void setOptions(OptionsBean options) {
            this.options = options;
        }

        public String getStatistics() {
            return statistics;
        }

        public void setStatistics(String statistics) {
            this.statistics = statistics;
        }

        public int getTop_n_control_flags() {
            return top_n_control_flags;
        }

        public void setTop_n_control_flags(int top_n_control_flags) {
            this.top_n_control_flags = top_n_control_flags;
        }

        public int getCountry() {
            return country;
        }

        public void setCountry(int country) {
            this.country = country;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public List<?> getWhitelisting_accounts() {
            return whitelisting_accounts;
        }

        public void setWhitelisting_accounts(List<?> whitelisting_accounts) {
            this.whitelisting_accounts = whitelisting_accounts;
        }

        public List<?> getBlacklisting_accounts() {
            return blacklisting_accounts;
        }

        public void setBlacklisting_accounts(List<?> blacklisting_accounts) {
            this.blacklisting_accounts = blacklisting_accounts;
        }

        public List<?> getWhitelisted_accounts() {
            return whitelisted_accounts;
        }

        public void setWhitelisted_accounts(List<?> whitelisted_accounts) {
            this.whitelisted_accounts = whitelisted_accounts;
        }

        public List<?> getBlacklisted_accounts() {
            return blacklisted_accounts;
        }

        public void setBlacklisted_accounts(List<?> blacklisted_accounts) {
            this.blacklisted_accounts = blacklisted_accounts;
        }
//
//        public List<Integer> getOwner_special_authority() {
//            return owner_special_authority;
//        }
//
//        public void setOwner_special_authority(List<Integer> owner_special_authority) {
//            this.owner_special_authority = owner_special_authority;
//        }
//
//        public List<Integer> getActive_special_authority() {
//            return active_special_authority;
//        }
//
//        public void setActive_special_authority(List<Integer> active_special_authority) {
//            this.active_special_authority = active_special_authority;
//        }

        public List<?> getAuthentications() {
            return authentications;
        }

        public void setAuthentications(List<?> authentications) {
            this.authentications = authentications;
        }

        public static class OwnerBean {
            /**
             * weight_threshold : 1
             * account_auths : []
             * key_auths : [["SEER8eb8m7Rvsmv3dm6tPzqo79kzYeX21UDS5DTj9kwHLmFHk9K29g",1]]
             * address_auths : []
             */

            private int weight_threshold;
            private List<?> account_auths;
            private List<List<String>> key_auths;
            private List<?> address_auths;

            public int getWeight_threshold() {
                return weight_threshold;
            }

            public void setWeight_threshold(int weight_threshold) {
                this.weight_threshold = weight_threshold;
            }

            public List<?> getAccount_auths() {
                return account_auths;
            }

            public void setAccount_auths(List<?> account_auths) {
                this.account_auths = account_auths;
            }

            public List<List<String>> getKey_auths() {
                return key_auths;
            }

            public void setKey_auths(List<List<String>> key_auths) {
                this.key_auths = key_auths;
            }

            public List<?> getAddress_auths() {
                return address_auths;
            }

            public void setAddress_auths(List<?> address_auths) {
                this.address_auths = address_auths;
            }
        }

        public static class ActiveBean {
            /**
             * weight_threshold : 1
             * account_auths : []
             * key_auths : [["SEER6oQPeq3vztVHFN7F3swS6BXC9a9ey5y5jdUzLRbMgNLneaBJRe",1]]
             * address_auths : []
             */

            private int weight_threshold;
            private List<?> account_auths;
            private List<List<String>> key_auths;
            private List<?> address_auths;

            public int getWeight_threshold() {
                return weight_threshold;
            }

            public void setWeight_threshold(int weight_threshold) {
                this.weight_threshold = weight_threshold;
            }

            public List<?> getAccount_auths() {
                return account_auths;
            }

            public void setAccount_auths(List<?> account_auths) {
                this.account_auths = account_auths;
            }

            public List<List<String>> getKey_auths() {
                return key_auths;
            }

            public void setKey_auths(List<List<String>> key_auths) {
                this.key_auths = key_auths;
            }

            public List<?> getAddress_auths() {
                return address_auths;
            }

            public void setAddress_auths(List<?> address_auths) {
                this.address_auths = address_auths;
            }
        }

        public static class OptionsBean {
            /**
             * memo_key : SEER6oQPeq3vztVHFN7F3swS6BXC9a9ey5y5jdUzLRbMgNLneaBJRe
             * voting_account : 1.2.5
             * num_committee : 0
             * num_authenticator : 0
             * num_supervisor : 0
             * votes : []
             * extensions : []
             */

            private String memo_key;
            private String voting_account;
            private int num_committee;
            private int num_authenticator;
            private int num_supervisor;
            private List<?> votes;
            private List<?> extensions;

            public String getMemo_key() {
                return memo_key;
            }

            public void setMemo_key(String memo_key) {
                this.memo_key = memo_key;
            }

            public String getVoting_account() {
                return voting_account;
            }

            public void setVoting_account(String voting_account) {
                this.voting_account = voting_account;
            }

            public int getNum_committee() {
                return num_committee;
            }

            public void setNum_committee(int num_committee) {
                this.num_committee = num_committee;
            }

            public int getNum_authenticator() {
                return num_authenticator;
            }

            public void setNum_authenticator(int num_authenticator) {
                this.num_authenticator = num_authenticator;
            }

            public int getNum_supervisor() {
                return num_supervisor;
            }

            public void setNum_supervisor(int num_supervisor) {
                this.num_supervisor = num_supervisor;
            }

            public List<?> getVotes() {
                return votes;
            }

            public void setVotes(List<?> votes) {
                this.votes = votes;
            }

            public List<?> getExtensions() {
                return extensions;
            }

            public void setExtensions(List<?> extensions) {
                this.extensions = extensions;
            }
        }
    }
}
