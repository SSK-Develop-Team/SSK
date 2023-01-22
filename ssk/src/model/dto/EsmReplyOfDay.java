 package model.dto;

import java.sql.Date;

public class EsmReplyOfDay {
	private Date date;
	private float positiveAvg;
	private float negativeAvg;
	public EsmReplyOfDay(Date date, float positiveAvg, float negativeAvg) {
		super();
		this.date = date;
		this.positiveAvg = positiveAvg;
		this.negativeAvg = negativeAvg;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public float getPositiveAvg() {
		return positiveAvg;
	}
	public void setPositiveAvg(float positiveAvg) {
		this.positiveAvg = positiveAvg;
	}
	public float getNegativeAvg() {
		return negativeAvg;
	}
	public void setNegativeAvg(float negativeAvg) {
		this.negativeAvg = negativeAvg;
	}
	
	@Override
	public boolean equals(Object o){
		return ( date.equals(((EsmReplyOfDay)o).date) && positiveAvg == ((EsmReplyOfDay)o).positiveAvg && negativeAvg == ((EsmReplyOfDay)o).negativeAvg);
	}
}
