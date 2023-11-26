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
	* {
		margin: 0;
		padding: 0;
	}
	
	.container {
		width: 500px;
		margin: 0 auto;
		padding: 25px
	}
	
	.container h1 {
		text-align: left;
		padding: 5px 5px 5px 15px;
		color: #FFBB00;
		border-left: 3px solid #FFBB00;
		margin-bottom: 20px;
	}
	
	.chating {
		background-color: #000;
		width: 500px;
		height: 500px;
		overflow: auto;
	}
	
	.chating .me {
		color: #F6F6F6;
		text-align: right;
	}
	
	.chating .others {
		color: #FFE400;
		text-align: left;
	}
	
	input {
		width: 330px;
		height: 25px;
	}
	
	.messagefilepreview {
		position: inherit;
		background: white;
		box-shadow: 0px 0px 10px lightgray;
		border-bottom: 1px solid lightgray;
		width: 100%;
		height: 100px;
		display: inline-flex;
		align-items: center;
		bottom: 0;
		margin-bottom: 55px;
		z-index: 5p;
		/* display: none; */
	}
	
	.messagefilepreview div {
		height: 75px;
		margin: 0 auto;
		margin-left: 15px;
		display: inline-flex;
		align-items: flex-end;
	}
	
	.messagefilepreview img {
		height: 75px;
	}
	
	.messagefilepreview span {
		cursor: pointer;
	}
	</style>


<script type="text/javascript">
$(function(){
	wsOpen();//웹소켓 오픈
	getChatting("${room_num}");//기존 채팅방 가져오기
});

	//상대방과 하던 채팅 가져오기
	function getChatting(room_num){
		
		//alert(room_num);
		
		if(room_num==0){
			return;
		}
		
		$.ajax({
			type:"get",
			dataType:"json",
			url:"/message/chatting",
			data:{"room_num":room_num},
			success:function(res){
				var chatContent="";
				$.each(res, function(i,ele){
					
					if(ele.sender_num=="${user_num}"){
						chatContent+="<p class='me' style='text-align: right;'>("+ele.mess_time+")&nbsp;&nbsp;나:"+ele.mess_content+"</p>";
					}else{
						chatContent+="<p class='other' style='text-align: left;'>("+ele.mess_time+")&nbsp;&nbsp; 상대:"+ele.mess_content+"</p>";
					}
				});
				
				$("#chatShow").html(chatContent);
			}
		});
		
		
		
		
	};


	
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
			var msgJson = JSON.parse(msg)

			var room_num = $("#room_num").val();//현제 선택된 채팅방
			
			getChatting(room_num);
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
		
		var room_num=$("#room_num").val();
		var msg = $("#chatting").val();
		var mynum = "${sessionScope.user_num}";
		
		alert(room_num);
			
		ws.send(JSON.stringify({
			"room_num" : room_num,
			"msg" : msg,
			"mynum" : mynum,
			"type" : "chat"
		}));

		$("#chatting").val("");
		getChatting(room_num); 

	}

</script>
</head>
<body>
	<div id="container" class="container">
		<h1>${roomName}의 채팅방</h1>
		<input type="hidden" id="room_num" value="${room_num}">		
		
		<div id="chatShow" class="chating">
		</div>
		
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th>
						<input id="chatting" placeholder="보내실 메시지를 입력하세요.">
					</th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
				<tr>
					<th>파일업로드</th>
					<th><input type="file" accept="image/jpeg,.png,.gif" id="msgfileupload"></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>