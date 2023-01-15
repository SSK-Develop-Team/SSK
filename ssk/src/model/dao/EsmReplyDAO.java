package model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.dto.EsmReply;
import model.dto.EsmTestLog;
import model.dto.SdqReply;

/**
 * @author Seo Ji Woo, Jiwon Lee
 * 
 * 정서 반복 기록 응답 삽입
 * 정서 반복 기록 응답 조회(테스트 로그 아이디로 조회)
 */

public class EsmReplyDAO {/*REPLY!=RESULT*/
	private final static String SQLST_INSERT_ESM_REPLY = "insert esm_reply(esm_test_log_id, esm_emotion_id, esm_reply_content) values(?,?,?)";
	private final static String SQLST_SELECT_ESM_REPLY_LIST_BY_ESM_TEST_LOG_ID = "select * from esm_reply where esm_test_log_id = ?";
	
	/*정서 반복 기록 응답 삽입*/
	public static boolean insertEsmReply(Connection con, EsmReply esmReply) {
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
	
	/*정서 반복 기록 응답 조회*/
	public static ArrayList<EsmReply> getEsmReplyListByEsmTestLogId(Connection con, int esmTestLogId){
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_REPLY_LIST_BY_ESM_TEST_LOG_ID);
			pstmt.setInt(1, esmTestLogId);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<EsmReply> esmReplyList = new ArrayList<EsmReply>();
			while(rs.next()) {
				EsmReply esmReply = new EsmReply(rs.getInt(2),rs.getInt(3),rs.getInt(4));
				esmReply.setEsmReplyId(rs.getInt(1));
				esmReplyList.add(esmReply);
			}
			return esmReplyList;
		}
		catch(SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

}
