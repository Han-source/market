/**
 CallBack 함수 : 특정 Event에 대응
 */
 
/** 함수 정의 영역 */
var chatService = (function() {
	//메세지 리스트 띄우는 함수
	function list(fromID, toID){
		$.ajax({
			type : "POST",
			url : "/chat/chatList",
			data : {
				fromID : fromID,
				toID : toID
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
						if(result[i][2].value.includes('button')){
							result[i][2].value = '거래제안을 보냈습니다';
							addChat(result[i][0].value, result[i][2].value,
									result[i][3].value);
						}else{
							console.log(result[i][2].value);
							addChat(result[i][0].value, result[i][2].value,
									result[i][3].value);
						}						
					}else{
						addChat(result[i][0].value, result[i][2].value,
								result[i][3].value);
					}
				}
				// 가장 마지막으로 전달 받은 ID가 저장이 된다.
				lastID = Number(parsed.last);
			}
		});
	}
	
	//메세지 전송함수
	function submit(fromID, toID, chatContent) {
		$.ajax({
			type : "POST",
			url : "/chat/chatting",
			data : {
				fromID : fromID,
				toID : toID,
				chatContent : chatContent,
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
	
	//읽지 않은 메세지 가져오기
	function unread(fromID) {
		$.ajax({
			type : "POST",
			url : "/chat/unread",
			data : {
			userID : fromID,
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
	
	//가격 제안을 한것에 대해 가격을 올려주는 함수
	function productPrice(fromID, toID, negoPrice, productId, agree) {
		$.ajax({
			type : "POST",
			url : "/chat/agreeNegoSug",
			data : {
				fromID : fromID,
				toID : toID,
				chatContent : negoPrice,
				postId : productId,
				agree : agree,
			},
			
			success : function() {
				alert('가격제안이 수락되었습니다')
			}
		});
		// 메시지를 보냈으니 content의 값을 비워준다.
		$('#negoPrice').val('');
	}
	
	//수락을 눌렀을때 실행되는 함수
	function agree(fromID, toID, chatContent, postId) {
		$.ajax({
			type : "POST",
			url : "/chat/chatting",
			data : {
				fromID : fromID,
				toID : toID,
				chatContent : chatContent,
				postId : postId,
			},
			success : function(result) {
			}
		});
		// 메시지를 보냈으니 content의 값을 비워준다.
		$('#negoPrice').val('');
	}
	
	//거절을 눌렀을 때 실행되는 함수
	function disAgree(fromID, toID, chatContent, postId) {
		$.ajax({
			type : "POST",
			url : "/chat/chatting",
			data : {
				fromID : fromID,
				toID : toID,
				chatContent : chatContent,
				postId : postId,
			},
			success : function(result) {
			}
		});
		// 메시지를 보냈으니 content의 값을 비워준다.
		$('#negoPrice').val('');
	}

			
	//채팅 처리용 함수들
	//앞이 chatting.jsp 뒤가 실행될 함수
	return {
		chatSubmit : submit,
		chatList : list,
		chatUnread : unread,
		negoProductPrice : productPrice,
		agreeFunction : agree,
		disAgreeFunction : disAgree
		};
})();