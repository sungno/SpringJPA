<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	
	<title>Home</title>
	<script src="resources/jqLib/jquery-3.2.1.min.js"></script>
	<script src="resources/jqLib/axTest01.js"></script>
	<script src="resources/jqLib/axTest02.js"></script>
	<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
	<link rel="stylesheet" type="text/css" href="resources/jqLib/myStyle.css" >
	<script>
		function setClock(){
			var now = new Date();
			var t = '* Current Time :'+
				now.getFullYear()+'년 '+(now.getMonth()+1)+'월 '+now.getDate()+'일 '+now.getHours()+':'+now.getMinutes()+':'+now.getSeconds();
			document.getElementById('clock').innerHTML = t;
			setTimeout('setClock()',1000); // 단위 1/1000초
			//setInterval('setClock()',1000); // 단위 1/1000초
			//위 둘은 다른 매서드 이지만 function에 적용했을떄 동일한 결과
		}
			
	</script>
</head>
<body onload="setClock()">
<h1>Hello Spring Mybatis!!!!</h1> 

<span>  * Server Start Time : ${serverTime} </span><br>
<span id="clock"></span><br>
<c:if test="${message != null}">
	=> ${message}<br>
</c:if>


<img src="resources/image/twitter_header_photo_1.png" >
<hr>





<a href="blist">BoardList</a>&nbsp;&nbsp;
<a href="bcheck">BoardCheckBoxList</a><br>



</body>
</html>
