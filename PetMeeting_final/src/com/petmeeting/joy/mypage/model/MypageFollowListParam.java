package com.petmeeting.joy.mypage.model;

import java.io.Serializable;
import java.util.Date;

public class MypageFollowListParam implements Serializable {


	//사람 검색할 때 쓰는 변수
	private String email;
	private String selection;
	private String keyword;
	
	
	//myprofile테이블에서 가져온 변수
	private String nickname;
	 
	//member테이블에서 가져온 변수
	private String myprofile_img;
	 
	//follow테이블에서 가져온 변수
	private int seq;  //이거는 쪽지, 플레이보드, 프리보드 다쓰도록
	private int follower;
	private int folloing;
	private String myemail;
	private String folloing_email;
 
	//freeboard에서 팔로워가 가져오는 것을 가져오는 변수
	
	private String board_code;
	private String category;
	private String title;
	private Date regdate;
	private Date pdate;
	
	
	//모집인지 참여인지 sort
	private String sort;
	
   public MypageFollowListParam() {

   }
   
   
	public MypageFollowListParam(String email) {

		this.email = email;
	}


	//메세지를 새로 보내는 곳에 팔로워/팔로잉 리스트를 뽑기 위한 생성자
	public MypageFollowListParam(String email, String selection, String keyword, String nickname, String myprofile_img,
			int seq, int follower, int folloing, String myemail, String folloing_email) {
		super();
		this.email = email;
		this.selection = selection;
		this.keyword = keyword;
		this.nickname = nickname;
		this.myprofile_img = myprofile_img;
		this.seq = seq;
		this.follower = follower;
		this.folloing = folloing;
		this.myemail = myemail;
		this.folloing_email = folloing_email;
	}


	

	//play와 free 글을 가져오기 위한 생성자

	public MypageFollowListParam(String email, String nickname, String myprofile_img, int seq, String myemail,
			String board_code, String category, String title, Date regdate, Date pdate, String sort) {
		super();
		this.email = email;
		this.nickname = nickname;
		this.myprofile_img = myprofile_img;
		this.seq = seq;
		this.myemail = myemail;
		this.board_code = board_code;
		this.category = category;
		this.title = title;
		this.regdate = regdate;
		this.pdate = pdate;
		this.sort = sort;
	}


	public String getEmail() {
		return email;
	}




	public void setEmail(String email) {
		this.email = email;
	}




	public String getSelection() {
		return selection;
	}




	public void setSelection(String selection) {
		this.selection = selection;
	}




	public String getKeyword() {
		return keyword;
	}




	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}




	public String getNickname() {
		return nickname;
	}




	public void setNickname(String nickname) {
		this.nickname = nickname;
	}




	public String getMyprofile_img() {
		return myprofile_img;
	}




	public void setMyprofile_img(String myprofile_img) {
		this.myprofile_img = myprofile_img;
	}




	public int getSeq() {
		return seq;
	}




	public void setSeq(int seq) {
		this.seq = seq;
	}




	public int getFollower() {
		return follower;
	}




	public void setFollower(int follower) {
		this.follower = follower;
	}




	public int getFolloing() {
		return folloing;
	}




	public void setFolloing(int folloing) {
		this.folloing = folloing;
	}




	public String getMyemail() {
		return myemail;
	}




	public void setMyemail(String myemail) {
		this.myemail = myemail;
	}




	public String getFolloing_email() {
		return folloing_email;
	}




	public void setFolloing_email(String folloing_email) {
		this.folloing_email = folloing_email;
	}




	public String getBoard_code() {
		return board_code;
	}


	public void setBoard_code(String board_code) {
		this.board_code = board_code;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	

	

	public Date getRegdate() {
		return regdate;
	}


	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}


	public Date getPdate() {
		return pdate;
	}


	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}


	public String getSort() {
		return sort;
	}


	public void setSort(String sort) {
		this.sort = sort;
	}


	@Override
	public String toString() {
		return "MypageFollowListParam [email=" + email + ", selection=" + selection + ", keyword=" + keyword
				+ ", nickname=" + nickname + ", myprofile_img=" + myprofile_img + ", seq=" + seq + ", follower="
				+ follower + ", folloing=" + folloing + ", myemail=" + myemail + ", folloing_email=" + folloing_email
				+ ", board_code=" + board_code + ", category=" + category + ", title=" + title + ", regdate=" + regdate
				+ ", pdate=" + pdate + "]";
	}


	









	   
     
}