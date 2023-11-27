<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gamja+Flower&family=Nanum+Pen+Script&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<!-- iamport.payment.js --> 
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style>
	#iamportPayment{
		cursor: pointer;
	}
</style>
<title>Insert title here</title>
<script type="text/javascript">
$(function() {
	
	$("#createRoomBtn").click(function(){
		var sangidx = $(this).attr("sangIdx");
		//alert(sangidx); //상품idx가져와서 채팅room생성
		
		$.ajax({
			type:"post",
			url:"/createRoom",
			data:{"sangidx":sangidx},
			dataType:"html",
			success:function(res){
				if(res==0){
					alert("자신이 판매하는 상품은 구매할 수 없습니다.");
					location.href="/goSellerRooms?sangidx="+sangidx;
				}else{
					location.href="/goChattingRoom?room_num="+res;
				}				
			}
		})
		
	})
	

	
		$("#iamportPayment").click(function(){ 
        	payment(); //버튼 클릭하면 호출 
        });
	});
	
	//버튼 클릭하면 실행
    function payment(data) {
    	const randomString = generateRandomString(8);
        IMP.init('imp78057427');//아임포트 관리자 콘솔에서 확인한 '가맹점 식별코드' 입력
        IMP.request_pay({// param
            pg: "kakaopay.TC0ONETIME", //pg사명 or pg사명.CID (잘못 입력할 경우, 기본 PG사가 띄워짐)
            pay_method: "card", //지불 방법
            merchant_uid: randomString, //"iamport_test_id", //가맹점 주문번호 (아임포트를 사용하는 가맹점에서 중복되지 않은 임의의 문자열을 입력)
            name: "${dto.j_title}",//"도서", //결제창에 노출될 상품명
            amount: "${dto.j_price}", //금액
            buyer_email : "${sessionScope.myemail}", 
            buyer_name : "${sessionScope.myname}",
            buyer_tel : "${sessionScope.myhp}"
        }, function (rsp) { // callback
            if (rsp.success) {
                alert("완료 -> imp_uid : "+rsp.imp_uid+" / merchant_uid(orderKey) : " +rsp.merchant_uid);
            } else {
                alert("실패 : 코드("+rsp.error_code+") / 메세지(" + rsp.error_msg + ")");
            }
        });
    }
	
 // 길이 8의 랜덤 문자열 생성
    function generateRandomString(length) {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        let result = '';

        for (let i = 0; i < length; i++) {
          const randomIndex = Math.floor(Math.random() * characters.length);
          result += characters.charAt(randomIndex);
        }

        return result;
      }
</script>
</head>
<body>
<div id="carouselExampleIndicators" class="carousel slide w-50 container">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>

		<div class="carousel-inner rounded">
			<div class="carousel-item active">
				<%-- <img src="../img/${dto.j_imageurl }" class="d-block w-100" alt="..."> --%>
				<c:forTokens var="pho" items="${dto.j_imageurl }" delims=",">
               		<img class="card-img-top" src="../img/${pho }" alt="..." />
               	</c:forTokens>
			</div>
			<div class="carousel-item">
				<img src="../img/detail2.PNG" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="../img/detail1.PNG" class="d-block w-100" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true" ></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	
	<div class="space-between container w-50 h-25">
		<div style="display: flex;">
			<div id="article-profile-image">
				<img alt="달달이" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-c649f052a34ebc4eee35048815d8e4f73061bf74552558bb70e07133f25524f9.png">
			</div>
			<div id="article-profile-left">
				<div id="nickname">${sessionScope.myid }</div>
				<div id="region-name">${dto.j_addr }</div>
			</div>
			<div style="margin-left: auto; margin-top: 5vh;">
				<button class="btn btn-dark" id="createRoomBtn" sangIdx="1">채팅</button>
			</div>
		</div>
		<div id="article-profile-right">
			
			<!-- <dl id="temperature-wrap">				
				<dt>매너온도</dt>
				<dd class="text-color-03 ">
					37.2 <span>°C</span>
				</dd>
			</dl>
			<div class="meters">
				<div class=" bar bar-color-03" style="width: 37%;"></div>
			</div>
			<div class=" face face-03"></div> -->
		</div>
		<hr>
	
		<div>
			<b>${dto.j_title } </b><br>
			<small class="text-secondary">${dto.j_category }</small><br>
			<b><fmt:formatNumber value="${dto.j_price }" type="currency"/></b><br><br>
			<div>
				<p>
					${dto.j_explanation }
				</p>
			</div>
			<div>
				<small class="text-secondary">관심 ${dto.j_interest } 채팅 아직없음 조회 ${dto.j_readcount }</small>
           		<img src="../img/kakaopay.png" style="width:70px; height:30px" id="iamportPayment"> 
			</div>
			<br>
			<hr>
		</div>	
		
	</div>
	
</body>
</html>