package seoJspWeb.board;

import java.io.File;
import java.util.*;

public class UtilMgr {
	public static String replace(String str, String pattern, String replace) {
		int s = 0, e = 0;
		StringBuffer result = new StringBuffer();

		while ((e = str.indexOf(pattern, s)) >= 0) {
			result.append(str.substring(s,e));
			result.append(replace);
			s = e + pattern.length();
		}
		result.append(str.substring(s));
		return result.toString();
	}
	
	public static String con(String s) {
		String str = null;
		try {
			str = new String(s.getBytes("UTF-8"),"8859_1");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	public static void delete(String s) {
		File file = new File(s);
		if(file.isFile()) {
			file.delete();
		}
		
	}
}
