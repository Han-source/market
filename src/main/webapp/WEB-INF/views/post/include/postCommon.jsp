<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- id 값으로 content를 그냥 사용하는건 위험하다. 왜냐하면 content값이 예약을 처리하는 기능이 있기에  -->
<!-- 실 내용만 담을 postCommon.jsp -->
<div class="form-group">
	<input name="id" type="hidden" value="${post.id}" class="form-control" readonly>
<!-- 여긴 중요한게, 객체를 만들어주는 부분이다. 제목을 넣는 부분 -->
</div>

	<!-- 수정 처리시(modify) title,content에는 readonly는 없어야 한다. -->
	<!-- 신규 처리시 title,content에는 value가 없고 readonly도 없다.  -->
	
	<!-- 신규화면에서 필요한 것들,  -->
<div class="form-group">
	<label>제목</label> <input id="title" name="title" value="${post.title}" 	class="form-control" readonly>
</div>

<div class="form-group">
	<label>내용</label>
	<textarea id="txaContent" name="content" class="form-control" rows="3" readonly>${post.content}</textarea>
	<!-- rows: 몇줄까지 화면에 보이게 할건지 -->
</div>

<div class="form-group">
	<label>작성자</label>
	 <c:choose>
	 	<c:when test="${empty post}">
	 		<input value= '<sec:authentication property="principal.curUser.name"/>'	class="form-control" readonly>
	 		
	 	</c:when>
	 	<c:otherwise>
	 		<input value="${post.writer.name}"	class="form-control" readonly>
	 	</c:otherwise>
	 </c:choose>
</div>

<!-- 05.27 새로운 속성들 추가 -->

<div class="form-group" id = "likeDivId">
   <p>
      조회수 : <b>${post.readCnt}</b> <span id="like"> 좋아요 : <i id="likecnt">${post.likeCnt}</i> </span>
   </p>
</div>

<div class="form-group" id = "dateDivId">
	<label >등록일 : </label>
	<fmt:formatDate pattern="yyyy-MM-dd" value="${post.registrationDate}" />
	<label >, 수정일 : </label>
	<fmt:formatDate pattern="yyyy-MM-dd" value="${post.updateDate}" />
</div>
 <c:choose>
	 	<c:when test="${boardId == 5}">
				<div class="form-group">
					<label>시작가격</label> <input type="number" id="autionStartPrice" name="autionStartPrice" value="${post.title}" 	class="form-control">
				</div>
				
				<div class="form-group">
					<label>종료가격</label> <input type="number" id="autionEndPrice" name="autionEndPrice" value="${post.title}" 	class="form-control">
				</div>
				
				<div class="form-group">
					<label>작성자id</label>
					 <c:choose>
					 	<c:when test="${empty post}">
					 		<input value= '<sec:authentication property="principal.curUser.name"/>'	class="form-control">
					 	</c:when>
					 	<c:otherwise>
					 		<input value="${post.writer.userId}" class="form-control" readonly>
					 	</c:otherwise>
					 </c:choose>
				</div>
				
				<div class="form-group">
	
	
					<label>시작시간 </label>
					<input type="datetime-local" name="startTime" value="${post.startTime}" />
					<label>종료 시간: </label>
					<input type="datetime-local" name="endTime" value="${post.endTime}" />
					
				</div>
				
				<div class="form-group">
					<label>즉시 구매가</label> <input id="immediatePurchasePrice" name="immediatePurchasePrice" value="${post.title}" 	class="form-control">
				</div>
	</c:when>
</c:choose>


<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
<input type='hidden' name='check' id="check" value='0'>
<script type="text/javascript">
//$(document).ready(function() { 이게 있으면 함수가 정의?가 안된다. 
	<!-- 수정 처리시(modify) title,content에는 readonly는 없어야 한다. -->
	<!-- 신규 처리시 title,content에는 value가 없고 readonly도 없다.  -->
	function controlInput(includer) {
		if(includer === '수정' || includer === '신규')  { //includer가 갖고있는 요소가 수정이니 아님 신규이니 라고 묻는다면
			$('#title').attr("readonly" , false);
			//document.getElementById("txaContent").readonly =  false;
			 $('#txaContent').attr("readonly" , false); //title, content 부분을 readonly를 false로 바꿔주면
			 $('#dateDivId').remove();
			 $('#likeDivId').remove();

		}
	}
	
	
	   $("#like").click(function () {
	         var id = "${post.id}"
	         var userId = "${userId}"
	         var checkLike = checkLike123();
	   
	         
	         var header = $("meta[name='_csrf_header']").attr("content");
	         var token = $("meta[name='_csrf']").attr("content");
	         var csrfHN = "${_csrf.headerName}";
	         var csrfTV = "${_csrf.token}";
	         console.log(checkLike);
	               $.ajax({
	                  url: "/post/UDlikeCnt",
	                  type: "POST",
	                  data: {
	                     id : id,
	                     userId : userId,
	                     checkLike : checkLike
	                  },
	                  beforeSend : function(xhr) {
	                     xhr.setRequestHeader(csrfHN, csrfTV);
	                  },
	                  success : function (data) {
	                     if($('#check').val()=='1'){
	                        $('#check').val('0');
	                     }else{
	                        $('#check').val('1');
	                     }
	                     
	                     //alert(data);
	                     console.log(data);
	                     $("#likecnt").html(data); 
	                  }

	               })
	            
	      });
	   
	   
	   
	   function checkLike123(){
	         var id = "${post.id}"
	         var userId = "${userId}"
	         var check;
             $.ajax({
                url: "/post/checkLike",
                type: "GET",
                async: false,
                data: {
                   id : id,
                   userId : userId,
                },
                success : function (data) {
                	check = data
               }
           })
           return check;
        }
</script>

