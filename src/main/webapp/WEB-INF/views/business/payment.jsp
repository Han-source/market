<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<jsp:useBean id="tablePrinter"
   class="www.dream.com.framework.printer.TablePrinter" />
<style>
#sliderBody{float: left; width:20%; height: 100px; padding:0px; margin-right:1%; } 
#header1{ height: 100px; border-bottom: 1px solid dimgrey; box-sizing: border-box; text-align: center; line-height: 100px; font-size: 1.5rem; }
.slider {
   float: left; width:50%; padding:10px; height: 100%; overflow: hidden; 
}
</style>
<body>
       <!-- Header Info Begin -->
    <div class="header-info">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3 text-center text-lg-center">
                    <div class="header-item ">
                        <img src="/resources/img/icons/delivery.png" alt="">
                        <p>빠른 배송!</p>
                    </div>
                </div>
                <div class="col-md-3 text-center text-lg-center">
                    <div class="header-item">
                        <img src="/resources/img/icons/voucher.png" alt="">
                        <p>안전 거래!</p>
                    </div>
                </div>
                <div class="col-md-3 text-center text-lg-center">
                    <div class="header-item">
                    <img src="/resources/img/icons/sales.png" alt="">
                    <p>판매자에게 할인된 금액으로 요청해보세요!</p>
                </div>
                </div>
            </div>
        </div>
    </div>
    <!--상품 결제 header -->
    <section class="page-add">
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <div class="page-breadcrumb">
                        <h2>상품 결제</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 상품 결제 정보 section  -->
    <section class="cart-total-page spad">
        <div class="container">
        <!--  테스트를 위한 주석 처리 -->
<!--             <form action="#" class="checkout-form"> -->
                <div class="row">
                    <div class="col-lg-12">
                        <h3>주문 정보</h3>
                    </div>
                     <div class="col-lg-9">
                        <div class="row">
                            <div class="col-lg-2">
                                <p class="in-name">수령인*</p>
                            </div>
                            <div class="col-lg-3">
                                <input type="text" id="recipient" name="buyerName" placeholder="이름">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2">
                                <p class="in-name">배송지 주소*</p>
                            </div>
                            <div class="col-lg-10">
                                <input type="text" id="buyerForAddress" name="address" placeholder="배송지를 입력하세요.">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2">
                                <p class="in-name">휴대폰 번호*</p>
                            </div>
                            <div class="col-lg-10">
                                <input type="number" id="buyerForphonNum" name="phonNum" placeholder="휴대폰 번호를 입력해주세요.">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2">
                                <p class="in-name">예비 연락처*</p>
                            </div>
                            <div class="col-lg-10">
                                <input type="number" id="buyerForReserveNum" name="reserveNum" placeholder="예비 연락처를 입력해주세요.">
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-lg-2">
                                <p class="in-name">배송 메모 *</p>
                            </div>
                            <div class="col-lg-10">
                                <input type="text" id="buyerForAbsentMsg" name="absentMsg" placeholder="배송 메모를 입력하세요.">
                            </div>
                        </div>                       
                    </div>
                    <div class="col-lg-3">
                        <div class="order-table">
                            <div class="cart-item">
                                <span>판매자 ID</span>
                                 <p>${post.writer.userId}</p>
<!--                                 <p class="product-name" value=""></p> -->
                            </div>
                            <div class="cart-item">
                                <span>원 가격</span>
                                <p>${product.productPrice}원</p>
                            </div>
                            <div class="cart-item">
                            <c:if test="${child != 7}">
                               <c:if test="${negoBuyer.discountPrice != null}">
                                   <span>할인이 적용된 가격</span>
                                   <p>${negoBuyer.discountPrice}원</p>
                               </c:if>
                            </c:if>
                            
                            </div>                       
                            <div class="cart-total">
                                <span>최종 가격</span>
                                <c:choose>
						        <c:when test="${negoBuyer eq null}"> 
						            <p id="finalPrice">${product.productPrice}"</p>
						        </c:when>
						        <c:otherwise> 
						             <p id="finalPrice">${negoBuyer.discountPrice}</p>
						        </c:otherwise>
						    </c:choose>	
                            </div>                        
                            
                       
                            
                        </div>
                    </div>
                </div>
               <div class="row">
                    <div class="col-lg-12">
                        <div class="payment-method">
                            <h3>상품 정보</h3>
                        </div>
                 
                    </div>
                </div>
                
                
                <div class="row">
                    <div class="col-lg-12">
                        <div class="payment-method">
                            <h3>결제 방식</h3>
                             <form id="frmPayment" method="post" action="/business/payment">       
	                            <button type="button" id="kakao_trade">결제 하기</button>
	                            <input type="hidden" name="productFinalPrice" value="${product.productPrice}">
	                            <input type="hidden" name="sellerId" value="${post.writer.userId}">
	                            <input type="hidden" name="buyerId" value="${buyerId}">
	                            <input type="hidden" name="boardId" value="${boardId}">
	                    	    <input type="hidden" name="child" value="${child}">
	                            <input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
                            </form>
                        </div>
                    </div>
                </div>
<!--             </form> -->
        </div>
    </section>
 </body>




<%@ include file="../includes/footer.jsp"%>
<script type="text/javascript">
$('#kakao_trade').click(function () {
    // getter
    var IMP = window.IMP;
    IMP.init('imp24192490');
    var money = document.getElementById('finalPrice').innerHTML;
    var csrfHN = "${_csrf.headerName}";
	var csrfTV = "${_csrf.token}";
	// 로그인한 사용자 정보
	var address;
	var phoneNum;
	var mobileNum;
	<c:forEach items="${loginPersonInfo}" var="listContactPoint" varStatus="status">
		<c:forEach items="listContactPoint" var="info" varStatus="sta">
			address = "${loginPersonInfo[status.index].listContactPoint[0].info}" ;
			phoneNum = "${loginPersonInfo[status.index].listContactPoint[1].info}";
			mobileNum = "${loginPersonInfo[status.index].listContactPoint[2].info}";
		</c:forEach>
	</c:forEach>
	//구매하면 보낼 곳의 정보, 주소, 폰번호, 예비번호, 부재시 메시지를 받아야함.
	var buyerForAddress = $('#buyerForAddress').val();
	var buyerForphonNum = $('#buyerForphonNum').val();
	var buyerForReserveNum = $('#buyerForReserveNum').val();
	var buyerForAbsentMsg = $('#buyerForAbsentMsg').val();
	var param = {"address":buyerForAddress, "phonNum":buyerForphonNum, 
			"reserveNum":buyerForReserveNum, "absentMsg":buyerForAbsentMsg,
			"productFinalPrice":parseInt(money), "buyerId":"${buyerId}" , "sellerId":"${post.writer.userId}"
			};
	var shippingInfoVO = JSON.stringify(param);
    IMP.request_pay({
        pg: 'kakao',
        merchant_uid: 'merchant_' + new Date().getTime(),
        amount: parseInt(money),
        buyer_name: "${buyerId}",
        seller_id: "${post.writer.userId}",
   	 	name: '주문명 : 주문명 설정',
        buyer_email: 'iamport@siot.do',
        buyer_tel: phoneNum,
        buyer_mobile:mobileNum,
        buyer_addr: address,
      
    }, function (rsp) {
        console.log(rsp);
        if (rsp.success) {
            var msg = '결제가 완료되었습니다.';
            msg += '고유ID : ' + rsp.imp_uid;
            msg += '상점 거래ID : ' + rsp.merchant_uid;
            msg += '결제 금액 : ' + rsp.paid_amount;
            msg += '카드 승인번호 : ' + rsp.apply_num;
            $.ajax({
                type: "POST", 
                dataType: 'json',
                url: "/business/purchase",
                headers: {
                	'Content-Type' : 'application/json'
                },
                data: JSON.stringify(param),
                beforeSend : function(xhr) {
    				xhr.setRequestHeader(csrfHN, csrfTV);
    			},
            });
        } else {
            var msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
        }
        alert(msg);
        document.location.href="/business/productList?boardId=" + ${boardId} + "&child=" + ${child}; 
    });
});
</script>


