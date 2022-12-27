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
	private final static String SQLST_SELECT_USER_BY_ID = "select * from user_profile where user_id=?";
	private final static String SQLST_INSERT_USER = "insert user_profile(user_login_id, user_password, user_name, "
			+ "user_email, user_role, registration_date, user_gender, user_birth, user_icon) values(?,?,?,?,?,?,?,?,?)";
	private final static String SQLST_SELECT_USER_LIST_BY_USER_ROLE = "select * from user_profile where user_role=?";
	private final static String SQLST_UPDATE_USER_INFO = "update user_profile set user_password=?, user_name=?, user_email=?,"
            + "user_role=?, registration_date=?, user_gender=?, user_birth=?, user_icon=?";
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
					user.setUserEmail(rs.getString(5));
					user.setUserRole(rs.getString(6));
					user.setRegistrationDate(rs.getDate(7));
					user.setUserGender(rs.getString(8));
					user.setUserBirth(rs.getDate(9));
					user.setUserIcon(rs.getString(10));
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
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserRole());
			pstmt.setDate(6, user.getRegistrationDate());
			pstmt.setString(7, user.getUserGender());
			pstmt.setDate(8, user.getUserBirth());
			pstmt.setString(9, user.getUserIcon());
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

	/*해당 role을 가진 모든 사용자 조회 */
	public static ArrayList<User> getUserListByUserRole(Connection con, String user_role){
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_USER_LIST_BY_USER_ROLE);
			pstmt.setString(1, user_role);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<User> userList = new ArrayList<User>();
			while(rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt(1));
				user.setUserLoginId(rs.getString(2));
				user.setUserPassword(rs.getString(3));
				user.setUserName(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				user.setUserRole(rs.getString(6));
				user.setRegistrationDate(rs.getDate(7));
				user.setUserGender(rs.getString(8));
				user.setUserBirth(rs.getDate(9));
				user.setUserIcon(rs.getString(10));
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
				child.setUserEmail(rs.getString(5));
				child.setUserRole(rs.getString(6));
				child.setRegistrationDate(rs.getDate(7));
				child.setUserGender(rs.getString(8));
				child.setUserBirth(rs.getDate(9));
				child.setUserIcon(rs.getString(10));
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
         pstmt.setString(3, user.getUserName());
         pstmt.setString(4, user.getUserEmail());
         pstmt.setString(5, user.getUserRole());
         pstmt.setDate(6, user.getRegistrationDate());
         pstmt.setString(7, user.getUserGender());
         pstmt.setDate(8, user.getUserBirth());
         pstmt.setString(9, user.getUserIcon());
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
