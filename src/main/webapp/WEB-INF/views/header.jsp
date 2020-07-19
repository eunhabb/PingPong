<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="/resources/js/summernote.js"></script>
<script src="/resources/js/summernote-ko-KR.js"></script>
<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script> -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/sojaeji.js"></script>
<script src="/resources/js/slick.min.js"></script>
<script src="/resources/js/common.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 <script type="text/javascript">
     var windowWidth = window.screen.width
     setViewPort(windowWidth);

     function setViewPort(w_width) {
         if (w_width <= 359) {
             $("meta[name=viewport]").attr("content", "width=359, maximum-scale=2.0, user-scalable=no, target-densitydpi=medium-dpi");
         } else {
             $("meta[name=viewport]").attr("content", "width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi");
         }
     }
     $(window).resize(function() {
         var windowWidth = window.screen.width
         setViewPort(windowWidth);
     });

 </script>
</head>
   <body>
      <header>
         <section id="hdTop">
            <div class="inner1200">
               <div class="util">
                  <ul>
                  <%-- <li class="alram"><a href="/alarm/alarm2"><img src="/resources/img/common/alram.png"><span class="length"><c:out value="${alarmCount}"/></span></a></li> --%>
                  <c:if test="${sessionScope.loginInfo != null}">
	                  <li class="welcome_line"><p>${sessionScope.loginInfo.name} 님 환영합니다.</p></li>
                  </c:if>
                  <c:choose>
                     <c:when test="${empty sessionScope.loginInfo}">
                        <li><a href="/member/login">Login</a></li>
                        <li><a href="/member/joinMail">Join</a></li>
                     </c:when>
                     <c:otherwise>
                        <li>
                            <a href="/member/myInfo">MyPage </a>
                           <ul class="depth2">
                              <li><a href="/member/myInfo">나의 정보수정</a></li>
                              <li><a href="/mypage/tutorRecord">나의 강의목록</a></li>
                              <li><a href="/mypage/groupRecord">모임기록</a></li>
                              <li><a href="/mypage/likeRecord">찜목록</a></li>
                              <li><a href="/letter/letterList">쪽지함</a></li>
                           </ul>
                        </li>
                        <li><a href="/member/logout">Logout</a></li>
                     </c:otherwise>
                  </c:choose>
               </ul>
            </div>
         </div>
      </section>
      <section id="hdBot">
         <div class="inner1200 clearfix">
            <h1 class="logo"><a href="/"><img src="/resources/img/common/logo.png"/></a></h1>
            <nav>
            	<div class="mClose"><button type="button"><i class="fa fa-times" aria-hidden="true"></i></button></div>
               <div >
                  <ul class="clearfix gnb">
                     <li>
                        <a href="/partner/partnerList?cpage=1&align=recent">Partner</a>
                        <ul class="depth2">
                           <li><a href="/partner/partnerList?cpage=1&align=recent">파트너 목록</a></li>
                           <li><a href="#;" class="resiterPop">파트너 등록</a></li>
                        </ul>
                     </li>
                     <li>
                        <a href="/group/main?schType=keyword&orderBy=seq&ing=all">Group</a>
                        <ul class="depth2">
                           <li><a href="/group/main?schType=keyword&orderBy=seq&ing=all">그룹 찾기</a></li>
                           <li><a href="/group/write">그룹 등록</a></li>
                        </ul>
                     </li>
                     <li>
                        <a href="/tutor/tutorList">Tutor</a>
                        <ul class="depth2">
                           <li><a href="/tutor/tutorList" >튜터 목록</a></li>
                           <li><a href="#;" id="tutorApp" data-grade="${loginInfo.grade}">튜터 신청</a></li>
                           <li><a href="/tutor/lessonList?schType=keyword&orderBy=seq&keywordSelect=name">강의 목록</a></li>
                        </ul>
                     </li>                                    
                     <li>
                        <a href="/discussion/list?cpage=1">Board</a>
                        <ul class="depth2">
                           <li><a href="/discussion/list?cpage=1">토론</a></li>
                           <li><a href="/correct/correct_list">질문</a></li>
                           <li><a href="/news/listProc">소식</a></li>
                        </ul>
                     </li>                                    
                     <li>
                        <a href="/guide/info">Guide</a>
                     </li>                                    
                     <li>
                        <a href="/developer/list">Developer</a>
                     </li>                                    
                  </ul>
               </div>
            </nav>
            <div class="mMenu"><button type="button"><i class="fa fa-bars" aria-hidden="true"></i></button></div>
         </div>
      </section>
   </header>
