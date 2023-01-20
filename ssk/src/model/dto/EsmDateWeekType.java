package model.dto;

import java.sql.Date;

public class EsmDateWeekType {
	private Date date;
	private String weekStr;
	
	public EsmDateWeekType(Date date, Date startDate, Date endDate) {
		super();
		this.date = date;
		this.weekStr = startDate.toString()+" ~ "+endDate.toString();
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getWeekStr() {
		return weekStr;
	}

	public void setWeekStr(Date startDate, Date endDate) {
		this.weekStr = startDate.toString()+" ~ "+endDate.toString();
	}
	
	@Override
	public boolean equals(Object o){
		return ( date.equals(((EsmDateWeekType)o).date) && weekStr == ((EsmDateWeekType)o).weekStr );
	}
}
