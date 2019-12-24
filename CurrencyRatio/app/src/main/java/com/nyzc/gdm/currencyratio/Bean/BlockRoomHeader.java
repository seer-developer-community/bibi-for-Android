package com.nyzc.gdm.currencyratio.Bean;

import java.io.Serializable;
import java.util.List;

public class BlockRoomHeader implements Serializable {


        private String previous;
        private String timestamp;
        private String witness;
        private String transaction_merkle_root;
        private String witness_signature;
        private List<?> extensions;
        private List<TransactionsBean> transactions;
        private List<String> signatures;
        private List<List<Object>> operation_results;

    public List<String> getSignatures() {
        return signatures;
    }

    public void setSignatures(List<String> signatures) {
        this.signatures = signatures;
    }

    public List<List<Object>> getOperation_results() {
        return operation_results;
    }

    public void setOperation_results(List<List<Object>> operation_results) {
        this.operation_results = operation_results;
    }

    public String getPrevious() {
            return previous;
        }

        public void setPrevious(String previous) {
            this.previous = previous;
        }

        public String getTimestamp() {
            return timestamp;
        }

        public void setTimestamp(String timestamp) {
            this.timestamp = timestamp;
        }

        public String getWitness() {
            return witness;
        }

        public void setWitness(String witness) {
            this.witness = witness;
        }

        public String getTransaction_merkle_root() {
            return transaction_merkle_root;
        }

        public void setTransaction_merkle_root(String transaction_merkle_root) {
            this.transaction_merkle_root = transaction_merkle_root;
        }

        public String getWitness_signature() {
            return witness_signature;
        }

        public void setWitness_signature(String witness_signature) {
            this.witness_signature = witness_signature;
        }

        public List<?> getExtensions() {
            return extensions;
        }

        public void setExtensions(List<?> extensions) {
            this.extensions = extensions;
        }

        public List<TransactionsBean> getTransactions() {
            return transactions;
        }

        public void setTransactions(List<TransactionsBean> transactions) {
            this.transactions = transactions;
        }

        public static class TransactionsBean {
            /**
             * ref_block_num : 58321
             * ref_block_prefix : 3079575698
             * expiration : 2018-11-21T05:45:57
             * operations : [[50,{"fee":{"amount":500000,"asset_id":"1.3.0"},"issuer":"1.2.14210","room":"1.15.560","type":0,"input":[0],"input1":[],"input2":[],"amount":10000000}]]
             * extensions : []
             * signatures : ["2013f7654d7ab1.3.23b1da1f1b4acf75da36d943217e5083ca6d18d68a67e2ff468ad4609a59ca5091021e169ac25754858fd50c82bddabdf2c44ddbc2c8ea5e6"]
             * operation_results : [[3,{"asset_id":"1.3.0","deltas":[["1.2.14210",-10000000]]}]]
             */

            private int ref_block_num;
            private long ref_block_prefix;
            private String expiration;
            private List<List<Object>> operations;
            private List<?> extensions;
            private List<String> signatures;


            public int getRef_block_num() {
                return ref_block_num;
            }

            public void setRef_block_num(int ref_block_num) {
                this.ref_block_num = ref_block_num;
            }

            public long getRef_block_prefix() {
                return ref_block_prefix;
            }

            public void setRef_block_prefix(long ref_block_prefix) {
                this.ref_block_prefix = ref_block_prefix;
            }

            public String getExpiration() {
                return expiration;
            }

            public void setExpiration(String expiration) {
                this.expiration = expiration;
            }

            public List<List<Object>> getOperations() {
                return operations;
            }

            public void setOperations(List<List<Object>> operations) {
                this.operations = operations;
            }

            public List<?> getExtensions() {
                return extensions;
            }

            public void setExtensions(List<?> extensions) {
                this.extensions = extensions;
            }

            public List<String> getSignatures() {
                return signatures;
            }

            public void setSignatures(List<String> signatures) {
                this.signatures = signatures;
            }


        }

}
