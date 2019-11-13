package com.petmeeting.joy.util;

import java.io.IOException;
import java.util.Random;

public class SendSMS {

	
	
	public  SendSMS(String phone,String msg) {
		

		
	        SMS sms = new SMS();

	        

	        sms.appversion("TEST/1.0");

	        sms.charset("utf8");

	        sms.setuser("hwwk78", "Gus294276!");				// coolsms 계정 입력해주시면되요



	        String number[] = new String[1];                                  // 받을 사람 폰번호

	        number[0] =phone;
	   		
	        

	        for( int i = 0 ; i < number.length ; i ++ ) {

		        SmsMessagePdu pdu = new SmsMessagePdu();

		        pdu.type = "SMS";

		        pdu.destinationAddress = number[i];

		        pdu.scAddress = phone;                 // 발신자 번호          

		        
		        
		        pdu.text = msg;					    // 보낼 메세지 내용

		        sms.add(pdu);

		

		        try {

		            sms.connect();

		            sms.send();

		            sms.disconnect();

		        } catch (IOException e) {

		            System.out.println(e.toString());

		        }

		        sms.printr();

		        sms.emptyall();

		    }
	        
	        
	    
	}
}
