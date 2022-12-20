package util.lang;

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
}
