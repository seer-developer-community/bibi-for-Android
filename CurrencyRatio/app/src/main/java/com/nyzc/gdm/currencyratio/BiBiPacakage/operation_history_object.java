package com.nyzc.gdm.currencyratio.BiBiPacakage;


import android.arch.persistence.room.ColumnInfo;

import java.io.Serializable;

public class operation_history_object implements Serializable {
    @ColumnInfo(name = "history_id")
    public String id;
    public operations.operation_type op;
    public int block_num;
    public int trx_in_block;
    public int op_in_trx;
    public int virtual_op;


}
