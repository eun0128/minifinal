package com.petmeeting.joy.util;

import java.text.DecimalFormat;
import java.util.regex.Pattern;

public class ProductUtility {
	
	public static String priceFormat(int num) {
		DecimalFormat df = new DecimalFormat("#,###");
		return df.format(num);
	}
	
	public static String phoneNumberFormat(String phoneNoStr) {
	 
	      String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
	      if(!Pattern.matches(regEx, phoneNoStr)) {
	    	  return null;
	      }
	      return phoneNoStr.replaceAll(regEx, "$1-$2-$3");
	}
}
