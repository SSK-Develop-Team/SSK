package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.dto.SdqResultAnalysis;

/**
 * @author Seo Ji Woo
 *
 */

public class SDQResultAnalysisDAO {
	
	private final static String SQLST_SELECT_SDQ_RESULT_ANALYSIS = "select * from sdq_result_analysis where sdq_type = ? and sdq_analysis_result = ?";
	private final static String SQLST_SELECT_SDQ_RESULT_ANALYSIS_MIN = "select * from sdq_result_analysis where sdq_type = ? and sdq_analysis_result = ?";
	private final static String SQLST_SELECT_SDQ_RESULT_ANALYSIS_MAX = "select * from sdq_result_analysis where sdq_type = ? and sdq_analysis_result = ?";
	
	public static SdqResultAnalysis getSDQAnalysisResult(Connection con, String sdqtype, String sdqanalysisresult) {
		SdqResultAnalysis bean = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_SDQ_RESULT_ANALYSIS);
			pstmt.setString(1, sdqtype);
			pstmt.setString(2, sdqanalysisresult);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new SdqResultAnalysis();
				bean.setSdqType(rs.getString("sdq_type"));
				bean.setSdqAnalysisResult(rs.getString("sdq_analysis_result"));
				bean.setMinValue(rs.getInt("min_value"));
				bean.setMaxValue(rs.getInt("max_value"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	public static int getSDQAnalysisMin(Connection con, String sdqtype, String sdqanalysisresult) {
		SdqResultAnalysis bean = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_SDQ_RESULT_ANALYSIS_MIN);
			pstmt.setString(1, sdqtype);
			pstmt.setString(2, sdqanalysisresult);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new SdqResultAnalysis();
				bean.setSdqType(rs.getString("sdq_type"));
				bean.setSdqAnalysisResult(rs.getString("sdq_analysis_result"));
				bean.setMinValue(rs.getInt("min_value"));
				bean.setMaxValue(rs.getInt("max_value"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return bean.getMinValue();
	}
	
	public static int getSDQAnalysisMax(Connection con, String sdqtype, String sdqanalysisresult) {
		SdqResultAnalysis bean = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_SDQ_RESULT_ANALYSIS_MAX);
			pstmt.setString(1, sdqtype);
			pstmt.setString(2, sdqanalysisresult);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new SdqResultAnalysis();
				bean.setSdqType(rs.getString("sdq_type"));
				bean.setSdqAnalysisResult(rs.getString("sdq_analysis_result"));
				bean.setMinValue(rs.getInt("min_value"));
				bean.setMaxValue(rs.getInt("max_value"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		return bean.getMaxValue();
	}
}
