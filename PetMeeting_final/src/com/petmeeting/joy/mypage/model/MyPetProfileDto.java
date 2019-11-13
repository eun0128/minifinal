package com.petmeeting.joy.mypage.model;

import java.io.Serializable;
/*
CREATE TABLE PM_PETPROFILE(
	EMAIL VARCHAR2(50),
	PETPROFILE_IMG VARCHAR2(50),
	PETNAME VARCHAR2(100),
	PETAGE NUMBER,
	PETTYPE VARCHAR2(50), 강아지/고양이/기타
	PETDETAIL VARCHAR2(100), 종
	PETWEIGHT VARCHAR2(50), 무게
	PETSEX NUMBER, 
	PETTNR VARCHAR2(50), 중성화여부
	PETINTRO VARCHAR2(1000)
);
*/

public class MyPetProfileDto implements Serializable {
	
	private String email;
	private String petprofile_img;
	private String petname;
	private int petage;
	private String pettype;		// 강아지/고양이/기타
	private String petdetail;	// 종
	private String petweight;	// 무게
	private int petsex;			// 성별 : 0 암컷 / 1 수컷
	private String pettnr;		// 중성화여부 : 0 중성화X, 1 중성화O
	private String petintro;
	
	public MyPetProfileDto() { }

	public MyPetProfileDto(String email, String petprofile_img, String petname, int petage, String pettype,
			String petdetail, String petweight, int petsex, String pettnr, String petintro) {
		super();
		this.email = email;
		this.petprofile_img = petprofile_img;
		this.petname = petname;
		this.petage = petage;
		this.pettype = pettype;
		this.petdetail = petdetail;
		this.petweight = petweight;
		this.petsex = petsex;
		this.pettnr = pettnr;
		this.petintro = petintro;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public int getPetage() {
		return petage;
	}

	public void setPetage(int petage) {
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

	public int getPetsex() {
		return petsex;
	}

	public void setPetsex(int petsex) {
		this.petsex = petsex;
	}

	public String getPettnr() {
		return pettnr;
	}

	public void setPettnr(String pettnr) {
		this.pettnr = pettnr;
	}

	public String getPetintro() {
		return petintro;
	}

	public void setPetintro(String petintro) {
		this.petintro = petintro;
	}

	@Override
	public String toString() {
		return "MyPetProfileDto [email=" + email + ", petprofile_img=" + petprofile_img + ", petname=" + petname
				+ ", petage=" + petage + ", pettype=" + pettype + ", petdetail=" + petdetail + ", petweight="
				+ petweight + ", petsex=" + petsex + ", pettnr=" + pettnr + ", petintro=" + petintro + "]";
	}
	
	

}
