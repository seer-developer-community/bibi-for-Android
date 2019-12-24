package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.Gson;
import com.neovisionaries.ws.client.WebSocket;
import com.neovisionaries.ws.client.WebSocketException;
import com.nyzc.gdm.currencyratio.Base.AppLocalWalletUser;
import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Bean.FileSave;
import com.nyzc.gdm.currencyratio.Bean.ResultBean;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.asset;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.MainActivity;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.HttpUrl;
import com.nyzc.gdm.currencyratio.Utils.NumerUtil;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import butterknife.BindView;
import cy.agorise.graphenej.Address;
import cy.agorise.graphenej.BrainKey;
import cy.agorise.graphenej.PublicKey;
import cy.agorise.graphenej.UserAccount;
import cy.agorise.graphenej.api.GetKeyReferences;
import cy.agorise.graphenej.interfaces.WitnessResponseListener;
import cy.agorise.graphenej.models.BaseResponse;
import cy.agorise.graphenej.models.WitnessResponse;

public class ImportWalletActivity extends BaseActivity implements WitnessResponseListener {


    @BindView(R.id.custom_title)
    CustomTitleBar customTitle;
    @BindView(R.id.rela_input_brainkey)
    RelativeLayout relaInputBrainkey;
    @BindView(R.id.tv_create_wallet_pwd)
    TextView tvCreateWalletPwd;
    @BindView(R.id.edit_input_wallet_pwd)
    EditText editInputWalletPwd;
    @BindView(R.id.edi_input_brainkey)
    EditText edi_input_brainkey;
    @BindView(R.id.rela_wallet_pwd)
    RelativeLayout relaWalletPwd;
    @BindView(R.id.view)
    View view;
    @BindView(R.id.tv_create_wallet_pwd_again)
    TextView tvCreateWalletPwdAgain;
    @BindView(R.id.edit_input_wallet_pwd_again)
    EditText editInputWalletPwdAgain;
    @BindView(R.id.rela_wallet_pwd_again)
    RelativeLayout relaWalletPwdAgain;
    @BindView(R.id.rela_import_wallet)
    RelativeLayout relaImportWallet;
    @BindView(R.id.iv_agree_service)
    ImageView ivAgreeService;
    @BindView(R.id.tv_service_agreement)
    TextView tvServiceAgreement;
    @BindView(R.id.ll_read_service)
    LinearLayout llReadService;
    @BindView(R.id.tv_import_wallet)
    TextView tvImportWallet;


    @Override
    public int getLayoutId() {
        return R.layout.activity_import_wallet;
    }

    public static void start(Context context) {
        Intent starter = new Intent(context, ImportWalletActivity.class);
        context.startActivity(starter);
    }

    @Override
    protected void init() {
        customTitle.setOnTitleClickListener(new CustomTitleBar.TitleOnClickListener() {
            @Override
            public void onLeftClick() {
                finish();
            }

            @Override
            public void onRightClick() {
            }
        });
        ivAgreeService.setOnClickListener(view -> {
            if (ivAgreeService.isSelected()) {
                ivAgreeService.setSelected(false);
            } else {
                ivAgreeService.setSelected(true);
            }
        });
        tvImportWallet.setOnClickListener(view -> getCheck());
        tvServiceAgreement.setOnClickListener(view -> ServiceActivity.start(ImportWalletActivity.this, 1));
        ivAgreeService.setSelected(true);
    }

    BrainKey mBrainKey;
    Address address;
    GetKeyReferences getKeyReferences;
    WebSocket mWebSocket;
    String brainkey;
    String pwd;
    String pwd_again;
    private String privateOwnerKeys, publicOwnerKeys;
    public static final int DEFAULT_SEQUENCE_NUMBER_0 = 0;
    public static final int DEFAULT_SEQUENCE_NUMBER_1 = 1;
    private PublicKey publicAddress;

    private void getCheck() {
        pwd = editInputWalletPwd.getText().toString().trim();
        pwd_again = editInputWalletPwdAgain.getText().toString().trim();
        brainkey = edi_input_brainkey.getText().toString().trim();
        if (TextUtils.isEmpty(brainkey.toString())) {
            Toast.makeText(ImportWalletActivity.this, getString(R.string.entermnemonic), Toast.LENGTH_SHORT).show();
            return;
        }
        if (TextUtils.isEmpty(pwd)) {
            Toast.makeText(this, getString(R.string.enterPwd), Toast.LENGTH_SHORT).show();
            return;
        } else {
            if (pwd.length() < 8) {
                Toast.makeText(this, getString(R.string.characters), Toast.LENGTH_SHORT).show();
                return;
            }
        }
        if (TextUtils.isEmpty(pwd_again)) {
            Toast.makeText(ImportWalletActivity.this, getString(R.string.PleaseRepeatPassword), Toast.LENGTH_SHORT).show();
            return;
        }
        if (!pwd_again.equals(pwd)) {
            Toast.makeText(ImportWalletActivity.this, getString(R.string.Inconsistentpassword), Toast.LENGTH_SHORT).show();
            return;
        } else {
            if (MyApp.importAccountBean != null) {
                if (!pwd.equals(MyApp.importAccountBean.getImport_account_pwd())) {
                    Toast.makeText(this, getString(R.string.Inconsistentpassword), Toast.LENGTH_SHORT).show();
                    return;
                }
            }
        }
        if (!ivAgreeService.isSelected()) {
            Toast.makeText(ImportWalletActivity.this, getString(R.string.checkAddress), Toast.LENGTH_SHORT).show();
            return;
        }
        showLoadingDialog();
        try {
            CreateBrainkey(brainkey, DEFAULT_SEQUENCE_NUMBER_1);
            CreateBrainkey(brainkey, DEFAULT_SEQUENCE_NUMBER_0);
            getKeyReferences = new GetKeyReferences(address, true, this);
            mWebSocket = MyApp.factory.createSocket(HttpUrl.Base_Url);
        } catch (IOException e) {
            showInfoDialog(e.getMessage());
        }
        new Thread(() -> {
            try {
                mWebSocket.addListener(getKeyReferences);
                mWebSocket.connect();
            } catch (WebSocketException e) {
                e.printStackTrace();
            }
        }).start();

    }

    /**
     * 导入钱包 根据助记词 得出公钥和私钥保存在本地
     *
     * @param brainkey
     * @param DEFAULT_SEQUENCE_NUMBER
     */

    private void CreateBrainkey(String brainkey, int DEFAULT_SEQUENCE_NUMBER) {
        mBrainKey = new BrainKey(brainkey, DEFAULT_SEQUENCE_NUMBER);
        address = mBrainKey.getPublicAddress(Address.BITSHARES_PREFIX);
//        publicAddress = address.getPublicKey();
        //1代表账户权限  0代表资金权限
        if (DEFAULT_SEQUENCE_NUMBER == 0) {
            publicActiveKey = address.getPublicKey().getAddress();
            privateActiveKey = mBrainKey.getWalletImportFormat();
        } else {
            publicOwnerKeys = address.getPublicKey().getAddress();
            privateOwnerKeys = mBrainKey.getWalletImportFormat();
        }

    }

    String privateActiveKey, publicActiveKey;
    ResultBean resultBean;
    BigDecimal loaclAmount;
    String seerAmount;
    String usdtAmount;
    String pfcAmount;

    @Override
    public void onSuccess(WitnessResponse response) {
        WitnessResponse<List<List<UserAccount>>> witnessResponse = response;
        if (witnessResponse.result != null) {
            String result = witnessResponse.result.get(0).get(0).toJsonString();
            try {
                resultBean = new Gson().fromJson(result, ResultBean.class);
                account_object accountObject = BitsharesWalletWraper.getInstance().get_account_object(resultBean.getId());
                try {
                    List<asset> list = BitsharesWalletWraper.getInstance().list_account_balance(accountObject.id, true);
                    for (int i = 0; i < list.size(); i++) {
                        switch (list.get(i).asset_id.get_userId()) {
                            case "1.3.0":
                                seerAmount = NumerUtil.getSeerBigDecimal(String.valueOf(list.get(i).amount));
                                break;
                            case "1.3.5":
                                usdtAmount = NumerUtil.getUsdtBigDecimal(String.valueOf(list.get(i).amount));
                                break;
                            case "1.3.2":
                                pfcAmount = NumerUtil.getPFCBigDecimal(String.valueOf(list.get(i).amount));
                                break;

                        }
                    }
                } catch (NetworkStatusException e) {
                    e.printStackTrace();
                }
                getSaveImportAccount(accountObject.name, seerAmount, pfcAmount, usdtAmount);
            } catch (NetworkStatusException e) {
                showInfoDialog(e.getMessage());
            }
            dismissLoadingDialog();
            Intent intent = new Intent(ImportWalletActivity.this, MainActivity.class);
            intent.putExtra("lanchMode", 1);
            startActivity(intent);
            finish();
        }
    }

    AppLocalWalletUser localWalletUser;

    /**
     * 保存通过导入助记词的用户
     */
    private void getSaveImportAccount(String name, String seer, String pfc, String usdt) {
        localWalletUser = new AppLocalWalletUser();
        localWalletUser.setLocalName(name);
        localWalletUser.setLocalPwd(pwd);
        localWalletUser.setLocalBrainKey(brainkey);
        localWalletUser.setLocalOwnerPrivateKey(null);
        localWalletUser.setLocalOwnerPublicKey(null);
        localWalletUser.setLocalActivePrivateKey(privateActiveKey);
        localWalletUser.setLocalActivePublicKey(publicActiveKey);
        localWalletUser.setAmoutSeerMoney(seer);
        localWalletUser.setAmountPFCMoney(pfc);
        localWalletUser.setAmountUsdtMoney(usdt);
        MyApp.localWalletUser = localWalletUser;
        FileSave.write(ImportWalletActivity.this, localWalletUser, "localwallet");
        MyApp.localWalletUser = (AppLocalWalletUser) FileSave.read(ImportWalletActivity.this, "localwallet");


    }

    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            dismissLoadingDialog();
            showInfoDialog(getString(R.string.checkmnemonic));

        }
    };

    @Override
    public void onError(BaseResponse.Error error) {
        handler.sendMessage(new Message());

    }
}
