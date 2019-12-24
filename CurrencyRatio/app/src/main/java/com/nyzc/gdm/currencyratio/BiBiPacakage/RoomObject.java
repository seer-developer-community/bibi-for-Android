package com.nyzc.gdm.currencyratio.BiBiPacakage;

import java.io.Serializable;
import java.util.List;

public class RoomObject implements Serializable {


    /**
     * id : 1.15.84
     * house_id : 1.14.9
     * owner : 1.2.105
     * label : []
     * description : 3个选项
     * script :
     * room_type : 1
     * status : opening
     * option : {"result_owner_percent":10000,"reward_per_oracle":0,"accept_asset":"1.3.0","minimum":1000000,"maximum":1000000000,"start":"2018-11-08T13:06:50","stop":"2020-11-08T13:06:50","input_duration_secs":3600,"filter":{"reputation":0,"guaranty":0,"volume":0},"allowed_oracles":[],"allowed_countries":[],"allowed_authentications":[]}
     * running_option : {"room_type":1,"selection_description":["1","2","3"],"range":3,"participators":[[{"player":"1.2.105","when":"2018-11-16T10:02:42","amount":1000000,"paid":1000000,"sequence":1}],[{"player":"1.2.105","when":"2018-11-16T07:21:54","amount":1000000,"paid":1000000,"sequence":0}],[]],"total_shares":2000000,"settled_balance":0,"settled_row":-1,"settled_column":-1,"player_count":[1,1,0],"total_player_count":2,"pvp_running":{"total_participate":[1000000,1000000,0]},"guaranty_alone":0}
     * owner_result : []
     * final_result : []
     * committee_result : []
     * oracle_sets : []
     * final_result : false
     * settle_finished : false
     * last_deal_time : 1970-01-01T00:00:00
     */

    public object_id<RoomObject> id;
    private String house_id;
    private String owner;
    private String description;
    private String script;
    private int room_type;
    private String status;
    private OptionBean option;
    private RunningOptionBean running_option;
    private boolean final_finished;
    private boolean settle_finished;
    private String last_deal_time;
    private List<?> label;

    private List<?> committee_result;
    private List<?> oracle_sets;

    public object_id<RoomObject> getId() {
        return id;
    }

    public void setId(object_id<RoomObject> id) {
        this.id = id;
    }

    public String getHouse_id() {
        return house_id;
    }

    public void setHouse_id(String house_id) {
        this.house_id = house_id;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getScript() {
        return script;
    }

    public void setScript(String script) {
        this.script = script;
    }

    public int getRoom_type() {
        return room_type;
    }

    public void setRoom_type(int room_type) {
        this.room_type = room_type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public OptionBean getOption() {
        return option;
    }

    public void setOption(OptionBean option) {
        this.option = option;
    }

    public RunningOptionBean getRunning_option() {
        return running_option;
    }

    public void setRunning_option(RunningOptionBean running_option) {
        this.running_option = running_option;
    }

    public boolean isFinal_finished() {
        return final_finished;
    }

    public void setFinal_finished(boolean final_finished) {
        this.final_finished = final_finished;
    }

    public boolean isSettle_finished() {
        return settle_finished;
    }

    public void setSettle_finished(boolean settle_finished) {
        this.settle_finished = settle_finished;
    }

    public String getLast_deal_time() {
        return last_deal_time;
    }

    public void setLast_deal_time(String last_deal_time) {
        this.last_deal_time = last_deal_time;
    }

    public List<?> getLabel() {
        return label;
    }

    public void setLabel(List<?> label) {
        this.label = label;
    }

//    public List<Integer> getOwner_result() {
//        return owner_result;
//    }
//
//    public void setOwner_result(List<Integer> owner_result) {
//        this.owner_result = owner_result;
//    }
//
//    public List<Integer> getFinal_result() {
//        return final_result;
//    }
//
//    public void setFinal_result(List<Integer> final_result) {
//        this.final_result = final_result;
//    }

    public List<?> getCommittee_result() {
        return committee_result;
    }

    public void setCommittee_result(List<?> committee_result) {
        this.committee_result = committee_result;
    }

    public List<?> getOracle_sets() {
        return oracle_sets;
    }

    public void setOracle_sets(List<?> oracle_sets) {
        this.oracle_sets = oracle_sets;
    }

    public static class OptionBean implements Serializable {
        /**
         * result_owner_percent : 10000
         * reward_per_oracle : 0
         * accept_asset : 1.3.0
         * minimum : 1000000
         * maximum : 1000000000
         * start : 2018-11-08T13:06:50
         * stop : 2020-11-08T13:06:50
         * input_duration_secs : 3600
         * filter : {"reputation":0,"guaranty":0,"volume":0}
         * allowed_oracles : []
         * allowed_countries : []
         * allowed_authentications : []
         */

        private double result_owner_percent;
        private double reward_per_oracle;
        private String accept_asset;
        private double minimum;
        private double maximum;
        private String start;
        private String stop;
        private Double input_duration_secs;
        private FilterBean filter;
        private List<?> allowed_oracles;
        private List<?> allowed_countries;
        private List<?> allowed_authentications;

        public double getResult_owner_percent() {
            return result_owner_percent;
        }

        public void setResult_owner_percent(double result_owner_percent) {
            this.result_owner_percent = result_owner_percent;
        }

        public double getReward_per_oracle() {
            return reward_per_oracle;
        }

        public void setReward_per_oracle(double reward_per_oracle) {
            this.reward_per_oracle = reward_per_oracle;
        }

        public String getAccept_asset() {
            return accept_asset;
        }

        public void setAccept_asset(String accept_asset) {
            this.accept_asset = accept_asset;
        }

        public double getMinimum() {
            return minimum;
        }

        public void setMinimum(double minimum) {
            this.minimum = minimum;
        }

        public double getMaximum() {
            return maximum;
        }

        public void setMaximum(double maximum) {
            this.maximum = maximum;
        }

        public String getStart() {
            return start;
        }

        public void setStart(String start) {
            this.start = start;
        }

        public String getStop() {
            return stop;
        }

        public void setStop(String stop) {
            this.stop = stop;
        }

        public Double getInput_duration_secs() {
            return input_duration_secs;
        }

        public void setInput_duration_secs(Double input_duration_secs) {
            this.input_duration_secs = input_duration_secs;
        }

        public FilterBean getFilter() {
            return filter;
        }

        public void setFilter(FilterBean filter) {
            this.filter = filter;
        }

        public List<?> getAllowed_oracles() {
            return allowed_oracles;
        }

        public void setAllowed_oracles(List<?> allowed_oracles) {
            this.allowed_oracles = allowed_oracles;
        }

        public List<?> getAllowed_countries() {
            return allowed_countries;
        }

        public void setAllowed_countries(List<?> allowed_countries) {
            this.allowed_countries = allowed_countries;
        }

        public List<?> getAllowed_authentications() {
            return allowed_authentications;
        }

        public void setAllowed_authentications(List<?> allowed_authentications) {
            this.allowed_authentications = allowed_authentications;
        }

        public static class FilterBean implements Serializable {
            /**
             * reputation : 0
             * guaranty : 0
             * volume : 0
             */

            private long reputation;
            private long guaranty;
            private long volume;

            public long getReputation() {
                return reputation;
            }

            public void setReputation(long reputation) {
                this.reputation = reputation;
            }

            public long getGuaranty() {
                return guaranty;
            }

            public void setGuaranty(long guaranty) {
                this.guaranty = guaranty;
            }

            public long getVolume() {
                return volume;
            }

            public void setVolume(long volume) {
                this.volume = volume;
            }
        }
    }

    public static class RunningOptionBean implements Serializable {
        public List<Integer> getOwner_result() {
            return owner_result;
        }

        public void setOwner_result(List<Integer> owner_result) {
            this.owner_result = owner_result;
        }

        public List<Integer> getFinal_result() {
            return final_result;
        }

        public void setFinal_result(List<Integer> final_result) {
            this.final_result = final_result;
        }

        /**
         * room_type : 1
         * selection_description : ["1","2","3"]
         * range : 3
         * participators : [[{"player":"1.2.105","when":"2018-11-16T10:02:42","amount":1000000,"paid":1000000,"sequence":1}],[{"player":"1.2.105","when":"2018-11-16T07:21:54","amount":1000000,"paid":1000000,"sequence":0}],[]]
         * total_shares : 2000000
         * settled_balance : 0
         * settled_row : -1
         * settled_column : -1
         * player_count : [1,1,0]
         * total_player_count : 2
         * pvp_running : {"total_participate":[1000000,1000000,0]}
         * guaranty_alone : 0
         */

        private int room_type;
        private double range;
        private double total_shares;
        private double settled_balance;
        private double settled_row;
        private double settled_column;
        private double total_player_count;
        private LmsrBean lmsr;
        private PvpRunningBean pvp_running;
        private LmsrRunningBean lmsr_running;
        private AdvancedRunningBean advanced_running;
        private AdvancedBean advanced;
        private Double guaranty_alone;
        private List<String> selection_description;
        private List<List<ParticipatorsBean>> participators;
        private List<Integer> player_count;
        private List<Integer> owner_result;
        private List<Integer> final_result;
        public LmsrBean getLmsr() {
            return lmsr;
        }

        public void setLmsr(LmsrBean lmsr) {
            this.lmsr = lmsr;
        }

        public LmsrRunningBean getLmsr_running() {
            return lmsr_running;
        }

        public void setLmsr_running(LmsrRunningBean lmsr_running) {
            this.lmsr_running = lmsr_running;
        }

        public AdvancedRunningBean getAdvanced_running() {
            return advanced_running;
        }

        public void setAdvanced_running(AdvancedRunningBean advanced_running) {
            this.advanced_running = advanced_running;
        }

        public AdvancedBean getAdvanced() {
            return advanced;
        }

        public void setAdvanced(AdvancedBean advanced) {
            this.advanced = advanced;
        }

        public int getRoom_type() {
            return room_type;
        }

        public void setRoom_type(int room_type) {
            this.room_type = room_type;
        }

        public Double getRange() {
            return range;
        }

        public void setRange(Double range) {
            this.range = range;
        }

        public double getTotal_shares() {
            return total_shares;
        }

        public void setTotal_shares(double total_shares) {
            this.total_shares = total_shares;
        }

        public double getSettled_balance() {
            return settled_balance;
        }

        public void setSettled_balance(double settled_balance) {
            this.settled_balance = settled_balance;
        }

        public double getSettled_row() {
            return settled_row;
        }

        public void setSettled_row(double settled_row) {
            this.settled_row = settled_row;
        }

        public double getSettled_column() {
            return settled_column;
        }

        public void setSettled_column(double settled_column) {
            this.settled_column = settled_column;
        }

        public double getTotal_player_count() {
            return total_player_count;
        }

        public void setTotal_player_count(double total_player_count) {
            this.total_player_count = total_player_count;
        }

        public static class LmsrBean implements Serializable {
            /**
             * L : 100000000000
             */

            private double L;

            public double getL() {
                return L;
            }

            public void setL(double L) {
                this.L = L;
            }
        }

        public static class LmsrRunningBean implements Serializable {
            private List<Double> items;
            private List<?> accelerator;

            public List<Double> getItems() {
                return items;
            }

            public void setItems(List<Double> items) {
                this.items = items;
            }

            public List<?> getAccelerator() {
                return accelerator;
            }

            public void setAccelerator(List<?> accelerator) {
                this.accelerator = accelerator;
            }
        }

        public static class AdvancedRunningBean implements Serializable {
            private List<List<Double>> total_participate;

            public List<List<Double>> getTotal_participate() {
                return total_participate;
            }

            public void setTotal_participate(List<List<Double>> total_participate) {
                this.total_participate = total_participate;
            }
        }

        public static class AdvancedBean implements Serializable {
            /**
             * pool : 500000000000
             * awards : [23000,39000,23000]
             */

            private String pool;
            private List<Double> awards;

            public String getPool() {
                return pool;
            }

            public void setPool(String pool) {
                this.pool = pool;
            }

            public List<Double> getAwards() {
                return awards;
            }

            public void setAwards(List<Double> awards) {
                this.awards = awards;
            }
        }

        public PvpRunningBean getPvp_running() {
            return pvp_running;
        }

        public void setPvp_running(PvpRunningBean pvp_running) {
            this.pvp_running = pvp_running;
        }

        public Double getGuaranty_alone() {
            return guaranty_alone;
        }

        public void setGuaranty_alone(Double guaranty_alone) {
            this.guaranty_alone = guaranty_alone;
        }

        public List<String> getSelection_description() {
            return selection_description;
        }

        public void setSelection_description(List<String> selection_description) {
            this.selection_description = selection_description;
        }

        public List<List<ParticipatorsBean>> getParticipators() {
            return participators;
        }

        public void setParticipators(List<List<ParticipatorsBean>> participators) {
            this.participators = participators;
        }

        public List<Integer> getPlayer_count() {
            return player_count;
        }

        public void setPlayer_count(List<Integer> player_count) {
            this.player_count = player_count;
        }

        public static class PvpRunningBean implements Serializable {
            private List<Double> total_participate;

            public List<Double> getTotal_participate() {
                return total_participate;
            }

            public void setTotal_participate(List<Double> total_participate) {
                this.total_participate = total_participate;
            }
        }

        public static class ParticipatorsBean implements Serializable {
            /**
             * player : 1.2.105
             * when : 2018-11-16T10:02:42
             * amount : 1000000
             * paid : 1000000
             * sequence : 1
             */

            private String player;
            private String when;
            private double amount;
            private double paid;
            private int sequence;
            private int block_num;
            private double reward;

            public int getBlock_num() {
                return block_num;
            }

            public void setBlock_num(int block_num) {
                this.block_num = block_num;
            }

            public double getReward() {
                return reward;
            }

            public void setReward(double reward) {
                this.reward = reward;
            }

            public String getPlayer() {
                return player;
            }

            public void setPlayer(String player) {
                this.player = player;
            }

            public String getWhen() {
                return when;
            }

            public void setWhen(String when) {
                this.when = when;
            }

            public double getAmount() {
                return amount;
            }

            public void setAmount(double amount) {
                this.amount = amount;
            }

            public double getPaid() {
                return paid;
            }

            public void setPaid(double paid) {
                this.paid = paid;
            }

            public int getSequence() {
                return sequence;
            }

            public void setSequence(int sequence) {
                this.sequence = sequence;
            }
        }
    }
}
