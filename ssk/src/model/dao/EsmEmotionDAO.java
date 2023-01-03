package model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.dto.EsmEmotion;
import model.dto.EsmRecord;
import model.dto.EsmType;

public class EsmEmotionDAO {
	private final static String SQLST_SELECT_ESM_EMOTION = "SELECT * FROM esm_emotion WHERE esm_type= ?";
	
	public static ArrayList<EsmEmotion> getEsmEmotionListByEsmType(Connection con, EsmType esmType){
		ArrayList<EsmRecord> esmRecordList = new ArrayList<EsmRecord>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_RECORD_BY_DATE);
			pstmt.setInt(1, userId);
			pstmt.setDate(2, esmRecordDate);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EsmRecord esmRecordElement = new EsmRecord();
				esmRecordElement.setEsmRecordId(rs.getInt("esm_record_id"));
				esmRecordElement.setEsmRecordText(rs.getString("esm_record_text"));
				esmRecordElement.setEsmRecordDate(rs.getDate("esm_record_date"));
				esmRecordElement.setEsmRecordTime(rs.getTime("esm_record_time"));
				esmRecordElement.setUserId(rs.getInt("user_id"));
				esmRecordList.add(esmRecordElement);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return esmRecordList;
	}

}
