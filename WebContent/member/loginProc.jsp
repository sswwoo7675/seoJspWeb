<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="seoJspWeb.member.MemberMgr"/>
<%
	request.setCharacterEncoding("utf-8");
	String cPath = request.getContextPath();
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String url = cPath+"/left.jsp";
	String msg = "로그인에 실패 하였습니다.";
	
	boolean result = mMgr.loginMember(id, pwd);
	
	if (result){
		session.setAttribute("idKey", id);
		msg = "로그인에 성공 하였습니다.";
	}
%>
<script>
	alert("<%=msg%>");
	top.document.location.reload();
	location.href="<%=url%>";
</script>