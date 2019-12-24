package com.nyzc.gdm.currencyratio.Bean;

import java.util.List;

public class ErrorMessage {


    /**
     * code : 1
     * data : {"code":10,"name":"assert_exception","message":"Assert Exception","stack":[{"context":{"level":"error","file":"seer_evaluator.cpp","line":777,"method":"do_evaluate","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"_db.head_block_time() < room_obj->option.stop: ","data":{}},{"context":{"level":"warn","file":"seer_evaluator.cpp","line":800,"method":"do_evaluate","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{"op":{"fee":{"amount":500000,"asset_id":"1.3.0"},"issuer":"1.2.16371","room":"1.15.576","type":0,"input":[0],"input1":[],"input2":[],"amount":1000000}}},{"context":{"level":"warn","file":"evaluator.cpp","line":51,"method":"start_evaluate","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{}},{"context":{"level":"warn","file":"db_block.cpp","line":635,"method":"apply_operation","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{"op":[50,{"fee":{"amount":500000,"asset_id":"1.3.0"},"issuer":"1.2.16371","room":"1.15.576","type":0,"input":[0],"input1":[],"input2":[],"amount":1000000}]}},{"context":{"level":"warn","file":"db_block.cpp","line":618,"method":"_apply_transaction","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{"trx":{"ref_block_num":4069,"ref_block_prefix":1.742883716E9,"expiration":"2018-12-05T06:53:18","operations":[[50,{"fee":{"amount":500000,"asset_id":"1.3.0"},"issuer":"1.2.16371","room":"1.15.576","type":0,"input":[0],"input1":[],"input2":[],"amount":1000000}]],"extensions":[],"signatures":["1b705b21c4f997f61bbe9e67491ce399a411ccb5697fb683dac3b86d3aa67b592f5956c39ed386b0a6d51ed931f5ffa3c34d5179b63947675b40d86a27dd7fd9b4"]}}},{"context":{"level":"warn","file":"db_block.cpp","line":227,"method":"push_transaction","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{"trx":{"ref_block_num":4069,"ref_block_prefix":1.742883716E9,"expiration":"2018-12-05T06:53:18","operations":[[50,{"fee":{"amount":500000,"asset_id":"1.3.0"},"issuer":"1.2.16371","room":"1.15.576","type":0,"input":[0],"input1":[],"input2":[],"amount":1000000}]],"extensions":[],"signatures":["1b705b21c4f997f61bbe9e67491ce399a411ccb5697fb683dac3b86d3aa67b592f5956c39ed386b0a6d51ed931f5ffa3c34d5179b63947675b40d86a27dd7fd9b4"]}}},{"context":{"level":"warn","file":"websocket_api.cpp","line":122,"method":"on_message","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{"call.method":"call","call.params":[4,"broadcast_transaction",[{"signatures":["1b705b21c4f997f61bbe9e67491ce399a411ccb5697fb683dac3b86d3aa67b592f5956c39ed386b0a6d51ed931f5ffa3c34d5179b63947675b40d86a27dd7fd9b4"],"expiration":"2018-12-05T06:53:18","extensions":[],"operations":[[50,{"amount":1000000,"fee":{"amount":500000,"asset_id":"1.3.0"},"input":[0],"input1":[],"input2":[],"issuer":"1.2.16371","room":"1.15.576","type":0}]],"ref_block_num":4069,"ref_block_prefix":1.742883716E9}]]}}]}
     * message : Assert Exception: _db.head_block_time() < room_obj->option.stop:
     */

    private int code;
    private DataBeanX data;
    private String message;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public DataBeanX getData() {
        return data;
    }

    public void setData(DataBeanX data) {
        this.data = data;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public static class DataBeanX {
        /**
         * code : 10.0
         * name : assert_exception
         * message : Assert Exception
         * stack : [{"context":{"level":"error","file":"seer_evaluator.cpp","line":777,"method":"do_evaluate","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"_db.head_block_time() < room_obj->option.stop: ","data":{}},{"context":{"level":"warn","file":"seer_evaluator.cpp","line":800,"method":"do_evaluate","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{"op":{"fee":{"amount":500000,"asset_id":"1.3.0"},"issuer":"1.2.16371","room":"1.15.576","type":0,"input":[0],"input1":[],"input2":[],"amount":1000000}}},{"context":{"level":"warn","file":"evaluator.cpp","line":51,"method":"start_evaluate","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{}},{"context":{"level":"warn","file":"db_block.cpp","line":635,"method":"apply_operation","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{"op":[50,{"fee":{"amount":500000,"asset_id":"1.3.0"},"issuer":"1.2.16371","room":"1.15.576","type":0,"input":[0],"input1":[],"input2":[],"amount":1000000}]}},{"context":{"level":"warn","file":"db_block.cpp","line":618,"method":"_apply_transaction","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{"trx":{"ref_block_num":4069,"ref_block_prefix":1.742883716E9,"expiration":"2018-12-05T06:53:18","operations":[[50,{"fee":{"amount":500000,"asset_id":"1.3.0"},"issuer":"1.2.16371","room":"1.15.576","type":0,"input":[0],"input1":[],"input2":[],"amount":1000000}]],"extensions":[],"signatures":["1b705b21c4f997f61bbe9e67491ce399a411ccb5697fb683dac3b86d3aa67b592f5956c39ed386b0a6d51ed931f5ffa3c34d5179b63947675b40d86a27dd7fd9b4"]}}},{"context":{"level":"warn","file":"db_block.cpp","line":227,"method":"push_transaction","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{"trx":{"ref_block_num":4069,"ref_block_prefix":1.742883716E9,"expiration":"2018-12-05T06:53:18","operations":[[50,{"fee":{"amount":500000,"asset_id":"1.3.0"},"issuer":"1.2.16371","room":"1.15.576","type":0,"input":[0],"input1":[],"input2":[],"amount":1000000}]],"extensions":[],"signatures":["1b705b21c4f997f61bbe9e67491ce399a411ccb5697fb683dac3b86d3aa67b592f5956c39ed386b0a6d51ed931f5ffa3c34d5179b63947675b40d86a27dd7fd9b4"]}}},{"context":{"level":"warn","file":"websocket_api.cpp","line":122,"method":"on_message","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"},"format":"","data":{"call.method":"call","call.params":[4,"broadcast_transaction",[{"signatures":["1b705b21c4f997f61bbe9e67491ce399a411ccb5697fb683dac3b86d3aa67b592f5956c39ed386b0a6d51ed931f5ffa3c34d5179b63947675b40d86a27dd7fd9b4"],"expiration":"2018-12-05T06:53:18","extensions":[],"operations":[[50,{"amount":1000000,"fee":{"amount":500000,"asset_id":"1.3.0"},"input":[0],"input1":[],"input2":[],"issuer":"1.2.16371","room":"1.15.576","type":0}]],"ref_block_num":4069,"ref_block_prefix":1.742883716E9}]]}}]
         */

        private double code;
        private String name;
        private String message;
        private List<StackBean> stack;

        public double getCode() {
            return code;
        }

        public void setCode(double code) {
            this.code = code;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public List<StackBean> getStack() {
            return stack;
        }

        public void setStack(List<StackBean> stack) {
            this.stack = stack;
        }

        public static class StackBean {
            /**
             * context : {"level":"error","file":"seer_evaluator.cpp","line":777,"method":"do_evaluate","hostname":"","thread_name":"th_a","timestamp":"2018-12-05T06:52:49"}
             * format : _db.head_block_time() < room_obj->option.stop:
             * data : {}
             */

            private ContextBean context;
            private String format;
            private DataBean data;

            public ContextBean getContext() {
                return context;
            }

            public void setContext(ContextBean context) {
                this.context = context;
            }

            public String getFormat() {
                return format;
            }

            public void setFormat(String format) {
                this.format = format;
            }

            public DataBean getData() {
                return data;
            }

            public void setData(DataBean data) {
                this.data = data;
            }

            public static class ContextBean {
            }

            public static class DataBean {
            }
        }
    }
}
