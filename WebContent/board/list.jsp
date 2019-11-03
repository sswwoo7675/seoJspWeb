<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="seoJspWeb.board.BoardBean"%>
<%@ page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="seoJspWeb.board.BoardMgr"/>
<%
	request.setCharacterEncoding("utf-8");	

	int totalRecord = 0; //전체 레코드 수
	int numPerPage = 10; //페이지당 레코드 수(상수)
	int pagePerBlock = 15; //블럭 당 페이지 수(상수)
	
	int totalPage = 0; //전체 페이지 수
	int totalBlock = 0; //전체 블럭 수
	
	int nowPage = 1; //현재페이지
	int nowBlock = 1; //현재 블럭
	
	int start = 0; //db의 select 시작번호
	int end = 10; //시작번호로부터 가져올 select 갯수
	
	int listSize = 0; //현재 읽어온 게시물의 수
	
	String keyWord = "", keyField = "";
	Vector<BoardBean> vlist = null;
	
	if(request.getParameter("keyWord") != null){
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	
	if(request.getParameter("reload")!=null){
		if(request.getParameter("reload").equals("true")){
			keyWord = "";
			keyField = "";
		}	
	}
	
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	start = (nowPage * numPerPage) - numPerPage;
	end = numPerPage;
	
	totalRecord = bMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage); //전체 페이지 수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재 블럭 계산
	
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);//전체 블럭 계산
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서지우 게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list(){
	    document.listFrm.action = "list.jsp";
	    document.listFrm.submit();
	}
	
	function pageing(page){
	    document.readFrm.nowPage.value = page;
	    document.readFrm.submit();
	}
	
	function block(value){
	    document.readFrm.nowPage.value = <%=pagePerBlock%>*(value-1)+1;
	    document.readFrm.submit();
	}
	
	function read(num){
	    document.readFrm.num.value=num;
	    document.readFrm.action="read.jsp";
	    document.readFrm.submit();
	}
	
	function check(){
	    if (document.searchFrm.keyWord.value==""){
	        alert("검색어를 입력하세요.");
	        document.searchFrm.keyWord.focus();
	        return;
	    }
	    document.searchFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br/>
		<h2>서지우 게시판</h2>
		<br/>
		<table align="center" width="700">
			<tr>
				<td>
					Total : <%=totalRecord%>Articles(
					<font color="red"><%=nowPage%>/<%=totalPage%>Pages</font> )
				</td>
			</tr>
		</table>
		<table align="center" width="700" cellpadding="3">
			<tr>
				<td align="center" colspan="2">
<%
	vlist = bMgr.getBoardList(keyField, keyWord, start, end);
	listSize = vlist.size();
	if(vlist.isEmpty()){
		out.println("등록된 게시물이 없습니다.");
	} else {
%>
					<table width="100%" cellpadding="2" cellspacing="0">
						<tr align="center" bgcolor="#D0D0D0" height="120%">
							<td>번 호</td>
							<td>제 목</td>
							<td>이 름</td>
							<td>날 짜</td>
							<td>조회수</td>
						</tr>
<%
		for(int i = 0; i<numPerPage; i++){
			if (i==listSize) break;
			BoardBean bean = vlist.get(i);
			int num = bean.getNum();
			String name = bean.getName();
			String subject = bean.getSubject();
			String regdate = bean.getRegdate();
			int depth = bean.getDepth();
			int count = bean.getCount();
%>
						<tr>
							<td align = "center">
								<%=totalRecord-((nowPage-1)*numPerPage)-i%>
							</td>
							<td>
<%
			if (depth>0){
				for(int j=0;j<depth;j++){
					out.println("&nbsp;&nbsp;");
				}
			}
%>
								<a href="javascript:read('<%=num%>')"><%=subject%></a>
							</td>
							<td align="center"><%=name%></td>
							<td align="center"><%=regdate%></td>
							<td align="center"><%=count%></td>
						</tr>
<%
		}
%>
					</table>
<%
	}
%>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br/><br/></td>
			</tr>
			<tr>
				<td>
<%
	int pageStart = (nowBlock-1)*pagePerBlock + 1; //하단 페이지 시작번호
	int pageEnd = ((pageStart + pagePerBlock)<=totalPage) ? (pageStart + pagePerBlock) : totalPage + 1;
	
	if(totalPage!=0){
		if (nowBlock>1){
%>
					<a href="javascript:block('<%=nowBlock-1%>')">prev...</a>
<%
		}
%>
					&nbsp;
<%
		for(;pageStart<pageEnd;pageStart++){
%>
					<a href="javascript:pageing('<%=pageStart %>')">
<%
			if(pageStart==nowPage){
%>
						<font color="blue">[<%=pageStart%>]</font>
<%
			} else {
%>	
						[<%=pageStart%>]				
<%
			}
%>
					</a>
<%
		}
%>
					&nbsp;
<%
		if(totalBlock>nowBlock){
%>
					<a href="javascript:block('<%=nowBlock+1%>')">.....next</a>
<%
		}
%>
<%
	}
%>
				</td>
				<td align="right">
					<a href="post.jsp">[글쓰기]</a>
					<a href="javascript:list()">[처음으로]</a>
				</td>
			</tr>
		</table>
		<hr width="700"/>
		<form name="searchFrm" method="get" action="list.jsp">
			<table width="600" cellpadding="4" cellspacing="0">
				<tr>
					<td	align="center" valign="bottom">
						<select name="keyField" size="1">
							<option value="name"> 이 름</option>
							<option value="subject"> 제 목</option>
							<option value="content"> 내 용</option>
						</select>
						<input size="16" name="keyWord">
						<input type="button" value="찾기" onClick="javascript:check()">
						<input type="hidden" name = "nowPage" value="1">
					</td>
				</tr>
			</table>
		</form>
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true">
			<input type="hidden" name = "nowPage" value="1">
		</form>
		<form name="readFrm" method="get">
			<input type="hidden" name="num">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
	</div>
</body>
</html>






















