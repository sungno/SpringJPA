<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<title>** BoardList **</title>
</head>
<body>
	<h2>** Spring MVC2 BoardList(Paging) **</h2>
	<img src="resources/image/aaa.gif" width="600" height="500"><br>
	<c:if test="${message != null}">
 	=> ${message}
	</c:if>
	<table width=800>
		<tr align="center" height="30" bgcolor="aqua">
			<td>SEQ</td>
			<td>Title</td>
			<td>I D</td>
			<td>RegDate</td>
			<td>CNT</td>
		</tr>

		<c:forEach var="mm" items="${banana}">
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
				</c:if> <c:if test="${logID == null}">
					${mm.title}
			</c:if></td>
				<td>${mm.id}</td>
				<td>${mm.regdate}</td>
				<td>${mm.cnt}</td>
			</tr>
		</c:forEach>
	</table>
	<hr>
	<!-- ** Paging 추가 -->
	<div align="center">
		<%-- ** paging1
		<c:forEach var="i" begin="1" end="${totPageNo}"> 
		--%>
		<!-- ** pageing2  -->
		<c:choose>
			<c:when test="${sPageNo>perPageNo}">
				<a href="pblist?currPage=1"><i class="fas fa-angle-double-left"></i></a>&nbsp;
				<a href="pblist?currPage=${sPageNo-1}"><i class="fas fa-angle-left"></i></a>&nbsp;&nbsp;
			</c:when>
			<c:otherwise>
				<font color="gray"><i class="fas fa-angle-double-left"></i>&nbsp;<i class="fas fa-angle-left"></i>&nbsp;&nbsp;&nbsp;&nbsp;</font>
			</c:otherwise>
		</c:choose>		
		
		<c:forEach var="i" begin="${sPageNo}" end="${ePageNo}">
			<c:if test="${currPage == i }">
				<font size="5" color="blue" >${i}&nbsp;</font>	
			</c:if>
			<c:if test="${currPage != i }">
				<a href="pblist?currPage=${i}">${i}</a>
			</c:if>
		</c:forEach>
		
		<c:choose>
			<c:when test="${ePageNo<totPageNo}">&nbsp;&nbsp;
				<a href="pblist?currPage=${ePageNo+1}"><i class="fas fa-angle-right"></i></a>&nbsp;
				<a href="pblist?currPage=${totPageNo}"><i class="fas fa-angle-double-right"></i></a>
			</c:when>
			<c:otherwise>
				<font color="gray">&nbsp;&nbsp;<i class="fas fa-angle-right"></i>&nbsp;<i class="fas fa-angle-double-right"></i></font>
			</c:otherwise>
		</c:choose>
	</div>
	
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