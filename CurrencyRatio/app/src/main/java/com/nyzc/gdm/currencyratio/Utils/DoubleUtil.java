package com.nyzc.gdm.currencyratio.Utils;

import java.text.DecimalFormat;
import java.text.NumberFormat;

public class DoubleUtil {


    /**
     * 字符串转换百分比
     *
     * @param progres
     * @return
     */
    public static String doubolePercent(String progres) {
        double pro = Double.valueOf(progres);
        Double rate = pro;
        NumberFormat num = NumberFormat.getPercentInstance();
        return num.format(rate);
    }

    /**
     * double转换百分比
     * @param progres
     * @return
     */
    public static String doubolePercent2(double progres) {
        Double rate = progres;
        NumberFormat num = NumberFormat.getPercentInstance();
        return num.format(rate);
    }
    /**
     * 保留两位小数
     * @param progresss
     * @return
     */
    public static String savedouble(double progresss) {
        double d = progresss;
        DecimalFormat df = new DecimalFormat("#.00");
        return df.format(d);
    }
}
