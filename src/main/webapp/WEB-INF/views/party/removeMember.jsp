<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>Spring Project</title>
	
	<link rel="stylesheet" href="/resources/css/signup.css" type="text/css">

	<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>

<body id="page-top">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
</head>

<!-- Begin Page Content -->
<div class="container-fluid">
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
      <div class="card-body">
         <form id="frmMember" action="/party/removeMember" method="post">
         <div id="PwdCheck" class="form-group">
         <h1>회원탈퇴 </h1>
         <h3 style="color: red;">${error}</h3>
         <br>
         <label>암호를 입력하세요.</label>
           <input id="userPwdCheck" name="userPwd" type="password" class="form-control"> 
         <p id="pwCheckMsg"></p>
            </div>
            
            
            <input type="hidden" id = "userPwd" name="userPassword" value="${userPassword}"> 
            <input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
            <button id="btnJoin" type="submit" class="btn btn-primary">회원탈퇴</button>
			<button id="btnJoin"  class="btn btn-primary" ><a href="/">취소</a></button>
         </form>
	</div>
	</div>
      </div>
   


<!-- End of Main Content -->
<script type="text/javascript">
$(document).ready(function() {
   var csrfHN = "${_csrf.headerName}";
   var csrfTV = "${_csrf.token}";
   
    
   $(document).ajaxSend(
      function(e, xhr){
         xhr.setRequestHeader(csrfHN, csrfTV);
      }
   );
   
   $("#userId").on("focusout", function(e) {
      //회원 ID가 유일한가를 Ajax 검사하고 그렇지 못할 때는 Focus를 다시 받아야 합니다. 
   });
   var frmPost = $("#frmPost");

   //비밀번호 일치 확인
   $('#PwdCheck').keyup(function(){
      if($('#userPwd').val()!=$('#userPwdCheck').val()){
         $('#pwCheckMsg').text('');
           $('#pwCheckMsg').html("<font color='#FF3333'>패스워드 확인이 불일치 합니다. </font>");
       }else{
           $('#pwCheckMsg').text('');
           $('#pwCheckMsg').html("<font color='#70AD47'>패스워드 확인이 일치 합니다.</font>");
       }
   });
   
      
//       $("#idCheck").on("click", function(e){
//          e.preventDefault();


//       id = $("#userId").val();
//       $.ajax({   
//           url: '/party/idCheck',
//           type: 'POST',
//           dataType: 'text', //서버로부터 내가 받는 데이터의 타입
//           contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
//           data: id,
//           success: function(data){
//                if(data == 0){
//                console.log("아이디 없음");
//                alert("사용하실 수 있는 아이디입니다.");
//                }else{
//                   console.log("아이디 있음");
//                   alert("중복된 아이디가 존재합니다.");
//                }
//           },
//           error: function (){        
//           }
//         });
//    });
});



</script>