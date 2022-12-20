package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AgeGroupDAO {
	private final static String SQLST_GET_CURRENT_AGE = "select * from age_group where start_age <= ? AND ? <= end_age";
	/*currentAge 찾기*/
	public static int getCurrAge(Connection con, int nowAge) {
		int findCurrAge = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_GET_CURRENT_AGE);
			pstmt.setInt(1, nowAge);
			pstmt.setInt(2, nowAge);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				findCurrAge = rs.getInt("age_group_id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return findCurrAge;
	}
}
