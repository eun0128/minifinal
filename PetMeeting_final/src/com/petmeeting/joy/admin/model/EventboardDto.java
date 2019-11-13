package com.petmeeting.joy.admin.model;

import java.io.Serializable;
import java.util.Date;

public class EventboardDto implements Serializable {
	
	private int seq;
	
	private String title;
	private String content;
	
	private String filename;
	
	private String location;
	private String location_detail;
	
	private Date event_sdate;
	private Date event_edate;
	private Date regdate;
	
	private boolean progressCheck;
	
	public EventboardDto() {
	}

	public EventboardDto(int seq, String title, String content, String filename, String location,
			String location_detail, Date event_sdate, Date event_edate, Date regdate) {
		super();
		this.seq = seq;
		this.title = title;
		this.content = content;
		this.filename = filename;
		this.location = location;
		this.location_detail = location_detail;
		this.event_sdate = event_sdate;
		this.event_edate = event_edate;
		this.regdate = regdate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getLocation_detail() {
		return location_detail;
	}

	public void setLocation_detail(String location_detail) {
		this.location_detail = location_detail;
	}

	public Date getEvent_sdate() {
		return event_sdate;
	}

	public void setEvent_sdate(Date event_sdate) {
		this.event_sdate = event_sdate;
	}

	public Date getEvent_edate() {
		return event_edate;
	}

	public void setEvent_edate(Date event_edate) {
		this.event_edate = event_edate;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public boolean isProgressCheck() {
		return progressCheck;
	}

	public void setProgressCheck(boolean progressCheck) {
		this.progressCheck = progressCheck;
	}

	@Override
	public String toString() {
		return "EventboardDto [seq=" + seq + ", title=" + title + ", content=" + content + ", filename=" + filename
				+ ", location=" + location + ", location_detail=" + location_detail + ", event_sdate=" + event_sdate
				+ ", event_edate=" + event_edate + ", regdate=" + regdate + ", progressCheck=" + progressCheck + "]";
	}



}
