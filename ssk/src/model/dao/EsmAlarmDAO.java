package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.dto.EsmAlarm;
import model.dto.User;

public class EsmAlarmDAO {
	private final static String SQLST_SELECT_ESMALARM_BY_LOGIN_ID = "select * from esm_alarm where user_login_id = ?";
	//사용자의 Esm 알람 정보 불러오기 (Connection con, int userId)
	public static ArrayList<EsmAlarm> getEsmAlarmListByUser(Connection con, int userId) {
		try {
			PreparedStatement pstmt = con.prepareStatement("select * from esm_alarm where user_id= ?");
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<EsmAlarm> alarmList = new ArrayList<EsmAlarm>();
			if(rs.next()) { 
				EsmAlarm alarm= new EsmAlarm();
				alarm.setAlarmId(rs.getInt(1));
				alarm.setAlarmStart(rs.getTime(2));
				alarm.setAlarmEnd(rs.getTime(3));
				alarm.setUserId(rs.getInt(5));
				
				alarmList.add(alarm);
			}
			return alarmList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//사용자의 ESm 알람 정보 저장하기 (Connection con, int userId)
	public static boolean insertUserAlarm(Connection con, EsmAlarm userAlarm ){
		try {
			PreparedStatement pstmt = con.prepareStatement("insert esm_alarm(start_time, end_time, interval_time,user_id) values(?,?,?,?)");
			pstmt.setTime(1, userAlarm.getAlarmStart());
			pstmt.setTime(2, userAlarm.getAlarmEnd());
			pstmt.setInt(3, userAlarm.getAlarmInterval());
			pstmt.setInt(3, userAlarm.getUserId());
			int insertCount = pstmt.executeUpdate();
			if(insertCount == 1) {
				return true;
			}
			else {
				return false;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	//사용자의 ESm 알람 정보 삭제하기 (Connection con, int userId) //하나씩만 삭제하게 코드수정하기
	public static void deleteUserAlarm(Connection con, int userId) {
		try {
			PreparedStatement pstmt = con.prepareStatement("DELETE FROM esm_alarm WHERE user_id = ?");
			pstmt.setInt(1, userId);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
