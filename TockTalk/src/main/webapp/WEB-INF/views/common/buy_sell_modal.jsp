<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<div class="modal fade" id="sellModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-backdrop="static" style="z-index: -1;">
	<div class="modal-dialog">
		<div class="modal-content" style="background-color:#ffffff"> 
			<div class="modal-header">
				<h5 class="modal-title grayFontBold" id="exampleModalLabel">매도주문</h5>
				<button type="button" class="close" data-dismiss="modal" id="cancel2_sell"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="input-group">
					<input class="form-control" type="text" id="keyword_sell"
						placeholder="종목명을 입력해주세요">
					<div class="input-group-append">
						<button type="button" class="btn btnBackgroundTrade" id="symbolSearch_sell">종목조회</button>
					</div>
				</div>
				<div class="input-group mt-1">
					<input class="form-control" type="text" name="tradeQty_sell" id="tradeQty_sell"
						placeholder="거래 수량을 입력해주세요">
					<div class="input-group-append">
						<button type="button" class="btn btnBackgroundTrade" id="amountSearch_sell" disabled="disabled">대금조회</button>
					</div>
				</div>
				<table class="table table-borderless mt-3" style="table-layout:fixed;">
					<tbody>
						<tr>
							<td>종목명</td>
							<td id="symbol_sell" class="grayFontBold"></td>
							<td>보유량</td>
							<td id="h_qty_sell" class="grayFontBold"></td>
						</tr>
						<tr>
							<td>매입가</td>
							<td id="avg_h_price_sell" class="grayFontBold"></td>
							<td>평가금액</td>
							<td id="total_sell" class="grayFontBold"></td>
						</tr>
						<tr>
							<td>현재가</td>
							<td id="cur_price_sell" class="grayFontBold"></td>
							<td>매도총액</td>
							<td id="sellingAmount" class="grayFontBold"></td>
						</tr>
						<tr>
							<td>예수금</td>
							<td id="deposit_sell" class="grayFontBold"></td>
							<td>거래후 잔액</td>
							<td id="balance_sell" class="grayFontBold"></td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" id="deposit_store_sell">
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btnBackgroundTrade" id="sell">매도하기</button>
				<button type="button" class="btn btnBackgroundTrade" id="cancel_sell" data-dismiss="modal">거래취소</button>
			</div>
		</div>
	</div>
</div>


</body>
</html>