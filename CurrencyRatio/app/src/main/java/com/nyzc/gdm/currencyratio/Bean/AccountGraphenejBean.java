package com.nyzc.gdm.currencyratio.Bean;

import java.io.Serializable;

public class AccountGraphenejBean implements Serializable{


    /**
     * account : {"name":"marco2015","owner_key":"SEER8GW7C8D94z9ySvXiWA57CxoMCy6CiXQheMLKaQfFL3s1MjSe4b","active_key":"SEER7Q3bPTjnL3jYX7kjZ794TzWjnNGZqNYXr2nH4ewCCyJRy73Sqp","memo_key":"SEER7Q3bPTjnL3jYX7kjZ794TzWjnNGZqNYXr2nH4ewCCyJRy73Sqp","refcode":null,"referrer":null}
     */

    private AccountBean account;

    public AccountBean getAccount() {
        return account;
    }

    public void setAccount(AccountBean account) {
        this.account = account;
    }

    public static class AccountBean {
        @Override
        public String toString() {
            return "AccountBean{" +
                    "name='" + name + '\'' +
                    ", owner_key='" + owner_key + '\'' +
                    ", active_key='" + active_key + '\'' +
                    ", memo_key='" + memo_key + '\'' +
                    ", refcode=" + refcode +
                    ", referrer=" + referrer +
                    '}';
        }

        /**
         * name : marco2015
         * owner_key : SEER8GW7C8D94z9ySvXiWA57CxoMCy6CiXQheMLKaQfFL3s1MjSe4b
         * active_key : SEER7Q3bPTjnL3jYX7kjZ794TzWjnNGZqNYXr2nH4ewCCyJRy73Sqp
         * memo_key : SEER7Q3bPTjnL3jYX7kjZ794TzWjnNGZqNYXr2nH4ewCCyJRy73Sqp
         * refcode : null
         * referrer : null
         */

        private String name;
        private String owner_key;
        private String active_key;
        private String memo_key;
        private Object refcode;
        private Object referrer;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getOwner_key() {
            return owner_key;
        }

        public void setOwner_key(String owner_key) {
            this.owner_key = owner_key;
        }

        public String getActive_key() {
            return active_key;
        }

        public void setActive_key(String active_key) {
            this.active_key = active_key;
        }

        public String getMemo_key() {
            return memo_key;
        }

        public void setMemo_key(String memo_key) {
            this.memo_key = memo_key;
        }

        public Object getRefcode() {
            return refcode;
        }

        public void setRefcode(Object refcode) {
            this.refcode = refcode;
        }

        public Object getReferrer() {
            return referrer;
        }

        public void setReferrer(Object referrer) {
            this.referrer = referrer;
        }
    }

    @Override
    public String toString() {
        return "AccountGraphenejBean{" +
                "account=" + account +
                '}';
    }
}
