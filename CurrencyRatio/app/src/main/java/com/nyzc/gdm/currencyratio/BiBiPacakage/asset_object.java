package com.nyzc.gdm.currencyratio.BiBiPacakage;

import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.asset_dynamic_data_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.chain.asset_options;
import com.nyzc.gdm.currencyratio.BiBiPacakage.util.NumericUtil;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

public class asset_object implements Serializable {
    public class asset_object_legible implements Serializable {
        public String count;
        public String decimal;
        public String symbol;
        public long lCount;
        public long lDecimal;
        public long scaled_precision;
    }

    //static const uint8_t space_id = protocol_ids;
    //static const uint8_t type_id  = asset_object_type;
    /// Ticker symbol for this asset, i.e. "USD"
    public object_id<asset_object> id;
    public String symbol;
    /// Maximum number of digits after the decimal point (must be <= 12)
    public int precision = 0;
    /// ID of the account which issued this asset.
    object_id<account_object> issuer;

    public asset_options options;

    /// Current supply, fee pool, and collected fees are stored in a separate object as they change frequently.
    object_id<asset_dynamic_data_object> dynamic_asset_data_id;


    public asset amount_from_string(String strAmount) {
        //strAmount.matches();
        // TODO: 07/09/2017 需要正则表达处理

        long precisionScaled = 1;
        String strDecimalFormat = "0";

        if (precision > 0) {
            strDecimalFormat = strDecimalFormat.concat(".");
            for (int i = 0; i < precision; ++i) {
                precisionScaled *= 10;
                strDecimalFormat = strDecimalFormat.concat("0");
            }
        }

        // 精度截取
        DecimalFormat decimalFormat = new DecimalFormat(strDecimalFormat, new DecimalFormatSymbols(Locale.ENGLISH));
        String strFormatAmount = decimalFormat.format(NumericUtil.parseDouble(strAmount));

        double result = NumericUtil.parseDouble(strFormatAmount);
        long resultAmount = (long) (result * precisionScaled);

        asset assetObject = new asset(resultAmount, id);
        return assetObject;
    }

    public long amount_from_long(String strAmount) {
        //strAmount.matches();
        // TODO: 07/09/2017 需要正则表达处理

        long precisionScaled = 1;
        String strDecimalFormat = "0";

        if (precision > 0) {
            strDecimalFormat = strDecimalFormat.concat(".");
            for (int i = 0; i < precision; ++i) {
                precisionScaled *= 10;
                strDecimalFormat = strDecimalFormat.concat("0");
            }
        }

        // 精度截取
        DecimalFormat decimalFormat = new DecimalFormat(strDecimalFormat, new DecimalFormatSymbols(Locale.ENGLISH));
        String strFormatAmount = decimalFormat.format(NumericUtil.parseDouble(strAmount));

        double result = NumericUtil.parseDouble(strFormatAmount);
        long resultAmount = (long) (result * precisionScaled);

        return resultAmount;
    }

    public long get_scaled_precision() {
        long scaled_precision = 1;
        for (int i = 0; i < precision; ++i) {
            scaled_precision *= 10;
        }
        return scaled_precision;
    }
}
