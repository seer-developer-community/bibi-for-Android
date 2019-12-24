package com.nyzc.gdm.currencyratio.Bean;

import java.util.List;

public class ApkVersionInfo {

    private List<ResultBean> result;

    public List<ResultBean> getResult() {
        return result;
    }

    public void setResult(List<ResultBean> result) {
        this.result = result;
    }

    public static class ResultBean {
        /**
         * iosVersion : 1.0.3
         * iosReleaseNotesCn : 增加版本控制功能
         * iosReleaseNotesEn : Add Version Control Function
         * iosIsforce : true
         * iosUpdataurl : https://66.aso.cool/app.php/ODM=
         * androidVersion : 1.0.2
         * androidReleaseNotesCn : 增加版本控制功能
         * androidReleaseNotesEn : Add Version Control Function
         * androidIsforce : true
         * androidUpdataurl : https://download.seer.best/bibi.apk
         */

        private String iosVersion;
        private String iosReleaseNotesCn;
        private String iosReleaseNotesEn;
        private String iosIsforce;
        private String iosUpdataurl;
        private String androidVersion;
        private String androidReleaseNotesCn;
        private String androidReleaseNotesEn;
        private String androidIsforce;
        private String androidUpdataurl;

        public String getIosVersion() {
            return iosVersion;
        }

        public void setIosVersion(String iosVersion) {
            this.iosVersion = iosVersion;
        }

        public String getIosReleaseNotesCn() {
            return iosReleaseNotesCn;
        }

        public void setIosReleaseNotesCn(String iosReleaseNotesCn) {
            this.iosReleaseNotesCn = iosReleaseNotesCn;
        }

        public String getIosReleaseNotesEn() {
            return iosReleaseNotesEn;
        }

        public void setIosReleaseNotesEn(String iosReleaseNotesEn) {
            this.iosReleaseNotesEn = iosReleaseNotesEn;
        }

        public String getIosIsforce() {
            return iosIsforce;
        }

        public void setIosIsforce(String iosIsforce) {
            this.iosIsforce = iosIsforce;
        }

        public String getIosUpdataurl() {
            return iosUpdataurl;
        }

        public void setIosUpdataurl(String iosUpdataurl) {
            this.iosUpdataurl = iosUpdataurl;
        }

        public String getAndroidVersion() {
            return androidVersion;
        }

        public void setAndroidVersion(String androidVersion) {
            this.androidVersion = androidVersion;
        }

        public String getAndroidReleaseNotesCn() {
            return androidReleaseNotesCn;
        }

        public void setAndroidReleaseNotesCn(String androidReleaseNotesCn) {
            this.androidReleaseNotesCn = androidReleaseNotesCn;
        }

        public String getAndroidReleaseNotesEn() {
            return androidReleaseNotesEn;
        }

        public void setAndroidReleaseNotesEn(String androidReleaseNotesEn) {
            this.androidReleaseNotesEn = androidReleaseNotesEn;
        }

        public String getAndroidIsforce() {
            return androidIsforce;
        }

        public void setAndroidIsforce(String androidIsforce) {
            this.androidIsforce = androidIsforce;
        }

        public String getAndroidUpdataurl() {
            return androidUpdataurl;
        }

        public void setAndroidUpdataurl(String androidUpdataurl) {
            this.androidUpdataurl = androidUpdataurl;
        }
    }
}
