package model.dto.export.column;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public enum LangColumnInfoOfUser implements ExcelColumnInfo{
    LANG_ID("NO.", 0),
    LANG_DATE("검사 실시 날짜",1),
    LANG_AGE_GROUP("검사 연령",2),
    LANG_ANSWER1("문항1", 3),
    LANG_ANSWER2("문항2", 4),
    LANG_ANSWER3("문항3", 5),
    LANG_ANSWER4("문항4", 6),
    LANG_ANSWER5("문항5", 7);

    private final String columnText;
    private final int columnIndex;

    LangColumnInfoOfUser(String columnText, int columnIndex){
        this.columnText = columnText;
        this.columnIndex = columnIndex;
    }
    public static List<LangColumnInfoOfUser> getAllColumns() {
        return Arrays.stream(values()).collect(Collectors.toList());
    }
    @Override
    public String getColumnText() {
        return columnText;
    }

    @Override
    public int getColumnIndex() {
        return columnIndex;
    }
}
