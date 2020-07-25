<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="/resources/js/login.js"></script>

<div id="subWrap" class="hdMargin">
	<section id="subContents" class="inner1200">
		<div id="login" class="card_body">
			<div class="tit_s1">
				<h2>login</h2>
			</div>				
			<input type="text" name="id" id="id" placeholder="Id"><br>
			<input type="password" name="pw" id="pw" placeholder="Password"><br>
			
			<div class="idSave">
				<ul class="checkBox_s1">
					<li class="">
						<input type="checkbox" name="rememberId" id="rememberId" name="rememberId"> 
						<label for="rememberId"><span></span>아이디 저장하기</label>
					</li>
				</ul>
			</div>
			
			
			<div class="loginBtn">
				
				<div class="btnS1 center ">
					<input type="button" value="Login" id="isIdPwSame">
				</div>
				<a id="login-form-btn" href="#;" onclick="loginFormWithKakao()">
					<span class="icon"><img src="/resources/img/login/kakao_login_large_wide.png" alt="카카오 로그인"></span>
				</a>
				<!-- 네이버 로그인 창으로 이동 
				<div id="naver_id_login" style="text-align:center">
					<a href="${url}">
						<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/>
					</a>
				</div>-->
			</div>

			<div id="other_text">
				<a href="#" class="side" id="idFind">id찾기</a>
				<a href="#"	class="side" id="pwFind">비밀번호 찾기</a>
				<a href="#" class="side" id="signup">회원가입</a>
			</div>
		</div>
	</section>
</div>

	<!--  카카오 회원가입 -->
	<form id="kakoForm" action="/member/snsSignUp?mem_type=kakao" method="post">
		<input type="hidden" name="kakaoId" id="kakaoId">
		<input type="hidden" name="kakaoNickname" id="kakaoNickname">
		<input type="hidden" name="kakaoProfile" id="kakaoProfile">
		<input type="hidden" name="kakaothumnail" id="kakaothumnail">
		<input type="hidden" name="pw" value="defalut">
		<!-- <input type="hidden" name="kakaoEmail" id="kakaoEmail">-->
	</form>
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script>
            // @details 카카오톡 Developer API 사이트에서 발급받은 JavaScript Key
            Kakao.init("51c6906054713d4819ea4a7363d66680");
            // @breif 카카오 로그인 버튼을 생성합니다.
            
            function loginFormWithKakao() {
                Kakao.Auth.loginForm({
                    success: function (authObj) {
                        //alert(JSON.stringify(authObj)); //<----Kakao.Auth.createLoginButton에서 불러온 결과값 json형태로 출력
                        Kakao.API.request({
                            url: "/v2/user/me",
                            success: function (res) {
                                /*
                                	res.id
                                	res.kaccount_email
                                	res.properties.nickname;
                               		res.properties.profile_image;
                               		res.properties.thumbnail_image;
                                */
                             // @breif 아이디
                                document.getElementById("kakaoId").value = res.id;
                                
                                /*
                                var kakaoid = document.getElementById("kakaoId").value;
                                kakaoid = res.id;
                                
                        			var regexid = /^(\d){8,10}/g;
                        			if(kakaoid.test(id)){
                        				alert("전화번호 로그인이 불가합니다.");
                        				return false;
                        			}
                                */
                                
                                
                                // @breif 닉네임
                                document.getElementById("kakaoNickname").value = res.properties.nickname;
                                document.getElementById("kakaoId").value = res.id;
                                document.getElementById("kakaoProfile").value = res.properties.profile_image;
                                document.getElementById("kakaothumnail").value = res.properties.thumbnail_image;
                                
                                var id = $('#kakaoId').val();
                                
                                $.ajax({
                                	url: "/member/isBlackForKakao",
                                	data: {id: id},
                                	type: "post"
                                }).done(function(resp){
                                	if (resp) {
                                		alert('블랙리스트로 등록되어 로그인하실 수 없습니다.');
                                	} else {
		                                document.getElementById("kakoForm").submit();
                                	}
                                })
                            }, fail: function (error) {
                                alert(JSON.stringify(error));
                            }
                        });
                    },
                    fail: function (err) {
                        alert(JSON.stringify(err))
                    },
                })
            }
        </script>
        
<jsp:include page="/WEB-INF/views/footer.jsp" />