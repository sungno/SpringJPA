<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** BoardList **</title>
<link rel="stylesheet" type="text/css" href="resources/jqLib/myStyle.css">
<script src="resources/jqLib/jquery-3.2.1.min.js"></script>
<script>
$(function() {
	$('#searchBtn').on("click", function(){
			self.location="cblist"
					+"${pageMaker.makeQuery(1)}"
					+"&searchType="
					+$('#searchType').val()
					+"&keyword="
					+$('#keyword').val();
	}); // click
	
}); // ready
</script>
</head>
<body>
<h2>** Spring Mybatis BoardList Criteria **</h2>
<img  src="resources/image/bar.gif"><br>
<div id="searchBar">
	<select name="searchType" id="searchType" >
		<option value="n" <c:out value="${pageMaker.cri.searchType==null ? 'selected' : '' }" />>
		---</option>
		<option value="t" <c:out value="${pageMaker.cri.searchType eq 't' ? 'selected' : '' }" />>
		Title</option>
		<option value="c" <c:out value="${pageMaker.cri.searchType eq 'c' ? 'selected' : '' }" />>
		Content</option>
		<option value="w" <c:out value="${pageMaker.cri.searchType eq 'w' ? 'selected' : '' }" />>
		Writer</option>
		<option value="tc" <c:out value="${pageMaker.cri.searchType eq 'tc' ? 'selected' : '' }" />>
		Title or Content</option>
		<option value="cw" <c:out value="${pageMaker.cri.searchType eq 'cw' ? 'selected' : '' }" />>
		Content or Writer</option>
		<option value="tcw" <c:out value="${pageMaker.cri.searchType eq 'tcw' ? 'selected' : '' }" />>
		Title or Content or Writer</option>
	</select>
	<input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
	<button id="searchBtn" >Search</button>
</div>
<c:if test="${message != null}">
 => ${message}<br>
</c:if>
<table width=800 border="0">
<tr align="center" height=30 bgcolor="springgreen">
	<td>Seq</td><td>Title</td><td>ID</td>
	<td>RegDate</td><td>Count</td>
</tr>
<c:forEach var="mm" items="${banana}">
	<tr align="center" height=30>
	<td>${mm.seq}</td>
	<td align="left">
		<!-- indent 값에 따른 들여쓰기 -->
		<c:if test="${mm.indent>0}">
			<c:forEach begin="1" end="${mm.indent}">
				<span>&nbsp;&nbsp;</span>
			</c:forEach>
			<span style="color:orange">re..</span>
		</c:if>
		<!-- title 출력 -->
		<c:if test="${logID!=null}">
			<a href="bdetail?seq=${mm.seq}&id=${mm.id}">${mm.title}</a>
		</c:if>
		<c:if test="${logID==null}">
			${mm.title}
		</c:if>
	</td>
	<td>${mm.id}</td>
	<td>${mm.regdate}</td><td>${mm.cnt}</td>
	</tr>
</c:forEach>
</table>
<hr>
<!--	     	
  ** Page Criteria 추가   
    1) First << ,  Prev < : enabled 여부
    2) sPage~ePage 까지 perPageNo 값 만큼 출력, 
    3) Next >  ,   Last >> : enabled 여부	
-->
<div align="center">
<hr>
<!-- 1) First << ,  Prev < : enabled 여부 -->
<c:if test="${pageMaker.prev && pageMaker.sPageNo>1}">
	<a href="cblist${pageMaker.makeQuery(1)}" >First</a>&nbsp;
	<a href="cblist${pageMaker.makeQuery(pageMaker.sPageNo-1)}">&lt;</a>&nbsp;
</c:if>
<!-- 2) sPage~ePage 까지 perPageNo 값 만큼 출력  -->
<c:forEach var="i" begin="${pageMaker.sPageNo}" end="${pageMaker.ePageNo}">
	<c:if test="${i==pageMaker.cri.currPage}">
		<font size="5" color="Orange">${i}&nbsp;</font>
	</c:if>
	<c:if test="${i!=pageMaker.cri.currPage}">
		<a href="cblist${pageMaker.makeQuery(i)}">${i}</a>&nbsp;	
	</c:if>
	
	<%-- 삼항식 사용예 (비교해 보세요) 
	<c:out value="${pageMaker.cri.currPage==i ? 'class=active' : ''}" /> 
	--%>
</c:forEach>

<!-- 3) Next >  ,   Last >> : enabled 여부 -->
<c:if test="${pageMaker.next && pageMaker.ePageNo > 0}">
	<a href="cblist${pageMaker.makeQuery(pageMaker.ePageNo+1)}">&gt;</a>&nbsp;	
	<a href="cblist${pageMaker.makeQuery(pageMaker.lastPageNo)}">Last</a> 
</c:if>
</div>
<hr>
<c:if test="${logID!=null}">
	<a href="binsertf">[새글등록]</a>&nbsp;
</c:if>
<c:if test="${logID==null}">
	<a href="loginf">[LogIn]</a>&nbsp;&nbsp;
	<a href="joinf">[Join]</a><br>
</c:if>
<a href="home">[Home]</a><br>
</body>
</html>