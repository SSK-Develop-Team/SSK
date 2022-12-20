package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.dto.User;

public class UserDAO {
	
	private final static String SQLST_SELECT_USER_LOGIN_ID_BY_ID = "select user_login_id from user_profile where user_login_id = ?;";
	private final static String SQLST_SELECT_USER_BY_LOGIN_ID = "select * from user_profile where user_login_id = ?";
	private final static String SQLST_SELECT_USER_LIST_BY_EXPERT_ID = "select * from user_profile where expert_id=?";
	private final static String SQLST_SELECT_USER_BY_ID = "select * from user_profile where user_id=?";
	private final static String SQLST_INSERT_USER = "insert user_profile(user_login_id, user_password, user_name, "
			+ "user_gender, user_birth, user_role, user_icon, expert_id, current_age) values(?,?,?,?,?,?,?,?,?)";
	private final static String SQLST_UPDATE_USER_INFO = "update user_profile set user_password=?, user_name=?, user_gender=?,"
            + "user_birth=?, user_role=?, user_icon=?, expert_id=?, current_age=?";
	private final static String SQLST_DELETE_USER = "DELETE FROM user_profile WHERE user_id = ?";	
	
	public static boolean checkId(Connection con, String userid){
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_USER_LOGIN_ID_BY_ID);
			pstmt.setString(1, userid);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return false;
			}
			else {
				return true;
			}
			
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public static User findUser(Connection con, String userLoginId, String userLoginPw){
		User user = new User();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_USER_BY_LOGIN_ID);

	        pstmt.setString(1, userLoginId);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String user_login_pw = rs.getString(3);
				if(user_login_pw.equals(userLoginPw)) {
					user.setUserId(rs.getInt(1));
					user.setUserLoginId(rs.getString(2));
					user.setUserPassword(rs.getString(3));
					user.setUserName(rs.getString(4));
					user.setUserGender(rs.getString(5));
					user.setUserBirth(rs.getDate(6));
					user.setUserRole(rs.getString(7));
					user.setUserIcon(rs.getString(8));
	                user.setExpertId(rs.getInt(9));
	                user.setCurrentAge(rs.getInt(10));
					return user;
				}
				else { //login failed
					return null;
				}
			}
			else { //invalid user
				return null;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
   
	/*회원가입*/
	public static boolean insertUser(Connection con, User user){
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_INSERT_USER);
			pstmt.setString(1, user.getUserLoginId());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setDate(5, user.getUserBirth());
			pstmt.setString(6, user.getUserRole());
			pstmt.setString(7, user.getUserIcon());
			pstmt.setInt(8, user.getExpertId());
			pstmt.setInt(9, user.getCurrentAge());
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

	/*전문가가 관리하는 사용자 리스트 조회 - 슈퍼 전문가는 모즌 전문가를 관리, 전문가는 자신의 아동을 관리 */
	public static ArrayList<User> getUserListByExpert(Connection con, int expertId){
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_USER_LIST_BY_EXPERT_ID);
			pstmt.setInt(1, expertId);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<User> userList = new ArrayList<User>();
			while(rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt(1));
				user.setUserLoginId(rs.getString(2));
				user.setUserPassword(rs.getString(3));
				user.setUserName(rs.getString(4));
				user.setUserGender(rs.getString(5));
				user.setUserBirth(rs.getDate(6));
				user.setUserRole(rs.getString(7));
				user.setUserIcon(rs.getString(8));
				user.setExpertId(rs.getInt(9));
				user.setCurrentAge(rs.getInt(10));
				userList.add(user);
			}
			return userList;
		}
		catch(SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/*선택한 사용자 정보 */
	public static User getUserById(Connection con, int userId) {
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_USER_BY_ID);
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				User child = new User();
				child.setUserId(rs.getInt(1));
				child.setUserLoginId(rs.getString(2));
				child.setUserPassword(rs.getString(3));
				child.setUserName(rs.getString(4));
				child.setUserGender(rs.getString(5));
				child.setUserBirth(rs.getDate(6));
				child.setUserRole(rs.getString(7));
				child.setUserIcon(rs.getString(8));
				child.setExpertId(rs.getInt(9));
				child.setCurrentAge(rs.getInt(10));
				return child;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*유저 정보 업데이트*/
	public static boolean updateUser(Connection con, User user) {
      boolean flag = false;
      try {
         PreparedStatement pstmt = con.prepareStatement(SQLST_UPDATE_USER_INFO);
         pstmt.setString(1, user.getUserPassword());
         pstmt.setString(2, user.getUserName());
         pstmt.setString(3, user.getUserGender());
         pstmt.setDate(4, user.getUserBirth());
         pstmt.setString(5, user.getUserRole());
         pstmt.setString(6, user.getUserIcon());
         pstmt.setInt(10, user.getExpertId());
         pstmt.setInt(10, user.getCurrentAge());
         int count = pstmt.executeUpdate();
         if (count > 0)
            flag = true;
      } catch (Exception e) {
         e.printStackTrace();
      }
      return flag;
   }
	
	/*사용자 삭제*/
	public static void deleteUser(Connection con, int userId) {
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_DELETE_USER);
			pstmt.setInt(1, userId);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
   

}
