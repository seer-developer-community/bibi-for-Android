package com.nyzc.gdm.currencyratio.Bean;

import java.util.List;

public class Room {


    /**
     * id : 11
     * jsonrpc : 2.0
     * result : {"id":"1.15.576","house_id":"1.14.4","owner":"1.2.13647","label":["毒液","热点","猫眼","电影"],"description":"电影《毒液：致命守护者》上映30天中国内地总票房是多少？（2018-12-01 0点前可以预测）结果以2018-12-08猫眼电影专业版发布数据（不含服务费）为准：http://piaofang.maoyan.com","script":"","room_type":1,"status":"finished","option":{"result_owner_percent":9000,"reward_per_oracle":0,"accept_asset":"1.3.0","minimum":500000,"maximum":1000000000,"start":"2018-11-19T08:57:40","stop":"2018-12-01T04:00:00","input_duration_secs":604800,"filter":{"reputation":0,"guaranty":0,"volume":0},"allowed_oracles":[],"allowed_countries":[],"allowed_authentications":[]},"owner_pay_fee_percent":0,"running_option":{"room_type":1,"selection_description":["≤17亿","17亿-19亿(不含)","≥19亿"],"range":3,"total_shares":"5867500000","settled_balance":"5867235600","settled_player":"1.2.16663","settled_id":"0.0.0","player_count":[22,17,11],"total_player_count":50,"pvp_running":{"total_participate":[239000000,"4523000000",1105500000]},"guaranty_alone":"12000000000","pvp_owner_percent":0,"pvp_owner_shares":0,"owner_result":[1],"final_result":[1],"committee_result":[],"oracle_sets":[],"final_finished":true,"settle_finished":true},"last_deal_time":"2018-12-10T02:22:39"}
     */

    private int id;
    private String jsonrpc;
    private ResultBean result;

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

    public ResultBean getResult() {
        return result;
    }

    public void setResult(ResultBean result) {
        this.result = result;
    }

    public static class ResultBean {
        /**
         * id : 1.15.576
         * house_id : 1.14.4
         * owner : 1.2.13647
         * label : ["毒液","热点","猫眼","电影"]
         * description : 电影《毒液：致命守护者》上映30天中国内地总票房是多少？（2018-12-01 0点前可以预测）结果以2018-12-08猫眼电影专业版发布数据（不含服务费）为准：http://piaofang.maoyan.com
         * script :
         * room_type : 1
         * status : finished
         * option : {"result_owner_percent":9000,"reward_per_oracle":0,"accept_asset":"1.3.0","minimum":500000,"maximum":1000000000,"start":"2018-11-19T08:57:40","stop":"2018-12-01T04:00:00","input_duration_secs":604800,"filter":{"reputation":0,"guaranty":0,"volume":0},"allowed_oracles":[],"allowed_countries":[],"allowed_authentications":[]}
         * owner_pay_fee_percent : 0
         * running_option : {"room_type":1,"selection_description":["≤17亿","17亿-19亿(不含)","≥19亿"],"range":3,"total_shares":"5867500000","settled_balance":"5867235600","settled_player":"1.2.16663","settled_id":"0.0.0","player_count":[22,17,11],"total_player_count":50,"pvp_running":{"total_participate":[239000000,"4523000000",1105500000]},"guaranty_alone":"12000000000","pvp_owner_percent":0,"pvp_owner_shares":0,"owner_result":[1],"final_result":[1],"committee_result":[],"oracle_sets":[],"final_finished":true,"settle_finished":true}
         * last_deal_time : 2018-12-10T02:22:39
         */

        private String id;
        private String house_id;
        private String owner;
        private String description;
        private String script;
        private int room_type;
        private String status;
        private OptionBean option;
        private int owner_pay_fee_percent;
        private RunningOptionBean running_option;
        private String last_deal_time;
        private List<String> label;

        public String getId() {
            return id;
        }

        public void setId(String id) {
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

        public int getOwner_pay_fee_percent() {
            return owner_pay_fee_percent;
        }

        public void setOwner_pay_fee_percent(int owner_pay_fee_percent) {
            this.owner_pay_fee_percent = owner_pay_fee_percent;
        }

        public RunningOptionBean getRunning_option() {
            return running_option;
        }

        public void setRunning_option(RunningOptionBean running_option) {
            this.running_option = running_option;
        }

        public String getLast_deal_time() {
            return last_deal_time;
        }

        public void setLast_deal_time(String last_deal_time) {
            this.last_deal_time = last_deal_time;
        }

        public List<String> getLabel() {
            return label;
        }

        public void setLabel(List<String> label) {
            this.label = label;
        }

        public static class OptionBean {
            /**
             * result_owner_percent : 9000
             * reward_per_oracle : 0
             * accept_asset : 1.3.0
             * minimum : 500000
             * maximum : 1000000000
             * start : 2018-11-19T08:57:40
             * stop : 2018-12-01T04:00:00
             * input_duration_secs : 604800
             * filter : {"reputation":0,"guaranty":0,"volume":0}
             * allowed_oracles : []
             * allowed_countries : []
             * allowed_authentications : []
             */

            private int result_owner_percent;
            private int reward_per_oracle;
            private String accept_asset;
            private int minimum;
            private int maximum;
            private String start;
            private String stop;
            private int input_duration_secs;
            private FilterBean filter;
            private List<?> allowed_oracles;
            private List<?> allowed_countries;
            private List<?> allowed_authentications;

            public int getResult_owner_percent() {
                return result_owner_percent;
            }

            public void setResult_owner_percent(int result_owner_percent) {
                this.result_owner_percent = result_owner_percent;
            }

            public int getReward_per_oracle() {
                return reward_per_oracle;
            }

            public void setReward_per_oracle(int reward_per_oracle) {
                this.reward_per_oracle = reward_per_oracle;
            }

            public String getAccept_asset() {
                return accept_asset;
            }

            public void setAccept_asset(String accept_asset) {
                this.accept_asset = accept_asset;
            }

            public int getMinimum() {
                return minimum;
            }

            public void setMinimum(int minimum) {
                this.minimum = minimum;
            }

            public int getMaximum() {
                return maximum;
            }

            public void setMaximum(int maximum) {
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

            public int getInput_duration_secs() {
                return input_duration_secs;
            }

            public void setInput_duration_secs(int input_duration_secs) {
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

            public static class FilterBean {
                /**
                 * reputation : 0
                 * guaranty : 0
                 * volume : 0
                 */

                private int reputation;
                private int guaranty;
                private int volume;

                public int getReputation() {
                    return reputation;
                }

                public void setReputation(int reputation) {
                    this.reputation = reputation;
                }

                public int getGuaranty() {
                    return guaranty;
                }

                public void setGuaranty(int guaranty) {
                    this.guaranty = guaranty;
                }

                public int getVolume() {
                    return volume;
                }

                public void setVolume(int volume) {
                    this.volume = volume;
                }
            }
        }

        public static class RunningOptionBean {
            /**
             * room_type : 1
             * selection_description : ["≤17亿","17亿-19亿(不含)","≥19亿"]
             * range : 3
             * total_shares : 5867500000
             * settled_balance : 5867235600
             * settled_player : 1.2.16663
             * settled_id : 0.0.0
             * player_count : [22,17,11]
             * total_player_count : 50
             * pvp_running : {"total_participate":[239000000,"4523000000",1105500000]}
             * guaranty_alone : 12000000000
             * pvp_owner_percent : 0
             * pvp_owner_shares : 0
             * owner_result : [1]
             * final_result : [1]
             * committee_result : []
             * oracle_sets : []
             * final_finished : true
             * settle_finished : true
             */

            private int room_type;
            private int range;
            private String total_shares;
            private String settled_balance;
            private String settled_player;
            private String settled_id;
            private int total_player_count;
            private PvpRunningBean pvp_running;
            private String guaranty_alone;
            private int pvp_owner_percent;
            private int pvp_owner_shares;
            private boolean final_finished;
            private boolean settle_finished;
            private List<String> selection_description;
            private List<Integer> player_count;
            private List<Integer> owner_result;
            private List<Integer> final_result;
            private List<?> committee_result;
            private List<?> oracle_sets;

            public int getRoom_type() {
                return room_type;
            }

            public void setRoom_type(int room_type) {
                this.room_type = room_type;
            }

            public int getRange() {
                return range;
            }

            public void setRange(int range) {
                this.range = range;
            }

            public String getTotal_shares() {
                return total_shares;
            }

            public void setTotal_shares(String total_shares) {
                this.total_shares = total_shares;
            }

            public String getSettled_balance() {
                return settled_balance;
            }

            public void setSettled_balance(String settled_balance) {
                this.settled_balance = settled_balance;
            }

            public String getSettled_player() {
                return settled_player;
            }

            public void setSettled_player(String settled_player) {
                this.settled_player = settled_player;
            }

            public String getSettled_id() {
                return settled_id;
            }

            public void setSettled_id(String settled_id) {
                this.settled_id = settled_id;
            }

            public int getTotal_player_count() {
                return total_player_count;
            }

            public void setTotal_player_count(int total_player_count) {
                this.total_player_count = total_player_count;
            }

            public PvpRunningBean getPvp_running() {
                return pvp_running;
            }

            public void setPvp_running(PvpRunningBean pvp_running) {
                this.pvp_running = pvp_running;
            }

            public String getGuaranty_alone() {
                return guaranty_alone;
            }

            public void setGuaranty_alone(String guaranty_alone) {
                this.guaranty_alone = guaranty_alone;
            }

            public int getPvp_owner_percent() {
                return pvp_owner_percent;
            }

            public void setPvp_owner_percent(int pvp_owner_percent) {
                this.pvp_owner_percent = pvp_owner_percent;
            }

            public int getPvp_owner_shares() {
                return pvp_owner_shares;
            }

            public void setPvp_owner_shares(int pvp_owner_shares) {
                this.pvp_owner_shares = pvp_owner_shares;
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

            public List<String> getSelection_description() {
                return selection_description;
            }

            public void setSelection_description(List<String> selection_description) {
                this.selection_description = selection_description;
            }

            public List<Integer> getPlayer_count() {
                return player_count;
            }

            public void setPlayer_count(List<Integer> player_count) {
                this.player_count = player_count;
            }

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

            public static class PvpRunningBean {
                private List<Integer> total_participate;

                public List<Integer> getTotal_participate() {
                    return total_participate;
                }

                public void setTotal_participate(List<Integer> total_participate) {
                    this.total_participate = total_participate;
                }
            }
        }
    }
}
