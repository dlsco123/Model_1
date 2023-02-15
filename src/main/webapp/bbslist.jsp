<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%!
    // 답글의 화살표 함수
    public String arrow(int depth){
    	String img = "<img src = './images/arrow.png' width = '20px' height = '20px' />";
    	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";		// 공백
    	
    	String ts = "";
    	for(int i = 0; i < depth; i++);{
    		ts += nbsp;
    	}
    	return depth==0?"":ts + img;
    }
    %>
    
<%
	MemberDto login = (MemberDto)session.getAttribute("login");
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

<%

// 검색
String choice = request.getParameter("choice");
String search = request.getParameter("search");

if(choice == null){
	choice = "";
}
if(search == null){
	search = "";
}

BbsDao dao = BbsDao.getInstance();



// TODO 페이지NUMBER
String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
	pageNumber = Integer.parseInt(sPageNumber);
}


// List<BbsDto> list = dao.getBbsList();
// List<BbsDto> list = dao.getBbsSearchList(choice, search);
List<BbsDto> list = dao.getBbsPageList(choice, search, pageNumber);

// 글의 총수
int count = dao.getAllBbs(choice, search);

//PAGE의 총 수
int pageBbs = count / 10;		// 10개씩 나눔			26 / 10 -> 2
if((count % 10) > 0){			// 6
	pageBbs++;					// 2 + 1 -> 3
}
	
	
%>

<h1>게시판</h1>

<div align="center">

<table border="1">
<col width="70"><col width="600"><col width="100"><col width="150">
<thead>
<tr>
	<th>번호</th><th>제목</th><th>조회수</th><th>작성자</th>
</tr>
</thead>
<tbody>

<%
if(list == null || list.size() == 0){
%>
	<tr>
		<td colspan="4">작성된 글이 없습니다</td>
	</tr>
		<%
}else{
	
	for(int i = 0;i < list.size(); i++)
	{
		BbsDto dto = list.get(i);
		%>
		<tr>
			<th><%=i + 1 %></th>
			<%
			if(dto.getDel() == 0 ){		// 삭제확인
			%>			
			<td>
				<%=arrow(dto.getDepth()) %>
				<a href="bbsdetail.jsp?seq=<%=dto.getSeq() %>">
				<%=dto.getTitle() %>
				</a>
			</td>
			<%
			}else if(dto.getDel() == 1){
			%>
			<td align="center">
			<%=arrow(dto.getDepth()) %>
				<font color="#f00">이 글은 작성자에 의해 삭제되었습니다</font>
			</td>
			<%
			}
			%>
			
			<td><%=dto.getReadcount() %></td>
<%-- 			<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %></td> --%>
			<td><%=dto.getId() %></td>
		</tr>
<%
	}
}
%>

</tbody>
</table>

<br>

<%	// TODO 페이지 처리
	for(int i = 0; i < pageBbs; i++){
		if(pageNumber == i){		// 현재 페이지인 경우
%>			
		<span style="font-size: 15pt; color: #00f; font-size: bold;">
		<%= i + 1 %>
		</span>
			<%
		}else{						// 다른 페이지인 경우
			%>
			<a href = "#none" title= "<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
				style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none;">
				[<%=i+1 %>]
			</a>
 			
<%	
		}
		
	}

%>





<br><br>

<select id="choice">
	<option value="">검색</option>
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="writer">작성자</option>
</select>

<input type="text" id="search" value="<%=search%>">

<button type="button" onclick="searchBtn()">검색</button>

<br><br>
<a href="bbswrite.jsp">글쓰기</a>

</div>

<script type="text/javascript">
// 페이징error 잡기
let search = "<%=search %>";		// 자바용 변수
console.log("search = " + search);
if (search != "") {
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");
}



function searchBtn() {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	/* if(choice == ""){
		alert("카테고리를 선택해 주십시오");
		return;
	} */
	/* 
	if(search.trim() == ""){
		alert("검색어를 선택해 주십시오");
		return;
	} */
	
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search;
}

function goPage( pageNumber ) {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNumber;
}
</script>


</body>
</html>



