<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script>
	$(function() {
		$(".box").on("click", function() {
			var seq = $(this).find(".seq").html();
			location.href = "/partner/partnerView?seq=" + seq;
		})
		
		$('#partnerBtn').on('click', function(){
			var checkboxCount = $("input:checkbox[name='contactList']").length;
			console.log('checkboxCount: ' + checkboxCount)
			var selectedContact = [];
			
			for (var i = 0; i < checkboxCount; i++) {
				var inputChecked = $("input:checkbox[name='contactList']:eq(" + i + ")").is(":checked");
				if (inputChecked) {
					selectedContact.push($("input:checkbox[name='contactList']:eq(" + i + ")").val());
					console.log('selectedContact: ' + selectedContact)
				}
			}
			
			$("#contact").val(selectedContact);
			
			$('#partnerRegister').submit();
		})
		
		$(".button_aa .email_a").on("click", function(e) {
			//e.stopPropagation(); // 부모의 태그를 막음
			alert("이메일 페이지로 이동하실께요.");
			var seq = $(this).closest('.button_aa').siblings('.box').find('.seq').html();
			location.href = "/partner/selectPartnerEmail?seq=" + seq;
		})   
		
	
		//시군 
		   new sojaeji('sido1', 'gugun1');
				 var addrTxt = "";
		   
		   $('#sido1').change(function(){
		         var sido = $("#sido1").val();
		         addrTxt = sido;
		         $('#address').val(sido);
		    });  
		   $('#gugun1').change(function(){
		         var gugun = $("#gugun1").val();
		         console.log(gugun);
		         console.log(addrTxt + ' ' + gugun)
		         $('#address').val(addrTxt + ' ' + gugun);
		    });  

		new sojaeji('sido1', 'gugun1');
		   
		$('#gugun1').change(function(){
			var sido = $('#sido1 option:selected').val();
			var gugun = $('#gugun1 option:selected').val();
			console.log(sido);
			console.log(gugun);
			console.log($('#address').val(sido + ' ' + gugun));
		});
		
		//최신순, 평점순
		var orderBy = '${orderBy}';
		if(orderBy != null){
			$("#orderBy").val(orderBy);
			console.log(orderBy);
		}else{
			$('#orderBy').val('seq');
		}
		
		$('#orderBy').on('change',function(){
			var orderByVal = $('#orderBy').val();
			location.href='/partner/partnerList?orderBy='+orderByVal;
		})
		
	})
</script>
<body>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>	
	<br>
	<br>
	<br>
	<div class="profileShareAgree">
		<form action="/partner/insertPartner" id="partnerRegister" method="post">
			<h2>파트너를 등록해주세요</h2>
			<div>자신의 프로필을 공유하여 다른 사람들과 소통해보세요.</div>
			프로필 공유 동의 <input type="checkbox" name="agree" id="agree">(필수)<br> 
			<span><input type="checkbox" name="contactList" id="letter" >쪽지</span> 
			<span><input type="checkbox" name="contactList" id="email" >이메일</span> 
			<span><input type="checkbox" name="contactList" id="chatting" >채팅</span><br>
			<input type="hidden" name="contact" id="contact">
			1:1 기본적으로 제공되는 서비스입니다.
			<button type="button" id="partnerBtn">등록</button>
		</form>
	</div>
	
	
	${loginInfo}
	<form action="/partner/partnerSearch" method="post" id="test">
		<div>
			<input type="text" name="name" placeholder="파트너의 이름">
		</div>
		<div class="partnerSearch">
			<select name="age" id="age" onchange="setSelectBox(this)">
				<option value="" disabled selected >나이대</option>
				<option value="1">10대</option>	
				<option value="2">20대</option>	
				<option value="3">30대</option>	
				<option value="4">40대</option>	
				<option value="5">50대</option>
			</select>
			<select name="gender" id="gender">
				<option value="" disabled selected >성별</option>
				<!-- <option value="전체">전체</option> -->
				<option value="남자">남자</option>	
				<option value="여자">여자</option>
			</select>
			
			<input type="hidden" id="address" name="address">
			<select name="sido1" id="sido1"></select>
            <select name="gugun1" id="gugun1"></select>
                                       
			<select name="lang_can" id="lang_can">
				<option value="" disabled selected >구사언어</option>
				<c:forEach var="ldto" items="${ldto}">
					<option value="${ldto.language}">${ldto.language}</option>
				</c:forEach>
			</select>
			<select name="lang_learn" id="lang_learn">
				<option value="" disabled selected >학습언어</option>
				<c:forEach var="ldto" items="${ldto}">
					<option value="${ldto.language}">${ldto.language}</option>
				</c:forEach>	
			</select>
			<select name="hobby" id="hobby">
				<option value="" disabled selected >취미</option>
				<!-- <option value="NULL">전체</option> -->
				<c:forEach var="hdto" items="${hdto}">
					<option value="${hdto.hobby}">${hdto.hobby}</option>
				</c:forEach>
			</select>
		</div>
		<input type="submit" value="검색">
	</form>
	
	<div class="orderBy">
		<select id="orderBy">
			<option value="seq">최신순</option>
			<option value="review_point">평점순</option>
		</select>
	</div>
	
	<div class="partnerBox">
		<c:choose>
			<c:when test="${empty plist}">
				등록된 파트너가 없습니다.
			</c:when>
			<c:otherwise>
				<c:forEach var="plist" items="${plist}">
					<div>
						<div class="box">
							<span class="seq">${plist.seq}</span> 
							<img src ="/upload/member/${plist.id}/${plist.sysname}">
							${plist.name}, ${plist.age}<br> 
							아이디 : ${plist.id}<br> 
							성별 :${plist.gender}<br> 
							이메일 : ${plist.email}<br> 
							구사 가능한 언어 :${plist.lang_can}<br> 
							배우고 싶은 언어 : ${plist.lang_learn}<br>
							취미 : ${plist.hobby}<br> 
							자기 소개 : ${plist.introduce}
						</div>
						<div class="button_aa">
							<button class="letter">쪽지</button>
							<button class="chatting" data-uid="${plist.id}" data-name="${plist.name}">채팅</button>
							<button class="email_a">이메일</button>
						</div>
					</div><hr>						
				</c:forEach>
			</c:otherwise>
		</c:choose>	
	</div>
	
	<div class="navi">${navi}</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>