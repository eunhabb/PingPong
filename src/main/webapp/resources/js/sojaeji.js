var sojaeji = function(sido, gugun) {
	var obj = this;

	obj.sido = document.getElementById(sido);
	obj.gugun = document.getElementById(gugun);
	
	if(obj.sido.length == 0){
		obj.update_sido();
	}
	obj.update_gugun.apply(obj);
	obj.sido.onchange = function() {
		obj.update_gugun.apply(obj);
	}
}

sojaeji.prototype = {
	update_gugun : function() {
		if (this.gugun == null) return;
		var gugun = this[this.sido.value];
		this.gugun.innerHTML = "";
		for(var i=0; i<gugun.length; i++)
			this.gugun.options.add(new Option(gugun[i], gugun[i]));
	},
	update_sido : function() {
		if (this.sido == null) return;
		var sido = this['시도'];
		for(var i=0; i<sido.length; i++)
			this.sido.options.add(new Option(sido[i], sido[i]));
		this.update_gugun();
	},
 '시도' : ['시, 도 선택','서울특별시','부산광역시','대구광역시','인천광역시','광주광역시','대전광역시','울산광역시','강원도','경기도','경상남도','경상북도','세종특별자치시','전라남도','전라북도','제주특별자치도','충청남도','충청북도'],
 '시, 도 선택' : ['구, 군 선택'],
 '서울특별시' : ['구, 군 선택','강남구','강동구','강북구','강서구','관악구','광진구','구로구','금천구','노원구','도봉구','동대문구','동작구','마포구','서대문구','서초구','성동구','성북구','송파구','양천구','영등포구','용산구','은평구','종로구','중구','중랑구'],
 '부산광역시' : ['구, 군 선택','강서구','금정구','남구','동구','동래구','부산진구','북구','사상구','사하구','서구','수영구','연제구','영도구','중구','해운대구','기장군'],
 '대구광역시' : ['구, 군 선택','남구','달서구','동구','북구','서구','수성구','중구','달성군'],
 '인천광역시' : ['구, 군 선택','계양구','남동구','동구','미추홀구','부평구','서구','연수구','중구','강화군','옹진군'],
 '광주광역시' : ['구, 군 선택','광산구','남구','동구','북구','서구'],
 '대전광역시' : ['구, 군 선택','대덕구','동구','서구','유성구','중구'],
 '울산광역시' : ['구, 군 선택','남구','동구','북구','중구','울주군'],
 '강원도' : ['구, 군 선택','강릉시','동해시','삼척시','속초시','원주시','춘천시','태백시','고성군','양구군','양양군','영월군','인제군','정선군','철원군','평창군','홍천군','화천군','횡성군'],
 '경기도' : ['구, 군 선택','고양시 덕양구','고양시 일산동구','고양시 일산서구','과천시','광명시','광주시','구리시','군포시','김포시','남양주시','동두천시','부천시','성남시 분당구','성남시 수정구','성남시 중원구','수원시 권선구','수원시 영통구','수원시 장안구','수원시 팔달구','시흥시','안산시 단원구','안산시 상록구','안성시','안양시 동안구','안양시 만안구','양주시','여주시','오산시','용인시 기흥구','용인시 수지구','용인시 처인구','의왕시','의정부시','이천시','파주시','평택시','포천시','하남시','화성시','가평군','양평군','연천군'],
 '경상남도' : ['구, 군 선택','거제시','김해시','마산시','밀양시','사천시','양산시','진주시','진해시','창원시','통영시','거창군','고성군','남해군','산청군','의령군','창녕군','하동군','함안군','함양군','합천군'],
 '경상북도' : ['구, 군 선택','경산시','경주시','구미시','김천시','문경시','상주시','안동시','영주시','영천시','포항시 남구','포항시 북구','고령군','군위군','봉화군','성주군','영덕군','영양군','예천군','울릉군','울진군','의성군','청도군','청송군','칠곡군'],
 '전라남도' : ['구, 군 선택','광양시','나주시','목포시','순천시','여수시','강진군','고흥군','곡성군','구례군','담양군','무안군','보성군','신안군','영광군','영암군','완도군','장성군','장흥군','진도군','함평군','해남군','화순군'],
 '세종특별자치시' : ['구, 군 선택','반곡동','소담동','보람동','대평동','가람동','한솔동','나성동','새롬동','다정동','어진동','종촌동','고운동','아름동','도담동','조치원읍','연기면','연동면','부강면','금남면','장군면','연서면','전의면','전동면','소정면'],
 '전라북도' : ['구, 군 선택','군산시','김제시','남원시','익산시','전주시 덕진구','전주시 완산구','정읍시','고창군','무주군','부안군','순창군','완주군','임실군','장수군','진안군'],
 '제주특별자치도' : ['구, 군 선택','제주시','서귀포시'],
 '충청남도' : ['구, 군 선택','계룡시','공주시','논산시','보령시','서산시','아산시','천안시 동남구','천안시 서북구','금산군','당진군','부여군','서천군','연기군','예산군','청양군','태안군','홍성군'],
 '충청북도' : ['구, 군 선택','제천시','청주시 상당구','청주시 흥덕구','충주시','괴산군','단양군','보은군','영동군','옥천군','음성군','증평군','진천군','청원군']}