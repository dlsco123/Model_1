<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    int seq = Integer.parseInt(request.getParameter("seq"));
	MemberDto login = (MemberDto)session.getAttribute("login");
	BbsDao dao = BbsDao.getInstance();
	
	dao.readcount(seq);			// 조회수 증가
	
 	BbsDto dto = dao.getBbs(seq);
	
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
	<h1>상세 글보기</h1>
	<table border="1">
		<col width="200px"><col width="200px">
		<tr>
			<th>작성자</th>
			<td><%=dto.getId() %></td>			
		</tr>
		
		<tr>
			<th>제목</th>
			<td><%=dto.getTitle()%></td>			
		</tr>
		
		<tr>
			<th>작성일</th>
			<td><%=dto.getWdate()%></td>			
		</tr>
		
		<tr>
			<th>조회수</th>
			<td><%=dto.getReadcount()%></td>			
		</tr>
		
		<tr>
			<th>정보</th>
			<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %> </td>			
		</tr>
		
		
		<tr style="height: 70px">
			<th>내용</th>
			<td>
				<textarea rows="15" cols="90"><%=dto.getContent() %></textarea>		
			</td>			
		</tr>
	</table>
	<br>
	<button type="button" onclick="answerBbs(<%=dto.getSeq() %>)">답글</button>	
	<button type="button" onclick="location.href='bbslist.jsp'">글목록</button>
	
	
	
	<!-- 작성자만 볼 수 있음 -->
	<%
	if(login.getId().equals(dto.getId())){
	%>
	<button type="button" onclick="updateBbs(<%=dto.getSeq() %>)" id="">수정</button>
	<button type="button" onclick="deleteBbs(<%=dto.getSeq() %>)" id="">삭제</button>	
		<%
	}
		%>
	</div>
	<script type="text/javascript">
		function answerBbs(seq) {
			location.href = "answer.jsp?seq=" + seq;
		}
		function updateBbs(seq) {
			location.href = "updateBbs.jsp?seq=" + seq;		// af존재
		}
		function deleteBbs(seq) {
			location.href = "deleteBbs.jsp?seq=" + seq;		//update명령으로 지워야함
		}
		
		// readcount증가
	</script>
	</body>
</html>
