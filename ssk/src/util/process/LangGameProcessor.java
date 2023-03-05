package util.process;

import javax.servlet.RequestDispatcher;

public class LangGameProcessor {
	public static String changeNameOfLangGameContent(String langGameContent,String userName) {
		String res = langGameContent;
		char lastName = userName.charAt(userName.length() - 1);
		int index = (lastName - 0xAC00) % 28;
		String addName = userName.substring(1,userName.length());
		
		while(res.contains("00")) {
			if(res.charAt(res.indexOf("00")+2)=='아') {
				res = index>0?res.replace("00아", addName+"아"):res.replace("00아", addName+"야");
			}else if(res.charAt(res.indexOf("00")+2)=='이') {
				res = index>0?res.replace("00이", addName+"이"):res.replace("00이", addName);
			}else {
				res = res.replace("00", addName);
			}
		}
		return res;
	}
	
	/*예외 문항 처리 - langGameLocation 지정 함수 - langGameId는 실제 DB에 저장된 langGameId의 -1한 값*/
	public static String getForwardLocationByLangQuestionIdAndLangGameId(int langQuestionId, int langGameId){
		String location = "/langGame.jsp";

		if(langQuestionId == 7 && langGameId == 1) {
			location = "/langGame07_2.jsp";
		} else if(langQuestionId == 47 && langGameId == 0) {
			location = "/langGame47.jsp";
		}else if(langQuestionId == 29 &&langGameId == 3){
			location = "/langGame29_4.jsp";
		}else if(langQuestionId == 46 && (langGameId == 2||langGameId == 3||langGameId == 4)){
			location = "/langGame46_3to5.jsp";
		}else if(langQuestionId==51 && langGameId == 0){
			location = "/langGame51.jsp";
		}
		else if(langQuestionId == 52 && langGameId == 0) {
			location = "/langGame52.jsp";
		}
		else if(langQuestionId == 53 && langGameId == 0) {
			location = "/langGame53.jsp";
		}
		else if(langQuestionId == 54 && langGameId == 0) {
			location = "/langGame54.jsp";
		}
		else if((langQuestionId == 56 && langGameId == 6) || (langQuestionId == 57 && langGameId == 6)) {
			location = "/langGame56_7.jsp";
		}
		else if(langQuestionId == 64 && (langGameId == 2||langGameId == 3)) {
			location = "/langGame64_3_4.jsp";
		}
		return location;
	}
}