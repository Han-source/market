<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<div class="form-group">
   <input name="postId" type="hidden" value="${post.id}" class="form-control" readonly>
<!-- 여긴 중요한게, 객체를 만들어주는 부분이다. 제목을 넣는 부분 -->
</div>

<div class="form-group">
   <label>제목</label> <input id="title" name="title" value="${post.title}"    class="form-control" readonly>
</div>

<div class="form-group">
   <label>내용</label>
   <textarea id="txaContent" name="content" class="form-control" rows="3" readonly>${post.content}</textarea>
   <!-- rows: 몇줄까지 화면에 보이게 할건지 -->
</div>

<div class="form-group">
   <c:choose>
        <c:when test="${negoBuyer eq null}"> 
            <label>가격</label> <input type="number" id="price" name="productPrice" value="${product.productPrice}"    class="form-control" readonly>
        </c:when>
        <c:otherwise> 
             <label>가격</label> <input type="number" id="price" name="productPrice" value="${negoBuyer.discountPrice}"    class="form-control" readonly>
        </c:otherwise>
    </c:choose>
</div>

<div class="form-group">
   <label>등록일 : </label>
   <fmt:formatDate pattern="yyyy-MM-dd" value="${post.registrationDate}" />
</div>
    <c:if test="${child == 7}">
         
      <div class="form-group">
         <label>종료 시간: </label>
         <input type="datetime-local" id="auctionEndDate" name="auctionEndDate" value="${condition.auctionEndDate}"  readonly>
      </div>


   </c:if>            
<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>

<script type="text/javascript">
   function controlInput(includer) {
      if(includer === '수정' || includer === '신규')  { //includer가 갖고있는 요소가 수정이니 아님 신규이니 라고 묻는다면
         $('#title').attr("readonly" , false);
         //document.getElementById("txaContent").readonly =  false;
          $('#txaContent').attr("readonly" , false); //title, content 부분을 readonly를 false로 바꿔주면
          $('#price').attr("readonly" , false);
          $('#auctionCurrentPrice').attr("readonly" , false);
          $('#auctionEndDate').attr("readonly" , false);
      }
   }
</script>