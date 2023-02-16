package model.dto;

import model.dto.export.SdqColumnInfo;
import model.dto.export.SdqExcelDTO;
import model.dto.export.UserColumnInfo;
import model.dto.export.UserExcelDTO;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.sql.Date;
import java.util.ArrayList;

import static model.dto.export.SdqColumnInfo.*;
import static model.dto.export.UserColumnInfo.*;

public class SskExcelByUser {
    private String fileName="default.xlsx";
    private Workbook wb;
    private Sheet sheet;
    private int rowIndex = 0;

    private CellStyle headerCellStyle, bodyCellStyle;

    /*init*/
    public SskExcelByUser(){
        wb = new XSSFWorkbook();
        sheet = wb.createSheet();
        setHeaderCellStyle();
        setBodyCellStyle();
    }

    /*Get FileName*/
    public String getFileName(){
        return fileName;
    }

    /*Get Workbook*/
    public Workbook getWorkBook(){
        return wb;
    }

    /*User data export*/
    public void addUserData(UserExcelDTO userExcelDTO){
        this.fileName = userExcelDTO.getId() + "_" + userExcelDTO.getLoginId() + "_" + userExcelDTO.getName() + "_" + new Date(System.currentTimeMillis()) +"_아동별.xlsx";
        sheet.createRow(rowIndex++);
        Row headerRow = sheet.createRow(rowIndex++);

        for(UserColumnInfo x : UserColumnInfo.getAllColumns()){
            createCellWithStyle(headerRow,x.getColumnIndex(),x.getColumnText(),headerCellStyle);
        }

        Row bodyRow  = sheet.createRow(rowIndex++);
        createCellWithStyleInt(bodyRow, ID.getColumnIndex(), userExcelDTO.getId(), bodyCellStyle);
        createCellWithStyle(bodyRow, NAME.getColumnIndex(), userExcelDTO.getName(), bodyCellStyle);
        createCellWithStyle(bodyRow, LOGIN_ID.getColumnIndex(), userExcelDTO.getLoginId(), bodyCellStyle);
        createCellWithStyle(bodyRow, EMAIL.getColumnIndex(), userExcelDTO.getEmail(), bodyCellStyle);
        createCellWithStyle(bodyRow, BIRTH.getColumnIndex(), userExcelDTO.getBirthStr(), bodyCellStyle);
        createCellWithStyle(bodyRow, GENDER.getColumnIndex(), userExcelDTO.getGenderStr(), bodyCellStyle);

        sheet.setColumnWidth(EMAIL.getColumnIndex(), 2000);
    }

    /*Sdq Data Export*/
    public void addSdqData(ArrayList<SdqExcelDTO> sdqExcelDTOS){
        sheet.createRow(rowIndex++);
        sheet.createRow(rowIndex++);

        Row headerRow = sheet.createRow(rowIndex++);

        for(SdqColumnInfo x : SdqColumnInfo.getAllColumns()){
             createCellWithStyle(headerRow,x.getColumnIndex(),x.getColumnText(),headerCellStyle);
             sheet.autoSizeColumn(x.getColumnIndex());
        }

        for(int i=0;i<sdqExcelDTOS.size();i++){
            Row bodyRow  = sheet.createRow(rowIndex++);
            createCellWithStyleInt(bodyRow, SDQ_ID.getColumnIndex(), sdqExcelDTOS.get(i).getId(), bodyCellStyle);
            createCellWithStyle(bodyRow, SDQ_TARGET.getColumnIndex(), sdqExcelDTOS.get(i).getTarget(), bodyCellStyle);
            createCellWithStyle(bodyRow, SDQ_DATETIME.getColumnIndex(), sdqExcelDTOS.get(i).getDateStr(), bodyCellStyle);
            sheet.autoSizeColumn(SDQ_DATETIME.getColumnIndex());
            createCellWithStyleInt(bodyRow, SDQ_ANSWER1.getColumnIndex(), sdqExcelDTOS.get(i).getReplyList().get(0), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER2.getColumnIndex(), sdqExcelDTOS.get(i).getReplyList().get(1), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER3.getColumnIndex(), sdqExcelDTOS.get(i).getReplyList().get(2), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER4.getColumnIndex(), sdqExcelDTOS.get(i).getReplyList().get(3), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER5.getColumnIndex(), sdqExcelDTOS.get(i).getReplyList().get(4), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER6.getColumnIndex(), sdqExcelDTOS.get(i).getReplyList().get(5), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER7.getColumnIndex(), sdqExcelDTOS.get(i).getReplyList().get(6), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER8.getColumnIndex(), sdqExcelDTOS.get(i).getReplyList().get(7), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER9.getColumnIndex(), sdqExcelDTOS.get(i).getReplyList().get(8), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER10.getColumnIndex(), sdqExcelDTOS.get(i).getReplyList().get(9), bodyCellStyle);

            ArrayList<SdqResultOfType> scoreList = sdqExcelDTOS.get(i).getScoreList();

            /*match sdq result and type column*/
            for(int j = 0 ; j<scoreList.size();j++){
                String typeName = scoreList.get(j).getSdqType();
                int columnIndex = SdqColumnInfo.findByColumnText(typeName).getColumnIndex();

                createCellWithStyleInt(bodyRow, columnIndex, scoreList.get(j).getResult(), bodyCellStyle);
                sheet.autoSizeColumn(columnIndex);
            }

        }

    }

    public void createCellWithStyle(Row row, int columnIndex, String value, CellStyle cellStyle){
        Cell cell = row.createCell(columnIndex);
        cell.setCellValue(value);
        cell.setCellStyle(cellStyle);
    }

    public void createCellWithStyleInt(Row row, int columnIndex, int value, CellStyle cellStyle){
        Cell cell = row.createCell(columnIndex);
        cell.setCellValue(value);
        cell.setCellStyle(cellStyle);
    }

    public void createCellWithStyleFloat(Row row, int columnIndex, float value, CellStyle cellStyle){
        Cell cell = row.createCell(columnIndex);
        cell.setCellValue(value);
        cell.setCellStyle(cellStyle);
    }



    /*Set Standard Cell Style - header, body*/
    public void setHeaderCellStyle(){
        headerCellStyle = (XSSFCellStyle) wb.createCellStyle();

        // 배경색 지정
        headerCellStyle.setFillForegroundColor(IndexedColors.AQUA.getIndex());
        headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // 정렬
        headerCellStyle.setAlignment(HorizontalAlignment.CENTER);
        headerCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        // 테두리
        headerCellStyle.setBorderTop(BorderStyle.THIN);
        headerCellStyle.setBorderBottom(BorderStyle.THIN);
        headerCellStyle.setBorderLeft(BorderStyle.THIN);
        headerCellStyle.setBorderRight(BorderStyle.THIN);
    }

    public void setBodyCellStyle(){
        bodyCellStyle = (XSSFCellStyle) wb.createCellStyle();

        // 정렬
        bodyCellStyle.setAlignment(HorizontalAlignment.CENTER);
        bodyCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        // 테두리
        bodyCellStyle.setBorderTop(BorderStyle.THIN);
        bodyCellStyle.setBorderBottom(BorderStyle.THIN);
        bodyCellStyle.setBorderLeft(BorderStyle.THIN);
        bodyCellStyle.setBorderRight(BorderStyle.THIN);
    }
}
