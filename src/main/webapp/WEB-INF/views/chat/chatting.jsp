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
                <input type="text" placeholder="메시지를 입력하세요." id="chatContent" name="chatContent"
                maxlength="100">
                <button type="button" class="btn btn-default pull-right" onclick="submitFunction();">
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

<script type="text/javascript">
	$(document).ready(function() {
		getUnread();
		chatListFunction();
		getInfiniteChat();
		getInfiniteUnread();
	});
</script>

<script type="text/javascript">
	function submitFunction() {
		var fromID = "${userId}";
		var toID = "${toId}";
		var chatContent = $('#chatContent').val();
		var header = $("meta[name='_csrf_header']").attr("content");
		var token = $("meta[name='_csrf']").attr("content");
		var csrfHN = "${_csrf.headerName}";
		var csrfTV = "${_csrf.token}";

		$.ajax({
			type : "POST",
			url : "/chat/chatting",
			data : {
				fromID : fromID,
				toID : toID,
				chatContent : chatContent,

			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHN, csrfTV);
			},
			success : function(result) {
				//전송 성공 시 성공alert
				if (result == 1) {
					autoClosingAlert('#successMessage', 2000);
				} else if (result == 0) {
					//전송 오류 시 오류 alert
					autoClosingAlert('#dangerMessage', 2000);
				} else {
					//전송 실패 시 실패 alert
					autoClosingAlert('#warningMessage', 2000);
				}
			}
		});
		// 메시지를 보냈으니 content의 값을 비워준다.
		$('#chatContent').val('');
	}

	function autoClosingAlert(selector, delay) {
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {
			alert.hide()
		}, delay);
	}

	var lastID = 0;
	function chatListFunction() {
		var fromID = "${userId}";
		var toID = "${toId}";
		var csrfHN = "${_csrf.headerName}";
		var csrfTV = "${_csrf.token}";
		$.ajax({
			type : "POST",
			url : "/chat/chatList",
			data : {
				fromID : fromID,
				toID : toID
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHN, csrfTV);
			},
			
			success : function(data) {
				if (data == "")
					return;
				$('#chatList').html('');
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for (var i = 0; i < result.length; i++) {
					if (result[i][0].value == fromID) {
						result[i][0].value = '나';
					}
					addChat(result[i][0].value, result[i][2].value,
							result[i][3].value);
				}
				// 가장 마지막으로 전달 받은 ID가 저장이 된다.
				lastID = Number(parsed.last);

			}
		});

	}
	
	img = new Image();
	img.onload; 
	img.src = "/resources/img/icon.png";
	
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

	function getUnread() {
		var csrfHN = "${_csrf.headerName}";
		var csrfTV = "${_csrf.token}";
		$.ajax({
			type : "POST",
			url : "/chat/unread",
			data : {
			userID : "${userId}",

			},beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHN, csrfTV);
			},
			success : function(result) {
				//  0을 받으면 에러, 1이상을 받으면 정상처리
				if (result >= 1) {
					showUnread(result);
				} else {
					// 0이 입력받을 때 공백 처리
					showUnread('');
				}
			}
		});
	}
	// 몇 초 간격으로 새로운 메시지가 온지 가져오는 것
	function getInfiniteChat() {
		setInterval(function() {
//			$('#chatList').empty();
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

