<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/resources/js/bootstrap2.js"></script>
<link rel="stylesheet" href="/resources/css/bootstrap2.css">
<link rel="stylesheet" href="/resources/css/custom.css">	

<title>Insert title here</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/">Fleax마켓</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="/">메인</a></li>
				<li ><a href="/chat/chatBox">메시지함<span id="unread" class="label label-info"></span></a></li>
			</ul>
			
		</div>
	</nav>


	
	<div class="container">
		<table class="table" style="margin: 0 auto;">
			<thead>
				<tr>
					<th><h4>주고받은 메시지 목록</h4></th>
				</tr>
			</thead>
			<div style="overflow-y: auto; width: 100%; max-height: 450px;">
				<table class="table table-bordered table-hover"
					style="text-align: center; border: 1px solid #dddddd; margin: 0 auto;">
					<tbody id="boxTable">
					</tbody>
				</table>
			</div>
		</table>
	</div>
</body>


<script type="text/javascript">
	// 기본적으로 메시지를 읽지않은 함수를 반복적으로 실행시키기
	$(document).ready(function(){
				getUnread();
				getInfiniteUnread();
				chatBoxFunction();
				getInfiniteBox();
			});
</script>
<script type="text/javascript">

	function chatBoxFunction() {
		// 로그인한 사용자 변수로 받기
		var userID = "${userId}"
		var csrfHN = "${_csrf.headerName}";
		var csrfTV = "${_csrf.token}";
		$.ajax({
			type : "POST",
			url : "/chat/chatBox",
			data : {
				userID : userID,

			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHN, csrfTV);
			},
			success : function(data) {
				//만약 결과 데이터가 비어있다면
				if (data == "")
					return;
				$('#boxTable').html('');
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for (var i = 0; i < result.length; i++) {
					if (result[i][0].value == userID) {
						result[i][0].value = result[i][1].value;
					} else {
						result[i][1].value = result[i][0].value;
					}
					//addBox는 실제로 우리 화면에 각각의 메시지 목록을 출력해주는 함수
					addBox(result[i][0].value, result[i][1].value,
							result[i][2].value, result[i][3].value);
				}
			}
		});
	}
	// 메시지함 같은 경우에는 누가 메시지를 보냈고 최근에 어떠한 메시지를 주고 받았는지 보여주도록
	// 만들어주는 함수
	function addBox(lastID, toID, chatContent, chatTime) {
		// 해당 메시지를 클릭했을 경우 메시지를 주고 받은 채팅방으로 이동
		$('#boxTable').append(
				'<tr onclick="location.href=\'chatting?toId='
						+ toID + '\'">'
						+ '<td style="width: 150px;"><h5>' + lastID
						+ '</h5></td>' + '<td>' + '<h5>' + chatContent
						+ '</h5>' + '<div class="pull-right">' + chatTime
						+ '</div>' + '</td>' + '</tr>');
	}

	function getUnread() {
		var userID = "${userId}"
		var csrfHN = "${_csrf.headerName}";
		var csrfTV = "${_csrf.token}";
		$.ajax({
			type : "POST",
			url : "/chat/unread",
			data : {
				userID : userID,

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
	// 반복적으로 서버한테 일정 주기 마다 자신이 읽지 않은 메시지 갯수를 요청하는 함수
	function getInfiniteUnread(){
		setInterval(function(){		
			getUnread();			
		}, 1000);
	}
	// unread라는 id값을 가진 원소 내부 값을 result로 담아주기.
	function showUnread(result){
		$('#unread').html(result);
	}
	// 사용자의 메시지함을 갱신하는 함수
	function getInfiniteBox() {
		setInterval(function() {
			chatBoxFunction();
		}, 1000);
	}
</script>
</html>