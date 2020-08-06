<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>
	<script>
		$(function(){
			$("#listStyle1 > section").each(function(){
				var text = $(this).find(".contents").text();
				var seq = $(this).data("seq");
				$(this).children("article").wrap('<a href="/discussion/view?seq='+seq+'">')
			
				var tagLt = text.replace(/<a/gim,"$lta;");
				var tagGt = tagLt.replace(/a>/gim,"a$gt;");
				console.log(tagGt)
				if(text.length >= 300) { 
					tagGt = tagGt.substring(0,299)+"...";;
					$(this).find(".contents").text(tagGt);
				}else{
					$(this).find(".contents").text(tagGt);
				}
			})
			
			// 정렬 
			$("#align").on("change",function(){
				var selVal = $(this).val();
				var keywordType = $("#keyword_type").val();
				var keywordInput = $("#keyword_input").val();
				location.href="/discussion/align?cpage=1&align="+selVal+"&type="+keywordType+"&keyword=" + keywordInput
			});

			
			// 제목 / 글제목 / 글내욕
			$("#searchAsKeyword").click(function(){
				var keywordType = $("#keyword_type").val();
				var keywordInput = $("#keyword_input").val();
				if(keywordInput == ""){
					alert("검색어를 입력해주세요.")
					return false;
				}
				location.href = "/discussion/kewordSch?cpage=1&type="+keywordType+"&keyword=" + keywordInput	
			});
			
			$("#keyword_type").on("change",function(){
				var value = $(this).val();
				if(value == ""){
					$("#keyword_input").attr("readonly",true);						
					$("#keyword_input").val("");		
					location.href = "/discussion/list?cpage=1"
				}else{
					$("#keyword_input").attr("placeholder","검색어를 입력해주세요.")
					$("#keyword_input").removeAttr("readonly"); 
				}
			})
			
			$("#keyword_input").keyup(function(e){
				if(e.keyCode == 13){
					$("#searchAsKeyword").click();
					return false;
				}
			})
			

			
			function readonlyFn(){
				var value = $(this).val();
				if(value == ""){
					$("#keyword_input").attr("readonly",true);						
					$("#keyword_input").val("");						
				}else{
					$("#keyword_input").removeAttr("readonly"); 
				}
			}
		})
	</script>

	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="discussion_list" class="inner1200">
				<div class="tit_s1">
					<h2>Discussion</h2>
					<p>이야기하고 싶은 흥미로운 주제가 있으신가요? 여기에서 전 세계 외국어 학습자들과 <br>토론을 하고 소통해 보세요.</p>
				</div>
				<div id="tabContWrap" class="search_wrap">
						<div class="search_as_keyword">
							<section class="defaultSch">
								<div class="tit">검색어</div>
								<div class="schCon ">
									<select id="keyword_type" name="type">
										<option value="">전체</option>
										<option value="writer" <c:if test="${type == 'writer'}">selected</c:if>>작성자</option>
										<option value="title" <c:if test="${type == 'title'}">selected</c:if>>글제목</option>
										<option value="contents" <c:if test="${type == 'contents'}">selected</c:if>>글내용</option>
									</select>
									
									<c:choose>
										<c:when test="${empty keyword}">
											<input type="text" name="keyword" id="keyword_input" placeholder="카테고리 선택후 검색해주세요." readonly>
										</c:when>
										<c:otherwise>
											<input type="text" name="keyword" id="keyword_input" placeholder="검색어를 입력하세요." value="${keyword}">
										</c:otherwise>
									</c:choose>
								</div>
							</section>
							<div class="btnS1 center">
								<div><button type="button" id="searchAsKeyword">검색</button></div>
							</div>
						</div>
					</form>
				</div>
				<div class="btnS1 right">
					<div>
						<select name="align" id="align">
							<option value="recent" <c:if test="${alignType == 'recent'}">selected</c:if>>최신 순</option>
							<option value="like" <c:if test="${alignType == 'like'}">selected</c:if>>인기 순</option>
						</select>
					</div>
					<div><a href="/discussion/write" class="on">토론 글쓰기</a></div>
				</div>
				<div id="listStyle1" class="card_body">
					<c:choose> 
						<c:when test="${empty list}">
							토론 게시글이 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="i" items="${list}">
								<section data-seq="${i.seq}">
									<article>
										<div class="title">${i.title}</div>
										<div class="userInfo_s1">
											<!-- <div class="thumb"><img src="/resources/img/sub/userThum.jpg"/></div> -->
											<div class="thumb"><img src="/upload/member/${i.id}/${i.thumNail}"/></div>
											<div class="info">
												<p class="userId">${i.writer}(${i.id})</p>
												<p class="writeDate">${i.dateString}</p>
											</div>
										</div>										
										<div class="contents">${i.contents}</div>			
										<div class="sideInfo">
											<div class="lang_date">
												<div class="info-language">언어 : ${i.language}</div>			
											</div>
											<div class="countList">
												<ul>
													<li><i class="fa fa-eye"></i> ${i.view_count}</li>
													<li><i class="fa fa-commenting-o" aria-hidden="true"></i> ${i.comment_count}</li>
													<li><i class="fa fa-thumbs-up"></i> ${i.like_count}</li>
												</ul>
											</div>		
										</div>
									</article>
								</section>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				<div id="listNav">
					${navi}
				</div>
			</article>
		</section>
	</div>



<jsp:include page="/WEB-INF/views/footer.jsp"/>