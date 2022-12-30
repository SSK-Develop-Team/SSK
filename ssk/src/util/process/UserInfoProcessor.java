package util.process;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class UserInfoProcessor {
	public static int getUserBirthToCurrAge(Date userBirth) {
		SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date(System.currentTimeMillis());
		
		String nowDate = formatter.format(date);
		String birthDate = formatter.format(userBirth);
		
		String nowYear = nowDate.split("-")[0];
		String nowMonth = nowDate.split("-")[1];
		
		String birthYear = birthDate.split("-")[0];
		String birthMonth = birthDate.split("-")[1];
		
		int curYear = Integer.parseInt(nowYear);
		int curMonth = Integer.parseInt(nowMonth);
		
		int nowAge = (Integer.parseInt(nowYear) - Integer.parseInt(birthYear)) * 12 + (Integer.parseInt(nowMonth) - Integer.parseInt(birthMonth));
		
		return nowAge;
	}

}
