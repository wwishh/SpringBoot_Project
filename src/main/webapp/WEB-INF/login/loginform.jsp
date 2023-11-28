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
  Kakao.init('e71519cf7254125fd922e1ee6dfb4122'); // 사용하려는 앱의 JavaScript 키 입력
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
							
							<!--  
							<button type="button" id="kakao-login-btn" name="kakaologinbtn "style="border:2px solid white; background-color:white"
							onclick="location.href='/app/users/kakao'">
								<img src="../img/kakaologin.png" style="width:20vh; height:6.1vh; border-radius: 30px;">
							</button>
							-->

							<a id="kakao-login-btn" href="javascript:loginWithKakao()">
								<img
								src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg"
								style="width: 20vh; height: 6.1vh; border-radius: 30px;" />
							</a>
							<p id="token-result"></p>
							<button class="api-btn" onclick="requestUserInfo()" style="visibility:hidden">사용자 정보 가져오기</button>

	
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


	<script type="text/javascript">
	/*	
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
		*/
		
		/* 카카오 로그인 1차관문 통과 
		 function loginWithKakao() {
	            location.href = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=6d49d3af0767e8e24e32a53f0def9545&redirect_uri=http://localhost:8949/app/users/kakao";
	        }

	        function getSearchParams(k) {
	            var p = {};
	            location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (s, k, v) { p[k] = v })
	            return k ? p[k] : p;
	        }

	        $(document).ready(function () {

	            var codeTest = getSearchParams("code");
	            
	            if (codeTest != null && codeTest != undefined) {
	                $.ajax({
	                    type: "POST",
	                    url: "https://kauth.kakao.com/oauth/token",
	                    header: {
	                        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
	                    },
	                    data: { grant_type: "authorization_code", client_id: "6d49d3af0767e8e24e32a53f0def9545", redirect_uri: "http://localhost:8949/app/users/kakao", code: codeTest },
	                    success: function (data, textStatus) {
	                        console.log(data);
	                        console.log(data.access_token);
	                        alert("토큰 -> " + data.access_token);
	                    },
	                    error: function (request, status, error) {
	                        alert("code:" + request.status + "\r\n" + "message:" + request.responseText + "\r\n" + "error:" + error);
	                    }
	                });
	            }
	        });
	        */
	        
	        function loginWithKakao() {
	            Kakao.Auth.authorize({
	              redirectUri: 'http://localhost:8949/app/users/kakao',
	              state: 'userme',
	            });
	          }

	          function requestUserInfo() {
	            Kakao.API.request({
	              url: '/v2/user/me',
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

	          // 아래는 데모를 위한 UI 코드입니다.
	          displayToken()
	          function displayToken() {
	            var token = getCookie('authorize-access-token');

	            if(token) {
	              Kakao.Auth.setAccessToken(token);
	              document.querySelector('#token-result').innerText = 'login success, ready to request API';
	              document.querySelector('button.api-btn').style.visibility = 'visible';
	            }
	          }

	          function getCookie(name) {
	            var parts = document.cookie.split(name + '=');
	            if (parts.length === 2) { return parts[1].split(';')[0]; }
	          }
	
	</script>
	
	


</body>



</html>