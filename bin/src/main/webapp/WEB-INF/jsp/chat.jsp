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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>

<meta charset="UTF-8">
	<title>Chating</title>
	<style>
		*{
			margin:0;
			padding:0;
		}
		.container{
			width: 500px;
			margin: 0 auto;
			padding: 25px
		}
		.container h1{
			text-align: left;
			padding: 5px 5px 5px 15px;
			color: #FFBB00;
			border-left: 3px solid #FFBB00;
			margin-bottom: 20px;
		}
		.chating{
			background-color: #000;
			width: 500px;
			height: 500px;
			overflow: auto;
		}
		.chating .me{
			color: #F6F6F6;
			text-align: right;
		}
		.chating .others{
			color: #FFE400;
			text-align: left;
		}
		input{
			width: 330px;
			height: 25px;
		}
		
	</style>


<script type="text/javascript">
$(function() {
	var ws;
	wsOpen();
	getChatting();
});
	/*var ws;

	function wsOpen(){
		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
		ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());
		wsEvt();
	}
		
	function wsEvt() {
		ws.onopen = function(data){
			//소켓이 열리면 동작
		}
		
		ws.onmessage = function(data) {
			//메시지를 받으면 동작
			var msg = data.data;
			if(msg != null && msg.trim() != ''){
				var d = JSON.parse(msg);
				if(d.type == "getId"){
					var si = d.sessionId != null ? d.sessionId : "";
					if(si != ''){
						$("#sessionId").val(si); 
					}
				}else if(d.type == "message"){
					if(d.sessionId == $("#sessionId").val()){
						$("#chating").append("<p class='me'>나 :" + d.msg + "</p>");	
					}else{
						$("#chating").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");
					}
						
				}else{
					console.warn("unknown type!")
				}
			}
		}

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
	}

	function chatName(){
		var userName = $("#userName").val();
		if(userName == null || userName.trim() == ""){
			alert("사용자 이름을 입력해주세요.");
			$("#userName").focus();
		}else{
			wsOpen();
			$("#yourName").hide();
			$("#yourMsg").show();
		}
	}

	function send() {
		var option ={
			type: "message",
			roomNumber: $("#roomNumber").val(),
			sessionId : $("#sessionId").val(),
			userName : $("#userName").val(),
			msg : $("#chatting").val()
		}
		ws.send(JSON.stringify(option))
		$('#chatting').val("");
	}*/
	


	//웹소켓 오픈
	function wsOpen() {
		
		ws = new WebSocket("ws://" + location.host + "/chating");
		wsEvt();
	}

	function wsEvt() {
		ws.onopen = function(data) {
			//소켓이 열리면 초기화 세팅하기
		}
		
	
		//메시지 잘 들어왔을 때 실행하는 내용
		ws.onmessage = function(data) {
			var msg = data.data;
			var d=JSON.parse(msg)
			
			alert(d.type);
			
			/* getChatting();
			
			if(d.type == "message"){
				$("#chating").append("<p>" + msg + "</p>");
			} */

			/* if(d.type == "message"){
				if(d.seller_id==${loginid}){//판매자가 현재 로그인한 아이디와 같다면
					$("#chating").append("<p class='me'>나 :" + d.msg + "</p>");	
				}else{
					$("#chating").append("<p class='others'>"+ d.buyer_id + " :" + d.msg + "</p>");
				}
			} */
		}

		//채팅 입력창에서 엔터 누르면 채팅 보내짐
		$("#chatting").keyup(function(e) {
			if (e.keyCode == 13) { //enter press
				if ($("#chatting").val() != '') {
					send();
				}
			}
		});
	}

	//메시지 보내면 동작하는 코드
	function send() {

			var	roomNumber = $("#roomNumber").val();
			var	seller_id = $("#seller_id").val();
			var	buyer_id = $("#buyer_id").val();
			var	chat = $("#chatting").val();
			
			alert(roomNumber+","+seller_id+","+buyer_id+","+chat);
			
			ws.send(JSON.stringify({
	            "roomNumber": roomNumber,
	            "seller_id": seller_id,
	            "buyer_id": buyer_id,
	            "chat": chat,
	            "type": "message"
	        }));
			
			$("#chatting").val("");
			getChatting();
		 
	}
	
	function getChatting(){
		$.ajax({
			type:"get",
			dataType:"json",
			url:"getChatting",
			data:{"room_id":$("#roomNumber").val()},
			success:function(res){
				var chatContent="";
				$.each(res,function(i,data){
					alert(data.setter_id);
				})
				/* $.each(res, function(i,data){
					if(data.seller_id==data.loginid){
						chatContent+="<p class='seller' del="+data.chat_id+">나 :" + data.content + "</p>";
					}else{
						chatContent+="<p class='buyer' del="+data.chat_id+">" + data.sender + " :" + data.content + "</p>"
					}
				}); 
				
				$("#chating").append(chatContent); */
			}
			
		});
	}
	
	
</script>
</head>
<body>
	<div id="container" class="container">
		<h1>${roomName}의 채팅방</h1>
		<input type="hidden" id="roomNumber" value="${room_id}">
		<input type="hidden" id="seller_id" value="${seller_id }">
		<input type="hidden" id="buyer_id" value="${buyer_id }">
		
		<div id="chating" class="chating">
		</div>
		
		<!-- <div id="yourName">
			<table class="inputTable">
				<tr>
					<th>사용자명</th>
					<th><input type="text" name="userName" id="userName"></th>
					<th><button onclick="chatName()" id="startBtn">이름 등록</button></th>
				</tr>
			</table>
		</div> -->
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>