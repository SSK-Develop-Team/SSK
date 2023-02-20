package model.sevice;

import model.dao.*;
import model.dto.*;
import model.dto.export.*;

import java.sql.Connection;
import java.util.ArrayList;

public class ExportChildResultExcelService {

    /*아동 기본 정보*/
    public static UserExcelDTO getChildData(Connection con, int childId){
        return new UserExcelDTO(UserDAO.getUserById(con, childId));
    }

    /*언어 검사 결과*/
    public static  ArrayList<LangExcelDTO> getLangDataListOfUser(Connection con, int childId, String childName){
        ArrayList<LangExcelDTO> langDataList = new ArrayList<LangExcelDTO>();

        ArrayList<LangTestLog> langTestLogList = LangTestLogDAO.getLangTestLogByUserId(con, childId);
        for(int i=0;i<langTestLogList.size();i++){
            LangTestLog langTestLog = langTestLogList.get(i);

            LangExcelDTO langData = new LangExcelDTO();
            langData.setUserId(childId);
            langData.setUserName(childName);
            langData.setId(i+1);
            langData.setDateStr(langTestLog.getLangTestDate());
            langData.setAgeGroupStr(LangReplyDAO.getLangAgeGroupIdByLogId(con,langTestLog.getLangTestLogId()));
            ArrayList<LangReply> langReplyList = LangReplyDAO.getLangReplyListByLangTestLogId(con,langTestLog.getLangTestLogId());
            ArrayList<Integer> langReplyIntegerList = new ArrayList<Integer>();
            for(int j=0;j< langReplyList.size();j++){
                langReplyIntegerList.add(langReplyList.get(j).getLangReplyContent());/*순서 보장 필요 -> 쿼리문으로 조정할 것(order by question id)*/
            }
            langData.setReplyList(langReplyIntegerList);
            langDataList.add(langData);
        }
        return langDataList;
    }


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
    public static ArrayList<EsmExcelDTO> getEsmDataListOfUser(Connection con, int childId, String childName){
        ArrayList<EsmExcelDTO> esmDataList = new ArrayList<EsmExcelDTO>();

        ArrayList<EsmTestLog> esmTestLogList = EsmTestLogDAO.getEsmTestLogListByUserId(con, childId);
        for(int i=0;i< esmTestLogList.size();i++){
            EsmTestLog esmTestLog = esmTestLogList.get(i);

            EsmExcelDTO esmData = new EsmExcelDTO();
            esmData.setUserId(childId);
            esmData.setUserName(childName);

            esmData.setId(i+1);
            esmData.setDateStr(esmTestLog.getEsmTestDate(), esmTestLog.getEsmTestTime());
            esmData.setReplyList(EsmReplyDAO.getEsmReplyIntegerListByEsmTestLogId(con,esmTestLog.getEsmTestLogId()));
            esmData.setScoreList(EsmReplyDAO.getEsmResultByEsmTestLogId(con,esmTestLog.getEsmTestLogId()));

            esmDataList.add(esmData);
        }

        return esmDataList;
    }

    /*정서 다이어리*/
    public static ArrayList<EsmRecordExcelDTO> getEsmRecordDataListOfUser(Connection con, int childId, String childName){
        ArrayList<EsmRecordExcelDTO> esmRecordDataList = new ArrayList<EsmRecordExcelDTO>();

        ArrayList<EsmRecord> esmRecordList = EsmRecordDAO.getEsmRecordListByUser(con, childId);
        for(int i=0;i<esmRecordList.size();i++){
            EsmRecordExcelDTO esmRecordData = new EsmRecordExcelDTO();
            esmRecordData.setUserId(childId);
            esmRecordData.setUserName(childName);

            esmRecordData.setId(i+1);
            esmRecordData.setText(esmRecordList.get(i).getEsmRecordText());
            esmRecordData.setDateStr(esmRecordList.get(i).getEsmRecordDate(), esmRecordList.get(i).getEsmRecordTime());

            esmRecordDataList.add(esmRecordData);
        }

        return esmRecordDataList;
    }


    /* export ssk excel by child*/
    public static SskExcelByUser getSskExcelByChild(Connection con, int childId, boolean lang, boolean sdq, boolean esm, boolean esmRecord){
        SskExcelByUser sskExcelByUser = new SskExcelByUser();

        UserExcelDTO userExcelDTO = getChildData(con, childId);
        sskExcelByUser.addUserData(userExcelDTO);

        if(lang==true){
            ArrayList<LangExcelDTO> langExcelDTOS = getLangDataListOfUser(con, childId, userExcelDTO.getName());
            sskExcelByUser.addLangData(langExcelDTOS);
        }
        if(sdq==true){
            ArrayList<SdqExcelDTO> sdqExcelDTOS = getSdqDataListOfUser(con, childId, userExcelDTO.getName());
            sskExcelByUser.addSdqData(sdqExcelDTOS);
        }
        if(esm==true){
            ArrayList<EsmExcelDTO> esmExcelDTOS = getEsmDataListOfUser(con, childId, userExcelDTO.getName());
            sskExcelByUser.addEsmData(esmExcelDTOS);
        }
        if(esmRecord==true){
            ArrayList<EsmRecordExcelDTO> esmRecordExcelDTOS = getEsmRecordDataListOfUser(con, childId, userExcelDTO.getName());
            sskExcelByUser.addEsmRecordData(esmRecordExcelDTOS);
        }

        return sskExcelByUser;
    }
}
