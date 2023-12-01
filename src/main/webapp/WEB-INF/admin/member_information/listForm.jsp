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
  <table class="board-table">
                <thead>
                <tr>
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-title">제목</th>
                    <th>작성자</th>
                    <th scope="col" class="th-date">등록일</th>
                    <th>수정/삭제</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="ldto" items="${list }" varStatus="i">
                <tr>
                    <td>${i.count }</td>
                    <td>${ldto.u_id }</td>
                    <td>${ldto.u_name }</td>
                    <td>${ldto.u_email }</td>
                    <td>${ldto.u_pass }</td>
                    <td><fmt:formatDate value="${ldto.u_writedate }" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td><fmt:formatDate value="${ldto.u_final_logindate }" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td align="center">
					<div>
					<jsp:include page="notice_correction.jsp?num=${n_dto.n_num }"/>
					</div>
					<button type="button" num="${ldto.n_num }" onclick="#">수정</button>
					<button type="button" num="${ldto.n_num }" onclick="#">삭제</button>
					<button type="button" onclick="location.href='../heje'">잠금해제</button>
					</td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
            
  
	
</body>
</html>