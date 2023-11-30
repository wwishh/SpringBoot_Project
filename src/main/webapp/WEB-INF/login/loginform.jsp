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
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.5.0/kakao.min.js"
  integrity="sha384-kYPsUbBPlktXsY6/oNHSUDZoTX6+YI51f63jCPEIPFP09ttByAdxd2mEjKuhdqn4" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script>
  Kakao.init('b9db298aab55a534f1075945a07886fe'); // 사용하려는 앱의 JavaScript 키 입력
</script>

  
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
#btnpasson {
	cursor: pointer;
	position: absolute;
	top: 107px;
	left: 475px;
	font-size: 30px;
}

#btnpassoff {
	cursor: pointer;
	position: absolute;
	top: 107px;
	left: 475px;
	font-size: 30px;
}

.failcnt {
	display: flex;
	flex-direction: row; /* 요소를 행 방향으로 나열합니다. */
	gap: 3vw; /* 각 요소 사이의 간격을 지정합니다. */
}

.randomquiz, .randomanswer {
	border: 1px solid black;
	width: 13vw;
	height: 5vh;
}
.failfont{
color: red;
font-size: 13px;
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
									
									<br>
									
							<div class="failcnt">
								<div class="randomquiz"></div>
								<div class="randomanswer"></div>
								<b class="failfont">잘못된 로그인시도 5회로 인해 확인요소 강화합니다</b>
							</div>
							<b>문구와 일치합니다</b>
									
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
							
							
							<a id="kakao-login-btn" href="javascript:loginWithKakao()"> 
							<img
								src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
								style="width:20vh; height:6.1vh; border-radius:30px;" alt="카카오 로그인 버튼" />
							</a>
							<p id="token-result"></p>
							
							<hr class="my-4">
							<ul> 
							<li style="list-style-type: none; float: left; margin-right:150px;" >
							<a href="../idsearch" style="text-decoration: none; color: black;"  >ID찾기</a>
							</li>
							
							<li style="list-style-type: none; float:left; margin-right:30px;"> 
							<a href="../pwsearch" style="text-decoration: none; color:black;">PW찾기</a>
							</li>
							<li style="list-style-type: none; float:right; margin-right:30px;">
							<a href="../joinform" style="text-decoration: none; color:black;" >가입</a>
							</li>
							</ul>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>

<script>
function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'http://localhost:8949/loginform',
    });
  }
  
  <!--
    const url = 'https://kauth.kakao.com/oauth/authorize?client_id=e71519cf7254125fd922e1ee6dfb4122' +
        '&redirect_uri=	http://localhost:8949' +
        '&response_type=code&' +
        'scope=account_email name profile_nickname phone_number';
	-->
 
  // 아래는 데모를 위한 UI 코드입니다.
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
          Kakao.Auth.setAccessToken("1111");
          
        });
    }
  }

  function getCookie(name) {
    var parts = document.cookie.split(name + '=');
    if (parts.length === 2) { return parts[1].split(';')[0]; }
  }
  
  function requestUserInfo() {
	    Kakao.API.request({
	      url: 'http://localhost:8949',
	    })
	      .then(function(res) {
	        alert(JSON.stringify(res));
	      })
	      .catch(function(err) {
	        alert(
	          'failed to request user information: ' + JSON.stringify(err)
	        );
	      });
	  }
</script>

</html>