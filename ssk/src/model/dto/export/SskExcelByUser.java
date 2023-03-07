package model.dto.export;

import model.dto.EsmResultOfType;
import model.dto.SdqResultOfType;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.sql.Date;
import java.util.ArrayList;

import static model.dto.export.EsmColumnInfo.*;
import static model.dto.export.EsmRecordColumnInfo.*;
import static model.dto.export.LangColumnInfo.*;
import static model.dto.export.SdqColumnInfo.*;
import static model.dto.export.UserColumnInfo.*;

public class SskExcelByUser {
    private String fileName="default.xlsx";
    private Workbook wb;
    private Sheet sheet;
    private int rowIndex = 0;

    private CellStyle defaultCellStyle, headerCellStyle, bodyCellStyle;

    /*init*/
    public SskExcelByUser(){
        wb = new XSSFWorkbook();
        sheet = wb.createSheet("검사 결과");

        setDefaultCellStyle();
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

        Row titleRow = sheet.createRow(rowIndex);
        titleRow.setHeight((short)1000);
        Cell titleCell = titleRow.createCell(0);
        sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 0,UserColumnInfo.getAllColumns().size()-1));
        titleCell.setCellValue("아동 정보");
        titleCell.setCellStyle(defaultCellStyle);
        rowIndex++;

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

    /*Lang Data Export*/
    public void addLangData(ArrayList<LangExcelDTO> langExcelDTOS){
        sheet.createRow(rowIndex++);
        sheet.createRow(rowIndex++);

        Row titleRow = sheet.createRow(rowIndex);
        titleRow.setHeight((short)1000);
        Cell titleCell = titleRow.createCell(0);
        sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 0,LangColumnInfo.getAllColumns().size()-1));
        titleCell.setCellValue("언어 발달 평가");
        titleCell.setCellStyle(defaultCellStyle);
        rowIndex++;
        
        Row headerRow = sheet.createRow(rowIndex++);

        for(LangColumnInfo x : LangColumnInfo.getAllColumns()){
            createCellWithStyle(headerRow,x.getColumnIndex(),x.getColumnText(),headerCellStyle);
            setAutoSizeColumnPlus(sheet,x.getColumnIndex());
        }

        for (LangExcelDTO langExcelDTO : langExcelDTOS) {
            Row bodyRow = sheet.createRow(rowIndex++);
            createCellWithStyleInt(bodyRow, LANG_ID.getColumnIndex(), langExcelDTO.getId(), bodyCellStyle);
            createCellWithStyle(bodyRow, LANG_DATE.getColumnIndex(), langExcelDTO.getDateStr(), bodyCellStyle);
            createCellWithStyle(bodyRow, LANG_AGE_GROUP.getColumnIndex(), langExcelDTO.getAgeGroupStr(), bodyCellStyle);
            sheet.autoSizeColumn(LANG_DATE.getColumnIndex());
            sheet.autoSizeColumn(LANG_AGE_GROUP.getColumnIndex());
            System.out.println("langExcelDTO.getReplyList() size : " + langExcelDTO.getReplyList().size());
            createCellWithStyleInt(bodyRow, LANG_ANSWER1.getColumnIndex(), langExcelDTO.getReplyList().get(0), bodyCellStyle);
            createCellWithStyleInt(bodyRow, LANG_ANSWER2.getColumnIndex(), langExcelDTO.getReplyList().get(1), bodyCellStyle);
            createCellWithStyleInt(bodyRow, LANG_ANSWER3.getColumnIndex(), langExcelDTO.getReplyList().get(2), bodyCellStyle);
            createCellWithStyleInt(bodyRow, LANG_ANSWER4.getColumnIndex(), langExcelDTO.getReplyList().get(3), bodyCellStyle);
            createCellWithStyleInt(bodyRow, LANG_ANSWER5.getColumnIndex(), langExcelDTO.getReplyList().get(4), bodyCellStyle);
        }
    }

    /*Sdq Data Export*/
    public void addSdqData(ArrayList<SdqExcelDTO> sdqExcelDTOS){
        sheet.createRow(rowIndex++);
        sheet.createRow(rowIndex++);

        Row titleRow = sheet.createRow(rowIndex);
        titleRow.setHeight((short)1000);
        Cell titleCell = titleRow.createCell(0);
        sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 0,SdqColumnInfo.getAllColumns().size()-1));
        titleCell.setCellValue("정서/행동 발달 평가");
        titleCell.setCellStyle(defaultCellStyle);
        rowIndex++;

        Row headerRow = sheet.createRow(rowIndex++);

        for(SdqColumnInfo x : SdqColumnInfo.getAllColumns()){
            createCellWithStyle(headerRow,x.getColumnIndex(),x.getColumnText(),headerCellStyle);
            setAutoSizeColumnPlus(sheet,x.getColumnIndex());
        }

        for (SdqExcelDTO sdqExcelDTO : sdqExcelDTOS) {
            Row bodyRow = sheet.createRow(rowIndex++);
            createCellWithStyleInt(bodyRow, SDQ_ID.getColumnIndex(), sdqExcelDTO.getId(), bodyCellStyle);
            createCellWithStyle(bodyRow, SDQ_TARGET.getColumnIndex(), sdqExcelDTO.getTarget(), bodyCellStyle);
            createCellWithStyle(bodyRow, SDQ_DATETIME.getColumnIndex(), sdqExcelDTO.getDateStr(), bodyCellStyle);
            sheet.autoSizeColumn(SDQ_DATETIME.getColumnIndex());
            createCellWithStyleInt(bodyRow, SDQ_ANSWER1.getColumnIndex(), sdqExcelDTO.getReplyList().get(0), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER2.getColumnIndex(), sdqExcelDTO.getReplyList().get(1), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER3.getColumnIndex(), sdqExcelDTO.getReplyList().get(2), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER4.getColumnIndex(), sdqExcelDTO.getReplyList().get(3), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER5.getColumnIndex(), sdqExcelDTO.getReplyList().get(4), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER6.getColumnIndex(), sdqExcelDTO.getReplyList().get(5), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER7.getColumnIndex(), sdqExcelDTO.getReplyList().get(6), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER8.getColumnIndex(), sdqExcelDTO.getReplyList().get(7), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER9.getColumnIndex(), sdqExcelDTO.getReplyList().get(8), bodyCellStyle);
            createCellWithStyleInt(bodyRow, SDQ_ANSWER10.getColumnIndex(), sdqExcelDTO.getReplyList().get(9), bodyCellStyle);

            ArrayList<SdqResultOfType> scoreList = sdqExcelDTO.getScoreList();

            /*match sdq result and type column*/
            for (SdqResultOfType sdqResultOfType : scoreList) {
                String typeName = sdqResultOfType.getSdqType();
                int columnIndex = SdqColumnInfo.findByColumnText(typeName).getColumnIndex();

                createCellWithStyleInt(bodyRow, columnIndex, sdqResultOfType.getResult(), bodyCellStyle);
                sheet.autoSizeColumn(columnIndex);

            }

        }

    }

    /*Esm Data Export*/
    public void addEsmData(ArrayList<EsmExcelDTO> esmExcelDTOS){
        sheet.createRow(rowIndex++);
        sheet.createRow(rowIndex++);
        
        Row titleRow = sheet.createRow(rowIndex);
        titleRow.setHeight((short)1000);
        Cell titleCell = titleRow.createCell(0);
        sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 0,EsmColumnInfo.getAllColumns().size()-1));
        titleCell.setCellValue("정서 반복 기록");
        titleCell.setCellStyle(defaultCellStyle);
        rowIndex++;

        Row headerRow = sheet.createRow(rowIndex++);

        for(EsmColumnInfo x : EsmColumnInfo.getAllColumns()){
            createCellWithStyle(headerRow,x.getColumnIndex(),x.getColumnText(),headerCellStyle);
            setAutoSizeColumnPlus(sheet,x.getColumnIndex());
        }

        for (EsmExcelDTO esmExcelDTO : esmExcelDTOS) {
            Row bodyRow = sheet.createRow(rowIndex++);
            createCellWithStyleInt(bodyRow, ESM_ID.getColumnIndex(), esmExcelDTO.getId(), bodyCellStyle);
            createCellWithStyle(bodyRow, ESM_DATETIME.getColumnIndex(), esmExcelDTO.getDateStr(), bodyCellStyle);
            sheet.autoSizeColumn(ESM_DATETIME.getColumnIndex());
            createCellWithStyleInt(bodyRow, ESM_ANSWER1.getColumnIndex(), esmExcelDTO.getReplyList().get(0), bodyCellStyle);
            createCellWithStyleInt(bodyRow, ESM_ANSWER2.getColumnIndex(), esmExcelDTO.getReplyList().get(1), bodyCellStyle);
            createCellWithStyleInt(bodyRow, ESM_ANSWER3.getColumnIndex(), esmExcelDTO.getReplyList().get(2), bodyCellStyle);
            createCellWithStyleInt(bodyRow, ESM_ANSWER4.getColumnIndex(), esmExcelDTO.getReplyList().get(3), bodyCellStyle);
            createCellWithStyleInt(bodyRow, ESM_ANSWER5.getColumnIndex(), esmExcelDTO.getReplyList().get(4), bodyCellStyle);
            createCellWithStyleInt(bodyRow, ESM_ANSWER6.getColumnIndex(), esmExcelDTO.getReplyList().get(5), bodyCellStyle);
            createCellWithStyleInt(bodyRow, ESM_ANSWER7.getColumnIndex(), esmExcelDTO.getReplyList().get(6), bodyCellStyle);
            createCellWithStyleInt(bodyRow, ESM_ANSWER8.getColumnIndex(), esmExcelDTO.getReplyList().get(7), bodyCellStyle);
            createCellWithStyleInt(bodyRow, ESM_ANSWER9.getColumnIndex(), esmExcelDTO.getReplyList().get(8), bodyCellStyle);
            createCellWithStyleInt(bodyRow, ESM_ANSWER10.getColumnIndex(), esmExcelDTO.getReplyList().get(9), bodyCellStyle);

            ArrayList<EsmResultOfType> scoreList = esmExcelDTO.getScoreList();

            /*match sdq result and type column*/
            for (EsmResultOfType esmResultOfType : scoreList) {
                String typeName = esmResultOfType.getEsmType();
                int columnIndex = EsmColumnInfo.findColumnByEsmType(typeName).getColumnIndex();

                createCellWithStyleInt(bodyRow, columnIndex, esmResultOfType.getResult(), bodyCellStyle);
            }

        }
    }

    /*ESM Record Data Export*/
    public void addEsmRecordData(ArrayList<EsmRecordExcelDTO> esmRecordExcelDTOS){
        sheet.createRow(rowIndex++);
        sheet.createRow(rowIndex++);
        
        Row titleRow = sheet.createRow(rowIndex);
        titleRow.setHeight((short)1000);
        Cell titleCell = titleRow.createCell(0);
        sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 0,EsmRecordColumnInfo.getAllColumns().size()-1));
        titleCell.setCellValue("정서 다이어리");
        titleCell.setCellStyle(defaultCellStyle);
        rowIndex++;

        Row headerRow = sheet.createRow(rowIndex++);

        for(EsmRecordColumnInfo x : EsmRecordColumnInfo.getAllColumns()){
            createCellWithStyle(headerRow,x.getColumnIndex(),x.getColumnText(),headerCellStyle);
            setAutoSizeColumnPlus(sheet,x.getColumnIndex());
        }

        for (EsmRecordExcelDTO esmRecordExcelDTO : esmRecordExcelDTOS) {
            Row bodyRow = sheet.createRow(rowIndex++);
            createCellWithStyleInt(bodyRow, ESM_RECORD_ID.getColumnIndex(), esmRecordExcelDTO.getId(), bodyCellStyle);
            createCellWithStyle(bodyRow, ESM_RECORD_DATETIME.getColumnIndex(), esmRecordExcelDTO.getDateStr(), bodyCellStyle);
            sheet.autoSizeColumn(ESM_RECORD_DATETIME.getColumnIndex());
            createCellWithStyle(bodyRow, ESM_RECORD_TEXT.getColumnIndex(), esmRecordExcelDTO.getText(), bodyCellStyle);
        }
    }

    public void setAutoSizeColumnPlus(Sheet sheet, int columnIndex){
        sheet.autoSizeColumn(columnIndex);
        sheet.setColumnWidth(columnIndex,sheet.getColumnWidth(columnIndex)+1000);
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



    /*Set Standard Cell Style - defualt, header, body*/
    public void setDefaultCellStyle(){
        defaultCellStyle = wb.createCellStyle();

        Font font = wb.createFont();
        font.setFontHeightInPoints((short) 14);
        font.setBold(true);
        defaultCellStyle.setFont(font);

        // 배경색 지정
        //defaultCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        //defaultCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // 정렬
        defaultCellStyle.setAlignment(HorizontalAlignment.CENTER);
        defaultCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        // 테두리
        //defaultCellStyle.setBorderTop(BorderStyle.THIN);
        //defaultCellStyle.setBorderBottom(BorderStyle.THIN);
        //defaultCellStyle.setBorderLeft(BorderStyle.THIN);
        //defaultCellStyle.setBorderRight(BorderStyle.THIN);
    }
    public void setHeaderCellStyle(){
        headerCellStyle = wb.createCellStyle();

        // 배경색 지정
        headerCellStyle.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
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
        bodyCellStyle = wb.createCellStyle();

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
