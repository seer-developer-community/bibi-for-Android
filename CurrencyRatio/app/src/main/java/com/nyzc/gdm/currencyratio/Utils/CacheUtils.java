package com.nyzc.gdm.currencyratio.Utils;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * 作者：${xuchangqing} on 2016/5/5 09:08
 * 邮箱：xcq_922@163.com
 * sp 存储用户信息
 */
public class CacheUtils {
    private static String FILE_NAME = "flasherrands";
    private static SharedPreferences sp;

    // 保存boolean值
    public static void putBoolean(Context context, String key, boolean value) {
        if (sp == null) {
            sp = context.getSharedPreferences(FILE_NAME, Context.MODE_PRIVATE);
        }
        sp.edit().putBoolean(key, value).commit();
    }

    // 取boolean值
    public static boolean getBoolean(Context context, String key,
                                     boolean defValue) {
        if (sp == null) {
            sp = context.getSharedPreferences(FILE_NAME, Context.MODE_PRIVATE);
        }
        return sp.getBoolean(key, defValue);
    }


    public static void putString(Context context, String key, String value) {
        if (sp == null) {
            sp = context.getSharedPreferences(FILE_NAME, Context.MODE_PRIVATE);
        }
        sp.edit().putString(key, value).commit();
    }

    public static String getString(Context context, String key, String defValue) {
        if (sp == null) {
            sp = context.getSharedPreferences(FILE_NAME, Context.MODE_PRIVATE);
        }
        return sp.getString(key, defValue);
    }
}
