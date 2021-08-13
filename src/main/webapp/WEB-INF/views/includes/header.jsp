<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
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
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet"> -->
<!-- Custom fonts for this template end-->

<!-- <link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet"> -->
<!-- Css Styles -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" type="text/css">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<!-- <link rel="stylesheet" href="/resources/css/font-awesome.min.css" type="text/css"> -->
<link rel="stylesheet" href="/resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/magnific-popup.css" type="text/css">
<link rel="stylesheet" href="/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/style.css" type="text/css">
<!--     <link rel="stylesheet" href="/resources/css/dropdw.css" type="text/css"> -->
<link rel="stylesheet" href="/resources/css/custom.css">
<link rel="stylesheet" href="/resources/css/banner.css" type="text/css">

<!-- Css Styles  end-->
</head>
<header class="header-section">
	<sec:authorize access="isAnonymous()">
		<ul class="sub-menu">
			<li style="visible: hidden; float: right; color: #1e1e1e;display: block;"><a href="/party/joinMember">JOIN</a></li>
			<li style="visible: hidden; float: right; color: #1e1e1e;display: block;"><a href="/party/customLogin">LOGIN </a></li>
		</ul>
	</sec:authorize>
	<div class="inner-header">
		<sec:authorize access="isAuthenticated()">
			<form action="/" method="POST">
				<fieldset style="float: right; border: 2 solid #9FB6FF; padding: 15">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" autofocus /> <input type="submit"
						value="로그아웃"></input>
				</fieldset>
			</form>
		</sec:authorize>
		<hr>
		<div class="logo">
			<a href="/"><img style="width: 151; height: 151;"
				src="/resources/img/icons/FleaxIcon1.png" alt="FleaxImg"></a>
		</div>
		<!-- Menu Bar -->
		<nav class="main-menu">
			<ul class="sub-menu">
				<!-- ul tag에서 공지사항bd=1, FAQbd=2, 자유게시판bd=3, 중고거래bd=4 -->
				<sec:authorize access="permitAll()">
					<c:forEach items="${boardList}" var="board">
								<li>
									<c:if test="${board.id == 1}">
										<a href="/post/listBySearch?boardId=${board.id}&child=0">
											<img src="/resources/img/icons/notice.png" style="float: bottom; width: 24px; height: 25px; margin: 0px, 8px;">${board.name}
										</a>												
									</c:if>
									<c:if test="${board.id == 2}">
										<a href="/post/listBySearch?boardId=${board.id}&child=0">
											<img src="/resources/img/icons/faqIcon.png" style="float: bottom; width: 24px; height: 25px; margin: 0px, 8px;">${board.name}
										</a>
									</c:if>
									<c:if test="${board.id == 3}">
										<a href="/post/listBySearch?boardId=${board.id}&child=0">
											<img src="/resources/img/icons/board.png" style="float: bottom; width: 24px; height: 25px; margin: 0px, 8px;">${board.name}
										</a>
									</c:if>
									<c:if test="${board.id == 4}">
										<a href="/business/productList?boardId=${board.id}&child=5">
											<img src="/resources/img/icons/tradeIcon.png" style="float: bottom; width: 24px; height: 25px; margin: 0px, 8px;">${board.name}
										</a>
									</c:if>
								</li>	
					</c:forEach>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<li>
						<img src="/resources/img/icons/chatIcon.png" style="float: bottom; width: 24px; height: 25px;" alt="chatIcon">
							메시지 함
						<ul class="sub-menu" id="boxTable"> </ul>
					</li>
					<li>
						<img src="/resources/img/icons/UserIcon.png" style="width: 24px; height: 25px;" alt="userIcon">
							내 정보 
							  <ul class="sub-menu">
                                <li><a href="/party/modifyMember">회원 정보 수정</a></li>
                                <li><a href="/chat/chatBox">채팅방</a></li>
                                <li><a href="/party/shoppingCart">장바구니</a></li>
                                <li><a href="/business/paymentHistory">결제내역</a></li>
                                <li><a href="party/removeMember">회원탈퇴</a></li>
		            	        <form action="/" method="POST">
	                    		    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                        		<input type="submit" value="로그아웃" />
			    	        	</form>
            	        </ul>
					</li>
				</sec:authorize>
			</ul>
		</nav>
	</div>
</header>