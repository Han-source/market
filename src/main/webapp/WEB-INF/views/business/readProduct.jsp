<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid"></div>
<!-- DataTales Example -->
<div class="card shadow mb-4">
   <div class="card-body">
      <div class="form-group">
      	  <%@include file="./include/attachFileManagement.jsp" %>
         <%@ include file="./include/productCommon.jsp" %>
         <!-- 공통적 속성인 실 내용들은 postCommon.jsp를 만들어서 보내버렸음 -->

         <sec:authentication property="principal" var ="customUser"/>
         <sec:authorize access="isAuthenticated()">
            <c:if test="${customUser.curUser.userId eq post.writer.userId}">
               <button data-oper='modify' class="btn btn-primary">수정</button>
            </c:if>
         </sec:authorize>
         
         <button data-oper='list' class="btn btn-secondary">목록</button>
          <sec:authorize access="isAuthenticated()">
            <c:if test="${customUser.curUser.userId ne post.writer.userId}">
               <button data-oper='chat' class="btn btn-secondary">채팅하기</button>
               <c:if test="${child ne 7}">
               <button data-oper='nego' class="btn btn-secondary">가격제안</button>
               </c:if>
    		   <button id='cart' class="btn btn-secondary">장바구니 담기</button>
    		   <button id='trade_kakao' class="btn btn-secondary">카카오페이로 결제하기</button>
                 <c:if test="${child == 7}">
	            	<button id ="btnAuction" type="button" class="btn btn-primary">경매 참여</button>
	            </c:if>
            </c:if>
         </sec:authorize>
         
         
         <!--  경매 타이머 구역 -->
         <c:if test="${child == 7}">
         <h2 id="auctionTimer"></h2>
         </c:if>
         <br>
         
         <c:if test="${child == 7}">
         <label>구매자 아이디 <input class="form-control"  value='${auctionMaxPrice.buyerId}' style='width:150px; height:50px'  readonly> </label>
         <label>경매 최고 가격 <input class="form-control"  value='${auctionMaxPrice.auctionCurrentPrice}' style='width:150px; height:50px'  readonly> </label>

          <hr size="10px">
          <c:forEach items="${auctionParty}" var="party">
               <label>구매자 아이디 <input class="form-control"  value='${party.buyerId}' style='width:150px; height:50px'  readonly> </label>
            <label>경매 가격 <input class="form-control"  value='${party.auctionCurrentPrice}원' style='width:150px; height:50px' readonly></label>
            <br>
            </c:forEach>
         </c:if>
         
         
         
         <form id="frmChat" action="/chat/chatting" method="get">
            <input type="hidden" id="toId" name="toId" value="${post.writer.userId}">
         </form>

         <form id='frmOper' action="/post/modifyPost" method="get">
            <input type="hidden" name="boardId" value="${boardId}">
            <input type="hidden" name="child" value="${child}">
            <input type="hidden" id="postId" name="postId" value="${post.id}">
         </form>
         
         <form id='frmCart' action="/post/insertShoppingCart" method="post">
            <input type="hidden" id="productId" name="productId" value="${post.id}">
            <input type="hidden" name="boardId" value="${boardId}">
			<input type="hidden" name="child" value="${child}">
            <input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
         </form>
         
      </div>
         <div id="modalProductNego" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
               <div class="modal-dialog">
                  <div class="modal-content">
                     <div class="modal-header" style="text-align: center;">
                        <h4 class="modal-title" id="myModalLabel" align="center" style="margin: 0 auto;">제안할 가격을 적어주세요</h4>
                     </div>
                     <!-- End of modal-header -->
                     <div class="modal-body" id = "modalProductNegoBody" style=" text-align: center;">
                        <label>제시가격</label>
                        <input class="form-control" name='negoPrice' id="negoPrice" value=''>
                     </div>
                     <div class="modal-footer">
                        <button id='btnSubmitNego' type="button" class="btn btn-default" onclick="negoSubmitFunction();">전송</button>                        
                        <button id='btnCloseModal' type="button" class="btn btn-default">취소</button>                        
                     </div>
                  </div>
               </div>
            </div>
      
            <!-- 상품 등록 관련 모달 -->
            <div id="AuctionModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
               <div class="modal-dialog">
                  <div class="modal-content">
                     <div class="modal-header" style="text-align: center;">
                        <h4 class="modal-title" id="auctuionModalLabel" align="center" style="margin: 0 auto;">경매 금액을 입력해주세요.</h4>
                     </div>
                     <!-- End of modal-header -->
                     <form id="frmAuction" action="/business/readProduct" method="post">
                        <div class="modal-body" id = "modalAuctionBody" style=" text-align: center;">
                           <label>아이디</label>
                           <input class="form-control" name='buyerId' id="buyerId" value='${userId}'>
                           <label>경매가격</label>
                           <input class="form-control" name='auctionCurrentPrice' id="auctionCurrentPrice" >
                        </div>
                        <div class="modal-footer">
                        
                           <button id='btnPriceModal' type="button" class="btn btn-primary">입찰</button>
                           <button id='btnCloseModal' type="button" class="btn btn-default">취소</button>
                           <input type="hidden" id="sellerId" name="sellerId" value="${post.writer.userId}">
                           <input type="hidden" name="boardId" value="${boardId}">
                           <input type="hidden" name="child" value="${child}">
                           <input type="hidden" id="postId" name="postId" value="${post.id}">
                           <input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>                        
                        </div>
                     </form>
                  </div>
               </div>
            </div>
            
            <div id="modalShopCart" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
               <div class="modal-dialog">
                  <div class="modal-content">
                     <div class="modal-header" style="text-align: center;">
                        <h4 class="modal-title" id="myModalLabel" align="center" style="margin: 0 auto;">해당 상품이 장바구니에 담겼습니다</h4>
                     </div>
                     <!-- End of modal-header -->
                     <div class="modal-body" id = "modalProductNegoBody" style=" text-align: center;">
                        <label>제시가격</label>
                        <input class="form-control" name='negoPrice' id="negoPrice" value=''>
                     </div>
                     <div class="modal-footer">
                        <button id='btnSubmitNego' type="button" class="btn btn-default" onclick="negoSubmitFunction();">전송</button>                        
                        <button id='btnCloseModal' type="button" class="btn btn-default">취소</button>                        
                     </div>
                  </div>
               </div>
            </div>  

   </div>
</div>

<!-- /.container-fluid -->

<!-- End of Main Content -->
<%@include file="../includes/footer.jsp"%>

<script type="text/javascript"> // El에 JSP가 만들어져야 돌아감 ↓
   $(document).ready(function() {
	   if("${child == 7}"){
			makeChart();
	   }
	   $("#trade_kakao").click(function () {
	         var IMP = window.IMP; // 생략가능
	         IMP.init('imp24192490');
	         // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	         // i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
	         IMP.request_pay({
	         pg : 'kakaopay',         /*
	         
	         */
	         merchant_uid: 'merchant_' + new Date().getTime(),
	         
	         name: '주문명:결제테스트',
	         //결제창에서 보여질 이름
	         amount: 10000,
	         //가격
	         buyer_email: 'iamport@siot.do',
	         buyer_name: '구매자이름',
	         buyer_tel: '010-1234-5678',
	         buyer_addr: '서울특별시 강남구 삼성동',
	         buyer_postcode: '123-456',
	         m_redirect_url: 'http://localhost:8080/business/complete'
	         /*
	         모바일 결제시,
	         결제가 끝나고 랜딩되는 URL을 지정
	         (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
	         */
	         }, function (rsp) {
	         console.log(rsp);
	         if (rsp.success) {
	         var msg = '결제가 완료되었습니다.';
	         msg += '고유ID : ' + rsp.imp_uid;
	         msg += '상점 거래ID : ' + rsp.merchant_uid;
	         msg += '결제 금액 : ' + rsp.paid_amount;
	         msg += '카드 승인번호 : ' + rsp.apply_num;
	         } else {
	         var msg = '결제에 실패하였습니다.';
	         msg += '에러내용 : ' + rsp.error_msg;
	         }
	         alert(msg);
	         });
	         });

	   
      adjustCRUDAtAttach('조회');
      negoSubmitFunction();
      var i = 0;
      <c:forEach var="attachVoInStr" items="${post.attachListInGson}" >
	      var img = 'img';
	      var param = img + i;
         appendUploadUl('<c:out value="${attachVoInStr}" />', param);
         i += 1;
      </c:forEach>
      
      // 경매 버튼 클릭시 모달 활성화
      $("#btnAuction").on("click", function(e) {
         $("#AuctionModal").modal("show");               
      });
      
	   // 경매 입찰시 최종 입찰 가격보다 더 높은 가격으로만 입찰 가능.
		$("#btnPriceModal").on("click", function(e) {
			var a = $("#auctionCurrentPrice").val() 
			if(parseInt("${maxBidPrice}") > parseInt($("#auctionCurrentPrice").val())){
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
      
      $("button[data-oper='list']").on("click", function() {
         $("#frmOper").find("#postId").remove();
         $("#frmOper").attr("action", "/post/listBySearch").submit();
      });
      
      $("button[data-oper='chat']").on("click", function() {
         $("#frmChat").attr("action", "/chat/chatting");
         frmChat.submit();
      });

      //장바구니 담기
      $("#cart").on("click", function() {
    	  if("${checkShoppingCart}" == "0"){
	          $("#frmCart").attr("action", "/business/insertShoppingCart");
	          $("#frmCart").submit();
	          alert('상품이 장바구니에 담겼습니다')
    	  }else {
    		  alert('이미 상품이 담겨있습니다')
    		  return;
    	  }
       });
      
      //가격제안 버튼을 눌렀을때 모달창 보여주기.      
      $("button[data-oper='nego']").on("click", function() {
         $("#modalProductNego").modal("show");
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
      if (chatContent != ""){
         chatContent += "<button type='button' id='negoAgree' onclick='updateProductPrice(" + $('#negoPrice').val() + ");'>수락</button>";
         chatContent += "<button type='button' id='negoDisAgree' onclick='disAgree();'>거절</button>"
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
	      if (auctionCurrentPrice == null){
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
	
</script>

<!-- 경매 카운트 기능 -->
<script>
const countDownTimer = function (id, date) {
   var _vDate = new Date(date); // 전달 받은 일자
   var _second = 1000; var _minute = _second * 60;
   var _hour = _minute * 60; var _day = _hour * 24;
   var timer;
   
   function showRemaining() {
      var now = new Date();
      var distDt = _vDate - now;
      if (distDt < 0) { 
         clearInterval(timer);
         document.getElementById(id).textContent = '해당 경매가 종료 되었습니다!';
         $('#btnAuction').hide();
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
   
   </script>

 	<canvas id="lookChartProduct" style="width:100vh ; height=100vw">
	</canvas>



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
			  data: {
			      labels:buyer,
			      datasets: [{
			          label: "입찰 금액",
			          borderColor: 'rgb(204, 102, 255)',
			          data: price
			      }]
			  },
			options : {
				responsive: false,
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
<script>
   
</script>