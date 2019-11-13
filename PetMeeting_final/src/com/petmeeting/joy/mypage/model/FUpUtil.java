package com.petmeeting.joy.mypage.model;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.petmeeting.joy.login.model.MemberDto;

public class FUpUtil {

	// 참고..solution 업체(utility 함수 만드는 업무 많음 : 사용자 편의성 고려해야하기 때문에)
	
	// f = myfile.txt
	// f.indexOf('.') => "6" ( .의 위치 가져온다 )
	// f.substring( 6 ) => ".txt"
	// f.substring( 0,6 ) => "myfile" (파일명 얻어오기)	
	
	// 파일명 변경하는 메소드	 ( myfile.txt -> 2234124.txt )
	public static String getNewFileName(String filename, String filecase, String usernickname) {//매개변수 = 원본 파일명
		String newfilename = "";
		String fpost = "";
	
		// 업로드한 파일이 jsp가 아니면 ..? png 일경우 .png 만 떼서 qqq_profile 에 붙여.. 저장할땐 qqq_profile.png
		if(filename.indexOf('.') >= 0) {	
			fpost = filename.substring( filename.indexOf('.') );		// .jpg 파일포맷 부분 얻기 
			newfilename = usernickname + filecase + fpost;	//--> qqq + _profile + .jsp			
		}else { // 확장자명이 없는 파일의 경우
			//newfilename = new Date().getTime() + ".back"; //backup
			newfilename = "";
		}
		return newfilename;
	}
	
	public static boolean delOldFile(String fupload, String oldfilename ) {
		boolean b;
		File oldfile = new File( fupload + "/" + oldfilename);
		
		if( oldfile.exists() ){
			if( oldfile.delete() ){
    			System.out.println("파일삭제 성공");
    			b = true;
    		}else{
    			System.out.println("파일삭제 실패");
    			b = false;
    		}
			
		}else{ 
			System.out.println("파일이 존재하지 않습니다.");
			b = false;
		}
		return b;
	}
	
	
	
	
	
	
	
	
}
