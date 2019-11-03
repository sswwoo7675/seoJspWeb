<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="seoJspWeb.poll.PollMgr" />
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String[] itemnum = request.getParameterValues("itemnum");
	boolean flag = pMgr.updatePoll(num, itemnum);
	String msg = "투표에 실패하였습니다.";
	if(flag){
		msg = "투표가 완료되었습니다.";
	}
%>
<script>
   alert("<%=msg%>");
   location.href="pollList.jsp?num=<%=num%>";
</script>