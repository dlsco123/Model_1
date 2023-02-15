<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    int seq = Integer.parseInt( request.getParameter("seq"));
	MemberDto login = (MemberDto)session.getAttribute("login");
	BbsDao dao = BbsDao.getInstance();
 	BbsDto dto = dao.getBbs(seq);
	boolean isS = dao.deleteBbs(seq);
	if(isS){
%>
		<script>
		alert("삭제되었습니다");
		location.href = "bbslist.jsp";		
		</script>
		<%
	}else{
	 	%>
	 	<script>
		alert("삭제실패");
		let seq = "<%=seq%>";
		location.href = "bbsdetail.jsp?seq=" + seq;		
		</script>
<%
	 }
 %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>