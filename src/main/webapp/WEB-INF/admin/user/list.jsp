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
</head>
<body>
	<h3>회원목록</h3>
	<table>
		<tr>
		<th>번호</th><th>이름</th><th>아이디</th><th>이메일</th><th>마지막로그인</th><th>등록일</th>
		</tr>
		<c:forEach var="u_dto" items="${list }" varStatus="i">
                <tr>
                    <td>${i.count }</td>
                    <td>${u_dto.u_name }</td>
                    <%-- <jsp:include page="user_detail.jsp">
						<jsp:param value="${u_dto.u_id }" name="u_id"/>
						<jsp:param value="${u_dto.u_pass }" name="u_pass"/>
					</jsp:include> --%>
                    <td>${u_dto.u_id }</td>
                    <td>${u_dto.u_email }</td>
                    <td><fmt:formatDate value="${u_dto.u_writerdate }" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td><fmt:formatDate value="${u_dto.u_final_logindate }" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td align="center">
					<jsp:include page="user_correction.jsp">
						<jsp:param value="${n_dto.n_num }" name="num"/>
					</jsp:include>
					<button type="button" class="u_del" num="${u_dto.u_id }" >삭제</button>
					</td>
                </tr>
                </c:forEach>
	</table>
</body>
</html>