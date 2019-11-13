package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class Mypagememandpet implements Serializable {

	
	private String email;
	
	private String myprofile_img;
	
	private String myage;
	private String mysex;
	private String myintro;
	
	private String petprofile_img;
	private String petname;
	private String petage;
	private String pettype;
	private String petdetail;
	private String petweight;
	
	private String petsex;
	private String pettnar;
	private String petintro;
	
	private int follower;
	private int following;
	
	private String name;
	private String nickname;
	
	
	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getMyprofile_img() {
		return myprofile_img;
	}


	public void setMyprofile_img(String myprofile_img) {
		this.myprofile_img = myprofile_img;
	}


	public String getMyage() {
		return myage;
	}


	public void setMyage(String myage) {
		this.myage = myage;
	}


	public String getMysex() {
		return mysex;
	}


	public void setMysex(String mysex) {
		this.mysex = mysex;
	}


	public String getMyintro() {
		return myintro;
	}


	public void setMyintro(String myintro) {
		this.myintro = myintro;
	}


	public String getPetprofile_img() {
		return petprofile_img;
	}


	public void setPetprofile_img(String petprofile_img) {
		this.petprofile_img = petprofile_img;
	}


	public String getPetname() {
		return petname;
	}


	public void setPetname(String petname) {
		this.petname = petname;
	}


	public String getPetage() {
		return petage;
	}


	public void setPetage(String petage) {
		this.petage = petage;
	}


	public String getPettype() {
		return pettype;
	}


	public void setPettype(String pettype) {
		this.pettype = pettype;
	}


	public String getPetdetail() {
		return petdetail;
	}


	public void setPetdetail(String petdetail) {
		this.petdetail = petdetail;
	}


	public String getPetweight() {
		return petweight;
	}


	public void setPetweight(String petweight) {
		this.petweight = petweight;
	}


	public String getPetsex() {
		return petsex;
	}


	public void setPetsex(String petsex) {
		this.petsex = petsex;
	}


	public String getPettnar() {
		return pettnar;
	}


	public void setPettnar(String pettnar) {
		this.pettnar = pettnar;
	}


	public String getPetintro() {
		return petintro;
	}


	public void setPetintro(String petintro) {
		this.petintro = petintro;
	}


	public int getFollower() {
		return follower;
	}


	public void setFollower(int follower) {
		this.follower = follower;
	}


	public int getFollowing() {
		return following;
	}


	public void setFollowing(int following) {
		this.following = following;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getNickname() {
		return nickname;
	}


	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


	public Mypagememandpet() {
		
	}


	public Mypagememandpet(String email, String myprofile_img, String myage, String mysex, String myintro,
			String petprofile_img, String petname, String petage, String pettype, String petdetail, String petweight,
			String petsex, String pettnar, String petintro, int follower, int following, String name, String nickname) {
		super();
		this.email = email;
		this.myprofile_img = myprofile_img;
		this.myage = myage;
		this.mysex = mysex;
		this.myintro = myintro;
		this.petprofile_img = petprofile_img;
		this.petname = petname;
		this.petage = petage;
		this.pettype = pettype;
		this.petdetail = petdetail;
		this.petweight = petweight;
		this.petsex = petsex;
		this.pettnar = pettnar;
		this.petintro = petintro;
		this.follower = follower;
		this.following = following;
		this.name = name;
		this.nickname = nickname;
	}


	public Mypagememandpet(String email, String myprofile_img, String myage, String mysex, String myintro,
			String petprofile_img, String petname, String petage, String pettype, String petdetail, String petweight,
			String petsex, String pettnar, String petintro, int follower, int following) {
		super();
		this.email = email;
		this.myprofile_img = myprofile_img;
		this.myage = myage;
		this.mysex = mysex;
		this.myintro = myintro;
		this.petprofile_img = petprofile_img;
		this.petname = petname;
		this.petage = petage;
		this.pettype = pettype;
		this.petdetail = petdetail;
		this.petweight = petweight;
		this.petsex = petsex;
		this.pettnar = pettnar;
		this.petintro = petintro;
		this.follower = follower;
		this.following = following;
	}




	public Mypagememandpet(String email, int follower, int following, String nickname) {
		super();
		this.email = email;
		this.follower = follower;
		this.following = following;
		this.nickname = nickname;
	}


	@Override
	public String toString() {
		return "Mypagememandpet [email=" + email + ", myprofile_img=" + myprofile_img + ", myage=" + myage + ", mysex="
				+ mysex + ", myintro=" + myintro + ", petprofile_img=" + petprofile_img + ", petname=" + petname
				+ ", petage=" + petage + ", pettype=" + pettype + ", petdetail=" + petdetail + ", petweight="
				+ petweight + ", petsex=" + petsex + ", pettnar=" + pettnar + ", petintro=" + petintro + ", follower="
				+ follower + ", following=" + following + ", name=" + name + ", nickname=" + nickname + "]";
	}

	
}
