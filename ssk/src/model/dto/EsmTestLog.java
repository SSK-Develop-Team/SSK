package model.dto;

import java.sql.Date;
import java.sql.Time;

public class EsmTestLog {
	
	private int esmTestLogId;
	private int userId;
	private Date esmTestDate;
	private String esmTestTime;
	
	public int getEsmTestLogId() {
		return esmTestLogId;
	}
	public void setEsmTestLogId(int esmTestLogId) {
		this.esmTestLogId = esmTestLogId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Date getEsmTestDate() {
		return esmTestDate;
	}
	public void setEsmTestDate(Date esmTestDate) {
		this.esmTestDate = esmTestDate;
	}
	public String getEsmTestTime() {
		return esmTestTime;
	}
	public void setEsmTestTime(String esmTestTime) {
		this.esmTestTime = esmTestTime;
	}
	
}
