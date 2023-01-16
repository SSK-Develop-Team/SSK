package model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.dto.EsmReply;
import model.dto.EsmTestLog;

/**
 * @author Seo Ji Woo
 *
 */

public class EsmReplyDAO {/*REPLY!=RESULT*/
	private final static String SQLST_INSERT_ESM_REPLY = "insert esm_reply(esm_test_log_id, esm_emotion_id, esm_reply_content) values(?,?,?)";
	
	public static boolean insertESMReply(Connection con, EsmReply esmReply) {
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_INSERT_ESM_REPLY, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, esmReply.getEsmTestLogId());
			pstmt.setInt(2, esmReply.getEsmEmotionId());
			pstmt.setInt(3, esmReply.getEsmReplyContent());
			
			pstmt.executeUpdate();
			
			ResultSet rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				esmReply.setEsmReplyId(rs.getInt(1));
				return true;
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
