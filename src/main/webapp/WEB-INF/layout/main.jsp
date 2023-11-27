<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gamja+Flower&family=Nanum+Pen+Script&family=Noto+Serif+KR:wght@200&display=swap"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
</head>
<body>
	<!-- Section-->
	<section class="py-3">
		<div class="container px-4 px-lg-5 mt-5">
			<!-- 출력방식 설정 -->
			<div class="sort">
				<div class="sort_insert">
					 <a href="/form">
						<button style="color: black" class="write"><img src="../../img/writePost.png" style="width: 20px;">글쓰기</button>
					</a>
				</div>
				<div class="sort_list">
					 <a href="/list">
						<button style="color: black" class="write">모든상품</button>
					</a>
				</div>			
			</div>
			
			<br>
			<div id="cardType" class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">     	
		     	<c:forEach var="dto" items="${list }">
		     	<div class="col mb-5">
		     		<div class="card h-100">
		                <img class="card-img-top" src="../img/${dto.j_imageurl }" alt="..." /> 
		                <div class="card-body p-4">
			            	<div class="text-center">
			            		<h5 class="fw-bolder">${dto.j_title}</h5>
			            		<fmt:formatNumber value="${dto.j_price}" type="currency"/>
							</div>
						</div>
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">	
								<a class="btn btn-outline-dark mt-auto" href="/sangpum/detail">View
									options</a>
							</div>
						</div>
					</div>
				</div>			
		     	</c:forEach>
	     	</div>
     		<br><br><br>
			<div class="kakao_inquiry">
				<div id="kakao-talk-channel-add-button"
					data-channel-public-id="_BpxgxjG" data-size="large"
					data-support-multiple-densities="true">
				</div>
				<div id="kakao-talk-channel-chat-button"
					data-channel-public-id="_BpxgxjG" data-title="question"
					data-size="large" data-color="yellow" data-shape="mobile"
					data-support-multiple-densities="true">
				</div>
			</div>
		</div>
	</section>
</body>
<script>
  window.kakaoAsyncInit = function() {
    Kakao.Channel.createChatButton({
      container: '#kakao-talk-channel-chat-button',
    });
    Kakao.Channel.createAddChannelButton({
      container: '#kakao-talk-channel-add-button',
    });
  };  
</script>
</html>