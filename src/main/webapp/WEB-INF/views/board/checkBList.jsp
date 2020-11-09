<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** BoardList **</title>
</head>
<body>
	<h2>** Spring MVC2 BoardList(조회수증가  & 답글) **</h2>
	<img src="resources/image/jerry01.gif" width="200" height="100"><br>
	<c:if test="${message != null}">
 	=> ${message}
	</c:if>
	
	
	<div id="searchBar">
	<form action="bcheck" method="get">
		<b>ID :</b>&nbsp; 
		<input type="checkbox" name=check value="green">green&nbsp;
		<input type="checkbox" name=check value="blue">blue&nbsp;
		<input type="checkbox" name=check value="banana">banana&nbsp; 
		<input type="checkbox" name=check value="cu5014">cu5014&nbsp;&nbsp;
		<input type="submit" value="검색"> 
		<input type="reset" value="취소">
	</form>
	</div>
	
	<table width=800>
		<tr align="center" height="30" bgcolor="aqua">
			<td>SEQ</td>
			<td>Title</td>
			<td>I D</td>
			<td>RegDate</td>
			<td>CNT</td>
		</tr>

		<c:forEach var="mm" items="${Banana}">
			<tr align="center" height=30>
				<td>${mm.seq}</td>
				<td align="left">
				
				<!-- indent 값에 따른 들여쓰기 -->
				<c:if test="${mm.indent>0}">
					<c:forEach begin="1" end="${mm.indent}" >
						<span>&nbsp;&nbsp;</span>
					</c:forEach>
					<span style="color:orange">↳</span>
				</c:if>	
				
				<!-- title 출력 -->
				<c:if test="${logID != null }">
						<a href="bdetail?seq=${mm.seq}&id=${mm.id}">${mm.title}</a>
				</c:if> 
				<c:if test="${logID == null}">
					${mm.title}
				</c:if></td>
				<td>${mm.id}</td>
				<td>${mm.regdate}</td>
				<td>${mm.cnt}</td>
			</tr>
		</c:forEach>
	</table>
	<hr>
	
	
	<c:if test="${logID!=null}">
		
		<a href="binsertf">[새글등록]</a>&nbsp;
	</c:if>
	
	<c:if test="${logID==null}">
		<a href="loginf">[LogIn]</a>&nbsp;&nbsp;
		<a href="joinf">[Join]</a>
		<br>
	</c:if>
	
		<a href="home">[Home]</a>
	<br>
</body>
</html>