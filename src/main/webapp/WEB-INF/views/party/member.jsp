<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="/resources/new_main.css">
</head>
 <body>
        <!-- header -->
        <div id="header">
            <a href="https://nid.naver.com/user2/V2Join.nhn?m=agree#agreeBottom" target="_blank" title="네이버 회원가입 페이지 보러가기"><img src="/resources/NAVER_CI_Green.png" id="logo"></a>
        </div>


        <!-- wrapper -->
        <div id="wrapper">

            <!-- content-->
            <div id="content">
				<form id="frmMember" method="post" action="/party/joinMember">
                <!-- ID -->
                <div>
                    <h3 class="join_title">
                        <label for="id">아이디</label>
                        <button id="idCheck">중복체크</button>
                    </h3>
                    <span class="box int_id">
                        <input type="text" id="userId" name="userId" class="int" maxlength="20">
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- PW1 -->
                <div>
                    <h3 class="join_title"><label for="pswd1">비밀번호</label></h3>
                    <span class="box int_pass">
                        <input type="text" id="userPwdOrgin" name ="userPwd" class="int" maxlength="20">
                        <span id="alertTxt">사용불가</span>
                        <img src="/resources/m_icon_pass.png" id="pswd1_img1" class="pswdImg">
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- PW2 -->
                <div>
                    <h3 class="join_title"><label for="pswd2">비밀번호 재확인</label></h3>
                    <span class="box int_pass_check">
                        <input type="text" id="userPwdCheck" name="userPwd" class="int" maxlength="20">
                        <img src="/resources/m_icon_check_disable.png" id="pswd2_img1" class="pswdImg">
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- NAME -->
                <div>
                    <h3 class="join_title"><label for="name">이름</label></h3>
                    <span class="box int_name">
                        <input type="text" id="name" name="name" class="int" maxlength="20">
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- BIRTH -->
                <div>
                    <h3 class="join_title"><label for="yy">생년월일</label></h3>

                    <div id="bir_wrap">
                        <!-- BIRTH_YY -->
                        <div id="bir_yy">
                            <span class="box">
                                <input id="birthDt" type="date" pattern="yyyy-MM-dd" class="form-control" name="birthDate"  >
                            </span>
                        </div>
                    </div>
                    <span class="error_next_box"></span>    
                </div>

                <!-- GENDER -->
                <div>
                    <h3 class="join_title"><label for="gender">성별</label></h3>
                    <span class="box gender_code">
                        <select id="gender" name="male"  class="sel">
                            <option>성별</option>
                            <option value="1">남자</option>
                            <option value="0">여자</option>
                        </select>                            
                    </span>
                    <span class="error_next_box">필수 정보입니다.</span>
                </div>

                <!-- EMAIL -->
                <div>
                    <h3 class="join_title"><label for="email">본인확인 이메일<span class="optional">(필수)</span></label></h3>
                    <span class="box int_email">
                        <input type="text" id="email" name="email" class="int" maxlength="100" placeholder="선택입력">
                    </span>
                    <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>    
                </div>
				
				
				<c:forEach items="${listCPType}" var="contactPointType" varStatus="status">
			<div class="form-group">
				<label>"${contactPointType.description}"</label>
				<input type="hidden" name="listContactPoint[${status.index}].contactPointType" value="${contactPointType.cpType}" class="form-control" readonly>
				<input name="listContactPoint[${status.index}].info"  class="form-control">
			<!-- 여긴 중요한게, 객체를 만들어주는 부분이다. 제목을 넣는 부분 -->
			</div>
			</c:forEach>
			<input type="hidden" name = "descrim" value="${memberType.partyType}">
			<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
				
                <!-- MOBILE -->
                <div>
                    <h3 class="join_title"><label for="phoneNo">휴대전화</label></h3>
                    <span class="box int_mobile">
                        <input type="tel" id="mobile" class="int" maxlength="16" placeholder="전화번호 입력">
                    </span>
                    <span class="error_next_box"></span>    
                </div>


                <!-- JOIN BTN-->
                <div class="btn_area">
                    <button type="button" id="btnJoin">
                        <span>가입하기</span>
                    </button>
                </div>
				</form>
                

            </div> 
            <!-- content-->

        </div> 
        <!-- wrapper -->
    <script src="/resources/main2.js"></script>
    </body>
    
    <script type="text/javascript">
$(document).ready(function() {
	var csrfHN = "${_csrf.headerName}";
	var csrfTV = "${_csrf.token}";
	
	$(document).ajaxSend(
		function(e, xhr){
			xhr.setRequestHeader(csrfHN, csrfTV);
		}
	);
	
	
	$("#idCheck").on("click", function(){
		id = $("#userId").val();
		
		$.ajax({	
		    url: '/party/idCheck',
		    type: 'POST',
		    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
		    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
		    data: id,

		    success: function(data){
		    	console.log(data);
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


</script>
</html>