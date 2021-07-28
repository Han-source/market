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
#index_01{ width: 24%; height: 150px; border: 1px solid dimgrey; margin: 0 auto; } 
#header1{ height: 100px; border-bottom: 1px solid dimgrey; box-sizing: border-box; text-align: center; line-height: 100px; font-size: 1.5rem; } 
</style>

<!-- Begin Page Content -->
<div class="container-fluid">
	
    <c:forEach items="${childBoardList}" var="child">
   		<a href="/post/listBySearch?boardId=4&child=${child.id}">${child.name}</a>
   	</c:forEach>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
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

			<!-- Paging 이벤트에서 서버로 요청보낼 인자들을 관리합니다. -->
			<form id="frmSearching" action="/post/listBySearch" method="get">
				<input type="text" name='searching' value="${pagination.searching}">
				<button id="btnSearch" class='btn btn-default'>검색</button>
				<c:choose>
			            <c:when test="${boardId == 4}"> 
			                <button type="button" id="btnRegisterProduct">상품등록</button> 
			            </c:when>
			            <c:otherwise> 
							<button id="btnRegisterPost">글쓰기</button> 
			            </c:otherwise>
			        </c:choose>
				<input type="hidden" name="boardId" value="${boardId}">
				<input type="hidden" name="child" value="${child}">
				<input type="hidden" name="parentBoardName" value="${parentBoardName}">
				<input type="hidden" name="pageNumber" value="${pagination.pageNumber}">
				<input type="hidden" name="amount" value="${pagination.amount}">
			</form>

			<!--  <a href="/post/registerPost?boardId=${boardId}">글쓰기</a> -->
			<!-- 글쓰기 Button ↑ 05.25作 -->

			<!-- <input type="button" value="글쓰기" class="btn btn-primary"> ↑동일 표현 -->
			<div >
				<table class="table table-bordered" id="dataTable">
					<thead>
						<!-- <tr><%=tablePrinter.printHeader(PostVO.class)%></tr> -->
					</thead>
						<c:forEach items="${listPost}" var="post">
						<tr id="index_01" class="card-body" style="float: left; width:24%; padding:10px; margin-right:1%">
									<td class="card-body" id="${post.id}" style="float: left; width:50%; padding:10px; height: 100%; overflow: hidden;">
										<ul>
										</ul>
									</td>
										<c:choose>
								            <c:when test="${boardId == 4}"> 
												<td class="card-body" style="float: left; width: 50%; padding:10px;">
													<a class='anchor4product' href="${post.id}" >${post.title}</a>
													<br>
													${post.writer.name}
													<br>
													${post.readCnt}
													<br>
													<fmt:formatDate pattern="yyyy-MM-dd" value="${post.updateDate}" />
													<br>
													<form id="frmPick" action="/post/listBySearch" method="get">
														<input type="hidden" name="boardId" value="${boardId}"> 
														<input type="hidden" name="boardId" value="${post.id}">
													</form>
												</td> 
								            </c:when>
								            <c:otherwise> 
												<td class="card-body" style="float: left; width: 50%; height: 100%; padding:10px;">
													<a class='anchor4post' href="${post.id}" >${post.title}</a>
													<br>
													${post.writer.name}
													<br>
													${post.readCnt}
													<br>
													<fmt:formatDate pattern="yyyy-MM-dd" value="${post.updateDate}" />
													<br>
													<form id="frmPick" action="/post/listBySearch" method="get">
														<input type="hidden" name="boardId" value="${boardId}"> 
														<input type="hidden" name="boardId" value="${post.id}">
													</form>
												</td> 
								            </c:otherwise>
								        </c:choose>
						</tr>									
						</c:forEach>
				</table>

				<!-- Paging 처리 05.27 -->
				<!-- EL로 처리, Criteria.java에 있음  -->
				<div class='fa-pull-right'>${pagination.pagingDiv}</div>

				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
							<div class="modal-body" id = "modalBody">처리가 완료 되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary">Save
									changes</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
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
		</div>
	</div>
	
</div>
<!-- /.container-fluid -->


<%@include file="../includes/footer.jsp"%>
<script src="\resources\js\util\utf8.js"></script>
<!-- End of Main Content -->
<script type="text/javascript">
	$(document).ready(function() {
	 // c에 들어있는 out tag를 활용, 저기 c는 제일 상단부에 taglib에 있음
	$("#btnRegisterPost").on("click", function() {
		frmSearching.attr('action', '/post/registerPost');
		frmSearching.submit();
	});
	 

	$("#btnRegisterProduct").on("click", function(e) {
		$("#productModal").modal("show");					
	});
	 
	
	$("#btnCloseModal").on("click", function(e) {
		$("#productModal").modal("hide");
	});
		
	 var result = '<c:out value="${result}"/>';
	
				
	// history.replaceState({}, null, null); 여기에 위치하면, 아무리 등록해도 Modal창이 안뜰것
	// 부르기 전에 상태를 넣었기때문에 글을 등록해도 Modal창이 안뜰것
	
	checkModal(result); // checkModal 함수 호출
	
	history.replaceState({}, null, null);
	// Modal창이 여러번 뜨는걸 방지하기 위한 Code1 (stateObj, title[, url]) -> Obj = {}이다 이는 null과 같은 의미
	// history객체야 상태를 변경하자, ({}, null, null) 한마디로 null이라는 상황이다. 넣어야하는 객체가 위처럼 3개라서 그렇지. 
	
	function checkModal(result){
		if (result === '' || history.state){ 
			return;
		}
		if (result.length == ${PostVO.ID_LENGTH}) { 

			$("#modalBody").html("게시글 " + result + "번이 등록되었습니다.");
		} else {
			$("#modalBody").html("게시글에 대한 " + result + "하였습니다.");
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
	
	/*Paging 처리에서 특정 쪽 번호를 클릭하였을때 해당 page의 정보를 조회하여 목록을 재출력 해줍니다. */
	var frmPaging = $('#frmPaging');
	$('.page-item a').on('click', function(eInfo) {
		eInfo.preventDefault();
		$("input[name='pageNumber']").val($(this).attr('href')); //여기 val이 중요하다. Click이 일어난 곳=this 거기가 href 처리해둔곳
		frmSearching.submit();
	});
	
	/* 05.28 특정 게시물에 대한 상세 조회 처리 */
	$('.anchor4post').on('click', function(e) {
		e.preventDefault();
		var postId = $(this).attr('href')
		frmSearching.append("<input name='postId' type='hidden' value='" + postId + "'>"); // 문자열을 끝내고 이어받아서 return값 호출
		frmSearching.attr('action', '/post/readPost');
		frmSearching.attr('method', 'get');
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
	
	
	<c:choose>
	    <c:when test="${boardId == 4}"> 
			<c:forEach var="list" items="${product}" varStatus="status">
				<c:forEach var="attachVoInStr" items="${list.attachListInGson}" varStatus="sta">
					var liTags = "";
					var attachVo = JSON.parse(decodeURL("${list.repersent}"));
							if(attachVo.uuid === "${product[status.index].listAttach[sta.index].uuid}"){
								liTags+= "<li>"
									+ "<img src='/uploadFiles/display?fileName=" 
									+ encodeURIComponent(attachVo.fileCallPath) + "' style = 'float: left;  width: 100px; height: 100px; object-fit: cover; display: inline-block; font-size: 0;'>"
									+ "</li>";
									$("#${listPost[status.index].id} ul").append(liTags);
							}
				</c:forEach>
			</c:forEach>
	    </c:when>
	    <c:otherwise> 	    	
			<c:forEach var="list" items="${listPost}" varStatus="status">
				<c:forEach var="attachVoInStr" items="${list.attachListInGson}" varStatus="sta">
					var liTags = "";
			    	var attachVo = JSON.parse(decodeURL("${list.repersent}"));
							if(attachVo.uuid === "${listPost[status.index].listAttach[sta.index].uuid}"){
								liTags+= "<li>"
										+ "<img src='/uploadFiles/display?fileName=" 
										+ encodeURIComponent(attachVo.fileCallPath) + "' style = 'float: left;  width: 100px; height: 100px; object-fit: cover; display: inline-block; font-size: 0;'>"
										+ "</li>";
										$("#${listPost[status.index].id} ul").append(liTags);
							}
				</c:forEach>
			</c:forEach> 
	    </c:otherwise>
	</c:choose>
	
});
	
	
</script>