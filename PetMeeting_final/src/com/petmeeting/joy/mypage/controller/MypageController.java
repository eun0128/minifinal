package com.petmeeting.joy.mypage.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.funding.model.FundingDto;
import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.mypage.model.FUpUtil;
import com.petmeeting.joy.mypage.model.MyGradeDto;
import com.petmeeting.joy.mypage.model.MyPetProfileDto;
import com.petmeeting.joy.mypage.model.MyProfileDto;
import com.petmeeting.joy.mypage.model.MyProfileParam;
import com.petmeeting.joy.mypage.model.MypageFollowDto;
import com.petmeeting.joy.mypage.model.MypageFollowListParam;
import com.petmeeting.joy.mypage.model.MypageFollowparam;
import com.petmeeting.joy.mypage.model.MypageListParam;
import com.petmeeting.joy.mypage.model.MypageMemberleave;
import com.petmeeting.joy.mypage.model.MypageMsgDto;
import com.petmeeting.joy.mypage.model.MypageMsgParam;
import com.petmeeting.joy.mypage.model.MypagePointListParam;
import com.petmeeting.joy.mypage.model.Mypagememandpet;
import com.petmeeting.joy.mypage.model.MypagemylikeDto;
import com.petmeeting.joy.mypage.model.MypagemylikefreeboardDto;
import com.petmeeting.joy.mypage.model.Mypagewebpush;
import com.petmeeting.joy.mypage.model.PointHistoryDto;
import com.petmeeting.joy.mypage.service.mypageService;
import com.petmeeting.joy.mypage.util.MypageDateUtil;
import com.petmeeting.joy.playboard.Util.PlayboardUtil;
import com.petmeeting.joy.playboard.model.PlayboardDto;
import com.petmeeting.joy.util.SendSMS;



@Controller
public class MypageController {

	@Autowired
	mypageService mypageService;
	
	
	/*
	@RequestMapping(value = "mypagehome.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String mypagehome() {
		
		System.out.println("mypagehome");
		
		
		return "mypage/mypageHome";
	}
	*/
	
	@RequestMapping(value = "mypagePhoneCheck.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String mypagePhoneCheck() {
		
		System.out.println("mypagephonecheck1");
		
		System.out.println("mypagephonecheck2");
		return "mypage/mypagePhonecheck";
	}
	
	
	  //인증번호 받기 위한 ajax
	  @ResponseBody	 
	 @RequestMapping(value = "mypagePhonerandnumcheck.do", method= {RequestMethod.GET,  RequestMethod.POST}) 
	  public String mypagePhonerandnumcheck(String phone) {
		  
		  
		  Random rand=new Random();
			String numStr="";
			
			System.out.println("phone"+phone);
			
			
		
			for(int i=0;i<6;i++) {
				//0~9까지 난수 생성!
			   String ran=Integer.toString(rand.nextInt(10));	
			   numStr+=ran;
			
			}
			
			System.out.println("랜덤숫자"+numStr);

			
		
		 
		 SendSMS sms = new SendSMS(phone,"PetMeeting_인증번호["+numStr+"]") ;
		 
		 
		 
			return numStr;
	  }
	 
	  
	  
	  //인증을 완료 했을 때 오는 컨트롤러 
	  @RequestMapping(value = "mypagecertification.do" , method= {RequestMethod.GET,  RequestMethod.POST})
      public String mypagecertification (HttpServletRequest req) {
		  System.out.println("본인인증");
		   
		  MemberDto member=(MemberDto) req.getSession().getAttribute("login");
		  
		  System.out.println("member"+member.toString());
		  
		  mypageService.mypagecertification(member);
		  
		  
		  
		  return "mypage/mypageHome";
	  }
	
	  //
	  @RequestMapping(value = "mypagefollow.do", method= {RequestMethod.GET,  RequestMethod.POST} )
      public String mypagefollow(HttpServletRequest req,Model model,MypageFollowparam param,String page) {
		  
		  System.out.println("myfollow!");
          MemberDto member=(MemberDto) req.getSession().getAttribute("login");
         
          
          param.setMyemail(member.getEmail()); 
         if(param.getS_category()!=null) {
        	 List<MypageFollowDto> lists=mypageService.mypagefollowmorelist(param);
        	 model.addAttribute("listtotalsize", lists.size());
        	 model.addAttribute("mypagelist", lists);
        	 for(int i=0 ;i<lists.size();i++) {
        		 MypageFollowDto dto = lists.get(i);
        		 System.out.println("난 ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ보다 더 영향력있다!!!!!!"+dto.toString());
        	 }
         }else {

             //더보기를 위해 전체 리스트 크기 구함
             List<MypageFollowDto> lists=mypageService.myFollolistemail(member);
             for(int i=0 ;i<lists.size();i++) {
            	 MypageFollowDto dto = lists.get(i);
        		 System.out.println("난 gg보다 더 영향력있다!!!!!!"+dto.toString());
        	 }
             model.addAttribute("listtotalsize", lists.size());
       	     model.addAttribute("mypagelist", lists);
         }
          
         
		  return "mypage/mypageFollow";
	  }
	  
	
	  @RequestMapping(value = "mypageInfoupdate.do", method= {RequestMethod.GET,  RequestMethod.POST} )
      public String mypageInfoupdate(HttpServletRequest req ,Model model) {
		  
		  System.out.println("mypageInfoupdate");
          MemberDto member=(MemberDto) req.getSession().getAttribute("login");

          model.addAttribute("member", member);
          
		  System.out.println("member"+member.toString());
		  
		  
		  
		
		  
		  
		  return "mypage/mypageInfoupdate";
	  }
	
	  
	  @RequestMapping(value = "mypagefolloingdel.do", method= {RequestMethod.GET,  RequestMethod.POST} )
      public String mypagefolloingdel(HttpServletRequest req ,Model model) {
		  
		  System.out.println("mypagefolloingdel");
		  
		  String folloingemail=req.getParameter("folloingid");
		  MemberDto member=(MemberDto) req.getSession().getAttribute("login");
		  
		  mypageService.mypagefollowdel(new MypageFollowDto(member.getEmail(), folloingemail));
		  
		  
		  
	  
		  return "redirect:/mypagefollow.do";
	  }
	  
	  @ResponseBody
	  @RequestMapping(value = "mypagefollowmore.do", method= {RequestMethod.GET,  RequestMethod.POST} )
      public List<MypageFollowDto> mypagefollowmore(HttpServletRequest req,String page,MypageFollowparam param,Model model) {
		  
		  System.out.println("mypagefollowmore");
		  System.out.println("page"+page);
		  
		  
		  MemberDto member=(MemberDto) req.getSession().getAttribute("login");
		  param.setMyemail(member.getEmail());
		  param.setEnd((Integer.parseInt(page)+1)*param.getEnd());
		  param.setStart(param.getEnd()-5);
		  System.out.println("param"+param);
		  
		  
		
		  List<MypageFollowDto> list=mypageService.mypagefollowmorelist(param);
		 
		  
		  
		  
		  return list;
	  }

	  
	  @RequestMapping(value = "mypageMemberleave.do", method= {RequestMethod.GET,  RequestMethod.POST} )
      public String mypageMemberleave(HttpServletRequest req,String page,MypageFollowparam param,Model model) {
	     
		  System.out.println("mypageMemberleave");
	  
        return "mypage/mypageMemberleave";
	  }
	  
	  @ResponseBody
	  @RequestMapping(value = "mypageInfocheckpwd.do" , method= {RequestMethod.GET,  RequestMethod.POST} )
	  public String mypageInfocheckpw(HttpServletRequest req) {
		  System.out.println("mypageInfocheckpwd.do");
		  
		  String pwd=req.getParameter("pwd");
		  System.out.println("pwd"+pwd);
		  MemberDto member=(MemberDto) req.getSession().getAttribute("login");
		  System.out.println("member"+member.toString());
		  
		  if(member.getPwd().equals(pwd)) {
			     return "true";
		  }else {
			     return "false";	  
		  }
		 
	  }
	  
	  @ResponseBody
	  @RequestMapping(value = "mypageInfoupdateaf.do" , method= {RequestMethod.GET,  RequestMethod.POST} )
	  public String mypageInfoupdate(HttpServletRequest req,MemberDto mem ) {
		  
		  System.out.println("mypageInfoupdate.do");
		  System.out.println("mem"+mem.toString());
		  
		  mypageService.mypageInfoUpdateaf(mem);
		  
		  
		  
		  return "true";

      }

	  
	  @RequestMapping(value = "mypagepasswordUpdate.do" , method= {RequestMethod.GET,  RequestMethod.POST} )
	  public String mypagepasswordUpdate(HttpServletRequest req,MemberDto mem ) {
	  
		 System.out.println("mypagepasswordUpdate");
		 
		 
	      return "mypage/mypagepasswordUpdate";
	  
	  }
	  
	  @ResponseBody
	  @RequestMapping(value = "mypagepasswordUpdateaf.do" , method= {RequestMethod.GET,  RequestMethod.POST} )
	  public String mypagepasswordUpdateaf(HttpServletRequest req,MemberDto mem ) {
	  
		 System.out.println("mypagepasswordUpdate");
		 MemberDto member=(MemberDto) req.getSession().getAttribute("login");
		 
		 mem.setEmail(member.getEmail());
		
		 
		mypageService.mypagepasswordUpdateaf(mem); 
				
		 
	      return "ok";
	  
	  }
	  //회원 탈퇴 진행 하는 부분
	  @ResponseBody
	  @RequestMapping(value = "mypagememberleaveaf.do", method= {RequestMethod.GET,  RequestMethod.POST} )
	  public String mypagememberleaveaf(HttpServletRequest req) {
		  System.out.println("mypagememberleaveaf");
		  
		  MemberDto member=(MemberDto) req.getSession().getAttribute("login");
		  
		  MypageMemberleave lmem=new MypageMemberleave(member.getEmail(),req.getParameter("reason") );
		  System.out.println("이유"+lmem.toString());
		  
		  mypageService.mypageMemberleave(lmem);
		  
		  return "ok!";
	  }
	  
	  
	  
	  @ResponseBody 
	  @RequestMapping (value = "mypagefollowmyattendplay.do", method= {RequestMethod.GET, RequestMethod.POST},
	  produces = "application/text; charset=utf8")
	  public String mypageattendplay (MemberDto mem){
		 List<PlayboardDto>list =mypageService.mypageattendplay(mem);
		 System.out.println("list.size"+list.size());
	
		 String data="";
		 if(list.size()==0) {
			 data+="<div class='nonplay'>참여 중인 소모임이 없습니다</div>";
			 data+="<div class='nonplayimg'><img alt='' src='./mypage_resources/mypage_h/mypageFollow/images/notfound.png'></div>";
		 }else {
			 
		 for(int i=0 ;i<list.size();i++) {
			 PlayboardDto dto=list.get(i);
			 data+="<div class='modaltitle'><img alt='' src='./mypage_resources/mypage_h/mypageFollow/images/title.png'>"+dto.getTitle()+"</div><div class='modaltime'><img  alt='' src='./mypage_resources/mypage_h/mypageFollow/images/time.png' >"+dto.getEdate()+"</div>"; 
		 }
		 
		 System.out.println("d"+data);
		 
		 }
		 return data;
		 
	  }
	  
	  
	  
	  
	  //메세지 보내는 컨트롤러
	 @RequestMapping(value = "mypageFollowreplymsg.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String mypageFollowreplymsg(MypageMsgDto msgdto,Model model) {

			System.out.println("답장 WWWddd하러 갑니다");
			System.out.println("msgdto"+msgdto.toString());
              
			model.addAttribute("msg", msgdto);
			
			return "mypage/Msgcommon";
			
		}
	 
	 /*
	 //나의 구독자들의 팔로우 팔로잉 가져오기!
	// @ResponseBody
	 @RequestMapping(value = "mypagefollowfollower.do", method = { RequestMethod.GET, RequestMethod.POST })
	 public String mypagefollowfollower(MypageFollowDto follow,Model model) {
		
		 
		 System.out.println("ajaxmem"+follow.toString());
		 
		 List<MypageFollowDto> list=mypageService.mypagefollowfollwinglist(follow);
		
		 /*
		 String data="";
		 for(int i=0; i<list.size() ;i++) {
			 MypageFollowDto flw=list.get(i);
			 data+=flw.getMyemail()+","+flw.getFolloing_email()+"/";
		 }
				 
		 data =  data.substring(0, data.lastIndexOf("/"));

	
		 System.out.println(data);
		 
	      
		
		 model.addAttribute("flist", list);
		 
		
		 
		 return "mypage/myfollowfollowing" ;
	 }
	  */

	 @RequestMapping(value = "mypagefollowfollower.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String mypagefollowfollower(MypageFollowDto follow,MypageFollowListParam flwparam, Model model, String flw, HttpServletRequest req) {
			System.out.println("follow!!!!!!");

			System.out.println("flw"+flw);
			flwparam.setEmail(follow.getMyemail()); 
			System.out.println("dds"+follow.toString());
		 
		    System.out.println(flwparam.toString()); 
			
			int myfollowers = mypageService.myFollowerCount(flwparam);
			int myfollowings = mypageService.myFollowingCount(flwparam);

			List<MypageFollowListParam> myfollowerlist = null;
			List<MypageFollowListParam> myfollowinglist = null;
		
			
			if(flw == null || flw.equals("")) {
				myfollowerlist = mypageService.myFollowerInfoList(flwparam);
				myfollowinglist = mypageService.myFollowingInfoList(flwparam);
				flw = "ing";
			}
			
			else {
				if(flw.equals("ing")) {
					myfollowinglist = mypageService.myFollowingInfoList(flwparam);
				
					flwparam.setKeyword("");
					flwparam.setSelection("");
				
					myfollowerlist = mypageService.myFollowerInfoList(flwparam); 
				
				}else if(flw.equals("wer")) {
					myfollowerlist = mypageService.myFollowerInfoList(flwparam); 
			
					flwparam.setKeyword("");
					flwparam.setSelection("");
		
					myfollowinglist = mypageService.myFollowingInfoList(flwparam);

				}			
			}
			model.addAttribute("email", follow.getMyemail());
			System.out.println( follow.getMyemail());
			
			
			System.out.println("flw가 변했니 " + flw);
			model.addAttribute("flw", flw);
			model.addAttribute("myfollowers", myfollowers);
			model.addAttribute("myfollowings", myfollowings);
			model.addAttribute("myfollowerlist", myfollowerlist);
			model.addAttribute("myfollowinglist", myfollowinglist);
			
			for(int i=0 ; i<myfollowerlist.size();i++) {
				System.out.println(myfollowerlist.get(i));
			}
			
			
			for(int i=0 ; i<myfollowinglist.size();i++) {
				System.out.println(myfollowinglist.get(i));
			}
			
			
			
			return "mypage/myfollowfollowfollowing";
		}
	 
	 
	 
	 
	 //나의 구독 검색 시 오는 ajax컨트롤러
		
		@ResponseBody
		@RequestMapping(value = "mypagegetflwsearch.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String mypagegetflwsearch(MypageFollowDto follow,MypageFollowListParam flwparam, Model model, HttpServletRequest req) {
			
			 System.out.println("검색결과4" + flwparam.toString());
			
			 List<MypageFollowListParam> myfollowerlist = mypageService.myFollowerInfoList(flwparam);
			 List<MypageFollowListParam> myfollowinglist = mypageService.myFollowingInfoList(flwparam);	
			 
			model.addAttribute("myfollowerlist", myfollowerlist);
			model.addAttribute("myfollowinglist", myfollowinglist);
			
			
			return "성공";
		}
	 
		
		
		//프로필!!띄우는 pop!!!
		@RequestMapping(value = "mypagefollowprofile.do", method = { RequestMethod.GET, RequestMethod.POST })
	 public String mypagefollowprofile(Mypagememandpet mempet,Model model) {
			
			System.out.println("profile");
			System.out.println(mempet.toString());
		
			Mypagememandpet myprofile=mypageService.mypageprofilememandpet(mempet.getEmail());
			
			
			
			System.out.println("controller"+myprofile.toString());
			model.addAttribute("proflie",myprofile);
			
			
			return "mypage/mypagememandpet";
		}

	 

	 //msg push
		@ResponseBody
		@RequestMapping(value = "mypagemsgpush.do", method = { RequestMethod.GET, RequestMethod.POST },
		produces = "application/text; charset=utf8")
		 public String mypagemsgpush(HttpServletRequest req) {
			
			String count="-1";
			
			
		    MemberDto member=(MemberDto) req.getSession().getAttribute("login");
			
		    
		    if(member==null) {
		    	return count;
		    }else {
		    	Mypagewebpush push=mypageService.mypagemsgpush(member.getEmail());
		    
		    	
		    	String data="";
		    	data+=push.getEmail()+"/"+push.getCount();		    
		        return data;
		    }
		  
		    
			
			
		}
		
		
		//나의 좋아요 후원 
		@RequestMapping(value = "mypagefundinglike.do", method = { RequestMethod.GET, RequestMethod.POST })
		 public String mypagefundinglike(MypagemylikeDto param,Mypagememandpet mempet,Model model,HttpServletRequest req) {
			System.out.println("나의 좋아요 펀딩 부분");
			  MemberDto member=(MemberDto) req.getSession().getAttribute("login");
			  param.setEmail(member.getEmail()); 
			  System.out.println("좋아요 부분 확인중"+param.toString());
			  
			  
			  List<FundingDto> list=mypageService.mypagefundinglike(param);
			  for(int i=0;i<list.size();i++) {
				  System.out.println("펀딩!"+list.get(i));
			  }
			  
			  
			  model.addAttribute("fundinglist", list);
			  
			  
			  return "mypage/mypagemyfundinglike";
		}

		
		//나의 좋아요 소모임
		@RequestMapping(value = "mypageplayboardlike.do", method = { RequestMethod.GET, RequestMethod.POST })
		 public String mypageplayboardlike(MypagemylikeDto param,Mypagememandpet mempet,Model model,HttpServletRequest req) {
			
			
			System.out.println("나의 좋아요  소모임");
		     MemberDto member=(MemberDto) req.getSession().getAttribute("login");
		     param.setEmail(member.getEmail()); 
		     
		     List<PlayboardDto> list=mypageService.mypageplayboardlike(param);
		     
		     model.addAttribute("myattendList", list);
		     
		     
		     return "mypage/mypagemyplaylistlike";
		}
		
		
	 
		//나의 좋아요 게시글
		@RequestMapping(value = "mypageboardlike.do", method = { RequestMethod.GET, RequestMethod.POST })
		 public String mypageboardlike(MypagemylikefreeboardDto param,Mypagememandpet mempet,Model model,HttpServletRequest req) {
			
			
			System.out.println("나의 좋아요  게시글");
		     MemberDto member=(MemberDto) req.getSession().getAttribute("login");
		     param.setEmail(member.getEmail()); 
		  
		     System.out.println("나의 좋아요 게시글 테스트 중"+param.toString());
		     
		     List<FreeboardDto> list=mypageService.mypagefreeboardlike(param);

		     System.out.println(list.size());

               
		     for(int i=0;i<list.size();i++) {
		    	 System.out.println(list.get(i));
		     }
		   
 
		     
		     model.addAttribute("freelist", list);
		     
		     return "mypage/mypagemyfreeboardlike";
		}
		
		
	  
	  ////////////////////////////////////////////////////////////////////////////////////////////
	  
	  //유정
	   // 마이페이지 메인홈화면으로 이동
      @RequestMapping(value = "mypagehome.do", method= {RequestMethod.GET, RequestMethod.POST})
      public String mypagehome(MypagePointListParam pparam, HttpServletRequest req, Model model) throws Exception{
         System.out.println("mypagehome.do ---------------------------");
         //TODO
         MemberDto user = (MemberDto)req.getSession().getAttribute("login");
         System.out.println("loginsession = " + user);
         MyGradeDto gdto = mypageService.getUserGrade( user );
         
         ////////////////////////////////////////////////////////rightbox를 위한 부분 
           MypageListParam listparam = new MypageListParam();
           listparam.setEmail(user.getEmail());
           
           //나의 이번주 참여, 모집 모임 리스트
           List<PlayboardDto> myattendList = mypageService.getJoinPlayList(listparam); 
           List<PlayboardDto> mymakeList = mypageService.getMakePlayList(listparam);
           
           String jsonData = "[";
            if(!myattendList.isEmpty()){
               
               for (PlayboardDto pdto : myattendList) {
            		jsonData += "{id:"+pdto.getSeq()+",title:'" + MypageDateUtil.ReduceTitle(pdto.getTitle()) + "', start:'" + MypageDateUtil.ConvertDate(pdto.getPdate()) + "', backgroundColor:'#8893cc' },";
        
               }
            }
            if(!mymakeList.isEmpty()){
               for (PlayboardDto pdto : mymakeList) {
            	   jsonData += "{id:"+pdto.getSeq()+",title:'" + MypageDateUtil.ReduceTitle(pdto.getTitle()) + "', start:'" + MypageDateUtil.ConvertDate(pdto.getPdate()) + "', backgroundColor:'#c2d7e1' },";
               }      
            }
            if(jsonData.equals("[")){
               jsonData = "";         
            }
            else{
               jsonData = jsonData.substring(0, jsonData.lastIndexOf(","));
               jsonData += "]";      
            }
           
           //작성한 글, 댓글 수 가져오기
           int writingCount = mypageService.getMyWritingCount(user.getEmail());
           int commentCount = mypageService.getMyCommentCount(user.getEmail());
           
           
           //나의 팔로워의 이번주 행보
           
           
           model.addAttribute("writingCount", writingCount);
           model.addAttribute("commentCount", commentCount);
           model.addAttribute("myattendList", myattendList);
           model.addAttribute("mymakeList", mymakeList);
           model.addAttribute("jsonData", jsonData);
         
         if(gdto!=null) {
            System.out.println("mypagehome.do>>> 로그인유저의 등급정보 : "+ gdto.toString() );
            model.addAttribute("userGrade", gdto);
            
         }
         
         
         
         ///////////////////////////////////////////////////////////leftbox
         
         List<MypageFollowListParam> flwerAllPlayList = mypageService.getRecentFollowersPlay(user.getEmail());
         List<MypageFollowListParam> flwerFreeList = mypageService.getRecentFollowersFree(user.getEmail());
         
           model.addAttribute("flwerAllPlayList", flwerAllPlayList);
           model.addAttribute("flwerFreeList", flwerFreeList);
         
         //TODO  유정추가 1022 ---------------------------------------------------------------------------------
			// 로그인 유저의 정보 가지고 가기(현재 포인트반영)
			MemberDto userdto = mypageService.getUser( user.getEmail() );
			model.addAttribute("userdto",userdto);
			
			// paging
			pparam.setEmail(user.getEmail());
			System.out.println("들어온 pparam : " + pparam.toString());
			
			int page = pparam.getPageNumber(); // 클릭한 페이지 넘버 0, 1, 2, 3, 4... 	초기페이지이동시 0	
			int start = page * pparam.getRecordCountPerPage() + 1; // 1 11 21	초기페이지이동시 1	
			int end = (page + 1) * pparam.getRecordCountPerPage(); // 10 20 30	초기페이지이동시 10
			
			pparam.setStart(start);
			pparam.setEnd(end);
			
			MypagePointListParam pageingparam = new MypagePointListParam(user.getEmail(), 0, pparam.getRecordCountPerPage(),start, end);
			
			System.out.println("다시 db로 보낼 param = " + pageingparam.toString());
			
			// 총  포인트 내역 수
			int totalRecordCount = mypageService.getAllPointList(pageingparam);
			// 포인트내역 리스트
			List<PointHistoryDto> pointlist = mypageService.getPointHIstoryList( pageingparam );
			
			for (PointHistoryDto poindto : pointlist) {
				System.out.println(poindto.toString());
			}

			model.addAttribute("pageNumber", page);
			model.addAttribute("pageCountPerScreen", 10);	//10개씩 단위
			model.addAttribute("recordCountPerPage", pparam.getRecordCountPerPage());	// 표현할 한 페이지의 글 수
			model.addAttribute("totalRecordCount", totalRecordCount);	//전체글수
			model.addAttribute("pparam", pparam);
			model.addAttribute("pointlist", pointlist); 
           
           
         return "mypage/mypageHome";
      }
      
		
		// 마이페이지 메인홈화면으로 이동
		@RequestMapping(value = "mypagehomePointHistoryList.do", method= {RequestMethod.GET, RequestMethod.POST})
		public String mypagehomePointHistoryList(MypagePointListParam frmdata, HttpServletRequest req, Model model) throws Exception{
			
			System.out.println("mypagehomePointHistoryList.do ---------------------------");
			MemberDto user = (MemberDto)req.getSession().getAttribute("login");
			// paging
			frmdata.setEmail(user.getEmail());
			
			
			System.out.println("들어온 pparam : " + frmdata.toString());
			
			int page = frmdata.getPageNumber(); // 클릭한 페이지 넘버 0, 1, 2, 3, 4... 	초기페이지이동시 0	
			int start = page * frmdata.getRecordCountPerPage() + 1; // 1 11 21	초기페이지이동시 1	
			int end = (page + 1) * frmdata.getRecordCountPerPage(); // 10 20 30	초기페이지이동시 10
			
			frmdata.setStart(start);
			frmdata.setEnd(end);
			
			MypagePointListParam pageingparam = new MypagePointListParam(frmdata.getEmail(), 0, frmdata.getRecordCountPerPage(),start, end);
			
			System.out.println("다시 db로 보낼 param = " + pageingparam.toString());
			
			// 총  포인트 내역 수
			int totalRecordCount = mypageService.getAllPointList(pageingparam);
			// 포인트내역 리스트
			List<PointHistoryDto> pointlist = mypageService.getPointHIstoryList( pageingparam );
			
			for (PointHistoryDto poindto : pointlist) {
				System.out.println(poindto.toString());
			}
	
			model.addAttribute("pageNumber", page);
			model.addAttribute("pageCountPerScreen", 10);	//10개씩 단위
			model.addAttribute("recordCountPerPage", frmdata.getRecordCountPerPage());	// 표현할 한 페이지의 글 수
			model.addAttribute("totalRecordCount", totalRecordCount);	//전체글수
			model.addAttribute("pparam", frmdata);
			model.addAttribute("pointlist", pointlist); 
			
			return "mypage/mypagePointlistPaging";
		}	
		
		
		
		
		@RequestMapping(value = "myprofile.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String myprofile(HttpServletRequest req) {
			System.out.println("myprofile.do -----------------------------");
					
			return "mypage/myProfile";
		}
		
		@ResponseBody
		@RequestMapping(value = "checkprofile.do", method = {RequestMethod.GET, RequestMethod.POST})
		public boolean checkprofile(HttpServletRequest req, Model model) {
			MemberDto user = (MemberDto)req.getSession().getAttribute("login");	
			
			// PM_CHECK_MYPROFILE테이블에 email 존재여부 확인 
			boolean checkIS = mypageService.check_myprofile( user );
			
			if(checkIS == false) {
				System.out.println("PM_CHECK_MYPROFILE에 유저정보 없음");
			}
			else if(checkIS) {
				System.out.println("PM_CHECK_MYPROFILE에 유저정보 있음");
			}
			
			return checkIS;
		}
		
		
		@RequestMapping(value = "mypetprofile.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String mypetprofile(HttpServletRequest req) {
			System.out.println("mypetprofile.do -----------------------------");
			
			// 펫등록 전일 경우 펫프로필 세션 값을 null로하여 생성
			MyPetProfileDto mypet = (MyPetProfileDto)req.getSession().getAttribute("mypet");			
			if(mypet == null) {
				System.out.println("mypet세션은 null입니다");
				req.getSession().setAttribute("mypet", null);
			}else System.out.println("mypet세션 = " + mypet.toString() );	
			
			return "mypage/myPetProfile";
		}
		
		
		
		@ResponseBody
		@RequestMapping(value = "checkpetprofile.do", method = {RequestMethod.GET, RequestMethod.POST})
		public boolean checkpetprofile(HttpServletRequest req) {
			System.out.println("checkpetprofile.do --------------------------------");
			
			MemberDto user = (MemberDto)req.getSession().getAttribute("login");
			System.out.println("login session = "+ user.toString());
			// 펫프로필 등록여부 확인 PM_CHECK_PETPROFILE
			boolean checkIS = mypageService.check_petprofile( user.getEmail() );
			
			if(!checkIS) {
				System.out.println("PM_CHECK_PETPROFILE 등록안되어있음");
			}
			else{
				System.out.println("PM_CHECK_PETPROFILE 등록되어있음");
			}
			
			return checkIS;
		}
		
		// 펫프로필 업데이트
		@ResponseBody
		@RequestMapping(value = "updatepetProfile.do", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/text; charset=utf8")
		public String insertPetProfile(MyPetProfileDto petdto,
				@RequestParam(value = "fileload", required = false)MultipartFile fileload,
				HttpServletRequest req, 
				Model model) {
			System.out.println("updatepetProfile.do --------------------------------");
			petdto.setPetdetail( petdto.getPetdetail().replace(",", "") );//제이쿼리로 추가된 select option의 값은 ,달고 넘어오더라굽쇼..
			System.out.println(petdto.toString());
			
			MemberDto loginuser = mypageService.getUser(petdto.getEmail());
			
			// 업로드한 파일명 가져오기
			String filename = fileload.getOriginalFilename();
			System.out.println("getOriginalFilename = "+ filename);
			
			// 업로드한 파일없음
			if(filename == null || filename.equals("")) {
				System.out.println("넘어온 fileimg없음-> 프로필이미지 null로 db저장)");				
			}
			
			// 업로드한 파일 있음
			else {				
				// 1. 사진 업로드 경로 설정
				// 톰캣경로
				String uploadfolder = req.getServletContext().getRealPath("/upload");					
				System.out.println("파일 업로드 경로 uploadfolder == " + uploadfolder);
				
				// 2. file 명 변경
				// 기존 파일명 가져와서 지우기
				String oldfilename = petdto.getPetprofile_img(); //기존 가지고 있던 프로필이미지 파일명
				// 기존파일 있으면
				if(oldfilename != null) {
					boolean b =  FUpUtil.delOldFile(uploadfolder, oldfilename);
				    System.out.println("기존파일 지우기 결과 == " +  b);
				}
				String filecase = "_petprofileImg";
				String newfilename = FUpUtil.getNewFileName(filename, filecase, loginuser.getNickname() );//.back주석하였음
				
				// 3. 업로드 (DB저장)
				petdto.setPetprofile_img(newfilename);	
				
				String fullpath = uploadfolder + "/" + newfilename;
				System.out.println("fullpath == " + fullpath);
			
				File file = new File(fullpath);
				
				try {
					//실제 파일 업로드 되는 부분 
					FileUtils.writeByteArrayToFile(file, fileload.getBytes());
				}catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			System.out.println("db저장할 파라미터로 넘기기전 paramdto 입니다 ? "+ petdto.toString());
			
			// 펫프로필 등록 여부확인
			boolean checkis = mypageService.check_petprofile( petdto.getEmail() );
			boolean resultIs;
			
			// 펫프로필 등록 되어있음 = 프로필 수정
			if(checkis) {				
				resultIs = mypageService.updatePetProfile(petdto);
				System.out.println("프로필 업데이트 결과  == " + resultIs);
				
			}
			// 펫프로필 등록 되어있음 = 프로필 등록(등록동시 addMyProfileCheck, 펫등록 포인트 지급)
			else {
				resultIs = mypageService.insertPetProfile(petdto);
				System.out.println("프로필 등록 결과  == " + resultIs);
			}
			
			if(resultIs) {
				// 업데이트된 포인트 반영하기 위해 loginsession 다시얻어오기
				
				MyPetProfileDto petprofiledto = mypageService.getLoginUserPetProfile(petdto.getEmail());
				
				// 로그인 세션 갱신
				req.getSession().removeAttribute("login");
				req.getSession().setAttribute("login", loginuser);				
				System.out.println("updatepetProfile.do>>> 로그인 세션갱신완료");
				
				// 펫프로필 세션
				req.getSession().removeAttribute("mypet");				
				req.getSession().setAttribute("mypet", petprofiledto);				
				System.out.println("updatepetProfile.do>>> 펫프로필 세션갱신완료");
				System.out.println( "갱신된 펫프로필세션 >>> " + req.getSession().getAttribute("mypet") );
				
				return "";
			}
			
			return "";			
		}
		
		// 프로필 닉네임 수정시 닉네임체크		
		@ResponseBody
		@RequestMapping(value = "nicknameCheck.do", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/text; charset=utf8")
		public String nicknameCheck( MyProfileParam paramdto, HttpServletRequest req) {
			System.out.println("nicknameCheck.do --------------------------------");
			
			MemberDto user = (MemberDto)req.getSession().getAttribute("login");
			String nickname = paramdto.getNickname();			
			MemberDto memdto = mypageService.checkNicknameExist( nickname );
			
			if(memdto == null) {
				return "사용 가능한 닉네임 입니다.";
			}
			else if( user.getNickname().equals(nickname) ){
				return "현재 사용중인 닉네임 입니다.";
			}else {
				return "이미 존재하는 닉네임 입니다.";
			}			
		}
		
		// 프로필수정
		@ResponseBody
		@RequestMapping(value = "updateProfile.do", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/text; charset=utf8")
		public String updateProfile(MyProfileParam paramdto,
				@RequestParam(value = "fileload", required = false)MultipartFile fileload,
				HttpServletRequest req, Model model) {
			
			System.out.println("updateProfile.do --------------------------------");
			System.out.println(paramdto.toString());
			
			MemberDto user = mypageService.getUser(paramdto.getEmail());
			
			// 업로드한 파일명 가져오기
			String filename = fileload.getOriginalFilename();
			System.out.println("getOriginalFilename = "+ filename);
			
			// 업로드한 파일없음
			if(filename == null || filename.equals("")) {
				System.out.println("넘어온 fileimg없음-> 프로필이미지 null로 db저장)");
				//paramdto.setMyprofile_img(user.get);
			}
			
			// 업로드한 파일 있음
			else {
				// 1. 프로필 사진 업로드 경로 설정
				// 절대경로
				String uploadfolder = req.getServletContext().getRealPath("/upload");					
				System.out.println("파일 업로드 경로 uploadfolder == " + uploadfolder);
						
				// 2. file 명 변경
				
				// 기존 파일명 가져와서 지우기
				String oldfilename = paramdto.getMyprofile_img(); //기존 가지고 있던 프로필이미지 파일명
				
				// 기존파일 있으면
				if(oldfilename != null) {
					boolean b =  FUpUtil.delOldFile(uploadfolder, oldfilename);
				    System.out.println("기존파일 지우기 결과 == " +  b);
				}
				
				String filecase = "_profileImg";
				String newfilename = FUpUtil.getNewFileName(filename, filecase, user.getNickname() );//.back주석하였음
				
				// 3. 업로드 (DB저장)
				paramdto.setMyprofile_img(newfilename);
				
				String fullpath = uploadfolder + "/" + newfilename;
				System.out.println("fullpath == " + fullpath);
				
				File file = new File(fullpath);
				
				try {
					//실제 파일 업로드 되는 부분 
					FileUtils.writeByteArrayToFile(file, fileload.getBytes());
				}catch (Exception e) {
					e.printStackTrace();
				}				
			}
			
			System.out.println("db저장할 파라미터로 넘기기전 paramdto 입니다 ? "+ paramdto.toString());
			
			// updateProfile 실행
			boolean updateisS = mypageService.updateProfile(paramdto);
			System.out.println("프로필업데이트(+닉네임업데이트) 됬나요 ? " + updateisS);
			
			if(updateisS) {
				
				// PM_CHECK_MYPROFILE테이블에 email 존재여부 확인 
				boolean checkIS = mypageService.check_myprofile( user );
				
				// 존재하지않으면 PM_CHECK_MYPROFILE테이블에 insert
				if(!checkIS) {
					boolean checkedisS = mypageService.addMyProfileCheck(user.getEmail());					
					System.out.println("프로필체크 테이블에 추가 됬나요 ? " + checkedisS);
					System.out.println("프로필 업데이트 + 체크테이블 추가 + 포인트업데이트 완료");
				}
				
				// 업데이트된 포인트 반영할 dto 다시얻어오기
				MemberDto loginuser = mypageService.getUser(user.getEmail());
				MyProfileDto profiledto = mypageService.getLoginUserProfile( user.getEmail() );	
				System.out.println("새로 갱신할 user 정보 loginuser ? " + loginuser.toString() );
				System.out.println("새로 갱신할 user profiledto ? " + profiledto.toString() );
				
				// 로그인 세션 갱신
				req.getSession().removeAttribute("login");
				req.getSession().setAttribute("login", loginuser);
				System.out.println("updateProfile.do>>> 로그인 세션갱신완료");
				
				// 프로필 세션 갱신				
				req.getSession().removeAttribute("userProfile");
				req.getSession().setAttribute("userProfile", profiledto);				
				System.out.println("updateProfile.do>>> 프로필 세션갱신완료");
				
				return "프로필 등록 성공";
			}
			
			return "프로필 등록 실패";
		}

		
	  /* 혜연*/
		@RequestMapping(value = "mycalendar.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String getMyCalendar(Model model, HttpServletRequest req) {
		
			MemberDto user = (MemberDto) req.getSession().getAttribute("login");
			MypageListParam listparam = new MypageListParam();
			listparam.setEmail(user.getEmail());
			
			List<PlayboardDto> joinlist = mypageService.getJoinPlayList(listparam);
			List<PlayboardDto> makelist = mypageService.getMakePlayList(listparam);
			

			String jsonData = "[";
			if(!joinlist.isEmpty()){
				
				for (PlayboardDto pdto : joinlist) {
					jsonData += "{id:"+pdto.getSeq()+",title:'" + MypageDateUtil.ReduceTitle(pdto.getTitle()) + "', start:'" + MypageDateUtil.ConvertDate(pdto.getPdate()) + "', backgroundColor:'#8893cc' },";
				}
			}
			if(!makelist.isEmpty()){
				for (PlayboardDto pdto : makelist) {
					jsonData += "{id:"+pdto.getSeq()+",title:'" + MypageDateUtil.ReduceTitle(pdto.getTitle()) + "', start:'" + MypageDateUtil.ConvertDate(pdto.getPdate()) + "', backgroundColor:'#c2d7e1' },";
				}		
			}
			if(jsonData.equals("[")){
				jsonData = "";			
			}
			else{
				jsonData = jsonData.substring(0, jsonData.lastIndexOf(","));
				jsonData += "]";		
			}

			System.out.println("jsonData체크" + jsonData);
			
			model.addAttribute("myjoinlist", joinlist);
			model.addAttribute("mymakelist", makelist);
			 model.addAttribute("jsonData", jsonData);
			return "mypage/mypageCalendar";
		}


		@RequestMapping(value = "mypageplaylist.do", method= {RequestMethod.GET, RequestMethod.POST})
		public String mypagePlaylist(MypageListParam listparam, HttpServletRequest req, Model model) throws Exception {
		
			 MemberDto member = (MemberDto)req.getSession().getAttribute("login");
			 
			listparam.setEmail(member.getEmail());
			 System.out.println("listparam 체크 "+ listparam.toString());
			 List<PlayboardDto> myattendList = null; 
			 List<PlayboardDto> mymakeList = null;
			 
			  
			if(listparam.getPlay() == null || listparam.getPlay().equals("")) {
			 myattendList= mypageService.getJoinPlayList(listparam);
			 mymakeList = mypageService.getMakePlayList(listparam);
			 listparam.setPlay("attend");
			 
			}
			else if(listparam.getPlay().equals("attend")){
				 myattendList= mypageService.getJoinPlayList(listparam);
				 
				 listparam.setCategory("");
				 listparam.setKeyword("");
				 listparam.setSelection("");
				 
				 mymakeList = mypageService.getMakePlayList(listparam);
			
			}else if(listparam.getPlay().equals("make")) {
				
				 mymakeList = mypageService.getMakePlayList(listparam);
				 
				 listparam.setCategory("");
				 listparam.setKeyword("");
				 listparam.setSelection("");
				 
				 myattendList= mypageService.getJoinPlayList(listparam);

			}
		
			 model.addAttribute("myattendList", myattendList);
			 model.addAttribute("mymakeList", mymakeList);
			 model.addAttribute("listparam", listparam);
			 
			return "mypage/mypagePlaylist";
		}
		
		
		@RequestMapping(value = "mypagefundinglist.do", method= {RequestMethod.GET, RequestMethod.POST})
		public String mypageFundinglist(MypageListParam listparam, HttpServletRequest req, Model model) throws Exception {
		
			 MemberDto member = (MemberDto)req.getSession().getAttribute("login");
			 listparam.setEmail(member.getEmail());
			 List<FundingDto> fundinglist = mypageService.getMyFundingList(listparam);
			
			
			 model.addAttribute("fundinglist", fundinglist);
			 model.addAttribute("listparam", listparam);
			 
			return "mypage/mypageFundinglist";

		}
		///////////////////////////////////////////////////////////////////////////////////////////// 나의
		///////////////////////////////////////////////////////////////////////////////////////////// 쪽지함
		@RequestMapping(value = "myrevmsg.do", produces = "application/String; charset=UTF-8", method = { RequestMethod.GET,
				RequestMethod.POST })
		public String mypageRevMsg(MypageMsgParam sparam, Model model, HttpServletRequest req) throws Exception {

			MemberDto user = (MemberDto) req.getSession().getAttribute("login");
			
			
			sparam.setEmail(user.getEmail());
			int page = sparam.getPageNumber(); // 0 , 1, 2, 3, 4, 5,
			int start = page * sparam.getRecordCountPerPage() + 1; // 1 11 21
			int end = (page + 1) * sparam.getRecordCountPerPage(); // 10 20 30

			System.out.println("sparam 체크체크 : " +sparam.toString());
			sparam.setStart(start);
			sparam.setEnd(end);

			MypageMsgParam searchParam = new MypageMsgParam(user.getEmail(), "", // selection
					"", // keyword
					"", "", 0, 0, start, end);


			int totalRecordCount = mypageService.getAllRevMsg(searchParam);
			int pureTotal = totalRecordCount;
			List<MypageMsgDto> revmsglist = mypageService.getRevMsgList(searchParam);

			revmsglist = mypageService.getRevMsgList(sparam);
			totalRecordCount = mypageService.getAllRevMsg(sparam);
		
			
			for (MypageMsgDto msgDto : revmsglist) {
				System.out.println(msgDto.toString());
			}

			model.addAttribute("pageNumber", page);
			model.addAttribute("pageCountPerScreen", 10);
			model.addAttribute("recordCountPerPage", sparam.getRecordCountPerPage());
			model.addAttribute("totalRecordCount", totalRecordCount);
			model.addAttribute("pureTotal", pureTotal);
			model.addAttribute("sparam", sparam);
			model.addAttribute("myrevmsglist", revmsglist);

			return "mypage/mypageRevMsgBox";
		}

		
		@RequestMapping(value = "mysendmsg.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String mypageSendMsg(MypageMsgParam sparam, Model model, HttpServletRequest req) {

			MemberDto user = (MemberDto) req.getSession().getAttribute("login");

			sparam.setEmail(user.getEmail());
			System.out.println("sparam 체크체크 : " +sparam.toString());
			int page = sparam.getPageNumber(); // 0 , 1, 2, 3, 4, 5,
			int start = page * sparam.getRecordCountPerPage() + 1; // 1 11 21
			int end = (page + 1) * sparam.getRecordCountPerPage(); // 10 20 30

			sparam.setStart(start);
			sparam.setEnd(end);

			MypageMsgParam searchParam = new MypageMsgParam(user.getEmail(), "", // selection
					"", // keyword
					0, 0, start, end);

			int totalRecordCount = mypageService.getAllSendMsg(searchParam);
			int pureTotal = totalRecordCount;
			List<MypageMsgDto> sendmsglist = mypageService.getSendMsgList(searchParam);

			totalRecordCount = mypageService.getAllSendMsg(sparam);
			sendmsglist = mypageService.getSendMsgList(sparam);

			System.out.println("이게 변화하는 total : "+ totalRecordCount);
			
			model.addAttribute("pageNumber", page);
			model.addAttribute("pageCountPerScreen", 10);
			model.addAttribute("recordCountPerPage", sparam.getRecordCountPerPage());
			model.addAttribute("totalRecordCount", totalRecordCount);
			model.addAttribute("pureTotal", pureTotal);
			model.addAttribute("sparam", sparam);
			model.addAttribute("mysendmsglist", sendmsglist);

			return "mypage/mypageSendMsgBox";
		}

		
		@RequestMapping(value = "writemsg.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String writeMsg(MypageFollowListParam flwparam, Model model, HttpServletRequest req) {

			System.out.println("쪽지 보내러 갑니다");

			return "mypage/mypageNewMsg";
		}
		
		@RequestMapping(value = "writemsgAf.do", method= {RequestMethod.GET, RequestMethod.POST})
		public String writeMsgAf(MypageMsgDto msgdto,  Model model) {
			
			System.out.println("쪽지 내용 : " + msgdto.toString());
			List<MypageMsgDto> msgdtolist = new ArrayList<MypageMsgDto>();
			
			if(msgdto.getNickname().contains(",")) {
				System.out.println("여러 값으로 서비스 들어가는 준비 중 ");
				String nicknameArr[] = null;
				
				nicknameArr=msgdto.getNickname().split(",");
			
				for (int i = 0; i < nicknameArr.length; i++) {
					MypageMsgDto mdto = new MypageMsgDto(msgdto.getSeq(),
														 msgdto.getTo_email(),
														 msgdto.getFrom_email(),
														 nicknameArr[i],
														 msgdto.getContent(),
														 msgdto.getSenddate(),
														 msgdto.getReaddate(),
														 msgdto.getImportant(),
														 msgdto.getReadcheck());
					msgdtolist.add(mdto);
			
				}
				mypageService.writeNewMultiMsgs(msgdtolist);
				for (MypageMsgDto dto : msgdtolist) {
					System.out.println("리스트에 제대로 안들어간거니? " + dto.toString());
				}
			}else {
				System.out.println("하나의 값으로 서비스 들어가는 준비 중 ");
				mypageService.writeNewMsg(msgdto);			
			}
		
			model.addAttribute("recordCountPerPage", 10);
			
			

			return "redirect:/myrevmsg.do";
		}
		
		@ResponseBody
		@RequestMapping(value = "checkaccount.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String checkAccount(MypageMsgDto msgdto, Model model) {
			
			return "mypage/mypageRevMsgBox";
		}

		@RequestMapping(value = "replymsg.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String replyMsg() {

			return "mypage/mypageReplyMsg";
			
		}

		@RequestMapping(value = "msgdetail.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String msgDetail(MypageMsgDto msgdto, String box, Model model) {
			
			if (box.equals("rev")) {	
				
				MypageMsgDto mdto = mypageService.getRevMsgDetail(msgdto);
				model.addAttribute("revmsgDetail", mdto);
				return "mypage/mypageReplyMsg";

			} else {
				
				MypageMsgDto mdto = mypageService.getSendMsgDetail(msgdto);
				model.addAttribute("sendmsgDetail", mdto);
				
				return "mypage/mypageSendMsg";
			}
		}

		@ResponseBody
		@RequestMapping(value = "changeReadcheck.do", method = { RequestMethod.GET, RequestMethod.POST })
		public int changeReadcheck(MypageMsgDto msgdto, String click) {

			MypageMsgDto mdto1 = mypageService.getRevMsgDetail(msgdto);

			if (mdto1.getReaddate() == null || mdto1.getReaddate().equals("") || click.equals("click")) {
				mypageService.changeReadcheck(mdto1);
			}

			MypageMsgDto mdto2 = mypageService.getRevMsgDetail(msgdto);
			return mdto2.getReadcheck();
		}

		@ResponseBody
		@RequestMapping(value = "deletemsg.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String deleteMsg(MypageMsgDto msgdto, @RequestParam(value = "seqArr[]") List<Integer> chArr, String select) {

			if (select.equals("send")) {
				for (int seq : chArr) {
					msgdto.setSeq(seq);
					mypageService.deleteSendMsg(msgdto);

				}
			} else if (select.equals("rev")) {
				for (int seq : chArr) {
					msgdto.setSeq(seq);
					mypageService.deleteRevMsg(msgdto);
	
				}
			} else {
				for (int seq : chArr) {
					msgdto.setSeq(seq);
					mypageService.deleteSendMsg(msgdto);
					mypageService.deleteRevMsg(msgdto);
				}
			}
			return "성공";
		}

		@ResponseBody
		@RequestMapping(value = "countunreadmsg.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String countUnreadMsg(Model model, HttpServletRequest req) {

			MemberDto user = (MemberDto) req.getSession().getAttribute("login");

			int totalCount = mypageService.getAllUnreadMsg(user);
			return totalCount + "";
		}

		@RequestMapping(value = "getcontact.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String getcontact(MypageFollowListParam flwparam, Model model, String flw, HttpServletRequest req) {
			MemberDto user = (MemberDto) req.getSession().getAttribute("login");

			flwparam.setEmail(user.getEmail());
			int myfollowers = mypageService.myFollowerCount(flwparam);
			int myfollowings = mypageService.myFollowingCount(flwparam);

			List<MypageFollowListParam> myfollowerlist = null;
			List<MypageFollowListParam> myfollowinglist = null;
		
			
			if(flw == null || flw.equals("")) {
				myfollowerlist = mypageService.myFollowerInfoList(flwparam);
				myfollowinglist = mypageService.myFollowingInfoList(flwparam);
				flw = "ing";
			}
			
			else {
				if(flw.equals("ing")) {
					myfollowinglist = mypageService.myFollowingInfoList(flwparam);
				
					flwparam.setKeyword("");
					flwparam.setSelection("");
				
					myfollowerlist = mypageService.myFollowerInfoList(flwparam); 
				
				}else if(flw.equals("wer")) {
					myfollowerlist = mypageService.myFollowerInfoList(flwparam); 
			
					flwparam.setKeyword("");
					flwparam.setSelection("");
		
					myfollowinglist = mypageService.myFollowingInfoList(flwparam);

				}			
			}
			System.out.println("flw가 변했니 " + flw);
			model.addAttribute("flw", flw);
			model.addAttribute("myfollowers", myfollowers);
			model.addAttribute("myfollowings", myfollowings);
			model.addAttribute("myfollowerlist", myfollowerlist);
			model.addAttribute("myfollowinglist", myfollowinglist);
			
			return "mypage/mypageContactlist";
		}
		
		@ResponseBody
		@RequestMapping(value = "getflwsearch.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String getflwsearch(MypageFollowListParam flwparam, Model model, HttpServletRequest req) {
			
			 MemberDto user = (MemberDto)req.getSession().getAttribute("login");
			 flwparam.setEmail(user.getEmail()); 
			  
			 List<MypageFollowListParam> myfollowerlist = mypageService.myFollowerInfoList(flwparam);
			 List<MypageFollowListParam> myfollowinglist = mypageService.myFollowingInfoList(flwparam);	
			 
			model.addAttribute("myfollowerlist", myfollowerlist);
			model.addAttribute("myfollowinglist", myfollowinglist);
			return "성공";
		}

		@ResponseBody
		@RequestMapping(value = "getflwemail.do",produces = "application/text; charset=utf8", method = { RequestMethod.GET, RequestMethod.POST })
		public String getflwemail(int seq, String flw) {
			MypageFollowListParam myflwParam = null;
			
			if(flw.equals("ing")) {
				myflwParam = mypageService.getFlwingEmail(seq);
				
			}
			else if(flw.equals("wer")) {
				myflwParam = mypageService.getFlwerEmail(seq);
			}
			
			return myflwParam.getNickname();
		}
		
		@ResponseBody
		@RequestMapping(value = "checknicknameExist.do",produces = "application/text; charset=utf8", method = { RequestMethod.GET, RequestMethod.POST })
		public String checknicknameExist(String nickname, HttpServletRequest req) {

			String nicknameArr[] = null;
			MemberDto user = (MemberDto)req.getSession().getAttribute("login");
			List<String> existList = new ArrayList<String>();
			List<String> notExistList = new ArrayList<String>();
			List<MemberDto> selectedList = new ArrayList<MemberDto>();
			String result = null;
			if(nickname.contains(",")) {
				
				nicknameArr=nickname.split(",");
				
				
				for (int i = 0; i < nicknameArr.length-1; i++) {
					if(nicknameArr[i].equals(nicknameArr[i+1])){
						return "닉네임 "+ nicknameArr[i]+"가 중복 입력되었습니다";
					}
					if(nicknameArr[i].equals(user.getNickname())) {
						return "자기 자신에게는 쪽지를 보낼 수 없습니다.";
					}
					if(user.getAuth() == 8) {
						return "관리자에게는 쪽지를 보낼 수 없습니다.";
					}
				}
				
				
				for (int i = 0; i < nicknameArr.length; i++) {
					System.out.println("들어온 닉네임 체크체크"+nicknameArr[i].toString());
					MemberDto memdto = mypageService.checkNicknameExist(nicknameArr[i]);
					
					selectedList.add(memdto);
				}
				
				//닉네임 체크한 리스트 뽑아서 존재하고 안하고 리스트에 넣어줌
				for (int j = 0; j < selectedList.size(); j++) {
			
					MemberDto memdto = selectedList.get(j);
					if(memdto == null) {
						notExistList.add(nicknameArr[j]);	
					}
					else {
						existList.add(nicknameArr[j]);
					}
				}
				if(notExistList.isEmpty()) {
					return "ready";
				}else {
					for (int i = 0; i < notExistList.size(); i++) {
						if(notExistList.size() == 1) {
							result = notExistList.get(i);
						}
						else {
							if(result == null) {
								result = "";
							}
							else {
								result = result + "," + notExistList.get(i);
								
							}	
						}
					}					
				}
			
				if(result.substring(0,0).equals(",")) {
					
				}else {					
					return "쪽지 보내기 실패했습니다\n"+"입력하신 " + result.substring(1) + "는 존재하지 않는 닉네임입니다.";
				}
				
			}
			else {
				if(nickname.equals(user.getNickname())) {
					return "자기 자신에게는 쪽지를 보낼 수 없습니다.";
				}
				
				MemberDto memdto = mypageService.checkNicknameExist(nickname);
				if(memdto == null) {
					System.out.println("존재하지 않는 닉네임 : "+ nickname);
					return "쪽지 보내기 실패했습니다\n"+"입력하신 " + nickname + "는 존재하지 않는 닉네임입니다.";
				}
			}
			return "ready";
		}
		
		
		@ResponseBody
		@RequestMapping(value = "gettotalflwcount.do",produces = "application/text; charset=utf8", method = { RequestMethod.GET, RequestMethod.POST })
		public String getTotalFlwCount(HttpServletRequest req) {
				
			 MemberDto user = (MemberDto)req.getSession().getAttribute("login");
			
			 MypageFollowListParam flwparam = new MypageFollowListParam();
			 flwparam.setEmail(user.getEmail()); 
			
			 int followingcount = mypageService.myFollowingCount(flwparam);
			 int followercount = mypageService.myFollowerCount(flwparam);
			 
			 
			String jsonData = "{\"followingcount\":"+followingcount+",\"followercount\" :"+followercount+"}";
			
			return jsonData;
		}
		
	  
	  
}
