<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gaegu:wght@300&family=Nanum+Pen+Script&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<style type="text/css">
	.likesangpum{
		display: inline-block;
	}
</style>
</head>
<body>
<h2>관심상품</h2>
	<div id="alllikesangpum">
		<c:forEach var="dto" items="${list }" varStatus="i">
			<div class="likesangpum">
				<img src="../img/${dto.sangimg }" style="width: 130px; height: 130px;">
				<div class="sangpuminfo">
					<b>${dto.j_title }</b>
					<fmt:formatNumber value="${dto.j_price }" type="currency"/>
				</div>
				
			</div>
		</c:forEach>
	</div>
</body>
</html>