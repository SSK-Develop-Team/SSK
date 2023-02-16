package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;

import model.dto.LangGame;
import model.dto.LangReply;
import model.dto.LangQuestion;

/**
 * 
 * @author Jiwon Lee
 * 언어 발달 평가 응답(lang_reply) DAO
 * 응답 삽입
 * 응답 업데이트
 * 응답 조회
 *
 */
public class LangReplyDAO {
	private static final String SQLST_INSERT_LANG_REPLY = "insert lang_reply(lang_test_log_id, lang_question_id, lang_reply_content) values(?,?,?)";
	private static final String SQLST_UPDATE_LANG_REPLY_BY_ID = "UPDATE lang_reply SET lang_reply_content = ? WHERE lang_reply_id = ?";
	private static final String SQLST_SELECT_LANG_REPLY_LIST_BY_LANG_TEST_LOG_ID = "SELECT * FROM lang_reply where lang_test_log_id=?";
	
	private final static String SQLST_SELECT_AGE_GROUP_ID_BY_TEST_LOG_ID = "SELECT age_group_id FROM lang_reply \r\n" + 
							"LEFT JOIN lang_question ON lang_reply.lang_question_id = lang_question.lang_question_id \r\n" +
							"WHERE lang_test_log_id = ?";
	
	/*응답 삽입*/
	public static boolean insertLangReply(Connection con, LangReply langReply) {
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_INSERT_LANG_REPLY, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1,langReply.getLangTestLogId());
			pstmt.setInt(2, langReply.getLangQuestionId());
			pstmt.setInt(3, langReply.getLangReplyContent());
			
			pstmt.executeUpdate();
			
			ResultSet rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				langReply.setLangReplyId(rs.getInt(1));
				return true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/*응답 업데이트*/
	public static boolean updateLangReply(Connection con, LangReply langReply) {
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_UPDATE_LANG_REPLY_BY_ID);
			pstmt.setInt(1, langReply.getLangReplyContent());
			pstmt.setInt(2, langReply.getLangReplyId());
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt==1) {
				return true;
			}else {
				return false;
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	/*응답 조회*/
	public static ArrayList<LangReply> getLangReplyListByLangTestLogId(Connection con, int langTestLogId){
		try {
			ArrayList<LangReply> langReplyList = new ArrayList<LangReply>();
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_LANG_REPLY_LIST_BY_LANG_TEST_LOG_ID);
			pstmt.setInt(1, langTestLogId);
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				LangReply langReplyElement = new LangReply();
				langReplyElement.setLangReplyId(rs.getInt(1));
				langReplyElement.setLangTestLogId(rs.getInt(2));
				langReplyElement.setLangQuestionId(rs.getInt(3));
				langReplyElement.setLangReplyContent(rs.getInt(4));
				langReplyList.add(langReplyElement);
			}
			return langReplyList;
		}catch(SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static int getLangAgeGroupIdByLogId(Connection con, int langTestLogId){
		try {
			ArrayList<Integer> ageGroupIdList = new ArrayList<Integer>();
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_AGE_GROUP_ID_BY_TEST_LOG_ID);
			pstmt.setInt(1, langTestLogId);
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int ageGroupIdElement = 0;
				ageGroupIdElement = rs.getInt(1);
				if(!ageGroupIdList.contains(ageGroupIdElement))
					ageGroupIdList.add(ageGroupIdElement);
			}
			return ageGroupIdList.get(0);
		}catch(SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}
}
