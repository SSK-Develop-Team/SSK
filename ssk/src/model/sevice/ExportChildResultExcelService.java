package model.sevice;

import model.dao.SdqReplyDAO;
import model.dao.SdqTestLogDAO;
import model.dao.UserDAO;
import model.dto.SdqTarget;
import model.dto.SdqTestLog;
import model.dto.SskExcelByUser;
import model.dto.export.SdqExcelDTO;
import model.dto.export.UserExcelDTO;

import java.sql.Connection;
import java.util.ArrayList;

public class ExportChildResultExcelService {

    /*아동 기본 정보*/
    public static UserExcelDTO getChildData(Connection con, int childId){
        return new UserExcelDTO(UserDAO.getUserById(con, childId));
    }

    /*언어 검사 결과*/

    /*정서행동 발달 검사 결과*/
    public static ArrayList<SdqExcelDTO> getSdqDataListOfUser(Connection con, int childId, String childName){
        ArrayList<SdqExcelDTO> sdqDataList = new ArrayList<SdqExcelDTO>();

        ArrayList<SdqTestLog> sdqTestLogList = SdqTestLogDAO.getSdqTestLogAllByUserId(con, childId);//아동의 모든 SDQ 기록 가져오기
        for(int i=0;i< sdqTestLogList.size();i++){
            SdqTestLog sdqTestLog = sdqTestLogList.get(i);

            SdqExcelDTO sdqData = new SdqExcelDTO();
            sdqData.setUserId(childId);
            sdqData.setUserName(childName);

            sdqData.setId(i+1);
            sdqData.setTarget(SdqTarget.getTypeNameKrByTypeName(SdqReplyDAO.getSdqTargetBySdqTestLogId(con, sdqTestLog.getSdqTestLogId())));
            sdqData.setDateStr(sdqTestLog.getSdqTestDate(), sdqTestLog.getSdqTestTime());
            sdqData.setReplyList(SdqReplyDAO.getSdqReplyListIntegerBySdqTestLogId(con, sdqTestLog.getSdqTestLogId()));//기록의 문항별 응답
            sdqData.setScoreList(SdqReplyDAO.getSdqResultOfTypesBySdqTestLogId(con, sdqTestLog.getSdqTestLogId()));//기록의 타입별 점수

            sdqDataList.add(sdqData);
        }

        return sdqDataList;
    }

    /*정서 반복 기록*/
    
    /*정서 다이어리*/


    /* export ssk excel by child*/
    public static SskExcelByUser getSskExcelByChild(Connection con, int childId, boolean lang, boolean sdq, boolean esm, boolean esmRecord){
        UserExcelDTO userExcelDTO = getChildData(con, childId);
        ArrayList<SdqExcelDTO> sdqExcelDTOS = getSdqDataListOfUser(con, childId, userExcelDTO.getName());

        SskExcelByUser sskExcelByUser = new SskExcelByUser();
        sskExcelByUser.addUserData(userExcelDTO);
        sskExcelByUser.addSdqData(sdqExcelDTOS);

        return sskExcelByUser;
    }
}
