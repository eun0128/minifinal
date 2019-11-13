package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class MypageFollowDto implements Serializable {

	
     private String email;
     private String nickname;
     private int follower;
     private int folloing;
     private String intro;
     private String picture;
     
     private String myemail;
     private String folloing_email;
     
     
     
     public String getMyemail() {
		return myemail;
	}

	public void setMyemail(String myemail) {
		this.myemail = myemail;
	}
	

	public MypageFollowDto(String myemail, String folloing_email) {
		super();
		this.myemail = myemail;
		this.folloing_email = folloing_email;
	}

	public String getFolloing_email() {
		return folloing_email;
	}

	public void setFolloing_email(String folloing_email) {
		this.folloing_email = folloing_email;
	}

	public MypageFollowDto() {
    	 
     }

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
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

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public MypageFollowDto(String email, String nickname, int follower, int folloing, String intro, String picture) {
		super();
		this.email = email;
		this.nickname = nickname;
		this.follower = follower;
		this.folloing = folloing;
		this.intro = intro;
		this.picture = picture;
	}


	@Override
	public String toString() {
		return "MypageFollowDto [email=" + email + ", nickname=" + nickname + ", follower=" + follower + ", folloing="
				+ folloing + ", intro=" + intro + ", picture=" + picture + ", myemail=" + myemail + ", folloing_email="
				+ folloing_email + "]";
	}

	public MypageFollowDto(String email) {
		super();
		this.email = email;
	}

	public MypageFollowDto(String email, String nickname, int follower, int folloing, String intro, String picture,
			String myemail, String folloing_email) {
		super();
		this.email = email;
		this.nickname = nickname;
		this.follower = follower;
		this.folloing = folloing;
		this.intro = intro;
		this.picture = picture;
		this.myemail = myemail;
		this.folloing_email = folloing_email;
	}
	
	
     
}
