package com.nyzc.gdm.currencyratio.Bean;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.List;

public class RegistError implements Serializable {

    /**
     * error : {"remote_ip":["Can't register more than one account per IP in less than 5 minutes"]}
     */

    private ErrorBean error;
    /**
     * error : {"base":["Account exists"]}
     */


    public ErrorBean getError() {
        return error;
    }

    public void setError(ErrorBean error) {
        this.error = error;
    }


    public static class ErrorBean {
        private List<String> remote_ip;
        private List<String> base;

        public List<String> getBase() {
            return base;
        }

        public void setBase(List<String> base) {
            this.base = base;
        }

        public List<String> getRemote_ip() {
            return remote_ip;
        }

        public void setRemote_ip(List<String> remote_ip) {
            this.remote_ip = remote_ip;
        }
    }

}
