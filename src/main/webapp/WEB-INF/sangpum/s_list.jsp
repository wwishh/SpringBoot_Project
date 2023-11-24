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
					<!-- <a href="/form">글쓰기</a> -->
					 <a href="/form">
						<button style="color: black" class="write">
						<img src="../../img/writePost.png" style="width: 20px;">글쓰기</button>
					</a>
				</div>			
				<div class="sort_listType">
					<!-- is Selected -->
					<span class="sort_card" onclick="cardShow()" title="카드 형식으로 보기">
						<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="40px" height="40px" viewBox="0 0 92 92" enable-background="new 0 0 92 92" xml:space="preserve">
						<path id="XMLID_79_" d="M34.9,40.7H7.6c-3.1,0-5.6-2.5-5.6-5.6V13.6C2,10.5,4.5,8,7.6,8h27.3c3.1,0,5.6,2.5,5.6,5.6v21.5C40.5,38.2,38,40.7,34.9,40.7z M10,32.7h22.5V16H10V32.7z M84.4,40.7H57.1c-3.1,0-5.6-2.5-5.6-5.6V13.6c0-3.1,2.5-5.6,5.6-5.6h27.3c3.1,0,5.6,2.5,5.6,5.6v21.5C90,38.2,87.5,40.7,84.4,40.7z M59.5,32.7H82V16H59.5V32.7z M34.9,84H7.6C4.5,84,2,81.5,2,78.4V56.9c0-3.1,2.5-5.6,5.6-5.6h27.3c3.1,0,5.6,2.5,5.6,5.6v21.5C40.5,81.5,38,84,34.9,84z M10,76h22.5V59.3H10V76z M84.4,84H57.1c-3.1,0-5.6-2.5-5.6-5.6V56.9c0-3.1,2.5-5.6,5.6-5.6h27.3c3.1,0,5.6,2.5,5.6,5.6v21.5C90,81.5,87.5,84,84.4,84z M59.5,76H82V59.3H59.5V76z"/>
						</svg>
					</span>
					<span class="sort_list" onclick="listShow()" title="리스트 형식으로 보기">
						<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="40px" height="40px" viewBox="0 0 92 92" enable-background="new 0 0 92 92" xml:space="preserve">
						<path id="XMLID_1308_" d="M25.6,14c0-2.8,2.2-5,5-5H86c2.8,0,5,2.2,5,5s-2.2,5-5,5H30.6C27.8,19,25.6,16.8,25.6,14z M86,41H30.6c-2.8,0-5,2.2-5,5s2.2,5,5,5H86c2.8,0,5-2.2,5-5S88.8,41,86,41z M86,73H30.6c-2.8,0-5,2.2-5,5s2.2,5,5,5H86c2.8,0,5-2.2,5-5S88.8,73,86,73z M9,39.4c-3.9,0-7,3.2-7,7.1s3.1,7.1,7,7.1c3.9,0,7-3.2,7-7.1S12.8,39.4,9,39.4z M9,7c-3.9,0-7,3.2-7,7.1c0,3.9,3.1,7.1,7,7.1c3.9,0,7-3.2,7-7.1C16,10.2,12.8,7,9,7z M9,70.8c-3.9,0-7,3.2-7,7.1C2,81.8,5.1,85,9,85c3.9,0,7-3.2,7-7.1C16,74,12.8,70.8,9,70.8z"/>
						</svg>
					</span>
				</div>
			</div>
			
			<br>
			
			<!-- 리스트형 출력방식 / 기본값 : hide-->
			<section id="listType" class="form-control">
				<ul class="list-type">
					<c:forEach var="dto" items="${list }">
						<a href="/sangpum/detail?num=${dto.j_sangid }" class="item-list-content">
							<li class="form-control">	
								<article>
									<div class="item-list-div">
										<img class="item-list-img" src="../img/${dto.j_imageurl }" alt="..."/>
										<div class="item-list-content">
											<h2 class="fw-bolder item-list-title">&nbsp;${dto.j_title}</h2><br>
											<h6 class="item-list-price"><fmt:formatNumber value="${dto.j_price}" type="currency"/></h6> 
										</div>
									</div>	
								</article>	
							</li>
						</a>
					</c:forEach>	
				</ul>
			</section>	 
			
			<!-- 카드형 출력방식 -->
			<div id="cardType" class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">     	
		     	<c:forEach var="dto" items="${list }">
		     	<div class="col mb-5">
		     		<div class="card h-100">
		                <img class="card-img-top" src="../img/${dto.j_imageurl }" alt="..."/> 
		                <div class="card-body p-4">
			            	<div class="text-center">
			            		<h5 class="fw-bolder">${dto.j_title}</h5>
			            		<fmt:formatNumber value="${dto.j_price}" type="currency"/>
							</div>
						</div>
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">	
								<a class="btn btn-outline-dark mt-auto" href="/detail">상품보기</a>
							</div>
						</div>
					</div>
				</div>			
		     	</c:forEach>
	     	</div>
	     	<!-- 
	     	<div class="col mb-5">
					<div class="card h-100">
						Product image
						<img class="card-img-top"
							src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
						Product details
						<div class="card-body p-4">
							<div class="text-center">
								Product name
								<h5 class="fw-bolder">Fancy Product</h5>
								Product price
								$40.00 - $80.00
							</div>
						</div>
						
						Product actions
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">	
								<a class="btn btn-outline-dark mt-auto" href="/detail">View
									options</a>
							</div>
						</div>
					</div>
				</div>
	     	 -->
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