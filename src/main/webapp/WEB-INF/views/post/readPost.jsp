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
			<%@ include file="./include/postCommon.jsp" %>
			<!-- 공통적 속성인 실 내용들은 postCommon.jsp를 만들어서 보내버렸음 -->

			<sec:authentication property="principal" var ="customUser"/>
			<sec:authorize access="isAuthenticated()">
				<c:if test="${customUser.curUser.userId eq post.writer.userId}">
					<button data-oper='modify' class="btn btn-primary">수정</button>
				</c:if>
			</sec:authorize>
			
			<button data-oper='chat' class="btn btn-secondary">채팅하기</button>
			<button data-oper='list' class="btn btn-secondary">목록</button>
			
			<form id="frmChat" action="/chat/chatting" method="get">
				<input type="hidden" id="toId" name="toId" value="${post.writer.userId}">
			</form>

			<form id='frmOper' action="/post/modifyPost" method="get">
				<input type="hidden" name="boardId" value="${boardId}">
				<input type="hidden" name="child" value="${child}">
				<input type="hidden" id="postId" name="postId" value="${post.id}">
				<input type="hidden" name="pageNumber" value="${pagination.pageNumber}">
				<input type="hidden" name="amount" value="${pagination.amount}">
				<input type="hidden" name="searching" value='${pagination.searching}'>
			</form>
			<%@include file="../common/attachFileManagement.jsp" %>
		</div>
		<%@include file="./include/replyManagement.jsp" %>
	</div>
</div>
<!-- /.container-fluid -->

<!-- End of Main Content -->
<%@include file="../includes/footer.jsp"%>

<script type="text/javascript"> // El에 JSP가 만들어져야 돌아감 ↓
	$(document).ready(function() {
		adjustCRUDAtAttach('조회');
		
		<c:forEach var="attachVoInStr" items="${post.attachListInGson}" >
			appendUploadUl('<c:out value="${attachVoInStr}" />');
		</c:forEach>
		
		//EL이 표현한 LIST 출력 양식, 그래서 첨부파일이 안보임, El은 Server에서 돌아감
		//postCommon에 있는 함수를 부를 것
		
		$("button[data-oper='modify']").on("click", function() {
			$("#frmOper").submit();
		});
		
		$("button[data-oper='list']").on("click", function() {
			$("#frmOper").find("#postId").remove();
			$("#frmOper").attr("action", "/post/listBySearch").submit();
		});
		
// 		$("button[data-oper='chat']").on("click", function() {
// 			$("#frmChat").attr("action", "/chat/chatting");
// 			frmChat.append(toId);
// 			frmChat.submit();
// 		});
		
		$("button[data-oper='chat']").on("click", function() {
		     window.open("../chat/chatting?toId=${post.writer.userId}", "_blank","width=400,height=500,left=1200,top=10");
		});
});
</script>

<canvas id="lookChartProduct" style="width:100vh ; height=100vw">

</canvas>


<script type="text/javascript">
   $(document).ready(function() {
      makeChart();
      new Chart();
   });
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

