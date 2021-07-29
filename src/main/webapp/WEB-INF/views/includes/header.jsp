<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Fleax Market</title>

<!-- Custom fonts for this template -->
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">


   <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
   <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet">
      
      
   <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
   <link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
    <!-- Css Styles -->
    <link rel="stylesheet" href="/resources/css/chatBox.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/dropdw.css" type="text/css">
<!--     <link rel="stylesheet" href="/resources/css/bootstrap2.css"> -->
<!--    <link rel="stylesheet" href="/resources/css/custom.css"> -->
</head>

   <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>


    <!-- Header Section Begin -->
    <header class="header-section">
            <div class="inner-header">
                <div class="logo">
                    <a href="/"><img src="/resources/img/logo.png" alt="" ></a>
                </div>
                
          
                <nav class="main-menu mobile-menu">
                    <ul>
                      <sec:authorize access="permitAll()" >
                     <c:forEach items="${boardList}" var="board">
                        <c:choose>
                           <c:when test="${board.id == 4}">
                              <li><a href="/post/listBySearch?boardId=${board.id}&child=5">${board.name}</a></li>
                           </c:when>
                           <c:otherwise>
                              <li><a href="/post/listBySearch?boardId=${board.id}&child=0">${board.name}</a></li>
                           </c:otherwise>
                        </c:choose>
                  <!-- 그리고 url을 우리가 만드는건데, post가 board 안에 있는거니까 그 클래스 안에있는 객체명을 따라가야한다. -->
                     </c:forEach>
                  </sec:authorize>
                  
   
  
           
                  
                  
                  
               <sec:authorize access="isAuthenticated()" >
               <li>메시지함
                        	 <ul class="sub-menu" id ="boxTable">               	
                              </ul>
               </li>
               
               <li>내 정보
                            <ul class="sub-menu">
                                <li><a href="/party/modifyMember">회원 정보 수정</a></li>
                                <li><a href="/chat/chatBox">채팅방</a></li>
                                <sec:authorize access="isAuthenticated()" >
                                <li><a href="check-out.html">회원탈퇴</a></li>
                                </sec:authorize>
                                 <sec:authorize access="isAuthenticated()">
                                 
                       <form action="/" method="POST">
                           <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                           <input type="submit" value="로그아웃"></input>
                      </form>
                      </sec:authorize>
                          </ul>
                  </li>                     
             </sec:authorize>   
            
            <sec:authorize access="isAnonymous()" >   
            <li>로그인 |  회원가입
                          <ul class="sub-menu">             
                              <li><a href="/party/customLogin" >로그인</a></li>                        
                              <li><a href="/party/joinMember" >회원가입</a></li>                       
                        </ul>
                </li>   
                 </sec:authorize>    
              </ul>
          </nav>
       </div>

    </header>
 