package com.petmeeting.joy.mypage.util;

import java.util.Date;

public class MypageTimeUtil {

	public static final int SEC = 60;
    public static final int MIN = 60;
    public static final int HOUR = 24;
    public static final int DAY = 30;
    public static final int MONTH = 12;
    
    public MypageTimeUtil() {

    }
    
   
    public static String calculateTime(Date date){
    	 long curTime = System.currentTimeMillis();
    	 long regTime = date.getTime();
    	 long diffTime = (curTime - regTime) / 1000;
    	 
    	 String msg = null;

    	    if (diffTime < MypageTimeUtil.SEC)
    	    {
    	        // sec
    	        msg = "방금";
    	    }
    	    else if ((diffTime /= MypageTimeUtil.SEC) < MypageTimeUtil.MIN)
    	    {
    	        // min
    	        System.out.println(diffTime);
    	        
    	        msg = diffTime + "분전";
    	    }
    	    else if ((diffTime /= MypageTimeUtil.MIN) < MypageTimeUtil.HOUR)
    	    {
    	        // hour
    	        msg = (diffTime ) + "시간전";
    	    }
    	    else if ((diffTime /= MypageTimeUtil.HOUR) < MypageTimeUtil.DAY)
    	    {
    	        // day
    	        msg = (diffTime ) + "일전";
    	    }
    	    else if ((diffTime /= MypageTimeUtil.DAY) < MypageTimeUtil.MONTH)
    	    {
    	        // day
    	        msg = (diffTime ) + "달전";
    	    }
    	    else
    	    {
    	        msg = (diffTime) + "년전";
    	    }
    	    
    	    return msg;

    }
    
}
