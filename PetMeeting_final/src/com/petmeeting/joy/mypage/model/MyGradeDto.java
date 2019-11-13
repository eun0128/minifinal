package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

public class MyGradeDto implements Serializable {
	
	private String grade_name;
	private String filename;
	
	public MyGradeDto() {}

	public MyGradeDto(String grade_name, String filename) {
		super();
		this.grade_name = grade_name;
		this.filename = filename;
	}

	public String getGrade_name() {
		return grade_name;
	}

	public void setGrade_name(String grade_name) {
		this.grade_name = grade_name;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	@Override
	public String toString() {
		return "MyGradeDto [grade_name=" + grade_name + ", filename=" + filename + "]";
	}
	
		
}
