package cy.agorise.graphenej.Bean;

import java.io.Serializable;
import java.util.List;

public class RoomBean implements Serializable {


    /**
     * id : 0
     * jsonrpc : 2.0
     * result : {"id":"1.15.530","house_id":"1.14.1","owner":"1.2.37","label":[],"description":"法甲 巴黎圣日耳曼 vs 里尔 主让 2 球","script":"","room_type":2,"status":"opening","option":{"result_owner_percent":9000,"reward_per_oracle":0,"accept_asset":"1.3.1","minimum":1000000,"maximum":1000000000,"start":"2018-10-29T03:45:34","stop":"2018-11-02T19:45:00","input_duration_secs":300,"filter":{"reputation":0,"guaranty":0,"volume":0},"allowed_oracles":[],"allowed_countries":[],"allowed_authentications":[]},"running_option":{"room_type":2,"selection_description":["主胜(-2)","平(主-2)","客胜(+2)"],"range":3,"advanced":{"pool":"500000000000","awards":[22000,42000,23000]},"participators":[[],[{"player":"1.2.11220","when":"2018-10-29T06:14:24","amount":210000000,"paid":50000000,"sequence":0}],[{"player":"1.2.11221","when":"2018-10-29T22:24:18","amount":23000000,"paid":10000000,"sequence":1}]],"total_shares":60000000,"settled_balance":0,"settled_row":-1,"settled_column":-1,"player_count":[0,1,1],"total_player_count":2,"advanced_running":{"total_participate":[[0,0],[50000000,210000000],[10000000,23000000]]},"guaranty_alone":0},"owner_result":[],"final_result":[],"committee_result":[],"oracle_sets":[],"final_finished":false,"settle_finished":false,"last_deal_time":"1970-01-01T00:00:00"}
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
         * id : 1.15.530
         * house_id : 1.14.1
         * owner : 1.2.37
         * label : []
         * description : 法甲 巴黎圣日耳曼 vs 里尔 主让 2 球
         * script :
         * room_type : 2
         * status : opening
         * option : {"result_owner_percent":9000,"reward_per_oracle":0,"accept_asset":"1.3.1","minimum":1000000,"maximum":1000000000,"start":"2018-10-29T03:45:34","stop":"2018-11-02T19:45:00","input_duration_secs":300,"filter":{"reputation":0,"guaranty":0,"volume":0},"allowed_oracles":[],"allowed_countries":[],"allowed_authentications":[]}
         * running_option : {"room_type":2,"selection_description":["主胜(-2)","平(主-2)","客胜(+2)"],"range":3,"advanced":{"pool":"500000000000","awards":[22000,42000,23000]},"participators":[[],[{"player":"1.2.11220","when":"2018-10-29T06:14:24","amount":210000000,"paid":50000000,"sequence":0}],[{"player":"1.2.11221","when":"2018-10-29T22:24:18","amount":23000000,"paid":10000000,"sequence":1}]],"total_shares":60000000,"settled_balance":0,"settled_row":-1,"settled_column":-1,"player_count":[0,1,1],"total_player_count":2,"advanced_running":{"total_participate":[[0,0],[50000000,210000000],[10000000,23000000]]},"guaranty_alone":0}
         * owner_result : []
         * final_result : []
         * committee_result : []
         * oracle_sets : []
         * final_finished : false
         * settle_finished : false
         * last_deal_time : 1970-01-01T00:00:00
         */

        private String id;
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
        private List<?> owner_result;
        private List<?> final_result;
        private List<?> committee_result;
        private List<?> oracle_sets;

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

        public List<?> getOwner_result() {
            return owner_result;
        }

        public void setOwner_result(List<?> owner_result) {
            this.owner_result = owner_result;
        }

        public List<?> getFinal_result() {
            return final_result;
        }

        public void setFinal_result(List<?> final_result) {
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

        public static class OptionBean {
            /**
             * result_owner_percent : 9000
             * reward_per_oracle : 0
             * accept_asset : 1.3.1
             * minimum : 1000000
             * maximum : 1000000000
             * start : 2018-10-29T03:45:34
             * stop : 2018-11-02T19:45:00
             * input_duration_secs : 300
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
             * room_type : 2
             * selection_description : ["主胜(-2)","平(主-2)","客胜(+2)"]
             * range : 3
             * advanced : {"pool":"500000000000","awards":[22000,42000,23000]}
             * participators : [[],[{"player":"1.2.11220","when":"2018-10-29T06:14:24","amount":210000000,"paid":50000000,"sequence":0}],[{"player":"1.2.11221","when":"2018-10-29T22:24:18","amount":23000000,"paid":10000000,"sequence":1}]]
             * total_shares : 60000000
             * settled_balance : 0
             * settled_row : -1
             * settled_column : -1
             * player_count : [0,1,1]
             * total_player_count : 2
             * advanced_running : {"total_participate":[[0,0],[50000000,210000000],[10000000,23000000]]}
             * guaranty_alone : 0
             */

            private int room_type;
            private int range;
            private AdvancedBean advanced;
            private int total_shares;
            private int settled_balance;
            private int settled_row;
            private int settled_column;
            private int total_player_count;
            private AdvancedRunningBean advanced_running;
            private int guaranty_alone;
            private List<String> selection_description;
            private List<List<?>> participators;
            private List<Integer> player_count;

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

            public AdvancedBean getAdvanced() {
                return advanced;
            }

            public void setAdvanced(AdvancedBean advanced) {
                this.advanced = advanced;
            }

            public int getTotal_shares() {
                return total_shares;
            }

            public void setTotal_shares(int total_shares) {
                this.total_shares = total_shares;
            }

            public int getSettled_balance() {
                return settled_balance;
            }

            public void setSettled_balance(int settled_balance) {
                this.settled_balance = settled_balance;
            }

            public int getSettled_row() {
                return settled_row;
            }

            public void setSettled_row(int settled_row) {
                this.settled_row = settled_row;
            }

            public int getSettled_column() {
                return settled_column;
            }

            public void setSettled_column(int settled_column) {
                this.settled_column = settled_column;
            }

            public int getTotal_player_count() {
                return total_player_count;
            }

            public void setTotal_player_count(int total_player_count) {
                this.total_player_count = total_player_count;
            }

            public AdvancedRunningBean getAdvanced_running() {
                return advanced_running;
            }

            public void setAdvanced_running(AdvancedRunningBean advanced_running) {
                this.advanced_running = advanced_running;
            }

            public int getGuaranty_alone() {
                return guaranty_alone;
            }

            public void setGuaranty_alone(int guaranty_alone) {
                this.guaranty_alone = guaranty_alone;
            }

            public List<String> getSelection_description() {
                return selection_description;
            }

            public void setSelection_description(List<String> selection_description) {
                this.selection_description = selection_description;
            }

            public List<List<?>> getParticipators() {
                return participators;
            }

            public void setParticipators(List<List<?>> participators) {
                this.participators = participators;
            }

            public List<Integer> getPlayer_count() {
                return player_count;
            }

            public void setPlayer_count(List<Integer> player_count) {
                this.player_count = player_count;
            }

            public static class AdvancedBean {
                /**
                 * pool : 500000000000
                 * awards : [22000,42000,23000]
                 */

                private String pool;
                private List<Integer> awards;

                public String getPool() {
                    return pool;
                }

                public void setPool(String pool) {
                    this.pool = pool;
                }

                public List<Integer> getAwards() {
                    return awards;
                }

                public void setAwards(List<Integer> awards) {
                    this.awards = awards;
                }
            }

            public static class AdvancedRunningBean {
                private List<List<Integer>> total_participate;

                public List<List<Integer>> getTotal_participate() {
                    return total_participate;
                }

                public void setTotal_participate(List<List<Integer>> total_participate) {
                    this.total_participate = total_participate;
                }
            }
        }
    }
}
