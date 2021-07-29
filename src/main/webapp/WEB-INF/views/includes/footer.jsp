<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!-- Footer -->
<footer class="sticky-footer bg-white">
   <div class="container my-auto">

   </div>
</footer>
<!-- End of Footer -->

</div>
<!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
   aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
            <button class="close" type="button" data-dismiss="modal"
               aria-label="Close">
               <span aria-hidden="true">×</span>
            </button>
         </div>
         <div class="modal-body">Select "Logout" below if you are ready
            to end your current session.</div>
         <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
            <a class="btn btn-primary" href="login.html">Logout</a>
         </div>
      </div>
   </div>
</div>

<a class="scroll-to-top rounded" href="#page-top"> <i
   class="fas fa-angle-up"></i>
</a>

<!-- Bootstrap core JavaScript-->
   
   <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="/resources/js/jquery.magnific-popup.min.js"></script>
    <script src="/resources/js/jquery.nice-select.min.js"></script>
    <script src="/resources/js/jquery.slicknav.js"></script>
    
    <script src="/resources/js/bootstrap.min.js"></script>
    <script src="/resources/js/owl.carousel.min.js"></script>
    <script src="/resources/js/mixitup.min.js"></script>
    <script src="/resources/js/main.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<script src="/resources/js/sb-admin-2.min.js"></script>
	<script src="/resources/js/js-image-slider.js"></script>
    <script src="/resources/js/ninja-slider.js" type="text/javascript"></script>




<!-- p235, 반응형 처리부분 모바일에서 Menu 펼쳐지기 방지 코드  -->
<script type="text/javascript">
/* $(document).ready(function() {
   $(".navbar-nav")
   .attr("class", "navbar-nav navbar-collapse collapse") <!-- collapse: css에서 정의되는 단어-->
   .attr("aria-expanded", "false")
   .attr("style", "height:1px")
}); */
</script>
</body>
<script type="text/javascript">
   // 기본적으로 메시지를 읽지않은 함수를 반복적으로 실행시키기
   $(document).ready(function(){
            getUnread();
            getInfiniteUnread();
             chatBoxFunction();
             getInfiniteBox();
         });
</script>


<script type="text/javascript">

    function chatBoxFunction() {
       // 로그인한 사용자 변수로 받기
       var userID = "${userId}"
       var csrfHN = "${_csrf.headerName}";
       var csrfTV = "${_csrf.token}";
       $.ajax({
          type : "POST",
          url : "/chat/chatBox",
          data : {
             userID : userID,

          },
          beforeSend : function(xhr) {
             xhr.setRequestHeader(csrfHN, csrfTV);
          },
          success : function(data) {
             //만약 결과 데이터가 비어있다면
             if (data == "")
                return;
             $('#boxTable').html('');
             var parsed = JSON.parse(data);
             var result = parsed.result;
             for (var i = 0; i < result.length; i++) {
                if (result[i][0].value == userID) {
                   result[i][0].value = result[i][1].value;
                } else {
                   result[i][1].value = result[i][0].value;
                }
                //addBox는 실제로 우리 화면에 각각의 메시지 목록을 출력해주는 함수
                addBox(result[i][0].value, result[i][1].value,
                      result[i][2].value, result[i][3].value);
             }
          }
       });
    }
   // 메시지함 같은 경우에는 누가 메시지를 보냈고 최근에 어떠한 메시지를 주고 받았는지 보여주도록
   // 만들어주는 함수
   function addBox(lastID, toID, chatContent, chatTime) {
      // 해당 메시지를 클릭했을 경우 메시지를 주고 받은 채팅방으로 이동
      //$('#boxTable').append(
      //      '<li style="border: 1px solid black;" onclick="location.href=\'chat/chatting?toId='+ toID + '\'">'
      //            + '<td style="width: 150px;"><h5>' + lastID + '</h5>'
      //             + '<h5>' + chatContent + '</h5> '+  '</td>'
      //      + '</li>');
   
      
      
      
      
	 $('#boxTable').append(
              '<li class = "conversation" onclick="window.open(\'../chat/chatting?toId='+toID+'\', \'_blank\',\'width=400,height=500,left=1200,top=10\');">'
                    + '<p class = "conversation_id">' + lastID + '</p>' 
                    + '<p class = "created_date">' + chatTime +'</p>'
                    + '<p class = "conversation_message">' + chatContent + '</p>' 
               + '</li>' );
        
     }
   
   function getUnread() {
      var userID = "${userId}"
      var csrfHN = "${_csrf.headerName}";
      var csrfTV = "${_csrf.token}";
      $.ajax({
         type : "POST",
         url : "/chat/unread",
         data : {
            userID : userID,

         },beforeSend : function(xhr) {
            xhr.setRequestHeader(csrfHN, csrfTV);
         },
         success : function(result) {
            //  0을 받으면 에러, 1이상을 받으면 정상처리
            if (result >= 1) {
               showUnread(result);
            } else {
               // 0이 입력받을 때 공백 처리
               showUnread('');
            }
         }
      });
   }
   // 반복적으로 서버한테 일정 주기 마다 자신이 읽지 않은 메시지 갯수를 요청하는 함수
   function getInfiniteUnread(){
      setInterval(function(){      
         getUnread();         
      }, 1000);
   }
   // unread라는 id값을 가진 원소 내부 값을 result로 담아주기.
   function showUnread(result){
      $('#unread').html(result);
   }
   // 사용자의 메시지함을 갱신하는 함수
    function getInfiniteBox() {
       setInterval(function() {
          chatBoxFunction();
       }, 1000);
    }
      
   
</script>
</html>