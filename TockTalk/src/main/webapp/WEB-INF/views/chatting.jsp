<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
	<title>chatting</title>
	<style>
		*{
			margin:0;
			padding:0;
		}
		.container{
			margin: 0 auto;
			padding: 25px
		}
		.container h1{
			text-align: left;
			padding: 5px 5px 5px 15px;
			color: #5f5f5f;
			border-left: 3px solid #FFBB00;
			margin-bottom: 20px;
		}
		.chatting{
			background-color: #f5f5f5;
			height: 600px;
			overflow: auto;
		}
		.chatting .me{
			color: #000;
			text-align: right;
		}
		.chatting .others{
			color: #000;
			text-align: left;
		}
		input{
			height: 25px;
			margin-left: 5px;
			margin-right: 5px;
		}
		#yourMsg{
			background-color: #f5f5f5;
			text-align:center;
			display:inline;
		}
	.chatting .myMessage {
	 border: 1px solid #888;  
	 color: #555; text-align: right	; 
	 }
 


	</style>
</head>

<script type="text/javascript">
	var ws;
	function wsOpen(room){
		ws = new WebSocket("ws://" + location.host + "/chatting/" + room);
		wsEvt();
	}
		
	function wsEvt() {
		ws.onopen = function(data){
			//소켓이 열리면 초기화 세팅하기
			console.log('소켓열림');
			console.log('ws : ' + ws.url);
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
						/* $("#chatting").append("<p class='me' style='color: red; font-size:20px; font-weight:bold;'>"+ d.userName +"<br> : " + d.msg + "</p>");
						 */$("#chatting").append("<p class='me'>"
								+ "<strong>" + d.userName + "(me)</strong>"
								+"<div class='me'>"	+ "<strong style='display : inline;' class='align-self-end'>" + "</strong>"
								+ d.msg
								+"</div>"
								+ "</p>");
					}else{
						$("#chatting").append("<p class='others' style='color: black; font-size:20px;font-weight:bold;'>"+ d.userName +"<br> : " + d.msg + "</p>");	
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
	$(document).ready(function chatName(){
	
		var userName = '<%=(String)session.getAttribute("ses_name")%>';
		/* var userName = $("#userName").val(); */
		console.log(userName); 
		if(userName == null || userName.trim() == ""){
			alert("사용자 이름을 입력해주세요.");
			$("#userName").focus();
		}else{
			var room = '<%= request.getParameter("symbol") %>';
			wsOpen(room);
			$("#yourName").hide();
			$("#yourMsg").show();
		}
	});
	
	function send() {
		var room = '<%= request.getParameter("symbol") %>';
		var option ={
			type: "message",
			sessionId : $("#sessionId").val(),
			userName : '<%=(String)session.getAttribute("ses_name")%>',
			room : room,
			msg : $("#chat").val()
		}
		ws.send(JSON.stringify(option))
		$('#chat').val("");
	}
</script>
<body>
	<h3 class="greenFontBold mt-5" style="text-align:center;" ><%= request.getParameter("chattingName") %> 채팅</h3>
	<div id="container" class="container">
	<input type="hidden" id="sessionId" value="">
		<div id="chatting" class="chatting">
		</div>
		<!--
 		<div id="yourName">
			<table class="inputTable">
				<tr>
					<th>사용자</th>
					<th><input type="text" name="userName" id="userName"></th>
					<th><button onclick="chatName()" id="startBtn">등록</button></th>
				</tr>
			</table>
		</div> --> 
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th><input id="chat" style="width:260px;" placeholder="보낼 메시지를 입력해주세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
