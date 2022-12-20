package model.dto;

import java.sql.Date;
import java.sql.Time;

public class SdqTestLog {
	
	private int sdqTestLogId;
	private int userId;
	private Date sdqTestDate;
	private String sdqTestTime;
	
	public int getSdqTestLogId() {
		return sdqTestLogId;
	}
	public void setSdqTestLogId(int sdqTestLogId) {
		this.sdqTestLogId = sdqTestLogId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Date getSdqTestDate() {
		return sdqTestDate;
	}
	public void setSdqTestDate(Date sdqTestDate) {
		this.sdqTestDate = sdqTestDate;
	}
	public String getSdqTestTime() {
		return sdqTestTime;
	}
	public void setSdqTestTime(String timeStr) {
		this.sdqTestTime = timeStr;
	}
	
}

