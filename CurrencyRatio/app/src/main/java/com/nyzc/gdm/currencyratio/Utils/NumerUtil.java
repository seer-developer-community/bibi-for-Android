package com.nyzc.gdm.currencyratio.Utils;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class NumerUtil {

    public static final int fee = 0;
    public static final String commenSeerFee = "100000";
    public static final String commenUsdtFee = "100";
    public static final String commenPFCFee = "100000";
    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    // 判断一个字符串是否含有数字
    public static boolean HasDigit(String content) {
        boolean flag = false;
        Pattern p = Pattern.compile(".*\\d+.*");
        Matcher m = p.matcher(content);
        if (m.matches()) {
            flag = true;
        }
        return flag;
    }

    public static String saveFiveDouble(Double d) {
        DecimalFormat df = new DecimalFormat("#.00000");
        String str = df.format(d);
        return str;
    }

    public static String getBigDecimal(String amounts, String rewards) {
        BigDecimal bigDecimal = new BigDecimal(rewards).divide(new BigDecimal(amounts), 4, BigDecimal.ROUND_DOWN).stripTrailingZeros();
        return bigDecimal.toPlainString();
    }

    public static String getSeerBigDecimal(String amount) {
        BigDecimal bigDecimal = new BigDecimal(amount).divide(new BigDecimal(commenSeerFee)).stripTrailingZeros();
        return bigDecimal.toPlainString();
    }

    public static String getUsdtBigDecimal(String amount) {
        BigDecimal bigDecimal = new BigDecimal(amount).divide(new BigDecimal(commenUsdtFee)).stripTrailingZeros();
        return bigDecimal.toPlainString();
    }

    public static String getPFCBigDecimal(String amount) {
        BigDecimal bigDecimal = new BigDecimal(amount).divide(new BigDecimal(commenPFCFee)).stripTrailingZeros();
        return bigDecimal.toPlainString();
    }

    public static String getOrderRate(int winNum, int orderNum) {
        BigDecimal bigDecimal = new BigDecimal(String.valueOf(winNum)).divide(new BigDecimal(String.valueOf(orderNum)), 2, BigDecimal.ROUND_DOWN).stripTrailingZeros();
        BigDecimal winRate = new BigDecimal(String.valueOf(bigDecimal.toPlainString())).multiply(new BigDecimal(commenUsdtFee)).stripTrailingZeros();
        return winRate.toPlainString();
    }

    public static String getBigDecimalAdd(String amount, String fee) {
        BigDecimal bigDecimal = new BigDecimal(amount).add(new BigDecimal(fee)).stripTrailingZeros();
        return bigDecimal.toPlainString();
    }

    public static String getBigUsdtDecimalAdd(String amount, String fee) {
        BigDecimal bigDecimal = new BigDecimal(amount).add(new BigDecimal(fee)).stripTrailingZeros();
        return bigDecimal.toPlainString();
    }

    public static String getExcepetAmount(String amount, String fee) {
        BigDecimal bigDecimal = new BigDecimal(amount).subtract(new BigDecimal(fee)).stripTrailingZeros();
        return bigDecimal.toPlainString();
    }

    public static boolean getGMTStopTime(String time) {
        try {
            Date d = new Date();
            String GTM = DateUtil.downDateMinut(sdf.format(d), 8);
            d = sdf.parse(GTM);
            Date dt1 = sdf.parse(time);
            if (d.getTime() < dt1.getTime()) {
                return true;

            } else {
                return false;
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean getStopTime(String time) {
        try {
            Date d = new Date();
            Date dt1 = sdf.parse(time);
            if (d.getTime() < dt1.getTime()) {
                return true;

            } else {
                return false;
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return false;
    }


}
