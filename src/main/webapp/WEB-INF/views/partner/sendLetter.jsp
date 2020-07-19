</body><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(function(){
		var layerPop_s2 = $("#layerPop_s2");
		$(".letter").on("click", function(){
			$('#sender').val('');
			$('#receiver').val('');
			$('#letter_contents').val('');
			
			var from_id = '${sessionScope.loginInfo.id}';
			var from_name = '${sessionScope.loginInfo.name}';
			var to_id = $(this).closest("article").find(".id").val();
			var to_name = $(this).closest("article").find(".name").val();
			if (from_id == to_id) {
				alert('자신에게는 쪽지를 보낼 수 없습니다.');
				return false;
			}
			
			$('#sender').html(from_name + "(" + from_id + ")");
			$('#receiver').html(to_name + "(" + to_id + ")");
			
			layerPop_s2.stop().fadeIn();
		})
		
		$('#sendLet').on('click', function(){
			$('#sender').val('');
			$('#receiver').val('');
			$('#letter_contents').val('');
			
			var to_id = '${pdto.id}';
			var to_name = '${pdto.name}';
			
			var from_id = '${sessionScope.loginInfo.id}';
			var from_name = '${sessionScope.loginInfo.name}';
			
			if (from_id == to_id) {
				alert('자신에게는 쪽지를 보낼 수 없습니다.');
				return false;
			}
			
			$('#sender').html(from_name + "(" + from_id + ")");
			$('#receiver').html(to_name + "(" + to_id + ")");
			
			layerPop_s2.stop().fadeIn();
		})
		
		$(".rep_rec_let").on("click", function(){
			$('#sender').val('');
			$('#receiver').val('');
			$('#letter_contents').val('');
			
			var from_id = '${sessionScope.loginInfo.id}';
			var from_name = '${sessionScope.loginInfo.name}';
			var to_id = $(this).closest(".letter_con").prev().find('.rec_id').html();
			var to_name = $(this).closest(".letter_con").prev().find('.show_con').html();;
			
			to_name = to_name.split(' ')[0];
			
			$('#sender').html(from_name + "(" + from_id + ")");
			$('#receiver').html(to_name + "(" + to_id + ")");
			
			layerPop_s2.stop().fadeIn();
		})
		
		$('#send_letter_btn').on('click', function(){
			var to_name = ($('#receiver').html().split('('))[0];
			var to_id = ($('#receiver').html().split('('))[1];
			to_id = to_id.substring(0, to_id.length - 1);
			var contents = $('#letter_contents').val();
			
			$.ajax({
				url: "/letter/send",
				data: {
					to_id: to_id,
					to_name: to_name,
					contents: contents
				},
				type: "POST"
			}).done(function(resp){
				if (resp) {
					alert('쪽지를 성공적으로 전송했습니다.');
					
				} else {
					alert('쪽지 전송에 실패하였습니다. 잠시 후 다시 시도해 주세요.');
				}
				layerPop_s2.stop().fadeOut();
			})
		})
		
		$("#back2").on("click", function(){
			layerPop_s2.stop().fadeOut();
		})
	})
</script>
<style>
	#layerPop_s2 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none;  background:rgba(0,0,0,0.5); paddint: 15px; }
	#layerPop_s2 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff; width:90%;}
	#layerPop_s2 .tit_s3 { margin: 12px; text-align: center; font-size: 20px; font-weight: bold; }
	#layerPop_s2 .checkAgree { color: #999; }
	#layerPop_s2 .checkLabel { vertical-align: middle; }
	#layerPop_s2 .layer_let_btns { text-align: center; }
	#layerPop_s2 .layer_let_btns > button { width: 50px; height: 30px; border: 1px solid #ddd; color: #aaa; background-color: #fff; border-radius: 6px; }
	#layerPop_s2 .layer_let_btns > button:first-child { margin-right: 6px; }
	#layerPop_s2 .layer_let_btns > button:hover { background-color: #4c98ff; color: #fff; border: none; }
</style>
<article id="layerPop_s2">
	<div class="pop_body">
		<div class="tit_s3">
			<h3>쪽지 보내기</h3>
		</div>
		<input type="hidden" name="parent_seq" value="">
		<section>
			<article>
				<div>
					<span>보내는 사람</span>
					<span id="sender"></span>
				</div>
				<div>
					<span>받는 사람</span>
					<span id="receiver"></span>
				</div>
				<div>내용</div>
				<div class="contents">
					<textarea rows="30" cols="50" name="contents" id="letter_contents"></textarea>
				</div>
				<div class="layer_let_btns">
					<button id="send_letter_btn">전송</button>
					<button id="back2">닫기</button>
				</div>
			</article>
		</section>
	</div>
</article>