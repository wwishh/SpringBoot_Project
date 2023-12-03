<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gaegu:wght@300&family=Nanum+Pen+Script&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<style type="text/css">
	#backgrounddiv{
		padding-top: 6%;
		padding-bottom: 9%;
	}
	#userdiv{
		border: 1px solid lightgray;
		border-radius: 30px;
		width: 800px;
		height: 350px;
		padding: 30px 30px 30px 30px;
		margin: auto;
		display: flex;
		align-items: center;
	}
	#usericon{
		display: inline-block;
		width: auto;
		height: auto;
	}
	#userinfo{
		display: inline-block;
		width: auto;
		height: auto;
	}
	
	#allsangpum {
	    display: flex;
	    flex-wrap: wrap;
	    justify-content: space-between;
	    margin-left: 40px;
	}

	#likesangpum,
	#buysangpum,
	#sellsangpum,
	#sellcomplete {
	    width: 50%; /* 필요에 따라 조절하세요. 여유 공간을 위해 마진/패딩을 고려하세요. */
	    margin-bottom: 20px; /* 필요에 따라 조절하세요. */
	    margin-top: 20px;
	    box-sizing: border-box;
	    border: 1px solid lightgray;
		border-radius: 30px;
		padding: 10px 10px 10px 10px;
		text-align: center;
	}
	
	#userdetail{
		display: inline-block;
		width: auto;
		height: auto;
		margin-left: 7%;
	}

</style>
</head>
<body>
<div id="backgrounddiv">
	<h3 style="width: 800px; margin: auto;"><b style="color: #4C4C4C;">My Page</b></h3><br>
	<div id="userdiv">
		<div id="userdetail">
			<div id="usericon">
				<i class="bi bi-person-circle" style="color: #BDBDBD; font-size: 7em;"></i>
			</div>
			<div id="userinfo">
				<b style="font-size: 20pt;">${dto.u_name}</b><br>
				<b style="font-size: 13pt; color: #BDBDBD;">${dto.u_email}</b><br>
				<b style="font-size: 11pt; color: #BDBDBD;">가입일 : <fmt:formatDate value="${dto.u_writerdate}" pattern="yyyy.HH.dd"/></b><br>		
				<button type="button" class="btn btn-outline-success btn-sm" 
				onclick="location.href='../updateform?u_id=${sessionScope.myid}'">회원정보수정</button>
			</div>
		</div>
		
		<div id="allsangpum">
			<div id="likesangpum">
				<b>관심상품</b><br>
				<b style="color: green; cursor: pointer;" onclick="location.href='interest/likesangpum?u_id=${sessionScope.myid}'">${likes }건</b>
			</div>
			
			<div id="buysangpum">
				<b>구매내역</b><br>
				<b style="color: green; cursor: pointer;" onclick="location.href='sangpum/buysangpum?u_id=${sessionScope.myid}'">${purchase }건</b>
			</div>
			
			<br>
			
			<div id="sellsangpum">
				<b>판매중</b><br>
				<b style="color: green; cursor: pointer;" onclick="location.href='sangpum/sellsangpum?u_id=${sessionScope.myid}'">${sell }건</b>
			</div>
			<div id="sellcomplete">
				<b>판매완료</b><br>
				<b style="color: green; cursor: pointer;" onclick="location.href='sangpum/sellcomplete?u_id=${sessionScope.myid}'">${sellcomplete }건</b>
			</div>
		</div>
	</div>
</div>
</body>
</html>