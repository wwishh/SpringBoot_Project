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

<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.5.0/kakao.min.js"
  integrity="sha384-kYPsUbBPlktXsY6/oNHSUDZoTX6+YI51f63jCPEIPFP09ttByAdxd2mEjKuhdqn4" crossorigin="anonymous"></script>
<script>
  Kakao.init('b9db298aab55a534f1075945a07886fe');
</script>

<title>Insert title here</title>
</head>
<body>
	<!-- Footer-->
	<footer class="py-5 bg-black">
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

		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2023</p>
		</div>
	</footer>
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

  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = 'https://t1.kakaocdn.net/kakao_js_sdk/2.5.0/kakao.channel.min.js';
    js.integrity = 'sha384-j5TN6EqladB+HIfGV8dVYRIzoJf9Fb4lvrkPmo9KlnDWpN1CZz8yC4rCH1ChRbbh';
    js.crossOrigin = 'anonymous';
    fjs.parentNode.insertBefore(js, fjs);
  })(document, 'script', 'kakao-js-sdk');
  
</script>
</html>