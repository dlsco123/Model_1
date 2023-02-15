<%@page import="dto.MemberDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    int seq = Integer.parseInt(request.getParameter("seq"));
	MemberDto login = (MemberDto)session.getAttribute("login");
// 	BbsDao dao = BbsDao.getInstance();
//  BbsDto dto = dao.getBbs(seq);
 	BbsDto dto = BbsDao.getInstance().getBbs(seq);
	
	if(login == null){
%>
		<script>
		alert('로그인 해 주십시오');
		location.href = "login.jsp";
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

<div align="center">
	<h2>글 수정</h2>
	<form action="updateBbsAf.jsp" method="post">
	<input type="hidden" name="seq" value="<%=dto.getSeq() %>">
	<table border="1">
	<col width="200"><col width="500">
	<tr>
		<th>작성자</th>
		<td><%=dto.getId() %></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" size="60" value="<%=dto.getTitle() %> "> </td>
<%-- 		<td><input type="text" name="title" size="60" placeholder="<%=dto.getTitle() %> "> </td> --%>
	</tr>
	<tr>
		<th>작성일</th>
		<td><%=dto.getWdate() %></td>
	</tr>
	<tr>
		<th>조회수</th>
		<td><%=dto.getReadcount() %></td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
			<textarea rows="10" cols="60" name="content"><%=dto.getContent() %>></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
				<input type="submit" value="수정완료">
		</td>
	</tr>	
	</table>
	</form>
</div>

</body>
</html>