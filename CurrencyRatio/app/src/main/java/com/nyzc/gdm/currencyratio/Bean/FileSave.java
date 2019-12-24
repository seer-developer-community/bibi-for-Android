package com.nyzc.gdm.currencyratio.Bean;

import android.content.Context;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

public class FileSave implements Serializable {

    /**
     * 写入本地文件
     *
     * @param context
     * @param obj
     * @param fileName
     */
    public static void write(Context context, Object obj, String fileName) {
        try {
            ByteArrayOutputStream bout = new ByteArrayOutputStream();
            ObjectOutputStream oout = new ObjectOutputStream(bout);
            oout.writeObject(obj);
            oout.flush();
            oout.close();
            bout.close();
            byte[] b = bout.toByteArray();
            File file = new File(context.getFilesDir(), fileName);
            FileOutputStream out = new FileOutputStream(file);
            out.write(b);
            out.flush();
            out.close();
        } catch (Exception e) {
        } finally {

        }
    }

    /**
     * 从本地文件读取
     *
     * @param context
     * @param fileName
     * @return
     */
    public static Object read(Context context, String fileName) {
        // 拿出持久化数据
        Object obj = null;
        try {
            File file = new File(context.getFilesDir(), fileName);
            FileInputStream in = new FileInputStream(file);
            ObjectInputStream oin = new ObjectInputStream(in);
            obj = oin.readObject();
            in.close();
            oin.close();
        } catch (Exception e) {
        }
        return obj;
    }

    /**
     * 删除文件
     * @param context
     * @param fileName
     * @return
     */
    public static boolean deleteFile(Context context, String fileName) {
        File file = new File(context.getFilesDir(), fileName);
        if (file.exists()) {
            file.delete();
            return true;
        }
        return false;
    }
}
