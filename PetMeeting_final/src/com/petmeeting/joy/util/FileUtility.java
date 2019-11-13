package com.petmeeting.joy.util;

import java.util.Date;

public class FileUtility {
	// f = myfile.txt 	=> f.indexOf('.') -> 6
	// 					=> f.substring(6) -> .txt
	// 					=> f.substring(0, 6) -> myfile
	
	// myfile.txt ----> 1213545.txt 변경
	public static String getNewFileName(String f) {
		String filename = "";
		String fpost = "";
		if(f.indexOf('.') >= 0) {	
			fpost = f.substring(f.indexOf('.'));	// 확장자명
			filename = new Date().getTime() + fpost;	// 숫자 + 확장자명
		}else {	// 확장자명이 없을 때
			filename = new Date().getTime() + ".back";	// 임의로 확장자명 지정
		}
		
		return filename;
	}
}
