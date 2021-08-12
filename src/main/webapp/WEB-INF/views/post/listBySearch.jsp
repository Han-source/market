<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<%@ page import="www.dream.com.bulletinBoard.model.PostVO"%>

<!-- TableHeader에 정의된 static method를 사용하기 위해 정의함 -->
<jsp:useBean id="tablePrinter" class="www.dream.com.framework.printer.TablePrinter"/>

<!-- End of Topbar -->

<!-- Begin Page Content -->
<div class="container-fluid">
   <!-- DataTales Example -->
   <p>
   <div class="card shadow mb-4">
      <div class="card-header py-3">
         <h6 class="m-0 font-weight-bold text-primary">${boardName}글목록</h6>
      </div>
      <div class="card-body">
         <!-- Paging 이벤트에서 서버로 요청보낸 인자들을 관리합니다. -->
         <form id="frmSearching" action="/post/listBySearch" method="get">
            <!--  정렬 방식 -->
      
            <input type="text" name="searching" value="${pagination.searching}" />
            <button id="btnSearch" class="btn btn-default">검색</button>
            <!-- c: if 조건문으로, descrim이 관리자인지, 공지사항, faq 의 boardId(1,2) => 이 두조건이 해당할때만 열어줌 -->
           <c:choose>    
               <c:when test="${descrim eq 'User' and boardId eq 3}">
                   <button id="btnRegisterPost" class="btn btn-primary">글쓰기</button>
               </c:when>
               <c:when test="${descrim eq 'Admin'}">
                   <button id="btnRegisterPost" class="btn btn-primary">글쓰기</button>
                   <button id="btnBatchDeletePost" class="btn btn-info">일괄삭제</button>
               </c:when>
           </c:choose>
            <input type="hidden" name="boardId" value="${boardId}">
            <input type="hidden" name="child" value="${child}">
            <input type="hidden" name="pageNumber" value="${pagination.pageNumber}">
            <input type="hidden" name="amount" value="${pagination.amount}">
            <input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
            <input type="hidden" name="ListFromLike" value="1">
         </form>
   	   	 <form id="frmLikeRank" action="/post/listBySearch" method="get">
         <input type="hidden" name="boardId" value="${boardId}">
            <input type="hidden" name="child" value="${child}">
            <input type="hidden" name="pageNumber" value="${pagination.pageNumber}">
            <input type="hidden" name="amount" value="${pagination.amount}">
            <input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
            <input type="hidden" name="ListFromLike" value="1">
         </form>	
   			
         <br> <a href="/">메인으로</a>
         <a href="/post/listBySearch?boardId=3&child=0"> 전체글</a>
         <a><button id="btnRankingLike" class="btn btn-default">개념글</button></a>

         <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
               <thead>
                  <tr>
                     <td id="noneAdmin" >선택</td>
                  <%= tablePrinter.printHeader(PostVO.class) %>  
                  </tr>
               </thead>
               
               <tbody>
                  <c:forEach items="${listPost}" var="post">
                     <tr>
                     <c:choose>
                           <c:when test="${empty post.listAttach}" >
                              <td id="noneAdmin1">
                                <c:if test="${descrim eq 'Admin'}">
                                    <input type="checkbox" name="chkpost"  id="chkposts" value="${post.id}">
                              </c:if>
                              </td>
                              <td ><a class="anchor4post" href="${post.id}" >
                                 <img src="\resources\img\noimg.png" style="width: 25px; height: 25px;">${post.title}</a>
                              </td>
                              <td>${post.writer.name}</td> 
                              <td>${post.readCnt}</td>
                              <td><fmt:formatDate pattern="yyyy년 MM월 dd일" value="${post.updateDate}" /></td>
                          </c:when>
                          <c:otherwise>
                            <td id="noneAdmin1">
                              <c:if test="${descrim eq 'Admin'}">
                                    <input type="checkbox" name="chkpost" id="chkposts" value="${post.id}">
                              </c:if>
                           </td>
                              <td><a class="anchor4post" href="${post.id}"><img src="\resources\img\attachimg.png" style="width: 25px; height: 25px;">${post.title}</a>
                              </td>
                              <td>${post.writer.name}</td>
                              <td>${post.readCnt}</td>
                              <td><fmt:formatDate pattern="yyyy년 MM월 dd일" value="${post.updateDate}" /></td>
                          </c:otherwise>
                      </c:choose>
                     </tr>
                  </c:forEach>
               </tbody>
            </table>

            <!-- 페이징 처리 -->
            <div class='fa-pull-right'>
            ${pagination.pagingDiv}
              
            </div>
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
                     <div class="modal-body">처리가 완료 되었습니다.</div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                           data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                     </div>
                  </div>
                  <!-- /.modal-content -->
               </div>
               <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
         </div>
      </div>
   </div>
</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<%@ include file="../includes/footer.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
   
   // descrim 이 비 로그인 상황일때
if (${descrim != 'User' and descrim != 'Admin'}){
      $('#noneAdmin').remove();
      var nA1 = $('#noneAdmin1');
      for (nA1 = 0; nA1 < 10; nA1++) {
         $('#noneAdmin1').remove();
         
      } // 이쪽 부분이 반복이 안돌아감.
      
   // descrim이 User일때 , Admin일때는 따로 만들어줄 필요가 없다.
   } else if(${descrim == 'User'}){
      $('#noneAdmin').remove();
      var nA1 = $('#noneAdmin1');
      for (nA1 = 0; nA1 < 10; nA1++) {
         $('#noneAdmin1').remove(); // 이쪽 부분이 반복이 안돌아감.
      }
   }
   
      var frmSearching = $('#frmSearching');
      
      $("#btnRegisterPost").on("click", function(){
//          if(${boardId} === 1 || ${boardId} === 2 ){
//            alert('관리자만 작성 가능합니다.');
//            preventDefault();
//            return;
           
//         } else {
           frmSearching.attr('action', '/post/registerPost');
           frmSearching.submit();   
//        }
        
     });
         var result = '<c:out value="${result}" />';
         
         checkModal(result); // 함수를 불러주는 역할
         
         //checkModal(result); 밑에 있어야 modal창을 띄울수있음
         history.replaceState({} , null, null);
         
         function checkModal(result){
            if(result === '' || history.state){
               return;
            }
            if(result.length == ${PostVO.ID_LENGTH}){
               $(".modal-body").html("게시글 " + result + " 번이 등록되었습니다");
            }else{
               $(".modal-body").html("게시글이 " + result + " 되었습니다");
            }
            $("#myModal").modal("show");
         }
               
         $('#btnSearch').on('click', function(eInfo) {
            eInfo.preventDefault();
            

            if ($('input[name="searching"]').val() === '') {
               alert('검색어를 입력하세요');
               return;
            }
            //신규 조회이므로 1쪽을 보여줘야합니다
            $("input[name='pageNumber']").val("1");

            frmSearching.submit();
         });
         
         // 버튼 누를 시 좋아요 제일 높은거 출력
         $('#btnRankingLike').on('click', function(eInfo) {
             eInfo.preventDefault();

             //신규 조회이므로 1쪽을 보여줘야합니다
             $("input[name='pageNumber']").val("1");
             frmLikeRank.submit();
          });

         /* 페이징 처리에서 특정 쪽 번호를 클릭하였을 때 해당 페이지의 정보를 조회하여 목록을 재 출력해 줍니다. */
         $('.page-item a').on('click', function(eInfo) {
            eInfo.preventDefault();
            $("input[name='pageNumber']").val($(this).attr('href'));
            frmSearching.submit();
         });

         /* 특정 게시물에 대한 상세 조회 처리 */
         $('.anchor4post').on('click', function(e) {
            e.preventDefault();
            var postId = $(this).attr('href');
            frmSearching.append("<input name='postId' type='hidden' value='" + postId + "'>");
            frmSearching.attr('action', '/post/readPost');
            frmSearching.attr('method', 'get');
            frmSearching.submit();
         });
         
         /* 관리자 Mode 여러 게시물을 선택하여 일괄적으로 삭제, 선택이 안되어있으면 삭제 불가능 */

        $('#btnBatchDeletePost').on('click', function(e) {
           var a = document.querySelectorAll('input[name="chkpost"]:checked');
           
           if(document.querySelectorAll('input[name="chkpost"]:checked').length == 0) {
            alert('삭제할 게시글을 선택해주세요.');
            
              } else {
              document.querySelectorAll('input[name="chkpost"]:checked').forEach((cel)=> {
                    frmSearching.append("<input name='postIds' type='hidden' value='" + cel.value + "'>");
                 });
                 
                 //form에 해당 항복 정보를 삽입
                 frmSearching.attr('action', '/post/batchDeletePost');
                 frmSearching.attr('method', 'post');
                 frmSearching.submit();
                 }
              });
           //선택된 항목에 대한 정보 추출 JS형식, jquery 형식으로도 써도 괜찮다.
   });

</script>