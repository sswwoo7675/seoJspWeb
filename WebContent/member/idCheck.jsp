<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="seoJspWeb.member.MemberMgr"/>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	boolean result = mMgr.checkId(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복체크</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br/>
		<b><%=id%></b>는
<%
	if(result){
		out.println(" 이미 존재하는 ID 입니다.<p/>");
	} else {
		out.println(" 는 사용 가능합니다.<p/>");
	}
%>
		<a href="#" onClick="self.close()">닫기</a>
	</div>
</body>
</html>