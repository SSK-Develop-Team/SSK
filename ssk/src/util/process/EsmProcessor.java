package util.process;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;

public class EsmProcessor {
	/**
	 * 날짜의 요일 번호를 받아오는 함수(Sunday = 1, Monday = 2, ..., Saturday = 7)
	 * @param currDate
	 * @return 요일 번호
	 */
	public static int getDayOfTheWeek(Date currDate) {
		Calendar currCal = Calendar.getInstance();
		currCal.setTime(currDate);
		int dayOfTheWeek = currCal.get(Calendar.DAY_OF_WEEK);
		return dayOfTheWeek;
	}
	
	/**
	 * 날짜에 해당하는 주의 모든 날짜 정보를 리스트로 받아오는 함수
	 * @param currDate
	 * @return ArrayList<Date>
	 */
	public static ArrayList<Date> getDateListOfWeek(Date currDate){
		ArrayList<Date> dateListOfWeek = new ArrayList<Date>();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(currDate);
		int dayOfTheWeek = cal.get(Calendar.DAY_OF_WEEK);
		
		for(int i=1;i<=7;i++) {
			if(i==dayOfTheWeek) {
				dateListOfWeek.add(currDate);
			}else {
				cal.add(Calendar.DATE, i-dayOfTheWeek);
				dateListOfWeek.add(new Date(cal.getTimeInMillis()));
				cal.add(Calendar.DATE, -i+dayOfTheWeek);
			}
		}
		
		return dateListOfWeek;
	}
	
	/**
	 * 날짜에 해당하는 주의 첫번째 날짜 정보(일요일)를 받아오는 함수
	 * @param currDate
	 * @return Date
	 */
	public static Date getStartDateOfWeek(Date currDate) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(currDate);
		int dayOfTheWeek = cal.get(Calendar.DAY_OF_WEEK);
		
		cal.add(Calendar.DATE, 1-dayOfTheWeek);
		return new Date(cal.getTimeInMillis());
	}
	
	/**
	 * 날짜에 해당하는 주의 마지막 날짜 정보(토요일)를 받아오는 함수
	 * @param currDate
	 * @return Date
	 */
	public static Date getEndDateOfWeek(Date currDate) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(currDate);
		int dayOfTheWeek = cal.get(Calendar.DAY_OF_WEEK);
		
		cal.add(Calendar.DATE, 7-dayOfTheWeek);
		return new Date(cal.getTimeInMillis());
	}
}
