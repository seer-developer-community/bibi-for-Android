package com.nyzc.gdm.currencyratio.accountPacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Message;
import android.view.KeyEvent;
import android.widget.ImageView;

import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.TransferBean;
import com.nyzc.gdm.currencyratio.Bean.WaitAccountBean;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.block_header;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.BiBiPacakage.object_id;
import com.nyzc.gdm.currencyratio.BiBiPacakage.operation_history_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.operations;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;
import com.nyzc.gdm.currencyratio.View.MyListView;
import com.nyzc.gdm.currencyratio.accountPacakage.Adapter.TranstionRecorderAdapters;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;

public class TranstionRecorderActivity extends BaseActivity {

    TranstionRecorderAdapters mAdapter;
    @BindView(R.id.recycle)
    MyListView mRecyclerView;
    List<WaitAccountBean> list;
    @BindView(R.id.custom_title)
    CustomTitleBar customTitleBar;
    @BindView(R.id.transferaccounts)
    ImageView transferaccounts;
    @BindView(R.id.rechargeeaccount)
    ImageView rechargeeaccount;
    @BindView(R.id.iv_cash_out)
    ImageView iv_cash_out;
    account_object AccountObject = null;

    @Override
    public int getLayoutId() {
        return R.layout.activity_transtion_recorder;
    }

    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);

            if (waitAccountBean != null) {
                mAdapter = new TranstionRecorderAdapters(TranstionRecorderActivity.this, waitAccountBean, assetId);
                mRecyclerView.setAdapter(mAdapter);
            }
            dismissLoadingDialog();
        }
    };
    String assetId;

    public static void start(Context context, String asset) {
        Intent starter = new Intent(context, TranstionRecorderActivity.class);
        starter.putExtra("assetId", asset);
        context.startActivity(starter);
    }

    WaitAccountBean waitAccountBean;
    String langauage;

    @Override
    protected void init() {
        assetId = getIntent().getStringExtra("assetId");
        langauage = CacheUtils.getString(this, "langauage", "");
        if (langauage.equals("zh")) {
            transferaccounts.setImageDrawable(getResources().getDrawable(R.mipmap.transferaccounts));
            rechargeeaccount.setImageDrawable(getResources().getDrawable(R.mipmap.recharge));
            iv_cash_out.setImageDrawable(getResources().getDrawable(R.mipmap.cashout));
        } else {
            transferaccounts.setImageDrawable(getResources().getDrawable(R.mipmap.en_transfer));
            rechargeeaccount.setImageDrawable(getResources().getDrawable(R.mipmap.en_recharge));
            iv_cash_out.setImageDrawable(getResources().getDrawable(R.mipmap.en_cashout));
        }
        switch (assetId) {
            case "1.3.0":
                customTitleBar.setTitle_text("SEER");
                break;
            case "1.3.5":
                customTitleBar.setTitle_text("USDT");
                break;
            case "1.3.2":
                customTitleBar.setTitle_text("PFC");
                break;
        }
        customTitleBar.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
            @Override
            public void onLeftClick() {
                Intent intent = new Intent();
                setResult(2, intent);
                finish();
            }

            @Override
            public void onRightClick() {

            }
        });
        transferaccounts.setOnClickListener(view -> {
            TransferAccountActivity.start(TranstionRecorderActivity.this, assetId);
            finish();
        });
        rechargeeaccount.setOnClickListener(view -> RechargeActivity.start(TranstionRecorderActivity.this, assetId));
        iv_cash_out.setOnClickListener(view -> {
            CashOutActivity.start(TranstionRecorderActivity.this, assetId);
            finish();
        });

    }


    @Override
    protected void onResume() {
        super.onResume();
            getData(page);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            Intent intent = new Intent();
            setResult(2, intent);
            finish();
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    block_header blockHeader;
    int page = 20;

    /**
     * 获取转账记录
     */
    private void getData(int page) {
        showLoadingDialog();
        new Thread(() -> {
            object_id<operation_history_object> startId;
            List<operation_history_object> operationHistoryObjectList = null;
            startId = object_id.create_from_string("1.9.0");
            List<operations.transfer_operation> transationBeanList = new ArrayList<>();
            List<String> listData = new ArrayList<>();
            List<TransferBean> listUserTo = new ArrayList<>();
            waitAccountBean = new WaitAccountBean();
            try {
                if (BitsharesWalletWraper.getInstance().build_connect() == 0) {
                    if (MyApp.localWalletUser != null) {
                        AccountObject = BitsharesWalletWraper.getInstance().get_account_object(MyApp.localWalletUser.getLocalName());
                        operationHistoryObjectList = BitsharesWalletWraper.getInstance().get_account_history(AccountObject.id, startId, page);
                        for (int i = 0; i < operationHistoryObjectList.size(); i++) {
                            if (operationHistoryObjectList.get(i).op.nOperationType == 0) {
                                operations.transfer_operation transferOperation = (operations.transfer_operation) operationHistoryObjectList.get(i).op.operationContent;
                                if (transferOperation.amount.asset_id.get_userId().equals(assetId)) {
                                    transationBeanList.add(transferOperation);
                                    if (transferOperation.to.get_userId().equals(AccountObject.getId().get_userId())) {
                                        account_object accountObject = BitsharesWalletWraper.getInstance().get_account_object(transferOperation.from.get_userId());
                                        TransferBean transferBean = new TransferBean();
                                        transferBean.setName(accountObject.name);
                                        transferBean.setOneSelf(true);
                                        listUserTo.add(transferBean);
                                    } else {
                                        account_object accountObject = BitsharesWalletWraper.getInstance().get_account_object(transferOperation.to.get_userId());
                                        TransferBean transferBean = new TransferBean();
                                        transferBean.setName(accountObject.name);
                                        transferBean.setOneSelf(false);
                                        listUserTo.add(transferBean);
                                    }
                                    blockHeader = BitsharesWalletWraper.getInstance().get_block_header(operationHistoryObjectList.get(i).block_num);
                                    listData.add(blockHeader.timestamp);
                                }
                            }
                        }
                        waitAccountBean.setListData(listData);
                        waitAccountBean.setListUserTo(listUserTo);
                        waitAccountBean.setTransationBeanList(transationBeanList);
                        handler.sendMessage(new Message());
                    }
                }
            } catch (NetworkStatusException e) {
//                    showInfoDialog(e.getMessage());
            }
        }).start();

    }

}
