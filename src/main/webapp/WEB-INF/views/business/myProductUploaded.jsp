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
<div class="container-fluid">
	<p> </p>
	<!-- DataTales Example -->
	<div class="card shadow mb-4">

		<div class="card-body">

			<form id="frmSearching" action="/product/readProduct" method="get">
			</form>
			<!--  내가 결제한 상품 목록만 조회  -->			
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
							내가 올린 상품
						</p>
						
        			</div>
        		
	        		 <div class="itemm_grid">
	                    <!-- 상품  -->  	  
	                		<!--  상품 사진 출력 부분. -->          
        				<c:forEach items="${productUploaded}" var="product" varStatus="status">
							 <c:forEach var="attachVoInStr" items="${product.attachListInGson}" varStatus="sta">
               					<div class="itemm">								
							 		<div class="itemm_img" id="${product.id}">
										<script>
											$(document).ready(function() {
												productImgListFunction('<c:out value="${productUploaded[status.index].attachListInGson[sta.index]}" />', '<c:out value="${productUploaded[status.index].listAttach[sta.index].uuid}" />', '<c:out value="${productUploaded[status.index].id}" />');
											});
										</script>
									</div>
									<!--  상품 추가 정보 입력하기. -->
									<div class="itemm_details">								
			                       		<p class="name">상품명 : ${product.title}</p>
			                       				                       	                    
			               	     	</div>								
								</div>
							</c:forEach>
						</c:forEach>
					</div>
				</div>	
			</div>
		</div>
	</div>
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
		var board = $('#boardId').val();
		var child = $(this).children('input#child').val();
		frmSearching.append("<input name='boardId' type='hidden' value='" + $('#boardId').val() + "'>"); // 문자열을 끝내고 이어받아서 return값 호출
		frmSearching.append("<input name='child' type='hidden' value='" + $(this).children('input#child').val() + "'>"); // 문자열을 끝내고 이어받아서 return값 호출
		frmSearching.attr('action', '/business/readProduct');
		frmSearching.attr('method', 'get');
		frmSearching.submit();
	});
});
	
	
	function productImgListFunction(attachVOInJson, uuid, id){
		imgService.productImgList(attachVOInJson, uuid, id);
	}


</script>
