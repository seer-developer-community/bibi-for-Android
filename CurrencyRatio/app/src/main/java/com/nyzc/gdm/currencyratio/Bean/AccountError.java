package com.nyzc.gdm.currencyratio.Bean;

import java.io.Serializable;
import java.util.List;

public class AccountError implements Serializable {


    /**
     * error : {"base":["Account exists"]}
     */

    private ErrorBean error;

    public ErrorBean getError() {
        return error;
    }

    public void setError(ErrorBean error) {
        this.error = error;
    }

    public static class ErrorBean {
        private List<String> base;

        public List<String> getBase() {
            return base;
        }

        public void setBase(List<String> base) {
            this.base = base;
        }
    }
}
