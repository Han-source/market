<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page import="www.dream.com.bulletinBoard.model.PostVO"%>
<%@include file="../includes/header.jsp"%>

<!--  TableHeader에 정의된 static method를 사용하기 위함 -->
<jsp:useBean id="tablePrinter"
	class="www.dream.com.framework.printer.TablePrinter" />
<style>
#sliderBody{float: left; width:20%; height: 100px; padding:0px; margin-right:1%; } 
#header1{ height: 100px; border-bottom: 1px solid dimgrey; box-sizing: border-box; text-align: center; line-height: 100px; font-size: 1.5rem; }
.slider {
   float: left; width:50%; padding:10px; height: 100%; overflow: hidden; 
}
</style>
	
    <c:forEach items="${childBoardList}" var="child">
   		<a href="/business/productList?boardId=4&child=${child.id}">${child.name}</a>
   	</c:forEach>
	
	<a><button id="btnSelledproductList" class="btn btn-default">거래완료글</button></a>

	<!-- DataTales Example -->
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">${boardName}글목록</h6>
			<c:if test="${boardId == 4}">
					<c:choose>
			            <c:when test="${child == 5}"> 
			                <h6 class="m-0 font-weight-bold text-primary">${childBoardName}</h6>
			            </c:when>
			            <c:when test="${child == 6}"> 
			                <h6 class="m-0 font-weight-bold text-primary">${childBoardName}</h6> 
			            </c:when>
			            <c:when test="${child == 7}"> 
			                <h6 class="m-0 font-weight-bold text-primary">${childBoardName}</h6> 
			            </c:when>
			        </c:choose>
			</c:if>
		</div>
		<div class="card-body">
			
			<!--  거래 완료된 상품리스트  -->			
			<form id="frmSelledproductList" action="/business/productList" method="get">
            <input type="hidden" name="boardId" value="${boardId}">
               <input type="hidden" name="child" value="${child}">
               <input type="hidden" name="findSelledProdutList" value="1">
            </form>
			<div class="itemm_wrapper">
        		<div class="itemm_container"> 		
        			<div class="itemm_heading_title">
       				
       					<form id="frmSearching" action="/business/productList" method="get">
							<input type="text" name='searching' value="${page.searching}">
							<button id="btnSearch" class='btn btn-default'>검색</button>
							    <button class="icon"><i class="fa fa-search"></i></button>
							
			                <button type="button" id="btnRegisterProduct" class="productBtn" >상품등록</button> 
							<input type="hidden" name="boardId" value="${boardId}">
							<input type="hidden" name="child" value="${child}">
							<input type="hidden" name="parentBoardName" value="${parentBoardName}">
							<input type="hidden" name="pageNumber" value="${page.pageNumber}">
							<input type="hidden" name="amount" value="${page.amount}">
							<input type="hidden" name="findSelledProdutList" value="0">
						</form>
						
						<p>
							안녕하세요 Fleax마켓입니다.
						</p>
						
        			</div>
        		
	        		 <div class="itemm_grid">
	                    <!-- 상품  -->  	  
	                		<!--  상품 사진 출력 부분. -->          
        				<c:forEach items="${productList}" var="product" varStatus="status">
							 <c:forEach var="attachVoInStr" items="${product.attachListInGson}" varStatus="sta">
               					<div class="itemm">								
							 		<div class="itemm_img" id="${product.id}">
										<script>
											$(document).ready(function() {
												productImgListFunction('<c:out value="${productList[status.index].attachListInGson[sta.index]}" />', '<c:out value="${productList[status.index].listAttach[sta.index].uuid}" />', '<c:out value="${productList[status.index].id}" />');
											});
										</script>
									</div>
									<!--  상품 추가 정보 입력하기. -->
									<div class="itemm_details">								
			                       		<p class="name">상품명 : ${product.title}</p>
			                       		<p class="price">가격 : ${productList[status.index].product.productPrice}</p>			                       	                    
			               	     	</div>								
								</div>
							</c:forEach>
						</c:forEach>
					</div>
				</div>	
			</div>
				<!-- Paging 처리 05.27 -->
				<!-- EL로 처리, Criteria.java에 있음  -->
				<div class='fa-pull-right'>${page.pagingDiv}</div>
				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">상품 등록 완료</h4>
							</div>
							<div class="modal-body" id = "modalBody">처리가 완료 되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 상품 등록 관련 모달 -->
				<div id="productModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header" style="text-align: center;">
								<h4 class="modal-title" id="myModalLabel" align="center" style="margin: 0 auto;">거래방식을 선택해 주세요</h4>
							</div>
							<!-- End of modal-header -->
							<div class="modal-body" id = "modalProductBody" style=" text-align: center;">
							  <c:forEach items="${childBoardList}" var="child">
						      		<button  class='btn btn-default' type="button" onclick="location.href='/business/registerProduct?boardId=4&child=${child.id}'">${child.name}</button>
							  </c:forEach>
							</div>
							<div class="modal-footer">
								<button id='btnCloseModal' type="button" class="btn btn-default">취소</button>								
							</div>
						</div>
					</div>
				</div>
				<!-- /.modal -->

			</div>
		

<%@include file="../includes/footer.jsp"%>
<script src="\resources\js\util\utf8.js"></script>
<script src="\resources\js\imgList\imgList.js"></script>
<!-- End of Main Content -->
<script type="text/javascript">
	$(document).ready(function() {

	$("#btnRegisterProduct").on("click", function(e) {
		$("#productModal").modal("show");					
	});
	 
	
	$("#btnCloseModal").on("click", function(e) {
		$("#productModal").modal("hide");
	});
		
	 var result = '<c:out value="${result}"/>';
	
	checkModal(result); // checkModal 함수 호출
	
	history.replaceState({}, null, null);

	function checkModal(result){
		if (result === '' || history.state){ 
			return;
		}
		if (result.length == ${PostVO.ID_LENGTH}) { 

			$("#modalBody").html("상품 " + result + "번으로 등록되었습니다.");
		} else {
			$("#modalBody").html("상품" + result + "하였습니다.");
		}
		
		$("#myModal").modal("show");
	}
	
	/*05.31 검색에 관한 처리 -> 06.04 frmPaging 기능 새로 작성하기*/
	var frmSearching = $('#frmSearching');
	$('#btnSearch').on('click', function(eInfo) {
		eInfo.preventDefault();
		
		if ($('input[name="searching"]').val().trim() === '') {
			alert('검색어를 입력하세요');
			return;
		}
		// 신규 조회 이므로 1쪽을 보여줘야 합니다.
		$("input[name='pageNumber']").val("1");
		
		frmSearching.submit();
	});
		//거래완료 글 페이징처리
	   var frmSelledproductList = $('#frmSelledproductList');
	   $('#btnSelledproductList').on('click', function(eInfo) {
	        eInfo.preventDefault();

	        //신규 조회이므로 1쪽을 보여줘야합니다
	        $("input[name='pageNumber']").val("1");

	        frmSelledproductList.submit();
	     });	   
	/*Paging 처리에서 특정 쪽 번호를 클릭하였을때 해당 page의 정보를 조회하여 목록을 재출력 해줍니다. */
	var frmPaging = $('#frmPaging');
	$('.page-item a').on('click', function(eInfo) {
		eInfo.preventDefault();
		$("input[name='pageNumber']").val($(this).attr('href')); //여기 val이 중요하다. Click이 일어난 곳=this 거기가 href 처리해둔곳
		frmSearching.submit();
	});
	
	
	$('.anchor4product').on('click', function(e) {
		e.preventDefault();
		var productId = $(this).attr('href')
		frmSearching.append("<input name='productId' type='hidden' value='" + productId + "'>"); // 문자열을 끝내고 이어받아서 return값 호출
		frmSearching.attr('action', '/business/readProduct');
		frmSearching.attr('method', 'get');
		frmSearching.submit();
	});
	
	
	$('.itemm').on('click', function(e) {
		e.preventDefault();
		var productId = $(this).children('.itemm_img').attr('id')
		frmSearching.append("<input name='productId' type='hidden' value='" + productId + "'>"); // 문자열을 끝내고 이어받아서 return값 호출
		frmSearching.attr('action', '/business/readProduct');
		frmSearching.attr('method', 'get');
		frmSearching.submit();
	});
});
	
	
	function productImgListFunction(attachVOInJson, uuid, id){
		imgService.productImgList(attachVOInJson, uuid, id);
	}


</script>
