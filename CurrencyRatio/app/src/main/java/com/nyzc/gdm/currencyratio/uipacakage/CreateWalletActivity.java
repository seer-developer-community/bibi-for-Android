package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Message;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;
import com.nyzc.gdm.currencyratio.Base.MyApp;
import com.nyzc.gdm.currencyratio.Base.AppLocalWalletUser;
import com.nyzc.gdm.currencyratio.Base.BaseActivity;
import com.nyzc.gdm.currencyratio.Bean.AccountGraphenejBean;
import com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper;
import com.nyzc.gdm.currencyratio.BiBiPacakage.account_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.exception.NetworkStatusException;
import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.FileUtils;
import com.nyzc.gdm.currencyratio.Utils.KeyBoardUtils;
import com.nyzc.gdm.currencyratio.View.CustomTitleBar;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import butterknife.BindView;
import cy.agorise.graphenej.Address;
import cy.agorise.graphenej.BrainKey;
import cy.agorise.graphenej.PublicKey;
public class CreateWalletActivity extends BaseActivity implements View.OnClickListener {


    @BindView(R.id.custom_title)
    CustomTitleBar customTitle;
    @BindView(R.id.tv_create_wallet_name)
    TextView tvCreateWalletName;
    @BindView(R.id.edit_input_wallet_name)
    EditText editInputWalletName;
    @BindView(R.id.rela_wallet_name)
    RelativeLayout relaWalletName;
    @BindView(R.id.view1)
    View view1;
    @BindView(R.id.tv_create_wallet_pwd)
    TextView tvCreateWalletPwd;
    @BindView(R.id.edit_input_wallet_pwd)
    EditText editInputWalletPwd;
    @BindView(R.id.rela_wallet_pwd)
    RelativeLayout relaWalletPwd;
    @BindView(R.id.view2)
    View view2;
    @BindView(R.id.tv_create_wallet_pwd_again)
    TextView tvCreateWalletPwdAgain;
    @BindView(R.id.edit_input_wallet_pwd_again)
    EditText editInputWalletPwdAgain;
    @BindView(R.id.rela_wallet_pwd_again)
    RelativeLayout relaWalletPwdAgain;
    @BindView(R.id.rela_create_wallet)
    RelativeLayout relaCreateWallet;
    @BindView(R.id.iv_agree_service)
    ImageView ivAgreeService;
    @BindView(R.id.tv_service_agreement)
    TextView tvServiceAgreement;
    @BindView(R.id.ll_read_service)
    LinearLayout llReadService;
    @BindView(R.id.tv_create_wallet)
    TextView tvCreateWallet;

    public static void start(Context context) {
        Intent starter = new Intent(context, CreateWalletActivity.class);
        context.startActivity(starter);
    }


    @Override
    public int getLayoutId() {
        return R.layout.activity_create_wallet;
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
        ivAgreeService.setOnClickListener(this);
        tvCreateWallet.setOnClickListener(this);
        tvServiceAgreement.setOnClickListener(view -> ServiceActivity.start(CreateWalletActivity.this, 1));
        ivAgreeService.setSelected(true);
    }

    @Override
    public void onNetChange(boolean netWorkState) {
        super.onNetChange(netWorkState);

    }

    /**
     * 该方法主要使用正则表达式来判断字符串中是否包含字母
     *
     * @param cardNum 待检验的原始卡号
     * @return 返回是否包含
     * @author fenggaopan 2015年7月21日 上午9:49:40
     */
    public boolean judgeContainsStr(String cardNum) {
        String regex = ".*[a-zA-Z]+.*";
        Matcher m = Pattern.compile(regex).matcher(cardNum);
        return m.matches();
    }

    public static boolean isContainNumber(String company) {
        Pattern p = Pattern.compile("[0-9]");
        Matcher m = p.matcher(company);
        if (m.find()) {
            return true;
        }
        return false;
    }

    account_object accountObject = null;

    /**
     * 创建钱包前 先查询创建的用户名是否存在
     * @param view
     */
    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.iv_agree_service:
                if (ivAgreeService.isSelected()) {
                    ivAgreeService.setSelected(false);
                } else {
                    ivAgreeService.setSelected(true);
                }
                break;
            case R.id.tv_create_wallet:
                name = editInputWalletName.getText().toString().trim();
                pwd = editInputWalletPwd.getText().toString().trim();
                boolean isContain = isContainNumber(name);
                if (TextUtils.isEmpty(name)) {
                    Toast.makeText(this, getString(R.string.PleaseEnterUsername), Toast.LENGTH_SHORT).show();
                    return;
                } else {
                    if (name.length() < 6) {
                        Toast.makeText(this, getString(R.string.nolessthanusename), Toast.LENGTH_SHORT).show();
                        return;
                    }
                    if (!isContain) {
                        Toast.makeText(this, getString(R.string.usernamejudgenum), Toast.LENGTH_SHORT).show();
                        return;
                    }
                    if (!judgeContainsStr(String.valueOf(name.charAt(0)))) {
                        Toast.makeText(this, getString(R.string.alphabetic), Toast.LENGTH_SHORT).show();
                        return;
                    }
                    if (!name.matches("^[a-z0-9]")) {
                        for (int i = 0; i < name.length(); i++) {
                            if (Character.isUpperCase(name.charAt(i))) {
                                Toast.makeText(this, getString(R.string.capitalletters), Toast.LENGTH_SHORT).show();
                                return;
                            }
                        }
                    }
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
                if (TextUtils.isEmpty(editInputWalletPwdAgain.getText().toString())) {
                    Toast.makeText(this, getString(R.string.PleaseRepeatPassword), Toast.LENGTH_SHORT).show();
                    return;
                }
                if (!editInputWalletPwdAgain.getText().toString().equals(editInputWalletPwd.getText().toString())) {
                    Toast.makeText(CreateWalletActivity.this, getString(R.string.Inconsistentpassword), Toast.LENGTH_SHORT).show();
                    return;
                }
                if (!ivAgreeService.isSelected()) {
                    Toast.makeText(this, getString(R.string.checkAddress), Toast.LENGTH_SHORT).show();
                    return;
                }
                try {
                    fileUtils = new FileUtils(CreateWalletActivity.this);
                    fileString = fileUtils.readFromAssets();
                    brainkeyRandom = BrainKey.suggest(fileString);
                    CreateBrainkey(DEFAULT_SEQUENCE_NUMBER_0);
                    CreateBrainkey(DEFAULT_SEQUENCE_NUMBER_1);
                    accountGraphenejBean.setAccount(CreateAccount(name));
                    MyApp.accountGraphenejBean = accountGraphenejBean;
                    if (BitsharesWalletWraper.getInstance().build_connect() == 0) {
                        accountObject = BitsharesWalletWraper.getInstance().get_account_object(name);
                        if (accountObject == null) {
                            CreateLocalWallet(name, pwd, brainkeyRandom, privateActiveKey, publicActiveKey, privateOwnerKeys, publicOwnerKeys);
                        } else {
                            KeyBoardUtils.hideSoftKeyboard(CreateWalletActivity.this);
                            showInfoDialog(getString(R.string.accountExists));
                        }
                    }
                } catch (NetworkStatusException e) {
                    showInfoDialog(e.getMessage());
                }


                break;
        }
    }

    String name;
    String pwd;
    AccountGraphenejBean accountGraphenejBean = new AccountGraphenejBean();

    private AccountGraphenejBean.AccountBean CreateAccount(String name) {
        graphenejBean = new AccountGraphenejBean.AccountBean();
        graphenejBean.setOwner_key(publicOwnerKeys);
        graphenejBean.setActive_key(publicActiveKey);
        graphenejBean.setMemo_key(publicActiveKey);
        graphenejBean.setName(name);
        graphenejBean.setRefcode("");
        graphenejBean.setReferrer("");
        return graphenejBean;
    }


    private FileUtils fileUtils;
    private String fileString;
    private String brainkeyRandom, privateOwnerKeys, publicOwnerKeys, privateActiveKey, publicActiveKey;
    private Address address;
    private PublicKey publicAddress;
    public static final int DEFAULT_SEQUENCE_NUMBER_0 = 0;
    public static final int DEFAULT_SEQUENCE_NUMBER_1 = 1;
    AccountGraphenejBean.AccountBean graphenejBean;
    BrainKey mBrainKey;

    /**
     * 随机生出助记词 生成两对公私钥
     */

    private void CreateBrainkey(int DEFAULT_SEQUENCE_NUMBER) {
        try {
            mBrainKey = new BrainKey(brainkeyRandom, DEFAULT_SEQUENCE_NUMBER);
            address = mBrainKey.getPublicAddress(Address.BITSHARES_PREFIX);
            publicAddress = address.getPublicKey();
            if (DEFAULT_SEQUENCE_NUMBER == 0) {
                publicActiveKey = publicAddress.getAddress();
                privateActiveKey = mBrainKey.getWalletImportFormat();
            } else {
                publicOwnerKeys = publicAddress.getAddress();
                privateOwnerKeys = mBrainKey.getWalletImportFormat();
            }
        } catch (Exception e) {
            showInfoDialog(e.getMessage());
        }
    }

    AppLocalWalletUser localWalletUser = null;


    /**
     * 创建钱包
     */
    private void CreateLocalWallet(String name, String pwd, String brainkey, String
            privateActiveKey, String publicActiverKey, String privateOwerKey, String publicOwerkey) {
        try {
            localWalletUser = new AppLocalWalletUser();
            localWalletUser.setLocalName(name);
            localWalletUser.setLocalPwd(pwd);
            localWalletUser.setLocalBrainKey(brainkey);
            localWalletUser.setLocalOwnerPublicKey(publicOwerkey);
            localWalletUser.setLocalOwnerPrivateKey(privateOwerKey);
            localWalletUser.setLocalActivePrivateKey(privateActiveKey);
            localWalletUser.setLocalActivePublicKey(publicActiverKey);
//            localWalletUser.setAmoutMoney("");
            MyApp.localWalletUser = localWalletUser;
            SaveBrainKeyActivity.start(CreateWalletActivity.this, MyApp.localWalletUser);
        }catch (Exception e){
            showInfoDialog(e.getMessage());
        }

    }


}
