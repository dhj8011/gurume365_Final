<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/joinPermission.css'/>">
<script src="<c:url value='/resources/js/jquery-3.2.1.js' />"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
/* 결제API적용 */
var budjet = $('#revValue2').attr('budjet');
var no = $('#revValue2').attr('no');
var datetime = $('#revValue2').attr('d')
var person = $('#revValue2').attr('p');
var content = $('#revValue2').attr('c');
var ppno = $('#revValue2').attr('pp');
var ttno = $('#revValue2').attr('tt');

function permissionCheck(){
	var check1 = document.getElementById("check1");
	var check2 = document.getElementById("check2");
	
	if(!check1.checked){
		alert("이용약관동의를 체크해주세요");
		return false;
	}
	if(!check2.checked){
		alert("개인정보 수집정보 동의를 체크해주세요");
		return false;
	}
	
	if(check1.checked&&check2.checked){
		
	
	var amount = parseInt(budjet)*0.1*ttno.length;
	IMP.init('imp35693442');
	IMP.request_pay({
	    pg : 'kakao',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '주문명:결제테스트',
	    amount : amount,
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456',
	    kakaoOpenApp : true
	}, function(rsp) {
	    if ( rsp.success ) {
	    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	    	jQuery.ajax({
	    		url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
	    		type: 'POST',
	    		dataType: 'json',
	    		data: {
		    		imp_uid : rsp.imp_uid
		    		//기타 필요한 데이터가 있으면 추가 전달
	    		}
	    	})
	    	var msg = '결제가 완료되었습니다.';
			msg += '\n고유ID : ' + rsp.imp_uid;
			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
			msg += '\결제 금액 : ' + rsp.paid_amount;
			msg += '카드 승인번호 : ' + rsp.apply_num;
			
			alert(msg);
			$('.close-modal ').get(0).click();
			$('#ff').attr('href','../reservation/reservationComplete?shop_no='+no+'&datetimepicker='+datetime+'&person='+person+'&content='+content+'&ppno='+ppno+'&ttno='+ttno);
			$('#ff').get(0).click();
			
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        
	        alert(msg);
	        $('.close-modal ').get(0).click();
			$('#ff').attr('href','../reservation/reservationComplete?shop_no='+no+'&datetimepicker='+datetime+'&person='+person+'&content='+content+'&ppno='+ppno+'&ttno='+ttno);
			$('#ff').get(0).click();
	    }
	});
	
	}
	
	
}
function permissionCancle(){
	location.href = "../"
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[ joinPermission.jsp ]</title>
</head>
<body>

<div id="joinPermission_main">
	<div id="joinPermission_title">
		gurume365
	</div>
	
	<div id="joinPermission_check1">
		<input type="checkbox" id="check1">결제 약관 동의
	</div>
	
	<div id="joinPermission_content1">
		<textarea rows="5" cols="58" readonly="readonly">제1조 (목적)
 
본 약관은 Gurume365(이하 “회사”라 합니다)가 제공하는 Gurume365 서비스의 이용과 관련하여 회사와 회원 사이의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
_
제2조 (용어의 정의)
 
① 본 약관에서 사용하는 용어의 의미는 다음과 같습니다.
1. ‘Gurume365 서비스’라 함은 회원이 제휴사와 상품 또는 용역(이하 ‘상품 등’이라고 합니다)을 거래함에 있어서 회사가 제공하는 결제서비스, 회원 사이에 사용 가능한 송금서비스, 제휴사의 멤버십서비스, 카카오포인트서비스, 쿠폰서비스, 청구서서비스 등 회사가 회원에게 제공하는 서비스를 총칭합니다.
2. ‘회원’이라 함은 본 약관에 따라 회사가 제공하는 카카오페이 서비스를 이용하는 자를 말합니다.
3. ‘제휴사’라 함은 회사와 계약을 체결하고 카카오페이 서비스를 이용하여 회원에게 상품 등을 판매하거나 멤버십・카카오포인트・쿠폰 등의 혜택을 제공하는 사업자를 말합니다.
4. ‘결제방법’이라 함은 회원이 결제서비스를 통하여 전자적 방법으로 상품 등을 구입 및 이용시 선택한 지불방법을 말합니다.
5. ‘Gurume365 비밀번호’라 함은 카카오페이 서비스 이용 시 필요로하는 인증 수단으로서 회원이 본인임을 사전에 확인하고 스스로 설정하여 회사에 등록한 숫자를 말합니다.
6. ‘Gurume365’라 함은 ‘회원’이 직접 유상 충전 또는 다른 회원으로부터 받는 등의 다양한 방법으로 충전하거나, 상품 등의 구매 또는 이벤트 등을 통해 받은 후 판매자로부터 상품 등을 구매하면서 결제서비스를 통하여 지급할 수 있는 선불전자지급수단을 말합니다.
7. ‘Gurume365’라 함은 회원이 제휴사에서 상품 등을 구매하거나 이벤트 등에 참여 후 정당하게 적립 받은 후 회사가 지정한 사용처에서 상품 등 구매에 따른 결제시 사용할 수 있는 가상의 데이터를 말합니다.
8. ‘쿠폰’이라 함은 회원이 제휴사를 통해 상품 등을 구매할 때 제공 받을 수 있는 혜택이 전자적 방법으로 저장・기록되어 있는 증표를 말합니다.
9. ‘청구기관’이라 함은 회사와 별도 계약을 체결하고 청구서서비스를 통해 회원에게 청구정보를 제공하고 납부를 요청하는 법인 또는 기관 등을 말합니다.
10. ‘청구정보’라 함은 청구서서비스를 통해 청구기관이 회원에게 보내는 청구서 및 고지서의 내용, 영수증, 마케팅 등의 정보를 말합니다.
11. ‘청구서 및 고지서’는 회원이 청구기관과의 계약 또는 법령에 따라 납부해야 하는 이용요금 및 공과금 등의 정보가 포함된 전자문서를 말합니다.
12. ‘전자고지’는 청구기관이 청구서서비스를 통해 회원에게 청구정보를 전송하는 것을 말합니다.
13. ‘자동납부’는 본 약관에 따른 결제서비스를 이용하여, 청구서서비스 내에서 정기적으로 발생하는 청구기관의 청구서 및 고지서의 이용요금 및 공과금 등을 자동으로 납부할 수 있는 기능을 말합니다.
② 본 약관에서 사용하는 용어 중 본 조에서 정하지 아니한 것은 카카오페이 서비스 웹페이지 안내 및 관계법령에서 정하는 바에 따르며, 그 외에는 일반 상관례에 따릅니다.
_
제3조 (약관의 명시 및 효력변경)
 
① 회사는 본 약관의 내용을 회원이 쉽게 알 수 있도록 카카오페이 서비스의 화면 내 또는 별도의 연결화면에 게시하거나 팝업화면 등으로 제공합니다.
② 회사는 관련 법령을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.
③ 회사가 본 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 제1항의 방식에 따라 그 개정약관을 적용일자 7일 전부터 적용일자 전일까지 공지합니다. 다만, 회원에게 불리한 약관 개정의 경우에는 적용일자 30일 이전에 공지하며, 공지 외에 일정기간 회원의 전자우편 등의 전자적 수단을 통해 통지합니다.
④ 회사가 전항에 따라 개정약관을 공지 또는 통지하면서 회원에게 30일 기간 내에 의사표시를 하지 않으면 의사표시가 표명된 것으로 본다는 뜻을 명확하게 공지 또는 통지하였음에도 회원이 명시적으로 거부의사를 표명하지 아니한 경우 회원이 개정약관에 동의한 것으로 봅니다.
⑤ 회원이 개정약관의 내용에 동의하지 않는 경우 회사는 해당 회원에 대하여 개정약관의 내용을 적용할 수 없으며, 이 경우 회원은 이용계약을 해지할 수 있습니다. 다만, 회사가 개정약관에 부동의 한 회원에게 기존 약관을 적용할 수 없는 특별한 사정이 있는 경우에는 회사는 해당 회원과의 이용계약을 해지할 수 있습니다.
_
제4조 (약관 외 준칙)
 
① 회사는 필요한 경우 개별 카카오페이 서비스에 관하여 적용될 사항을 위해 개별약관이나 이용정책을 정하여 운영할 수 있으며, 해당 내용은 홈페이지 등을 통해 공지합니다.
② 본 약관에서 정하지 아니한 사항은 전자금융거래이용약관 및 전자금융거래법이 우선 적용됩니다.
③ 회원은 항상 개별약관이나 이용정책의 내용에 변경이 있는지 여부를 주시하여야 하며, 변경사항의 공지가 있을 시에는 이를 확인하여야 합니다.
_
제5조 (대리 및 보증의 부인)
 
① 회사는 회원과 제휴사 및 청구기관 간의 편리한 상품 등의 거래 및 각종 정보교환을 위한 시스템을 운영 및 관리, 제공할 뿐이며, 회원과 제휴사 및 청구기관을 대리하지 않습니다. 또한, 회원과 제휴사 및 청구기관 사이에 성립된 상품 등 거래 및 각종 정보교환과 관련한 책임, 제휴사 및 청구기관과 회원이 상호 제공한 정보에 대한 책임은 해당 제휴사 및 청구기관과 회원이 직접 부담하여야 합니다.
② 회사는 카카오페이 서비스를 통하여 이루어지는 제휴사 및 청구기관과 회원 간의 상품 등의 거래 및 각종 정보교환 관련하여 판매의사 또는 구매의사 존부 및 진정성, 상품 등의 품질, 완전성, 안전성, 적법성 및 타인의 권리에 대한 비침해성, 회원・제휴사・청구기관이 입력한 정보 및 그 정보를 통하여 링크된 URL에 게재된 자료의 진실성 또는 적법성 등 일체에 대하여 보증하지 아니하며, 이와 관련한 일체의 위험은 해당 제휴사・회원・청구기관이 전적으로 부담합니다.
③ 회사는 카카오페이 서비스와 관련하여 회원에게 상품 등을 판매하거나 제휴자로부터 상품 등을 구매하지 않으며, 단지 제휴사와 회원간의 상품 등 거래의 편의성을 증진시키는 결제도구만을 개발 및 제공합니다.
_
제6조 (카카오페이 서비스의 종류)
 
회사가 회원에게 제공하는 카카오페이 서비스의 종류는 다음과 같습니다.
1. 결제서비스 : 제휴사가 판매하는 상품 등을 회원이 구입 및 이용할 수 있도록 그 대가를 결제할 수 있도록 회사가 제공하는 결제서비스를 총칭합니다.
2. 송금서비스 : 회원이 카카오머니를 이용하여 송금 받는 사람에게 일정 범위의 금원을 송금할 수 있는 서비스를 말합니다.
3. 멤버십서비스 : 카카오페이 서비스를 통해 기 가입된 제휴사 멤버십을 연결하거나 신규가입, 제휴사 멤버십 상태 및 혜택 확인, 혜택 이용 등을 할 수 있는 서비스를 말합니다.
4. 카카오포인트서비스 : 회사가 지정한 제휴사에서 상품 등을 구매하거나 이벤트 등에 참여 후 정해진 조건에 따라 카카오포인트를 지급 받고, 해당 카카오포인트를 회사가 지정한 제휴사에서 상품 등 결제시 사용할 수 있는 서비스를 말합니다.
5. 쿠폰서비스 : 제휴사가 제공한 쿠폰을 회원에게 지급하고, 회원은 지급 받은 쿠폰을 상품 등을 구매 시 사용할 수 있는 서비스를 말합니다.
6. 청구서서비스 : 회원이 주식회사 카카오가 운영하는 스마트기기 메신저 어플리케이션인 카카오톡을 통해 청구정보를 수신 및 열람하거나 청구서 및 고지서에 따른 요금 및 공과금 등을 납부할 수 있는 서비스를 말합니다.
_
제7조 (카카오페이 서비스 이용계약 체결)
 
① 회사는 카카오 계정을 가진 자가 본 약관에 동의하고 이용하고자 하는 카카오페이 서비스의 종류에 따른 가입 절차에 따른 기재항목을 사실대로 정확하게 기재한 자에게만 카카오페이 서비스의 이용을 승낙하는 것을 원칙으로 합니다.
② 회원은 결제서비스, 송금서비스 또는 청구서서비스와 관련하여 회사가 요구하는 사항(본인인증정보 – 이름, 개인식별정보, 휴대폰번호, 생년월일, 성별 등)을 회사에 제공함으로써 이용할 수 있습니다.
③ 회원은 결제서비스 및 송금서비스의 이용과 관련하여 신용카드 결제정보(신용카드번호, 유효기간, 카드비밀번호 등), 휴대폰 결제정보(통신사, 휴대폰번호 등), 계좌 결제정보(계좌번호, 예금주명 등) 등을 신용카드사, 통신사, 은행에 제공하여 인증 및 승낙을 받음으로써 이용할 수 있습니다.
④ 회원은 카카오페이 서비스 이용 신청 시 회사가 요청하는 정보를 정확하게 작성하여야 합니다.
⑤ 회사는 다음 각 호의 어느 하나에 해당하는 사유가 발생하는 경우 이용신청에 대한 승낙을 거부할 수 있습니다.
1. 제1항을 위반하여 이용신청을 하는 경우
2. 만 15세 미만의 자가 이용신청을 하는 경우
3. 기재 내용에 허위, 기재누락, 오기 등이 있는 경우
4. 회사로부터 이용정지 당한 회원이 그 이용정지 기간 중에 이용계약을 임의 해지하고 재이용신청을 하는 경우
5. 과거에 본 약관의 위반 등의 사유로 카카오페이 서비스 이용계약이 해지 당한 경력이 있는 경우
6. 기타 본 약관에 위배되거나 위법 또는 부당한 이용신청임이 확인된 경우
⑥ 회사는 카카오페이 서비스 관련 설비의 여유가 없거나, 기술상 또는 업무상 문제가 있는 경우에는 승낙을 유보할 수 있습니다.
⑦ 본 조 제5항과 제6항에 따라 회원 가입 신청의 승낙을 하지 아니하거나 유보한 경우 회사는 원칙적으로 이를 이용신청자에게 알립니다.
⑧ 이용계약의 성립 시기는 회사가 이용신청 완료를 신청절차 상에서 표시한 시점으로 합니다.
_
제8조 (회원 정보의 제공 및 변경)
 
① 회사는 회원의 카카오페이 서비스 이용계약 체결 이후 필요한 경우 회원의 동의하게 회원의 정보를 추가적으로 수집할 수 있습니다.
② 회원은 카카오페이 서비스 이용계약 체결 및 이용을 위해 제공한 회원정보를 회원 본인이 온라인으로 열람하고 수정할 수 있습니다.
③ 회원은 회사에 제공한 회원정보에 변경이 있을 경우 온라인으로 수정하거나 전자우편 등의 수단으로 회사에 변경사항을 알려야 합니다.
④ 제3항의 변경사항을 회사에 알리지 않아 발생한 불이익은 회원이 부담합니다.
_
제9조 (결제서비스의 종류)
 
회사가 회원에게 제공하는 결제서비스는 다음과 같습니다.
1. 카드 간편결제 : 회원이 카드의 결제정보를 등록하고 판매자로부터 상품 등을 구매시 해당 카드로 카카오페이 비밀번호 입력 후 간편하게 결제할 수 있는 서비스
2.카드 자동결제 : 회원이 카드의 결제정보를 1회 등록하여 카드사로부터 인증 및 승낙을 받은 이후 판매자로부터 상품 등을 구매시 카카오페이 비밀번호 등의 입력 없이 자동으로 결제할 수 있는 서비스(단, 카드사의 요청 등 필요한 경우 추가 인증을 받을 수 있습니다.)
3. 휴대폰 간편결제 : 회원이 결제에 사용하고자 하는 휴대폰의 결제정보를 1회 등록하여 통신사로부터 인증 및 승낙을 받으면 이후 판매자로부터 상품 등을 구매시 결제정보를 다시 입력할 필요 없이 카카오페이 비밀번호의 입력만으로 간편하게 결제할 수 있는 서비스
4. 카카오머니 간편결제 : 회원이 카카오머니 계좌를 연결하고 판매자로부터 상품 등을 구매시 충전된 카카오머니 잔액으로 카카오페이 비밀번호 입력 후 간편하게 결제할 수 있는 서비스
5. 카카오머니 자동결제 : 회사가 정한 방식에 따라 카카오머니를 이용한 자동결제를 1회 신청하고, 이후 판매자로부터 상품 등을 구매시 카카오페이 비밀번호 등의 입력 없이 자동으로 결제할 수 있는 서비스(단, 회사 또는 카카오머니 계좌 연결 은행 등의 필요에 따라 추가 인증을 받을 수 있습니다.)
6. 카카오포인트 결제 : 회원이 정당하게 적립 받은 카카오포인트를 회사가 지정한 사용처에서 상품 등 구매 시 카카오페이 비밀번호 입력 등 회사가 정한 절차를 거친 후 결제할 수 있는 서비스
7. 법인카드 결제 : 법인회원이 법인명의의 카드를 등록하고, 법인이 사전에 지정한 임직원의 상품 등 구매시 결제되도록 할 수 있는 서비스. (이때, 카드사 및 제휴사의 필요에 따라 사용자 등록 및 결제시점에서 추가 인증을 받을 수 있습니다.)
_
제10조 (카카오머니 계정, 한도, 충전, 환불, 수수료, 소멸시효, 결제 및 거래 취소)
 
① 카카오머니 계정은 회사가 정하는 카카오머니 발급 대상 은행계좌와 연결하여 발급됩니다.
② 회사는 카카오머니의 보유, 충전, 결제, 송금, 받기 등의 한도를 정할 수 있으며, 이에 대한 자세한 내용은 고객센터 도움말 페이지에 게시합니다. 단, 회사는 카카오머니를 이용한 거래가 부정사용 또는 비정상적인 거래로 판단되거나 의심되는 경우 카카오머니의 보유, 충전, 결제, 송금, 받기 등의 한도를 감액하거나 제한할 수 있습니다.
③ 회원은 카카오머니 계정에 연결된 은행계좌 출금, 다른 회원이 송금한 카카오머니의 받기, 이벤트 및 프로모션 등에서의 무상 지급, 판매자 환불금 적립 등의 방법으로 카카오머니를 충전할 수 있습니다.
④ 회사는 다음 각호의 어느 하나에 해당되는 경우 회원의 카카오머니 충전을 제한할 수 있습니다.
1. 카카오페이 비밀번호 및 계좌비밀번호 등의 오류 및 입력 횟수 초과한 경우
2. 카카오머니 발행권면 최고한도 초과한 경우
3. 카카오머니가 사고 신고된 경우
4. 카카오머니 계정에 연결된 은행계좌의 잔액이 부족한 경우
5. 기타 기술적, 제도적 사유가 발생한 경우
⑤ 회원은 카카오머니 자동충전을 이용할 수 있으며, 자동충전을 이용하기 위해서는 사전에 자동충전 조건을 설정하여야 합니다.
⑥ 회사는 회원이 정당한 카카오머니를 제시하고 환불을 요청하는 경우 환불 요청 금액을 카카오머니 계정에 연결된 은행계좌로 입금하여 드립니다.
⑦ 회사는 카카오머니 계정에 연결된 은행계좌의 문제 등으로 전항에 따른 환불 처리가 어려운 경우 회원으로부터 별도의 은행계좌 정보를 제공 받아서 1회성으로 환불 처리를 합니다.
⑧ 회사는 회원이 카카오머니를 환불 또는 반환을 요청할 때 고객이 지정한 은행계좌에 온라인 송금 또는 기타의 방법으로 별도 비용 없이 지급합니다.
⑨ 회사는 회원의 송금서비스 이용에 대해서 송금수수료를 받을 수 있습니다.
⑩ 제9항에 따른 수수료는 회사가 정하는 바에 따르며, 수수료에 관한 사항은 고객센터 도움말 페이지에 게시합니다. 다만, 회사가 사업적으로 필요하다고 판단되는 경우 해당 수수료를 감면할 수 있습니다.
⑪ 카카오머니의 유효기간은 마지막 충전일 또는 사용일로부터 10년입니다. 회사는 유효기간이 도래하기 7일전 통지를 포함하여 3회 이상 ‘유효기간의 도래’, ‘유효기간 경과시 연결계좌로 잔액이 자동 입금된다는 점’, ‘연결계좌가 없거나 유효하지 않은 경우 잔액반환을 신청할 수 있는 방법’ 등을 카카오톡으로 통지합니다. ⑫ 제11항에도 불구하고, 마케팅 및 프로모션 등으로 무상 지급되는 카카오머니에 대해서는 별도의 이용목적 및 유효기간을 둘 수 있습니다. 이 경우 회사는 적립시점에 제약사항을  명시하고 회원이 서비스 이용화면에서 이를 확인할 수 있도록 해야 합니다.
⑬ 회원은 카카오머니를 결제 수단으로 제공하는 제휴사 어디에서나 카카오머니를 이용하여 상품 등을 구매할 수 있습니다.
⑭ 전항의 카카오머니 이용 후 구매대금이 회원의 카카오머니에서 차감되어 거래가 종료된 이후에 회원이 반품, 취소 등의 이유로 제휴사와 합의하여 해당 거래를 취소하고자 할 경우에는 회사가 정한 바에 따라 제휴사의 카카오머니 처리단말기(온라인 판매자의 경우 온라인결제 프로그램)을 통하여 취소할 수 있으며, 이 경우 취소 금액은 카카오머니 잔액으로 충전됩니다.
_
제11조 (멤버십서비스)
 
① 회원은 제휴사가 요구하는 멤버십 이용정보를 제공하고, 제휴사의 멤버십 이용약관 동의 등의 절차를 완료한 후 멤버십서비스를 이용할 수 있습니다.
② 회원은 멤버십서비스를 통해 제휴사에서 발급하는 멤버십 카드・포인트 관리, 멤버십 혜택 및 소식 받기 등을 이용할 수 있습니다.
_
제12조 (카카오포인트서비스)
 
① 회원이 상품 등의 구매 또는 이벤트 참여 등 회사가 제시한 조건을 충족한 경우 회사는 정해진 정책에 따라 회원에게 카카오포인트를 적립할 수 있습니다.
② 회원은 회사가 정하는 절차와 조건에 따라 결제서비스를 통한 구매 상품 등의 결제시 카카오포인트를 사용할 수 있습니다.
③ 카카오포인트는 현금으로 전환하거나 환불이 불가합니다.
④ 다음 각 호에 해당하는 경우 해당 카카오포인트는 소멸됩니다.
1. 카카오포인트가 부여된 날로부터 1년이 경과하는 경우(단, 회사에서 카카오포인트를 지급하면서 1년보다 단기의 유효기간을 정하여 안내한 경우 안내한 기간의 경과와 함께 카카오포인트는 소멸됩니다)
2. 카카오페이 서비스 이용계약이 해지되는 경우
3. 카카오계정 생성시 체결한 카카오서비스 이용계약이 해지되는 경우
⑤ 회원은 카카오포인트를 본인의 거래에 대해서만 사용할 수 있으며, 어떠한 경우라도 타인에게 매매 또는 양도하거나, 실질적으로 매매 또는 양도와 동일하게 볼 수 있는 행위를 하여서는 아니 됩니다.
⑥ 회원이 부당 또는 부정하게 카카오포인트를 취득한 경우 회원은 카카오포인트를 사용할 수 없으며 회사는 이를 회수할 수 있습니다.
⑦ 상품 등의 구매를 통해 적립된 카카오포인트는 해당 구매가 취소될 경우 회사에 의해 환수될 수 있습니다.
⑧ 본 조 제3항과 제4항에도 불구하고, 회사가 정한 특정한 상황에서 지급된 카카오포인트는 현금 전환이 가능하고, 상사소멸시효의 적용을 받습니다.
⑨ 카카오포인트의 부여 및 사용에 관한 상세한 사항은 회사가 정한 정책을 따르며, 회사는 고객센터 도움말 페이지 등을 통하여 회원에게 안내합니다.
_
제13조 (쿠폰서비스)
 
① 회원은 본 약관의 동의 등 카카오페이 서비스 가입을 완료한 경우 카카오페이 서비스를 통해 제공되는 제휴사의 쿠폰을 제공 받을 수 있습니다.
② 회원은 제휴사에서 상품 등을 구매하는 경우 쿠폰에 기재된 조건에 따른 혜택을 받을 수 있습니다.
_
제14조 (청구서서비스 일반)
 
① 회사가 회원에게 제공하는 청구서서비스는 다음과 같습니다.
1. 전자고지
2. 청구서 및 고지서 납부
3. 청구기관의 마케팅 및 소식지 등 정보 전송
4. 기타 회사가 추가 개발하거나 제휴를 통해 회원에게 제공하는 서비스
② 회사는 청구서서비스 이용과 관련하여 회원을 다음 각 호와 같이 구분합니다.
1. “준회원”은 본 약관에 동의만 하고, 청구서서비스 이용을 위한 인증을 완료하지 않은 회원으로서 청구서서비스 일부 이용이 제한됩니다.
2. “정회원”은 본 약관에 동의하고, 청구서서비스 이용을 위한 인증까지 완료한 회원으로서 청구서서비스 전부를 이용할 수 있습니다.
③ 회원이 이용 가능한 청구서서비스는 제2항에 따른 회원의 구분, 회원의 단말기 이용환경, 회원과 청구기관의 계약, 회원의 별도 동의 여부, 관련법령 등에 따라 달라질 수 있습니다.
④ 제1항에 따른 개별 청구서서비스의 상세 내용 및 이용조건은 청구서서비스 내 안내 페이지에 기재한 내용을 따르며, 회사는 청구서서비스를 일정한 범위로 구분하여 각 범위 별로 이용 가능한 시간을 별도로 지정할 수 있습니다.
⑤ 회원은 카카오톡을 통하여 청구서서비스를 이용할 수 있습니다. 단, 가능한 단말기의 종류와 OS(Android, iOS) 등에 따라 청구서서비스의 구성과 기능에는 차이가 있을 수 있으며, 일부 기능은 이용이 불가 할 수 있습니다.
⑥ 청구서서비스를 이용하는 과정에서 Wi-Fi 무선인터넷을 사용하지 않고, 회원이 가입한 이동통신사의 무선인터넷에 연결하여 이용하는 경우 이동통신사로부터 별도의 데이터 통신요금이 부과될 수 있습니다.
_
제15조 (전자고지 이용신청 및 해지)
 
① 회원은 회사와 청구기관이 협의하여 정한 절차에 따라 청구기관별 전자고지를 신청 또는 해지할 수 있습니다.
② 회원은 청구기관으로부터 전자고지를 받기 위해서는 청구기관에게 회원의 의사 및 정보를 청구기관이 지정한 방법으로 전달하고, 청구서서비스를 통한 전자고지를 위해 필요한 회원 정보의 수집 및 제공 관련하여 관련법령에서 회사 및 청구기관에게 요구하는 필수 사항에 동의를 하여야 합니다.
③ 회사는 제1항과 제2항의 절차를 수행하기 위한 화면을 청구서서비스 내에서 제공할 수 있습니다.
④ 제1항과 제2항에도 불구하고, 회사는 회원의 청구기관별 전자고지의 신청 없이도 청구기관과의 계약에 따라 회원에게 전자고지를 할 수 있습니다. 단, 회원은 해당 청구기관의 전자고지 수신을 원하지 않는 경우 회사가 안내하는 방법에 따라 언제든지 수신거부 처리를 할 수 있습니다.
⑤ 회원의 전자고지 신청 및 해지는 청구기관이 최종 승인을 하며, 회사는 청구기관이 지정한 날로부터 회원에게 청구서서비스를 통한 전자고지를 시작 및 종료합니다.
⑥ 제16조 제8항 각 호의 상황 등으로 인해 회원이 청구기관의 전자고지를 수신하지 못하거나 회원과 청구기관의 계약이 종료되어 전자고지의 필요가 없어진 경우 회사는 청구기관의 요청에 따라 회원의 해당 청구기관 전자고지 수신을 해지할 수 있습니다.
_
제16조 (전자고지 내역 확인)
 
① 회사는 청구기관으로부터 전자고지 내역을 제공 받은 후 청구서서비스를 통해 청구기관이 지정한 일정에 따라 회원에게 전송합니다.
② 회사는 납기일 또는 청구기관이 별도로 지정한 일자까지 전자고지 내역을 청구서서비스에 게시하며 그 이후에는 삭제할 수 있습니다.
③ 청구서서비스에서 제공하는 전자고지에는 청구기관의 요청에 따라 청구기관의 부가정보 및 소식지 등이 제공되지 않을 수 있습니다.
④ 회원이 전자고지에 따른 청구서 및 고지서를 열람하면 회사는 열람 여부를 기록하고 청구기관에게 상담 등의 목적으로 열람여부 및 열람일시를 제공할 수 있습니다.
⑤ 회원은 수신된 전자고지의 내용과 관련한 문의가 있을 경우 해당 전자고지의 주체인 청구기관에게 직접 하여야 합니다.
⑥ 회사는 전자고지의 내용이나 청구기관의 사정으로 전자고지의 내용에 대한 문의가 응대되지 않아 발생할 수 있는 상황에 대해 책임을 부담하지 않습니다.
⑦ 회원이 전자고지를 수신하지 않거나 열람하지 않아 발생할 수 있는 불이익에 대해 회사는 책임을 부담하지 않습니다.
⑧ 회사는 회원에게 전자고지가 전송되었음을 알리는 별도의 알림을 카카오톡 메시지를 통해서 전송할 수 있으며, 회원은 본 약관에 동의하고, 전자고지를 신청하는 것으로써 전자고지 발송 안내에 대한 메시지 수신에 동의한 것으로 봅니다. 단, 회사는 다음 각 호의 상황에 있어서 전자고지 발송 안내에 대한 메시지의 수신을 보증하지 않으며, 해당 메시지를 수신하지 못하여 발생하는 손해에 대하여 회사는 책임을 부담하지 않습니다.
1. 회원이 카카오톡을 탈퇴했거나 어플리케이션을 삭제한 경우
2. 회원이 주식회사 카카오의 정책에 따라 카카오톡 사용이 정지된 경우
3. 회원의 네트워크 환경 문제 혹은 카카오톡 메시지 장기 미확인 등으로 인해 메시지를 확인할 수 없는 경우
4. 회원이 청구서서비스에 대한 카카오톡 플러스친구 또는 옐로아이디의 메시지 수신을 거부 처리한 경우
5. 카카오톡의 시스템 및 청구서서비스의 오류 및 장애로 인한 메시지 발송 불가 상황인 경우
6. 기타 회사가 불가피한 이유로 인해 메시지를 발송할 수 없다고 판단하는 경우
_
제17조 (전자고지 납부)
 
① 회원은 전자고지를 통해서 수신한 청구서 및 고지서의 금액을 청구서서비스에서 제공하는 전자적 결제수단을 사용하여 납부할 수 있습니다.
② 회사는 납부를 위한 청구서 및 고지서 금액에 대한 회원과 청구기관 사이의 계약에 일체 관여하지 않습니다.
③ 회원은 청구서서비스를 통해서는 납부 지시를 철회할 수 없으며, 지시한 납부를 철회하고자 할 때는 청구기관에 직접 요청하여야 합니다. 단, 일부 요금은 관계법령에 따라 청구기관을 통한 철회도 불가능할 수 있습니다.
④ 결제 수단에 따라 납부 지시 철회가 불가하여 환불이 이루어져야 하는 경우 환불은 청구기관이 정한 절차에 따릅니다.
⑤ 회사는 1회 납부 건수 및 금액 한도를 정할 수 있으며, 국세 등 관계법령에서 정한 경우 회원은 신용카드 등의 납부 수수료를 부담하여야 합니다.
⑥ 회원은 자신의 납부 내역을 청구서서비스에서 5년 동안 확인할 수 있습니다. 단, 관계법령에서 납부내역 확인기간을 별도로 정하는 경우에는 그에 따릅니다.
⑦ 회원은 회사가 정한 결제관련 절차를 마친 후 청구서서비스에서 자동납부를 신청할 수 있으며, 회사가 해당 신청을 승낙함으로써 자동납부 기능을 이용할 수 있습니다.
⑧ 자동납부가 가능한 경우는 회사와 청구기관의 사정에 따라 달라질 수 있습니다.
⑨ 자동납부를 이용하는 회원은 설정된 납부일에 정상적인 납부가 이루어질 수 있도록 자동납부 결제 수단을 관리하여야 합니다. 회원의 귀책으로 정상적인 납부가 이루어지지 않는 경우 그로 인해 발생하는 손해는 회원이 부담합니다.
⑩ 회원이 자동납부의 신청, 변경 및 해지를 요청하였더라도 청구기관의 정책이나 회사의 청구서서비스 운영정책에 따라서 요청 사항은 일정 기간 이후부터 적용될 수 있습니다.
_
제18조 (회사의 의무)
 
① 회사는 관련 법령과 본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적이고 안정적으로 카카오페이 서비스를 제공하기 위하여 최선을 다하여 노력합니다.
② 회사는 회원이 안전하게 카카오페이 서비스를 이용할 수 있도록 개인정보보호를 위한 보안시스템을 갖추며, 개인정보처리방침을 공지하고 이를 준수합니다.
③ 회사는 카카오페이 서비스 이용과 관련하여 회원으로부터 제기된 의견이나 불만이 정당하다고 인정할 경우에는 이를 처리하여야 합니다. 회원이 제기한 의견이나 불만사항에 대해서는 게시판을 활용하거나 전자우편 등을 통하여 회원에게 처리과정 및 결과를 전달합니다.
_
제19조 (회원의 의무)
 
① 회원은 상품 등을 구매하기 전에 반드시 상품 등의 상세 내용과 거래의 조건을 정확하게 확인한 후 구매를 하여야 합니다. 회원은 구매하려는 상품 등의 내용과 거래의 조건을 확인하지 않고 구매하여 발생한 모든 손실・손해에 대한 책임을 부담하여야 합니다.
② 회원은 본 약관 및 회사가 카카오페이 서비스 화면에서 고지하는 내용을 준수하여야 하며, 본 약관 및 고지내용을 위반하거나 이행하지 아니하여 발생하는 손실 및 손해에 대하여 책임을 부담합니다.
③ 회원은 상품 등 구매시 스스로의 책임하에 상품 등을 구매하여야 하며, 회사는 제휴사의 상품 등의 내용과 거래 조건에 대해서 어떠한 보증이나 책임도 부담하지 않습니다.
④ 회원은 자신의 명의가 도용되거나 제3자에게 부정하게 사용된 것을 인지한 경우 즉시 그 사실을 회사에게 통보하여야 합니다.
⑤ 회원은 상품 등의 구매 시 결제방법을 사용함에 있어 반드시 본인 명의의 결제수단을 사용하여야 하며, 타인의 결제수단의 임의사용 등을 하여서는 안됩니다. 타인의 결제수단을 임의 사용함으로써 발생하는 회사, 결제수단의 적법한 소유자, PG, 판매자의 손실과 손해에 대한 책임은 회원에게 있습니다. 단, 제9조 제7항의 법인카드 결제의 경우에는 결제수단의 사용자가 회원인 법인이 지정한 임직원이 됩니다.
⑥ 회원은 카드 자동결제에서 사용하는 신용카드 결제정보, 휴대폰 간편결제에서 사용하는 휴대폰 결제정보, 카카오머니 결제 및 카카오머니 자동결제에서 사용하는 계좌 결제정보 그리고 카카오페이 비밀번호 등에 대한 관리책임이 있으며, 이를 제3자에게 제공, 누설하거나 이와 유사한 행위를 하여서는 안됩니다.
⑦ 결제서비스 이용시 결제와 관련하여 회원이 입력한 정보 및 그 정보와 관련하여 발생한 책임과 불이익은 전적으로 회원이 부담하여야 합니다.
⑧ 회원은 카카오페이 서비스를 이용 중인 스마트폰 및 USIM 칩 등의 분실, 도난 및 카카오페이 비밀번호 등의 누설 등 사고 발생시에는 그 사실을 회사에 신고하여야 합니다.
⑨ 회원은 결제서비스 이용 시 정당하고, 적법한 사용권한을 가지고 있는 결제수단을 사용하여야 하며, 회사는 그 여부를 확인할 수 있습니다. 또한 회사는 회원 결제수단의 적법성 등에 대한 확인이 완료될 때까지 거래진행을 중지하거나 해당 거래를 취소할 수 있습니다.
⑩ 회원은 제휴사와 상품 등 구매 절차에서 분쟁이 발생한 경우 분쟁 해결을 위하여 성실히 임하여야 하며, 분쟁해결의 불성실로 인하여 제휴사와 회사에 발행한 모든 손실, 손해를 부담하여야 합니다.
⑪ 회원은 회사가 정하고 인정하는 방식에 따라 카카오포인트 또는 쿠폰 등을 사용하여야 합니다.
⑫ 회원은 카카오페이 서비스를 이용하여 얻은 정보를 회사의 사전 동의 없이 영리목적으로 이용하거나 제3자에게 이용하게 하는 행위를 할 수 없으며, 카카오페이 서비스의 이용권한 및 기타 이용 계약상 지위를 타인에게 양도, 증여할 수 없습니다.
⑬ 회원은 회사가 카카오페이 서비스를 안전하게 제공할 수 있도록 회사에 협조하여야 하며, 회사가 회원의 본 약관 위반행위를 발견하여 회원에게 해당 위반행위에 대하여 소명을 요청할 경우 회원은 회사의 요청에 적극 응하여야 합니다.
_
제20조 (회원의 금지행위)
 
① 회사는 카카오페이 서비스의 신뢰성을 제공하고 안전한 카카오페이 서비스 이용이 이루어 질 수 있도록 아래와 같은 행위를 금지합니다.
1. 회사가 제공하는 카카오페이 서비스 이용방법에 의하지 아니하고 비정상적인 방법으로 카카오페이 서비스를 이용하거나 시스템에 접근하는 행위
2. 타인의 명의, 신용카드정보, 휴대폰 정보, 계좌 정보 등을 도용하여 회사가 제공하는 카카오페이 서비스를 이용하는 행위
3. 여신전분금융업법 등 법령에 의하여 금지된 방법으로 비정상적인 결제를 하는 행위
4. 회사가 게시한 정보의 무단 변경 또는 회사가 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시하는 행위
5. 회사 및 기타 제3자의 저작권 등 지적재산권에 대한 침해행위
6. 회사 및 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
7. 회사가 제공하는 카카오페이 서비스를 이용하여 얻은 회사의 정보를 회사의 사전 동의 없이 복제 또는 유통시키거나 상업적으로 이용하는 행위
8. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 서비스에 공개 또는 게시하는 행위
9. 구매의사 없이 반복적인 결제를 발생시키는 행위
10. 기타 불법적이거나 부당한 행위
② 회사는 회원이 본 조의 금지행위를 행하는 경우 제21조에 따라 카카오페이 서비스 이용을 제한할 수 있으며, 회사는 필요한 경우 회원의 금지행위 사실을 관련 정부기관 또는 사법기관에 통지할 수 있습니다.
_
제21조 (카카오페이 서비스의 이용제한 등)
 
① 회사는 카카오페이 서비스의 안정성과 신뢰성을 위하여 아래 각 호의 어느 하나에 해당하는 사유가 발생하는 경우 회원의 카카오페이 서비스 이용을 정지하거나 이용계약을 해지할 수 있습니다. 카카오페이 서비스의 이용이 정지된 회원은 해당 기간 동안 카카오페이 서비스를 이용할 수 없습니다. 이용제한의 구체적인 기준 등에 대해서는 운영정책에서 정합니다.
1. 본 약관 제19조 회원의 의무를 위반한 경우
2. 본 약관 제20조의 금지행위에 해당하는 경우
3. 카카오계정이 정지되거나 상실하는 경우
4. 본 약관에서 규정한 사항이나 별도 페이지에 규정한 이용규칙을 위반한 경우
5. 기타 회사가 FAQ, 도움말 등의 운영정책에서 정한 경우
② 회사는 제1항의 경우 회원이 해당 사유를 소명하거나 거래 상대방의 양해가 있었음을 소명하는 등 회사가 정하는 기준을 충족하는 경우 이용정지 조치를 해소할 수 있습니다.
_
제22조 (이용계약의 해제, 해지 등)
 
① 회원은 언제든지 이용계약 해지 신청을 할 수 있으며, 회사는 관련 법령 등이 정하는 바에 따라 이를 즉시 처리하여야 합니다. 단, 카드 자동결제와 카카오머니 자동결제의 경우 회원은 먼저 카드 자동결제와 카카오머니 자동결제가 연결되어 있는 판매자 서비스에서 자동 결제 등록을 해지하여야 합니다.
② 회원이 이용계약을 해지할 경우 회사는 관련 법령 및 개인정보처리방침에 따라 회원 정보를 보유하는 경우를 제외하고는 해지 즉시 회원의 모든 데이터를 삭제합니다.
③ 이용계약 해지로 인해 발생한 불이익에 대한 책임은 회원 본인이 부담하여야 하며, 이용계약이 종료되면 회사는 회원에게 부가적으로 제공한 각종 무상혜택을 회수할 수 있습니다.
④ 회사는 회원에게 다음 각 호의 어느 하나에 해당하는 사유가 발생하거나 확인된 경우 이용계약을 해지할 수 있습니다.
1. 회원이 카카오페이 서비스의 원활한 진행을 방해하는 행위를 하거나 시도한 경우
2. 회원이 고의로 회사의 영업을 방해한 경우
3. 다른 회원의 권리나 명예, 신용 기타 정당한 이익을 침해하거나 대한민국 법령 또는 선량한 풍속 기타 사회질서에 위배되는 행위를 한 경우
4. 회원이 본 약관에 위배되는 행위를 하거나 본 약관에서 정한 해지사유가 발생한 경우
5. 회원에게 제7조에서 정한 이용계약의 승낙거부사유가 있음이 확인된 경우
6. 카카오페이 서비스와 연결된 회원의 회사 계정 또는 주식회사 카카오의 계정이 휴면 또는 정지 처리된 경우
7. 기타 회사가 합리적인 판단에 기하여 카카오페이 서비스 제공을 거부할 필요가 있다고 인정할 경우
⑤ 회사가 이용계약을 해지하는 경우 회사는 회원에게 전자우편 등으로 해지 사유를 밝혀 해지의사를 통지합니다. 이 경우 회사는 해지를 하기 전에 상당한 기간을 정하여 회원의 이의 신청의 기회를 부여합니다. 다만, 본 약관 및 운영정책에서 정하는 사유가 있을 경우에는 별도의 이의 신청 기간을 부여하지 않을 수 있습니다.
⑥ 회사가 이용계약을 해지하더라도 이용계약의 해지 이전에 이미 체결된 회원과 제휴사간의 상품 등 거래계약의 완결에 관해서는 본 약관이 계속 적용됩니다.
⑦ 이용계약이 회사에 의해 해지되는 경우 회원의 재이용 신청에 대하여 회사는 그 승낙을 거절할 수 있습니다.
⑧ 이용계약의 종료와 관련하여 발생한 손해는 이용계약이 종료된 해당 회원이 책임을 부담하여야 하고, 회사는 관련 법령에 규정이 없는 한 책임을 지지 않습니다.
_
제23조 (개인정보)
 
① 회사는 회원이 안전하게 카카오페이 서비스를 이용할 수 있도록 회원의 개인정보보호를 위하여 개인정보보호정책을 실시하며, 이에 따라 회원의 개인정보를 보호하여야 할 의무가 있습니다. 회사의 개인정보보호정책은 회사의 홈페이지 또는 카카오페이 서비스에 링크된 화면을 통하여 확인할 수 있습니다.
② 회사는 카카오페이 서비스를 통하여 주문 및 결제가 이루어진 경우 거래 당사자간 원활한 의사소통 및 상담 등의 거래 이행을 위하여 관련된 정보를 필요한 범위 내에서 거래 당사자에게 제공할 수 있습니다.
_
제24조 (카카오페이 서비스의 중단)
 
① 회사는 통신, 전력 등의 공급이 중단되는 불가피한 경우는 물론 정보통신설비의 보수점검, 증설, 교체, 이전 등의 유지 관리 업무를 수행하기 위해 필요한 경우 카카오페이 서비스의 제공을 일시적으로 중단할 수 있으며, 이 경우 7일 이전에 카카오페이 서비스 중단을 공지합니다. 다만, 불가피하게 사전 공지를 할 수 없는 경우 회사는 사후 공지할 수 있습니다.
② 회사는 카카오페이 서비스 제공을 위해 계약을 체결하고 있는 제휴사, 청구기관, 금융기관의 시스템 운영 상황이나 계약 체결 상황에 따라서 카카오페이 서비스 운영상 상당한 이유가 있는 경우에는 카카오페이 서비스의 전체 또는 일부의 제공을 일시적으로 중단할 수 있습니다.
③ 회사는 천재지변, 전쟁, 폭동, 테러, 해킹, DDOS 등 불가항력적 사유로 카카오페이 서비스가 중단된 경우 즉시 이러한 사실을 공지하된, 만일 정보통신설비의 작동불능 등의 불가피한 사유로 인해 사전공지가 불가능한 경우에는 이러한 사정이 해소된 이후 즉시 이러한 사실을 공지합니다.
④ 회사는 파산 신청, 기업회생절차 개시 신청 등 정상적인 영업활동이 곤란하여 카카오페이 서비스를 지속할 수 없는 때에는 회원에게 이를 통지한 날로부터 30일이 경과한 때부터 카카오페이 서비스를 중단할 수 있습니다.
⑤ 회사는 본 조 제1항 내지 제2항의 사유가 발생한 경우 최대한 빠른 시간 내에 카카오페이 서비스를 재개하도록 최선의 노력을 다합니다.
_
제25조 (회사의 면책)
 
① 제휴사와 회원 사이에 이루어지는 상품 등의 매매와 관련하여 발생하는 상품 등의 배송, 청약철회 또는 교환, 반품 및 환불 등의 거래진행은 거래의 당사자인 제휴사와 회원 각각의 책임 하에 이루어집니다. 회사는 제휴사와 회원 사이의 상품 등 거래에 관여하지 않으며, 이에 대하여 어떠한 책임도 부담하지 않습니다.
② 회사는 회원 상호간 또는 회원과 청구기관을 포함한 제3자 상호간에 청구서서비스를 매개로 하여 발생한 분쟁에 대해서는 개입할 의무가 없으며, 이로 인한 회원의 손해를 배상할 책임을 부담하지 않습니다.
③ 회사는 회원이 카카오페이 서비스를 이용하여 기대하는 수익을 달성하지 못했거나 상실한 것에 대해서 책임을 지지 않으며, 그 밖에 카카오페이 서비스를 통하여 얻은 정보로 인하여 발생한 손해에 대하여도 책임을 부담하지 않습니다.
④ 제24조의 사유로 인하여 카카오페이 서비스를 중단하는 경우 회사는 카카오페이 서비스의 중단에 대하여 어떠한 책임도 부담하지 않습니다.
⑤ 회사는 회원의 귀책사유로 인한 카카오페이 서비스 이용의 장애에 대하여 책임을 지지 않습니다.
⑥ 회원이 자신의 개인정보, 카카오페이 서비스 등록 정보 등을 타인에게 제공하거나, 회원의 관리소홀로 유출됨으로써 발생하는 피해에 대해서 회사는 책임을 지지 않습니다.
_
제26조 (준거법 및 재판관할)
 
① 본 약관과 관련된 사항에 대하여는 대한민국 법률을 준거법으로 합니다.
② 회사와 회원간 발생한 분쟁에 관한 소송은 민사소송법 상의 관할법원에 제소합니다.
</textarea>
	</div>

	<div id="joinPermission_check2">
		<input type="checkbox" id="check2">개인정보 수집 및 이용약관 동의
	</div>
		
	<div id="joinPermission_content2">
		<textarea rows="5" cols="58" readonly="readonly">회사는 회원가입, e알리미 서비스 및 각종 서비스의 제공을 위해 최초 회원가입 당시아래와 같은 최소한의 개인정보를 필수항목으로 수집하고 있습니다. 
- 필수항목 : 이름, 휴대폰번호(혹은 e메일계정), 비밀번호, 자필서명

- 선택항목 : e메일계정

 
2.  개인정보의 수집 및 이용목적

회사는 다음과 같은 목적으로 회원의 개인정보를 수집합니다.

 o 가. 회원관리 
     회원제 서비스 이용 및 개인식별, 불량회원의 부정 이용방지와 비인가 사용방지, 가입의사 확인, 가입 및 가입횟수 제한, 고지사항 전달, 고객고충 및 민원처리

 o 나. 서비스 제공    
      스마트공지 등 e알리미 서비스의 전달, 공지용 문자메시지/e메일의 발송


3.   개인정보의 보유 및 이용기간

     이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체없이 파기합니다. 
      - 보존 이유 : 서비스의 제공 
      - 보존 기간 : 회원탈퇴 시까지
    

4.   개인정보 수집 동의 거부의 권리와 그 행사방법

      - 이용자는 해당 개인정보의 수집 및 이용을 거부할 권리가 있습니다. 단 개인정보의 수집 및 이용을 거부할 경우 본 서비스의 이용에 제한이 있을 수 있습니다.
      - 가입해지(동의철회)를 위해서는 "회원탈퇴"를 클릭하여 직접 열람,정정 또는 탈퇴가 가능합니다.

      - 이용자의 개인정보 조회, 수정을 위해서는 '개인정보변경'(또는 '회원정보수정' 등)을, 
      - 혹은 개인정보 관리책임자에게 이메일 등의 방법으로 연락하시면 지체 없이 조치하겠습니다.</textarea>
	</div>
	
	<div id="joinPermission_button_area">
		<div id="joinPermission_button_agree">
			<a rel="modal:open"></a><input type="button" value="agree" onclick="permissionCheck()">
		</div>
		
		<div id="joinPermission_button_cancle">
			<input type="button" value="cancel" onclick="permissionCancle()">
		</div>
		<input type="hidden" id="revValue2" no='${no}' p=${p} d='${d}' c='${c}' pp='${pp}' tt='${tt}' budjet=${budjet}>
	</div>
</div>

</body>
</html>