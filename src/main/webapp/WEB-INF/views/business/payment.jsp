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
            <form action="#" class="checkout-form">
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
                                <input type="text" name="" placeholder="이름">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2">
                                <p class="in-name">배송지 주소*</p>
                            </div>
                            <div class="col-lg-10">
                                <input type="text" name="" placeholder="배송지를 입력하세요.">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2">
                                <p class="in-name">휴대폰 번호*</p>
                            </div>
                            <div class="col-lg-10">
                                <input type="text" name="" placeholder="휴대폰 번호를 입력해주세요.">
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-lg-2">
                                <p class="in-name">배송 메모 *</p>
                            </div>
                            <div class="col-lg-10">
                                <input type="text" name="" placeholder="배송 메모를 입력하세요.">
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
                                <span>할인이 적용된 가격</span>
                                <p>${negoBuyer.discountPrice}원</p>
                            </c:if>
                            
                            </div>                       
                            <div class="cart-total">
                                <span>최종 가격</span>
                                <c:if test="${child != 7}">
                                <p>${negoBuyer.discountPrice}원</p>
                                </c:if>
                                <c:if test="${child == 7}">
                                <p>${product.productPrice}원</p>
                                </c:if>
                            </div>                        
                            
                       
                            
                        </div>
                    </div>
                </div>
               <div class="row">
                    <div class="col-lg-12">
                        <div class="payment-method">
                            <h3>상품 정보</h3>
                        </div>
                        
 						<c:forEach items="${productList}" var="product1" varStatus="status">
		                  <div id="sliderBody" class="sliderBody" >
		                     <div class="slider" id="${product1.id}">
		                         <ul class="slider__images" style="list-style:none;">
		                            <c:forEach var="attachVoInStr" items="${product1.attachListInGson}" varStatus="sta">
		                              <script>
		                                 $(document).ready(function() {
		                                    imageList('<c:out value="${product1[status.index].attachListInGson[sta.index]}" />', '<c:out value="${product1[status.index].listAttach[sta.index].uuid}" />', '<c:out value="${product1[status.index].id}" />');
		                                 });
		                              </script>                     
		                           </c:forEach>
		                        </ul>
		                     </div>
<!-- 		                     <div class="card-body" style="float: left; width: 50%; padding:10px;"> -->
<%-- 		                           <a class='anchor4product' href="${product.id}" >${product.title}</a> --%>
<!-- 		                           <br> -->
<%-- 		                           ${product.writer.name} --%>
<!-- 		                           <br> -->
<%-- 		                           ${product.readCnt} --%>
<!-- 		                           <br> -->
<%-- 		                           <fmt:formatDate pattern="yyyy-MM-dd" value="${product.updateDate}" /> --%>
<!-- 		                           <br> -->
<!-- 		                     </div>  -->
		                 </div>                           
		               </c:forEach>
 						
 						
 					    
                    </div>
                </div>
                
                
                <div class="row">
                    <div class="col-lg-12">
                        <div class="payment-method">
                            <h3>결제 방식</h3>
                     	                     
                            <button type="submit">결제 완료</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>
 
 
 
 </body>




<%@ include file="../includes/footer.jsp"%>
<script type="text/javascript">
function imageList(attachVOInJson, uuid, id){
    var liTags = "";
    var attachVo = JSON.parse(decodeURL(attachVOInJson));
          if(attachVo.uuid === uuid){
             liTags+= "<li>"
                + "<img src='/uploadFiles/display?fileName=" 
                + encodeURIComponent(attachVo.fileCallPath) + "' style = 'float: left;  width: 100px; height: 100px; object-fit: cover; display: inline-block; font-size: 0;'>"
                + "</li>";
                $("#"+ id +" ul.slider__images" ).append(liTags);
          }
 }   
 
</script>



