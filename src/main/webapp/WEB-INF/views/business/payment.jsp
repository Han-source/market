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
   float: left; width:50%; padding:10px; height: 100%; overflow: hidden;}


table {
    width: 100%;
    border: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #444444;
    padding: 10px;
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
    <section class="payment_wrap">
        <div class="payment_box">
            <h3>택배거래, 번개페이로 결제합니다</h3>
            	<div class="payment_list">
            	<!-- 이미지  -->
            		<div class="payment_img" id="imageeDiv">
						 <c:forEach var="attachVoInStr" items="${post.attachListInGson}" varStatus="sta">
							<script>
								$(document).ready(function() {
									appendFunction('<c:out value="${attachVoInStr}" />', "${product.id}");
								});
							</script>							
						</c:forEach>
	                </div>
							
							<div class="payment_details">
                		<c:choose>
					        <c:when test="${negoBuyer eq null}"> 
					            <h5 id="finalPrice">${product.productPrice}원</h5>
					        </c:when>
					        <c:otherwise> 
					             <h5 id="finalPrice">${negoBuyer.discountPrice}원</h5>
					        </c:otherwise>
					   	 </c:choose>
	                    <p>${post.content}</p>
	                </div>
						                </div>
					
				
              
                <!--  배송지  -->
            <div class="shipping_address">
            	<h3>수령인</h3>
           			<div>
                        <select id="userNameSelection" name="userNameSelection">
							<option value="1" selected="selected">직접입력</option>
							<option id="loginUser" value='${userName}'>${userName}</option>
						</select>
					</div>
	                <div class="shipping_registration">
	                    <input type="text" id="recipient" name="buyerName" placeholder="이름">
	                </div>
	            
	            <h3>휴대폰 번호</h3>
	                <div class="shipping_registration">
	                    <input type="number" id="buyerForphonNum" name="phonNum" placeholder="휴대폰 번호를 입력해주세요.">
	                </div>
	                
	            <h3>집 전화 번호</h3>
	                <div class="shipping_registration">
                         <input type="number" id="buyerForReserveNum" name="reserveNum" placeholder="예비 연락처를 입력해주세요.">
	                </div>
	                
                <h3>배송지 주소</h3>
	                <div class="shipping_registration">
	                    <input type="text" id="buyerForAddress" name="address"  placeholder="배송지 등록">
	                </div>
                <div class="shipping_req">
                	<input type="hidden" id="buyerForAbsentMsg" name="absentMsg" placeholder="배송 메모를 입력하세요.">
                    <select id="absentMsgSelection" name="absentMsgSelection">
                        <option id="absentMsg" value="1">배송 요청사항(선택)</option>
                        <option id="absentMsg" value="배송전에 미리 연락주세요">배송전에 미리 연락주세요</option>
                        <option id="absentMsg" value="부재시 문앞에 놓아주세요">부재시 문앞에 놓아주세요</option>
                        <option id="absentMsg" value="부재시 경비실에 맡겨주세요">부재시 경비실에 맡겨주세요</option>
                    </select>
                </div>
            </div>
            
            <div class="points_wrap">
                <h3>포인트</h3>
                <div class="remaining_points">
                    <span>0</span>
                    <button>전액사용</button>
                </div>
                <p class="points_available">
                    <span>사용 가능한 번개 포인트</span>
                    <span>0</span>
                </p>
            </div>
            <div class="payment_amountt">
                <h3>결제금액</h3>
                <div class="payment_amount_box">
                    <div class="total_paymentt">
                        <p class="product_aamount">
                            <span class="lefttt">상품금액</span>
                            <span class="righttt">${product.productPrice}원</span>
                        </p>
                        <p class="commissionn">
                            <span class="lefttt">할인된 금액</span>
                            	<c:choose>
							        <c:when test="${negoBuyer eq null}"> 
							            <span class="righttt">0원</span>
							        </c:when>
							        <c:otherwise> 
							             <span class="righttt">${product.productPrice - negoBuyer.discountPrice}원</span>
							        </c:otherwise>
								 </c:choose>                            
                        </p>
                        <p class="shipping_feeee">
                            <span class="lefttt">배송비</span>
                            <span class="righttt">무료배송</span>
                        </p>
                        <p class="total_payment_amountt">
                            <span class="lefttt total_left">총 결제금액</span>
                            	<c:choose>
							        <c:when test="${negoBuyer eq null}">
							            <span class="righttt total_right" id="finalPrice">${product.productPrice}원</span>
							        </c:when>
							        <c:otherwise> 
							             <span class="righttt total_right" id="finalPrice">${negoBuyer.discountPrice}원</span>
							        </c:otherwise>
							    </c:choose>
                        </p>
                    </div>
                </div>
            </div>
            <form id="frmPayment" method="post" action="/business/payment">
               <div class="make_paymentt">
			       <button  type="button" id="kakao_trade">결제하기</button>
			   </div>      
               <input type="hidden" name="productFinalPrice" value="${product.productPrice}">
               <input type="hidden" name="sellerId" value="${post.writer.userId}">
               <input type="hidden" name="buyerId" value="${buyerId}">
               <input type="hidden" name="boardId" value="${boardId}">
       	       <input type="hidden" name="child" value="${child}">
               <input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
            </form>
            
          </div>
    </section>
 </body>

<%@ include file="../includes/footer.jsp"%>
<script src="\resources\js\util\utf8.js"></script>
<script src="\resources\js\imgList\imgList.js"></script>
<script type="text/javascript">

function appendFunction(attachVOInJson, postId){
	imgService.append(attachVOInJson, false, postId);
}



$('#userNameSelection').change(function() {
	var addr;
	var phoneNum;
	var homeNum;
	var recipient = $('#recipient');
	var buyerForAddress = $('#buyerForAddress');
	var buyerForphonNum = $('#buyerForphonNum');
	var buyerForReserveNum = $('#buyerForReserveNum');

   	addr = "${loginPersonInfo[0].info}";
	phoneNum = "${loginPersonInfo[1].info}";
	homeNum = "${loginPersonInfo[2].info}";
 	
	
 	
	if($(this).val()=="1"){
		recipient.val("");
		buyerForAddress.val("");
		buyerForphonNum.val("");
		buyerForReserveNum.val("");
		
		recipient.attr("readonly", false);
		buyerForAddress.attr("readonly", false);
		buyerForphonNum.attr("readonly", false);
		buyerForReserveNum.attr("readonly", false);
	} else {
		recipient.val(document.getElementById('loginUser').innerHTML);
		buyerForAddress.val(addr);
		buyerForphonNum.val(phoneNum);
		buyerForReserveNum.val(homeNum);
	}
});


$('select[name=absentMsgSelection]').change(function() {
	if($(this).val()=="1"){
		$('#buyerForAbsentMsg').val("");
		$("#buyerForAbsentMsg").attr("readonly", false);
	} else {
		$('#buyerForAbsentMsg').val($(this).val());
		$("#buyerForAbsentMsg").attr("readonly", true);
	}
});


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
	
	//구매하면 보낼 곳의 정보, 주소, 폰번호, 예비번호, 부재시 메시지를 받아야함.
	//결재시 받을 주소
	var buyerForAddress = $('#buyerForAddress').val();
	//결제시 받을 연락 받을 번호
	var buyerForphonNum = $('#buyerForphonNum').val();
	//집 전화번호
	var buyerForReserveNum = $('#buyerForReserveNum').val();
	//부재시 메세지
	var buyerForAbsentMsg = $('#buyerForAbsentMsg').val();
	
	var param = {"address":buyerForAddress, "phonNum":buyerForphonNum, 
			"reserveNum":buyerForReserveNum, "absentMsg":buyerForAbsentMsg,
			"productFinalPrice":parseInt(money), "buyerId":"${buyerId}" , "sellerId":"${post.writer.userId}" ,productId:"${post.id}" };
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


