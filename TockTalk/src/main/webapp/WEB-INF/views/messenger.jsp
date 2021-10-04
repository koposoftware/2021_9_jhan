<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/nav.jsp" />


<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

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
		.chatFormat{
			
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
			height: 50px;
			margin-left: 5px;
			margin-right: 5px;
		}
		#yourMsg{
			background-color: #f5f5f5;
			text-align:center;
			display:inline;
		}
		#sendBtn{
		
		}
		.chat_wrap .header { font-size: 14px; padding: 15px 0; background: #1F9688; color: white; text-align: center;  }
		 
		.chat_wrap .chat { padding-bottom: 80px; }
		.chat_wrap .chat ul { width: 100%; list-style: none; }
		.chat_wrap .chat ul li { width: 100%; }
		.chat_wrap .chat ul li.left { text-align: left; }
		.chat_wrap .chat ul li.right { text-align: right; }
		 
		.chat_wrap .chat ul li > div { font-size: 13px;  }
		.chat_wrap .chat ul li > div.sender { margin: 10px 20px 0 20px; font-weight: bold; }
		.chat_wrap .chat ul li > div.message { display: inline-block; word-break:break-all; margin: 5px 20px; max-width: 75%; border: 1px solid #888; padding: 10px; border-radius: 5px; background-color: #FCFCFC; color: #555; text-align: left; }
		 
		.chat_wrap .input-div { position: fixed;  bottom:0; width: 95%; background-color: #FFF; text-align: center; border-top: 1px solid #F18C7E; }
		.chat_wrap .input-div > textarea { width: 100%; height: 80px; border: none; padding: 10px; }
		 
		.format { display: none; }
		

	</style>
</head>

<script type="text/javascript">
	var ws;
	function wsOpen(){
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
						/* $("#chatting").append("<p class='me'>"
								+ "<strong>" + d.userName + "(me)</strong>"
								+"<div class='me'>"	+ "<strong style='display : inline;' class='align-self-end'>" + "</strong>"
								+ d.msg
								+"</div>"
								+ "</p>");
						  */
						 $("#chatting").append('<a class="me" href="#" onclick="selectUser(\'' + d.userName + '\')"><li class="clearfix">\n' +
			                '                <img src="https://rtfm.co.ua/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png" width="55px" height="55px" alt="avatar" />\n' +
			                '                <div class="me">\n' +
			                '                    <div id="userNameAppender_' + d.userName + '" class="name">' + d.userName + '</div>\n' +
			                '                    <div class="status">\n' +
			                '                        <i class="fa fa-circle offline"></i>\n' +
			                '                    </div>\n' +
			                '                </div>\n' +
			                '            </li></a>');
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
		console.log(userName); 
			wsOpen();
	});
	
	function send() {
		var room = '<%= request.getParameter("symbol") %>';
		var option ={
			type: "message",
			sessionId : $("#sessionId").val(),
			userName : '<%=(String)session.getAttribute("ses_name")%>',
			msg : $("#chat").val()
		}
		ws.send(JSON.stringify(option))
		$('#chat').val("");
	}
	
	
	/**/
	const Chat = (function(){
    const myName = "안재훈";
 
    // init 함수
    function init() {
        // enter 키 이벤트
        $(document).on('keydown', 'div.input-div textarea', function(e){
            if(e.keyCode == 13 && !e.shiftKey) {
                e.preventDefault();
                const message = $(this).val();
 				console.log(message);
                // 메시지 전송
                sendMessage(message);
                // 입력창 clear
                clearTextarea();
            }
        });
    }
 
    // 메세지 전송
    function sendMessage(message) {
        // 서버에 전송하는 코드로 후에 대체
        const data = {
            "senderName"    : "안재훈",
            "message"        : message
        };
 
        // 통신하는 기능이 없으므로 여기서 receive
        resive(data);
    }
 
    // 메세지 입력박스 내용 지우기
    function clearTextarea() {
        $('div.input-div textarea').val('');
    }
 
    // 메세지 수신
    function resive(data) {
        const LR = (data.senderName != myName)? "left" : "right";
        appendMessageTag(LR, data.senderName, data.message);
    }
    
    // 메세지 태그 append
    function appendMessageTag(LR_className, senderName, message) {
        const chatLi = createMessageTag(LR_className, senderName, message);
 
        $('div.chat:not(.format) ul').append(chatLi);
 
        // 스크롤바 아래 고정
        $('div.chat').scrollTop($('div.chat').prop('scrollHeight'));
    }
    
    // 메세지 태그 생성
    function createMessageTag(LR_className, senderName, message) {
        // 형식 가져오기
        let chatLi = $('div.chat.format ul li').clone();
 
        // 값 채우기
        chatLi.addClass(LR_className);
        chatLi.find('.sender span').text(senderName);
        chatLi.find('.message span').text(message);
 		console.log("char 2: "+ chatLi.find('.message span').text(message));
        return chatLi;
    }
    return {
        'init': init
    };
	})();
	 
	$(function(){
	    Chat.init();
	});


</script>
<body>
<div class="chat_wrap">
    <div class="header">
        <h3>별돌이님과의 대화</h3>
    </div>
        <div class="chat" >
        <ul>
	            <li class = "right">
	                <div class="sender" style="font-size: 20px;">
	                    <span>안재훈</span>
	                </div>
	                <div class="message" style="font-size: 20px;">
	                    <span>이렇게 하면 돼??	</span>
	                </div>
	            </li>
	            
	          	 <li class = "left">
	                <div class="sender" style="font-size: 20px;">
	                    <span>별돌이</span>
	                </div>
	                <div class="message" style="font-size: 20px;">
	                    <span>그러면 이번 기회에 배워보자!</span>
	                </div>
	            </li>
	            <li class = "left">
	                <div class="sender" style="font-size: 20px;">
	                    <span>별돌이</span>
	                </div>
	                <div class="message" style="font-size: 20px;">
	                    <span> </span>
	                </div>
	            </li>
        </ul>
    </div>

      <!-- <div id="chatting" class="chatting"></div> -->
    <div class="input-div">
        <textarea placeholder="Press Enter for send message."></textarea>
    </div>
 
    <!-- format -->
 
    <!-- <div class="chatFormat">
        <ul>
            <li>
                <div class="sender">
                    <span></span>
                </div>
                <div class="message">
                    <span></span>
                </div>
            </li>
        </ul>
    </div> -->
</div>

</body>
</html>

<%-- <jsp:include page="common/footer.jsp" /> --%>