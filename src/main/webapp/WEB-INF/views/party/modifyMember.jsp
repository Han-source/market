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
        <div class = "signUp">
            <h1>회원정보 수정</h1>
        </div>
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-body">
                    <form id="frmMember" method="post" action="/party/modifyMember">
                <div class="form-group idBox">
                    <input id="userId" name="userId"  value="${partyId}" class="form-control" readonly>
                </div>
                
                <div id="PwdCheck" class="form-group">
                        <input id="userPwdOrgin" name="userPwdOrigin" placeholder="비밀번호" type="password" class="form-control">
                        <input id="userPwdCheck" name="userPwd" placeholder="비밀번호 재확인" type="password" class="form-control">
                        <p id="pwCheckMsg"></p>
                </div>
    
				<div class="form-group">
					<label>이름</label>
					<input  type="text" name="name" placeholder="재미있는걸로" class="form-control" >
					<!-- rows: 몇줄까지 화면에 보이게 할건지 -->
				</div>
				
<!-- 			<c:forEach items="${listCPType}" var="contactPointType" varStatus="status">
					<div class="form-group">
					<c:if test="${status.index eq 1}">
						<label>"${contactPointType.description}"</label>
						<input type="hidden" name="listContactPoint[${status.index}].contactPointType" value="${contactPointType.cpType}" class="form-control" readonly>
						<input name="listContactPoint[${status.index}].info"  class="form-control">
					</c:if>
					</div>
				</c:forEach>
-->
				<div class="form-group">
						<label>${listCPType[1].description}</label>
						<input type="hidden" name="listContactPoint[1].contactPointType" value="${listCPType[1].cpType}" class="form-control" readonly>
						<input name="listContactPoint[1].info"  class="form-control">
					<!-- 여긴 중요한게, 객체를 만들어주는 부분이다. 제목을 넣는 부분 -->
				</div>
				
				<input type="hidden" name = "descrim" value="${memberType.partyType}">
				<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
				<button id="btnJoin" type="submit" class="btn btn-primary">회원 정보 수정</button>
				<button id="btnJoin"  class="btn btn-primary" ><a href="/">취소</a></button>
			</form>

		</div>
	</div>
    </div>
    
    <!-- End of Main Content -->
    
    
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/resources/js/sb-admin-2.min.js"></script>


   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
            if($('#userPwdOrgin').val()!=$('#userPwdCheck').val()){
                $('#pwCheckMsg').text('');
                  $('#pwCheckMsg').html("<font color='#FF3333'>패스워드 확인이 불일치 합니다. </font>");
             }else{
                  $('#pwCheckMsg').text('');
                  $('#pwCheckMsg').html("<font color='#70AD47'>패스워드 확인이 일치 합니다.</font>");
             }
        });
        
            
            $("#idCheck").on("click", function(e){
                e.preventDefault();
    
    
            id = $("#userId").val();
            $.ajax({	
                url: '/party/idCheck',
                type: 'POST',
                dataType: 'text', //서버로부터 내가 받는 데이터의 타입
                contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
                data: id,
                success: function(data){
                     if(data == 0){
                     console.log("아이디 없음");
                     alert("사용하실 수 있는 아이디입니다.");
                     }else{
                         console.log("아이디 있음");
                         alert("중복된 아이디가 존재합니다.");
                     }
                },
                error: function (){        
                }
              });
        });
    });
    
    var result = document.querySelector(".result");
    
    function validation() {
        var number = document.getElementById("phoneNumber").value;
        var numberpattern = /^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/;
    
        if (numberpattern.test(number)) {
            result.innerHTML = "올바른 번호입니다!";
        }
        else {
            result.innerHTML = "올바른 번호를 입력해주세요!";
        }
    }
    
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');
    
    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }
    
    function execPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
    
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
    
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
    
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
    
                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width: '100%',
            height: '100%',
            maxSuggestItems: 5
        }).embed(element_layer);
    
        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';
    
        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }
    
    function initLayerPosition() {
        var width = 300; //팝업창 width
        var height = 400; //팝업창 height
        var borderWidth = 5; //팝업창 border 두께
    
        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth) + 'px';
    }
    
    </script>
</body>
</html>