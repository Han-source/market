<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/resources/js/bootstrap2.js"></script>
<script src="\resources\js\util\utf8.js"></script>
<!-- <link rel="stylesheet" href="/resources/css/bootstrap2.css"> -->
<!-- <link rel="stylesheet" href="/resources/css/custom.css"> -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/chatting.css" type="text/css">
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"
	th:content="${_csrf.headerName}" />
</head>

<body>

<div class="chat_container" id="chat">
        <div class="chat_title">
            <span>${toId}님과 대화중</span>
        </div>
        <div class="chat_message_list" id="chatList">
            <div class="message_row you_message"></div>
            <div class="message_row other_message"></div>
        </div>
        <div class="chat_form" id="frmMember" action="/chat/chatting" method="post">
            <form>
                <input type="text" placeholder="메시지를 입력하세요." id="chatContent" name="chatContent" maxlength="100">
                <button type="button" class="btn btn-default pull-right" onclick="chatSubmit();">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </form>
        </div>
    </div>

<div class="alert alert-success" id="successMessage"
	style="display: none;">
	<strong>메시지 전송에 성공했습니다.</strong>
</div>
<div class="alert alert-danger" id="dangerMessage"
	style="display: none;">
	<strong>이름과 내용을 모두 입력해주세요.</strong>
</div>
<div class="alert alert-warning" id="warningMessage"
	style="display: none;">
	<strong>데이터베이스 오류 발생했습니다. </strong>
</div>

<!--Page level plugins
<script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>
 -->

<!-- Page level custom scripts
<script src="/resources/js/demo/datatables-demo.js"></script>
 -->

<!-- End of Main Content -->
<script src="\resources\js\chat\chat.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		getUnread();
		chatListFunction();
		getInfiniteChat();
		getInfiniteUnread();
	});
</script>

	<script type="text/javascript">
	var fromID = "${userId}";
	var toID = "${toId}";
	var postId;
	var chatContent;
	var csrfHN = "${_csrf.headerName}";
	var csrfTV = "${_csrf.token}";
	$(document).ajaxSend(
		function(e, xhr){
			xhr.setRequestHeader(csrfHN, csrfTV);
		}
	);
	
	//네고 버튼을 수락했을 때
	function updateProductPrice(negoPrice) {
		postId = $('#postId').val();
		chatService.negoProductPrice(fromID, toID, negoPrice, postId, '수락')
		chatContent = '가격제안이 수락되었습니다.';
		chatService.agreeFunction(fromID, toID, chatContent , postId);
	}
	//네고버튼을 거절했을 때
	function disAgree() {
		chatContent = '가격제안이 거절되었습니다.';
		postId = $('#postId').val();
		chatService.disAgreeFunction(fromID, toID, chatContent , postId);
	}
	//사용자가 메세지 전송 버튼을 누르면 실행되는 함수
	function chatSubmit(){
		chatService.chatSubmit(fromID, toID, $('#chatContent').val());
	}
	
	
	function autoClosingAlert(selector, delay) {
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {
			alert.hide()
		}, delay);
	}

	var lastID = 0;
	//채팅방 내용 띄워주기
	function chatListFunction() {
		chatService.chatList(fromID, toID)
	}

	// 채팅을 보낸사람, 내용, 시간 
	// 채팅 메시지 형태
	function addChat(chatName, chatContent, chatTime) {
		 if (chatName == '나'){
	         $('#chatList')
	         	.append(
						'<div class="row">'
								+ '<div class="col-lg-12">'
									+ '<div class="media">'
								+ '<a class="pull-left" href="#">'
								+ '</a>'
										+ '<div class="message_row you_message">'
											+ '<div class="message_text">' + chatContent + '</div>'
											+ '<div class="message_time">' + chatTime + '</div>'
										+ '</div>'
									+ '</div>'
								+ '</div>'
						+ '</div>');
   			}else{
			$('#chatList')
				.append(
						'<div class="row">'
								+ '<div class="col-lg-12">'
									+ '<div class="media">'
								+ '<a class="pull-left" href="#">'
								+ '</a>'
										+ '<div class="message_row other_message">'
											+ '<div class="message_text">' + chatContent + '</div>'
											+ '<div class="message_time">' + chatTime + '</div>'
										+ '</div>'
									+ '</div>'
								+ '</div>'
						+ '</div>');
     	}
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight); // 스크롤을 맨 아래로 두기
	}
	
	$('#negoAgree').on("click", function(e) {
		alert('수락');
	});
	
	function getUnread() {
		chatService.chatUnread(fromID)
	}

	function getInfiniteChat() {
		setInterval(function() {
			chatListFunction();
		}, 3000);
	}

	function getInfiniteUnread() {
		setInterval(function() {
			getUnread();
		}, 1000);
	}

	function showUnread(result) {
		$('#unread').html(result);
	}
</script>

</body>

</html>

