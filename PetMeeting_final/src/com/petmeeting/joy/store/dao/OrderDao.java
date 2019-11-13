package com.petmeeting.joy.store.dao;

import java.util.List;

import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.store.model.OrderBean;
import com.petmeeting.joy.store.model.OrderDto;
import com.petmeeting.joy.store.model.OrderInfoDto;
import com.petmeeting.joy.store.model.OrderParam;
import com.petmeeting.joy.store.model.ProductOptionDto;
import com.petmeeting.joy.store.model.RefundDto;
import com.petmeeting.joy.store.model.SalesDto;


public interface OrderDao {
	

	/**
	 * 상품코드, 옵션을 통해 상품 옵션 시퀀스를 찾아오기 위한 메소드
	 */
	public int getProductOptionSeq(OrderBean oBean);

	/**
	 * 주문을 완료했을 때 DB에 주문에 대한 정보를 넣기위한 메소드
	 */
	public void addOrder(OrderDto oDto);
	
	/**
	 * 상품코드, 옵션을 통해 상품의 총 수량 가져오기 위한 메소드
	 */
	public int getProductOptionQuantity(ProductOptionDto poDto);

	/**
	 * 주문했을 때 총 수량을 변경해주는 메소드 
	 */
	public boolean minusPQuantity(ProductOptionDto poDto);
	
	/**
	 * 배송지 정보, 배송 상태에 대한 정보를 넣어주는 메소드
	 */
	public void addOrderDetail(OrderInfoDto oiDto);
	
	
	/**
	 * 주문번호를 통해 주문상품, 배송 정보를 리스트에 담아주는 메소드
	 */
	public List<OrderInfoDto> getOrderDetailList(OrderInfoDto oiDto);
	
	/**
	 * 현재 로그인된 이메일주소로 주문상태가 배송준비중인 상품의 갯수를 찾는 메소드
	 */
	public int getMyorderReadyCount(String email);
	
	/**
	 * 현재 로그인된 이메일주소로 주문상태가 배송중인 상품의 갯수를 찾는 메소드
	 */
	public int getMyorderDeliveryCount(String email);
	
	
	/**
	 * 현재 로그인된 이메일주소로 주문상태가 배송완료인 상품의 갯수를 찾는 메소드
	 */
	public int getMyorderCompleteCount(String email);
	
	/**
	 * 현재 로그인된 유저의 주문내역 최근 5개 뽑아오기
	 */
	public List<OrderInfoDto> getMyorderListLatest(String email);
	
	public int getTotalPrice(OrderDto oDto);
	
	/**
	 * 주문한 상품들에 대한 적립금을 가져오기 위한 메소드
	 */
	public int getOrderPoint(OrderInfoDto oiDto);
	
	/**
	 * 주문 후 내 적립금을 더해주거나 빼주기 위한 메소드
	 */
	public boolean savePoint(MemberDto mDto);
	
	
	/**
	 * 주문 기간으로 주문내역을 조회하는 메소드
	 */
	public List<OrderInfoDto> orderRefernce(OrderParam param);

	/**
	 * 주문 내역 카운트
	 */
	public int getOrderCount(OrderParam param);
	
	public boolean orderCancel(OrderInfoDto oiDto);
	public boolean cancelPoint(MemberDto mem);
	public int getUse_Point(OrderInfoDto oiDto);
	
	
	/**
	 * 반품/교환할 주문리스트를 가져오기 위한 메소드
	 */
	public List<OrderInfoDto> getRefundList(OrderInfoDto oiDto);
	public List<OrderInfoDto> getOrderRefundList(OrderInfoDto oiDto);
	
	
	/**
	 * 반품신청 데이터를 집어넣는 메소드
	 */
	public void addRefund(RefundDto rDto);

	public boolean updateStatus(OrderDto oDto);
	
	public List<OrderInfoDto> getRefundBreakdown(OrderParam param);
	public int getRefundCount(OrderParam param);
	
	
	public boolean updateRefundSeq(OrderDto oDto);
	
	/**
	 * 리뷰 페이지 : 리뷰작성 가능한 나의 주문 상품 불러오기!
	 */
	public List<OrderInfoDto> getMyorderListReview(String email);
	
	
	/* 관리자 */
	
	
	/**
	 * 관리자페이지에서 주문리스트를 뿌려주는 메소드
	 */
	public List<OrderInfoDto> getAdminOrderList(OrderParam param);
	
	/**
	 * 주문리스트 정렬, 검색을 위해 리스트의 카운트를 가져오는 메소드
	 */
	public int getAdminOrderListCount(OrderParam param);
	
	public List<RefundDto> getAdminOrderDetailList(int rseq);
	
	/**
	 * 주문리스트에서 관리자가 배송상태를 바꿔주는 메소드
	 */
	public boolean updateOrderStatus(String ordernumber);
	
	/**
	 * 관리자페이지에서 반품/교환리스트를 뿌려주는 메소드
	 */
	public List<RefundDto> getAdminRefundList(OrderParam param);
	public int getAdminRefundCount(OrderParam param);
	
	public List<OrderInfoDto> getRefundProductList(int seq);
	
	/**
	 * 월별 매출통계
	 */
	public List<SalesDto> getMonthlySales(SalesDto param);
	
	/**
	 * 오늘의 매출
	 */
	public int getTodaySales();
	
	/**
	 * 매출 상위 5개 제품 이름과 매출액 가져오기
	 */
	public List<SalesDto> getProductSales();
	
	/**
	 * 환불 완료 업데이트
	 */
	public void updateRefundComplete(int refund_seq);
	
	/**
	 * 교환 완료 업데이트
	 */
	public void updateChangeComplete(int refund_seq);
	
	/**
	 * 주문번호로 주문정보 불러오기
	 */
	public OrderInfoDto getOrderDetail(String ordernumber);
	
	
	/**
	 * 오늘의 주문 수
	 */
	public int getTodayOrder();

	/**
	 * 배송대기 상품 수
	 */
	public int getDeliveryWait();
	
	/**
	 * 배송중인 상품 수
	 */
	public int getDeliveryIng();
	
	/**
	 * 취소된 주문 수
	 */
	public int getCancel();
	
	
	/**
	 * 반품/교환 신청 수
	 */
	public int getREreqCount(int status);
	
	public void updateDeliveryComplete(String ordernumber);
}
