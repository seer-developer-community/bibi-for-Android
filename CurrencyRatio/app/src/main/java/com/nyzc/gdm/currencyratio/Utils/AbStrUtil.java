package com.nyzc.gdm.currencyratio.Utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AbStrUtil {

	/**
	 * 描述：判断一个字符串是否为null或空值.
	 * 
	 * @param str
	 *            指定的字符串
	 * @return true or false
	 */
	public static boolean isEmpty(String str) {
		return str == null || str.trim().length() == 0;
	}

	/**
	 * 描述：是否只是字母和数字.
	 * 
	 * @param str
	 *            指定的字符串
	 * @return 是否只是字母和数字:是为true，否则false
	 */
	public static Boolean isNumberLetter(String str) {
		Boolean isNoLetter = false;
		String expr = "^[A-Za-z0-9]+$";
		if (str.matches(expr)) {
			isNoLetter = true;
		}
		return isNoLetter;
	}

	/**
	 * 描述：获取字符串的长度.
	 * 
	 * @param str
	 *            指定的字符串
	 * @return 字符串的长度（中文字符计2个）
	 */
	public static int strLength(String str) {
		int valueLength = 0;
		String chinese = "[\u0391-\uFFE5]";
		if (!isEmpty(str)) {
			// 获取字段值的长度，如果含中文字符，则每个中文字符长度为2，否则为1
			for (int i = 0; i < str.length(); i++) {
				// 获取一个字符
				String temp = str.substring(i, i + 1);
				// 判断是否为中文字符
				if (temp.matches(chinese)) {
					// 中文字符长度为2
					valueLength += 2;
				} else {
					// 其他字符长度为1
					valueLength += 1;
				}
			}
		}
		return valueLength;
	}

	/**
	 * 描述：手机号格式验证.
	 * 
	 * @param str
	 *            指定的手机号码字符串
	 * @return 是否为手机号码格式:是为true，否则false
	 */
	public static Boolean isMobileNo(String str) {
		Boolean isMobileNo = false;
		try {
			Pattern p = Pattern
					.compile("^((13[0-9])|(15[0-9])|(17[0-9])|(18[0,1,4,5-9]))\\d{8}$");
			Matcher m = p.matcher(str);
			isMobileNo = m.matches();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isMobileNo;
	}

	/**
	 * 描述：是否包含中文.
	 * 
	 * @param str
	 *            指定的字符串
	 * @return 是否包含中文:是为true，否则false
	 */
	public static Boolean isContainChinese(String str) {
		Boolean isChinese = false;
		String chinese = "[\u0391-\uFFE5]";
		if (!isEmpty(str)) {
			// 获取字段值的长度，如果含中文字符，则每个中文字符长度为2，否则为1
			for (int i = 0; i < str.length(); i++) {
				// 获取一个字符
				String temp = str.substring(i, i + 1);
				// 判断是否为中文字符
				if (temp.matches(chinese)) {
					isChinese = true;
				} else {

				}
			}
		}
		return isChinese;
	}

	// 邮箱验证
	public static boolean emailFormat(String email) {
		Pattern pattern = Pattern
				.compile("^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$");
		Matcher mat = pattern.matcher(email);
		return mat.matches();
	}

	// 密码验证
	public static boolean passwordFormat(String email) {
		Pattern pattern = Pattern
				.compile("^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$");
		Matcher mat = pattern.matcher(email);
		return mat.matches();
	}
}
