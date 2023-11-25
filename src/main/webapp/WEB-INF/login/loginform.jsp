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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.5.0/kakao.min.js"
  integrity="sha384-kYPsUbBPlktXsY6/oNHSUDZoTX6+YI51f63jCPEIPFP09ttByAdxd2mEjKuhdqn4" crossorigin="anonymous"></script>
<script>
$(function(){
	var passtype=$("#u_pass").attr("type");
	
	$("#btnpasson").hide();

	$("#btnpassoff").click(function(){
		//alert(passtype);
		$("#u_pass").attr("type","text");
		$("#btnpassoff").hide();
		$("#btnpasson").show();

	});
	
	$("#btnpasson").click(function(){
		//alert(passtype);
		$("#u_pass").attr("type","password");
		$("#btnpasson").hide();
		$("#btnpassoff").show();
	});
	
	
});

function CheckCapsLock(event){
	if(event.getModifierState("CapsLock")){
		document.getElementById("pwmsg").innerText = "Caps Lock 활성화됨"
	} else {
		document.getElementById("pwmsg").innerText = ""
	}
	
}
  
</script>
<style>
#btnpasson{
cursor: pointer;
position: absolute;
top:107px;
left: 475px;
font-size: 30px;
}
#btnpassoff{
cursor: pointer;
position: absolute;
top:107px;
left: 475px;
font-size:30px;
}

</style>
<title>Insert title here</title>
</head>
<body>

	<div class="container text-center">
		<div class="row">
			<div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
				<div class="card card-signin my-5">
					<div class="card-body">
						<h5 class="card-title text-center">
							<b>Log In</b>
						</h5>
						<form class="form-signin " method="post" action="login">
							<div class="form-label-group">
								<input type="text" id="u_id" name="u_id" class="form-control"
									placeholder="id" required="required" >
									
							</div>
							<br>

							<div class="form-label-group">
								<input type="password" id="u_pass" name="u_pass" class="form-control"
									placeholder="Password" required="required" onkeyup="CheckCapsLock(event)" onchange="CheckCapsLock(event)">
									<div id="pwmsg" style="color: red;"></div>
									<i class='bi bi-eye-fill' id="btnpasson"></i> 
									<i class="bi bi-eye-slash-fill" id="btnpassoff"></i> 
									
							</div>
							
							<br>
							

							<hr>

							<div class="form-label-group">
								<c:if test="${check == 1 }">
									<label>${message }</label>
								</c:if>
							</div>


							<button type="submit" style="border:2px solid white; border-radius:30px; background-color:lightgray; color:white;
							width:42vh; height:6.1vh;">Sign in</button>
								
							<br>
							
							<button type="button" id="naverloginbtn" name="naverloginbtn"style="border:2px solid white; background-color:white">
								<img src="../img/naverlogo.png" style="width:20vh; height:6.1vh; border-radius:30px;">
							</button>
							
							
							<button type="button" id="kakao-login-btn" name="kakaologinbtn "style="border:2px solid white; background-color:white"
							onclick="location.href='javascript:loginWithKakao()'">
								<img src="../img/kakaologin.png" style="width:20vh; height:6.1vh; border-radius: 30px;">
							</button>
							<p id="token-result"></p>
								
								
							<hr class="my-4">
							Forgot your <a href="javascript:void(0)" onclick="findid()">ID</a>
							or <a href="javascript:void(0)" onclick="findpassword()">Password</a>?
							<button type="button" class="btn btn-lg btn-dark btn-block text-uppercase"
								onclick="location='joinform'">Join</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		function findid() {
			var url = "find_id_form";

			window
					.open(url, "_blank_1",
							"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=500, height=500");
		}

		function findpassword() {
			var url = "find_password_form";

			window
					.open(url, "_blank_1",
							"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=500, height=500");
		}
		function loginWithKakao() {
		    Kakao.Auth.authorize({
		      redirectUri: 'https://developers.kakao.com/tool/demo/oauth',
		    });
		  }
		//test 
		Kakao.init('3336b0db7f7e18999056f7f419eb0d26'); // 사용하려는 앱의 JavaScript 키 입력
		displayToken()
		  function displayToken() {
		    var token = getCookie('authorize-access-token');

		    if(token) {
		      Kakao.Auth.setAccessToken(token);
		      Kakao.Auth.getStatusInfo()
		        .then(function(res) {
		          if (res.status === 'connected') {
		            document.getElementById('token-result').innerText
		              = 'login success, token: ' + Kakao.Auth.getAccessToken();
		          }
		        })
		        .catch(function(err) {
		          Kakao.Auth.setAccessToken(null);
		        });
		    }
		  }

		  function getCookie(name) {
		    var parts = document.cookie.split(name + '=');
		    if (parts.length === 2) { return parts[1].split(';')[0]; }
		  }
		
	</script>


</body>
</html>