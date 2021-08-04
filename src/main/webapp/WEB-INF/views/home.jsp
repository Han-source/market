<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="includes/header.jsp"%>
<div style="height: 10vh;">

</div>
<div class="mainCcontainer">
	<div class="section">
	   <input type="radio" name="slide" id="slide01" checked>
	   <input type="radio" name="slide" id="slide02">
	   <input type="radio" name="slide" id="slide03">
	   <div class="slidewrap">
	      <ul class="slidelist" >
	         <!-- 슬라이드 영역 -->
	         <li class="slideitem">
	            <a>
	               <img src="/resources/img/icons/slide01.jpg">
	            </a>
	         </li>
	         <li class="slideitem">
	            <a>
	               <img src="/resources/img/icons/slide02.jpg">
	            </a>
	         </li>
	         <li class="slideitem">
	            <a>
	               <img src="/resources/img/icons/slide03.jpg">
	            </a>
	         </li>
	         <!-- 좌,우 슬라이드 버튼 -->
	         <div class="slidecontrol">
	            <div>
	               <label for="slide03" class="left"></label>
	               <label for="slide02" class="right"></label>
	            </div>
	            <div>
	               <label for="slide01" class="left"></label>
	               <label for="slide03" class="right"></label>
	            </div>
	            <div>
	               <label for="slide02" class="left"></label>
	               <label for="slide01" class="right"></label>
	            </div>
	         </div>
	      </ul>
	      <!-- 페이징 -->
	      <ul class="slide-pagelist">
	         <li><label for="slide01"></label></li>
	         <li><label for="slide02"></label></li>
	         <li><label for="slide03"></label></li>
	      </ul>
	   </div>
	</div>
</div>

<%@include file="includes/footer.jsp"%>
