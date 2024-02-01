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
				EsmAlarm esmTime= new EsmAlarm();
				esmTime.setAlarmId(rs.getInt(1));
				esmTime.setAlarmStart(rs.getTime(2));
				esmTime.setAlarmEnd(rs.getTime(3));
				esmTime.setAlarmInterval(rs.getInt(4));
				esmTime.setUserId(rs.getInt(5));
				
				alarmList.add(esmTime);
			}
			return alarmList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//사용자의 ESm 알람 정보 저장하기 (Connection con, int userId)
	public static boolean insertUserAlarm(Connection con, EsmAlarm esmTime ){
		try {
			PreparedStatement pstmt = con.prepareStatement("insert esm_alarm(start_time, end_time, interval_time, user_id) values(?,?,?,?)");
			pstmt.setTime(1, esmTime.getAlarmStart());
			pstmt.setTime(2, esmTime.getAlarmEnd());
			pstmt.setInt(3, esmTime.getAlarmInterval());
			pstmt.setInt(4, esmTime.getUserId());
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
	
	/*사용자의 ESm 알람 정보 업데이트*/
	public static boolean updateUserAlarm(Connection con, EsmAlarm esmTime) {
      boolean flag = false;
      try {
         PreparedStatement pstmt = con.prepareStatement("update esm_alarm set start_time=?, end_time=?, interval_time=? where user_id = ?");
         pstmt.setTime(1, esmTime.getAlarmStart());
         pstmt.setTime(2, esmTime.getAlarmEnd());
         pstmt.setInt(3, esmTime.getAlarmInterval());
         pstmt.setInt(4, esmTime.getUserId());
         
         int count = pstmt.executeUpdate();
         if (count > 0)
            flag = true;
      } catch (Exception e) {
         e.printStackTrace();
      }
      return flag;
   }
	
}
