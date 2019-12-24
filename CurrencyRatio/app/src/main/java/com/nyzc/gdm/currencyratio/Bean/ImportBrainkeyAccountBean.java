package com.nyzc.gdm.currencyratio.Bean;

import java.io.Serializable;

public class ImportBrainkeyAccountBean implements Serializable {


    private String import_brainkey;
    private String import_account_pwd;

    public String getImport_brainkey() {
        return import_brainkey;
    }

    public void setImport_brainkey(String import_brainkey) {
        this.import_brainkey = import_brainkey;
    }

    public String getImport_account_pwd() {
        return import_account_pwd;
    }

    public void setImport_account_pwd(String import_account_pwd) {
        this.import_account_pwd = import_account_pwd;
    }

    @Override
    public String toString() {
        return "ImportBrainkeyAccountBean{" +
                "import_brainkey='" + import_brainkey + '\'' +
                ", import_account_pwd='" + import_account_pwd + '\'' +
                '}';
    }
}
