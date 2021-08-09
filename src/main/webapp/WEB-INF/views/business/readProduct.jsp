<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
		<section class="product_wrap">
			<div class="product_img">
				<div class="product_imgs">
					<%@include file="./include/attachFileManagement.jsp"%>
				</div>
			</div>
					<div class="product_content">
		                <h2 class = "product_title">${post.title}</h2>
		                <h3 class = "product_price">
		                	<c:choose>
						        <c:when test="${negoBuyer.discountPrice eq 0}"> 
						            ${product.productPrice}원
						        </c:when>
						        
						        <c:when test="${negoBuyer.auctionCurrentPrice ne 0}"> 
						            ${product.productPrice}원
						        </c:when>
						        
						        <c:otherwise> 
						             ${negoBuyer.discountPrice}원
						        </c:otherwise>
						    </c:choose>	
		                </h3>
		                <div class = "product_detail">
		                    <span>상품설명<br>
		                    ${post.content}</span>
		                </div>    
		            <div class="product_button">
		                <button type="button" data-oper='list' class="product_chat">
		                    <span>목록</span>
		                    <i class="fas fa-comment-dots"></i>
		                </button>
		                <sec:authentication property="principal" var ="customUser"/>
		                <sec:authorize access="isAuthenticated()">
							<c:if test="${customUser.curUser.userId ne post.writer.userId}">
								<button data-oper='chat' class="product_chat">
									<span>채팅하기</span>
									<i class="fas fa-comment-dots"></i>
								</button>
								<c:if test="${child ne 7}">
									<button data-oper='nego' class="product_chat">
										<span>가격제안</span>
									</button>
								</c:if>
								<button id='cart' class="product_like">
									<span>장바구니 담기</span>
									<i class="fas fa-heart"></i>
									
								</button>
								<c:if test="${child != 7}">
								<button id='payment' class="btn btn-secondary">
									<span>결제하기</span>
								</button>
								</c:if>
								
								<button id='autionpayment' class="btn btn-secondary">
									<span>결제하기</span>
								</button>
								
								<c:if test="${child == 7}">
									<button id="btnAuction" type="button" class="product_chat">
										<span>경매참여</span>
									</button>
								</c:if>
							</c:if>
							<sec:authentication property="principal" var="customUser" />
							<c:if test="${customUser.curUser.userId eq post.writer.userId}">
								<button data-oper='modify' class="product_chat">
									<span>수정</span>
								</button>
							</c:if>			
						</sec:authorize>
		            </div>
		        </div>
				
		</section>


			<!--  경매 타이머 구역 -->
			<c:if test="${child == 7}">
				남은 경매 시간
				<h2 id="auctionTimer"></h2>
					<label>최고가 입찰자 <input class="form-control"
						value='${maxBidPrice.buyerId}'
						style='width: 150px; height: 50px' readonly>
					</label>
					<label>현재 가격 <input class="form-control"
						value='${maxBidPrice.auctionCurrentPrice}'
						style='width: 150px; height: 50px' readonly>
					</label>
					<br>

				<hr size="10px">
				<c:forEach items="${auctionParty}" var="party">
					<label>구매자 아이디 <input class="form-control"
						value='${party.buyerId}' style='width: 150px; height: 50px'
						readonly>
					</label>
					<label>입찰 가격 <input class="form-control"
						value='${party.auctionCurrentPrice}원'
						style='width: 150px; height: 50px' readonly></label>
					<br>
				</c:forEach>
				<canvas id="lookChartProduct" style="width: 100vh;">
			 </canvas>
			</c:if>



			<form id="frmChat" action="/chat/chatting" method="get">
				<input type="hidden" id="toId" name="toId"
					value="${post.writer.userId}">
			</form>

			<form id='frmOper' action="/post/modifyPost" method="get">
				<input type="hidden" name="boardId" value="${boardId}"> 
				<input type="hidden" name="child" value="${child}"> 
				<input type="hidden" id="postId" name="postId" value="${post.id}">
			</form>

			<form id='frmCart' action="/post/insertShoppingCart" method="post">
				<input type="hidden" id="productId" name="productId"
					value="${post.id}"> <input type="hidden" name="boardId"
					value="${boardId}"> <input type="hidden" name="child"
					value="${child}"> <input type='hidden'
					name='${_csrf.parameterName}' value='${_csrf.token}'>
			</form>
			
            <form id="frmPayment" action="/business/payment" method="get">
	            <input type="hidden" name="boardId" value="${boardId}">
	            <input type="hidden" name="child" value="${child}">
	            <input type="hidden" name="productId" value="${post.id}"> 
            </form>   
            
            <form id="frmAutionpayment" action="/business/autionPayment" method="get">
	            <input type="hidden" name="boardId" value="${boardId}">
	            <input type="hidden" name="child" value="${child}">
	            <input type="hidden" name="productId" value="${post.id}"> 
            </form>   
            

		<div id="modalProductNego" class="modal fade" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header" style="text-align: center;">
						<h4 class="modal-title" id="myModalLabel" align="center"
							style="margin: 0 auto;">제안할 가격을 적어주세요</h4>
					</div>
					<!-- End of modal-header -->
					<div class="modal-body" id="modalProductNegoBody"
						style="text-align: center;">
						<label>제시가격</label> <input class="form-control" name='negoPrice'
							id="negoPrice" value=''>
					</div>
					<div class="modal-footer">
						<button id='btnSubmitNego' type="button" class="btn btn-default"
							onclick="negoSubmitFunction();">전송</button>
						<button id='btnCloseModal' type="button" class="btn btn-default">취소</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 상품 등록 관련 모달 -->
		<div id="AuctionModal" class="modal fade" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header" style="text-align: center;">
						<h4 class="modal-title" id="auctuionModalLabel" align="center"
							style="margin: 0 auto;">경매 금액을 입력해주세요.</h4>
					</div>
					<!-- End of modal-header -->
					<form id="frmAuction" action="/business/readProduct" method="post">
						<div class="modal-body" id="modalAuctionBody"
							style="text-align: center;">
							<label>아이디</label> <input class="form-control" name='buyerId'
								id="buyerId" value='${userId}'> <label>경매가격</label> <input
								class="form-control" name='auctionCurrentPrice'
								id="auctionCurrentPrice">
						</div>
						<div class="modal-footer">

							<button id='btnPriceModal' type="button" class="btn btn-primary">입찰</button>
							<button id='btnCloseModal' type="button" class="btn btn-default">취소</button>
							<input type="hidden" id="sellerId" name="sellerId"
								value="${post.writer.userId}"> <input type="hidden"
								name="boardId" value="${boardId}"> <input type="hidden"
								name="child" value="${child}"> <input type="hidden"
								id="postId" name="postId" value="${post.id}"> <input
								type='hidden' name='${_csrf.parameterName}'
								value='${_csrf.token}'>
						</div>
					</form>
				</div>
			</div>
		</div>

		<div id="modalShopCart" class="modal fade" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header" style="text-align: center;">
						<h4 class="modal-title" id="myModalLabel" align="center"
							style="margin: 0 auto;">해당 상품이 장바구니에 담겼습니다</h4>
					</div>
					<!-- End of modal-header -->
					<div class="modal-body" id="modalProductNegoBody"
						style="text-align: center;">
						<label>제시가격</label> <input class="form-control" name='negoPrice'
							id="negoPrice" value=''>
					</div>
					<div class="modal-footer">
						<button id='btnSubmitNego' type="button" class="btn btn-default"
							onclick="negoSubmitFunction();">전송</button>
						<button id='btnCloseModal' type="button" class="btn btn-default">취소</button>
					</div>
				</div>
			</div>
		</div>


<!-- /.container-fluid -->

<!-- End of Main Content -->
<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		$('#autionpayment').hide();
		showPurchaseWhenAutionEnd();
		if ("${child}" == "7") {
			makeChart();
		}
			adjustCRUDAtAttach('조회');
			negoSubmitFunction();
			var i = 0;
			<c:forEach var="attachVoInStr" items="${post.attachListInGson}" >
				var img = 'img';
				var param = img + i;
				appendUploadUl('<c:out value="${attachVoInStr}" />',param);
				i += 1;
			</c:forEach>
			// 경매 버튼 클릭시 모달 활성화
			$("#btnAuction").on("click", function(e) {
				$("#AuctionModal").modal("show");
			});
			// 경매 입찰시 최종 입찰 가격보다 더 높은 가격으로만 입찰 가능.
			$("#btnPriceModal").on("click", function(e) {
				var a = $("#auctionCurrentPrice").val()
				if (parseInt("${maxBidPrice.auctionCurrentPrice}") > parseInt($("#auctionCurrentPrice").val())) {
					alert("입찰에 실패하였습니다.")
				} else {
					alert("입찰에 성공하였습니다.");
					$("#frmAuction").submit();
					return;
				}
				$("#AuctionModal").modal("hide");
			});
			//EL이 표현한 LIST 출력 양식, 그래서 첨부파일이 안보임, El은 Server에서 돌아감
			//postCommon에 있는 함수를 부를 것
			$("button[data-oper='modify']").on("click", function() {
				$("#frmOper").submit();
			});
			$("button[data-oper='list']").on( "click", function() {
				$("#frmOper").find("#postId").remove();
				$("#frmOper").attr("action",
						"/post/listBySearch").submit();
			});
			//결제하기 페이지 이동
	        $("#payment").on("click", function() {
	             $("#frmPayment").attr("action", "/business/payment");
	             frmPayment.submit();
	        });
			
			//경매 결제 페이지로 이동
	        $("#autionpayment").on("click", function() {
	             $("#frmAutionpayment").attr("action", "/business/autionPayment");
	             $("#frmAutionpayment").submit();
	        });
	        
			
			$("button[data-oper='chat']").on("click", function() {
				window.open("../chat/chatting?toId=${post.writer.userId}", "_blank", "width=400,height=500,left=1200,top=10");
			});
			//장바구니 담기
			$("#cart").on("click", function() {
				if ("${checkShoppingCart}" == "0") {
					$("#frmCart").attr("action","/business/insertShoppingCart");
					$("#frmCart").submit();
					alert('상품이 장바구니에 담겼습니다')
				} else {
					alert('이미 상품이 담겨있습니다')
					return;
				}
			});
			//가격제안 버튼을 눌렀을때 모달창 보여주기.      
			$("button[data-oper='nego']").on("click", function() {
				$("#modalProductNego").modal("show");
			});
			$("#btnSubmitNego").on("click", function(e) {
				$("#modalProductNego").modal("hide");
			});
			//모달창을 닫기 버튼을 누르면 실행
			$("#btnCloseModal").on("click", function(e) {
				$("#modalProductNego").modal("hide");
			});
		});
	//전송 버튼 눌렀을때 실행할 함수.
	function negoSubmitFunction() {
		var fromID = "${userId}";
		var toID = "${post.writer.userId}";
		var chatContent = $('#negoPrice').val();
		var boardId = "${boardId}";
		var child = "${child}";
		var productId = document.getElementById("postId").value;
		if (chatContent != "") {
			chatContent += "원에 제안! <br>상품의 거래제안이 도착했어요 <br>";
			chatContent += "<a href='/business/readProduct?boardId=" + boardId +"&child=" + child + "&productId=" + productId + "' target='_blank'>내 상품 보러가기</a>";
			chatContent += "<div  style='float:left;' ><button type='button' id='negoAgree' style='width:80px; margin-right: 20px; margin-left: 15px; background-color: #E0F8F1' onclick='updateProductPrice("
					+ $('#negoPrice').val() + ");'>수락</button>";
			chatContent += "<button type='button' id='negoDisAgree' style='width:80px; background-color: #F6CEEC'' onclick='disAgree();'>거절</button></div>"
			chatContent += "<input type='hidden' id='postId' value='${post.id}'/>";
		}
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
			}
		});
		// 메시지를 보냈으니 content의 값을 비워준다.
		$('#negoPrice').val('');
	}
	function autionBid() {
		var userID = "${userId}";
		var auctionCurrentPrice = $("#auctionCurrentPrice").val();
		var boardId = "${boardId}"
		var child = "${child}"
		var postId = "${post.id}"
		var sellerId = "${post.writer.userId}"
		if (auctionCurrentPrice == null) {
			alert('가격을 입력해 주세요');
			return;
		}
		$.ajax({
			type : "GET",
			url : "/business/readProduct",
			data : {
				userID : userID,
				auctionCurrentPrice : auctionCurrentPrice,
				boardId : boardId,
				child : child,
				postId : postId,
				sellerId : sellerId
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHN, csrfTV);
			},
			success : function(result) {
			}
		});
		// 메시지를 보냈으니 content의 값을 비워준다.
		$("#auctionCurrentPrice").val();
	}
	
	function showPurchaseWhenAutionEnd() {
	
	}
</script>

<!-- 경매 카운트 기능 -->
<script>
if("${child}" == "7"){
	const countDownTimer = function(id, date) {
		var _vDate = new Date(date); // 전달 받은 일자
		var _second = 1000;
		var _minute = _second * 60;
		var _hour = _minute * 60;
		var _day = _hour * 24;
		var timer;
		function showRemaining() {
			var now = new Date();
			var distDt = _vDate - now;
			if (distDt < 0) {
				clearInterval(timer);
				document.getElementById(id).textContent = '해당 경매가 종료 되었습니다!';
				$('#btnAuction').hide();
				if("${child}" == "7" && "${maxBidPrice.buyerId}" == "${userId}")
				$('#autionpayment').show();
				return;
			}
			var days = Math.floor(distDt / _day);
			var hours = Math.floor((distDt % _day) / _hour);
			var minutes = Math.floor((distDt % _hour) / _minute);
			var seconds = Math.floor((distDt % _minute) / _second);
			document.getElementById(id).textContent = days + '일 ';
			document.getElementById(id).textContent += hours + '시간 ';
			document.getElementById(id).textContent += minutes + '분 ';
			document.getElementById(id).textContent += seconds + '초';
		}
		timer = setInterval(showRemaining, 100);
	}
	var dateObj = new Date();
	dateObj.setDate(dateObj.getDate() + 1);
	countDownTimer('auctionTimer', '${condition.auctionEndDate}'); // 2024년 4월 1일까지, 시간을 표시하려면 01:00 AM과 같은 형식을 사용한다.
}
</script>

<!--DB와 Chart 값을 연동하여 경매에 입찰할때마다 입찰자, 입찰금액이 Update 가능  -->
<script>
	function makeChart() {
		var ctx = document.getElementById("lookChartProduct");
		var buyer = new Array();
		var price = new Array();
		<c:forEach items="${tc}" var="item" varStatus="status">
		buyer.push("${item.buyerId}");
		price.push("${item.auctionCurrentPrice}");
		</c:forEach>
		
		var chart = new Chart(ctx, {
			type : 'line',
			data : {
				labels : buyer,
				datasets : [ {
					label : "입찰 금액",
					borderColor : 'rgb(204, 102, 255)',
					data : price
				} ]	
			},
			options : {
				responsive : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				}
			}
		});
	}
</script>